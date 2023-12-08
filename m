Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D2E809C54
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 07:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbjLHGZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 01:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHGZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 01:25:17 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2411723;
        Thu,  7 Dec 2023 22:25:24 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7b70db00e64so15180039f.2;
        Thu, 07 Dec 2023 22:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702016723; x=1702621523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zFpM3a3kO+H6eKxWi2Fxy+Ey6betIA4rnEu4oUHt5AI=;
        b=F+nUt65aNaTGMqw0755syQrKfVb7ik07xoj9ZBf56NiSd9xw/igbD1RO/HSvTO0Uvp
         wkN+eyANJtBgJ7euFABTMS/EpMC+HG4KOgf7QQzeEdm6YrYCzWdQ/hRZDY4wMs9odOSj
         KyaGIwumkoV3m5PfeHkL7+nCqXyXPIr5HG8pJu2sVy8H0WyNPcWy9nIlBmQfWNFJP3Jc
         wqXCpC7TF5jPGlbn2u4RNuFMamyqfzxVTt/eQ1N4H0rSCrSZN6giFQm8raCb3MbNH02J
         +HiQcBILS6rBqyeAAB2SWmSTorQioED4WOs5qcAjBcjggSnO0pIl+m5rzfouMi0M0k+7
         F7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702016723; x=1702621523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zFpM3a3kO+H6eKxWi2Fxy+Ey6betIA4rnEu4oUHt5AI=;
        b=UmiNUPG2toGDYSQaaczlg1hgJGnsVU0zn8gIipsyK8iRgD8DOObmrNnpAodtlIjZIu
         jzjRBypiMmd8q3FmslIB1/6aqUQvj2lH9q0TjkxQ6IzODHtLyoSvrMxPSys/JvRAUhAu
         6NMl6DGYnVbHVDRCx4ezrH9WdHuvY5jMHyXCTqWkh95ELuGaeqvohHznm8WNimV7B6b5
         Id+2mbBeUObCcNY8elz/YxbWWxoTzjXxJQqyp578aDqIz4sqKHiTtpeaLTThLNYjPPlC
         lwAxKDkELYDqothQGjoONRvQb2SRBoWHqR0rF2B5uO0gmDxtyAUeIPqmuA6k5ahpTD8P
         uCrw==
X-Gm-Message-State: AOJu0YyhJ0fe6F6yJvMwEHVSXFHdh2bHr7DBAgqH35bYm7M1o5L2RF8v
        9y9i/PsDvhTAXNQMfaBZ+RM=
X-Google-Smtp-Source: AGHT+IHD/PmHnKSx9OZ0b73k8RkKfdGrpVKH95h+DLSuZ8wr3y94tZA8ushXUOt0kbv5NYsMvhtXPA==
X-Received: by 2002:a6b:6a14:0:b0:7b4:28f8:d8 with SMTP id x20-20020a6b6a14000000b007b428f800d8mr4136516iog.33.1702016723587;
        Thu, 07 Dec 2023 22:25:23 -0800 (PST)
Received: from celestia.nettie.lan ([2001:470:42c4:101:de4c:e3ab:ccaa:1887])
        by smtp.gmail.com with ESMTPSA id h25-20020a02cd39000000b0042acf934cbasm301894jaq.72.2023.12.07.22.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 22:25:23 -0800 (PST)
From:   Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?UTF-8?q?Daniel=20Kukie=C5=82a?= <daniel@kukiela.pl>,
        Sven Rademakers <sven.rademakers@gmail.com>,
        Joshua Riek <jjriek@verizon.net>,
        Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH v2] arm64: dts: rockchip: Add PCIe pinctrls to Turing RK1
Date:   Thu,  7 Dec 2023 23:25:10 -0700
Message-ID: <20231208062510.893392-1-CFSworks@gmail.com>
X-Mailer: git-send-email 2.41.0
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

The RK3588 PCIe 3.0 controller seems to have unpredictable behavior when
no CLKREQ/PERST/WAKE pins are configured in the pinmux. In particular, it
will sometimes (varying between specific RK3588 chips, not over time) shut
off the DBI block, and reads to this range will instead stall
indefinitely.

When this happens, it will prevent Linux from booting altogether. The
PCIe driver will stall the CPU core once it attempts to read the version
information from the DBI range.

Fix this boot hang by adding the correct pinctrl configuration to the
PCIe 3.0 device node, which is the proper thing to do anyway. While
we're at it, also add the necessary configuration to the PCIe 2.0 node,
which may or may not fix the equivalent problem over there -- but is the
proper thing to do anyway. :)

Fixes: 2806a69f3fef6 ("arm64: dts: rockchip: Add Turing RK1 SoM support")
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---

Hi list,

Compared to v1, v2 removes the `reset-gpios` properties as well -- this should
give control of the PCIe resets exclusively to the PCIe cores. (And even if the
`reset-gpios` props had no effect in v1, it'd be confusing to have them there.)

Note that it is OK for the pcie2x1l1 node to refer to pcie30x1m1_pins. The
pcie2x1l1 device is *in fact* a PCIe 3.0 controller, and the pcie30x1m1_pins
pinmux setting is so-named to reflect this. The pcie2x1l1 node is so-named
because Linux does not (currently) support routing it to a PCIe 3.0 PHY; so in
practice it is effectively a PCIe 2.0 controller, for the time being.

Cheers and thank you for your time,
Sam

---
 .../boot/dts/rockchip/rk3588-turing-rk1.dtsi     | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
index 9570b34aca2e..875446fdb67e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
@@ -214,8 +214,7 @@ rgmii_phy: ethernet-phy@1 {
 &pcie2x1l1 {
 	linux,pci-domain = <1>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&pcie2_reset>;
-	reset-gpios = <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
+	pinctrl-0 = <&pcie30x1m1_pins>;
 	status = "okay";
 };
 
@@ -226,8 +225,7 @@ &pcie30phy {
 &pcie3x4 {
 	linux,pci-domain = <0>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&pcie3_reset>;
-	reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
+	pinctrl-0 = <&pcie30x4m1_pins>;
 	vpcie3v3-supply = <&vcc3v3_pcie30>;
 	status = "okay";
 };
@@ -245,17 +243,7 @@ hym8563_int: hym8563-int {
 		};
 	};
 
-	pcie2 {
-		pcie2_reset: pcie2-reset {
-			rockchip,pins = <4 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
 	pcie3 {
-		pcie3_reset: pcie3-reset {
-			rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-
 		vcc3v3_pcie30_en: pcie3-reg {
 			rockchip,pins = <2 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
-- 
2.41.0

