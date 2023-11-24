Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3400A7F74EF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbjKXN11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235173AbjKXN1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:27:03 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5E5199A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:26:59 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-54917ef6c05so2627771a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700832418; x=1701437218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fc7fhdesv2TTKM5jfB6vSgH1s61myNEyMCDD2LMJNmI=;
        b=TIvmkvN8wNjoRDZxIrfG25aA2I6RXhFMYDf2p7zhSISlpsfmAvv9kbGMOcRoMJ84uZ
         sFjQ7katyu8sjzS6RopMH6WtqQyIRUtsoyOQl1OuAL08FbwjSSHc0zn4ZfCD3fo0SHps
         OX0hjPAoEKBSzkPuefstJJg4pKFTdUFOVvZgJrfXl4NllMgm7udoZyZ5g+geiZi1Afiq
         62pH+E/E1MXK1UcyzcOk6MPp7Xpi1BVfgFsxiahx19tE5g1iBQxnuhPku0Q5Fw4J7cta
         e6RJwx76MIezOCR6iUBr5RSIXH9EElFO734rsAL9BTThIjOEpRh3y/3HXefSq4P1z49F
         bmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700832418; x=1701437218;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fc7fhdesv2TTKM5jfB6vSgH1s61myNEyMCDD2LMJNmI=;
        b=qipsewoGY6hdJVYWIJsBJC9ZFVb3rPZ2sc0h5EefwQcdrhUHyCAdZtTiHw9yAt8yTv
         G3DijNBg4Ak9eCNKSOLmqLPseH4RFyMTU83vanV19qkelL1TqXMV8gD8K71u/rg+WI9B
         nDsfMrKTDJlRG1sp/9FpNFmvUbXGe09sn3X9Gzab02RXGmyD5isDyj7K/llB5jCpXKyI
         5rjygjyKHyF/Ls2HoLQdm5JFdxDE0vhjN2Tct41q9AgOMtfxQVGYALt1Vg05pVmiTkDm
         9W2rS7iq/03fj/SRzX0jqEJkbbwdJgutn3rZ+1UaP4qxe10gCszv5cIF3uHvHQlUxGjt
         T0mA==
X-Gm-Message-State: AOJu0Yzl+d7A2vS9pHpidSDB4sg+FJNJvpIudrMkdYGKFGVATRzHfdgH
        Pn755EX2DDoUr8vb7OChJLQRlg==
X-Google-Smtp-Source: AGHT+IFvmU9MV6dBfM4J7s8/nW8aiBBOleJq0MfOZK7V+UVCEQIkQgaId85WEMcD3WEemsH/uNVnZw==
X-Received: by 2002:a50:d4cf:0:b0:548:d344:161a with SMTP id e15-20020a50d4cf000000b00548d344161amr2199461edj.15.1700832417788;
        Fri, 24 Nov 2023 05:26:57 -0800 (PST)
Received: from [192.168.86.103] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id o26-20020a056402039a00b005487c48d9ebsm1793399edv.57.2023.11.24.05.26.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 05:26:57 -0800 (PST)
Message-ID: <c79617c2-6023-4179-84db-3e37f3c1b050@linaro.org>
Date:   Fri, 24 Nov 2023 13:26:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/5] misc: fastrpc: Add CRC support for remote buffers
Content-Language: en-US
To:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        linux-arm-msm@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
References: <20231121094844.5764-1-quic_ekangupt@quicinc.com>
 <20231121094844.5764-3-quic_ekangupt@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20231121094844.5764-3-quic_ekangupt@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/11/2023 09:48, Ekansh Gupta wrote:
> CRC check for input and output argument helps in ensuring data
> consistency over a remote call. If user intends to enable CRC check,
> first local user CRC is calculated at user end and a CRC buffer is
> passed to DSP to capture remote CRC values. DSP is expected to
> write to the remote CRC buffer which is then compared at user level
> with the local CRC values.
> 
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> ---
> Changes in v7:
>    - Rebase the patch to latest kernel version
> 
>   drivers/misc/fastrpc.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 265e34f53c4e..55f126c779cb 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -611,6 +611,7 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
>   	/* Released in fastrpc_context_put() */
>   	fastrpc_channel_ctx_get(cctx);
>   
> +	ctx->crc = (u32 *)(uintptr_t)invoke->crc;
>   	ctx->sc = sc;
>   	ctx->retval = -1;
>   	ctx->pid = current->pid;
> @@ -1067,6 +1068,7 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
>   	struct fastrpc_invoke_buf *list;
>   	struct fastrpc_phy_page *pages;
>   	u64 *fdlist;
> +	u32 *crclist;
>   	int i, inbufs, outbufs, handles;
>   
>   	inbufs = REMOTE_SCALARS_INBUFS(ctx->sc);
> @@ -1074,7 +1076,8 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
>   	handles = REMOTE_SCALARS_INHANDLES(ctx->sc) + REMOTE_SCALARS_OUTHANDLES(ctx->sc);
>   	list = fastrpc_invoke_buf_start(rpra, ctx->nscalars);
>   	pages = fastrpc_phy_page_start(list, ctx->nscalars);
> -	fdlist = (uint64_t *)(pages + inbufs + outbufs + handles);
> +	fdlist = (u64 *)(pages + inbufs + outbufs + handles);
> +	crclist = (u32 *)(fdlist + FASTRPC_MAX_FDLIST);
>   
>   	for (i = inbufs; i < ctx->nbufs; ++i) {
>   		if (!ctx->maps[i]) {
> @@ -1099,6 +1102,10 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
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
> @@ -1719,6 +1726,7 @@ static int fastrpc_multimode_invoke(struct fastrpc_user *fl, char __user *argp)
>   
>   	switch (invoke.req) {
>   	case FASTRPC_INVOKE:
> +	case FASTRPC_INVOKE_ENHANCED:

Isn't this change part of 1/5 patch?



>   		/* nscalars is truncated here to max supported value */
>   		if (copy_from_user(&einv, (void __user *)(uintptr_t)invoke.invparam,
>   				   invoke.size))
