Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF6378E14A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236495AbjH3VQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241009AbjH3VQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:16:36 -0400
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6FED7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:16:09 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-500a8b2b73eso465011e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693430035; x=1694034835; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UyTb34CC8o6Ht8AgxrBaKUd8noms1JfX94fq0UgPdCI=;
        b=OhxsDMJs+zPANSO1W98EtqVJlEn0fFRw3GEM6pEBg96BlJaeJJFipKKid0HhcaP3Kp
         R0zrJSOKUY/9Ch9kCPSiSzu2sRmKaJm4+hkWZ1KdeWmUMmVptjCDq6tcWYbBOMvKY9bE
         uwbDrHd85++bYG/rKc2JKk97va8y7A2FCns68bySmg2XGsMAux71kBWrCBBrA802VMwe
         keU42QlZGjmTJmqa21GJ7OmHyIZSYK5AWQUPFwxE6JgUq5tlii110+azTmqjlVXM8XX9
         JPs8zPC9Yz4K2SsnzjcwYcLX5w9R5FFTZVBuRaKQQH4zJ8Tu3e2tnPksEoPV4/3kuQoM
         r0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693430035; x=1694034835;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UyTb34CC8o6Ht8AgxrBaKUd8noms1JfX94fq0UgPdCI=;
        b=DOzvdPBXAyO4kFF880dGp8gCN3E+5VnLgntCd3T8f7j1V8wrS0cZ5riZZovRXucR4d
         st5QZzwnLH4yf1cViC6Hv3niozoqgJzSY6Sb+X3t2UanjIDpFH0JbmKr/XQzZ14uO81U
         luqr5WbvSonqCjs+d600EKHqKjhcUDb0VMdeIb2UypKr6x2q6b8mvaDjHXiOrykwpztO
         bDC3lf+qPWa+J7aEOwYSTJip1IFHSpNqkyfKshrOCFzwiBHjUXqNb+Z9NjnGPRfv725q
         yv6X11sBSypefrykJi+30BqgWYgvjyBoRvrQfvEdntXEiQq9vbXZCePhnOB4xdFAleQk
         0UDA==
X-Gm-Message-State: AOJu0YwYw+91TyUsjHep0QZwouUp2LOi2v5U+XDU4DTwfpxlHldK3FcW
        j5iR5H+onAF9Yw3U5hHsX2B5ng==
X-Google-Smtp-Source: AGHT+IEzmGKuK2006TWdjdLApsy6n7D2FXVYkf7FTUBXVsxQ81IWEUBLq0vJch02O7U6IiqOWnnJWA==
X-Received: by 2002:a05:6512:3c8b:b0:500:5d5c:ecc9 with SMTP id h11-20020a0565123c8b00b005005d5cecc9mr2813219lfv.62.1693430035654;
        Wed, 30 Aug 2023 14:13:55 -0700 (PDT)
Received: from [192.168.1.101] (abyl195.neoplus.adsl.tpnet.pl. [83.9.31.195])
        by smtp.gmail.com with ESMTPSA id b3-20020ac25623000000b004f37bd02a89sm2516351lff.287.2023.08.30.14.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 14:13:55 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 30 Aug 2023 23:13:51 +0200
Subject: [PATCH 1/2] dt-bindings: phy: qcom,usb-snps-femto-v2: Add REFGEN
 regulator
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230830-topic-refgenphy-v1-1-892db196a1c0@linaro.org>
References: <20230830-topic-refgenphy-v1-0-892db196a1c0@linaro.org>
In-Reply-To: <20230830-topic-refgenphy-v1-0-892db196a1c0@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693430032; l=921;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=vz1a+iPTk87wOT0fjsMmHkhaWg81ePPnVEq7IVR09VI=;
 b=DeUqTuNNnWAlhWqgl4R5rZoKMeEWwhxo81jSLACtmX0W8ScXz/2107XWlPhOWn21pFFsePvgh
 IoQZZ+Zu85uBLJt03N/briK2+2TsjrZ++D8IVfgBxSenH37ey2PQ9lG
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HSPHY is (or at least can be) one of the users of the reference
voltage generating regulator. Ensure that dependency is described
properly.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
index 0f200e3f97a9..e895b6c4ee49 100644
--- a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
@@ -53,6 +53,9 @@ properties:
     items:
       - description: PHY core reset
 
+  refgen-supply:
+    description: phandle to the REFGEN regulator node
+
   vdda-pll-supply:
     description: phandle to the regulator VDD supply node.
 

-- 
2.42.0

