Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4627F811CE0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjLMSkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbjLMSkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:40:07 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56FC124;
        Wed, 13 Dec 2023 10:40:13 -0800 (PST)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3b9dd6886e2so3012274b6e.3;
        Wed, 13 Dec 2023 10:40:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702492813; x=1703097613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bk16U5scx1tPHB/sUHe34ccYiT/Dghekb93ELXvO8dI=;
        b=PktheiHuNTuS4dwrDnZ3yE7E2AK8HHl7/1tA+xmlzvjyy8DpUHlXt2qG/RsSGOukGJ
         Z4562ss/WDWH65bazQCXr5E+HLtgDWmWlKrlNZAynXuk+JRyNa+j7rvHkYuJTE3wrAw0
         RyCmkC6C6jt2Srnoash+QhVUGftChUxjN3zO+bnjtY8AnnYPjTlZ1snR+/6EEca8DBrS
         INzzMgnAT3lNz544iWNXyD05CeRSgiPnnBiMKWxusUpxiXB+3w7BOsTzISRl24RxNMYJ
         zCOW6PKjTgK/Yd+ehHqXJtGHpnSfUFx5Z3eS1DmdVHjyMsO8UIfNz5NrAQqpTwz9V6RU
         Gqvg==
X-Gm-Message-State: AOJu0YzbsxQvJ2zQI9CMTfaCUPnMtZl+HHZdXU38jLz9dZydY/DSi2bd
        0y0+Jvbx6fQkxbuwP1uykQ==
X-Google-Smtp-Source: AGHT+IGLvpIcUlvOnEFpKET/HqBWExVFfLIVAo2ChPmpSua5/uQPxyF5cM+bTORC3n5Brh16ThZ0GA==
X-Received: by 2002:a05:6808:118c:b0:3b9:e120:6a10 with SMTP id j12-20020a056808118c00b003b9e1206a10mr6107903oil.12.1702492812942;
        Wed, 13 Dec 2023 10:40:12 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l3-20020a056808020300b003b8388ffaffsm3049163oie.41.2023.12.13.10.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 10:40:12 -0800 (PST)
Received: (nullmailer pid 1698665 invoked by uid 1000);
        Wed, 13 Dec 2023 18:40:11 -0000
Date:   Wed, 13 Dec 2023 12:40:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Abel Vesa <abel.vesa@linaro.org>, Iskren Chernev <me@iskren.info>,
        Shawn Guo <shawn.guo@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        devicetree@vger.kernel.org, Danila Tikhonov <danila@jiaxyga.com>,
        linux-gpio@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rohit Agarwal <quic_rohiagar@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        Richard Acayan <mailingradian@gmail.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Botka <martin.botka@somainline.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 01/10] dt-bindings: pinctrl: qcom: create common LPASS
 LPI schema
Message-ID: <170249281039.1698604.14736933847927766425.robh@kernel.org>
References: <20231208215534.195854-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208215534.195854-1-krzysztof.kozlowski@linaro.org>
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


On Fri, 08 Dec 2023 22:55:25 +0100, Krzysztof Kozlowski wrote:
> Just like regular TLMM pin controllers in Qualcomm SoCs, the Low Power
> Audio SubSystem (LPASS) Low Power Island (LPI) TLMM blocks share a lot
> of properties, so common part can be moved to separate schema to reduce
> code duplication and make reviewing easier.
> 
> Except the move of common part, this introduces effective changes:
> 1. To all LPASS LPI bindings: Reference pinmux-node.yaml in each pin
>    muxing and configuration node, to bring definition of "function" and
>    "pins" properties.
> 
> 2. qcom,sc7280-lpass-lpi-pinctrl: Reference pinctrl.yaml in top leve.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../pinctrl/qcom,lpass-lpi-common.yaml        | 75 +++++++++++++++++++
>  .../qcom,sc7280-lpass-lpi-pinctrl.yaml        | 49 ++----------
>  .../qcom,sc8280xp-lpass-lpi-pinctrl.yaml      | 49 +-----------
>  .../qcom,sm6115-lpass-lpi-pinctrl.yaml        | 48 +-----------
>  .../qcom,sm8250-lpass-lpi-pinctrl.yaml        | 49 +-----------
>  .../qcom,sm8350-lpass-lpi-pinctrl.yaml        | 49 +-----------
>  .../qcom,sm8450-lpass-lpi-pinctrl.yaml        | 49 +-----------
>  .../qcom,sm8550-lpass-lpi-pinctrl.yaml        | 49 +-----------
>  .../qcom,sm8650-lpass-lpi-pinctrl.yaml        | 49 +-----------
>  9 files changed, 109 insertions(+), 357 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-common.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

