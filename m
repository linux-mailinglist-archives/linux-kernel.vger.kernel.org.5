Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8245E79FB3F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 07:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbjINFru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 01:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235316AbjINFrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 01:47:37 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A7D1739
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 22:47:33 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99bcc0adab4so71967766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 22:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694670451; x=1695275251; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aRwKx+aVUNdsT/yRs8dmsSCK+EhxcclEATZc5SW5dvk=;
        b=CwWSiijddI8KOTo71TaKJsUGwgeBO4AN7smiA5V2bM9M8y4U4SD4p/fdw4XAdGZCfZ
         EYtqIyqM0mLEA5SQWraJ28eSVvGIaMvQH7dTVClICZYrXItPEdFI/3aQtTfviakmiBbK
         Kf4kwbQxsiaOpvWN7tXvonFaXbHDw781u+HpcmCbjnjevh3AZUc9GkuPhFVLljXSjuuS
         vEGbEzXp5D4zbv6Csr+Xd6rmo0O9QlKyK88AZ7KTWDmzRA27fLa//HkhMtwYdIle97sF
         t/Hee40bl4FrF62ndwIWyOIVGsp8B82jDILjRu87kasYqXwZuJfg8h2fyuZsaql76Z4X
         QKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694670451; x=1695275251;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aRwKx+aVUNdsT/yRs8dmsSCK+EhxcclEATZc5SW5dvk=;
        b=RW927S5lUP74ZzpMoi7JBMtRKXtyQMb4H9pZEIrRx48u0JD8vgGqqxWwRVfGVLdKoW
         w2+QYf8JESdd5aI3Jbf27x7Ya8nMfcPPD5l60vb/ExPbDTTE8IKRNhndsjidfD/OsjTq
         qXj3Xv++OLd+Y3m+4v9Iw8CxKKNxxGxNon7ilYdGiAPp5XrSWHgdbRqulff9UqUI+jmF
         d5trM241ZqcLl0r1l5gtlFUPY6L4/+yBRqhhLqENY6TLUiX/NBttEXFVOMBW+0tstIim
         pM8gCMNItzK45voEE5GF8V7WaFdUrcs4EA2ATmlIxCq7UL2ufCKc20x3jIkZsjPknvrt
         GsCg==
X-Gm-Message-State: AOJu0Yz+GIqlOb0cBhNpCQhX7V0r75HytERF/4W4+zRaR2GLM+MmD/4o
        xor2zYnJ/fy6QHDjwb9uqJbvfw==
X-Google-Smtp-Source: AGHT+IGxTh/8mNU2+nmm+vM8YqApu/9J2UNCKeeNHOXZXyiuYhSXCWhblzjZH7lFirW7vVAD2E7tLA==
X-Received: by 2002:a17:906:e:b0:9a2:2635:daa9 with SMTP id 14-20020a170906000e00b009a22635daa9mr3555311eja.6.1694670451368;
        Wed, 13 Sep 2023 22:47:31 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id gy18-20020a170906f25200b00991d54db2acsm484864ejb.44.2023.09.13.22.47.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 22:47:30 -0700 (PDT)
Message-ID: <4520fa76-8645-a438-ba7d-ef50c9781249@linaro.org>
Date:   Thu, 14 Sep 2023 07:47:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/5] dt-bindings: gpio: vf610: correct i.MX8ULP and i.MX93
 interrupts
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
References: <20230914-vf610-gpio-v1-0-3ed418182a6a@nxp.com>
 <20230914-vf610-gpio-v1-1-3ed418182a6a@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230914-vf610-gpio-v1-1-3ed418182a6a@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2023 04:20, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX8ULP and i.MX93 actually has two interrupts for each gpio
> controller, one for

...

> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,vf610-gpio
> +              - fsl,imx7ulp-gpio
> +    then:
> +      properties:
> +        interrupts:
> +          maxItems: 1
> +    else:
> +      properties:
> +        interrupts:
> +          maxItems: 2

Instead describe the items with "items:" and descriptions.

Best regards,
Krzysztof

