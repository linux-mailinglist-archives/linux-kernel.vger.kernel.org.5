Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D025E77E751
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 19:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345100AbjHPRKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 13:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345109AbjHPRK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 13:10:28 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA23126B5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 10:10:22 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4ff8cf11b90so2362848e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 10:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692205821; x=1692810621;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xxCwuqjPcl+IJA8BvbLFYWTyePxgeQPUkGWOK9EtNqI=;
        b=mkpQ0woCJzp7wN5rDFIqeyIKJOlw6h0u+DTTiJDMtOJW+L32iGlp5pz8fhrqan4Olb
         XunbnzPLRLro6Jntfn+eLF+sRpgYaiYRK3H2s9Meg83EV5cYy6agudihU/RuvpjT9MHJ
         grK+uVRMBDEhFsMIztqySA+k7l+rnkvzadbFJvX7kQIAojgnwdqfdvVm32i81Pv8YzkK
         QuM1qHm5WfxAf0Aga4LCOKUaGDLzgQR/tLsX8Jh9XQfuJ97KaYGJ1EUuSZ4eHI4MoATk
         9q77ZN721sY7TvPU0kyRHSVJK/3yy+rJTIpWIpRFvsGXUQq103iPi7u8qzsQm+YDUVnf
         QRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692205821; x=1692810621;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xxCwuqjPcl+IJA8BvbLFYWTyePxgeQPUkGWOK9EtNqI=;
        b=OLRiGuT89MJGx5MoD61gN62TjcAYOi3fHwqVPzJCPQlyIMgjfCOwrDq4H9RjOOKaSj
         CQUCGBavXLTc04cS5WPqcgAD6aEFNHL4+jrirX2s2D0iQNJuDWhp0QG3tIf79+uJFbo9
         oPHg0vR/mzZR/OjZhOOBYUGWRdNSWB6+/sVmMnacfUI/akAmN6yRYZFI1yIDRFmbuvBd
         wSFDIQdvrKB+ZSe6aWvQ9a+u5iQx9Nh7A1YxQtbSZMt4Gyl7dwN4ixYnLD4Qtenj+gVk
         Anqn6Kez2jRfMfCHGVhr55kdV75zNMc0/WntIQwP+cFipsIBfc2+ld+JFEAflU6wUlY6
         xWAg==
X-Gm-Message-State: AOJu0YwTZgf8k/qy8IMYCFHXpL66bANOgmUY/Nic7FuJftuaOIjj/OmC
        5ybeBq5DpzYKZZbsUDowT0Nm0A==
X-Google-Smtp-Source: AGHT+IHWeo2IdfUkhGlh5jDKe2Y0lGdrKg2LDP7fAQshjPpk/ewwT2mUjd86rGsLoKWIDaWS2PvwzQ==
X-Received: by 2002:a19:430b:0:b0:4fe:17d9:6755 with SMTP id q11-20020a19430b000000b004fe17d96755mr1710122lfa.25.1692205820994;
        Wed, 16 Aug 2023 10:10:20 -0700 (PDT)
Received: from [192.168.1.101] (abxi8.neoplus.adsl.tpnet.pl. [83.9.2.8])
        by smtp.gmail.com with ESMTPSA id eo12-20020a056512480c00b004f858249932sm3016609lfb.90.2023.08.16.10.10.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 10:10:20 -0700 (PDT)
Message-ID: <0d4d7d4b-9cbc-40df-98f5-3c9696bf6b13@linaro.org>
Date:   Wed, 16 Aug 2023 19:10:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/14] media: qcom: camss: Start to move to module
 compat matched resources
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, rfoss@kernel.org,
        todor.too@gmail.com, agross@kernel.org, andersson@kernel.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230814162907.3878421-1-bryan.odonoghue@linaro.org>
 <20230814162907.3878421-3-bryan.odonoghue@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230814162907.3878421-3-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.08.2023 18:28, Bryan O'Donoghue wrote:
> There is a lot of unnecessary if/elsing in this code that arguably
> should never have made it upstream when adding a second let alone
> subsequent SoC.
> 
> I'm guilty of not fixing the mess myself when adding in the sm8250.
> Before adding in any new SoCs or resources lets take the time to cleanup
> the resource passing.
> 
> First step is to pass the generic struct camss_resources as a parameter
> per the compatible list.
> 
> Subsequent patches will address the other somewhat dispirate strutures
> which we are also doing if/else on and assigning statically.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
[...]


> -
>  	for (i = 0; i < camss->csiphy_num; i++) {
>  		ret = msm_csiphy_subdev_init(camss, &camss->csiphy[i],
> -					     &csiphy_res[i], i);
> +					     &camss->res->csiphy_res[i], i);
&camss->res is used quite extensively, so I think it may be a good
idea to keep the variable there, just make it point to the correct
new thing.

Konrad
