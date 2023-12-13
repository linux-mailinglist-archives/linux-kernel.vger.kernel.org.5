Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59A48120CA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 22:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjLMVcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 16:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjLMVca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 16:32:30 -0500
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A718CF;
        Wed, 13 Dec 2023 13:32:36 -0800 (PST)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6d099d316a8so3558279b3a.0;
        Wed, 13 Dec 2023 13:32:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702503156; x=1703107956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9vLldFUT2lj5En/2c0eRbR6cRR7RYkOf947WEF4oTy8=;
        b=aPayDzM0Tmk5+mnHa1N43WMaCFCYGllFfA9xQ8DeaRXndhKw5FTjom2ByuirBymHI3
         r8mvf79n4ATASFqNRumgZX+s0fr/kWuWIyonRrDA81hCvMWNdd3lpdbbChhOQsKcG1xe
         4K6vjgNBElksozH/DSQZ53kuhPE8RMBFtFoDaOEFiYoFltg2X9PLChbtEXz/PwUcKLCo
         7ti3fmONG8NlyemFEknGCL6uO6jxkrVuUcCLrM232hrWHy0mFtgp8XeYcQEq5ZQR3hQa
         QSUv94qBa3bY7T+tvOqekNBUvYPSxdKd9j8U9oYaW7ki+wLuimB0JaxcCoSSsiXk5tt4
         cXBw==
X-Gm-Message-State: AOJu0Yw5M+cZLlsdeVkKDM19m1RJU8GOE2XIag5wNGdAOqMBKqgjw91V
        3hUWleNqjtxAFD1WhaVC7Ok=
X-Google-Smtp-Source: AGHT+IFeHj1sZHbZlIX7LHxiM+jET3cKuq1LbZO13kqqQ2WkZ3POeQpJjFyD/xFuF7j1BPNZzRS0KQ==
X-Received: by 2002:a05:6a00:4601:b0:6cd:f91e:dfe4 with SMTP id ko1-20020a056a00460100b006cdf91edfe4mr9061145pfb.2.1702503155583;
        Wed, 13 Dec 2023 13:32:35 -0800 (PST)
Received: from dev-linux.lan (070-095-021-110.res.spectrum.com. [70.95.21.110])
        by smtp.gmail.com with ESMTPSA id p51-20020a056a0026f300b006cef5c09ca3sm3190824pfw.147.2023.12.13.13.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 13:32:35 -0800 (PST)
From:   Sukrut Bellary <sukrut.bellary@linux.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Sukrut Bellary <sukrut.bellary@linux.com>,
        Robert Nelson <robertcnelson@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, d-gole@ti.com,
        Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH] arm64: dts: ti: k3-am625-beagleplay: Use pwrseq for TI's wl18xx enable.
Date:   Wed, 13 Dec 2023 13:32:19 -0800
Message-Id: <20231213213219.566369-1-sukrut.bellary@linux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BeaglePlay SBC has Texas Instrument's WL18xx WiFi Chipset.

BeaglePlay SBC:
https://www.beagleboard.org/boards/beagleplay

TI WL18XX:
https://www.ti.com/lit/ds/symlink/wl1807mod.pdf

Currently, WLAN_EN is configured as regulator and regulator-always-on.
During hibernation thaw, WiFi fails to come online.
During freeze/suspend,
the WLAN_EN line is not put to low '0' to power down the WiFi.
So during restore, the WiFi driver tries to load the FW without following
correct power sequence.
WLAN_EN => '1'/assert (high) to power-up the chipset.
WLAN_EN => '0'/deassert (low) to shut-down the chipset.

thaw failure log below:

Use mmc-pwrseq-simple to drive TI's WiFi (WL18xx) chipset enable 'WLAN_EN'.
mmc-pwrseq-simple provides power sequence flexibility with support for
post power-on and power-off delays.

================ thaw failure Log ================
[  161.418528] ------------[ cut here ]------------
[  161.418540] WARNING: CPU: 1 PID: 45 at drivers/net/wireless/ti/wlcore/sdio.c:123 wl12xx_sdio_raw_write+0xe4/0x168 [wlcore_sdio]
[  161.418576] Modules linked in: br_netfilter bridge stp llc overlay usb_f_mass_storage usb_f_acm u_serial usb_f_ncm usb_f_rndis u_ether libcomposite wl18xx wlcore mac80211 libarc4 cfg80211 rfkill crct10dif_ce6[  161.418676] CPU: 1 PID: 45 Comm: kworker/u8:2 Not tainted 6.5.0-rc6+ #2
[  161.418684] Hardware name: BeagleBoard.org BeaglePlay (DT)
[  161.418691] Workqueue: events_unbound async_run_entry_fn
[  161.418711] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  161.418719] pc : wl12xx_sdio_raw_write+0xe4/0x168 [wlcore_sdio]
[  161.418731] lr : wl12xx_sdio_raw_write+0x94/0x168 [wlcore_sdio]
[  161.418743] sp : ffff800082b43970
[  161.418746] x29: ffff800082b43970 x28: ffff800083c5b000 x27: 0000000000000003
[  161.418757] x26: ffff80007aab3800 x25: ffff800083c53000 x24: 0000000000000000
[  161.418767] x23: 0000000000004000 x22: ffff00000f938000 x21: ffff000005bd3010
[  161.418778] x20: 0000000000008000 x19: ffff000005bd2000 x18: 0000000000000000
[  161.418789] x17: 0000000000000100 x16: 0000000000000000 x15: f44fb9a9e0200014
[  161.418799] x14: 0000000000000049 x13: 000000000000038f x12: 0000000000000000
[  161.418809] x11: 0000000000000001 x10: 0000000000000a50 x9 : ffff800082b43550
[  161.418819] x8 : ffff000000ca2830 x7 : ffff00007fb92f40 x6 : 00000007e5428bd2
[  161.418829] x5 : 03ffffffffffffff x4 : ffff0000002569c0 x3 : 0000000000000000
[  161.418839] x2 : 0000000000000001 x1 : ffff000000256810 x0 : 00000000ffffff92
[  161.418850] Call trace:
[  161.418856]  wl12xx_sdio_raw_write+0xe4/0x168 [wlcore_sdio]
[  161.418869]  wlcore_raw_write.constprop.0+0x4c/0xac [wlcore]
[  161.418931]  wlcore_boot_upload_firmware+0x140/0x3c0 [wlcore]
[  161.418973]  wl18xx_boot+0x574/0x77c [wl18xx]
[  161.419011]  wl1271_op_add_interface+0x5f0/0xaa8 [wlcore]
[  161.419052]  drv_add_interface+0x3c/0x88 [mac80211]
[  161.419228]  ieee80211_reconfig+0x1a8/0xf1c [mac80211]
[  161.419330]  ieee80211_resume+0x54/0x70 [mac80211]
[  161.419432]  wiphy_resume+0x84/0xf8 [cfg80211]
[  161.419562]  device_resume+0x84/0x178
[  161.419576]  async_resume+0x28/0x74
[  161.419584]  async_run_entry_fn+0x34/0xe0
[  161.419596]  process_one_work+0x1e0/0x340
[  161.419605]  worker_thread+0x68/0x428
[  161.419613]  kthread+0x114/0x118
[  161.419620]  ret_from_fork+0x10/0x20
[  161.419630] ---[ end trace 0000000000000000 ]---
[  161.419726] wl1271_sdio mmc2:0001:2: sdio write failed (-110)
[  162.341981] wlcore: using inverted interrupt logic: 2
[  170.553515] ------------[ cut here ]------------

[  180.315942] ieee80211 phy0: PM: dpm_run_callback(): wiphy_resume+0x0/0xf8 [cfg80211] returns -110
[  180.316090] ieee80211 phy0: PM: failed to thaw async: error -110
======================================================

Full thaw failure log -
https://gist.github.com/sukrutb/8b02a9ffa7bd1cb9fb514220e9af097e

Suggested-by: Shengyu Qu <wiagn233@outlook.com>
Signed-off-by: Sukrut Bellary <sukrut.bellary@linux.com>
---
 .../arm64/boot/dts/ti/k3-am625-beagleplay.dts | 25 ++++++++-----------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
index eadbdd9ffe37..d388c5e78658 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
@@ -83,6 +83,15 @@ wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@9db00000 {
 		};
 	};
 
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_en_pins_default>;
+		post-power-on-delay-ms = <1>;
+		power-off-delay-us = <80>;
+		reset-gpios = <&main_gpio0 38 GPIO_ACTIVE_LOW>;
+	};
+
 	vsys_5v0: regulator-1 {
 		bootph-all;
 		compatible = "regulator-fixed";
@@ -105,20 +114,6 @@ vdd_3v3: regulator-2 {
 		regulator-boot-on;
 	};
 
-	wlan_en: regulator-3 {
-		/* OUTPUT of SN74AVC2T244DQMR */
-		compatible = "regulator-fixed";
-		regulator-name = "wlan_en";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		enable-active-high;
-		regulator-always-on;
-		vin-supply = <&vdd_3v3>;
-		gpio = <&main_gpio0 38 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&wifi_en_pins_default>;
-	};
-
 	vdd_3v3_sd: regulator-4 {
 		/* output of TPS22918DBVR-U21 */
 		bootph-all;
@@ -849,7 +844,6 @@ &sdhci1 {
 };
 
 &sdhci2 {
-	vmmc-supply = <&wlan_en>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&wifi_pins_default>, <&wifi_32k_clk>;
 	bus-width = <4>;
@@ -857,6 +851,7 @@ &sdhci2 {
 	ti,fails-without-test-cd;
 	cap-power-off-card;
 	keep-power-in-suspend;
+	mmc-pwrseq = <&sdio_pwrseq>;
 	ti,driver-strength-ohm = <50>;
 	assigned-clocks = <&k3_clks 157 158>;
 	assigned-clock-parents = <&k3_clks 157 160>;
-- 
2.34.1

