Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F5D801CB9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 13:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbjLBMwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 07:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLBMv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 07:51:57 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F221C11B;
        Sat,  2 Dec 2023 04:52:01 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40b54261524so32570335e9.3;
        Sat, 02 Dec 2023 04:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701521520; x=1702126320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZ7Vk4rlYI4wpR0DprPRhwDbWK92/MFMHHXtx/iHz6w=;
        b=FdlGoiv5Ilmiq6J7++JRxUlIW/smuP2FwY+0SRSD2s+X2SumG2VB8mqUmq38XfjX8J
         SnLdhnkTd0OU88aCEyE8SXc3VLSvyC5GjFWPifgGMAP5uwT5ipgjoSKEje/4fr1D1xFC
         neQkmWgCK5V2yHfJ+8R9yW9mqKiZsUptUFF1M6h3dab2hA5VmAgKhWW/NPMXS8BMFk67
         zKia/NyVyXtGEa5k8NrGk+rSJNVcNMDJvwxEoZSlY2rugjq3MvQpNGwIK2bpFdr6g+Pr
         J+GNFWCypJbx0gFPJZUtJc0A1EjTM2pShNxYiZmz7pMoJI/f4XFayEqc3tV5NDe5TqMI
         TGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701521520; x=1702126320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZ7Vk4rlYI4wpR0DprPRhwDbWK92/MFMHHXtx/iHz6w=;
        b=ltc6JkYkArAXeurbBuD6hJkHys4uhnzP04x7ewLisztYejyGz9wganAUSxZA3aqTTs
         RUPko1iZNxadMJIvStTd3XjINZ8kvq+qEn1EjxJa2/zacfpcSQy0mnZa7I+8aUzLto7Y
         H9GRY0pkxUHBoP1/979d4BeqJhfsDRudtisLGyJmC3w7OLmw4EBCYus8e2D1++9SYN98
         2iMrHy4scNGQACWEGea03is940TE36iJ/BQVBGhAzrb8YpmkdTBUIlCN07niWwsdPpJo
         VvJNFG7m/L/7Rk4D5H9jfWmQda5A1BQqdSPqauXYLuFcM+MJlFtUwI451RjowwwJMgWu
         8hzQ==
X-Gm-Message-State: AOJu0YytPMo8C1j4qpOUFUjDlCJmZJ41zz7w5VjVYSZDvZYzULpOFuah
        DxsQwNjULkfbOcLzP7kL/A==
X-Google-Smtp-Source: AGHT+IGHKK9cB3J1W0QWDzln8wREBYdZjVmE10rf8PD+2/UqMjmKdajLeMCstCvLsLWhy3jXHtShew==
X-Received: by 2002:a05:600c:3b85:b0:40b:5e21:dd1a with SMTP id n5-20020a05600c3b8500b0040b5e21dd1amr414964wms.72.1701521520134;
        Sat, 02 Dec 2023 04:52:00 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:908e:b829:354b:f8ee])
        by smtp.gmail.com with ESMTPSA id g5-20020a170906198500b009c5c5c2c5a4sm3018161ejd.219.2023.12.02.04.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 04:51:59 -0800 (PST)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 1/5] pmdomain: rockchip: Add missing powerdomains for RK3128
Date:   Sat,  2 Dec 2023 13:51:40 +0100
Message-ID: <20231202125144.66052-2-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231202125144.66052-1-knaerzche@gmail.com>
References: <20231202125144.66052-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For RK3128 the powerdomains PD_PERI, PD_SYS and PD_CRYPTO are currently
missing.
Add them.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 drivers/pmdomain/rockchip/pm-domains.c   | 13 ++++++++-----
 include/dt-bindings/power/rk3128-power.h |  3 +++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 9b76b62869d0..62ba4129f6bb 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -998,11 +998,14 @@ static const struct rockchip_domain_info rk3066_pm_domains[] = {
 };
 
 static const struct rockchip_domain_info rk3128_pm_domains[] = {
-	[RK3128_PD_CORE]	= DOMAIN_RK3288("core",  BIT(0), BIT(0), BIT(4), false),
-	[RK3128_PD_MSCH]	= DOMAIN_RK3288("msch",  0,      0,      BIT(6), true),
-	[RK3128_PD_VIO]		= DOMAIN_RK3288("vio",   BIT(3), BIT(3), BIT(2), false),
-	[RK3128_PD_VIDEO]	= DOMAIN_RK3288("video", BIT(2), BIT(2), BIT(1), false),
-	[RK3128_PD_GPU]		= DOMAIN_RK3288("gpu",   BIT(1), BIT(1), BIT(3), false),
+	[RK3128_PD_CORE]	= DOMAIN_RK3288("core",   BIT(0), BIT(0), BIT(4), false),
+	[RK3128_PD_MSCH]	= DOMAIN_RK3288("msch",   0,      0,      BIT(6), true),
+	[RK3128_PD_VIO]		= DOMAIN_RK3288("vio",    BIT(3), BIT(3), BIT(2), false),
+	[RK3128_PD_VIDEO]	= DOMAIN_RK3288("video",  BIT(2), BIT(2), BIT(1), false),
+	[RK3128_PD_GPU]		= DOMAIN_RK3288("gpu",    BIT(1), BIT(1), BIT(3), false),
+	[RK3128_PD_PERI]	= DOMAIN_RK3288("peri",   0,      0,      BIT(0), false),
+	[RK3128_PD_SYS]		= DOMAIN_RK3288("sys",    0,      0,      BIT(5), true),
+	[RK3128_PD_CRYPTO]	= DOMAIN_RK3288("crypto", 0,      0,      BIT(7), false),
 };
 
 static const struct rockchip_domain_info rk3188_pm_domains[] = {
diff --git a/include/dt-bindings/power/rk3128-power.h b/include/dt-bindings/power/rk3128-power.h
index c051dc3108db..68af6c68c272 100644
--- a/include/dt-bindings/power/rk3128-power.h
+++ b/include/dt-bindings/power/rk3128-power.h
@@ -10,5 +10,8 @@
 #define RK3128_PD_VIDEO		2
 #define RK3128_PD_GPU		3
 #define RK3128_PD_MSCH		4
+#define RK3128_PD_PERI		5
+#define RK3128_PD_SYS		6
+#define RK3128_PD_CRYPTO	7
 
 #endif
-- 
2.43.0

