Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95A7788038
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 08:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242395AbjHYGrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 02:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242252AbjHYGrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 02:47:17 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D14C1995
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 23:47:14 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99bf8e5ab39so63862966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 23:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692946033; x=1693550833;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d+h7Z3AHszYQ/48y7ylXF0wY2H5ct/DzNLRlfXyrhJo=;
        b=IJsglntmLI9Vcjx/NFhD+fRHY4miOVIc4MHlInq15VR4GK0HxPBdrkLk4IPlvZQqTk
         JoDUhhScZ25C5KID7YKJTxGblhQBdyajFPxwijwjkevEDw9znRc/X+X/gp1al4j+XKzU
         ICJSpFzfKqam1JF2gWmTe3dLetXgN3Kj6X37554seFk/vZgwNDL278trkeM28xVkuEX2
         FO3BK4ph3W5jFHVzaEhO0fGFimL3kvu4+Qk2duVZw163RoBfac9yB0db4TZIcMqTpZKl
         WeD7MR0lGUt5aB1Jn5I0uogamYlJW5IX88qYzwd5eb1EXSh1Vzchr7s6zKDGBYKgQGQc
         3MEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692946033; x=1693550833;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d+h7Z3AHszYQ/48y7ylXF0wY2H5ct/DzNLRlfXyrhJo=;
        b=dP2wYcOFwBNlY6alugOV/PyVY6x1YlYOrHJfbgi2+lh4shmJ1p6wBfznYYjTTrHRQl
         NzB3tn0pw8VxHnW87QCsTUUyN1vk2Hhonh83KVsLjG7ORLWs5Bo8sJ2pQzeQZPJx+7KZ
         7a6MS532uf3ySzCs03MVfd4nGxBNezUpG9XsmFY0Lmj/qqgtRfgoLwoYP0aN4GZvCPFE
         RCVi3LDRyQysNu094sSkQyeoazQRTaKK9mbuPUfmBwcZpIy+90CZtG0LsOiPyJn1Izzg
         ju7Co3K3V33dp0cqnWboqmlPsu/4tRR8L0L8VRYf6CVQyJ92oFJ2JE39PZm89ZfwivNS
         Hwag==
X-Gm-Message-State: AOJu0YzSmABjcNYp44wBtOzlGDfNkkSyZAHbRsmP3aqRZ0XnhnHnqR8a
        23XOF3WhrFgpzoZ82jd4nsdBdg==
X-Google-Smtp-Source: AGHT+IEGZqZgmKNIkyaAo6WLS12bV7qKfdm+d5pIB+2qw4pocaa+Qtl9RMNtvDxlYOPUTHKyZtUXUA==
X-Received: by 2002:a17:907:aa1:b0:99c:75f7:19c1 with SMTP id bz1-20020a1709070aa100b0099c75f719c1mr12244709ejc.39.1692946033029;
        Thu, 24 Aug 2023 23:47:13 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id ha19-20020a170906a89300b00992b7ff3993sm602489ejb.126.2023.08.24.23.47.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 23:47:12 -0700 (PDT)
Message-ID: <b8b414cf-c425-f322-51e6-c825e58ae6ed@linaro.org>
Date:   Fri, 25 Aug 2023 08:47:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 4/4] MAINTAINERS: Update MIPS/LOONGSON1 entry
Content-Language: en-US
To:     Keguang Zhang <keguang.zhang@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
References: <20230824125012.1040288-1-keguang.zhang@gmail.com>
 <20230824125012.1040288-5-keguang.zhang@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230824125012.1040288-5-keguang.zhang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/2023 14:50, Keguang Zhang wrote:
> Add two new F: entries for Loongson1 Ethernet driver
> and dt-binding document.
> Add a new F: entry for the rest Loongson-1 dt-binding documents.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
> V2 -> V3: Update the entries and the commit message
> V1 -> V2: Improve the commit message
> 
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 250c43c675cb..f462f3d19e4a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14341,9 +14341,12 @@ MIPS/LOONGSON1 ARCHITECTURE
>  M:	Keguang Zhang <keguang.zhang@gmail.com>
>  L:	linux-mips@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/*/loongson,ls1x-*.yaml
> +F:	Documentation/devicetree/bindings/net/loongson,ls1[bc]-*.yaml

This should be just one pattern */loongson,* or even just N: loongson,
if you want to cover any future versions as well (not only ls1).

Best regards,
Krzysztof

