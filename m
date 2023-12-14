Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE4581374D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 18:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443630AbjLNRGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 12:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLNRGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:06:52 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F1DB7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 09:06:57 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-54dcfca54e0so10954010a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 09:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702573616; x=1703178416; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vg4pzsKp2Qe/t4K3eYUmtV9LkGCsbM0iu+iGTaqM5Ck=;
        b=F2sIpfGDpB6dmvn2e3bPyI+qV/p3URKD27bn+g/EhOBcqA6Y9M19bfmll9ZA6QUG2g
         2V8NKMTEoDhRxmyp+rdOCwlY4vFyzuRPwVmLRCL59lFtWP/HUVDIipARUMrPiuvbvPj7
         xSj7LP/wFI0YBm6Lmt/PQqt/4LBjkMwc12smF/a0jq5x339wVkzlrFfzqWCoj9U4oqKX
         ReP2q13gGMi3Elj1AvFxbrVfpuIdhyssyboNJN5fP/d4y3v6i+g2G+Soe1Pr431/N3cy
         bJIv0ESkP0KapRncK2F0OAvipbeI3ni9Z5TdJ57nt4j7aYVX7QGdpFRNyi9/JAFx0kd9
         MHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702573616; x=1703178416;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vg4pzsKp2Qe/t4K3eYUmtV9LkGCsbM0iu+iGTaqM5Ck=;
        b=cpjb7CEkxstaW5koZmLEpzTLnj6ze/aBOTwGrnW+mcDx0fEFWoGrouawHXPrIoi8te
         YMY7HxlTnE0QBmRFxjyzheaWqrF3mn4B4meJASh5JGpBNGZD8JRmuFvZGpVHz0O6mrso
         +jR0rXAC8xZSK5InMLj3Rw8PSewQpbu5hI1hAh/d+iK57vwzlNpNivIIVozr1/+STckz
         C30AMxxuRYiuORpPERkK6LjGbvmRwMYAN+RsmbOzxjCFyyKmSex8ppHNbFwnJCLgfChT
         aFwCUbxGlRjby3U33+Uxk0w2nz0gVFeWGb+CtDWwfekl40Vm35SOgu4lrLRqf25Jg33+
         g67Q==
X-Gm-Message-State: AOJu0Yz1e+SSC6TB7wX/+kFtZ3bZBkVUIun868zGJiWNTvhThx8npqb4
        hpu1jfbYlCNc4zqyANb7ee9gKQ==
X-Google-Smtp-Source: AGHT+IFwnubd/IcCm6zKJxoRCySo1E+aDWxfOl0YfDbKYnbz4Qx8e3oh/+MYHR5/NygWBwZ41rV4+w==
X-Received: by 2002:a05:6402:2313:b0:552:1be8:422 with SMTP id l19-20020a056402231300b005521be80422mr1727337eda.51.1702573616379;
        Thu, 14 Dec 2023 09:06:56 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id y66-20020a50bb48000000b0054c77ac01f4sm7182863ede.51.2023.12.14.09.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 09:06:56 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
Date:   Thu, 14 Dec 2023 19:06:52 +0200
Subject: [PATCH] dt-bindings: usb: qcom,dwc3: Add X1E80100 binding
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231214-x1e80100-usb-v1-1-c22be5c0109e@linaro.org>
X-B4-Tracking: v=1; b=H4sIACs2e2UC/x3MMQqAMAxA0atIZgtJRQ1eRRy0Rs1SpUUpSO9uc
 XzD/y9ECSoRhuqFII9GPX0B1RW4Y/a7GF2LwaJtyBKZRMJIiOaOi1kct8y9cNcglOQKsmn6d+O
 U8wctMyjmXgAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1223; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=M6miljaqwJPNWjTWUdahHGSlgKOEzXafA/Gjh7eL4QQ=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlezYujPA2t+ofl5U22PW88pc91HxN9ggKKvB4Q
 uunpvqYfliJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZXs2LgAKCRAbX0TJAJUV
 VowlD/9TfX/CZHexvlo32hwGjhczMG95CPnUTrqn+eZB1lcJ/dNVDvN9D8fxo6ps7+O+30+jiTn
 sO3gTfxdUh+s70sYVVZEX2nnUTFYeJcwFnI9CKoJqFisK280Su4mt7bMRN/kTWVDIBYdglEIvgZ
 grgSGTMYMqxFHe+f+EN7VwsJxuR1cN53x51GNroyO8EIYgoO8T64bcdbi6O7DpqRtF3MqP2q0p5
 ShCNrpgyZt0WiN+2a9K7gEWGrFHBZur1EBNCBBzS0RtLPL98dez1JVE14AsqEfKjQCc+EDZgzDq
 +5PFfi0GiH18d5JtoO5sHPP8vTgIfJOxymEdAbDWAUPtghnrymW2BZ00pXic+5uCNJnulEbBQxC
 6Cc1R6awioK8ET8mLsnnGTM4CoYbM9mDPf7GZCDN+znde+nBCT007rjV+xsEcGktgvtKs5nUPXp
 VSdsSsPGuw5f+djy7knLSen0V5ZleRWGG4Hp7bX3noy37OFX+to0u7ODhCuSJH+pbVan3BExOi/
 MclXJysnOJKUuBnq/vaSBzZkQGUAH4naeltzB7CCM7WyX5nl0G0k8EUcXHxGUYMDDl1j0CrOe52
 3MSgXPDTNowzkN/sRDa7aCMKmG10fWejuLUYGZGFz44wbq1yIOpS+PBNCRMuI2a3aYOIwkOAh7t
 38prAfbScGrMc0Q==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add X1E80100 to the DT schema.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
index 3ec62027f663..473c4bfaf8a2 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
@@ -47,6 +47,7 @@ properties:
           - qcom,sm8450-dwc3
           - qcom,sm8550-dwc3
           - qcom,sm8650-dwc3
+          - qcom,x1e80100-dwc3
       - const: qcom,dwc3
 
   reg:
@@ -264,6 +265,7 @@ allOf:
           contains:
             enum:
               - qcom,sc8280xp-dwc3
+              - qcom,x1e80100-dwc3
     then:
       properties:
         clocks:
@@ -459,6 +461,7 @@ allOf:
           contains:
             enum:
               - qcom,sc8280xp-dwc3
+              - qcom,x1e80100-dwc3
     then:
       properties:
         interrupts:

---
base-commit: 48e8992e33abf054bcc0bb2e77b2d43bb899212e
change-id: 20231211-x1e80100-usb-bc85887e8630

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>

