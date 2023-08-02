Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E4D76C5EC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 08:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjHBG4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 02:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjHBG4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 02:56:36 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DA3E4C
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 23:56:33 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9923833737eso927844766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 23:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1690959392; x=1691564192;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4WekZWN6r3kEo9Z2SWEpwzpGIFVoo4aO3LnnSXjlvYM=;
        b=dQbyTvayxNXzXnaDzhb3dWNJb8dFPo5kSGVOQt8Y0gQ7TNrrZWVkzaPRmfiPVPLedF
         mGG3RDRxV7QUaRLkg8aVqfQRr8ODrJ2KdPxvphBZYq0UGKJh7blaLtLFzzm2ln4bq2SZ
         pF2N2ir4xI/1aJevJD8H6tvnHfK+Rt5zs9kzVaMa7JpPd7qTC+FCUx4vV1ewbi36xjTS
         D2WrR+vD7Wg0O/RVDXd7roySAyHYTJh2dkMkOCeFgVjpinIQdXwuvXegP8wymfFstsH2
         RsY5OPte5dp5ISxz1iL9meNywNIq3qCZazN3AlfMZY30BSCWZfnrp2DCBjI0CVRpIlnD
         ruTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690959392; x=1691564192;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4WekZWN6r3kEo9Z2SWEpwzpGIFVoo4aO3LnnSXjlvYM=;
        b=OmosbbIx3b9IeraQxXwfTU+IT95q2RtGalz0BpVGcmgLzCFSyPh3fcUdt5h06atUdh
         mCXlfo41d+WZ4fHOlAk0CWAbjGeI3iw8UK3aX4oov66NnzdEMzNyPzB4hMzaSq9oVljh
         QxBYXMWke+69UzU6SUK9OKkr6LCTtv5xCQ8TpzUMaDPhCXln3eSENTeIr7hD2iNqPobe
         2V7LY+ShGNkn4uvZAd6pf930LTVhWVhRQ4K4+gAERBIlAHhOoKWY0WUl0PVw0zN6dh7E
         7nhY2TV7oAYTFq6gCDDOvxfPoEFgOu3G4DctW6dXzMizZ5VdhIMRtI1mykQHwWhPFMYp
         +PKQ==
X-Gm-Message-State: ABy/qLaWD3pmvzQU0ADzNaqa2H3MFMqy2vj9AOFVTDHsWG96Ssr44vk7
        nTcIfiCUPkXwa5C1RQMGahRPmg==
X-Google-Smtp-Source: APBJJlFGxq+aMT3PqHDgik/2AOf8hLDUHBWjDVKJBcTpdIfewNezftcZ0MjSF0LXzcYzfzYmQ/xYmw==
X-Received: by 2002:a17:907:7631:b0:993:f9b2:93c1 with SMTP id jy17-20020a170907763100b00993f9b293c1mr4129777ejc.9.1690959392217;
        Tue, 01 Aug 2023 23:56:32 -0700 (PDT)
Received: from [172.16.240.113] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id e1-20020a1709062c0100b0099bd5b72d93sm8567400ejh.43.2023.08.01.23.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 23:56:31 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Wed, 02 Aug 2023 08:56:28 +0200
Subject: [PATCH v3 1/2] dt-bindings: net: qualcomm: Add WCN3988
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230802-fp4-bluetooth-v3-1-7c9e7a6e624b@fairphone.com>
References: <20230802-fp4-bluetooth-v3-0-7c9e7a6e624b@fairphone.com>
In-Reply-To: <20230802-fp4-bluetooth-v3-0-7c9e7a6e624b@fairphone.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatible for the Bluetooth part of the Qualcomm WCN3988
chipset.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
index 56cbb42b5aea..2735c6a4f336 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
@@ -19,6 +19,7 @@ properties:
       - qcom,qca2066-bt
       - qcom,qca6174-bt
       - qcom,qca9377-bt
+      - qcom,wcn3988-bt
       - qcom,wcn3990-bt
       - qcom,wcn3991-bt
       - qcom,wcn3998-bt
@@ -111,6 +112,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,wcn3988-bt
               - qcom,wcn3990-bt
               - qcom,wcn3991-bt
               - qcom,wcn3998-bt

-- 
2.41.0

