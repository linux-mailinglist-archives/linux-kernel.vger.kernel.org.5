Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7687D9A08
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346053AbjJ0NfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345996AbjJ0Ner (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:34:47 -0400
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4B9D7D
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 06:34:43 -0700 (PDT)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202310271334418c82199d957eac0fa8
        for <linux-kernel@vger.kernel.org>;
        Fri, 27 Oct 2023 15:34:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=SkXMaUVEsb4kPB44vkGq4pV31saBQG9CgbO7o0C0h+Q=;
 b=VuC0EBY5NqqqEAuLFOqledQOu/5j4czFDeXS7mTxGFAITmqK7vEz2oUXywk7tIAloME8Wa
 pzz3IKsm7VPug5qqslE1448YxV102bPdb1jWKH/IGqUGvp0Zm2P+QJeyidEQASAzErVOpkYO
 6z5j8PTu+cGvVQbG1AViTwLnOoBWU=;
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
Subject: [PATCH 6/7] arm64: dts: ti: iot2050: Add node for SPI devices on Arduino connector
Date:   Fri, 27 Oct 2023 15:34:37 +0200
Message-Id: <34ac4d465e1e51723941936c4b04b736fa85dd8b.1698413678.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1698413678.git.jan.kiszka@siemens.com>
References: <cover.1698413678.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

This interface is normally driven by userspace on the IOT2050.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
index 53bd296ba310..bc77ba58d8f9 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
@@ -1180,6 +1180,12 @@ &mcu_spi0 {
 	#address-cells = <1>;
 	#size-cells = <0>;
 	ti,pindir-d0-out-d1-in;
+
+	spidev@0 {
+		compatible = "siemens,iot2050-arduino-spi";
+		spi-max-frequency = <20000000>;
+		reg = <0>;
+	};
 };
 
 &tscadc1 {
-- 
2.35.3

