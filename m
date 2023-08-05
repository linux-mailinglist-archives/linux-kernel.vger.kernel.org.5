Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A4D7711E9
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 21:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjHETqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 15:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHETqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 15:46:16 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE071735;
        Sat,  5 Aug 2023 12:46:14 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 375Jjw4S119004;
        Sat, 5 Aug 2023 14:45:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691264758;
        bh=CdhQuWo9ujaCpg9RHjcoZQ/AvoBB7wleNs6Mpq6ktyg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=KU0VmzWRSoVMVYBEjZlI84Xg60/BTRvd5Nzj0x9YVEMKl3jsuI9p12gnNSVfItPsr
         k70MWaN+vgKyfVD8rXAci0qP+LZOzGVpZ4wDI23686d0dXzP82o/RCjBxNvu833KSZ
         qfjO1X57YtGuXvSsmco76mxf1nkt7X6RH6BgkEp0=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 375JjwSD026423
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 5 Aug 2023 14:45:58 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 5
 Aug 2023 14:45:58 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 5 Aug 2023 14:45:58 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 375Jjvx4025732;
        Sat, 5 Aug 2023 14:45:58 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Andrew Davis <afd@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] arm64: dts: ti: k3-am62a: Remove syscon compatible from epwm_tbclk
Date:   Sat, 5 Aug 2023 14:45:57 -0500
Message-ID: <169126415606.84898.18424472511177398578.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230802174521.236255-1-afd@ti.com>
References: <20230802174521.236255-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew Davis,

On Wed, 02 Aug 2023 12:45:19 -0500, Andrew Davis wrote:
> The other instances have been fixed, but AM62a seems to have been missed,
> fix this here.
> 

The merging of two conf nodes:

I understand the linux-next dependency, it does create a dtbs_check
warnings on rc1, but I am picking this up since the yaml fixup is in
next already and not a new compatible addition. if the fixups does'nt
end up in linus-master for 6.6-rc1, we might need to look at what we
need to do. Please let me know if there is any concerns and I can drop
this series from my tree.

For the tbclk node name fix up:

I also noticed there were two other places we needed the fix as well,
since they were trivial, I rolled up [2] as part of the patch #3. if
you think the fixup should be done differently, let me know and I can
drop the series from my tree and we can pick a new series up.

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/3] arm64: dts: ti: k3-am62a: Remove syscon compatible from epwm_tbclk
      commit: b9d801dbb2d5cb796dce32ffcee63fba83f72841
[2/3] arm64: dts: ti: k3-am64: Merge the two main_conf nodes
      commit: a57ba56bca42fa484bec916f7a88a3dc03d6cbdf
[3/3] arm64: dts: ti: k3: Fix epwm_tbclk node name to generic name
      commit: 085baaa7084e39a63d72db86821c6fb65bdbff72

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
[2]
diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 33b6aadc9083..ef90b2bc81eb 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -55,7 +55,7 @@ phy_gmii_sel: phy@4044 {
 			#phy-cells = <1>;
 		};
 
-		epwm_tbclk: clock@4130 {
+		epwm_tbclk: clock-controller@4130 {
 			compatible = "ti,am62-epwm-tbclk";
 			reg = <0x4130 0x4>;
 			#clock-cells = <1>;
diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 350beddc3d3c..d08f086d7d01 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -502,7 +502,7 @@ dss_oldi_io_ctrl: dss-oldi-io-ctrl@41e0 {
 			reg = <0x000041e0 0x14>;
 		};
 
-		ehrpwm_tbclk: clock@4140 {
+		ehrpwm_tbclk: clock-controller@4140 {
 			compatible = "ti,am654-ehrpwm-tbclk";
 			reg = <0x4140 0x18>;
 			#clock-cells = <1>;
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

