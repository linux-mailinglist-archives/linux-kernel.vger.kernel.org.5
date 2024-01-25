Return-Path: <linux-kernel+bounces-38320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1800B83BDCA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A6C81F323D9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708D61CAA2;
	Thu, 25 Jan 2024 09:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YoiF5AAH"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CFB1BF38
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706175995; cv=none; b=u2QgO6z9JlE9F9Zz7uCq2I4rfAIORIvAgynqXzh65+tAVf+iOOPtZRq3294VsDJ8OKmGx76g/KX5RDU/0mpyBqZZg1EPCwiZwKv4oqBNiPUDL9p56ZiugmQ6MWhrl1aq3WnWUngmAKWR9fwkSyx1O/5NMnoeXTct4VUiIhZ0OWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706175995; c=relaxed/simple;
	bh=gmD+NvOsDsUZuLvDpzmgzfyKbOs5AbVhb/st6S83/PM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IOEXlR8VFOaB8DRGHX3q5R8z9MZBugsu4SLSg61vwm8pFTOx5v15p0pvCdhXkCOiaHB4TijAr2K2ifaVjBtgWvh1TPi1IRYqsnr9OwKsiYBuGX4jrG0D1cuF14EFFtwcGFxqKvxKXLjMVS/gLH+Zx37qGUjQwZenm1V1rRouDMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YoiF5AAH; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40eb0836f8dso38999235e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 01:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706175992; x=1706780792; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uKjEA1ufSVAWNn9i+0G+DRJUHaevlwhyDkwZbs4cgCo=;
        b=YoiF5AAH+/igKarmgDURmMHuUFYpz7lXbfbyB+yXt6SQ9TK5pF4E9zE8+bbqUug50g
         8ER2l65JAFLCX2/wItWaGSlsT3N48eVMU0ejmXBzWRr1O4pZrNiRmnM+G2s6hbdVaPKn
         CbjgdRV8hs7l6+vPieFy6BYIFg7v9/L+IfmEsVXu43PmYcea8r7UqqjL7WlBZ6+YcGca
         Nqwuccx5Fxd1WvNne1Rdi5qRjfKgjq41CuMtrdbjrAhsLlMkyIx0JIE3JWzuE90JLnbD
         J7MkmkGXhb+erMqJJWyXR6gB9RtZ1dGslYte2YnDh2yGhsig8ADq/Gtu/aU+B8QaF5e5
         yDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706175992; x=1706780792;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uKjEA1ufSVAWNn9i+0G+DRJUHaevlwhyDkwZbs4cgCo=;
        b=kL7VtT+BEZGApUuwLdmNbPwPWA+K9/pz+wwHMd3y2mJDG375rQC7acuzuoRSuLXkXl
         902HoAoFBwIUQo2YSqO6qRnkr8u99grBDrNRcWdtu9ql6yedoSDEVvcxbxErnncyCPgZ
         ejjl/WaC9chUr4OS5GvCCk46eSIdcSZRUYceT0ShBIqvgYJ0euEswjVuqouEQeOEIGL0
         0D1+2V1LCdF3EKybjduAUBj3x3pR/FCMMA90i30cyTWh0x8idWbAzfIzKxAhp7XvNZD3
         yLtLJid7ktjmyUgRNtevbpCGKZTdrC3wV9eRbDVLzKuLd/CrC+Bh0F3aofzER2QwcFDR
         XaMg==
X-Gm-Message-State: AOJu0Yz+4MOw+0SSntunh5B41DocY8ckhu6pGXJhIctwmICYCZfe05sJ
	HxpklZ/e9Wp5WPvG3qBuEw14x1L52zs1QfUVjC8ZiUHp60y1LnFl5gfhg4g+IyE=
X-Google-Smtp-Source: AGHT+IGn/FM9gXJkdJJpOQ1l+2CxmF5gIptmChuQvcivFbgEobBNM7oIX991MqEP8m0r+4vw7WNaCQ==
X-Received: by 2002:a05:600c:a08:b0:40e:69da:4815 with SMTP id z8-20020a05600c0a0800b0040e69da4815mr295213wmp.35.1706175991985;
        Thu, 25 Jan 2024 01:46:31 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:e809:1d8e:6f0b:53c1? ([2a01:e0a:3cb:7bb0:e809:1d8e:6f0b:53c1])
        by smtp.gmail.com with ESMTPSA id j11-20020a05600c190b00b0040e53f24ceasm1956031wmq.16.2024.01.25.01.46.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 01:46:31 -0800 (PST)
Message-ID: <d33bad27-da65-4866-96e7-a249824fcb6e@linaro.org>
Date: Thu, 25 Jan 2024 10:46:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] optee: support wq_sleep_timeout
Content-Language: en-US
To: "gavin.liu" <gavin.liu@mediatek.com>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20240125052744.18866-1-gavin.liu@mediatek.com>
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20240125052744.18866-1-gavin.liu@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/25/24 06:27, gavin.liu via OP-TEE wrote:
> From: Gavin Liu <gavin.liu@mediatek.com>
> 
> Add wq_sleep_timeout to support self waking when timeout for secure
> driver usage.
> 
> Signed-off-by: Gavin Liu <gavin.liu@mediatek.com>
> ---
>  drivers/tee/optee/notif.c         |  9 +++++++--
>  drivers/tee/optee/optee_private.h |  2 +-
>  drivers/tee/optee/rpc.c           | 10 ++++++++--
>  3 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tee/optee/notif.c b/drivers/tee/optee/notif.c
> index 05212842b0a5..d5e5c0645609 100644
> --- a/drivers/tee/optee/notif.c
> +++ b/drivers/tee/optee/notif.c
> @@ -29,7 +29,7 @@ static bool have_key(struct optee *optee, u_int key)
>  	return false;
>  }
>  
> -int optee_notif_wait(struct optee *optee, u_int key)
> +int optee_notif_wait(struct optee *optee, u_int key, u32 timeout)
>  {
>  	unsigned long flags;
>  	struct notif_entry *entry;
> @@ -70,7 +70,12 @@ int optee_notif_wait(struct optee *optee, u_int key)
>  	 * Unlock temporarily and wait for completion.
>  	 */
>  	spin_unlock_irqrestore(&optee->notif.lock, flags);
> -	wait_for_completion(&entry->c);
> +	if (timeout != 0) {
> +		if (!wait_for_completion_timeout(&entry->c, timeout))
> +			rc = -ETIMEDOUT;
> +	} else {
> +		wait_for_completion(&entry->c);
> +	}
>  	spin_lock_irqsave(&optee->notif.lock, flags);
>  
>  	list_del(&entry->link);
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> index 7a5243c78b55..da990c4016ec 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -252,7 +252,7 @@ struct optee_call_ctx {
>  
>  int optee_notif_init(struct optee *optee, u_int max_key);
>  void optee_notif_uninit(struct optee *optee);
> -int optee_notif_wait(struct optee *optee, u_int key);
> +int optee_notif_wait(struct optee *optee, u_int key, u32 timeout);
>  int optee_notif_send(struct optee *optee, u_int key);
>  
>  u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_params,
> diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> index e69bc6380683..14e6246aaf05 100644
> --- a/drivers/tee/optee/rpc.c
> +++ b/drivers/tee/optee/rpc.c
> @@ -130,6 +130,8 @@ static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
>  static void handle_rpc_func_cmd_wq(struct optee *optee,
>  				   struct optee_msg_arg *arg)
>  {
> +	int rc = 0;
> +
>  	if (arg->num_params != 1)
>  		goto bad;
>  
> @@ -139,7 +141,8 @@ static void handle_rpc_func_cmd_wq(struct optee *optee,
>  
>  	switch (arg->params[0].u.value.a) {
>  	case OPTEE_RPC_NOTIFICATION_WAIT:
> -		if (optee_notif_wait(optee, arg->params[0].u.value.b))
> +		rc = optee_notif_wait(optee, arg->params[0].u.value.b, arg->params[0].u.value.c);

optee/optee_rpc_cmd.h needs updating (near "Waiting on notification") to reflect the meaning
of value.c.

Was value.c required to be zero prior to this change? Otherwise this could lead to undefined
behavior.
 

> +		if (rc)
>  			goto bad;
>  		break;
>  	case OPTEE_RPC_NOTIFICATION_SEND:
> @@ -153,7 +156,10 @@ static void handle_rpc_func_cmd_wq(struct optee *optee,
>  	arg->ret = TEEC_SUCCESS;
>  	return;
>  bad:
> -	arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> +	if (rc == -ETIMEDOUT)
> +		arg->ret = TEEC_ERROR_BUSY;
> +	else
> +		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
>  }
>  
>  static void handle_rpc_func_cmd_wait(struct optee_msg_arg *arg)

-- 
Jerome

