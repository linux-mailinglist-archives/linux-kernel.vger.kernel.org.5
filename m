Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6572B756003
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjGQKBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 06:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjGQKB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:01:27 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B999B19C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 03:01:22 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 64C4E240104
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:01:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1689588079; bh=T9HVwP+zel2OrTfBZon8ZQ3bTW0P6nUFFyAK92/ZpSM=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=bKx9bU8yECOmaTFy5+usgdOCQoq0QRtIFy157sc9djgGgSim5HlmLVDFqEwbPrWc/
         e99o6Esvdw0rN+s/ejw8NtTSlJNlXlr0skhnmwEY/TxkMlea9yq4JU0jamfK/QDX5d
         EtitHzdE0b+4LErWz9TYNCqYsH+Nuq960pLfubmxaI78PAxDWVQA5OE39N8xVBIHlp
         wFdQEWV692HsTtzlsO6emduhvaQyiDgbjnsYjgzzGl1G83aNdVt2fgxmm9ZoQT/5SM
         Jk14TqF+9KY0fByIkWANUg8DxqW48v2+CjHW3AAkGqLxiKxeBs1W3/t5MbMjUrOUBi
         jkM02M92o6WfQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4R4HfN6Hqpz6twY;
        Mon, 17 Jul 2023 12:01:16 +0200 (CEST)
From:   Martin Kepplinger <martink@posteo.de>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v1 4/4] arm64: dts: imx8mq-librem5: Reduce usdhc2's post-power-on-delay-ms to 20ms
Date:   Mon, 17 Jul 2023 10:00:56 +0000
Message-Id: <20230717100056.4047292-5-martink@posteo.de>
In-Reply-To: <20230717100056.4047292-1-martink@posteo.de>
References: <20230717100056.4047292-1-martink@posteo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>

This appears to be enough for both Redpine and SparkLAN cards.
Waiting for too long makes us waste time in resume from system
suspend, so let's keep it as short as possible.

Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index 3f251910b3949..e329c29f3f1c6 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -1394,7 +1394,7 @@ &usdhc2 {
 	bus-width = <4>;
 	vmmc-supply = <&reg_wifi_3v3>;
 	mmc-pwrseq = <&usdhc2_pwrseq>;
-	post-power-on-delay-ms = <1000>;
+	post-power-on-delay-ms = <20>;
 	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
 	max-frequency = <100000000>;
 	disable-wp;
-- 
2.30.2

