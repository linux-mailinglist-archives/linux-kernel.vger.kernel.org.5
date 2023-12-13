Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF974811D0D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377921AbjLMSmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233703AbjLMSlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:41:53 -0500
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52438198;
        Wed, 13 Dec 2023 10:41:58 -0800 (PST)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6d9f4eed60eso4392439a34.1;
        Wed, 13 Dec 2023 10:41:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702492917; x=1703097717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6hnC07KzQLENIA7eocm0YNr1M8TmUcaLuIx8ujcxeA=;
        b=Jn3WlZMeH5H7Z0Z4AUGSAhDPqvE+Mlg3AhsRuMeVrifCdWymV6Z2RUep+yUsV+n3XC
         O4F6fiOM7vpsBz47bq/UojGqHGiBACp4dBRi7pv9I/ie0iSInSV8WYPt7BKH6M5FO/8L
         3JbDdXO9i3dSGjTcrlK8bn5b6llW7xmSN3K+M5UkzJOH6g00Jy7JPe/EwI6ga+DAyEpJ
         XvKsk3kuDOCSkHwxKgfQH/qxNBrF+CCw566pmmicnX+J0eCI7FyJqkxOrMaSg9EvqaGh
         EC6KGI4//cB/vO0gFJEiPhH9LBoSs4YdSorrOVkoy8pQP5z+p8gkpr7vup9AxN2yj4PQ
         bMeg==
X-Gm-Message-State: AOJu0YznYEcc9FO0WnfVb6E2mf+da0DwENWkgw+FwoAIVrdUqF+F2/jI
        SbnkVBguPcFnt3tPM5upSw==
X-Google-Smtp-Source: AGHT+IHcGZMy5l4vtqVLoJG/8de6K3BbVb9iRhkWeLsVUPExCV0QeWmen3h+A5LXk1SwuVn2iig+oQ==
X-Received: by 2002:a9d:69d2:0:b0:6d9:a81b:3735 with SMTP id v18-20020a9d69d2000000b006d9a81b3735mr9929395oto.45.1702492917626;
        Wed, 13 Dec 2023 10:41:57 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h24-20020a056830165800b006c4f7ced5d2sm2869178otr.70.2023.12.13.10.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 10:41:57 -0800 (PST)
Received: (nullmailer pid 1701307 invoked by uid 1000);
        Wed, 13 Dec 2023 18:41:55 -0000
Date:   Wed, 13 Dec 2023 12:41:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Iskren Chernev <me@iskren.info>,
        Danila Tikhonov <danila@jiaxyga.com>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Martin Botka <martin.botka@somainline.org>,
        linux-kernel@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        linux-gpio@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        devicetree@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rohit Agarwal <quic_rohiagar@quicinc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 10/10] dt-bindings: pinctrl: qcom: drop common properties
 and allow wakeup-parent
Message-ID: <170249291501.1701227.12108329987370274288.robh@kernel.org>
References: <20231208215534.195854-1-krzysztof.kozlowski@linaro.org>
 <20231208215534.195854-10-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208215534.195854-10-krzysztof.kozlowski@linaro.org>
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


On Fri, 08 Dec 2023 22:55:34 +0100, Krzysztof Kozlowski wrote:
> Drop common properties already defined in referenced common Qualcomm SoC
> TLMM bindings and use "unevaluatedProperties: false".  This makes the
> binding smaller and easier to review.  Additionally this allows now
> "wakeup-parent" property coming from common TLMM bindings.
> 
> In few places move the "required:" block to bottom, to match convention.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,ipq6018-pinctrl.yaml |  8 +-------
>  .../bindings/pinctrl/qcom,mdm9615-pinctrl.yaml | 18 ++++++------------
>  .../bindings/pinctrl/qcom,msm8226-pinctrl.yaml |  8 +-------
>  .../bindings/pinctrl/qcom,msm8953-pinctrl.yaml |  7 +------
>  .../bindings/pinctrl/qcom,sdx55-pinctrl.yaml   |  8 +-------
>  .../bindings/pinctrl/qcom,sdx65-tlmm.yaml      |  8 +-------
>  6 files changed, 11 insertions(+), 46 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

