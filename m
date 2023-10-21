Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56927D1E5B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 18:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjJUQrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 12:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjJUQrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 12:47:04 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BDAD63;
        Sat, 21 Oct 2023 09:47:00 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9c3aec5f326so626039366b.1;
        Sat, 21 Oct 2023 09:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697906819; x=1698511619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=svyD/5jChRx0NY9XuLVDQOWnqJED0iNwjhnTl/C1h5U=;
        b=ItL+bG1k4lr/0xeVnUu2KmYWzxBOAxzupRCd1pxCdeSUrTOJ5KAJdeBrmJRqSN1mXO
         bjin6cXeeqVLG6rN03SxTTEPR3UGEWuf5uq4Had9KrL82MLJLIIwdUBLQ57xbm8VaTZL
         8A0btEgXgNWCbbciia3ZKPgiWXr31nWmzhkN7G5U0WSUENt71ZnHGuH/0y/hBitpGgBa
         VTauAg4N/E7TZeGlQr6zhawAdCH7ebr/I1+O0YjjNrfMQpyYFJVymxzGRJj1dYF55rLV
         8hgqf7ZaCP21xDGI5U7fmHrboTaijoFr1MwzSz105x6DzU4U6OdTDnRqZlvFBlSMlOfc
         j+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697906819; x=1698511619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=svyD/5jChRx0NY9XuLVDQOWnqJED0iNwjhnTl/C1h5U=;
        b=XkPIHYg4IQT23uzm4cbYEKYP54Ghg9eOK9MD/zm5rAPYVAbo6yWtakPzu0Oy+KioA4
         P4knGvaFLO//dvNUqIBgd12xcUApFFUm6A7SuTTEEda59qt6OL8lZXs1B/+fgnUakxFw
         0kNuvtDoCI149mEFdQ+aB5vyEJSri/H8d9MQSaIzO4Ed3dIDWPnoIrqXbLJeh5qVeHXR
         jiU7gVAurfwRr8HaFhTDupjTqtESWOrfRg3jd273J4fmFwXMQXee7RgvI7NjdWWvOP72
         xcqY4CbzY0ITihcHBUphn7vRIo66bfezfiUJBliIn6UnBK+M1WJrR08VNaws/3tXWLAp
         QhHA==
X-Gm-Message-State: AOJu0YwD7GkLOYnI4LSeAuW2c4wqBTDYJDAjQ/Iv8h8M4EIdDPyCHLfe
        UFNfRE63+Uy9i5i+YqZ3Qxi1PWR4n6J1KcJ7jZ4=
X-Google-Smtp-Source: AGHT+IFrXEx8ItQE0JdVItjNM8J/Nz5Seq1Ud0HqzdG4xGGsNPyjjKR+HHWRKkz7aeXLGopyUoNFOw==
X-Received: by 2002:a17:907:1ca4:b0:9ae:5df2:2291 with SMTP id nb36-20020a1709071ca400b009ae5df22291mr4784950ejc.1.1697906818931;
        Sat, 21 Oct 2023 09:46:58 -0700 (PDT)
Received: from localhost.localdomain ([145.224.104.33])
        by smtp.gmail.com with ESMTPSA id f20-20020a17090660d400b009a1c05bd672sm3792954ejk.127.2023.10.21.09.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 09:46:58 -0700 (PDT)
From:   luka177 <lukapanio@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc:     luka177 <lukapanio@gmail.com>
Subject: [PATCH 1/2] dt-bindings: arm: qcom: Add Xiaomi Pad 6 (xiaomi-pipa) Add a compatible for Xiaomi Pad 6.
Date:   Sat, 21 Oct 2023 18:46:53 +0200
Message-ID: <20231021164654.146002-1-lukapanio@gmail.com>
X-Mailer: git-send-email 2.42.0
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

Signed-off-by: luka177 <lukapanio@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index adbfaea32343..1bfae1b237d2 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -965,6 +965,7 @@ properties:
               - sony,pdx203-generic
               - sony,pdx206-generic
               - xiaomi,elish
+              - xiaomi,pipa
           - const: qcom,sm8250
 
       - items:
-- 
2.42.0

