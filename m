Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBBF756001
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjGQKBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 06:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjGQKB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:01:26 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FF710D3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 03:01:18 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 725E724002A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:01:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1689588077; bh=vr3gsYDTkmHcdQXLBVcauJWuxFs06mWWDQ0zCFL/fb8=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=X/psIeoY2sKAcd0D0HavJ9jhbn0vNYmssPg8wbbZMf9ALiTIhvnLEv4PLYhfTM1Q2
         kchZ3z4wcEujm1DBxhDfOohPuRJEZGls0QAZFnko5AInONWsdewhfLamQMW2hv3Uk2
         TeDFsGwQyTxfZDLMC81NG02nfAIupV7dadcg0ktAa4M+kfV1PzaHkumgW8qjwDuroQ
         5zXrCv4ugdZLsXCf3GGc9I3IDBrJVKHGfeMGllP1oYNpJPMeKZCLPFgGUYKqDwCVCk
         T5LsV8B97DjSPDehGEh4NfP2cnAhhLdbPDA6O2toEZMW2swRUoJtWlv4y9DdmQUx5F
         Xy6Mfcps3Kt6w==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4R4HfM2t6kz6tvw;
        Mon, 17 Jul 2023 12:01:15 +0200 (CEST)
From:   Martin Kepplinger <martink@posteo.de>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v1 3/4] arm64: dts: imx8mq-librem5: Mark tps65982 as wakeup source
Date:   Mon, 17 Jul 2023 10:00:55 +0000
Message-Id: <20230717100056.4047292-4-martink@posteo.de>
In-Reply-To: <20230717100056.4047292-1-martink@posteo.de>
References: <20230717100056.4047292-1-martink@posteo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>

This allows to wake up from system suspend on USB-C plug/unplug.

Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index ab47bdc35cebd..3f251910b3949 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -796,6 +796,8 @@ typec_pd: usb-pd@3f {
 		interrupt-parent = <&gpio1>;
 		interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-names = "irq";
+		extcon = <&usb3_phy0>;
+		wakeup-source;
 
 		connector {
 			compatible = "usb-c-connector";
-- 
2.30.2

