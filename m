Return-Path: <linux-kernel+bounces-13283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE7F8202ED
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 01:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E7E22839BE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 00:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7641FCF;
	Sat, 30 Dec 2023 00:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wRqi7/e3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31C739E
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 00:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ccbbb5eb77so49512161fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 16:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703894708; x=1704499508; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8FrB087Wxc7YUxgxR36o8RYypzFH7Y/v8MFiKZG/oMY=;
        b=wRqi7/e38kjNV/EzDUt/RgHSrSgjecukZtMXqGIX47uJdmWvxyTY/8o/+31sj/r1ZH
         ZX/1h2Ti5tLzTMcJx77QGEmQVRMehUKreOHQN5Mx0HlMoN9ZxpbW3dPxwLrKrqpYXlju
         AeALO5JDAE/q+sBh3mcPymKOk6AtPMHqfUlxlJEBjpfa8yDmkBCqeDWmCpkXkGMfqppp
         FCTbWpCeY0vJHKDPNiE1MiWtwvOHq5U9FUlI5csVDyRa3HMAasFH4gDLRqXfqNqqD5VW
         VFcwaFqAZf+/JXikgP7HP1JionaMs7eCSicKFY5RqfvuMJLlPQmmjMtjgx4p8B/+T3B+
         BUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703894708; x=1704499508;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8FrB087Wxc7YUxgxR36o8RYypzFH7Y/v8MFiKZG/oMY=;
        b=hzYcrMKTyfiN5pR4l0fCfH97lURuBRNUka8l4xuKQ3HEBBbLb6/wMY33089qGt3k/1
         xR+bdGmJ5sPwE9klqTwvbsfELf1Jt4fwASMIME8y9/V9Hc5fAh2x0ue1I3eI+nzSckiE
         ZAOVS+WBObQGJs/v4CRSodc8bGgTgIoswtt35BYQDFW09NMVoEHfLetAqvTBYyc61XLD
         EdMW/TSB/ZxWjI8fXILF2GGgvaKWr1lWD2T7Rj6mQVwzX9zXtbluEAOjjlVypTA8KbxY
         77QcfVcF1335Jq/mXSbHay9yreEy7drTTgJISA7sBHlEbKyHo+nPnQQEC1juPZNRtYOH
         652w==
X-Gm-Message-State: AOJu0YyrwAf80kRMuP50u8j6onpqIdgo7GcmzzcIGslKXZ9HlkDkdEMU
	YlAhUins4BJtuBVRGVlHp71NhCV7xDS7XQ==
X-Google-Smtp-Source: AGHT+IESbUUUrskneqleCfW1B53y5DbAic4Lq+wysIajPwIXYTa484l7ZF5yNXRCtBMvbbbN8GaV2g==
X-Received: by 2002:ac2:4c4e:0:b0:50e:885d:4d1a with SMTP id o14-20020ac24c4e000000b0050e885d4d1amr2495677lfk.93.1703894707814;
        Fri, 29 Dec 2023 16:05:07 -0800 (PST)
Received: from [10.167.154.1] (178235179036.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.36])
        by smtp.gmail.com with ESMTPSA id wj6-20020a170907050600b00a26a0145c5esm8609623ejb.116.2023.12.29.16.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Dec 2023 16:05:07 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Sat, 30 Dec 2023 01:05:02 +0100
Subject: [PATCH 01/10] dt-bindings: clock: gcc-sc8180x: Add the missing CX
 power domain
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231230-topic-8180_more_fixes-v1-1-93b5c107ed43@linaro.org>
References: <20231230-topic-8180_more_fixes-v1-0-93b5c107ed43@linaro.org>
In-Reply-To: <20231230-topic-8180_more_fixes-v1-0-93b5c107ed43@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703894704; l=1455;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=EUFmaZVLsy2eKPdw1XRmfhHY9zTvCfCahSEoyNR/DAs=;
 b=I2aj2RRwuDf5hoAahsDQJFfeq4V502Q5JD7r0SaMt3xBsmDWkIWZd6hWvHdvWZwKgad5/5ihT
 tLvzdi/rb+kCweiPlNERqaQcMo5yjGj0bjq5A3JAPNayy3DAn1Xj529
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

The GCC block is (mostly) powered by the VDD_CX rail. Allow specifying
it in power-domains.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/clock/qcom,gcc-sc8180x.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sc8180x.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sc8180x.yaml
index 6c4846b34e4b..a1085ef4fd05 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-sc8180x.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sc8180x.yaml
@@ -31,10 +31,15 @@ properties:
       - const: bi_tcxo_ao
       - const: sleep_clk
 
+  power-domains:
+    items:
+      - description: CX domain
+
 required:
   - compatible
   - clocks
   - clock-names
+  - power-domains
 
 allOf:
   - $ref: qcom,gcc.yaml#
@@ -44,6 +49,7 @@ unevaluatedProperties: false
 examples:
   - |
     #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
     clock-controller@100000 {
       compatible = "qcom,gcc-sc8180x";
       reg = <0x00100000 0x1f0000>;
@@ -51,6 +57,7 @@ examples:
                <&rpmhcc RPMH_CXO_CLK_A>,
                <&sleep_clk>;
       clock-names = "bi_tcxo", "bi_tcxo_ao", "sleep_clk";
+      power-domains = <&rpmhpd SC8180X_CX>;
       #clock-cells = <1>;
       #reset-cells = <1>;
       #power-domain-cells = <1>;

-- 
2.43.0


