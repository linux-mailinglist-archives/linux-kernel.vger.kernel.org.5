Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA6A80C46A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbjLKJYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbjLKJYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:24:00 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165C5FD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:24:07 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a1c7b20f895so487567666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702286645; x=1702891445; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wn0vmS+DlZFfx9caCjg1W7hM4xi3LW9kbH1lruHFYM8=;
        b=fhVa6+It0JMXd/jjVk0rRNBKbtb2bDM+CBXPtE0xK9LWIz4gfkYlLqpISWvP5sUC5a
         FVKGllofsmZxgxU07jN3+pQ1EliTVEBfA2xA5ntQRfqHNwf2WBg1aeda2tycVhqDkuTE
         p+mcV0CKg62EilS5HYCP2ZQQPCO/Qrjhx5j8Uvjg0DF/xTNfxGDkzJvnUt+tJAHGekAZ
         CojFa3jdqCha/sbQ6YEhIYluaqKmShlKJdyRDBVdYHlddF/S95sH7fpepAlA8x7YkhZ3
         MmS8gSFhVe3W+nRrMEtkU0yikTnWjZSclcFFjYgOSqZWY1jZ/fUhMKuq0FSYODel/clc
         Z4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702286645; x=1702891445;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wn0vmS+DlZFfx9caCjg1W7hM4xi3LW9kbH1lruHFYM8=;
        b=wSsBgEWDowtiztqjbxT1LgKEaxFjJ/2mFGzAKF48FHniCUpIE1zbXLm3xS1Hv8ohv2
         3V0xa8J3Bg+1E1eATwpB2CWQNhWkqhbZOLiGPb8cV99vKt/EnoZcr5rGTzv/7DPXtsME
         Y7o7f9J/t48uOZ8Z3n2c24yb1rer59uv/0qxUNBbp3OI6TRrEIRyPHrJJ9NynJP64Wj7
         UK2UZWiPYyITEDstXGEI0+5MjtHBHG09Yac/BoS0ubjF4oC4y3XiQqW3V/aHhwubYxRd
         U2iw/CO7JY2wBWvHlH3Hl6F8svUQOco6e7yj1hoZ5+8a/h5Ny4FX++B4rFYEB2wfHTrz
         F18A==
X-Gm-Message-State: AOJu0YzT5qkg8ItSB1f75qQzqBbCK3/tcWJj2iGN/S7kk2pSTUsoJpXm
        Q3egtvJvVTnhA5RsohG5989mxg==
X-Google-Smtp-Source: AGHT+IFw56eFBCLAYXPgrXfR+4po1IIGRgaiClklQGaZVuleC5pauurJOuMcBMmBsMTXqq1S4uSJlQ==
X-Received: by 2002:a17:906:f753:b0:a19:a1ba:8cdf with SMTP id jp19-20020a170906f75300b00a19a1ba8cdfmr1955220ejb.125.1702286645634;
        Mon, 11 Dec 2023 01:24:05 -0800 (PST)
Received: from [10.167.154.1] (178235179179.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.179])
        by smtp.gmail.com with ESMTPSA id tb21-20020a1709078b9500b009ad89697c86sm4570248ejc.144.2023.12.11.01.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 01:24:05 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 11 Dec 2023 10:23:58 +0100
Subject: [PATCH 1/2] dt-bindings: interconnect: qcom,msm8998-bwmon: Add
 SM6115 bwmon instance
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231209-topic-6115iccdt-v1-1-f62da62b7276@linaro.org>
References: <20231209-topic-6115iccdt-v1-0-f62da62b7276@linaro.org>
In-Reply-To: <20231209-topic-6115iccdt-v1-0-f62da62b7276@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702286641; l=921;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=uoFy81O4yXaBoZ14IfFvS77gswFxZ0y4ucvu/5N+9NU=;
 b=Lo7Y7n07+eqt/vVZg2bMFag6ynbxLC6bxQwLgZq1AfXMi72k7breiL3owOIJKg7oO2hudqng7
 nQA7i75Hlc2D7xUYVl7hlBzvePyoaouSEVOaWRTh60rrzfk88J/O7eZ
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SM6115 has a single BWMONv4 intance for CPU. Document it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
index a88cea732370..05067e197abe 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
@@ -30,6 +30,7 @@ properties:
               - qcom,sc7280-cpu-bwmon
               - qcom,sc8280xp-cpu-bwmon
               - qcom,sdm845-cpu-bwmon
+              - qcom,sm6115-cpu-bwmon
               - qcom,sm6350-llcc-bwmon
               - qcom,sm8250-cpu-bwmon
               - qcom,sm8550-cpu-bwmon

-- 
2.43.0

