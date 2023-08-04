Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2AAB770243
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjHDNu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbjHDNuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:50:22 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFFB171D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 06:50:20 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbea14706eso20185145e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 06:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691157019; x=1691761819;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LoLk+hOHQDH/7cn6RwtpMRmNp0rfp4NE+LThM4ovVo0=;
        b=Iq73nhf26djD0Az8ZfElTDbIqxiANOI/S79ud6Rz6kFZ+9WawtYNfzFUX3Y21uly+p
         ZwN+JLJP8y+9lcy8AHyT8OZIR5I2B62iMHXaA040bDOhYkEyert2J84xX7Laqp6Tsd/K
         biA/jkQ6JbhDXfIaOhlTWrx1LYaGwj9kU88iIOc9yBWeIucueW0rqhG+jXUWk4MR5X2w
         Uxe+f26YAATez92uwPNWtzMARfl1/bSYYhg5CsZ2V2RMvFZ/YiobO92qTy5etAXli/h7
         PI/C4U8t9SHevcbCYS5H8ZNLEQlTqSRzZEpCClptA2yGjbIhuHFhJxCCcClFDEmSR/Eo
         xdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691157019; x=1691761819;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LoLk+hOHQDH/7cn6RwtpMRmNp0rfp4NE+LThM4ovVo0=;
        b=jSBT2FmbabSlC0dYKWUezbQPOLwoO7jrOpOM5vf6EkS3jIybQcGf98TdhwEiX31YwL
         ISeCSefsyXMGxPAjxuSv+jRX9rJupuHy5NvB1SyqwTk9GLKyqfKfI+5MGCGRxvfxq/Jw
         gwmBRDeZQBTM0aLgUxu7SzkLlmU8J6q330sJceYRwU3WVwReiBn89k6IM7U1yBCkiq7z
         Ta95WfyNnFvxfja9bpD4C1Y3p+Ue1jLe+Vxe6/RoqLX3PWId5wBz3KQhHt+QhyAtvpBO
         zJOWff7EvRlMcALgPYhhBDoGtjPWyfC4KNVJ2tbIrJ4URg3Dm6dD3co8Y0Na/iBptn+U
         IJjQ==
X-Gm-Message-State: AOJu0YwQa+EbPBh79dffji5ZlJb1WJfzIFpdSKx7cxySarbj8iIMascy
        Mh6XZMsqlhn947PzeXwPqkE7T+V9RRV0/ZTcpWw+jA==
X-Google-Smtp-Source: AGHT+IHa3+bma9AUYcnhJNVyKIfX2dChvnPV6M/GXAV5okgMM/j1KmkdeHWmt1vH+sKaMpIN2Qd1jQ==
X-Received: by 2002:a7b:cc99:0:b0:3fb:dbd0:a7ea with SMTP id p25-20020a7bcc99000000b003fbdbd0a7eamr1539381wma.37.1691157019189;
        Fri, 04 Aug 2023 06:50:19 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id u25-20020a7bcb19000000b003fe1cac37d8sm6894793wmj.11.2023.08.04.06.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 06:50:18 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 04 Aug 2023 15:50:07 +0200
Subject: [PATCH 1/4] dt-bindings: soc: qcom: qcom,pmic-glink: add a gpio
 used to determine the Type-C port plug orientation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230804-topic-sm8550-upstream-type-c-orientation-v1-1-36dd3edec7bf@linaro.org>
References: <20230804-topic-sm8550-upstream-type-c-orientation-v1-0-36dd3edec7bf@linaro.org>
In-Reply-To: <20230804-topic-sm8550-upstream-type-c-orientation-v1-0-36dd3edec7bf@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1566;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=OqwjDDJ6wXxzZ/R9TLS3ZhkzX5nrKiThYc8EEj79dbY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkzQIXBfNNLcv9KzFJsuw/TYIGvMdCbOuI5stAXHtn
 +iuwmG2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZM0CFwAKCRB33NvayMhJ0SD4D/
 wLoVGn84hF58XjNA6hMQ+niD52vUKxV3oWhqEbVSf5B9XhAJWlMsqoWkaHQkIOEj8IYyhjLTqq8bOt
 8cMZ9p8l/tkGTB58R38iljZ7w/e+QsP8HXMzqz3QA8NQq9rdZBxqLBxpBarzyRGuZ2KChKo6zoBCHH
 TTUyI6N9dSaANs/sJAIAmEFgf3tcth15yHiifaRJa/TCUE92ClKTLBiq4wSsTIlNZR1Z9HZ+WLCeEq
 W+YmTGd0IbR37qQRLDzA8HmPinbn3igo61Msiy4wtrBckd1u/lUJF9IGX4T1r74DxPoNa1Ob3Nsvi8
 srVxoiwRiIzClcDt3fVj+rt4zIOCpjZaipE62s8pFlz2DlNwUkznvJJaUobVJnNZMnYm1VdtpjBJsw
 Rgjkr4Gp9vbf2viS+3BJFNRSDoT+WAmaacJ44YnmRqJxogTt3wOHutBj5k+KCttwL4bZVT13D8d/ju
 k9asVHXTOPSn+QaB+IAbEgBZpz+Mil0+dbYdBEi4sjON3+KlXwtw1TQsnwt2IIyqmSVjdLRDXe8E1N
 TvI0B+oytZ5MJuf3kxEukNX/0Fr3jJonuKpEqGuqnFEOcTcOHoY89WkSsSD/H4P1ODn3BrkBkDr5Cb
 Eczr48YD/vkVtT25EW1Ov8RWWwmnOPpthwPJSB22C5QKmLi41qqiC8dD2MXw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On SM8450 and SM8550 based platforms, the Type-C plug orientation is given on a
GPIO line set by the PMIC.

Document this optional Type-C connector property, and take the
assumption an active level represents an inverted/flipped orientation.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml  | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
index bceb479f74c5..1b0a00b19a54 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
@@ -35,6 +35,11 @@ properties:
   '#size-cells':
     const: 0
 
+  orientation-gpios:
+    description: An input gpio for Type-C connector orientation, used to detect orientation
+      of the Type-C connector. GPIO active level means "CC2" or Reversed/Flipped orientation.
+    maxItems: 1
+
 patternProperties:
   '^connector@\d$':
     $ref: /schemas/connector/usb-connector.yaml#
@@ -44,6 +49,19 @@ patternProperties:
 required:
   - compatible
 
+allOf:
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - qcom,sm8450-pmic-glink
+                - qcom,sm8550-pmic-glink
+    then:
+      properties:
+        orientation-gpios: false
+
 additionalProperties: false
 
 examples:

-- 
2.34.1

