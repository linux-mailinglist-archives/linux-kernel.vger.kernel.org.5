Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467727E293A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbjKFP7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 10:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjKFP7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:59:46 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFC010A;
        Mon,  6 Nov 2023 07:59:43 -0800 (PST)
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A40796607480;
        Mon,  6 Nov 2023 15:59:40 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699286380;
        bh=gejreQ+R9N2hJNUtlzdmP6zPO2yp/PwNztMCU8VlSv8=;
        h=From:To:Cc:Subject:Date:From;
        b=TQrVvo8FtPx4X+auY9pRUHOY8SmbEDkVy/Hln6yrSqgNGGmLm8PnqlPwC+psKg/83
         irPrR5WsSe8u7THcvK06CU36U6dGE2IH97ugNTwpdDwckTB1Aqe/WdVVKUrIhMifps
         t4SwNc7GNURa4sUJ0zdprH6HELb9YUVBNo/SLaACpjQFSTDzC5W2JDRsRtxT+TYKWb
         KLCOkkjaBDR2V2Jqhihh2uNXZ7TGnY4J9v+WBmy0HLSnQnvnCMhjcUCSmOmZ8uFl1G
         O5uNMYeh/UuOtNjuJHe1A0+k9MHMNE0GxhkNcIW4PE1gRb3PwYV2KFg2HR6dUVa4fM
         bauQJxG5wDflA==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 96BF348011C; Mon,  6 Nov 2023 16:59:37 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v1 1/2] arm64: dts: rockchip: add USB3 host to rock-5b
Date:   Mon,  6 Nov 2023 16:54:31 +0100
Message-ID: <20231106155934.80838-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable USB3 host controller for the Radxa ROCK 5 Model B. This adds
USB3 for the upper USB3 port (the one further away from the PCB).

The lower USB3 and the USB-C ports use the RK3588 USB TypeC host
controller, which use a different PHY without upstream support.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index 741f631db345..61b937beca7f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -138,6 +138,10 @@ &combphy1_ps {
 	status = "okay";
 };
 
+&combphy2_psu {
+	status = "okay";
+};
+
 &cpu_b0 {
 	cpu-supply = <&vdd_cpu_big0_s0>;
 };
@@ -765,3 +769,7 @@ &usb_host1_ehci {
 &usb_host1_ohci {
 	status = "okay";
 };
+
+&usb_host2_xhci {
+	status = "okay";
+};
-- 
2.42.0

