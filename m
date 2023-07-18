Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A53B757485
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjGRGnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjGRGng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:43:36 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D1F134
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:43:34 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fba86f069bso8526291e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689662613; x=1692254613;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v5CpVfHOQeL2LF002u5Xyqm/1T5/fOjKqrixrQcBn/c=;
        b=jjZa44APAVVwSEVbbKQM2rscObAtGMKOGRkEsRgMMQeKzhFHaZvhcpFYfrywmlc2UI
         4hb2sYJixCMQTFlS2SdycaSCDryKrIaltpB1lvEmyfGOiV/Kg8cDnEsZ6Yc8dX6kmeJP
         8gDeP8JODjkWbBb4vfddmZaOcaXIfq0ScJx/oC8kdE/T2CTCK6ZYyT//wFBeOiGYEfjb
         YYjnL9VZBW9gGnkST0ABokNNV2iSthnOsuwwPMv2cyZAR+Lw4BzJK/tOlGDAN9GQ26Sy
         5OWj7AE++xrelu0MP01x/l4PmZQsimKJnyYxbaAfjT7ASCOWlxTKqf6hcBPya+KCQSxq
         b6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689662613; x=1692254613;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v5CpVfHOQeL2LF002u5Xyqm/1T5/fOjKqrixrQcBn/c=;
        b=jrAw8URErIsnHZBrQxA20JUMR4eLY/9EmjcdIB3t/Nl+6xS4Y3W30dQuuWFFuUjcp7
         Phe1Pg3+n3DPfldmGWMEEUqs4JrGDQQDx8QHMsYFmMbeE7ZDKRy3US3bKHfQmcRWJ/yV
         huxrR2V+PswhdglgXDxbUqeNt+5LXU3JKHLzfmblW6+RWOEyVgrv+e3hhLxlYQ68ZeVG
         jzzXVCr6Y8S1sieAzl945ozVY4eG58jRL+xBzWWjif5iB2+/M3g9FXQ+s8z0EypoUxDE
         rJgzBgiRHMjRyrfN6eV9g6YL43dY1qT9tUVdNxvXRMk67n8I62K2Jqw1gMNRJUEbPvKR
         4buw==
X-Gm-Message-State: ABy/qLbU2A2wvSz9Ba0ZPIUfs8BRPM8NqqTkW0e6yQkk4virk4jA8qKT
        tZ7U6js/RUnvvLyVJk/YmoGAng==
X-Google-Smtp-Source: APBJJlFYj2Bl/pt3x1GWDI/VfNnq/0tUTHHr6EW2SJ7mBnZ57sFCMx6i+0/ln+RNqjDgRSEbozCT6Q==
X-Received: by 2002:ac2:530b:0:b0:4fb:81f2:422b with SMTP id c11-20020ac2530b000000b004fb81f2422bmr8178038lfh.54.1689662612904;
        Mon, 17 Jul 2023 23:43:32 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.222.251])
        by smtp.gmail.com with ESMTPSA id i14-20020adfefce000000b0031434c08bb7sm1383799wrp.105.2023.07.17.23.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 23:43:32 -0700 (PDT)
Message-ID: <aa9cdc3a-dc01-f480-cc75-7ddf0a5092d1@linaro.org>
Date:   Tue, 18 Jul 2023 08:43:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] KVM: x86:Fix warnings in debugfs.c
Content-Language: en-US
To:     shijie001@208suo.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org
Cc:     hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_5FEF30EB273BF931FF82DB522CA8CB13A307@qq.com>
 <d02e47813a9b22b2c625caf8ac5ae0fb@208suo.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <d02e47813a9b22b2c625caf8ac5ae0fb@208suo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/7/23 05:08, shijie001@208suo.com wrote:
> The following checkpatch warning is removed:
> WARNING: Prefer seq_puts to seq_printf
> 
> Signed-off-by: Jie Shi <shijie001@208suo.com>
> ---
>   arch/x86/kvm/debugfs.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/debugfs.c b/arch/x86/kvm/debugfs.c
> index ee8c4c3496ed..a3e118397aa3 100644
> --- a/arch/x86/kvm/debugfs.c
> +++ b/arch/x86/kvm/debugfs.c
> @@ -133,20 +133,20 @@ static int kvm_mmu_rmaps_stat_show(struct seq_file 
> *m, void *v)
>       mutex_unlock(&kvm->slots_lock);
> 
>       /* index=0 counts no rmap; index=1 counts 1 rmap */
> -    seq_printf(m, "Rmap_Count:\t0\t1\t");
> +    seq_puts(m, "Rmap_Count:\t0\t1\t");
>       for (i = 2; i < RMAP_LOG_SIZE; i++) {
>           j = 1 << (i - 1);
>           k = (1 << i) - 1;
>           seq_printf(m, "%d-%d\t", j, k);
>       }
> -    seq_printf(m, "\n");
> +    seq_puts(m, "\n");

If you really want to clean this, then seq_putc() is more
appropriate.

> 
>       for (i = 0; i < KVM_NR_PAGE_SIZES; i++) {
>           seq_printf(m, "Level=%s:\t", kvm_lpage_str[i]);
>           cur = log[i];
>           for (j = 0; j < RMAP_LOG_SIZE; j++)
>               seq_printf(m, "%d\t", cur[j]);
> -        seq_printf(m, "\n");
> +        seq_puts(m, "\n");

Ditto.

>       }
> 
>       ret = 0;

