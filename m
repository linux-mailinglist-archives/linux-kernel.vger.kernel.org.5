Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D15811CF4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbjLMSkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbjLMSkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:40:24 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B4B116;
        Wed, 13 Dec 2023 10:40:30 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3ba2e4ff6e1so109970b6e.3;
        Wed, 13 Dec 2023 10:40:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702492830; x=1703097630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjZj66GLbXTUfCywC1vMaQREynkAslvoiTIlAljpkog=;
        b=DtsooEuZ8HCFIpucHBI0XeYReyUzbX/TtoU77v3tG/wjT/MhCnTvSYOofdigf7pydb
         XNsQ1IfPA12gNmAWyZ33eg4z7w2KJIgefD7chCl7gWA3X5F45TA20vvvyG9df8GnY6oZ
         1naHN3LuLGkH5KXQE68FS4dv9ZdOrFH1HXDwOYSL+3QwdDdS/HpQPKRGYX3tMm1XqhA4
         wkrJbv2uC4NRzOZjIxTKW3BruIZXNrkAHq6/ebKK77zdF5wpuHkmOc0NNyBJhrnK8FCe
         bYbwgviKq38afkVzX/b0L5goPpq0Tq/VMEj+S6Onlho39BykDMpXqLF0EwOYqxC3DtN4
         F56Q==
X-Gm-Message-State: AOJu0Yyd4AW6sMCl5BzAoJkzrPECMhDDZKicSOVOyyXmsMzohbPUBM92
        B6vxNCGkVR0pfms40qlSXQ==
X-Google-Smtp-Source: AGHT+IGVUA0LU1LAUmke6RBPdZGGE1uaTC6yTHJDnD2or9ucPVr28VxLqx1bv5ILNg3C6KRUFd8N6w==
X-Received: by 2002:a05:6808:1454:b0:3b9:dc8e:1fe4 with SMTP id x20-20020a056808145400b003b9dc8e1fe4mr9998506oiv.73.1702492829902;
        Wed, 13 Dec 2023 10:40:29 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h6-20020a056808014600b003b9d5e265f1sm3063940oie.2.2023.12.13.10.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 10:40:29 -0800 (PST)
Received: (nullmailer pid 1699187 invoked by uid 1000);
        Wed, 13 Dec 2023 18:40:27 -0000
Date:   Wed, 13 Dec 2023 12:40:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Rohit Agarwal <quic_rohiagar@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Iskren Chernev <me@iskren.info>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>, devicetree@vger.kernel.org,
        Melody Olvera <quic_molvera@quicinc.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, Danila Tikhonov <danila@jiaxyga.com>,
        Martin Botka <martin.botka@somainline.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-gpio@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
Subject: Re: [PATCH 04/10] dt-bindings: pinctrl: qcom,sdx75-tlmm: restrict
 number of interrupts
Message-ID: <170249282710.1699125.3122123137876603611.robh@kernel.org>
References: <20231208215534.195854-1-krzysztof.kozlowski@linaro.org>
 <20231208215534.195854-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208215534.195854-4-krzysztof.kozlowski@linaro.org>
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


On Fri, 08 Dec 2023 22:55:28 +0100, Krzysztof Kozlowski wrote:
> SDX75 TLMM pin controller comes with only one interrupt, so narrow
> the number of interrupts previously defined in common TLMM bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pinctrl/qcom,sdx75-tlmm.yaml          | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

