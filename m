Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94417F2B24
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjKULAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjKULAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:00:14 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBC6E7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 03:00:10 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-32d9d8284abso3605201f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 03:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700564409; x=1701169209; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WxpSuXDoom2RWs6bn/SJPon0BVz9GrlE7SEKe7RDhZw=;
        b=tv0XEopWfREjhj9mVQy3xjtMRliBniAfh6trZ9sZCZlrpxYwROZKSd0yLqBfYpc9XO
         m7cgO2a1MWnwT9lIfJlY6JTQcpAbQ9cUapxgwUV06iNZswdHgm2Bkz7oTqSl/S+I+iHH
         YBgpSbFCUc6BhkGibB7AQbN9JJCnN6zMtv2O+0J1qIjjg8RKlBDD5kNSctcyF7huuRHk
         cdQKQFaZYnRcG27Hc1R18KOh52g9qNqa/az3cHS7xZ1Sg84Z/7PMgsCOGmm/MB4J57AW
         OP3TetSB8obbIQ+CBXzrUreVvFo9ae0AM/TCE6NJDqOMN/hr8tBH0I3sdLfjVlUhrIxz
         LnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700564409; x=1701169209;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WxpSuXDoom2RWs6bn/SJPon0BVz9GrlE7SEKe7RDhZw=;
        b=kBhSIVfifewfAkYUThaGzWGWzG7uJXfz+EeOldqw77FugAHwUAO16NVLoe0Io5X7+V
         jOfvYIiy6KCN8fC3Z9APPxo1A0Y5ua/vdzpft1bsuTq2jWlDKLdl5R0lTUAMJebIKvcR
         otosEy/VLDeY2HbFRrhFJ3OzTzwnZr7ACZOqASUjEkPK47U2TMMwhXaZCMOQLkGDMxM3
         id4wN1hqn4tUxf1/XWSaZBZ6pwRw562m5dHDP/H9o0JvMIClXs39Nmtw2+EfXlhawLkL
         KBq7Fw9ANQyGV8pv2qPqgAlYXqkYq7atIVwRYDPtBb/ftSpG2if1TRBPvHprZk05O1pR
         QLjg==
X-Gm-Message-State: AOJu0Yw6k4/OkstrL4NKPOMh9CKp81KTfkiSiFZO3DFSFMJqngUlbPnF
        Sp+wCWDa3nhVU/uDM9D7GeVftw==
X-Google-Smtp-Source: AGHT+IE6rx3KaLlnXaMX2kgktmHvy+PCtdK3K6gqwe2qTcwowExI+WZxf5wSCeAq4mnqFP8CV2i37Q==
X-Received: by 2002:a5d:5703:0:b0:32f:7f6c:72a6 with SMTP id a3-20020a5d5703000000b0032f7f6c72a6mr4993664wrv.16.1700564408809;
        Tue, 21 Nov 2023 03:00:08 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id f1-20020adff581000000b00332c0e934aasm9028500wro.44.2023.11.21.03.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 03:00:08 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 21 Nov 2023 12:00:00 +0100
Subject: [PATCH v3 1/8] dt-bindings: arm: qcom: document SM8650 and the
 reference boards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231121-topic-sm8650-upstream-dt-v3-1-db9d0507ffd3@linaro.org>
References: <20231121-topic-sm8650-upstream-dt-v3-0-db9d0507ffd3@linaro.org>
In-Reply-To: <20231121-topic-sm8650-upstream-dt-v3-0-db9d0507ffd3@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1087;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=UZ2eQGqqiWNvOpQYnbzT/mou5C8lbL9c01Zc1IvQLo0=;
 b=owEBbAKT/ZANAwAKAXfc29rIyEnRAcsmYgBlXI2zX1OUMOs6I6alDZxPKmW4LnOlXvPGdVy7JUQX
 e5PMf1eJAjIEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZVyNswAKCRB33NvayMhJ0Z1eD/
 d/ASd2RmcDdHfCxZgl49Y9CLN1cIyIrIYOvPVFjPynEe198UDFJC9V+c43r4z7tVhWiZ2UbkGff+YB
 2IREs2+Xri5Ndl4r/tu7RW+prd7APQ4BSEo/YB30zEc+/wUvRq3TqN8BsMcSH3iuSfny5O32YUT7FP
 WsFbrEFdSht9in7YNOiWE9VSPuq/DtpQ8MkyCuIvLhxtAxeczt/kCHq1zJBGwm02hxJ3zzfeZ3czZB
 04bmhAObvRbexFto5Y1PsAtqJTacTzVFS8nl5y5bvt2+/+nZcW57NJOiQxtKzIGR+rZiaj/MghynNZ
 e8TYEivrwAzl7NZnIoxfZfjJw6/qUJyvJJboToE2rL8FKV3jDdNK67TBA2wr4GQsMBZsKwrjscRIG2
 buyxzzrE9a84Gt/Vq5eWVowrZTC5DYy0nVuyG/LppJbxbgO2fmxplwnm8Idf2tKA0iBhrfSEY36esw
 K5xiidYJMzsiJpWG3Npmc8fCNey59Q3oujwen+Xrq/rhef/p5tEzfjhRqJHi9nCALvwfOAMKAJg4cG
 jSRJ+e6/PNxONKi2QIBlMlwy44CpQyLvrH8BqylUPmGwnQtb7HmMF1NWeQn/eoGMQE/Lrl4NWLNFdd
 TjirdKxcc5Hv56AIXvgaiXl8UbUpx/+nQjjoRTgJbnlI/z7f6+SjlKzB7Y
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the SM8650 SoC and based MTP (Mobile Test Platforms) and QRD
(Qualcomm Reference Device) boards.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 88b84035e7b1..c5b6518973d8 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -87,6 +87,7 @@ description: |
         sm8350
         sm8450
         sm8550
+        sm8650
 
   The 'board' element must be one of the following strings:
 
@@ -1044,6 +1045,12 @@ properties:
               - qcom,sm8550-qrd
           - const: qcom,sm8550
 
+      - items:
+          - enum:
+              - qcom,sm8650-mtp
+              - qcom,sm8650-qrd
+          - const: qcom,sm8650
+
   # Board compatibles go above
 
   qcom,msm-id:

-- 
2.34.1

