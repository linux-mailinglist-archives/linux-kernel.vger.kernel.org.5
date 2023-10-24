Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9646E7D5A1D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 20:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343983AbjJXSGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 14:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjJXSGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 14:06:46 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2E310CF;
        Tue, 24 Oct 2023 11:06:44 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3b2e330033fso3017176b6e.3;
        Tue, 24 Oct 2023 11:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698170803; x=1698775603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ae7vdk1cQp2CgRsl6yINY1JpUls8w4HQJ67tzSmt9A0=;
        b=uDDFConsnqJFTtaPZxcoZC+63l8BtKn65hkUfBKamCudPeRKwcS66fTyqE69TMjErh
         PEJLB+oW0s3O5v6smNo1cvBTJCEjvxkgkQaopD/sKdBVh2EA31oJDY5WYsTgkIDZx5/Q
         OsvgzFP/TE6vIDh1oXjuD54249PM4Mv2jfqKoKHk1v2ySta1sYKCMDRAQ8UYQJwGcRBu
         mjXMupCLjxQ4aSOIZKrbc8J0vTMomTbceOZOFWX5mkBtP4YzIMkfQyNevs10vApiRna9
         x5Cqnso3igoHmZTw5hm3uPvz7s2Bp6D85Pb5VfPVAHGRXedB38DbsmTU3WSZIhjBLeoa
         E02w==
X-Gm-Message-State: AOJu0YxvcPc0xmNYx2NCS9GL8XGBKtIUV2wG3tlqi5Nn5O4Na93Vet0S
        Vp4LjHXyuboNbMknciJLqQ==
X-Google-Smtp-Source: AGHT+IG+8Y/FODuDVm+nbBrX5HhQB4VI2MEKaHKAdSIDI3y2soo5kgXrrhy01QfKUQw1pDP7XyUVoA==
X-Received: by 2002:a05:6808:a06:b0:3b2:e469:903f with SMTP id n6-20020a0568080a0600b003b2e469903fmr14132710oij.15.1698170802826;
        Tue, 24 Oct 2023 11:06:42 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j19-20020aca1713000000b003b274008e46sm2044677oii.0.2023.10.24.11.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 11:06:42 -0700 (PDT)
Received: (nullmailer pid 215374 invoked by uid 1000);
        Tue, 24 Oct 2023 18:06:41 -0000
Date:   Tue, 24 Oct 2023 13:06:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom,sa8775p-tlmm: add missing
 wakeup-parent
Message-ID: <169817080056.215320.12489087678601922929.robh@kernel.org>
References: <20231018145750.429385-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018145750.429385-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Oct 2023 16:57:50 +0200, Krzysztof Kozlowski wrote:
> Add missing wakeup-parent property, already used by DTS to indicate that
> pins are wakeup capable:
> 
>   sa8775p-ride.dtb: pinctrl@f000000: 'wakeup-parent' does not match any of the regexes: '-state$', 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/pinctrl/qcom,sa8775p-tlmm.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

