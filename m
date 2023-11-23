Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9427F5ECF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 13:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345237AbjKWMN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 07:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345215AbjKWMNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 07:13:24 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92FC11F;
        Thu, 23 Nov 2023 04:13:29 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-548f74348f7so1150907a12.2;
        Thu, 23 Nov 2023 04:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700741608; x=1701346408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lEDS1xDbHv2bX/Af0XP8lgFHd9wrBccG/R9qGzxmb30=;
        b=LtfsVzEL+U6XXigthT3aNp6Dgr7jKM8OB7M4GTmpLZ8Z9FdKdDFEJsvbQ3ZEtnGVBS
         mbK72HEKfwgpOkcfF6CI8UlMcjhEar4lu+7KhNQI8p3sa0whF74adPNFqF7aBk9ZnIRT
         xahxzEcInPRjNtIE+gQ3X47gsQ4d4iAkV158wLJ7A+laPHZ+OXTwU1o6kmC3gwf6VLZE
         xeUJjbne6lwbcIQTuLreoXEAsNl82zhlckgGQQ1s2RGWYtTURg/42oRD6izDRY0F0m96
         WPguEbNk78vmNc8dBdXRJK3XiUBZRrc29vuGgnCAqMTttsF1/N9zpW52c5HT4Y6uuvew
         Ipxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700741608; x=1701346408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lEDS1xDbHv2bX/Af0XP8lgFHd9wrBccG/R9qGzxmb30=;
        b=Qzg/6IUz2Ot3g8hoLeNguvPX+meoRJghFxbEhhcgw8FC6XB+j+5PMEGZ+wGMttm4VC
         Q00Krtuv4kOiPabBtCIHJrC+qedZbM3bTouRQ/N5hZ3yR9Mv0InEfLN5CVnLViv3uFMG
         XzsTpffeqBHLBpfx+4VPWe+n9TnK4pbO6OJKnBDyJp2UV2N77fE7kqoUGp20bmg2rrBn
         2pNMVCuPN04CsvVrWbK+NoUVEceptFux8k04X4UUJRCq4gCJLCMk9bTNw2Y99NL3GxK9
         /1qADfAad84Ut+OT5Emg0T4lPDyJpGI7dnBESWL3MVc1Y4MFvT3Wx5iGqm3ZVk/5SeyG
         wOFw==
X-Gm-Message-State: AOJu0YxwxjyRRDn7WJoA7aWrw0aj7ICcwdEHU/MCVE3QZl0y93h5qhGr
        aKAr5KZ+3UfC8dJE4g2nHoTRAPcMtMM=
X-Google-Smtp-Source: AGHT+IFU08KnhdZcRouB/Uhp9IfkcPQcB/iEiRn39XYcoO3ubI7l6bxVHt4kxeSzgbITJsxT8WP31Q==
X-Received: by 2002:aa7:d9d5:0:b0:548:89b7:f590 with SMTP id v21-20020aa7d9d5000000b0054889b7f590mr4373603eds.35.1700741608161;
        Thu, 23 Nov 2023 04:13:28 -0800 (PST)
Received: from fedora.. (dh207-99-119.xnet.hr. [88.207.99.119])
        by smtp.googlemail.com with ESMTPSA id by10-20020a0564021b0a00b0054868b36118sm580678edb.32.2023.11.23.04.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 04:13:27 -0800 (PST)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH] arm64: dts: qcom: ipq8074: Add QUP4 SPI node
Date:   Thu, 23 Nov 2023 13:12:54 +0100
Message-ID: <20231123121324.1046164-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add node to support the QUP4 SPI controller inside of IPQ8074.
Some devices use this bus to communicate to a Bluetooth controller.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index d8e8a5cded64..1b9e50edc892 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -744,6 +744,20 @@ blsp1_i2c3: i2c@78b7000 {
 			status = "disabled";
 		};
 
+		blsp1_spi4: spi@78b8000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x78b8000 0x600>;
+			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_QUP4_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp_dma 18>, <&blsp_dma 19>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
 		blsp1_i2c5: i2c@78b9000 {
 			compatible = "qcom,i2c-qup-v2.2.1";
 			#address-cells = <1>;
-- 
2.42.0

