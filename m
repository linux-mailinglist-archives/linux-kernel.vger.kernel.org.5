Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7604F78A534
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 07:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjH1F0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 01:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjH1F0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 01:26:36 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDB892
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 22:26:31 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-4121130e7afso15591891cf.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 22:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1693200391; x=1693805191;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=108AsllHoPT0Lzt6ytjY6pwVBBXW6+UeWb5fHpdiN2Q=;
        b=ldkG786to9BGWtLjh1WpxPRqStCYl8LmG4rHbPoL584Ls+asn+5YyMI61vJLYr6C4t
         2fmq2AzgCsmbCOMiBqUszMj3zNyh9TcrZRbKwG4w4ulMng1rF9U39n1QYbXcMwqMl9mw
         YTmukQHhLrSUlJeclpPyPGv9x4XYuLCD/EVOt2l3sRuMUOFkPha71hxR9S1i1sVc530C
         TRJoYH624KKJC61vtkAJYiKDE+NAzAIIDnM9fJrG/+3B8/IW4DTJhPOtbxJX1OSgt0Zd
         JKfXUgJ5WriQuw+RZOisBtZYZqkwfLR66g527y4cNsWVAQ6cCcO8kAiUmku2CsbPLZVH
         VuOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693200391; x=1693805191;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=108AsllHoPT0Lzt6ytjY6pwVBBXW6+UeWb5fHpdiN2Q=;
        b=ap4WjpWmiYh0iw6oFfniKcA3VXw/Q+vVJMtIOa6Q7Z3wWag0ID99HYnR/JO82zVGvO
         D5IaNk9avTa0xC27a6+bBeC9lJD3He7y4hICcLzEc+J2tA1UiN7oBe3gymRHpv/4y6JT
         io4oB3lc/5l8pQ023rX/QqnIEuwcDnnvR10up/xMdTHjsF9a6soic+QdoU73gTTbBrir
         UI5W/z/y+gsuOt/7c7/99fH+lfrCSI89dNK8MXoVvAFn604nGAyTvthejG8eB3Q3ZZxo
         kN2VUQUye7wK697jVZ+JTQqB53izjMNjYpPvbC1mdC9DyKa9g1LQ9S8V45NJkjOUKFUr
         8pGw==
X-Gm-Message-State: AOJu0YzMImiu5JTTk9SPC1xgUPUDy8DmjP0dIcfGBfA1j17OUMcgLoqD
        KgTOV5TctjzE2i2skfVlIO+Wzg==
X-Google-Smtp-Source: AGHT+IHEQKuNBZ6qJ4N2xNz7ofrzmnsHi+TY1oiaRD1gEJ0FxfGbS6fr0a1lahg4MRvwzZ6B70mZTw==
X-Received: by 2002:a05:622a:1182:b0:410:9855:aae with SMTP id m2-20020a05622a118200b0041098550aaemr25612358qtk.19.1693200391084;
        Sun, 27 Aug 2023 22:26:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:2000:b002:6140:58e3:2550:7e99? ([2600:1700:2000:b002:6140:58e3:2550:7e99])
        by smtp.gmail.com with ESMTPSA id bt4-20020ac86904000000b00403f1a7be90sm2084094qtb.88.2023.08.27.22.26.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Aug 2023 22:26:30 -0700 (PDT)
Message-ID: <15058508-9e21-0d10-4eca-2c8a5562d36c@sifive.com>
Date:   Mon, 28 Aug 2023 00:26:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] crash_core.c: remove unneeded functions
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, linux-riscv@lists.infradead.org,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        thunder.leizhen@huawei.com, dyoung@redhat.com, prudo@redhat.com,
        linux-kernel@vger.kernel.org
References: <20230827101128.70931-1-bhe@redhat.com>
 <20230827101128.70931-9-bhe@redhat.com>
From:   Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20230827101128.70931-9-bhe@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baoquan,

On 2023-08-27 5:11 AM, Baoquan He wrote:
> So far, nobody calls functions parse_crashkernel_high() and
> parse_crashkernel_high(), remove both of them.

minor typo: should be parse_crashkernel_low().

Regards,
Samuel

> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  include/linux/crash_core.h |  4 ----
>  kernel/crash_core.c        | 18 ------------------
>  2 files changed, 22 deletions(-)
> 
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index 2f732493e922..0c512a80a768 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -80,10 +80,6 @@ void final_note(Elf_Word *buf);
>  int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
>  		unsigned long long *crash_size, unsigned long long *crash_base,
>  		unsigned long long *low_size, bool *high);
> -int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
> -		unsigned long long *crash_size, unsigned long long *crash_base);
> -int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
> -		unsigned long long *crash_size, unsigned long long *crash_base);
>  
>  #ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
>  #ifndef DEFAULT_CRASH_KERNEL_LOW_SIZE
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 6bc00cc390b5..61a8ea3b23a2 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -323,24 +323,6 @@ int __init parse_crashkernel(char *cmdline,
>  	return 0;
>  }
>  
> -int __init parse_crashkernel_high(char *cmdline,
> -			     unsigned long long system_ram,
> -			     unsigned long long *crash_size,
> -			     unsigned long long *crash_base)
> -{
> -	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
> -				suffix_tbl[SUFFIX_HIGH]);
> -}
> -
> -int __init parse_crashkernel_low(char *cmdline,
> -			     unsigned long long system_ram,
> -			     unsigned long long *crash_size,
> -			     unsigned long long *crash_base)
> -{
> -	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
> -				suffix_tbl[SUFFIX_LOW]);
> -}
> -
>  /*
>   * Add a dummy early_param handler to mark crashkernel= as a known command line
>   * parameter and suppress incorrect warnings in init/main.c.

