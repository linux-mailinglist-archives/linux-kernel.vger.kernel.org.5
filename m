Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399CB77CDB9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 16:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237485AbjHOOBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 10:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237456AbjHOOAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 10:00:41 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B32D1;
        Tue, 15 Aug 2023 07:00:40 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe28f92d8eso8555783e87.1;
        Tue, 15 Aug 2023 07:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692108039; x=1692712839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltyQwF2LAMGJH0evTykrvVjQou+GUeNnjt/wVeM5SF0=;
        b=ZHukLVy0358l0WMPNL3pncLnc/8q25csLKF6Cjv9hPbTOZfCSvsjChHoX7POz7RIkI
         RN/KEjFoWrVw2yRIDYgqFXODJVbLm94e5WGyZ0NxWunzj+ifssTK3/e9YejYzfC29GP5
         Ab4MJ06QLfi52RO1zDUGC0E/9xK3NLoJ19FtYuG74VZ6GnbapI6n+bERusHpWd/DrSjG
         k1A3lRAMth5I2tmNQuxWe7D6llF2lNk/B7ZIkWo4Y7m5hcC54d0AN8ZWPCzREHibwxCG
         0ydGV2vbDPJRjEp3tvL/FemQfKBmiw8wgLyK46z2XUazA4UPX6emR/EJchiywiL7flFI
         j6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692108039; x=1692712839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ltyQwF2LAMGJH0evTykrvVjQou+GUeNnjt/wVeM5SF0=;
        b=D8upkTb3WwuWp6K3P0MDTVCzKHlT/sB+u8KOF2JuIIWqJSRJHAtKJAs3vaFlu4dLzD
         olWSxQKG3aBsYa9UunQW2EvhtainPS+KYNH3mg62dvnncjayOMZ9cQDDQwwHNTMUDw06
         /1Jn+gffRQrFe99LURRSrTzR82GSDK596m5PJFMeyKzgPFsJ5nFpqKTpMtREOnmIclKj
         ClevOj4X6A7QR2bBZeVSNUHL9NHlN5hBnbGa7fQuDZP1+4O1D2ks4j7mr7iGukswlVkQ
         SHv13GVKQ9Ev5or1QYAR3ebSnlpbvAb0DNIAseENIohJTbnwR2C14zH6ryoJE8ScyxgU
         xuzg==
X-Gm-Message-State: AOJu0YzfckYZ8XvgipNni6EH98DwNQPJccvSBFaaobi2/B0CuIa4o5SC
        VQj/tg+8dfa0fcxcu9JHBJY=
X-Google-Smtp-Source: AGHT+IEfr77smkL+24HO9hz+7rz2f9ubnVRvLkFPiEEn2cUK6jQbiqLOYgbvez2LJm6rf+D4Ivg20g==
X-Received: by 2002:a05:6512:2147:b0:4f8:5e8b:5ec8 with SMTP id s7-20020a056512214700b004f85e8b5ec8mr7416051lfr.9.1692108038419;
        Tue, 15 Aug 2023 07:00:38 -0700 (PDT)
Received: from fedora.. (dh207-96-14.xnet.hr. [88.207.96.14])
        by smtp.googlemail.com with ESMTPSA id a26-20020aa7d91a000000b00525740aa68dsm1049042edr.36.2023.08.15.07.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 07:00:37 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, quic_gurus@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     computersforpeace@gmail.com, Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 4/5] dt-bindings: firmware: qcom,scm: document IPQ5018 compatible
Date:   Tue, 15 Aug 2023 15:59:37 +0200
Message-ID: <20230815140030.1068590-4-robimarko@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230815140030.1068590-1-robimarko@gmail.com>
References: <20230815140030.1068590-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that IPQ5018 compatible was never documented in the bindings.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index bf753192498a..212ad5f32408 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -24,6 +24,7 @@ properties:
           - qcom,scm-apq8064
           - qcom,scm-apq8084
           - qcom,scm-ipq4019
+          - qcom,scm-ipq5018
           - qcom,scm-ipq5332
           - qcom,scm-ipq6018
           - qcom,scm-ipq806x
-- 
2.41.0

