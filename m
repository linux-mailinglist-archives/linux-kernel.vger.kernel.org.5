Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618F27843A1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbjHVONC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236632AbjHVOMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:12:38 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464DAE55
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:12:16 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe8242fc4dso44764105e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692713491; x=1693318291;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gtuVpXwzMWaEGB5Cog4rldjWRfctqtTvAKEr2qA47a0=;
        b=jrsLu4OK5YNUPhALPL0I23aolOPR0gxWLbx3ArwjKaqJFKr7lrHWqM20Cw/SCIQEAt
         EK3RpfCgATOkdJZeCsUaPyXXPOI81zRnRt86ZQ9+vHZUNc0N1GKQ+wwOZO8XD1fE39NM
         r7IiKKjFomA51ccrBcdxBPsKW/q4tAywISe6wTx9f5P9iA/25oN9i40H/gv5lmB2tpG4
         A5DO9v2/70CIeNC0VkpHZOXd6h6X2cVK2gMOiJnpRBMTCpSM2AN9HY2/BdIMNoYkOTLr
         NgxVq2D0hT0JvAbJdvTvfOvCAMsNs3VQYRH9wC9kaoQT05RLp1gdb67xqmIX5b3rO2X/
         g/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692713491; x=1693318291;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gtuVpXwzMWaEGB5Cog4rldjWRfctqtTvAKEr2qA47a0=;
        b=JE7hEC1rAmTXMDJrJerxbTe922SdGHZNscxHFpu5cHirZMBTQdK4xtItRki+pCu/Cd
         LBAP+2r6O9Q2/6JfDwaYHa5/Pmjq7zf29w19goASUZxtliTZ/kT7OXUBVGwlahpShvcl
         WCIsb5O/3tgfb3kb1sVqKQw+2hasds3Sby36bQgXHkMb7aHs3uLNlvHy4mbyouF2bKNj
         VTkMC5ecB4hZpAPFmyltQqfGJypvwBUOb/HfAo9KXqnDHN1WXWHQCozQxmyDR3rQrZwS
         91yQhi+WdMLT/tqiKpJ9UZpD94MNydLGWTBpubPtXwJpNj1ifhPJQyeNXdk2o5rvEqqO
         c0JA==
X-Gm-Message-State: AOJu0YxWAm5pabAOCpD7eCIT1Iw8B7R9l/TNkjigQP1kYxxqnYNgHwkQ
        znRPJjVAM99AD8hN7EwaHIGxUQ==
X-Google-Smtp-Source: AGHT+IG3axjvpue4qJhnlyhDa9rG2BdtfVF5SwL11Xk400+vtf82q0540IzXmG0em8nbpnu1dvRaOA==
X-Received: by 2002:adf:e6c9:0:b0:313:dee2:e052 with SMTP id y9-20020adfe6c9000000b00313dee2e052mr7424653wrm.26.1692713491002;
        Tue, 22 Aug 2023 07:11:31 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id m9-20020a05600c280900b003fe539b83f2sm19587753wmb.42.2023.08.22.07.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 07:11:30 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 22 Aug 2023 16:11:25 +0200
Subject: [PATCH 2/2] arm64: dts: qcom: sm8550: Add PRNG
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230822-topic-sm8550-rng-v1-2-8e10055165d1@linaro.org>
References: <20230822-topic-sm8550-rng-v1-0-8e10055165d1@linaro.org>
In-Reply-To: <20230822-topic-sm8550-rng-v1-0-8e10055165d1@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=759;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=OJpdRyF5Au18OAODNZEy6fBEK+Vc+azzodyRiMN3bls=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBk5MIP76cER9EmyxruqX9NYGR6Jn0RJnTMzyheD4Ut
 zX0fxUeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZOTCDwAKCRB33NvayMhJ0RK5D/
 4tNEi6O+SlSFOeJZvyWu1fzMBWkKIizUTOm7fYnRQ6HuLks1bVXeo7B89Mh9kQU5IZEhy0NWVe27mM
 UINmm2mFfnO55TvEWuDzMrYZK+vbMebZgpP5vif56SjEBefeasFElXR2WFEc7Vz8M73tYVRIBdn6gN
 8cXCbu1BzW0NW11RXY9r2ohM3V80Z/EsqXRJac83wboswvVIJnvbhHtHiLKaQ+AKS2TqrAe8qpF2nZ
 G/J4lu/dDFtAn4gVScbCkFlQiFDwLZgwpWhqe8ILkzEmQjLy+VFzeUlCRp7nBGsLED2gWA0BttHItC
 vQUzPJEkE3gu9mCCu50LMaJPqEqT7FFEZskGvV3XTgUB/kEdHQgu5c+RVEtUG09wK4ObAcECxMnWeS
 H/3qkHqK/h2Hunc6BIWSpDa401wht9+Yr2Dj08Ibuz6f0YkOPhdKSOh7Q7MKzwun8QL1MNr+xt25GV
 uuZoL48R90MJbqr0FClxYajfI9DvQJWLclpyKJQjccQzWR3/uAMW2TvaPmzUpHkCioVJBgLI2IWFx/
 +bAqBsN9w9qqlpK5tQ7OG2T+H85Rx0ciL/lGH2IAr3kkZLw/8VVbjyBNp2dIbYoqL26/ondxjOfy0w
 wZRT6wMn0+79AwOyS6G/aUwJTuSLGzjhp4RUPzDPqKQYIam684Azn59PKRNA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Qualcomm Pseudo-Random Number Generator.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index d115960bdeec..643ec80feacc 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -1661,6 +1661,11 @@ mmss_noc: interconnect@1780000 {
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
+		rng: rng@10c3000 {
+			compatible = "qcom,sm8550-prng-ee", "qcom,prng-ee";
+			reg = <0 0x010c3000 0 0x1000>;
+		};
+
 		pcie0: pci@1c00000 {
 			device_type = "pci";
 			compatible = "qcom,pcie-sm8550";

-- 
2.34.1

