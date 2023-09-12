Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAE779D257
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235900AbjILNct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235797AbjILNcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:32:31 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E3210E6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:32:07 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50078e52537so9505511e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694525526; x=1695130326; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B5TUXFOv6yn9qpDAW3kO5jAn0DGFePw29Rv/Qa+Dofg=;
        b=GUwYvW7TYXpM+51IA8ioyZdjor7F0OmR1JTfRAZQ/hSfoppZmd1R6meXI7tXnJMgJZ
         EwUpoHUrVroJFg8diOJBHvOURrK2u/OUWCGxKPY57XFCPxCkWGdSLvrmsUa0h393VWj+
         OjsayCgCOdzloxGL5BTE/Z7CVtmctum0NdPMd8XXwJ2HpllCqx14pOJBjdOjnKUxYCwt
         fspcGpDByO7y4qdf0Vaz/ikP3H1w8BZzfIs9FamWD452gd5qgtAn78S7nsK/9Am2QA9n
         OlFk3N/HqEvtbu52L11eABDp7CPoWoQ1z+8GSUnLRkMCjc/qetF7x/jM6BRGq1fX+aq4
         am1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694525526; x=1695130326;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B5TUXFOv6yn9qpDAW3kO5jAn0DGFePw29Rv/Qa+Dofg=;
        b=NUuZWbPGAETbUt7/2eLVjIhPNk/P/W5DdAfDefQ4Mv1TqYhTYU81VNiPUUCIcx1PPB
         rLfeNbeVB6EuB+Pa7Wj9atvBSw/sLhNUqQv5Vdbp/MUxwWnUij9T3RWQzRLxj9Ghmmv4
         B2HhhdoBIBjAp6pe/MEGgqbzw0jvqIFMh4e5k3v26maTbNbYRutIiB5CnfBT3yvTPlhI
         T6gB1x0I5FPpCPT0MFpWaxgbohEn5TwKlqtOM8FPMD9JApOCEoRi4zEld1oPbI6dLptu
         GkK23FY18CAf8qFVIqT3dbST2gbWj9a5wygCZA6QW/91MpvzjTWD6GSLtig80gVXU9eD
         8JyQ==
X-Gm-Message-State: AOJu0YydeGZ63rgVajmSwv1ZQIZ1+mmTC6eTNtz/MTVwhubi6ez1GYqS
        tecnKzy7knaOIF3OxMDe4+EK/g==
X-Google-Smtp-Source: AGHT+IHJT5ownOgbIaxSDc0bjTSHUboWqifcbF1bbRzUuxxzkufa54Qv6/pZdVwNX0+AypcHeAsw4Q==
X-Received: by 2002:a05:6512:36c2:b0:500:a2d0:51ba with SMTP id e2-20020a05651236c200b00500a2d051bamr8884352lfs.44.1694525526211;
        Tue, 12 Sep 2023 06:32:06 -0700 (PDT)
Received: from [10.167.154.1] (178235177248.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.248])
        by smtp.gmail.com with ESMTPSA id j2-20020aa7ca42000000b0052a401d8ef6sm5983830edt.71.2023.09.12.06.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 06:32:05 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 12 Sep 2023 15:31:47 +0200
Subject: [PATCH v2 09/14] dt-bindings: remoteproc: qcom,msm8996-mss-pil:
 Remove PNoC clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230721-topic-rpm_clk_cleanup-v2-9-1e506593b1bd@linaro.org>
References: <20230721-topic-rpm_clk_cleanup-v2-0-1e506593b1bd@linaro.org>
In-Reply-To: <20230721-topic-rpm_clk_cleanup-v2-0-1e506593b1bd@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Alexey Minnekhanov <alexeymin@postmarketos.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-usb@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694525501; l=1303;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=365nLiorSKhklpxOJKGzrpOJcjkDQ3JA1L7vx8xj8ao=;
 b=ySRL9bhp5qv2LV2atLTYfW8bK0jq1ULmiT06RNxNxp7RXo7yb3yJDGE30x8jvAVd8tI2P5hSh
 SmOedpd+V+SCvsris2NdjIHKDtQdhxNuBTsCKDJeGhS4i0WUKkpGulP
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PNoC clock is a clock for the entire PNoC bus, managed from
within the interconnect driver. Attaching it to MSS was a total hack.
Get rid of it.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml
index 0643faae2c39..971734085d51 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml
@@ -220,7 +220,6 @@ allOf:
             - description: GCC MSS GPLL0 clock
             - description: GCC MSS SNOC_AXI clock
             - description: GCC MSS MNOC_AXI clock
-            - description: RPM PNOC clock
             - description: RPM QDSS clock
         clock-names:
           items:
@@ -231,7 +230,6 @@ allOf:
             - const: gpll0_mss
             - const: snoc_axi
             - const: mnoc_axi
-            - const: pnoc
             - const: qdss
         glink-edge: false
       required:

-- 
2.42.0

