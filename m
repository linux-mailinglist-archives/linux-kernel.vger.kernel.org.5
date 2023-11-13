Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545617E9866
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 09:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbjKMI5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 03:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233337AbjKMI4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 03:56:45 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74341707
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 00:56:33 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9bf86b77a2aso617118066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 00:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1699865792; x=1700470592; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CynjfYwQt6yEjM2yMQy6bc2CWbjcfVhAVfgPHtrn8R0=;
        b=Ku1rR5ZhiViLtyprrjrTUYU/pwAIWbiBblbUoveMhq0Gav3fTkKl40O+0oo/8bL0jc
         hxTI9TzpJR7T8iq8UsTLKOzYdL5SfuKmdEZEzbLN6x12RRg3hUnVuizptErlSJUnE0Ec
         eXLTX+bBN0VO2pYUlv1+PPb0EyvJITBtq/rRfZSZZxtLkQjPDHdMHhoWnw3ff9Ggkf4X
         dEeyMTVuSb4JqzCriVzWxYBDxn1iXtMhfFsZskRfel4dGpoqO/HrlgYfzCa8wwVGlZCw
         aJLx+mesUN9M1/NmAQ7bdJTntxpI5jqQIBrn03aGD+5zQGUXhbdEyhFM2hRMUiMg625X
         o99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699865792; x=1700470592;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CynjfYwQt6yEjM2yMQy6bc2CWbjcfVhAVfgPHtrn8R0=;
        b=HJzxiOSRPN6dq8Svd0epXFHRGFX8J2ROV041N9moxg84JEzaLfukAsLg48icZy1e4W
         2X7wCF3lBWlZECyISNhSyI/KEFRYwLsaBTrBBwFBteMU8/YIvxa2TkuPJ2Stw2LgDbQe
         4en2mlvD01UkIbaHhwNKYVbWHTV9WtGxmOx5eC7/3ONl2T67pzmR+1+NORKRuQKaQl5q
         bq+DO9oYl7EF5zYqdKO7pZuU3Evtn6JF41b6NYS7uSd7PyiVolZhidFThpDQ9ON94iYT
         Hdwkm+xMaGNLCmJFmcD5HfrDXG37t0pQtOQIYYrq1WOz4y1SJQH2wRN3N8MBNHuTy6JN
         PRfQ==
X-Gm-Message-State: AOJu0Yx2JCZIVIKRE7XcTMPOX0nRgefJ9Z3NAld5MHOEAm021AWxg/Yv
        Hlado4hPs0cnE5tCm9kD5Sim4DLwUkloPxlEZeL+Xw==
X-Google-Smtp-Source: AGHT+IE+1B70iakds+oKGTWbH2CVf5IC+VLEh7U7CdAMgRj38n4ZGWVR76woo6mU73f3DDL36Oe23w==
X-Received: by 2002:a17:907:76d0:b0:9ae:7502:7d30 with SMTP id kf16-20020a17090776d000b009ae75027d30mr3389089ejc.57.1699865792415;
        Mon, 13 Nov 2023 00:56:32 -0800 (PST)
Received: from otso.luca.vpn.lucaweiss.eu (k10064.upc-k.chello.nl. [62.108.10.64])
        by smtp.gmail.com with ESMTPSA id kk22-20020a170907767600b009c758b6cdefsm3673538ejc.128.2023.11.13.00.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 00:56:32 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Mon, 13 Nov 2023 09:56:21 +0100
Subject: [PATCH v2 10/11] arm64: dts: qcom: qcm6490-fairphone-fp5: Enable
 various remoteprocs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231113-sc7280-remoteprocs-v2-10-e5c5fd5268a7@fairphone.com>
References: <20231113-sc7280-remoteprocs-v2-0-e5c5fd5268a7@fairphone.com>
In-Reply-To: <20231113-sc7280-remoteprocs-v2-0-e5c5fd5268a7@fairphone.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?utf-8?q?Matti_Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the ADSP, CDSP, MPSS and WPSS that are found on the SoC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
index 77ba05b77d68..307062c1a0cb 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
@@ -470,6 +470,26 @@ &qupv3_id_1 {
 	status = "okay";
 };
 
+&remoteproc_adsp {
+	firmware-name = "qcom/qcm6490/fairphone5/adsp.mbn";
+	status = "okay";
+};
+
+&remoteproc_cdsp {
+	firmware-name = "qcom/qcm6490/fairphone5/cdsp.mbn";
+	status = "okay";
+};
+
+&remoteproc_mpss {
+	firmware-name = "qcom/qcm6490/fairphone5/modem.mbn";
+	status = "okay";
+};
+
+&remoteproc_wpss {
+	firmware-name = "qcom/qcm6490/fairphone5/wpss.mbn";
+	status = "okay";
+};
+
 &sdc2_clk {
 	drive-strength = <16>;
 	bias-disable;

-- 
2.42.1

