Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25B478CEEB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 23:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbjH2Vmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 17:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234561AbjH2VmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 17:42:02 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E0EE0;
        Tue, 29 Aug 2023 14:41:59 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-52bcd4db4c0so577134a12.0;
        Tue, 29 Aug 2023 14:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693345318; x=1693950118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qnILlP8q2DeGAzfkJm61DUzvyf5NVG2lDz1bKXH5zw=;
        b=hkcuQyzJRMb8hfJdFVK5rC+Ep4syE23uVHIehR+bXC2Wkpnzi8eYoNoUQXo0zmHn8s
         Aa963gIYMUsg1y7I5KIMgHyBDcIdoiQ2cnfKo74aqIHL+u2Dd9JtMV9bWMIJLqEv8fMk
         doMXKW6WAXHmNokqVr9i3X3ddNk8+yGG9E1mmsxrWQgAq2uVSXyCDlG3c+OK+b2xvekH
         YXwGtVrGu+jWgDi+QpZuC1cpzjQ1f0huNOIubBvjzjWGrUCJIoI844lJ4sWSWBqMBibG
         rlOJsBg2AsJlATt2hNmGaMi6n0Hwg8XQDgucW21feOPVTyAv63cro7iMWr9ckM8uEVTK
         bGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693345318; x=1693950118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qnILlP8q2DeGAzfkJm61DUzvyf5NVG2lDz1bKXH5zw=;
        b=TCWBGWy6hCqAlF/m8XYUMYQ4c6Z5rwSbeFLJ3ZbJlsK6VHUThridjLEePbDaxcC+bR
         b7AuQCiHRhJdh4omkMWHTAZ0XKWZaCkxAJxflYOmW1fsbwj3pwsolFgPvQ8Lbo4CtigE
         cLvno+fk+NiH/rzbKiB55Va34WNqPm6BiIPTrTg0ANg1QiD/zyoDvk4XEdrihP2zBwqV
         wbTKIhzaKmYl9Z7CaPTQPR0QKVR1dTYZAmo6H/sJ+l/aQYUjPMri673hxt683l7NbIpn
         Zq9C1K7z7w8tQUCzCInR1bBgaGOtqupIx7uA+De088PBKPVdoBaqx9H+1SFLU/P2PVfw
         cV+w==
X-Gm-Message-State: AOJu0YxfRGrOn1IEBuu3GhgIkubp2Z+m94KR1+7r+uT9gwaktT2ShCEP
        8laZCcv58ZsTmgdlaJddbYIYJRd9Ew==
X-Google-Smtp-Source: AGHT+IE7hH16YYs92WhaAQWPFZk1HX03SLm48A7/44weyAkccswzPwpDYe/QN3pFb4Y/+lTSuS6Jow==
X-Received: by 2002:aa7:d614:0:b0:523:b133:5c7a with SMTP id c20-20020aa7d614000000b00523b1335c7amr445302edr.21.1693345317920;
        Tue, 29 Aug 2023 14:41:57 -0700 (PDT)
Received: from U4.lan ([2001:9e8:b963:7410:84d2:f616:9527:dd98])
        by smtp.gmail.com with ESMTPSA id f15-20020aa7d84f000000b0052228721f84sm6113428eds.77.2023.08.29.14.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 14:41:57 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 2/4] ARM: dts: rockchip: Add CPU resets for RK3128
Date:   Tue, 29 Aug 2023 23:40:05 +0200
Message-ID: <20230829214004.314932-6-knaerzche@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230829214004.314932-2-knaerzche@gmail.com>
References: <20230829214004.314932-2-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support bring-up of the non-boot cores, this patch adds the
reset controls for the cpu cores.
They are required/will be used by the Rockchip platsmp driver.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk3128.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
index 3a0856973795..2778049003a1 100644
--- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
@@ -34,6 +34,7 @@ cpu0: cpu@f00 {
 			reg = <0xf00>;
 			clock-latency = <40000>;
 			clocks = <&cru ARMCLK>;
+			resets = <&cru SRST_CORE0>;
 			operating-points = <
 				/* KHz    uV */
 				 816000 1000000
@@ -45,18 +46,21 @@ cpu1: cpu@f01 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0xf01>;
+			resets = <&cru SRST_CORE1>;
 		};
 
 		cpu2: cpu@f02 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0xf02>;
+			resets = <&cru SRST_CORE2>;
 		};
 
 		cpu3: cpu@f03 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0xf03>;
+			resets = <&cru SRST_CORE3>;
 		};
 	};
 
-- 
2.42.0

