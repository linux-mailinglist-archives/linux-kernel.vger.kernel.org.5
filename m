Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78EA9759122
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 11:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjGSJF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 05:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjGSJFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:05:36 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7005D172E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:05:04 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9939fbb7191so125842666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689757496; x=1692349496;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CG2i2gBdVgAobd7kSOtOhhY9985qKrdP4M4UxdNSfpA=;
        b=MOo4xwK0xHvBv6dWQDzKM4xZBpYxTg51VuIGMqgw+zOK983xACaLL8Theq51In9kck
         ZbW8lqvNI30+RT0Ho3lDWgtkFCQV/uc4m29yqrHATPsdeOui9ZS9gwJQju57qUIFvN/t
         chxhOdn/P3ssp0Cefy9C77tBxSrmVYaT5jAoKz+caAYFnznIBIeQdXPqv84zZI83jm4u
         vsO64A/nrPqAofMmncPSkmslDsGlx8pVeuGHZJcESevisX7PcQN1DB1v00rImbeHLdDb
         jretoz77IVDpgb5t3fvU1NgIzImTrM+iWcuM6hs7JmBeoKGYF/gVX7fHzUfEop8Wj9Cp
         Mr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689757496; x=1692349496;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CG2i2gBdVgAobd7kSOtOhhY9985qKrdP4M4UxdNSfpA=;
        b=S3rKHOOGUHrPUpFPjI0W4GIbtE281s1jyEoZe3ldEYuEUXFP677JJBk7PSSuydKdEp
         IurzDt8lGSReY0W3y43kAIdAdmjS/nACiVV4WFSLfN50+8qgVawpgQrCdvsA51qL4GWc
         +8C2qdPKK7Yf+m3g6pPzJVYlsm5EDg6eRmZyz0BCaERNH6yTxaOaOkXi5Dl0poKoL7gh
         b0rw4u0I5G3+0xYL1mYSJxWwmXw1o7WctmKN6ss6bBObaV/GaOKgIGmGx0k/nkW91RIT
         ytwipxFUn9klmom8DT6HEeqgEI+d3x1l3lx+rPyQzWhO9zL7WLDIDSzDkDc09ruFBnlT
         DTPg==
X-Gm-Message-State: ABy/qLYOCxrMcLBsS0xCCfKmkLPtO74CtLjpoywf6C0TrGkM5c9KqYDS
        grjCP22RoiYb6lvyJXXtwIclbw==
X-Google-Smtp-Source: APBJJlG2CdR7otElXbCSTvvIj4z8QCx0EPvoLVEcs45/igNTPlvZg67Tn6ceqy4lh0WKAf33sSeqQA==
X-Received: by 2002:a17:907:3ea0:b0:993:f9d8:9fd0 with SMTP id hs32-20020a1709073ea000b00993f9d89fd0mr1955000ejc.1.1689757495980;
        Wed, 19 Jul 2023 02:04:55 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id cw17-20020a170906c79100b00992b0745548sm2058618ejb.152.2023.07.19.02.04.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 02:04:55 -0700 (PDT)
Message-ID: <401692d5-14a9-51a2-6676-06449ec54d18@linaro.org>
Date:   Wed, 19 Jul 2023 11:04:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/7] ARM: dts: exynos: k3g: Add GPIO keys support
Content-Language: en-US
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230716220644.22158-1-markuss.broks@gmail.com>
 <20230716220644.22158-4-markuss.broks@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230716220644.22158-4-markuss.broks@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2023 00:05, Markuss Broks wrote:
> Add the four physical buttons support, volume buttons have
> external pull-up resistors.
> 
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> ---
>  arch/arm/boot/dts/exynos5422-samsung-k3g.dts | 60 ++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 

Is it a duplicate? You know it cannot be then applied?

Best regards,
Krzysztof

