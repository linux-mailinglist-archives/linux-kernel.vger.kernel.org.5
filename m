Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFB17B4F4C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236221AbjJBJoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236185AbjJBJn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:43:59 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB630EE
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 02:43:55 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-536b39daec1so5422471a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 02:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696239834; x=1696844634; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IDJtwog5v/98wuUqpM1mH1LIS964L7ubTthALakV0lQ=;
        b=QpFFy1fCY0AvFtBmacSvXhIVTd10puHwKiPtpqF0aNnbk3cjBiGVfszgltLar4PCM8
         2AMFyPcxt0McTcSIgUXwcFqYYyo2xu+wluHRw8UTv/MRmlVrwxX310dRqs02OKxo4BLG
         kISbD+A6oO7XwYOZtPeAEWTE09wxUcMV9Eub3r7ICDePX7XQDBIxvMryc4cXEqi9wAzb
         5tyWB3OZAJUZdYrhWBQNzfqe1qcJhTKcbvtZkOf11UaqdXSnWwWXBAwgnfHNUnoLAhjk
         7s41olLh9pT3XEN9CP4+yYfzGAvinqbhNWCF0fD/DkCuvMMB9O8nIxv0ZN+wnOyWKIJA
         XMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696239834; x=1696844634;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IDJtwog5v/98wuUqpM1mH1LIS964L7ubTthALakV0lQ=;
        b=rWptO8VrBQflTt9K6VAUw8mLf2jAL9PoM2SPF7E0pIu5dJyElcG6zC6nH0U+x0htcu
         /jtvFlJAFHO90VTDEML2VT5wDutb3fNH3akomZsfeaiQvTLFEhwF97bsQgeZfP2lfhYB
         urf65q1nkGOKOndE8ixahAhey8S3aqHWM7j7izeteAG78TfKzTfxe0Um+sIpNUeU46x1
         UGT07bD+Xq9O1++JfV5PlnwJEPRNuIloZCsd/vNdUZbFpkQUxzMMN7FAfs4FzScDSmO0
         4LosPQDsyhhJP1GPlFrzw9J7tFekipOrYqxMOdL8TgQ9bP9WE8c3XY49q+AuMNGzzsPl
         kgJw==
X-Gm-Message-State: AOJu0YymvmCPZW5WdSSraL0YF04unL8Z5rv49o6MG6X4OsPj/Syi2vcD
        vWsu5up67L5BSm+lv7/sZ2p5LA==
X-Google-Smtp-Source: AGHT+IFDJ1pdz7d3aCdpPH84bhsr5wOgC+8mqxYbO63RQaT7bDlIIb68+ozW/YpcSpe7iV47HAyRRw==
X-Received: by 2002:aa7:d51a:0:b0:522:30cc:a1f4 with SMTP id y26-20020aa7d51a000000b0052230cca1f4mr10020005edq.0.1696239834278;
        Mon, 02 Oct 2023 02:43:54 -0700 (PDT)
Received: from [192.168.86.24] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id j6-20020aa7ca46000000b0052889d090bfsm15286001edt.79.2023.10.02.02.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 02:43:53 -0700 (PDT)
Message-ID: <d57e4cc3-7ecb-bff2-f0e7-1d2ddbfa35fe@linaro.org>
Date:   Mon, 2 Oct 2023 10:43:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/5] misc: fastrpc: Add CRC support for remote buffers
Content-Language: en-US
To:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ekangupt@qti.qualcomm.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, fastrpc.upstream@qti.qualcomm.com
References: <1695205890-21018-1-git-send-email-quic_ekangupt@quicinc.com>
 <1695205890-21018-2-git-send-email-quic_ekangupt@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <1695205890-21018-2-git-send-email-quic_ekangupt@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ekansh,
Thankyou for the patch,

Looks like this series depends on Multi Mode series, can you include 
them together.

--srini

On 20/09/2023 11:31, Ekansh Gupta wrote:
> CRC check for input and output argument helps in ensuring data
> consistency over a remote call. If user intends to enable CRC check,
> first local user CRC is calculated at user end and a CRC buffer is
> passed to DSP to capture remote CRC values. DSP is expected to
> write to the remote CRC buffer which is then compared at user level
> with the local CRC values.
> 
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> ---
>   drivers/misc/fastrpc.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 04eaf6c..337ec1f 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -610,6 +610,7 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
>   	/* Released in fastrpc_context_put() */
>   	fastrpc_channel_ctx_get(cctx);
>   
> +	ctx->crc = (u32 *)(uintptr_t)invoke->crc;
>   	ctx->sc = sc;
>   	ctx->retval = -1;
>   	ctx->pid = current->pid;
> @@ -1063,6 +1064,7 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
>   	struct fastrpc_invoke_buf *list;
>   	struct fastrpc_phy_page *pages;
>   	u64 *fdlist;
> +	u32 *crclist;
>   	int i, inbufs, outbufs, handles;
>   
>   	inbufs = REMOTE_SCALARS_INBUFS(ctx->sc);
> @@ -1070,7 +1072,8 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
>   	handles = REMOTE_SCALARS_INHANDLES(ctx->sc) + REMOTE_SCALARS_OUTHANDLES(ctx->sc);
>   	list = fastrpc_invoke_buf_start(rpra, ctx->nscalars);
>   	pages = fastrpc_phy_page_start(list, ctx->nscalars);
> -	fdlist = (uint64_t *)(pages + inbufs + outbufs + handles);
> +	fdlist = (u64 *)(pages + inbufs + outbufs + handles);
> +	crclist = (u32 *)(fdlist + FASTRPC_MAX_FDLIST);
>   
>   	for (i = inbufs; i < ctx->nbufs; ++i) {
>   		if (!ctx->maps[i]) {
> @@ -1094,6 +1097,10 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
>   			fastrpc_map_put(mmap);
>   	}
>   
> +	if (ctx->crc && crclist && rpra) {
> +		if (copy_to_user((void __user *)ctx->crc, crclist, FASTRPC_MAX_CRCLIST * sizeof(u32)))
> +			return -EFAULT;
> +	}
>   	return 0;
>   }
>   
> @@ -1706,6 +1713,7 @@ static int fastrpc_multimode_invoke(struct fastrpc_user *fl, char __user *argp)
>   
>   	switch (invoke.req) {
>   	case FASTRPC_INVOKE:
> +	case FASTRPC_INVOKE_ENHANCED:
>   		/* nscalars is truncated here to max supported value */
>   		if (copy_from_user(&einv, (void __user *)(uintptr_t)invoke.invparam,
>   				   invoke.size))
