Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6039C7B4F0E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236104AbjJBJaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236098AbjJBJaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:30:20 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DF4A4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 02:30:16 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99de884ad25so2281315566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 02:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696239014; x=1696843814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/4UpxCQBxDX1LugDmhEIeIka2jTxgrDKUQizgQT2+9I=;
        b=vo/XS2gPWoLFkbpdYQuZJ6VuPA1b0gCLGcN+cOSh9TeNP7o1Uc7QOm4T5goInTYISi
         iE6irRDRNwHTeICdJVE7dRJ+kuMzP/Spv9JU66GkLesYmFQbam9t6kEPNTFL8egHfxCy
         lADE8AzrcO7/Zo+i8HYHgBqsR3Oa2Hw9gx9P6lecm+w2kQ76090oxxdi9yZAQlYSDC0H
         bifwjpLoZhj58eu+9M9ToqEBoo6rlQSFCuL7TzDRl9mPK31fIE7ylDzaQb0bP97ibyFU
         Kgrz7ZTaLbFXYR7J/1GuhdvGo3dc3Pam3ADkDDxsKR6FUkuls2K4Hb3aIcXk2SgM2PQX
         /PWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696239014; x=1696843814;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/4UpxCQBxDX1LugDmhEIeIka2jTxgrDKUQizgQT2+9I=;
        b=e7BS/uG/IPoOekEiy/xQv79CJ4XKfTBIvfht+SaLr9lKUzndGPJKCkA3fDjwOvgVCm
         JUsp5zCK1sQL+P0Cc5gLDS3MC5S3Pnt6gxozyqU7GOg0VHiTgDLMQKecpT7wQbhJoNc9
         1Pho409dVPTq4fP/ohVuOU40HW08g9F6W6sxHnwWzWECAayK+gdODGgfRL5QpSJt28qv
         wyzrq2gN2AvfK3vU4WRQPdhBDxAQw4A3lWwbBywsvyxPUKr4bBBe5784rHCbu/d0dsIl
         /Zq5AkRsIXUehgHzksuxkoM18RwM0LhMn3WERn6Bu7bQyBCjhSnXoddbhF4SkBEy2jmb
         y4iQ==
X-Gm-Message-State: AOJu0YzN57wArIbPVVpJuFEWzzJozWxzGdKm/nZ3UdQhpld8CdEWjnZG
        ORePFygJcKaijDTkjhjDI/2iKA==
X-Google-Smtp-Source: AGHT+IHO6AD3vjK5Y1otTfkKT2XlBvraVvG/KjArGCr0JQ6NJdniqtEewGE9pqBfr+Z9/c6C3j0dsQ==
X-Received: by 2002:a17:906:2d1:b0:9ae:5fe1:ef01 with SMTP id 17-20020a17090602d100b009ae5fe1ef01mr9843170ejk.37.1696239014687;
        Mon, 02 Oct 2023 02:30:14 -0700 (PDT)
Received: from [192.168.86.24] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id fi3-20020a170906da0300b009a1fef32ce6sm16866511ejb.177.2023.10.02.02.30.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 02:30:14 -0700 (PDT)
Message-ID: <92db4a0d-c416-6a1c-ad71-15c2156d59aa@linaro.org>
Date:   Mon, 2 Oct 2023 10:30:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 2/3] misc: fastrpc: Free DMA handles for RPC calls with
 no arguments
Content-Language: en-US
To:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ekangupt@qti.qualcomm.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, fastrpc.upstream@qti.qualcomm.com,
        stable <stable@kernel.org>
References: <1695973360-14369-1-git-send-email-quic_ekangupt@quicinc.com>
 <1695973360-14369-3-git-send-email-quic_ekangupt@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <1695973360-14369-3-git-send-email-quic_ekangupt@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/09/2023 08:42, Ekansh Gupta wrote:
> The FDs for DMA handles to be freed is updated in fdlist by DSP over
> a remote call. This holds true even for remote calls with no
> arguments. To handle this, get_args and put_args are needed to
> be called for remote calls with no arguments also as fdlist
> is allocated in get_args and FDs updated in fdlist is freed
> in put_args.
> 
> Fixes: 8f6c1d8c4f0c ("misc: fastrpc: Add fdlist implementation")
> Cc: stable <stable@kernel.org>
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> ---
>   drivers/misc/fastrpc.c | 23 ++++++++++-------------
>   1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index fb92197..a52701c 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -1091,6 +1091,7 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
>   		}
>   	}
>   
> +	/* Clean up fdlist which is updated by DSP */
>   	for (i = 0; i < FASTRPC_MAX_FDLIST; i++) {
>   		if (!fdlist[i])
>   			break;
> @@ -1157,11 +1158,9 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
>   	if (IS_ERR(ctx))
>   		return PTR_ERR(ctx);
>   
<---
> -	if (ctx->nscalars) {
> -		err = fastrpc_get_args(kernel, ctx);
> -		if (err)
> -			goto bail;
> -	}
> +	err = fastrpc_get_args(kernel, ctx);
> +	if (err)
> +		goto bail;
-->
I dont see any point of the above change as fastrpc_internal_invoke will 
be called from kernel with nscalars always set.

do you see a path that does not set this?

--srini
>   
>   	/* make sure that all CPU memory writes are seen by DSP */
>   	dma_wmb();
> @@ -1185,14 +1184,12 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
>   	if (err)
>   		goto bail;
>   
> -	if (ctx->nscalars) {
> -		/* make sure that all memory writes by DSP are seen by CPU */
> -		dma_rmb();
> -		/* populate all the output buffers with results */
> -		err = fastrpc_put_args(ctx, kernel);
> -		if (err)
> -			goto bail;
> -	}
> +	/* make sure that all memory writes by DSP are seen by CPU */
> +	dma_rmb();
> +	/* populate all the output buffers with results */
> +	err = fastrpc_put_args(ctx, kernel);
> +	if (err)
> +		goto bail;
>   
>   bail:
>   	if (err != -ERESTARTSYS && err != -ETIMEDOUT) {
