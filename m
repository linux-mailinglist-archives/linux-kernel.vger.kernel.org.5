Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563C875608A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjGQKdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 06:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjGQKde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:33:34 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F191BD2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 03:33:14 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b8b318c5cfso34330955ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 03:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689589992; x=1692181992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aoaxiWdRTQIjlpKBPFLmbhlJ2o+zAdh4av4kyochmEo=;
        b=g519a+G7tOuP5AGM99e4AMmxik1Mq8hK7gBhqN7FfI+fi/u8RiwEdZteCyakYGYPp6
         LSJRF5Km6sXgyIAlc90wqM1qSPKCKc+H3LTr9jpdfZwmbJEbEka5ynRujS7NNNEB1CoS
         WHVeD8s+JTtarzKaGi2LDeJU8uJKCpuRSm9DJp142XsIcjzRrRByl9XNuIlqcYjHLsSI
         w8EoI4s1yeYtJRXOsfuf3TyVwtvx8DNZhLTifve1u6pdFo+iv8eD02apBZJqGs4Bedkk
         OGkhqV1yml1BoYdBsrB8DRKy9k7pjQH+j+nacouB8lEz7suiSGB2L70kIZ1ouOXOgALy
         ITPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689589992; x=1692181992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aoaxiWdRTQIjlpKBPFLmbhlJ2o+zAdh4av4kyochmEo=;
        b=CSfCLU7Zt/0Eb6yDGODF0bJsbxj8KxrrjpVwiFfpOG2Mi7djgIGxTHFO7Fg3Gm4oyS
         T+/wzndDQoGI/mIKMstlJKb522TmyS/eg7WXxoN2PFj6n7lEc1H6jfY2p2kUBs3z2mJR
         6QrlBZLfEjr2OZoiFcBIiG/HC11k39D2aVPZmF9jSoKfaQZ3xMVjj+LRfGh1VkVWkv8R
         f0GtB37GZTnWMOqdcxW9UUwavSlsWE9rdT4RAD3TFak2XFBoioJ5Yk9EUFE1G46c9t/0
         qgmZt9HOjBhyHVTWw4MbNkEZX2cozH1KjIBkz9Wvlcl1w4LfoCPRxGFzNJ0uab8r5ld2
         rnIQ==
X-Gm-Message-State: ABy/qLaMeEH3rtM87TPUaKk2t45+/H8Rk0tApA0B2C2o8PeX/hZxEq2F
        5JMQLKZH1mSv9lk7sCloRS5oMg==
X-Google-Smtp-Source: APBJJlGxjHTy27oHzebTb158x0c33RIuQvSDpQ/GYL/rSpU/c05I0WJAE/sHlYsRZQIMLM7KbWO+Tg==
X-Received: by 2002:a17:902:9347:b0:1b8:a12e:d655 with SMTP id g7-20020a170902934700b001b8a12ed655mr1968934plp.11.1689589991826;
        Mon, 17 Jul 2023 03:33:11 -0700 (PDT)
Received: from localhost.localdomain ([223.233.68.54])
        by smtp.gmail.com with ESMTPSA id ij9-20020a170902ab4900b001b9de67285dsm12633616plb.156.2023.07.17.03.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 03:33:11 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        quic_schowdhu@quicinc.com, gregkh@linuxfoundation.org
Subject: [PATCH v8 4/4] arm64: dts: qcom: qrb4210-rb2: Enable EUD debug peripheral
Date:   Mon, 17 Jul 2023 16:02:36 +0530
Message-Id: <20230717103236.1246771-5-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230717103236.1246771-1-bhupesh.sharma@linaro.org>
References: <20230717103236.1246771-1-bhupesh.sharma@linaro.org>
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

Since the USB-C type port on the Qualcomm QRB4210-RB2 board
can be set primarily in a 'device' configuration (with the default
DIP switch settings), it makes sense to enable the EUD debug
peripheral on the board by default by setting the USB 'dr_mode' property
as 'otg'.

Now, the EUD debug peripheral can be enabled by executing:
 $ echo 1 > /sys/bus/platform/drivers/qcom_eud/1610000.eud/enable

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 27 +++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
index a7278a9472ed9..640668960deb0 100644
--- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
+++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
@@ -264,6 +264,10 @@ &pon_resin {
 	status = "okay";
 };
 
+&eud {
+	status = "okay";
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
@@ -518,7 +522,28 @@ &usb {
 
 &usb_dwc3 {
 	maximum-speed = "super-speed";
-	dr_mode = "peripheral";
+
+	/*
+	 * There is only one USB DWC3 controller on QRB4210 board and it is connected
+	 * via a DIP Switch:
+	 * - to either an USB - C type connector or an USB - A type connector
+	 *   (via a GL3590-S hub), and
+	 * - to either an USB - A type connector (via a GL3590-S hub) or a connector
+	 *   for further connection with a mezzanine board.
+	 *
+	 * All of the above hardware muxes would allow us to hook things up in
+	 * different ways to some potential benefit for static configurations (for e.g.
+	 * on one hand we can have two USB - A type connectors and a USB - Ethernet
+	 * connection available and on the other we can use the USB - C type in
+	 * peripheral mode).
+	 *
+	 * Note that since the USB - C type can be used only in peripehral mode,
+	 * so hardcoding the mode to 'peripheral' here makes sense.
+	 *
+	 * However since we want to use the EUD debug device, we set the mode as
+	 * 'otg' here.
+	 */
+	dr_mode = "otg";
 };
 
 &usb_hsphy {
-- 
2.38.1

