Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B377D626F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbjJYHZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbjJYHZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:25:39 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D29D182
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:25:36 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-507a29c7eefso7962726e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698218734; x=1698823534; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8UZhJQSD0Uc3f3xdHOo042gWQWkDiJjvPAwU+g19bRs=;
        b=sqmNC0bJf4GCWLgJ/1QtejJzsUxiCtfSPDiNNFnSaHEReUpBReRKKghY7qxlHij6FS
         npgvJ3x7fMS4QNy15y4SPOatCQ2aHuhVydptANJ39ArJ2NBsh3DA+QfW1peByqpBa+iC
         +h8unQxL2gHXp0hJZAY9VCKTyHDWLKk13fdhdSncJgWXFW+PxvD2Ang16uz2I4pe288o
         TqHA3cNXyNSBwpbT5WDKk84rtMopZ7Z/MxOyX++43nJOtpQmxJg75ME/nZ9mbOmCM1ZO
         JB5EM2jwjDf7pd2q4po3Bch8JGhlypXti8LtS4xCPazY59bKf/ObZ/Fv/uEiMp/DL5lJ
         c0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698218734; x=1698823534;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8UZhJQSD0Uc3f3xdHOo042gWQWkDiJjvPAwU+g19bRs=;
        b=O+y8oav5oJ5nH2v93BtiwbtRWfo8EfSHKgE9bYnj+ciphju0wW44pNDgqg0Hn7zhEU
         XKxR1wDzLfTBaHSSef68iKz7b76NnMZcbt8uArxjykp0qxo3GyStr15MNgNWkdTZLj44
         4jQQqJshpVwOljEd7u/RHC5EhVXri1+d6qBnslGVcTLpWdMXqzeIWsIp9+Q+lB5yu585
         lKR6lMxEDPqIFCDWO9HqF40waFQqXwbFKEukWzVBC9VgUpuV37hQ14sdhAaW7ZRwchpG
         Q8H33wnavnSY91Om/BYTfhwDWLFqifLayi4T/v60+zLWIc1DDKYSp/b/rLYOBv/XIrwg
         1X3A==
X-Gm-Message-State: AOJu0YxRKfitdex1XGLnp+wXaDU4K0Ql6KS54NXwTUyq/tN6TYVHChFv
        5xLoLEOV/GMwaGbD71iurV0C2g==
X-Google-Smtp-Source: AGHT+IEv00dbc7BJHQBIE96AgaQVZe4kY9vbKpsd0Znwe5esaLt0vb15E2rFC6uN1ffp4/9tIaouCg==
X-Received: by 2002:a05:6512:65:b0:507:9e56:5b1c with SMTP id i5-20020a056512006500b005079e565b1cmr9300064lfo.13.1698218734417;
        Wed, 25 Oct 2023 00:25:34 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id g17-20020a5d5551000000b0032cc35c2ef7sm11462557wrw.29.2023.10.25.00.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 00:25:33 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 25 Oct 2023 09:25:31 +0200
Subject: [PATCH] dt-bindings: usb: qcom,dwc3: document the SM8560
 SuperSpeed DWC3 USB controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231025-topic-sm8650-upstream-bindings-dwc3-v1-1-fdd447e99865@linaro.org>
X-B4-Tracking: v=1; b=H4sIAOrCOGUC/x3NPQ6DMAxA4asgz1iKA41Kr4I60MShHghRTH8kx
 N2JGL/lvR2Ui7DCo9mh8FdU1lRBbQP+PaWZUUI1WGM7MuRwW7N41OXubgY/WbfC04IvSUHSrBh
 +vkPHvaWhpzjECLWUC0f5X5fxeRwnz0d2oHUAAAA=
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
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1119;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=94slVde3c1MdIK5l3UGMWWvmzVgx8QGqBtuDrQplXMg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlOMLtED6TIvM9aOKsOTTkKEpJ1fTNDtge5B2SpsiC
 Q0Lp7H2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTjC7QAKCRB33NvayMhJ0VAWEA
 C2keWT9ubyCYrE7fyYYR+SNXUB7+iOYVpKfOiWWvYZU9Sd0yMUK82VZWDfLuXoi+n8DztcJqvmi46o
 hiEbK7UqZqCbUPZH+PKwBtKLtPNHCBD0TlCcru72ENA4jKGN+a34U81uaTEMv6mVokHMIsmhKSkC81
 LFUF3BC1TTDsNzhDHHbL+zKOuplUFFGSKGsSJnBKX2q3gVgbcTpObieed/sgIuHsWwQcsZBGffGDs/
 2dsMvvcAwW9sWndev8CuHx409T1bX1qW0R2u65CRQVroIAlQYFDN/YIyJ3pbN+90ykjBbNf/QIYHE7
 J8plPEIB/TshABj7uN1ZMfx/2kU+LZBBWjXAJi7XRlArfr8Nklepq2DHpYCkXFHG8h0H1R1t4uFTIV
 t4dE52DC1gFYaqWSlN0m3hEnEfijbxblN4oPsMdnSC4zdcKvM/PB8Z5lhvsubMzHma4I2A27ddiivp
 TjfxIi1kC7FShak3aIc8c4SSM430FG/AMdigNFHZtOqyi6zKlwLOAxidsDwN1DX703yOOCnj68rGvZ
 iyjU0EZ9CeJPJGKEzBca51vXNN/esy1b5DnaTvf6L+EI7o1L5ioyiQA45iKOJ75mHMZ9KeWBvgtenu
 uNuYdzthiVwAeF3/zvtVO2IMiZYWMolktZ6TIxCgqtFTc98JlAp8/jDunnDg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the SuperSpeed DWC3 USB controller on the SM8650 Platform.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
For convenience, a regularly refreshed linux-next based git tree containing
all the SM8650 related work is available at:
https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm85650/upstream/integ
---
 Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
index e889158ca205..ea2c663ddc52 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
@@ -46,6 +46,7 @@ properties:
           - qcom,sm8350-dwc3
           - qcom,sm8450-dwc3
           - qcom,sm8550-dwc3
+          - qcom,sm8650-dwc3
       - const: qcom,dwc3
 
   reg:

---
base-commit: fe1998aa935b44ef873193c0772c43bce74f17dc
change-id: 20231016-topic-sm8650-upstream-bindings-dwc3-6e421941f9ff

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

