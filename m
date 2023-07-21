Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABF775BD7D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 06:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjGUErt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 00:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjGUErq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 00:47:46 -0400
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6FA1BEF;
        Thu, 20 Jul 2023 21:47:43 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2b974031aeaso2749831fa.0;
        Thu, 20 Jul 2023 21:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689914861; x=1690519661;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rzttnzwsCVtAaan/zl6CN7jlq5PQz6KDFquQEPaS+Bc=;
        b=QayWFcX5HEggXhga4mcA6+c46JJvtHdG4RIsKp3ZTQKMsTEE2uIzs0JYwDkgKBBBfF
         rshNsFM/9cW+3MBhbRYXsOduMC3XBWNhrQsAcTI3yCJGxVXBmA8W97P5OXnAJ9TY5kkT
         NOU6ckeYkdhZSxbXGSidVdSd9TTKVxINbqEsIY96y+jzso+XoML4LlWDaVSs9AOgpoIc
         ZQdulSjyGRMU6KtQpYy/26pRL8jbswQtgiRmQDvPgsqJmZuZ7mAOSBI5gy7k2VcRycO6
         acrA7SFYNX9BHhhwCvAN6HA3nfyoA3moYsKW095Q9bK+B/MzVyKmD3auSa9ww6uL1q9J
         8H2A==
X-Gm-Message-State: ABy/qLbStMhfas9dvsuanRYGyl5zxCl8KSWkKYIamBMHzG6V90ow/mki
        RVs+1od3ToCzgJF3NPD5ZtM=
X-Google-Smtp-Source: APBJJlH/0GSArnoEoKgRfmDmBsIjxbEzLoj3aEeG5CEys0ce+HDI3lHaB12EuIDD4vDcOsVZT5C6xg==
X-Received: by 2002:a2e:8684:0:b0:2b6:dd13:4f26 with SMTP id l4-20020a2e8684000000b002b6dd134f26mr721096lji.46.1689914861274;
        Thu, 20 Jul 2023 21:47:41 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id bh17-20020a05600c3d1100b003fbb1ce274fsm15201953wmb.0.2023.07.20.21.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 21:47:40 -0700 (PDT)
Message-ID: <748e8be1-d7e6-c0a3-b83b-a8475873cc4c@kernel.org>
Date:   Fri, 21 Jul 2023 06:47:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] x86/microcode/AMD: Increase microcode PATCH_MAX_SIZE
Content-Language: en-US
To:     John Allen <john.allen@amd.com>, bp@alien8.de,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, stable@vger.kernel.org
References: <20230720202813.3269888-1-john.allen@amd.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230720202813.3269888-1-john.allen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20. 07. 23, 22:28, John Allen wrote:
> Future AMD cpus will have microcode patches that exceed the current
> limit of three 4K pages. Increase substantially to avoid future size
> increases.

Hi,

so with my current distro (openSUSE TW):
$ zgrep NODES_SHIFT /proc/config.gz
CONFIG_NODES_SHIFT=10

This:

static u8 amd_ucode_patch[MAX_NUMNODES][PATCH_MAX_SIZE];

is now 32M instead of 12M. That is a complete waste on my _one_ node 
system. Can we make amd_ucode_patch dynamic first, depending on 
num_online_nodes()?

> Signed-off-by: John Allen <john.allen@amd.com>
> Cc: stable@vger.kernel.org
> ---
>   arch/x86/include/asm/microcode_amd.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/microcode_amd.h b/arch/x86/include/asm/microcode_amd.h
> index e6662adf3af4..e3d5f5ae2f46 100644
> --- a/arch/x86/include/asm/microcode_amd.h
> +++ b/arch/x86/include/asm/microcode_amd.h
> @@ -41,7 +41,7 @@ struct microcode_amd {
>   	unsigned int			mpb[];
>   };
>   
> -#define PATCH_MAX_SIZE (3 * PAGE_SIZE)
> +#define PATCH_MAX_SIZE (8 * PAGE_SIZE)
>   
>   #ifdef CONFIG_MICROCODE_AMD
>   extern void __init load_ucode_amd_bsp(unsigned int family);

thanks,
-- 
js
suse labs

