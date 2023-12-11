Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAD480C651
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbjLKKXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjLKKXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:23:40 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF76C3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:23:43 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-a1db6c63028so482786166b.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702290222; x=1702895022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tCTT1HWaBNhjtHeFQYajDR7/foWiM7nOIut8ehHasE4=;
        b=mJPikFMALdlh/q5ViicT0mAe6OI0qJqqOjkN7sJfsCEmhsDnlBNhoq+peA2cSGSNeN
         w7Z3I7NQjsuC5Amtxp7yq/MawCftjzrbv5zesPiH5iax5EkHzJDLb8vkbLOyKz3wi1Bb
         rKy2b0oh8GkAtnY5Lb8EHUHHPGIiI7T4nLgi13lHJw75Sh0CczCRWPdUMGglKoZaMVe/
         bPP4Ysz50TLvciM8tvejRfkKWDX7OXmFQ9vtSChz7/znRY+Mx4fnRgZ0CawAGx+DOD3x
         nAAsQLDDvgaO7YZ3awFdwUCsXT+vPggX3k5gh/wMeFojSzhSM+z54aGjdHYORavYPSx6
         arYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702290222; x=1702895022;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tCTT1HWaBNhjtHeFQYajDR7/foWiM7nOIut8ehHasE4=;
        b=Twu/Olb6zXu1p1anOMQ0sly262wid5MEPxWfxwYU9bw2wODD5BIvCmu3Rc8J/pybaV
         lOfRb/Dz2LOk3SVqb54H4+2vQ5ZBL1RUkWz6cmitJTQYK3SJjwIv2xGkrB2+t79af0EA
         1LHLw7oS7+2cb+cQ9b2oomj0IwAOqbF/zvpquA6h2USMDVUm+zexlkIdg2fTiYG66uL0
         KPUevG/8OyvADyITXzc4qkr61onsVX6UI5ugg75SncoyN9e3akvFE08p6HF72WjE2KPk
         Nln37xjS5F92ZTwBknY08R/NctjrY1JUlX1oXwHTCzgTc42na/yzC5IUDpgtIcf2lQm1
         QglQ==
X-Gm-Message-State: AOJu0Yz9ci1wtnf22zrvP9gg0Eafs/8/dItFY58HiIp9pgYyFESmZBEc
        m2KjqhDzJtb9layeFZeH85JMvQ==
X-Google-Smtp-Source: AGHT+IFMu9j1B8jlwJ/43DK0orY7miD0UT4aeO4o/Rxpav0ZGKbzZIg9R4nuStg4nZBpSTX9lyyeYg==
X-Received: by 2002:a17:906:535e:b0:a1f:652e:d7c5 with SMTP id j30-20020a170906535e00b00a1f652ed7c5mr2050207ejo.111.1702290221932;
        Mon, 11 Dec 2023 02:23:41 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id li18-20020a170907199200b009fd77d78f7fsm4548178ejc.116.2023.12.11.02.23.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 02:23:41 -0800 (PST)
Message-ID: <730b71e2-9c3c-4b40-86a6-0794615222fd@linaro.org>
Date:   Mon, 11 Dec 2023 10:23:40 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build failure after merge of the nvmem tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20231211164916.6f0d2357@canb.auug.org.au>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20231211164916.6f0d2357@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thankyou Stephen for the patch.

On 11/12/2023 05:49, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the nvmem tree, today's linux-next build (i386 defconfig)
> failed like this:
> 
> /home/sfr/next/next/drivers/nvmem/core.c: In function 'nvmem_cell_put':
> /home/sfr/next/next/drivers/nvmem/core.c:1603:9: error: implicit declaration of function 'nvmem_layout_module_put' [-Werror=implicit-function-declaration]
>   1603 |         nvmem_layout_module_put(nvmem);
>        |         ^~~~~~~~~~~~~~~~~~~~~~~
> 
> Caused by commit
> 
>    ed7778e43271 ("nvmem: core: Rework layouts to become regular devices")
> 
> I have applied the following patch for today.
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 11 Dec 2023 16:34:34 +1100
> Subject: [PATCH] fix up for "nvmem: core: Rework layouts to become regular devices"
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>   drivers/nvmem/core.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 9fc452e8ada8..784b61eb4d8e 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -1491,6 +1491,11 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np, const char *id)
>   	return cell;
>   }
>   EXPORT_SYMBOL_GPL(of_nvmem_cell_get);
> +
> +#else /* IS_ENABLED(CONFIG_OF) */
> +
> +static inline void nvmem_layout_module_put(struct nvmem_device *nvmem) { }
> +

I see no reason why nvmem_layout_module_put() should be even under 
IS_ENABLED(CONFIG_OF).

Updated the patch with this fixed.


--srini

>   #endif
>   
>   /**
