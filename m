Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB73811CE6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbjLMSk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbjLMSkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:40:18 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E521F3;
        Wed, 13 Dec 2023 10:40:24 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3b9db318839so5191140b6e.3;
        Wed, 13 Dec 2023 10:40:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702492824; x=1703097624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9q0N5+I2XeAWa13qGmbU24vDxavw3qyT6Mq11LfmaY=;
        b=wCn3bU0rvyRJUa1Z0cOqcEBq/lilfchX69j1CWgpBwFoeZ3f03Iv7RD7Vrm3f7PaFl
         MKfhyqsPeDQIj9/3buU0IvsanRLqP7/euWTul+RyYSzosajPbbU4r/84HWpKVD1QMMXv
         tosnhRr6+UEPG636hTQDV0vgJ8rahVe/kEv23Fz0eh03k1lRuKyqCg9V8BCG/sc+oHt9
         84oMmqkDwlQVBESkqXrO5LfvCwZqxAzkug4daiVbfpgOonJRLomag15SwjO9SRrCivLs
         xn2FHxDzzPUynBPxCL+uAk2v1bCSlU3O5cp1DRYgAMt8E8JA6fBRGcMpfyg4B32vlDXj
         tJ/Q==
X-Gm-Message-State: AOJu0YxD3wyCQ/IB+eJOr6HCi90Nd6K61m/Fj6TBfOOU61I5B2l2hiPN
        dTIBmOtk7ROLlC2lAqUj4w==
X-Google-Smtp-Source: AGHT+IFf1Cdi45kqzXGyoK8dJDdcjhO/uHBOKivm/Xv5cLfIp9q4l0hsbHNuiGZ0drgHp1kW9hHNDA==
X-Received: by 2002:a05:6808:bcf:b0:3b8:ba0a:3460 with SMTP id o15-20020a0568080bcf00b003b8ba0a3460mr9656391oik.17.1702492823823;
        Wed, 13 Dec 2023 10:40:23 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s17-20020a056808209100b003b6caf2accfsm3042792oiw.22.2023.12.13.10.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 10:40:23 -0800 (PST)
Received: (nullmailer pid 1698952 invoked by uid 1000);
        Wed, 13 Dec 2023 18:40:21 -0000
Date:   Wed, 13 Dec 2023 12:40:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Abel Vesa <abel.vesa@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Danila Tikhonov <danila@jiaxyga.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Rohit Agarwal <quic_rohiagar@quicinc.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-kernel@vger.kernel.org,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Iskren Chernev <me@iskren.info>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH 03/10] dt-bindings: pinctrl: qcom,sa8775p-tlmm: restrict
 number of interrupts
Message-ID: <170249282088.1698893.2429891810348063745.robh@kernel.org>
References: <20231208215534.195854-1-krzysztof.kozlowski@linaro.org>
 <20231208215534.195854-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208215534.195854-3-krzysztof.kozlowski@linaro.org>
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


On Fri, 08 Dec 2023 22:55:27 +0100, Krzysztof Kozlowski wrote:
> SA8775p TLMM pin controller comes with only one interrupt, so narrow
> the number of interrupts previously defined in common TLMM bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pinctrl/qcom,sa8775p-tlmm.yaml        | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

