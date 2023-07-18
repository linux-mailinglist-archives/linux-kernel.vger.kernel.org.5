Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959A27573CE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjGRGMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjGRGMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:12:13 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50751731
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:11:48 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6726d5d92afso3944916b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689660700; x=1692252700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aoaxiWdRTQIjlpKBPFLmbhlJ2o+zAdh4av4kyochmEo=;
        b=sn5U4MWGxnrt7DhiV2WWKv7dD7NLNlyt1BcEtCXTkOw/Uf8oIJ6PwmKIwF6FtLKPhg
         8TlIKNSQAyZVe1gfVbgEx2k8bk5LMX+QAuclX+KMIcO0NFJoSrIERmxT118aoGWjIzCc
         fUmHl4YQZsx/3es7b/IVW1UOf/2CleLxq5vu/8l6FlBARVxbuw+8O7D528NGSBVVihRd
         Pj7faOnq6na2/+UZbhmoh6Nk4yfgUZ2Qz4qtTekyyv8G6nGfu5sTfSsW2JCbSsqAzq8m
         +1gff7MypqYM5gumiG3UP0JgnJp+awXH9VN26Zp0jgZTC4al32RLzwDOhW0f4ctfmDwr
         okbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689660700; x=1692252700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aoaxiWdRTQIjlpKBPFLmbhlJ2o+zAdh4av4kyochmEo=;
        b=czk6pNfhECzoBfdpZZ9lyqCbyMWB05YI6r34PPpXsIQng+/gvxpsdnw/8yD1KmVrOf
         qw7DBDQg80npT82fqLPdDZTG3umh/OBAFJ+pJNZD9Jgg7wZXkORZLypzyiN2d+l1SmgE
         OEXUESyN6ss6PV2F69C1AJKA1sn/Hs8LoOKhh4WiEmd27ewGh8qMn8cW3M32LkC1e11t
         IC1t+nHGb4KqSdRKgWtmg7/sBnjVw/5eP0mhV9MgYZGvfmD4hTPrInQCsUdEGcEz1odN
         u3NrI1hz4tJU7xOHg16IeZMspZg7tJBrMmhk48pLFrS/aPlEGM05sC1IU8jO6tEWXomc
         yAog==
X-Gm-Message-State: ABy/qLYhiiCU/x6RGeB/OR/IqvRh/V3NIiT3TnbCdTCzC2CYS92ocWi8
        dDrcG8KPeNLg00D29c+Ze3/zFQ==
X-Google-Smtp-Source: APBJJlEjkKb95SZ3h4MhroX1z4Rb0wFQVD0acfPLpGOo6UMskxiuerWVpHUqtAwqOeu7rT87h9CrJw==
X-Received: by 2002:a05:6a20:9189:b0:12f:d350:8a12 with SMTP id v9-20020a056a20918900b0012fd3508a12mr15193455pzd.21.1689660700254;
        Mon, 17 Jul 2023 23:11:40 -0700 (PDT)
Received: from localhost.localdomain ([223.233.68.54])
        by smtp.gmail.com with ESMTPSA id h21-20020a62b415000000b0067db7c32419sm778106pfn.15.2023.07.17.23.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 23:11:39 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        quic_schowdhu@quicinc.com, gregkh@linuxfoundation.org,
        stephan@gerhold.net
Subject: [PATCH v9 7/7] arm64: dts: qcom: qrb4210-rb2: Enable EUD debug peripheral
Date:   Tue, 18 Jul 2023 11:40:52 +0530
Message-Id: <20230718061052.1332993-8-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230718061052.1332993-1-bhupesh.sharma@linaro.org>
References: <20230718061052.1332993-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

