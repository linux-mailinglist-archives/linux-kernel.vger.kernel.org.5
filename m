Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B70781497
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 23:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240343AbjHRVOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 17:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240339AbjHRVOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 17:14:31 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF444216
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 14:14:30 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1bbb4bde76dso729277fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 14:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692393270; x=1692998070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QiLNEqO3RQVovKsfrOU7Xg2I81wb5TNuTl74DFna1Vo=;
        b=L8Uk9ewKbx9s0nuoV2ErfRIVUr73PHNpOwLkRteCyGzsmiS2c9nDkomKK4rOPOZh2C
         krKXme801oWY2ta2hg9DO+6eE2YNddiZRpkser8c3qGBbFiNmJn3vVhH/aBvd/bnBhHR
         SbV6GdTQSO07NT5VLG/enSBpYgL11oT8oVkU3ZIjvJQwZhc7yAdlTT3zxFXrVDHVfGIp
         Tmk89X+lVd5F4Q89I/+h21tk2XqLfhnGEg6lAcZt72C1BQUonUb/WGfu6HchLRuOZ12z
         E1WVWcjzyYbakaKUg7CdQTkzwllhSqxK4w9Jtl88vByFsu7MW76DhdPaWaqlKwM2qG70
         qwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692393270; x=1692998070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QiLNEqO3RQVovKsfrOU7Xg2I81wb5TNuTl74DFna1Vo=;
        b=BAKZhjMB3822pn/9SS4pUCAUNDIAMJPc8FjEvA6nYHSo7hNwfKWN0vl3NeT5Dbej50
         m1sB5zLy5j/UPyb2jl6ml6fxY38IosVF+0sfGGLOldWoUczsN/4kTxygFYLNx4ckhJ3o
         kvnCnl+N/z8XZgnQVR93QSVP1CbAc0s/zTWCGrnH77cafBseyaudEW6GpjhLzK4cVbHi
         Ltw5VcZjU7nU8dEGzSeU/P2Mc/MTF8XBI4T02buGnDKM507pypHElspO2X00l766ZJiV
         dJzdVvWQJYGB1CMIMWP4OeUm80i9hNuFr+55MBOexImsAoHsssqlHeDxdCxqzAF1QyzL
         MaOA==
X-Gm-Message-State: AOJu0Yz+z4XWqXg10xwVOjwVuTkv9vPhTfh7yGScVmKv7beJIomrr8hS
        D3ggeWiAvVqZ5ERRw1sbJZpA23ptm5hcU19c
X-Google-Smtp-Source: AGHT+IG3POy/xWG/WDyZ0XfwMnRnvgN+lvkh+bOPbSZZR+8fqC69v8m8mzODHp3Q8B1EgiFH7jNqcQ==
X-Received: by 2002:a05:6870:b295:b0:1c0:fe16:90fa with SMTP id c21-20020a056870b29500b001c0fe1690famr489853oao.56.1692393270026;
        Fri, 18 Aug 2023 14:14:30 -0700 (PDT)
Received: from localhost.localdomain ([2804:56c:d7a7:4200:af4f:edcc:126f:213d])
        by smtp.gmail.com with ESMTPSA id c5-20020a05687091c500b001b03e0c0970sm1470671oaf.2.2023.08.18.14.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 14:14:29 -0700 (PDT)
From:   BrenoRCBrito <brenorcbrito@gmail.com>
Cc:     brenorcbrito@gmail.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        linkt <xazrael@hotmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: amd: yc: Add VivoBook Pro 15 to quirks list for acp6x
Date:   Fri, 18 Aug 2023 18:14:16 -0300
Message-Id: <20230818211417.32167-1-brenorcbrito@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VivoBook Pro 15 Ryzen Edition uses Ryzen 6800H processor, and adding to
 quirks list for acp6x will enable internal mic.

Signed-off-by: BrenoRCBrito <brenorcbrito@gmail.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index a2fe3bd4f9a1..a2661dd637a5 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -248,6 +248,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "M3402RA"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "M6500RC"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.40.1

