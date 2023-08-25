Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCD3788DC9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 19:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241320AbjHYRX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 13:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239372AbjHYRXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 13:23:25 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDAD2135
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 10:23:23 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2bcb50e194dso17261751fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 10:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692984201; x=1693589001;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mnl0nfGWFMmePo5XhhTAL9r/K3CVNL4Sy0w8+CLGMTs=;
        b=ojBZNwS1tIBPfR9KCT7+DuZfHjQSi9gx057HfyL1bxEv/FVgb/xHtYFrUPPnG1m5/o
         nQrCin0K2krR+onwHEF1xgPyttEFGjDjVQHfl31FNsaloNjL+Wj049jv7JjquX6WAWVe
         xYwo7hpE+PviwbdHTkdnfdYl6dyIL0cieGDpGbxPbCAhreibBV7Crlf2wqvyqTB5wSF8
         lcsUXG8GJ1Mc0mLaWCgEnVxdqX8BqkqCydhBK/WuG1M2L382YPV+53107TVVIpRrrAw8
         S82/RFb6SczYfJA7MEDArYY43nWVvq4h1LIMnBjrAznIXJLcgHiyzdmzlWFpxtZrupLU
         mJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692984201; x=1693589001;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mnl0nfGWFMmePo5XhhTAL9r/K3CVNL4Sy0w8+CLGMTs=;
        b=dCdWfchUkSW6ZQf98j5gNUojhN8eXltRxMU1NyvwWjMaip+FSsF+c0XtdYDz2BLmFT
         C0+T7bcvKysI0xISqejdHRrncK53d3ewn5NZ7h03Paxjx4UHvxxfdy6Dkz4kYVMAdZ5G
         dzri7fcI+I0AuQ1mgS4Tg19KTRNx3yB8EDgvvmIPtcJBJY0SYVs308zuX3B/2iAK5Bq9
         ToWnajioN2IEcg37mSwoCANpw4+HD/jdfvXA7B+HRzF8MgKwmM0E67Tn2WvPvMBGtvJ4
         vLxL+sBuppZdw1Lx1zg5G5tGTGx6WDgahFsAuMLD/nF1w5kfSXKQ+hEiFPeWYJu8Ze9i
         7c8Q==
X-Gm-Message-State: AOJu0YyOI/gXodKQ+ugVTm2ctZuYrd0Ni1mPYVyjhkVTIBr6c80dmJER
        uZeihD/DIZE77h94ZSfx8PtWIw==
X-Google-Smtp-Source: AGHT+IHGRJTTur6Oz9VmbkB/HpCjN3NrWbDfAwaZ4WLBV/xsf6YFnzAq58tMlYQQ98UExDKmW3zL4w==
X-Received: by 2002:a2e:8091:0:b0:2b9:55c9:c228 with SMTP id i17-20020a2e8091000000b002b955c9c228mr14001217ljg.27.1692984201324;
        Fri, 25 Aug 2023 10:23:21 -0700 (PDT)
Received: from [192.168.1.101] (abxh59.neoplus.adsl.tpnet.pl. [83.9.1.59])
        by smtp.gmail.com with ESMTPSA id n11-20020a2e904b000000b002bcb1e1322asm407647ljg.63.2023.08.25.10.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 10:23:21 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 25 Aug 2023 19:23:12 +0200
Subject: [PATCH 1/2] ASoC: dt-bindings: qcom,lpass-tx-macro: Add SM6115
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230825-topic-6115tx-v1-1-ebed201ad54b@linaro.org>
References: <20230825-topic-6115tx-v1-0-ebed201ad54b@linaro.org>
In-Reply-To: <20230825-topic-6115tx-v1-0-ebed201ad54b@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692984198; l=1361;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=jgTjHUj7TFqcyTxVQWudplP084wTba8RuCtAcYnZkrQ=;
 b=8UXxWoH+EUI9yNwtTdYkE66s1GCSUJ75tB7slZwxx0H+ZdSdJzBgStNWBOn9OWZKoCIUSmzHj
 rWmKIH3X6UdDZPNm3LJNPzEr4K1EnBWlgjjKFbx0wKNDr3/e2s4DBNw
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

SM6115 has a TX Macro, requiring an NPL clock, but not DCODEC.
Document it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/sound/qcom,lpass-tx-macro.yaml | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
index 4156981fe02b..962701e9eb42 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
@@ -13,6 +13,7 @@ properties:
   compatible:
     enum:
       - qcom,sc7280-lpass-tx-macro
+      - qcom,sm6115-lpass-tx-macro
       - qcom,sm8250-lpass-tx-macro
       - qcom,sm8450-lpass-tx-macro
       - qcom,sm8550-lpass-tx-macro
@@ -97,6 +98,23 @@ allOf:
             - const: dcodec
             - const: fsgen
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sm6115-lpass-tx-macro
+    then:
+      properties:
+        clocks:
+          minItems: 4
+          maxItems: 4
+        clock-names:
+          items:
+            - const: mclk
+            - const: npl
+            - const: dcodec
+            - const: fsgen
+
   - if:
       properties:
         compatible:

-- 
2.42.0

