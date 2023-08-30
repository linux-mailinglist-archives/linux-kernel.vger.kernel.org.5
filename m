Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7290A78DB5F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238747AbjH3SjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244248AbjH3Msy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 08:48:54 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8897CD2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 05:48:50 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2bcc331f942so10311851fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 05:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693399729; x=1694004529; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tWkuNyNpN35mUdPo9osM+UvbCZY9NRuobjLnr6Z6HMI=;
        b=sSFEkiCBX3hFqR6l2ESC6Ze2Xv8sHKa9NYGmcIbpu3NGJZ3TqInyjXBlui8V/Jto0t
         swM9GMHAl+Qp3vLUdO4KXnDKCVScwgeSynZw2I+rpsv4YeXdRaXD/06nXDaQJsx8uo+N
         GkiiOVVcOt8XRtAuElYex6Qx/ZHJql2knZr9wPMQ0sVX+wvVRyr+E+Yxh/+aLM7aGveH
         lPb2cTlIV/q1ZVXBYmcGZ74+M4U+lqqJhh714Nyc0mwLp8XSlez5+70nTiytH1WG8V3T
         yjSGvDBAX/XqzEXIcPDsuemkkbxPhcbGE9v6wh0zTWZKdXi/RUuLfgxli/2z6ZVnZ+Eh
         NBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693399729; x=1694004529;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWkuNyNpN35mUdPo9osM+UvbCZY9NRuobjLnr6Z6HMI=;
        b=TQCl2BS5idH08JJRaYdHJ8ce3uLOJGBq765ofyNLOX5UWLemb5aSsp1zoN0Zl/+3eL
         FtXNZOugoifLYwmbRAPKiwOyUMkE/MgW2kbM1UVWw+9lKqb8/Kr+/wImZpRc4rpfS5hY
         SblPoNYFbsbPxVBY3q+tpH/PO8U1rSjkYXgblMoZGBPzzAt6qn2De/Q0dlMzmd/tbhAA
         Qz1g2yWbryCxv5lwse1iEyZzlwx+NyXlSYO7/llDtd58K/zp70bTgDuqWrPPjL6YHmvV
         LZBk/tfnspG4JmUcnSsHlAuXlRMqSzFP3U79BC1h4Xn72G0PLGv8s7nL87KyBvF0ZhQ2
         O+/g==
X-Gm-Message-State: AOJu0YyXNd+R7qICg1Fi8D4Wehh0FvpCdhVyzmbgjlpACMZxe+WIbWwx
        kyNMb6acV9A2Lj4R8O1lcVPuWQ==
X-Google-Smtp-Source: AGHT+IHnTIGMZI8k8PHQCgawzuSVJ+4ZmqO1+OtbsAv1rszk4da6sggiDWDSJgEzOWurdA6UTHV+OA==
X-Received: by 2002:a05:651c:2314:b0:2bb:7e3f:3cc2 with SMTP id bi20-20020a05651c231400b002bb7e3f3cc2mr2083506ljb.2.1693399729224;
        Wed, 30 Aug 2023 05:48:49 -0700 (PDT)
Received: from [192.168.1.101] (abyl195.neoplus.adsl.tpnet.pl. [83.9.31.195])
        by smtp.gmail.com with ESMTPSA id y23-20020a2e7d17000000b002b94b355527sm2602662ljc.32.2023.08.30.05.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 05:48:48 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 30 Aug 2023 14:48:41 +0200
Subject: [PATCH 2/7] dt-bindings: qcom: geni-se: Allow dma-coherent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230830-topic-8550_dmac2-v1-2-49bb25239fb1@linaro.org>
References: <20230830-topic-8550_dmac2-v1-0-49bb25239fb1@linaro.org>
In-Reply-To: <20230830-topic-8550_dmac2-v1-0-49bb25239fb1@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693399725; l=710;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=CppecVFIy2DoqbEQwzZdR+9tg6tYiwkRdQB1uCJt3Uk=;
 b=1W0O6Wei8zx7qhG0OegNkxw9mq9RE0tWQdW4sZEAZXQkjwthGZWHtFarTl/I/KRpha9uXkOJd
 xqjIz3ppSuoDkXD4iNn9zf0dCmG0yXSaM5kfUze/b8/Ef14pXrObwYT
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On SM8550, the QUP controller is coherent with the CPU.
Allow specifying that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
index 8a4b7ba3aaf6..7b031ef09669 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
@@ -52,6 +52,8 @@ properties:
   iommus:
     maxItems: 1
 
+  dma-coherent: true
+
 required:
   - compatible
   - reg

-- 
2.42.0

