Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9175878DA8B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237706AbjH3Sgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245205AbjH3OqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 10:46:17 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2981A2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:46:13 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so209628766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693406772; x=1694011572; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5pBWaiAxt3c7UKiYBVmzRQWXUVgNPi+xoAwOSlkZgSg=;
        b=kcVQUuKkxP0F+OLs8erkthnGot2to+j+oP753j1esqtt6NZuqECeJaGiOlj0PmpEuC
         fprZg65jFt/ETMPc5ruZPFwhCLNHTVLFHoD+H8J9dv1LPdxIUdAKLszDC8EU+8Ev4IUy
         HE8qAJpbbshp+h144E9oLxqn3tZxyBF1R1+IpaNy2n84Q2kq0qFckOOfXfjzDlDzDYx6
         F8UxLEtSMC4cOYAOM1ODOD7fENfmnUyeLTpXeoYOEU7+NmKSp/FJZI/LUNbi6oe3hNju
         R2y4OeKUoSja3zyy2rSKyOPVZukNu0oeHDWyzF4zBISb3SYSML3Y1N4WCV+4ywrlDny0
         VNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693406772; x=1694011572;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5pBWaiAxt3c7UKiYBVmzRQWXUVgNPi+xoAwOSlkZgSg=;
        b=ch+xICLS4UZ6qIe5ajFKUj2qIxeYF4ZGQjhj/QSkSCCokcG5sIWPq79+oe81jyexxl
         6d6WGUKgnNv2RsQVVwLNZ9n42V2vOA3vQmuITducmnS3Upp5hu1rfC66/CNszr9mclhF
         KxhNLjO6WL77lujlFRf4LmYy3DGH2rloa0YLpNIQuN3fmV84lLmFFhWJCOa3HXMfJ9Xw
         rCuJmDRVnsFPlXCndb8i/c8Kpwjsk1OooEiyAJINOm0egME16esgA5VCgBMZasrS0JCl
         K+aWrSSnJgAYCrNziKcpPsz/vZaAG1+5quCnQ/muzw4QXLnulhCsxf0rJbVDRF7kHIyq
         b86g==
X-Gm-Message-State: AOJu0Yz/R48zEMznxCTfSebBR8ToArwW3+j8jlhnBnXAujhq5k+tV3Cg
        T7Os9JHOILY+pl3EFtX3tMyE7A==
X-Google-Smtp-Source: AGHT+IECBfom6bQT2ajlFb2yXCA1KjL8rdq1f4FAA8HWcZ+VnqFs+cy5NHaCNPbc9rBQ2bDMqwdkSA==
X-Received: by 2002:a17:907:c004:b0:99b:4210:cc76 with SMTP id ss4-20020a170907c00400b0099b4210cc76mr2530744ejc.28.1693406772113;
        Wed, 30 Aug 2023 07:46:12 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id s11-20020a170906354b00b00999bb1e01dfsm7239237eja.52.2023.08.30.07.46.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 07:46:10 -0700 (PDT)
Message-ID: <25b44b0d-e958-ada3-3900-589224c1e37f@linaro.org>
Date:   Wed, 30 Aug 2023 16:46:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH net-next 1/2] dt-bindings: net: Add compatible for
 AM64x in ICSSG
Content-Language: en-US
To:     MD Danish Anwar <danishanwar@ti.com>, Andrew Lunn <andrew@lunn.ch>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Simon Horman <horms@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, srk@ti.com, r-gunasekaran@ti.com
References: <20230830113724.1228624-1-danishanwar@ti.com>
 <20230830113724.1228624-2-danishanwar@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230830113724.1228624-2-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2023 13:37, MD Danish Anwar wrote:
> Add compatible for AM64x in icssg-prueth dt bindings. AM64x supports
> ICSSG similar to AM65x SR2.0.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
> index 311c570165f9..13371159515a 100644
> --- a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
> +++ b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
> @@ -20,6 +20,7 @@ properties:
>    compatible:
>      enum:
>        - ti,am654-icssg-prueth  # for AM65x SoC family
> +      - ti,am642-icssg-prueth  # for AM64x SoC family

Keep the list ordered, probably alphanumerically.


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

