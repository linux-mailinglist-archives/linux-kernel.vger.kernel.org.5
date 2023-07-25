Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17847609B0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 07:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjGYFrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 01:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjGYFrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 01:47:19 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9F31990
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 22:47:03 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-52229d3b8c8so2869546a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 22:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690264022; x=1690868822;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OtHOe9UdxU5Yo//nXQXaDbcIAQ2a2ywAGBNvuDNWOxc=;
        b=RkqmbCMYlKG1SqMf6AZRdTXFW5PDxQXv2laiS4Mzw9GgCzLQyYY7ip3uERDKs93bmY
         Th/5XSXd08Mi7H+a1S+pPajh8Cht8xDC5uoPzcPLd9R5CppLzyNHK3Uja34d9JrWS0iy
         a0iAklOfQh5k7UZtiqpL7Ki+NI06njRYu2v+6Uv4N4XCw/zt0qQSOjqmI2crdD/Lnboc
         oGcOhhue64IKJQbA/WPM3t66y/gLiYpKtWXz1TJv2zx7lMgvvM3oSbkhJbS1JG3o2XTa
         VvGfzGyVKpQSMhv0iaLOnCusE87TsiE5OUVcs34P3JVc9Tv7LrmJnH2kbSwYdzNmo2n0
         nTUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690264022; x=1690868822;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OtHOe9UdxU5Yo//nXQXaDbcIAQ2a2ywAGBNvuDNWOxc=;
        b=H5kWhqtj3BC1o+YwHf13oqirFQ5M2DDLQ/UImjXyW4IQVMBHUuuBYpTHpnC7OLvgeo
         gIXqnYl3ml469j+163wpKxvKrL2RRHZz45/LnebPYWHdMO/SsFhvoJtlUtawQApy97YS
         twKpAxlN+IAG8a1uyx0gvhJimriSzHauEiVVdsNvNIGHqzglGAMycncQrznhs9YzNODB
         jSBlJpjzvEZU8jQ74zSEgLszrCsXdVPycZOeN+RMLiavdicdcFPpAodewgPOBnQnpn9J
         OP028DMc7kTPZ34HPHGo1sNqm7ukAWhBmd1z0V+Hm6mvzCBbCB3EfQT+VeV+2+yThIV6
         eYlA==
X-Gm-Message-State: ABy/qLZQAeNVx7jaR1LLBTi/wRur8zfBLQmrH7r104N9gNGeAwbPfaK5
        OPGGh8NGe/BcM7KMRyoUHh5FzA==
X-Google-Smtp-Source: APBJJlGW2Ft1BMDPjxoRGOBAjx7oBR6OsdhVvd1itXUbAlMhPt12HP2lasOnaGt2j9Xkmz5krUPreQ==
X-Received: by 2002:a17:906:15b:b0:991:c842:2ca2 with SMTP id 27-20020a170906015b00b00991c8422ca2mr11113442ejh.15.1690264022216;
        Mon, 24 Jul 2023 22:47:02 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id u20-20020a170906951400b0099ba3438554sm1625375ejx.191.2023.07.24.22.46.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 22:46:56 -0700 (PDT)
Message-ID: <877c6d2c-430f-b1fb-4267-18be5d7256dc@linaro.org>
Date:   Tue, 25 Jul 2023 07:46:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: Add BQ Aquaris M5
Content-Language: en-US
To:     =?UTF-8?Q?Andr=c3=a9_Apitzsch?= <git@apitzsch.eu>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230724-bq_m5-v1-0-17a0870a73be@apitzsch.eu>
 <20230724-bq_m5-v1-1-17a0870a73be@apitzsch.eu>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230724-bq_m5-v1-1-17a0870a73be@apitzsch.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/2023 22:52, André Apitzsch wrote:
> Add a compatible for BQ Aquaris M5 (Longcheer L9100).
> 
> Signed-off-by: André Apitzsch <git@apitzsch.eu>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>  1 file changed, 1 insertion(+)


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


---

This is an automated instruction, just in case, because many review tags
are being ignored. If you do not know the process, here is a short
explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions, under or above your Signed-off-by tag. Tag is "received", when
provided in a message replied to you on the mailing list. Tools like b4
can help here. However, there's no need to repost patches *only* to add
the tags. The upstream maintainer will do that for acks received on the
version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

Best regards,
Krzysztof

