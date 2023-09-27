Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06977B0EEE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 00:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjI0WdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 18:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjI0WdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 18:33:01 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4664102;
        Wed, 27 Sep 2023 15:32:56 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4060b623e64so37447445e9.0;
        Wed, 27 Sep 2023 15:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695853939; x=1696458739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T9WCpJ9NzeLVvWIWMoXZNdOxnnzDXic6RaiR8cReCog=;
        b=akmHz3sfcrR6vZJ5fe6Hv7Hvu50NMNsWni+qcQKYfvCU1xOfOTFJwriVOLGR0q8Xst
         +8cLQAzeMImHLv5aeoa5ALHz4GEzsAZcqu8va9pwwfvbxFag5RlRTdsCS6eBOHcANObp
         uaQetUsQM5W4QGxr1S9cR4+pXV3mXOUXs/ui3Zu4qAzZhexO4zggePbz5JkMS3lYWpBO
         TGyXbnIPfOK/IXv+Sf8ZJzJvUYnK5ql3Ej2dHx6Bxv5gMVflN+yoKclfAenTMCQgRt/n
         ZoZxC1Y0c3igOenB0fOGFglj/Bb9KTeUI8INbAjre6Rzq6r+P8Yorhb69+eTnPmo0JfM
         cslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695853939; x=1696458739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T9WCpJ9NzeLVvWIWMoXZNdOxnnzDXic6RaiR8cReCog=;
        b=v0OvJT7bk8pR8v6wEzv96z3w8AN3SkOB9/rYSrSTslL/vNGOjm5tq6WxikmTzOJ1iO
         Rj5QGoZhPcj0R6E12JGS7Djp28NIsypgUSiBzw96JRd0nvAVH3NobnIO8NuxLLDjz1+F
         1gdvs5oOXKfjB+kcWBZRbWmfX+oz5B1H2lx8ibs9nDG6610XLmqexjagbOA1NQgDLU2C
         NMSITGKGvbOaP+tY26WViKKaq3d2C+WyHPcRmSOXfrteXMzQJB0njxirVwCoAU2WpEQi
         dY3bWkO8OVlIW+4gSsxRYuCbLh/DTAKm0iyD/qBixVjOHmKA+Z2XS03Pp6OB7tgm6NWw
         miMQ==
X-Gm-Message-State: AOJu0Yws/r/rXbd3AboLNhxvchxuV8veERlpe0w1BgdKt/PkEWjXILfA
        YVsgUzHeB4lqa45Hpyfg1Rw=
X-Google-Smtp-Source: AGHT+IFj90YtQ231dKDr0LEfgiMpXwVWVmPmdjVad5uEus1rDhNZDLL8aaM/ziz9du6rV9rqF69JKg==
X-Received: by 2002:a05:600c:1c13:b0:401:c717:ec6d with SMTP id j19-20020a05600c1c1300b00401c717ec6dmr5932985wms.15.1695853939206;
        Wed, 27 Sep 2023 15:32:19 -0700 (PDT)
Received: from yoga.fem.tu-ilmenau.de ([2001:638:904:ffe5:5742:c50f:bd0:6aa6])
        by smtp.gmail.com with ESMTPSA id o11-20020a5d4a8b000000b0031ffb51f6f9sm18019304wrq.30.2023.09.27.15.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 15:32:18 -0700 (PDT)
From:   Sven Frotscher <sven.frotscher@gmail.com>
To:     broonie@kernel.org
Cc:     git@augustwikerfors.se, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        mario.limonciello@amd.com, regressions@lists.linux.dev,
        Sven Frotscher <sven.frotscher@gmail.com>,
        stable@vger.kernel.org
Subject: [PATCH v3] ASoC: amd: yc: Fix non-functional mic on Lenovo 82YM
Date:   Wed, 27 Sep 2023 23:48:02 +0200
Message-ID: <20230927215058.16220-2-sven.frotscher@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like the Lenovo 82TL, 82V2, 82QF and 82UG, the 82YM (Yoga 7 14ARP8)
requires an entry in the quirk list to enable the internal microphone.
The latter two received similar fixes in commit 1263cc0f414d
("ASoC: amd: yc: Fix non-functional mic on Lenovo 82QF and 82UG").

Fixes: c008323fe361 ("ASoC: amd: yc: Fix a non-functional mic on Lenovo 82SJ")
Cc: stable@vger.kernel.org
Signed-off-by: Sven Frotscher <sven.frotscher@gmail.com>
---
v2->v3 changes:
* add message title of referenced commit to commit message
* make whitespace consistent with surrounding code
* use a patch-friendly e-mail client
---
v1->v2 changes:
* add Fixes and Cc tags to commit message
* remove redundant LKML link from commit message
* fix mangled diff
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 94e9eb8e73f2..15a864dcd7bd 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -241,6 +241,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "82V2"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82YM"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.42.0

