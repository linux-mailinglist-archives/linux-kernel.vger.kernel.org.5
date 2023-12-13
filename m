Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA843811CF6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbjLMSk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbjLMSkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:40:32 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FE5115;
        Wed, 13 Dec 2023 10:40:39 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3b9e6262fccso4483084b6e.3;
        Wed, 13 Dec 2023 10:40:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702492838; x=1703097638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZqgf+NEHlDMkFq7LELFGKj9ja6j83ZZDIMHua0p/B0=;
        b=qlLjtYHhnM0Txdsla4MPj3eL0rPRY20LjwddVj7d1BORGiPxnYYPgSx0Z+z1sHFpcy
         EbuE998Vtk2NcWDSBVXJEsm7m+y4SUpErnQr2XHFNFVShR3K+5Z8Tze1ANAMsvmwDFWp
         YftKI933lJal0OZgNLKwGzDIb35ipTJ9Y9q2Fc5/gthETWXj0ygLmM4ZdtQz7OCyeO2U
         jn1SGFt3phnsSmmJd/PIKXiXys4JwIrrIM3JWOMu3ZllzfB6uaCrD/PEDK5Y2pokvyfC
         NhxGpIxlF1AZgw5zFWbkmMTEFdKuv0XZluSiWBd9bX4J54Lka3eLeZUye0kKc7kHmvQs
         B2hQ==
X-Gm-Message-State: AOJu0Yzs+xEKWaZk2a2rgCjSD+t/GFVX93P20d66BWyR6ztD2+4yE/4l
        yCJIEtB8euivItAv+JDNYQ==
X-Google-Smtp-Source: AGHT+IHtDotQAiV0YdzAJz3QxciCuKH8qD00YpcKsOvdg7C0hMME/WleZlH6/RTbjinwJZngn0GRIg==
X-Received: by 2002:a05:6808:1312:b0:3b8:b2c0:e30e with SMTP id y18-20020a056808131200b003b8b2c0e30emr11800606oiv.40.1702492838564;
        Wed, 13 Dec 2023 10:40:38 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 6-20020aca0f06000000b003b8b28a3ef6sm3034972oip.14.2023.12.13.10.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 10:40:37 -0800 (PST)
Received: (nullmailer pid 1699435 invoked by uid 1000);
        Wed, 13 Dec 2023 18:40:36 -0000
Date:   Wed, 13 Dec 2023 12:40:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        devicetree@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
        linux-gpio@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Danila Tikhonov <danila@jiaxyga.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Rohit Agarwal <quic_rohiagar@quicinc.com>,
        linux-arm-msm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Iskren Chernev <me@iskren.info>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Martin Botka <martin.botka@somainline.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 05/10] dt-bindings: pinctrl: qcom,sm8550-tlmm: restrict
 number of interrupts
Message-ID: <170249283593.1699383.3944942647536894581.robh@kernel.org>
References: <20231208215534.195854-1-krzysztof.kozlowski@linaro.org>
 <20231208215534.195854-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208215534.195854-5-krzysztof.kozlowski@linaro.org>
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


On Fri, 08 Dec 2023 22:55:29 +0100, Krzysztof Kozlowski wrote:
> SM8550 TLMM pin controller comes with only one interrupt, so narrow
> the number of interrupts previously defined in common TLMM bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pinctrl/qcom,sm8550-tlmm.yaml         | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

