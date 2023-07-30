Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B41768616
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 16:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjG3OpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 10:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjG3OpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 10:45:03 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F384C10DF;
        Sun, 30 Jul 2023 07:44:59 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-98dfb3f9af6so598235266b.2;
        Sun, 30 Jul 2023 07:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690728298; x=1691333098;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qatmX1drXczyjBuXVS/Z28bd163JP+DxoLTqvpXHiNU=;
        b=f952mAznLxTvV6iW6QCfmfNJwgCqQTbRLBMyVeUS0joahGjUeOSU81YUMraF/8CdNj
         MNsI6U1cr2HjNg07581unm3Ire9d0Y1wNR/EDAT36owznBK0ITHcuRtQLPwGs/QiT0v0
         w3YPMsAlp3dYFvcjR74TKzj2zGBhSPPR118YY2uH7/QGVE5OH9xvwj0TfBgRHKyYLs5e
         s8uk/oRWLR/f+WnpKKFWq8a3hW426LymROH3ztmLabH72gK1JpcCm/+od1Uznc3RLIH6
         HXFnJahk1jU8fdWQackEAB00qf2VpUYRsF15C2g9fcAEVq0uVEs6YtziZ0R5rSEBaJt4
         jNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690728298; x=1691333098;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qatmX1drXczyjBuXVS/Z28bd163JP+DxoLTqvpXHiNU=;
        b=EyTVyqfsqwIMxuyoBBQ1W903DfKLj/I5YyFV8LtCY5TdZdO3HJD4BhOSkJFMg5BJ9n
         xWEZ3/nmz3fettqseEnwvTJt1Nv3vD18a6XqemGisAJcAQQEt/k+saWAe6FU2tSpCYBU
         rsblkpsaXQcR0+/irJ9YjJ1y/UzROqbvU3olef3n4o+u91ae2hiBjj8ttzzApERFntsE
         iDa08Ell6c27VzVoDHKpq3tk4uRONIfr/3/sGEbOTi0Lsgbrq5Zf2XOVLoxMXMfI5N1+
         AduAgid0xNXv65bt0fBq4WcUZ2gRgZYysUMVsTh8qxw7VTKlPbJVNfBZ9t3bxHQ2PQ5w
         H/pw==
X-Gm-Message-State: ABy/qLaq5O5MJja2nDA7ITP7vwTbbl03hP8M0ZPVm5UgIiHKJvH+snF1
        0SfZBr3iCHB2QWrI+hIXslE=
X-Google-Smtp-Source: APBJJlFHWXUIeLEn72XT6Fj0n6dcrBwxzkwMo7xyVvbITvmvOJK7FBjyJb7DRqgGTwKCxsk3y0OiZg==
X-Received: by 2002:a17:906:309b:b0:99b:5085:42a2 with SMTP id 27-20020a170906309b00b0099b508542a2mr5489135ejv.40.1690728298242;
        Sun, 30 Jul 2023 07:44:58 -0700 (PDT)
Received: from standask-GA-A55M-S2HP ([188.123.113.247])
        by smtp.gmail.com with ESMTPSA id kq6-20020a170906abc600b009828e26e519sm4683529ejb.122.2023.07.30.07.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 07:44:58 -0700 (PDT)
Date:   Sun, 30 Jul 2023 16:44:56 +0200
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: pinctrl: brcm,bcm11351-pinctrl: Convert to YAML
Message-ID: <ZMZ3aEnrrZRDNdO+@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Broadcom BCM281xx pin controller bindings to DT schema.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 .../pinctrl/brcm,bcm11351-pinctrl.txt         | 461 ------------------
 .../pinctrl/brcm,bcm11351-pinctrl.yaml        | 259 ++++++++++
 2 files changed, 259 insertions(+), 461 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/brcm,bcm11351-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/brcm,bcm11351-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,bcm11351-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/brcm,bcm11351-pinctrl.txt
deleted file mode 100644
index e047a198db38..000000000000
--- a/Documentation/devicetree/bindings/pinctrl/brcm,bcm11351-pinctrl.txt
+++ /dev/null
@@ -1,461 +0,0 @@
-Broadcom BCM281xx Pin Controller
-
-This is a pin controller for the Broadcom BCM281xx SoC family, which includes
-BCM11130, BCM11140, BCM11351, BCM28145, and BCM28155 SoCs.
-
-=== Pin Controller Node ===
-
-Required Properties:
-
-- compatible:	Must be "brcm,bcm11351-pinctrl"
-- reg:		Base address of the PAD Controller register block and the size
-		of the block.
-
-For example, the following is the bare minimum node:
-
-	pinctrl@35004800 {
-		compatible = "brcm,bcm11351-pinctrl";
-		reg = <0x35004800 0x430>;
-	};
-
-As a pin controller device, in addition to the required properties, this node
-should also contain the pin configuration nodes that client devices reference,
-if any.
-
-=== Pin Configuration Node ===
-
-Each pin configuration node is a sub-node of the pin controller node and is a
-container of an arbitrary number of subnodes, called pin group nodes in this
-document.
-
-Please refer to the pinctrl-bindings.txt in this directory for details of the
-common pinctrl bindings used by client devices, including the definition of a
-"pin configuration node".
-
-=== Pin Group Node ===
-
-A pin group node specifies the desired pin mux and/or pin configuration for an
-arbitrary number of pins.  The name of the pin group node is optional and not
-used.
-
-A pin group node only affects the properties specified in the node, and has no
-effect on any properties that are omitted.
-
-The pin group node accepts a subset of the generic pin config properties. For
-details generic pin config properties, please refer to pinctrl-bindings.txt
-and <include/linux/pinctrl/pinconfig-generic.h>.
-
-Each pin controlled by this pin controller belong to one of three types:
-Standard, I2C, and HDMI.  Each type accepts a different set of pin config
-properties.  A list of pins and their types is provided below.
-
-Required Properties (applicable to all pins):
-
-- pins:		Multiple strings.  Specifies the name(s) of one or more pins to
-		be configured by this node.
-
-Optional Properties (for standard pins):
-
-- function:			String. Specifies the pin mux selection. Values
-				must be one of: "alt1", "alt2", "alt3", "alt4"
-- input-schmitt-enable:		No arguments. Enable schmitt-trigger mode.
-- input-schmitt-disable:	No arguments. Disable schmitt-trigger mode.
-- bias-pull-up:			No arguments. Pull up on pin.
-- bias-pull-down:		No arguments. Pull down on pin.
-- bias-disable:			No arguments. Disable pin bias.
-- slew-rate:			Integer. Meaning depends on configured pin mux:
-				*_SCL or *_SDA:
-					0: Standard(100kbps)& Fast(400kbps) mode
-					1: Highspeed (3.4Mbps) mode
-				IC_DM or IC_DP:
-					0: normal slew rate
-					1: fast slew rate
-				Otherwise:
-					0: fast slew rate
-					1: normal slew rate
-- input-enable:			No arguments. Enable input (does not affect
-				output.)
-- input-disable:		No arguments. Disable input (does not affect
-				output.)
-- drive-strength:		Integer. Drive strength in mA.  Valid values are
-				2, 4, 6, 8, 10, 12, 14, 16 mA.
-
-Optional Properties (for I2C pins):
-
-- function:			String. Specifies the pin mux selection. Values
-				must be one of: "alt1", "alt2", "alt3", "alt4"
-- bias-pull-up:			Integer. Pull up strength in Ohm. There are 3
-				pull-up resistors (1.2k, 1.8k, 2.7k) available
-				in parallel for I2C pins, so the valid values
-				are: 568, 720, 831, 1080, 1200, 1800, 2700 Ohm.
-- bias-disable:			No arguments. Disable pin bias.
-- slew-rate:			Integer. Meaning depends on configured pin mux:
-				*_SCL or *_SDA:
-					0: Standard(100kbps)& Fast(400kbps) mode
-					1: Highspeed (3.4Mbps) mode
-				IC_DM or IC_DP:
-					0: normal slew rate
-					1: fast slew rate
-				Otherwise:
-					0: fast slew rate
-					1: normal slew rate
-- input-enable:			No arguments. Enable input (does not affect
-				output.)
-- input-disable:		No arguments. Disable input (does not affect
-				output.)
-
-Optional Properties (for HDMI pins):
-
-- function:			String. Specifies the pin mux selection. Values
-				must be one of: "alt1", "alt2", "alt3", "alt4"
-- slew-rate:			Integer. Controls slew rate.
-					0: Standard(100kbps)& Fast(400kbps) mode
-					1: Highspeed (3.4Mbps) mode
-- input-enable:			No arguments. Enable input (does not affect
-				output.)
-- input-disable:		No arguments. Disable input (does not affect
-				output.)
-
-Example:
-// pin controller node
-pinctrl@35004800 {
-	compatible = "brcm,bcm11351-pinctrl";
-	reg = <0x35004800 0x430>;
-
-	// pin configuration node
-	dev_a_default: dev_a_active {
-		//group node defining 1 standard pin
-		grp_1 {
-			pins		= "std_pin1";
-			function	= "alt1";
-			input-schmitt-enable;
-			bias-disable;
-			slew-rate	= <1>;
-			drive-strength	= <4>;
-		};
-
-		// group node defining 2 I2C pins
-		grp_2 {
-			pins		= "i2c_pin1", "i2c_pin2";
-			function	= "alt2";
-			bias-pull-up	= <720>;
-			input-enable;
-		};
-
-		// group node defining 2 HDMI pins
-		grp_3 {
-			pins		= "hdmi_pin1", "hdmi_pin2";
-			function	= "alt3";
-			slew-rate	= <1>;
-		};
-
-		// other pin group nodes
-		...
-	};
-
-	// other pin configuration nodes
-	...
-};
-
-In the example above, "dev_a_active" is a pin configuration node with a number
-of sub-nodes.  In the pin group node "grp_1", one pin, "std_pin1", is defined in
-the "pins" property.  Thus, the remaining properties in the "grp_1" node applies
-only to this pin, including the following settings:
- - setting pinmux to "alt1"
- - enabling schmitt-trigger (hystersis) mode
- - disabling pin bias
- - setting the slew-rate to 1
- - setting the drive strength to 4 mA
-Note that neither "input-enable" nor "input-disable" was specified - the pinctrl
-subsystem will therefore leave this property unchanged from whatever state it
-was in before applying these changes.
-
-The "pins" property in the pin group node "grp_2" specifies two pins -
-"i2c_pin1" and "i2c_pin2"; the remaining properties in this pin group node,
-therefore, applies to both of these pins.  The properties include:
- - setting pinmux to "alt2"
- - setting pull-up resistance to 720 Ohm (ie. enabling 1.2k and 1.8k resistors
-   in parallel)
- - enabling both pins' input
-"slew-rate" is not specified in this pin group node, so the slew-rate for these
-pins are left as-is.
-
-Finally, "grp_3" defines two HDMI pins.  The following properties are applied to
-both pins:
- - setting pinmux to "alt3"
- - setting slew-rate to 1; for HDMI pins, this corresponds to the 3.4 Mbps
-   Highspeed mode
-The input is neither enabled or disabled, and is left untouched.
-
-=== Pin Names and Type ===
-
-The following are valid pin names and their pin types:
-
-	"adcsync",		Standard
-	"bat_rm",		Standard
-	"bsc1_scl",		I2C
-	"bsc1_sda",		I2C
-	"bsc2_scl",		I2C
-	"bsc2_sda",		I2C
-	"classgpwr",		Standard
-	"clk_cx8",		Standard
-	"clkout_0",		Standard
-	"clkout_1",		Standard
-	"clkout_2",		Standard
-	"clkout_3",		Standard
-	"clkreq_in_0",		Standard
-	"clkreq_in_1",		Standard
-	"cws_sys_req1",		Standard
-	"cws_sys_req2",		Standard
-	"cws_sys_req3",		Standard
-	"digmic1_clk",		Standard
-	"digmic1_dq",		Standard
-	"digmic2_clk",		Standard
-	"digmic2_dq",		Standard
-	"gpen13",		Standard
-	"gpen14",		Standard
-	"gpen15",		Standard
-	"gpio00",		Standard
-	"gpio01",		Standard
-	"gpio02",		Standard
-	"gpio03",		Standard
-	"gpio04",		Standard
-	"gpio05",		Standard
-	"gpio06",		Standard
-	"gpio07",		Standard
-	"gpio08",		Standard
-	"gpio09",		Standard
-	"gpio10",		Standard
-	"gpio11",		Standard
-	"gpio12",		Standard
-	"gpio13",		Standard
-	"gpio14",		Standard
-	"gps_pablank",		Standard
-	"gps_tmark",		Standard
-	"hdmi_scl",		HDMI
-	"hdmi_sda",		HDMI
-	"ic_dm",		Standard
-	"ic_dp",		Standard
-	"kp_col_ip_0",		Standard
-	"kp_col_ip_1",		Standard
-	"kp_col_ip_2",		Standard
-	"kp_col_ip_3",		Standard
-	"kp_row_op_0",		Standard
-	"kp_row_op_1",		Standard
-	"kp_row_op_2",		Standard
-	"kp_row_op_3",		Standard
-	"lcd_b_0",		Standard
-	"lcd_b_1",		Standard
-	"lcd_b_2",		Standard
-	"lcd_b_3",		Standard
-	"lcd_b_4",		Standard
-	"lcd_b_5",		Standard
-	"lcd_b_6",		Standard
-	"lcd_b_7",		Standard
-	"lcd_g_0",		Standard
-	"lcd_g_1",		Standard
-	"lcd_g_2",		Standard
-	"lcd_g_3",		Standard
-	"lcd_g_4",		Standard
-	"lcd_g_5",		Standard
-	"lcd_g_6",		Standard
-	"lcd_g_7",		Standard
-	"lcd_hsync",		Standard
-	"lcd_oe",		Standard
-	"lcd_pclk",		Standard
-	"lcd_r_0",		Standard
-	"lcd_r_1",		Standard
-	"lcd_r_2",		Standard
-	"lcd_r_3",		Standard
-	"lcd_r_4",		Standard
-	"lcd_r_5",		Standard
-	"lcd_r_6",		Standard
-	"lcd_r_7",		Standard
-	"lcd_vsync",		Standard
-	"mdmgpio0",		Standard
-	"mdmgpio1",		Standard
-	"mdmgpio2",		Standard
-	"mdmgpio3",		Standard
-	"mdmgpio4",		Standard
-	"mdmgpio5",		Standard
-	"mdmgpio6",		Standard
-	"mdmgpio7",		Standard
-	"mdmgpio8",		Standard
-	"mphi_data_0",		Standard
-	"mphi_data_1",		Standard
-	"mphi_data_2",		Standard
-	"mphi_data_3",		Standard
-	"mphi_data_4",		Standard
-	"mphi_data_5",		Standard
-	"mphi_data_6",		Standard
-	"mphi_data_7",		Standard
-	"mphi_data_8",		Standard
-	"mphi_data_9",		Standard
-	"mphi_data_10",		Standard
-	"mphi_data_11",		Standard
-	"mphi_data_12",		Standard
-	"mphi_data_13",		Standard
-	"mphi_data_14",		Standard
-	"mphi_data_15",		Standard
-	"mphi_ha0",		Standard
-	"mphi_hat0",		Standard
-	"mphi_hat1",		Standard
-	"mphi_hce0_n",		Standard
-	"mphi_hce1_n",		Standard
-	"mphi_hrd_n",		Standard
-	"mphi_hwr_n",		Standard
-	"mphi_run0",		Standard
-	"mphi_run1",		Standard
-	"mtx_scan_clk",		Standard
-	"mtx_scan_data",	Standard
-	"nand_ad_0",		Standard
-	"nand_ad_1",		Standard
-	"nand_ad_2",		Standard
-	"nand_ad_3",		Standard
-	"nand_ad_4",		Standard
-	"nand_ad_5",		Standard
-	"nand_ad_6",		Standard
-	"nand_ad_7",		Standard
-	"nand_ale",		Standard
-	"nand_cen_0",		Standard
-	"nand_cen_1",		Standard
-	"nand_cle",		Standard
-	"nand_oen",		Standard
-	"nand_rdy_0",		Standard
-	"nand_rdy_1",		Standard
-	"nand_wen",		Standard
-	"nand_wp",		Standard
-	"pc1",			Standard
-	"pc2",			Standard
-	"pmu_int",		Standard
-	"pmu_scl",		I2C
-	"pmu_sda",		I2C
-	"rfst2g_mtsloten3g",	Standard
-	"rgmii_0_rx_ctl",	Standard
-	"rgmii_0_rxc",		Standard
-	"rgmii_0_rxd_0",	Standard
-	"rgmii_0_rxd_1",	Standard
-	"rgmii_0_rxd_2",	Standard
-	"rgmii_0_rxd_3",	Standard
-	"rgmii_0_tx_ctl",	Standard
-	"rgmii_0_txc",		Standard
-	"rgmii_0_txd_0",	Standard
-	"rgmii_0_txd_1",	Standard
-	"rgmii_0_txd_2",	Standard
-	"rgmii_0_txd_3",	Standard
-	"rgmii_1_rx_ctl",	Standard
-	"rgmii_1_rxc",		Standard
-	"rgmii_1_rxd_0",	Standard
-	"rgmii_1_rxd_1",	Standard
-	"rgmii_1_rxd_2",	Standard
-	"rgmii_1_rxd_3",	Standard
-	"rgmii_1_tx_ctl",	Standard
-	"rgmii_1_txc",		Standard
-	"rgmii_1_txd_0",	Standard
-	"rgmii_1_txd_1",	Standard
-	"rgmii_1_txd_2",	Standard
-	"rgmii_1_txd_3",	Standard
-	"rgmii_gpio_0",		Standard
-	"rgmii_gpio_1",		Standard
-	"rgmii_gpio_2",		Standard
-	"rgmii_gpio_3",		Standard
-	"rtxdata2g_txdata3g1",	Standard
-	"rtxen2g_txdata3g2",	Standard
-	"rxdata3g0",		Standard
-	"rxdata3g1",		Standard
-	"rxdata3g2",		Standard
-	"sdio1_clk",		Standard
-	"sdio1_cmd",		Standard
-	"sdio1_data_0",		Standard
-	"sdio1_data_1",		Standard
-	"sdio1_data_2",		Standard
-	"sdio1_data_3",		Standard
-	"sdio4_clk",		Standard
-	"sdio4_cmd",		Standard
-	"sdio4_data_0",		Standard
-	"sdio4_data_1",		Standard
-	"sdio4_data_2",		Standard
-	"sdio4_data_3",		Standard
-	"sim_clk",		Standard
-	"sim_data",		Standard
-	"sim_det",		Standard
-	"sim_resetn",		Standard
-	"sim2_clk",		Standard
-	"sim2_data",		Standard
-	"sim2_det",		Standard
-	"sim2_resetn",		Standard
-	"sri_c",		Standard
-	"sri_d",		Standard
-	"sri_e",		Standard
-	"ssp_extclk",		Standard
-	"ssp0_clk",		Standard
-	"ssp0_fs",		Standard
-	"ssp0_rxd",		Standard
-	"ssp0_txd",		Standard
-	"ssp2_clk",		Standard
-	"ssp2_fs_0",		Standard
-	"ssp2_fs_1",		Standard
-	"ssp2_fs_2",		Standard
-	"ssp2_fs_3",		Standard
-	"ssp2_rxd_0",		Standard
-	"ssp2_rxd_1",		Standard
-	"ssp2_txd_0",		Standard
-	"ssp2_txd_1",		Standard
-	"ssp3_clk",		Standard
-	"ssp3_fs",		Standard
-	"ssp3_rxd",		Standard
-	"ssp3_txd",		Standard
-	"ssp4_clk",		Standard
-	"ssp4_fs",		Standard
-	"ssp4_rxd",		Standard
-	"ssp4_txd",		Standard
-	"ssp5_clk",		Standard
-	"ssp5_fs",		Standard
-	"ssp5_rxd",		Standard
-	"ssp5_txd",		Standard
-	"ssp6_clk",		Standard
-	"ssp6_fs",		Standard
-	"ssp6_rxd",		Standard
-	"ssp6_txd",		Standard
-	"stat_1",		Standard
-	"stat_2",		Standard
-	"sysclken",		Standard
-	"traceclk",		Standard
-	"tracedt00",		Standard
-	"tracedt01",		Standard
-	"tracedt02",		Standard
-	"tracedt03",		Standard
-	"tracedt04",		Standard
-	"tracedt05",		Standard
-	"tracedt06",		Standard
-	"tracedt07",		Standard
-	"tracedt08",		Standard
-	"tracedt09",		Standard
-	"tracedt10",		Standard
-	"tracedt11",		Standard
-	"tracedt12",		Standard
-	"tracedt13",		Standard
-	"tracedt14",		Standard
-	"tracedt15",		Standard
-	"txdata3g0",		Standard
-	"txpwrind",		Standard
-	"uartb1_ucts",		Standard
-	"uartb1_urts",		Standard
-	"uartb1_urxd",		Standard
-	"uartb1_utxd",		Standard
-	"uartb2_urxd",		Standard
-	"uartb2_utxd",		Standard
-	"uartb3_ucts",		Standard
-	"uartb3_urts",		Standard
-	"uartb3_urxd",		Standard
-	"uartb3_utxd",		Standard
-	"uartb4_ucts",		Standard
-	"uartb4_urts",		Standard
-	"uartb4_urxd",		Standard
-	"uartb4_utxd",		Standard
-	"vc_cam1_scl",		I2C
-	"vc_cam1_sda",		I2C
-	"vc_cam2_scl",		I2C
-	"vc_cam2_sda",		I2C
-	"vc_cam3_scl",		I2C
-	"vc_cam3_sda",		I2C
diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,bcm11351-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/brcm,bcm11351-pinctrl.yaml
new file mode 100644
index 000000000000..90c275295199
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/brcm,bcm11351-pinctrl.yaml
@@ -0,0 +1,259 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/brcm,bcm11351-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM281xx pin controller
+
+maintainers:
+  - Florian Fainelli <florian.fainelli@broadcom.com>
+  - Ray Jui <rjui@broadcom.com>
+  - Scott Branden <sbranden@broadcom.com>
+
+allOf:
+  - $ref: pinctrl.yaml#
+
+properties:
+  compatible:
+    const: brcm,bcm11351-pinctrl
+
+  reg:
+    maxItems: 1
+
+patternProperties:
+  '-pins$':
+    type: object
+    additionalProperties: false
+
+    patternProperties:
+      '-grp[0-9]$':
+        type: object
+        unevaluatedProperties: false
+
+        properties:
+          pins:
+            description:
+              Specifies the name(s) of one or more pins to be configured by
+              this node.
+            items:
+              enum: [ adcsync, bat_rm, bsc1_scl, bsc1_sda, bsc2_scl, bsc2_sda,
+                      classgpwr, clk_cx8, clkout_0, clkout_1, clkout_2,
+                      clkout_3, clkreq_in_0, clkreq_in_1, cws_sys_req1,
+                      cws_sys_req2, cws_sys_req3, digmic1_clk, digmic1_dq,
+                      digmic2_clk, digmic2_dq, gpen13, gpen14, gpen15, gpio00,
+                      gpio01, gpio02, gpio03, gpio04, gpio05, gpio06, gpio07,
+                      gpio08, gpio09, gpio10, gpio11, gpio12, gpio13, gpio14,
+                      gps_pablank, gps_tmark, hdmi_scl, hdmi_sda, ic_dm, ic_dp,
+                      kp_col_ip_0, kp_col_ip_1, kp_col_ip_2, kp_col_ip_3,
+                      kp_row_op_0, kp_row_op_1, kp_row_op_2, kp_row_op_3,
+                      lcd_b_0, lcd_b_1, lcd_b_2, lcd_b_3, lcd_b_4, lcd_b_5,
+                      lcd_b_6, lcd_b_7, lcd_g_0, lcd_g_1, lcd_g_2, lcd_g_3,
+                      lcd_g_4, lcd_g_5, lcd_g_6, lcd_g_7, lcd_hsync, lcd_oe,
+                      lcd_pclk, lcd_r_0, lcd_r_1, lcd_r_2, lcd_r_3, lcd_r_4,
+                      lcd_r_5, lcd_r_6, lcd_r_7, lcd_vsync, mdmgpio0, mdmgpio1,
+                      mdmgpio2, mdmgpio3, mdmgpio4, mdmgpio5, mdmgpio6,
+                      mdmgpio7, mdmgpio8, mphi_data_0, mphi_data_1, mphi_data_2,
+                      mphi_data_3, mphi_data_4, mphi_data_5, mphi_data_6,
+                      mphi_data_7, mphi_data_8, mphi_data_9, mphi_data_10,
+                      mphi_data_11, mphi_data_12, mphi_data_13, mphi_data_14,
+                      mphi_data_15, mphi_ha0, mphi_hat0, mphi_hat1, mphi_hce0_n,
+                      mphi_hce1_n, mphi_hrd_n, mphi_hwr_n, mphi_run0, mphi_run1,
+                      mtx_scan_clk, mtx_scan_data, nand_ad_0, nand_ad_1,
+                      nand_ad_2, nand_ad_3, nand_ad_4, nand_ad_5, nand_ad_6,
+                      nand_ad_7, nand_ale, nand_cen_0, nand_cen_1, nand_cle,
+                      nand_oen, nand_rdy_0, nand_rdy_1, nand_wen, nand_wp, pc1,
+                      pc2, pmu_int, pmu_scl, pmu_sda, rfst2g_mtsloten3g,
+                      rgmii_0_rx_ctl, rgmii_0_rxc, rgmii_0_rxd_0, rgmii_0_rxd_1,
+                      rgmii_0_rxd_2, rgmii_0_rxd_3, rgmii_0_tx_ctl, rgmii_0_txc,
+                      rgmii_0_txd_0, rgmii_0_txd_1, rgmii_0_txd_2,
+                      rgmii_0_txd_3, rgmii_1_rx_ctl, rgmii_1_rxc, rgmii_1_rxd_0,
+                      rgmii_1_rxd_1, rgmii_1_rxd_2, rgmii_1_rxd_3,
+                      rgmii_1_tx_ctl, rgmii_1_txc, rgmii_1_txd_0, rgmii_1_txd_1,
+                      rgmii_1_txd_2, rgmii_1_txd_3, rgmii_gpio_0, rgmii_gpio_1,
+                      rgmii_gpio_2, rgmii_gpio_3, rtxdata2g_txdata3g1,
+                      rtxen2g_txdata3g2, rxdata3g0, rxdata3g1, rxdata3g2,
+                      sdio1_clk, sdio1_cmd, sdio1_data_0, sdio1_data_1,
+                      sdio1_data_2, sdio1_data_3, sdio4_clk, sdio4_cmd,
+                      sdio4_data_0, sdio4_data_1, sdio4_data_2, sdio4_data_3,
+                      sim_clk, sim_data, sim_det, sim_resetn, sim2_clk,
+                      sim2_data, sim2_det, sim2_resetn, sri_c, sri_d, sri_e,
+                      ssp_extclk, ssp0_clk, ssp0_fs, ssp0_rxd, ssp0_txd,
+                      ssp2_clk, ssp2_fs_0, ssp2_fs_1, ssp2_fs_2, ssp2_fs_3,
+                      ssp2_rxd_0, ssp2_rxd_1, ssp2_txd_0, ssp2_txd_1, ssp3_clk,
+                      ssp3_fs, ssp3_rxd, ssp3_txd, ssp4_clk, ssp4_fs, ssp4_rxd,
+                      ssp4_txd, ssp5_clk, ssp5_fs, ssp5_rxd, ssp5_txd, ssp6_clk,
+                      ssp6_fs, ssp6_rxd, ssp6_txd, stat_1, stat_2, sysclken,
+                      traceclk, tracedt00, tracedt01, tracedt02, tracedt03,
+                      tracedt04, tracedt05, tracedt06, tracedt07, tracedt08
+                      tracedt09, tracedt10, tracedt11, tracedt12, tracedt13
+                      tracedt14, tracedt15, txdata3g0, txpwrind, uartb1_ucts,
+                      uartb1_urts, uartb1_urxd, uartb1_utxd, uartb2_urxd,
+                      uartb2_utxd, uartb3_ucts, uartb3_urts, uartb3_urxd,
+                      uartb3_utxd, uartb4_ucts, uartb4_urts, uartb4_urxd,
+                      uartb4_utxd, vc_cam1_scl, vc_cam1_sda, vc_cam2_scl,
+                      vc_cam2_sda, vc_cam3_scl, vc_cam3_sda ]
+
+          function:
+            description:
+              Specifies the pin mux selection.
+            enum: [ alt1, alt2, alt3, alt4 ]
+
+          slew-rate:
+            description: |
+              Meaning depends on configured pin mux:
+                *_scl or *_sda:
+                  0: Standard (100 kbps) & Fast (400 kbps) mode
+                  1: Highspeed (3.4 Mbps) mode
+                ic_dm or ic_dp:
+                  0: normal slew rate
+                  1: fast slew rate
+                Otherwise:
+                  0: fast slew rate
+                  1: normal slew rate
+
+          bias-disable: true
+          input-disable: true
+          input-enable: true
+
+        required:
+          - pins
+
+        allOf:
+          - $ref: pincfg-node.yaml#
+
+          # Optional properties for standard pins
+          - if:
+              properties:
+                pins:
+                  contains:
+                    enum: [ adcsync, bat_rm, classgpwr, clk_cx8, clkout_0,
+                            clkout_1, clkout_2, clkout_3, clkreq_in_0,
+                            clkreq_in_1, cws_sys_req1, cws_sys_req2,
+                            cws_sys_req3, digmic1_clk, digmic1_dq, digmic2_clk,
+                            digmic2_dq, gpen13, gpen14, gpen15, gpio00, gpio01,
+                            gpio02, gpio03, gpio04, gpio05, gpio06, gpio07,
+                            gpio08, gpio09, gpio10, gpio11, gpio12, gpio13,
+                            gpio14, gps_pablank, gps_tmark, ic_dm, ic_dp,
+                            kp_col_ip_0, kp_col_ip_1, kp_col_ip_2, kp_col_ip_3,
+                            kp_row_op_0, kp_row_op_1, kp_row_op_2, kp_row_op_3,
+                            lcd_b_0, lcd_b_1, lcd_b_2, lcd_b_3, lcd_b_4, lcd_b_5,
+                            lcd_b_6, lcd_b_7, lcd_g_0, lcd_g_1, lcd_g_2, lcd_g_3,
+                            lcd_g_4, lcd_g_5, lcd_g_6, lcd_g_7, lcd_hsync,
+                            lcd_oe, lcd_pclk, lcd_r_0, lcd_r_1, lcd_r_2,
+                            lcd_r_3, lcd_r_4, lcd_r_5, lcd_r_6, lcd_r_7,
+                            lcd_vsync, mdmgpio0, mdmgpio1, mdmgpio2, mdmgpio3,
+                            mdmgpio4, mdmgpio5, mdmgpio6, mdmgpio7, mdmgpio8,
+                            mphi_data_0, mphi_data_1, mphi_data_2, mphi_data_3,
+                            mphi_data_4, mphi_data_5, mphi_data_6, mphi_data_7,
+                            mphi_data_8, mphi_data_9, mphi_data_10,
+                            mphi_data_11, mphi_data_12, mphi_data_13,
+                            mphi_data_14, mphi_data_15, mphi_ha0, mphi_hat0,
+                            mphi_hat1, mphi_hce0_n, mphi_hce1_n, mphi_hrd_n,
+                            mphi_hwr_n, mphi_run0, mphi_run1, mtx_scan_clk,
+                            mtx_scan_data, nand_ad_0, nand_ad_1, nand_ad_2,
+                            nand_ad_3, nand_ad_4, nand_ad_5, nand_ad_6,
+                            nand_ad_7, nand_ale, nand_cen_0, nand_cen_1,
+                            nand_cle, nand_oen, nand_rdy_0, nand_rdy_1,
+                            nand_wen, nand_wp, pc1, pc2, pmu_int,
+                            rfst2g_mtsloten3g, rgmii_0_rx_ctl, rgmii_0_rxc,
+                            rgmii_0_rxd_0, rgmii_0_rxd_1, rgmii_0_rxd_2,
+                            rgmii_0_rxd_3, rgmii_0_tx_ctl, rgmii_0_txc,
+                            rgmii_0_txd_0, rgmii_0_txd_1, rgmii_0_txd_2,
+                            rgmii_0_txd_3, rgmii_1_rx_ctl, rgmii_1_rxc,
+                            rgmii_1_rxd_0, rgmii_1_rxd_1, rgmii_1_rxd_2,
+                            rgmii_1_rxd_3, rgmii_1_tx_ctl, rgmii_1_txc,
+                            rgmii_1_txd_0, rgmii_1_txd_1, rgmii_1_txd_2,
+                            rgmii_1_txd_3, rgmii_gpio_0, rgmii_gpio_1,
+                            rgmii_gpio_2, rgmii_gpio_3, rtxdata2g_txdata3g1,
+                            rtxen2g_txdata3g2, rxdata3g0, rxdata3g1, rxdata3g2,
+                            sdio1_clk, sdio1_cmd, sdio1_data_0, sdio1_data_1,
+                            sdio1_data_2, sdio1_data_3, sdio4_clk, sdio4_cmd,
+                            sdio4_data_0, sdio4_data_1, sdio4_data_2,
+                            sdio4_data_3, sim_clk, sim_data, sim_det,
+                            sim_resetn, sim2_clk, sim2_data, sim2_det,
+                            sim2_resetn, sri_c, sri_d, sri_e, ssp_extclk,
+                            ssp0_clk, ssp0_fs, ssp0_rxd, ssp0_txd, ssp2_clk,
+                            ssp2_fs_0, ssp2_fs_1, ssp2_fs_2, ssp2_fs_3,
+                            ssp2_rxd_0, ssp2_rxd_1, ssp2_txd_0, ssp2_txd_1,
+                            ssp3_clk, ssp3_fs, ssp3_rxd, ssp3_txd, ssp4_clk,
+                            ssp4_fs, ssp4_rxd, ssp4_txd, ssp5_clk, ssp5_fs,
+                            ssp5_rxd, ssp5_txd, ssp6_clk, ssp6_fs, ssp6_rxd,
+                            ssp6_txd, stat_1, stat_2, sysclken, traceclk,
+                            tracedt00, tracedt01, tracedt02, tracedt03,
+                            tracedt04, tracedt05, tracedt06, tracedt07,
+                            tracedt08, tracedt09, tracedt10, tracedt11,
+                            tracedt12, tracedt13, tracedt14, tracedt15,
+                            txdata3g0, txpwrind, uartb1_ucts, uartb1_urts,
+                            uartb1_urxd, uartb1_utxd, uartb2_urxd, uartb2_utxd,
+                            uartb3_ucts, uartb3_urts, uartb3_urxd, uartb3_utxd,
+                            uartb4_ucts, uartb4_urts, uartb4_urxd, uartb4_utxd ]
+            then:
+              properties:
+                drive-strength:
+                  enum: [ 2, 4, 6, 8, 10, 12, 14, 16 ]
+
+                bias-disable: true
+                bias-pull-up: true
+                bias-pull-down: true
+                input-schmitt-enable: true
+                input-schmitt-disable: true
+
+          # Optional properties for I2C pins
+          - if:
+              properties:
+                pins:
+                  contains:
+                    enum: [ bsc1_scl, bsc1_sda, bsc2_scl, bsc2_sda, pmu_scl,
+                            pmu_sda, vc_cam1_scl, vc_cam1_sda, vc_cam2_scl,
+                            vc_cam2_sda, vc_cam3_scl, vc_cam3_sda ]
+            then:
+              properties:
+                bias-pull-up:
+                  description:
+                    There are 3 pull-up resistors (1.2k, 1.8k, 2.7k) available
+                    in parallel for I2C pins.
+                  enum: [ 568, 720, 831, 1080, 1200, 1800, 2700 ]
+
+                bias-disable: true
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pinctrl@35004800 {
+      compatible = "brcm,bcm11351-pinctrl";
+      reg = <0x35004800 0x430>;
+
+      dev-a-active-pins {
+        /* group node defining 1 standard pin */
+        std-grp0 {
+          pins = "gpio00";
+          function = "alt1";
+          input-schmitt-enable;
+          bias-disable;
+          slew-rate = <1>;
+          drive-strength = <4>;
+        };
+
+        /* group node defining 2 I2C pins */
+        i2c-grp0 {
+          pins = "bsc1_scl", "bsc1_sda";
+          function = "alt2";
+          bias-pull-up = <720>;
+          input-enable;
+        };
+
+        /* group node defining 2 HDMI pins */
+        hdmi-grp0 {
+          pins = "hdmi_scl", "hdmi_sda";
+          function = "alt3";
+          slew-rate = <1>;
+        };
+      };
+    };
+...
-- 
2.34.1

