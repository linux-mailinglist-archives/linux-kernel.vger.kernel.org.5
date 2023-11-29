Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08D97FDBDA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343918AbjK2Pqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbjK2Pqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:46:45 -0500
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B80D67;
        Wed, 29 Nov 2023 07:46:51 -0800 (PST)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6ce2eaf7c2bso4117458a34.0;
        Wed, 29 Nov 2023 07:46:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701272811; x=1701877611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJ23N4x9xsyS+PdtjpIOJ1tiYnfSGNct1P34OTOLm2k=;
        b=WFQxqnhUA1kF2ZyYkKYSAu4AUdZtTlJJdl3XI+sUzPqC1HMR2LldNEqps51MKNEFQg
         GG+zOjA0NgU893x/HllDZkq29jcjK3zoPpVnHT9bFWrxsbudvn9xG/qZ/tDqQrBFKZl3
         fyM2a7QuQnNXsuV9XV5Kj0x82F69yKJ1zwqV1pmh3yxCNRR6EHYyHgeAKxm3n7JH/3XK
         GkW82uKANutpz8GQgtu8kCX0Q3zHfBNTFsOVTq16JuGy4ZBYrgMz5R2zWlGYtJECe7/R
         +g3ZBV2w+l5ZXi9HdcLMFMND6+GkVSSIg72h/mtLgcYTNABzKcF5O82k3Le4+kYm9iVu
         go/w==
X-Gm-Message-State: AOJu0YxDw/wTmPXBLwgxqWpeDSz/5OkCuL3dDwccGCJc+qSNJEnMUfwC
        vFTgtQTSl7c45QKT2j7YBA==
X-Google-Smtp-Source: AGHT+IH1cW5WeqpkTlob3Rn0FcoRYZoiNqB7GPItDNM4+VO90I/UqzXgHGRDuxBkDGTJ34CdR2GIPg==
X-Received: by 2002:a05:6830:34a9:b0:6d8:138a:dd8b with SMTP id c41-20020a05683034a900b006d8138add8bmr16934439otu.33.1701272810799;
        Wed, 29 Nov 2023 07:46:50 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d22-20020a0568301b7600b006b87f593877sm2023303ote.37.2023.11.29.07.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 07:46:49 -0800 (PST)
Received: (nullmailer pid 2542152 invoked by uid 1000);
        Wed, 29 Nov 2023 15:46:48 -0000
Date:   Wed, 29 Nov 2023 09:46:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH 4/4] ASoC: dt-bindings: qcom,lpass-wsa-macro: Add SM8650
 LPASS WSA
Message-ID: <170127280827.2542113.8003220554875038607.robh@kernel.org>
References: <20231129113014.38837-1-krzysztof.kozlowski@linaro.org>
 <20231129113014.38837-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129113014.38837-4-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 29 Nov 2023 12:30:14 +0100, Krzysztof Kozlowski wrote:
> Add bindings for Qualcomm SM8650 Low Power Audio SubSystem (LPASS) WSA
> macro codec, which looks like compatible with earlier SM8550.
> 
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/sound/qcom,lpass-wsa-macro.yaml  | 21 ++++++++++++-------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

