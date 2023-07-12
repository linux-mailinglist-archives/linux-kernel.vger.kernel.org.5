Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3145750FF9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 19:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbjGLRuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 13:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjGLRug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 13:50:36 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F541980;
        Wed, 12 Jul 2023 10:50:33 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbf1b82de7so7147985e9.1;
        Wed, 12 Jul 2023 10:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689184232; x=1691776232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LZqLINOtBwV5zC4WW6O4f4il0pqHzOeFeKN7V/Riank=;
        b=JZg4UToys+m3hyc3PDmhlRIvzt2GNAcrwRwmAxhwe0XgTRDePrnFKWBWRAC9l9DKFT
         V23CASp1H4expuyNbmf52cqrOkt8HX2U8xjoZxa8pLkMHb3YtYoeOO5joFlwF9fN01cn
         wOMcXbrPX4g514OugpkhjvTDu+5kuj6tqDlv4sKJ9uVvDWux1U+XBK0ArVJ6ZO/GNHxR
         pjT7/r02Uxu1wDzWg39XPxu5tU178shEchL3Glu1HlZHkLxZZ/8JrPlNm6g08zV3pTgw
         XHppda1g+RsxbUohUJcTTtA6udBhnnFBsPoyWrnVhzvvLeRDN1pkQ7VE6TNcth98L2De
         abHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689184232; x=1691776232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LZqLINOtBwV5zC4WW6O4f4il0pqHzOeFeKN7V/Riank=;
        b=B8a35pegvomN/AekrTf5E17JsCK2sB89Sj/3L6LkIThUyhMQXTbH91axvwFRJR7meq
         dG3Jj1Kj/vQDTlmJJzO/hnOE2VQ2fLLh5jgqdp1b73hVRNZsvAbVdl/kkW8hq2k+K+Uy
         9v7AVBohp+M/UgjanRNEVjYyzVP4rHfsG2OrT/LjuInW17Q/qm4toPksdetBsa4b7WzQ
         H8chdwNRqgRQ+IujuQkB80lVQQpA/QFRqZRK7Xfh7B91tquBtsY37RVUkU19YCJ2zBmV
         HEKegGeF0/QQe37yUaemqLn5R+AauiM654Dc+qx6v90v2bP0Ze65mU3EKerbMRnubV7S
         2RCQ==
X-Gm-Message-State: ABy/qLYlMoLogkaSOdB7ees9nWNVApPQnlCYutqA0dZBpyzGXXPnBMCX
        qi9K0cBXRAAjJrwm5BnVcVHCIaPZo7ASDmR/HcjApw==
X-Google-Smtp-Source: APBJJlEDVrkg2aUJMb9F1hfAJ3sNJWM1NtrYsD/SjHfIqa74JWlrpN0wNdOQCGYwys+AQMetnzcxSQ==
X-Received: by 2002:a05:600c:220f:b0:3f4:2a69:409 with SMTP id z15-20020a05600c220f00b003f42a690409mr75782wml.11.1689184231951;
        Wed, 12 Jul 2023 10:50:31 -0700 (PDT)
Received: from localhost (04.nur.exit.tor.loki.tel. [94.16.121.226])
        by smtp.gmail.com with ESMTPSA id s6-20020a05600c044600b003fbdf8292a7sm5575968wmb.46.2023.07.12.10.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 10:50:31 -0700 (PDT)
From:   Maxim Mikityanskiy <maxtram95@gmail.com>
To:     Alex Hung <alexhung@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Hughes <hughsient@gmail.com>,
        Jorge Lopez <jorge.lopez2@hp.com>,
        Maxim Mikityanskiy <maxtram95@gmail.com>
Subject: [PATCH] platform/x86/intel/hid: Add HP Dragonfly G2 to DMI quirks
Date:   Wed, 12 Jul 2023 20:50:23 +0300
Message-ID: <20230712175023.31651-1-maxtram95@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW_TABLET_MODE reports are broken on BIOS versions newer than 1.9.1 on
HP Elite Dragonfly G2. Analysis of SSDT9 shows that the BTNL method has
to be called to start getting 0xcc and 0xcd events. Apparently, the
button_array_present method used to return true on BIOS 1.9.1 and older,
but it returns false on newer BIOSes due to HEBC returning 0x000033f3
(bits 0x60000 and 0x20000 are not set).

Add this laptop to button_array_table to force the BTNL call, and also
add it to dmi_vgbs_allow_list to read the initial state and sync VBDS
with VBPS, because this laptop has a reliable VGBS method.

Tested with BIOS 1.13.1.

Signed-off-by: Maxim Mikityanskiy <maxtram95@gmail.com>
---
 drivers/platform/x86/intel/hid.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/platform/x86/intel/hid.c b/drivers/platform/x86/intel/hid.c
index 5632bd3c534a..5c78b476ed1e 100644
--- a/drivers/platform/x86/intel/hid.c
+++ b/drivers/platform/x86/intel/hid.c
@@ -128,6 +128,13 @@ static const struct dmi_system_id button_array_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Surface Go 3"),
 		},
 	},
+	{
+		.ident = "HP Elite Dragonfly G2",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP Elite Dragonfly G2 Notebook PC"),
+		},
+	},
 	{ }
 };
 
@@ -150,6 +157,12 @@ static const struct dmi_system_id dmi_vgbs_allow_list[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Surface Go"),
 		},
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP Elite Dragonfly G2 Notebook PC"),
+		},
+	},
 	{ }
 };
 
-- 
2.41.0

