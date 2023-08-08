Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999E87744B8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235449AbjHHS1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235443AbjHHS0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:26:42 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFB72335B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:41:17 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-58411e24eefso64160837b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 10:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691516477; x=1692121277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5vSuOYJ8lgzid7qcR3Pv4QupXjq5e6/Z+W5Dx+Z51YE=;
        b=esWesM8y33s2kyeH2UvYVGe/afZwXmOBV1q+R4RLb3ScYtHVHF7ilo653ef9JOjLO9
         BjiMaxRAa6kEO/E7WX3e1lQj8ZTjsY8eG6bUlbZH8vipPjz9OAPHjmIDvRprvZ2V0gvK
         WqmrgxUF4nTQERIA9kMJrNZ/lDjAtpq2b4oAQxhlT5AbANBvZpcFm80p5uVE91K5wPU3
         kAJk5J0OtT2HPXo8KWdE3M6Obmd0PdB62SxXJFGR900fMPL1WzNkbp5ZFNbehSeqpv9l
         FBw7DCtuSeL4ZKVtfr9QxY0fQ505E1lQZjAsBuZ0hOiESdFrZqgAz3uFfZUL6e5z2u2/
         WbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691516477; x=1692121277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5vSuOYJ8lgzid7qcR3Pv4QupXjq5e6/Z+W5Dx+Z51YE=;
        b=jLDZD7kKKjJmAL3aHasj+0UHUMRUaqXfwJ+X1rNLF8827JxLvINu0SrU5gQl0YsETD
         Ot75r+JGmw8PjXCEJqGqpU1JgdBdtq4i/sp5a4gvEjepgHHXzL+Z/ItJsdpCaROWO1NW
         ypkIZSNMoRuq0F7YgP5Xk+pa6/xe2z4yxe220gkkY0MaofUAgyZqGYnqs6yBp8BJChly
         OS+qlfHHnRA9z3uKZj16jx4bzGgEtkgQ7rk0ENwfv4sFm3NYnVUkk8kRahCEpyOnnZDz
         DvCfojg5EM5TVnqp7IRpbBonYgD9j2atnzoyqTA2G5n56P0DYhZ2ygdB6EmdOBrflfSJ
         6hNg==
X-Gm-Message-State: AOJu0YwMg390APV+CBMqVTPvaBsSbqbKoHoKeDJpf+kuwzvJfPNXPiti
        Pe1pvmOhNmMgm2en0VVBk/mIXv4iWtzdSw==
X-Google-Smtp-Source: AGHT+IFaHs7LV2J++qlIMAwQvOnlN3wBSkOzg0ctEJpNLDT1O32slLnzmFKCIBCVAJeiEoJkTtBCpg==
X-Received: by 2002:a0d:dbd2:0:b0:583:f02e:b93e with SMTP id d201-20020a0ddbd2000000b00583f02eb93emr448950ywe.35.1691516476828;
        Tue, 08 Aug 2023 10:41:16 -0700 (PDT)
Received: from walt-ROG-Strix.. (99-176-3-182.lightspeed.brhmal.sbcglobal.net. [99.176.3.182])
        by smtp.gmail.com with ESMTPSA id c190-20020a814ec7000000b005619cfb1b88sm3514501ywb.52.2023.08.08.10.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 10:41:16 -0700 (PDT)
From:   Walt Holman <waltholman09@gmail.com>
To:     tiwai@suse.de, linux-kernel@vger.kernel.org
Cc:     Walt Holman <waltholman09@gmail.com>
Subject: [PATCH] Add quirk for MSI Bravo B7ED digital microphone
Date:   Tue,  8 Aug 2023 12:37:45 -0500
Message-Id: <20230808173744.14837-1-waltholman09@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Walt Holman <waltholman09@gmail.com>

---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index a2fe3bd4f9a1..1498df122f38 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -248,6 +248,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "M3402RA"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Micro-Star International Co., Ltd."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Bravo 15 B7ED"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.39.2

