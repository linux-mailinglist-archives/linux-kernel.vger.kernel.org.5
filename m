Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6679276F9A5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 07:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjHDFlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 01:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbjHDFlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 01:41:09 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE9F212D;
        Thu,  3 Aug 2023 22:40:49 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b962c226ceso26733161fa.3;
        Thu, 03 Aug 2023 22:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691127648; x=1691732448;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SifUjTMVfXchWMpRS4lIPvkiZWPI//VB1HsW/UooW70=;
        b=Z+KLUrBYyMwSpVHb/TdX060hMwaqucuB8BvbZFUggynIAMmpNK20pJFme9lldUSHip
         3sqIdyb/x1lo4mcM95vFvg+0M3Rv4+uWQVud3/ALWzUIdFYZwG4EoBCmOY3Hbn0RbTpd
         HSTNoBz2pn/RFw2Y0d2ZtdWUfEx4FiYRrpaOJ5D/Jiv6bk1MgcVFXxOdPRtKtltgZpOg
         CV4p5MuE1+8c+px2LPj9aCYkVmsPoXn0uHIFffoI1Q9txy8j/62Mayig9uxnjI7eqoAo
         iw0G+ZeUL0kTdHVS8uEA2oJZrUp8f1MSRuXLXtVO4jSKqq6tHE7sRfPWPKQw0mksV/0l
         nI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691127648; x=1691732448;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SifUjTMVfXchWMpRS4lIPvkiZWPI//VB1HsW/UooW70=;
        b=I+TWjPFpmx1C2rwrOEB/whhHlHTCTvtZhUotcLnzk08SQYOLKtRMedpUo6l/DlPTRz
         ikrcQJP9vxhfmsML9sbqeagMntN/46bWyPGyO9XwJgyx7U67HmRxGAt1qnxrAUtmhypy
         eQLFFELFv56fb+gLf6JLLeV43Ua8rtaJhv3h5Ps/CzwF0A/MuvEKjRYaYvgp66LAU1ae
         Wz/wPH3wHSC2jlA592Ex64Q92mGRZ1G6QF0lKaS19ZOT5/5k5moFNxAk8Y0VREzLJo/L
         CvjOJ87OXgiRcjC8AUxZK/WulOSi5M0S2hBTyA8SCqBMyBN/KI5q/X+urr4JZPBrJsGC
         gF9w==
X-Gm-Message-State: AOJu0YyFP8sZVLBn7OC/dEoA+VeJCvlFq/LyQ1bEMhnCIK7669fE+01L
        f7Ofl0Yb3WI2jCScktSoL9v36J1iXQk=
X-Google-Smtp-Source: AGHT+IF80bBIR+uHsx7CZcbvOnInW5NMG2TASDwUSByyaF13ELLN3uLYqmZYgOSjf582isjyOmH4Ow==
X-Received: by 2002:a2e:9095:0:b0:2b9:44c5:ac15 with SMTP id l21-20020a2e9095000000b002b944c5ac15mr711501ljg.41.1691127647546;
        Thu, 03 Aug 2023 22:40:47 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::5? (dc78bmyyyyyyyyyyyyyct-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::5])
        by smtp.gmail.com with ESMTPSA id z10-20020a2e7e0a000000b002b839578e56sm311291ljc.11.2023.08.03.22.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 22:40:47 -0700 (PDT)
Message-ID: <87eb7f91-df2e-b466-2fa8-fc171679c621@gmail.com>
Date:   Fri, 4 Aug 2023 08:40:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] dt-bindings: mfd: bd71847-pmic: Remove unneeded LED
 header
To:     Fabio Estevam <festevam@gmail.com>, lee@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Fabio Estevam <festevam@denx.de>
References: <20230804021657.190700-1-festevam@gmail.com>
Content-Language: en-US, en-GB
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230804021657.190700-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/23 05:16, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> There is nothing from <dt-bindings/leds/common.h> that is needed by
> the binding example.
> 
> Remove the unneeded inclusion.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> ---
>   Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
> index 7ab7b2c7f3e6..d783cc4e4e86 100644
> --- a/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
> +++ b/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
> @@ -130,7 +130,6 @@ dependencies:
>   examples:
>     - |
>       #include <dt-bindings/interrupt-controller/irq.h>
> -    #include <dt-bindings/leds/common.h>
>   
>       i2c {
>           #address-cells = <1>;

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

