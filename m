Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9767A0FD5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 23:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjINV07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 17:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjINV05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 17:26:57 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC5926B2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 14:26:52 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c364fb8a4cso12977405ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 14:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694726812; x=1695331612; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4LzmTOuTIv4VUvVsi7SsAaofqZS+sUeMRVa500GSkmc=;
        b=qdDJyH1N0sSzqSMRbB5OnSBOheOE6hMJ6QJiNyxxl5xvdPsDVeq84UPRdQbgcW72OD
         JaJ1PU40orIWcmibL91bPgFJH0Lm52+rFO997pX/JzenCLy7HPtF8g9enCcWonlKiOwp
         go9YCv0kAlazLsWkI9vAyva4//KmmRKWq68fwTr2AUDfh3w84dUlUgmRLTU1EiAyFniH
         nG4yUpLCR5Kl/NqbOEZDXAnXNGl27syEhO45HqDOvUZB2fGULs5ODlMOHJmXLhmUrYYY
         ffELmwNg36AmCEvLvGl6W5u4vgpjeLlA9mnsL/mkeaSG/dwPApIIhNYcYXoUbw6RP3Uz
         mxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694726812; x=1695331612;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4LzmTOuTIv4VUvVsi7SsAaofqZS+sUeMRVa500GSkmc=;
        b=XQ5Ukfb/svtowLzK4sRRYpnOqagoKjVl7ki8yKGEh3pcxXZSDSRE7NwLqfQO9hUu6O
         PXuOcsKxwxcxy1fxq9XSX0BpRLMy8s2vrFN/gpnjvk7n27sQ4mH5wr9lUq0MyShMKZub
         RuCUjmML0biuXiCycvgZzZPgERfWT0yau5fMg1r9wqkMTkOYb47UWZH1kU9xfIC7B07w
         p1VtO00O9C+QD2YUmIC6xGDZ7Fser61vzvzREJ92i1ehT2M4xB3lNCXZGissxXUaPo65
         eme+F5N8qnuinwfcf+9w5j23CgGLVdK8oo1I6DTePvfODvhT06y5Wj+Hw4x1cmj51UZ/
         cJ0g==
X-Gm-Message-State: AOJu0YwSbboRGQGD8RpJDDMlO+1Dw2ThAYYWQcEcP2HI4vI/qTfQbAoD
        fD3APKZdnKeeSrH1Yv4IBgU=
X-Google-Smtp-Source: AGHT+IE+kK/pe/5lufgYlyWCWF0r0Fpfv/VUwKNXVhZf+3vP28c26HPOiGWc55UyABMSmfYOEfyL7A==
X-Received: by 2002:a17:902:b602:b0:1b3:d4d5:beb2 with SMTP id b2-20020a170902b60200b001b3d4d5beb2mr6700103pls.9.1694726812032;
        Thu, 14 Sep 2023 14:26:52 -0700 (PDT)
Received: from [10.67.51.148] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id u10-20020a17090341ca00b001bbb7af4963sm2030920ple.68.2023.09.14.14.26.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 14:26:51 -0700 (PDT)
Message-ID: <28fad55f-1253-deb2-9615-b32746129664@gmail.com>
Date:   Thu, 14 Sep 2023 14:26:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] nvmem: brcm_nvram: store a copy of NVRAM content
Content-Language: en-US
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>
References: <20230914064922.3986-1-zajec5@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230914064922.3986-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/23 23:49, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This driver uses MMIO access for reading NVRAM from a flash device.
> Underneath there is a flash controller that reads data and provides
> mapping window.
> 
> Using MMIO interface affects controller configuration and may break real
> controller driver. It was reported by multiple users of devices with
> NVRAM stored on NAND.
> 
> Modify driver to read & cache all NVRAM content during init and use that
> copy to provide NVMEM data when requested.
> 
> Link: https://lore.kernel.org/linux-mtd/CACna6rwf3_9QVjYcM+847biTX=K0EoWXuXcSMkJO1Vy_5vmVqA@mail.gmail.com/
> Cc: Arınç ÜNAL <arinc.unal@arinc9.com>
> Cc: Florian Fainelli <florian.fainelli@broadcom.com>
> Cc: Scott Branden <scott.branden@broadcom.com>
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
[snip]
> -	priv->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> -	if (IS_ERR(priv->base))
> -		return PTR_ERR(priv->base);
> +	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	priv->size = resource_size(res);
> +
> +	priv->data = devm_kzalloc(dev, priv->size, GFP_KERNEL);

These can conceivably quite big data structures, how about using kvmalloc()?
-- 
Florian

