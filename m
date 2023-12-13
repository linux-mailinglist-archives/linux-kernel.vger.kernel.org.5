Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76855811F20
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbjLMTmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235370AbjLMSkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:40:42 -0500
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F177186;
        Wed, 13 Dec 2023 10:40:48 -0800 (PST)
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6d9d29a2332so3331095a34.0;
        Wed, 13 Dec 2023 10:40:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702492847; x=1703097647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MkULXo4mhKcg71U73w4rkp43EOuli/ib4+NFro1doXU=;
        b=h4oqfXX6pYxgNqIFmdJFNGgWreDQUTU5C+FimfIbI1zSxh4JMKEKcqVay8PqDRwIJw
         D936Qj6QfxUeq8DegVByNNqiSOnQMRJHoPGLdCtOXUMKt/mIa9NmPACz3Zl+SCPSet5x
         9eWRDWMWAiMXUk886uhX3rOGKNQYpvvZTz67TfLqKClSFXSnbsDxg5C1AmlnaNNmPxPr
         bssXT0rg1E17qu+doQe6OtEPahfH4wkYumkdRDwVg/V26r4IlXYFUNdCBaQLCVgvnBLL
         AOdOXpAndALOhdlxCEQZ3SUX3vAunFgEmMbKyhu/0Irvd7C2T+kz7TAJxbsQbQRILyyk
         PFEg==
X-Gm-Message-State: AOJu0YwJFVY/QT3Az1epuLHJeMgK6wqJ45ZSfmoJG0bexUG1jgXGCpeS
        x0sQo/7RAJVEkUumGJSNIg==
X-Google-Smtp-Source: AGHT+IELENIrqmlyue3dNgttQHCnHTUptGZ/xiBYpYZKegTnwRp23rEHAfgBChxnnkwfpFvLdwrpmw==
X-Received: by 2002:a05:6830:641c:b0:6da:262d:123b with SMTP id cj28-20020a056830641c00b006da262d123bmr2238780otb.31.1702492847650;
        Wed, 13 Dec 2023 10:40:47 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w5-20020a056830110500b006c619f17669sm2867203otq.74.2023.12.13.10.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 10:40:47 -0800 (PST)
Received: (nullmailer pid 1699707 invoked by uid 1000);
        Wed, 13 Dec 2023 18:40:45 -0000
Date:   Wed, 13 Dec 2023 12:40:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Shawn Guo <shawn.guo@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        devicetree@vger.kernel.org, Danila Tikhonov <danila@jiaxyga.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Martin Botka <martin.botka@somainline.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Iskren Chernev <me@iskren.info>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 06/10] dt-bindings: pinctrl: qcom,sm8650-tlmm: restrict
 number of interrupts
Message-ID: <170249284530.1699674.6881848735473134289.robh@kernel.org>
References: <20231208215534.195854-1-krzysztof.kozlowski@linaro.org>
 <20231208215534.195854-6-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208215534.195854-6-krzysztof.kozlowski@linaro.org>
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


On Fri, 08 Dec 2023 22:55:30 +0100, Krzysztof Kozlowski wrote:
> SM8650 TLMM pin controller comes with only one interrupt, so narrow
> the number of interrupts previously defined in common TLMM bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pinctrl/qcom,sm8650-tlmm.yaml         | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

