Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630787F4555
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343951AbjKVMFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343917AbjKVMFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:05:38 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9051710D0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 04:05:33 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5488bf9e193so5388765a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 04:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700654732; x=1701259532; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bymm8ioFVVD3dhLMm++/IzfooTvBAxFVOSgxW0vP3RQ=;
        b=O7l+4JBawhFmrtkfqORuV0TIP5EqhOAHHf0S/rFVAGo6sAA0drkZfDu/zRahTDb818
         5k4ZLU0p82ktnLEw8x4+5aZ+6FUqj191+QMJK7FtaD9UoJ0Z5nIMMMjzYhRSIiSZrIfe
         ZXP1jWhGAZ4yTK7JJSj1A9HlZekyP0NdL1X97pkPSwpne4u/3XR4ms7asdtrEn636LJC
         Y/BWxlN42y62y25Ts0MfsLqy0u3QqeLt4a0So6V5RkOi/PDPEAlNiC81j2Xn48JWYxXW
         P3/p2ApyEQ5FXVI5Jsas0Q+2CCzLFj021NNaMaQmii4TA5o3c9tgOwFO9Vz1BvV9YnUj
         O5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700654732; x=1701259532;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bymm8ioFVVD3dhLMm++/IzfooTvBAxFVOSgxW0vP3RQ=;
        b=uBKta80Nv5U1t1FvzoiRlq+Dfm9wrlIYmVcZCvj20DJ8r0nRVjX2xnvc175J14SknN
         a68LYoGN/no7uLRmvQvak/MKsaKs42F22JeRLzwTQb01otdLIXCFSAg510gCFqNV0KkG
         1Vy91XuhawQa/7y/6Y7z70qQpPSiu68SQIWfAXqj71AsiabjIBRByckB/laYOoy1KlY8
         l+VWL0FE+n9dWPO12KSeoTkhX05D5PY5lUw6cmV/1rw6OHIAeuOGGYjUrYVaNxYN5VC2
         dXA7OYd5fEIRyu3evop98APrUe2z3xiogaomaAAuJK3BNdkAq0mfmbllTlZ4yPWBUiAH
         /3Vw==
X-Gm-Message-State: AOJu0Yxpfod27W3tTCLmxboOzBkD/nLEMibbqIIK2Ptkjg+4jJr7tjcA
        F4eGHis6paPN00xHKiUowzgs1g7gySuyLHCYqV0=
X-Google-Smtp-Source: AGHT+IFHxGuasn2hCVAywG1/40UpIxj4n1WBlznP+vAlUpkOgylTp/74MdCSST/XfRt80LCtIdPAHQ==
X-Received: by 2002:a17:906:9d14:b0:a01:c04a:b843 with SMTP id fn20-20020a1709069d1400b00a01c04ab843mr1330938ejc.41.1700654731851;
        Wed, 22 Nov 2023 04:05:31 -0800 (PST)
Received: from [127.0.1.1] ([86.123.99.122])
        by smtp.gmail.com with ESMTPSA id kq14-20020a170906abce00b009fcb10eecb2sm4383416ejb.84.2023.11.22.04.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 04:05:31 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
Date:   Wed, 22 Nov 2023 14:05:21 +0200
Subject: [PATCH 1/2] dt-bindings: phy: qcom,sc8280xp-qmp-usb3-uni: Add
 X1E80100 USB PHY binding
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-phy-qualcomm-usb3-uniphy-x1e80100-v1-1-3f5bd223d5b4@linaro.org>
References: <20231122-phy-qualcomm-usb3-uniphy-x1e80100-v1-0-3f5bd223d5b4@linaro.org>
In-Reply-To: <20231122-phy-qualcomm-usb3-uniphy-x1e80100-v1-0-3f5bd223d5b4@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=843; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=Ff/TzKsr6VAOQih2h47SXfwoazhLB1JbDRlKoZrC1AU=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlXe6HIiyEgikpop1Wudnzf4cIJEHtKgxjpGy7X
 feKVqqm9OiJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZV3uhwAKCRAbX0TJAJUV
 VlM3D/4q4GqU7KihS6jouVBbYJL68SAuWdXSWijx9lTEkmWY1zKy/5+hTyhSCXwTaeK8M4VHuaw
 P6bw68odJ6BAzzfu+vLYtXH3snTgjk0L8MKXKOUrP+ndgFxCHnDi/wb9Xl3nYoOR9JmaQt7J9kI
 jtVER2C2wtBHwH9NI1txuT55Mujy2Kywh4AWzW+UyD/o+5OPBP0pz+UIeH/3bh4fM1o02+8+tZu
 HXI2w0gV75aAOQ/b8l88EI/g3axf36rnevsUeD8DmHvZoiZbBP7w8qvUPqmf0qXyjhw/4wAuOLj
 +cPw5D8rMm3V0O6T3aYnjudWrRBrox/+66kyVlCOHphusYUUGdGaAEHREBqjDc5WPLEecbkLErR
 T6L25nHaIxooyV1JcrSXHsf6OK68JHhNwrXAGuxPvYme6FF+yC/HBi4lKgvYY/gexOgvgEPbSk8
 PrqCB8Bh+UgBJ/566qzbhEKTbAZrwj1hSZ+2yk9qCnTqprP141H0Oav6cDFF1bLIsOIxr804a4y
 +7refNHwhj5KNG9n6fu3RRSnMcye4StU9J7uAcL0onArspVbis7lowN4LWa8VGg59tTOT3HGa20
 skOkzqPLUY1IixvV8sofVvPWhgvviQYtELdFD48RqY0nlPFCu/92D/OPIWMp9RsB3+IvtZpzFhY
 6aqESegYgGlFTRg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for Qualcomm QMP Super Speed (SS) UNI PHY found
in X1E80100.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
index 57702f7f2a46..6041d17c0e2a 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
@@ -32,6 +32,7 @@ properties:
       - qcom,sm8150-qmp-usb3-uni-phy
       - qcom,sm8250-qmp-usb3-uni-phy
       - qcom,sm8350-qmp-usb3-uni-phy
+      - qcom,x1e80100-qmp-usb3-uni-phy
 
 
   reg:

-- 
2.34.1

