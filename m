Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EDA77DBC0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 10:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242756AbjHPIHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 04:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242744AbjHPIG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 04:06:56 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B92126A8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 01:06:53 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-307d58b3efbso5431196f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 01:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692173211; x=1692778011;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tw5E2UBQXvOpbGHprcCTw5ennRO9STUpYBfUSdY86ds=;
        b=t4Y/X17KHem58LEiK8ROQhxkwMypsmvrbTaHQ5mJuc1GhgmqRSxJUK7J5Pncti0vPX
         vhLZLzn2o8a1zlbizbdsegpIMSmMOBIaGboNgMvHQZBg2usnJI8YcHWUKNQGSBZyfp2t
         6lchihWpwecA9cuAhxobl0U79XgNzl7qv4p9fv9HZZuZfPfzsawyx1bEbIUGkhJDao1q
         NqLj1fN7TsJkWKpAu84lbAhFBLVeLPTLfMMEQPFcd00whfD0JL4LL/oyL/RJjEPrdZSb
         NH8lzTrfF5OERCzVYS82cpssawlrmmcdpEAHnSgNclq+CsM7CM9Ii5U/+wSi7HIvWKB6
         Z4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692173211; x=1692778011;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tw5E2UBQXvOpbGHprcCTw5ennRO9STUpYBfUSdY86ds=;
        b=Mroqq+fBeRyPG7m5ETyQhIT9qJXSyDMYv4iisD2aYBrYGHxattP5pZqsOiufELFfJk
         JBu+/9P39W6vrFsnol1nD7h9mhZS4UaTInvlEiefpezWKISmglzX+0nCCG+wW8HeUSeC
         mdpb9v7t41ttR9SRk8kSgEjSaG/ZpCDR8UG/H9fiklFUACxdpP1qiHxfDuHKtEOJzKht
         2lcBFh3khtXLQBFL9OdGN+CBKDKyd/S8ubDVoLhnD89vFT+jg1nXBrNGb0y8xXXdZed5
         ASonFBuLYkACL24RA1wFmAFF/ByySCvdYy2RttQaGCtdmVzjBsmUzqFCVvYtqo8935To
         7v6Q==
X-Gm-Message-State: AOJu0YyWt8G2WP65JpSilGH50DJq2NqbV7Jo8FmeaVVQF98KLpgeQctM
        TCIH03MyD7577kfAYkObvIRpFQ==
X-Google-Smtp-Source: AGHT+IH6NpwmoudJyghMIrpgE7AXA8Trjw/2cTk2K4YqOd5aQB8yeFebZw1Zr7XrtTox1oneOCs2lw==
X-Received: by 2002:a5d:61cb:0:b0:319:72f8:7244 with SMTP id q11-20020a5d61cb000000b0031972f87244mr993379wrv.45.1692173211520;
        Wed, 16 Aug 2023 01:06:51 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id x5-20020adfdcc5000000b00317878d83c6sm20430428wrm.72.2023.08.16.01.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 01:06:51 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 16 Aug 2023 10:06:46 +0200
Subject: [PATCH v4 1/3] dt-bindings: net: bluetooth: qualcomm: document
 WCN7850 chipset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230816-topic-sm8550-upstream-bt-v4-1-2ea2212719f6@linaro.org>
References: <20230816-topic-sm8550-upstream-bt-v4-0-2ea2212719f6@linaro.org>
In-Reply-To: <20230816-topic-sm8550-upstream-bt-v4-0-2ea2212719f6@linaro.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1856;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=F961/lw+yAY73+/udy9usG6VmzbRuCgDP2WSGtHNz0o=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBk3IOXsOco9A8t7v3yhlPuyA6uFeqjOoMHcE6lvojX
 Av0S/JCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZNyDlwAKCRB33NvayMhJ0VV3D/
 92enjP4XckJJxHlstLtRpx5pIAKjD55yGTKeZAOMtfpa6hnw73fw/vzkPA0frqFW5PJkf+uSqreDzh
 WpKcI1HWQ8/dWlt+Qz1O8boQUM1KHVBY2h4GuP8Vqy9gR3OFa4yYINUjF3g484buaBGou9fPRYmVGK
 HhTZdbwRn7iKX39C2WRtD06sXaFDrOhxjsAOvwsPU63FEKDXrrPld6WrkVIQ2Y7juo7Hb219ZD0cIG
 q86qBcW+fZ20W/g4wgh6DbDc8H9rXfvE5m6/3/UKNtkW4/Ff8WLynTwyrYKwZaxmqca8pq0vuy6dcP
 QtvVkBWpWsEo/5UNUYx64+WgPF0fe4KrjjX8qUFJ0uDL0ncp3uayhenKPqCUSg0t6YjE2rVWeFgfmr
 Eqv8mMK0U3mZtv1FP3YRbEtxd76HKkk2KUBaSXhGWDHu2zmoNdBs2H8eCuRJcu9Yj3MxLzAGHq6UQF
 KRNw+3Wnyz3wVb9xUJXNYIqXg+dX4izy8o2zOB/asn87Vphoe7xK+IAdmaFC3bwqASjWvXGLqu1WJT
 4HJugAA0T1M+DjktUUAoVy43uTSyyKn2vxHZ/BFkzQj8uROv9gDXOAS2JgVpSnRXKWPZOw7zm+6oB1
 lQwvPRXaO3Wks9S0x05OB5Tgkh9P38t5N13ILEFF2BTAJBPRlR9M40KdZozg==
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

Document the WCN7850 Bluetooth chipset.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
index 2735c6a4f336..eba2f3026ab0 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
@@ -26,6 +26,7 @@ properties:
       - qcom,qca6390-bt
       - qcom,wcn6750-bt
       - qcom,wcn6855-bt
+      - qcom,wcn7850-bt
 
   enable-gpios:
     maxItems: 1
@@ -58,6 +59,9 @@ properties:
   vddaon-supply:
     description: VDD_AON supply regulator handle
 
+  vdddig-supply:
+    description: VDD_DIG supply regulator handle
+
   vddbtcxmx-supply:
     description: VDD_BT_CXMX supply regulator handle
 
@@ -73,6 +77,9 @@ properties:
   vddrfa1p2-supply:
     description: VDD_RFA_1P2 supply regulator handle
 
+  vddrfa1p9-supply:
+    description: VDD_RFA_1P9 supply regulator handle
+
   vddrfa2p2-supply:
     description: VDD_RFA_2P2 supply regulator handle
 
@@ -157,6 +164,22 @@ allOf:
         - vddrfa0p8-supply
         - vddrfa1p2-supply
         - vddrfa1p7-supply
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,wcn7850-bt
+    then:
+      required:
+        - enable-gpios
+        - swctrl-gpios
+        - vddio-supply
+        - vddaon-supply
+        - vdddig-supply
+        - vddrfa0p8-supply
+        - vddrfa1p2-supply
+        - vddrfa1p9-supply
 
 examples:
   - |

-- 
2.34.1

