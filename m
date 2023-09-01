Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCC87901EF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 20:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350514AbjIASKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 14:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbjIASKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 14:10:49 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB4992;
        Fri,  1 Sep 2023 11:10:45 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-98377c5d53eso271793966b.0;
        Fri, 01 Sep 2023 11:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693591844; x=1694196644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7vAUl+f+nTpTddF45AevJsS/6FUW2IsLXphAnOA2RZ4=;
        b=InzpSEc7xNd+5B5lqJphhTHDY6uViCOpkXJR/6ozf7IH0ysivpMl9HnOU8+fbKvJUn
         ns9opGLp34tr7OUn4qYUaZ0OO7yPbjMETvzUYEYDhBrKki8Xp16xFtMd1ec3NLMGq1Mq
         RKGuwFYPH0BFbQePJNyNa3hgZ3XBcRSTFqto6skRFl6/eqthfwuD+YYgo3XBQs20QN9A
         /w/+k4EE9hoqdUPWOWR/w9iG8dRqA+ehGWO1ltCYiGA9940K7Fx5BQANzOC3j6uSkOeU
         UHHlMJ2+cVWAZADyWfGTUv0jcE3eLcbmHyiRpo3rjcHNsH8+DN+ZUTjT7QqSTUCTLewk
         7WLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693591844; x=1694196644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7vAUl+f+nTpTddF45AevJsS/6FUW2IsLXphAnOA2RZ4=;
        b=fnkYA/7brrYM4zxZS8EVosbO/CDecvmFaYNMRbdv/Np2jMRtw/FyuPa4Qfa/Q70WBU
         9AkrPGBIJvNTMy7DU1iQaYo+oSTS/rRO95KEJQzcrXHbe2esDtEfs20U1UU11umK84lD
         KjrEkFX3oGFU/kNrfDh7922RifX5DONxQAp7fR3xiB4hId37U6NKDWyOz4QmyPvczTG/
         K1UclyppsAzq8hD3m8m48FPZbPTSB6a444mICrmETdca4+BUL9oNFh8IhTbFWM6HRx/I
         KckLF5oDNq2IE31lDPISkdSc5fY1JvaJu+kTR0C5qgUdGK/4PvKmFs/06K/NwatldAof
         yZwA==
X-Gm-Message-State: AOJu0YwsDS2Ny3TCTxyMcs7jlH9G/1/Y+68OLM4YCrEaYfRID/oFgjK/
        /Y+AlSHGOFIoj7/P0LKOoms=
X-Google-Smtp-Source: AGHT+IFi6wHXHh77TlN/+blswyS/MIXBXlCnQXBSVFYt7wNq/Nvi0h0HD08ZRCHs84L0DK3a45V4BQ==
X-Received: by 2002:a17:906:32d3:b0:9a1:d7cd:6040 with SMTP id k19-20020a17090632d300b009a1d7cd6040mr1940535ejk.37.1693591843661;
        Fri, 01 Sep 2023 11:10:43 -0700 (PDT)
Received: from fedora.. (dh207-99-49.xnet.hr. [88.207.99.49])
        by smtp.googlemail.com with ESMTPSA id j9-20020a170906410900b0099bd5b72d93sm2278999ejk.43.2023.09.01.11.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 11:10:43 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 1/2] dt-bindings: arm: qcom,ids: Add IDs for IPQ8174 family
Date:   Fri,  1 Sep 2023 20:10:04 +0200
Message-ID: <20230901181041.1538999-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ8174 (Oak) family is part of the IPQ8074 family, but the ID-s for it
are missing so lets add them.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 include/dt-bindings/arm/qcom,ids.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
index be12e1dd1f38..d2b84a308fde 100644
--- a/include/dt-bindings/arm/qcom,ids.h
+++ b/include/dt-bindings/arm/qcom,ids.h
@@ -203,6 +203,9 @@
 #define QCOM_ID_SM6125			394
 #define QCOM_ID_IPQ8070A		395
 #define QCOM_ID_IPQ8071A		396
+#define QCOM_ID_IPQ8172			397
+#define QCOM_ID_IPQ8173			398
+#define QCOM_ID_IPQ8174			399
 #define QCOM_ID_IPQ6018			402
 #define QCOM_ID_IPQ6028			403
 #define QCOM_ID_SDM429W			416
-- 
2.41.0

