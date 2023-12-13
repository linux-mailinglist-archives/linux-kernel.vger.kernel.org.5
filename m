Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5920A811CF8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378909AbjLMSlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235406AbjLMSkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:40:49 -0500
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C8411D;
        Wed, 13 Dec 2023 10:40:55 -0800 (PST)
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3ba1be5ad0aso1621479b6e.0;
        Wed, 13 Dec 2023 10:40:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702492855; x=1703097655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6QChL3UFwengUkFQ589Gbhv55ese1QQ3B9A2PboGzU=;
        b=n18J8HsuKj+FNA87YZYIgu/hdKDtCTkav6ZGLa2CmVc7VAFPeS2dQ5VxhPQi9r0hmC
         vUYh2dMnPhyqgUt3I2KvpvUW11O8IyB54SW9SZXStEVLbHkyU6rQAD7AwnK7ZQsSPBRM
         WCVyfRXMUcA3ViaeedCNmI7Nq48YiviCaYWGdzdc3rDjA1ER6E6qGADYMvJO79Ymfq2+
         pS9jLeWpCBz+bMc4pY2USEjLTXxutuhIpVJRnJGUeJJD/KaD//L0e1RgL0DmvAVRGOD+
         Yj11bhTzdiJrNCCp+YZpsJjFHBlIX9M3pgN1xjUTp/rQnPMDp/9pNH40S6dA/OrxZqpg
         Nobg==
X-Gm-Message-State: AOJu0YxYCxFqMy8Ddkfx5wdXIJGj1X8wjIvZnu3Hcvq2oJn2ArDp3Gzq
        K9RtL7ZKs1xiY054xVVyrA==
X-Google-Smtp-Source: AGHT+IF1/EHzltMGERiH/L5f43NfOspJ45HQqmi+bmGVwSNHWW9thVXvR+THDQl0GwhU16/ZaLTNWQ==
X-Received: by 2002:a05:6870:9e83:b0:203:382c:392c with SMTP id pu3-20020a0568709e8300b00203382c392cmr561942oab.72.1702492855044;
        Wed, 13 Dec 2023 10:40:55 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id mm3-20020a056871728300b001fb05cf9dfdsm4065102oac.19.2023.12.13.10.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 10:40:54 -0800 (PST)
Received: (nullmailer pid 1699960 invoked by uid 1000);
        Wed, 13 Dec 2023 18:40:53 -0000
Date:   Wed, 13 Dec 2023 12:40:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rohit Agarwal <quic_rohiagar@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-gpio@vger.kernel.org, Danila Tikhonov <danila@jiaxyga.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Iskren Chernev <me@iskren.info>,
        Richard Acayan <mailingradian@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 07/10] dt-bindings: pinctrl: qcom,x1e80100-tlmm: restrict
 number of interrupts
Message-ID: <170249285252.1699898.2447894163438031564.robh@kernel.org>
References: <20231208215534.195854-1-krzysztof.kozlowski@linaro.org>
 <20231208215534.195854-7-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208215534.195854-7-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 08 Dec 2023 22:55:31 +0100, Krzysztof Kozlowski wrote:
> X1E80100 TLMM pin controller comes with only one interrupt, so narrow
> the number of interrupts previously defined in common TLMM bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pinctrl/qcom,x1e80100-tlmm.yaml       | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

