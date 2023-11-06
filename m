Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCD87E1888
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 03:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjKFCPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 21:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKFCPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 21:15:01 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D5DEB
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 18:14:58 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6bd73395bceso3214620b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 18:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nathanrossi.com; s=google; t=1699236897; x=1699841697; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ws+jU834Z5pTFjaSqg7/r2pohlZD9LFdAotisTHBmcI=;
        b=c/qYfM70BedTUEz6I8040Ov72NuFbAHKNKP+eAWNZ+bVMpJnyeZHGpZH985tYW+Mpn
         YmpLMKfpQ/OU7y7uIRrkxMs7flr11UMYR7mJecZXCgGVMRFucnfMLfxZA0P8cJMr61p9
         KODRqbVLtO5eU9MooyATemcOi7YtapMM49LHMNeuk67lDWL2hXy09Yiu6jnlk2s2uTsT
         lMUoiaGizrwXVZsU+vJF8Y9qIlVNRigkkUAPuM3owLr/mhr98erCWlC3nFdCPMIzPsZG
         BN8DUdCo+xSPlNlO5RogVnC5U0p3lP18YFPnRySnWDFPlXBdokiSKJbVChA3p9aOHSSw
         LCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699236897; x=1699841697;
        h=mime-version:content-transfer-encoding:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ws+jU834Z5pTFjaSqg7/r2pohlZD9LFdAotisTHBmcI=;
        b=N994AelCUQcb3pMXPu2vvkKoUhsyNh8gVExkYl7eiiEBwCdxyxGNx8el54yawesx4s
         YZ80BnqcM1Fs6UrVBZEny/9diHuz/kTfARQTQ3W/UJaSx3Htd/ccQVPFHJMh2ueO2NVz
         zHjfV8TwGKQ+1jWfc+TbcixaZGfApp8/uetvoGzNL+xsZDPI1pXi2D+FBHSIZtsZ/uo+
         uDR0gCaysawZZ/fc5PMF69KDfi8i3BaM41+jwjs6myJVVm6vN8V5chLnh9itqyHd+d7k
         soJxlqRpgpAs7UnRgKnXlBCYuU1JYJW13GUMljJc4kaCujZQc/TkROp1+pqaFcPmOfIB
         MnMg==
X-Gm-Message-State: AOJu0YxtWUKBKwXmeiKEydNmLlmlQT8gWgfbq9YbFJU/TStmdVwbV4MS
        VzkAeaQDW17CvHnhpntfjKE7QnKn1PbQKi9J/GdO1g==
X-Google-Smtp-Source: AGHT+IHR2nhzPl6lt4YYapmqhrLBMX6QH5ic7OLG3JGF8/stq+pN8h2t4zePr3+UKE9bM02bEaIXgw==
X-Received: by 2002:a05:6a20:1446:b0:13f:13cb:bc50 with SMTP id a6-20020a056a20144600b0013f13cbbc50mr13293588pzi.25.1699236896754;
        Sun, 05 Nov 2023 18:14:56 -0800 (PST)
Received: from [127.0.1.1] (117-20-68-32.751444.bne.nbn.aussiebb.net. [117.20.68.32])
        by smtp.gmail.com with UTF8SMTPSA id d185-20020a6336c2000000b005b4b70738e5sm4534743pga.8.2023.11.05.18.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 18:14:56 -0800 (PST)
Date:   Mon, 06 Nov 2023 02:14:36 +0000
Message-Id: <20231106021436.1917894-1-nathan@nathanrossi.com>
From:   Nathan Rossi <nathan@nathanrossi.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Nathan Rossi <nathan@nathanrossi.com>,
        Nathan Rossi <nathan.rossi@digi.com>,
        Fabio Estevam <festevam@gmail.com>, Li Jun <jun.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH v2] arm64: dts: imx8mp: imx8mq: Add parkmode-disable-ss-quirk on DWC3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Rossi <nathan.rossi@digi.com>

The i.MX8MP and i.MX8MQ devices both use the same DWC3 controller and
are both affected by a known issue with the controller due to specific
behaviour when park mode is enabled in SuperSpeed host mode operation.

Under heavy USB traffic from multiple endpoints the controller will
sometimes incorrectly process transactions such that some transactions
are lost, or the controller may hang when processing transactions. When
the controller hangs it does not recover.

This issue is documented partially within the linux-imx vendor kernel
which references a Synopsys STAR number 9001415732 in commits [1] and
additional details in [2]. Those commits provide some additional
controller internal implementation specifics around the incorrect
behaviour of the SuperSpeed host controller operation when park mode is
enabled.

The summary of this issue is that the host controller can incorrectly
enter/exit park mode such that part of the controller is in a state
which behaves as if in park mode even though it is not. In this state
the controller incorrectly calculates the number of TRBs available which
results in incorrect access of the internal caches causing the overwrite
of pending requests in the cache which should have been processed but
are ignored. This can cause the controller to drop the requests or hang
waiting for the pending state of the dropped requests.

The workaround for this issue is to disable park mode for SuperSpeed
operation of the controller through the GUCTL1[17] bit. This is already
available as a quirk for the DWC3 controller and can be enabled via the
'snps,parkmode-disable-ss-quirk' device tree property.

It is possible to replicate this failure on an i.MX8MP EVK with a USB
Hub connecting 4 SuperSpeed USB flash drives. Performing continuous
small read operations (dd if=/dev/sd... of=/dev/null bs=16) on the block
devices will result in device errors initially and will eventually
result in the controller hanging.

  [13240.896936] xhci-hcd xhci-hcd.0.auto: WARN Event TRB for slot 4 ep 2 with no TDs queued?
  [13240.990708] usb 2-1.3: reset SuperSpeed USB device number 5 using xhci-hcd
  [13241.015582] sd 2:0:0:0: [sdc] tag#0 UNKNOWN(0x2003) Result: hostbyte=0x07 driverbyte=DRIVER_OK cmd_age=0s
  [13241.025198] sd 2:0:0:0: [sdc] tag#0 CDB: opcode=0x28 28 00 00 00 03 e0 00 01 00 00
  [13241.032949] I/O error, dev sdc, sector 992 op 0x0:(READ) flags 0x80700 phys_seg 25 prio class 2
  [13272.150710] usb 2-1.2: reset SuperSpeed USB device number 4 using xhci-hcd
  [13272.175469] sd 1:0:0:0: [sdb] tag#0 UNKNOWN(0x2003) Result: hostbyte=0x03 driverbyte=DRIVER_OK cmd_age=31s
  [13272.185365] sd 1:0:0:0: [sdb] tag#0 CDB: opcode=0x28 28 00 00 00 03 e0 00 01 00 00
  [13272.193385] I/O error, dev sdb, sector 992 op 0x0:(READ) flags 0x80700 phys_seg 18 prio class 2
  [13434.846556] xhci-hcd xhci-hcd.0.auto: xHCI host not responding to stop endpoint command
  [13434.854592] xhci-hcd xhci-hcd.0.auto: xHCI host controller not responding, assume dead
  [13434.862553] xhci-hcd xhci-hcd.0.auto: HC died; cleaning up

[1] https://github.com/nxp-imx/linux-imx/commit/97a5349d936b08cf301730b59e4e8855283f815c
[2] https://github.com/nxp-imx/linux-imx/commit/b4b5cbc5a12d7c3b920d1d7cba0ada3379e4e42b

Fixes: fb8587a2c165 ("arm64: dtsi: imx8mp: add usb nodes")
Fixes: ad37549cb5dc ("arm64: dts: imx8mq: add USB nodes")
Signed-off-by: Nathan Rossi <nathan.rossi@digi.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
Changes in v2:
- Added Fixes to commit message
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 ++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index c9a610ba48..1264da6012 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -2072,6 +2072,7 @@ usb_dwc3_0: usb@38100000 {
 				phys = <&usb3_phy0>, <&usb3_phy0>;
 				phy-names = "usb2-phy", "usb3-phy";
 				snps,gfladj-refclk-lpm-sel-quirk;
+				snps,parkmode-disable-ss-quirk;
 			};
 
 		};
@@ -2114,6 +2115,7 @@ usb_dwc3_1: usb@38200000 {
 				phys = <&usb3_phy1>, <&usb3_phy1>;
 				phy-names = "usb2-phy", "usb3-phy";
 				snps,gfladj-refclk-lpm-sel-quirk;
+				snps,parkmode-disable-ss-quirk;
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 4b1ce9fc17..c6dc3ba0d4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1649,6 +1649,7 @@ usb_dwc3_0: usb@38100000 {
 			phys = <&usb3_phy0>, <&usb3_phy0>;
 			phy-names = "usb2-phy", "usb3-phy";
 			power-domains = <&pgc_otg1>;
+			snps,parkmode-disable-ss-quirk;
 			status = "disabled";
 		};
 
@@ -1680,6 +1681,7 @@ usb_dwc3_1: usb@38200000 {
 			phys = <&usb3_phy1>, <&usb3_phy1>;
 			phy-names = "usb2-phy", "usb3-phy";
 			power-domains = <&pgc_otg2>;
+			snps,parkmode-disable-ss-quirk;
 			status = "disabled";
 		};
 
---
2.42.0
