Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F0D793820
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 11:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjIFJZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 05:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236730AbjIFJZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 05:25:10 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C0B10C9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 02:25:06 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-52bcd4db4bdso4952166a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 02:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693992305; x=1694597105; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XDAh0aCllih17eVlFn1jaipFdLOlK9NfNTLcE0E+Gek=;
        b=eQhgiDckWFM2iW69fTGqU3JOxMjLP/oEjETlmkWKL6sbrDBwyWeWb7qFXbt27JN4K1
         K5Exd9GgCOAO1kKdOwp8Sz9Lkk0FbE0/4Hkb4gko8CRzHK2+6tBRmHZg6sWBiQ5wJPR0
         lRZcs6jdJNJnrJ/MvZwYzC3fhTMwnYb2N2H0EQhaRkOsXJDuKSG1mm6n2RAqxdUy+1W6
         XLOWRckAdIxQogUSF9QScEefXklrPpCvOU4gr03tcToy+k8VlhTt2ZvUj7hudEB7JvAW
         2snT4KHKtAcXuY5b6uY78TGZxWpdei6N6kBTYeYWf32UtJfeRsBG1upBsvQMhtbMNxX4
         Ycuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693992305; x=1694597105;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XDAh0aCllih17eVlFn1jaipFdLOlK9NfNTLcE0E+Gek=;
        b=LHcbYGjDlo6cXAsSsNIdgMVMzTKEdwe+N2RMQTPLw1enM3rOayKGWZ8Jl9bh4tUQzU
         qqdXSNixEZgEIxT79fbBNj5lTZg06badEeo76D+I/tFrfVeEg2uq9Aq5nZNTntLt2DRq
         UMJJE+qUDoiiT6/QCpQ2p29mFQiM3Gv8rCS5vpCOlfwWnkWJiH8AcHCgs5+RX76Eycbn
         U0WfgEIoejr8Wjho2wlIOUZQPlSmpZw6LKerWl3+1cMkp4a8pF00Mv5ZhquDnYj8K6b0
         0yieDE0Q/Z73IHGqKdVQyh7/WvVXZlVDQlTmItEYksiijP8Int5AirXVgDerZHGHCsld
         K4PQ==
X-Gm-Message-State: AOJu0YzfmQHHn+7OdC4h6Ca2fbBnm1pp8mYiW75uxER80j89WJlWlc/Z
        HEo1ins4ruOd3iKbNYHwUyVWyg==
X-Google-Smtp-Source: AGHT+IFFo+QJScmITF/zsTHhCFf8BwYb/OcZFemUtjPrr/hckmIBNoTGAzRiOkyVbW+lJx86HX6gGA==
X-Received: by 2002:aa7:dace:0:b0:525:69ec:e1c8 with SMTP id x14-20020aa7dace000000b0052569ece1c8mr1578435eds.40.1693992305071;
        Wed, 06 Sep 2023 02:25:05 -0700 (PDT)
Received: from [10.167.154.1] (178235177204.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.204])
        by smtp.gmail.com with ESMTPSA id q10-20020aa7cc0a000000b005232c051605sm8096155edt.19.2023.09.06.02.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 02:25:04 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 06 Sep 2023 11:24:59 +0200
Subject: [PATCH 5/5] arm64: dts: qcom: qrb2210-rb1: Hook up USB3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230906-topic-rb1_features_sans_icc-v1-5-e92ce6fbde16@linaro.org>
References: <20230906-topic-rb1_features_sans_icc-v1-0-e92ce6fbde16@linaro.org>
In-Reply-To: <20230906-topic-rb1_features_sans_icc-v1-0-e92ce6fbde16@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693992295; l=712;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=QbeFe51vD05DVZiBOlvsL2lYN7leouI3Bx68sEs+dDY=;
 b=xmDOXv3FY/Ud72be9WmQQ9zSBqko7R9Q8DTNzNZ8Ua/mjgwnlHSaLQ42k2pAfxYRXj0uaAuNP
 jkk5NfbwsbeCPMK8r4ok4+0kTm6ofr5uhAwqWDn95GVs0ebMCkLRXIk
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure the USB3 PHY to enable USB3 functionality

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
index fd45f58e254d..94885b9c21c8 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
@@ -409,6 +409,12 @@ &usb {
 	status = "okay";
 };
 
+&usb_qmpphy {
+	vdda-phy-supply = <&pm2250_l12>;
+	vdda-pll-supply = <&pm2250_l13>;
+	status = "okay";
+};
+
 &usb_hsphy {
 	vdd-supply = <&pm2250_l12>;
 	vdda-pll-supply = <&pm2250_l13>;

-- 
2.42.0

