Return-Path: <linux-kernel+bounces-108623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1129880D2C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DD8B1C20AA5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8413381AC;
	Wed, 20 Mar 2024 08:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZgUnKxf"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADF122075;
	Wed, 20 Mar 2024 08:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710923837; cv=none; b=NNlvaGagMh4LSfKh8P1knKKGl6SAwxmwrKvHTs4r1sYxSOESCgwlMnEx9Ph0HOlWK1RC5pVvankUzp19Ftbqll2bNmKNJ2hzD2f+BQHTueRaBm54C4sKQJBXNVp6O00LZVb/Evu5TI0URjSSxVB6Ggjpl1WKMhRk+TcleTtfvCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710923837; c=relaxed/simple;
	bh=EFLt4e6oqFF2WTxkgQw0GLain+7038G1Uq8oXPYQNUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cXgkBpox7Js+9an2mwvgJdo81AtMyei+bgOcglSEQaL9BFR2MZiGBP19kc3adCTHlJRt1f60Zho7vRHZcm6gmrEJuJwcSTGEKBL/+GQPKtH/DRfJ/ejwjK2qp31L+fNs8PuLksjiT6wjlAiylLt/TUO37U+dwaSCCvHKguTyHF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZgUnKxf; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4146af3ebc8so3436985e9.2;
        Wed, 20 Mar 2024 01:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710923833; x=1711528633; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O0h9ShhKwKo94HpkMlCl4q0fJQvniE/fEbxFxlkuix8=;
        b=dZgUnKxfdoQXyJux3cOwXNxjh2wlfruhsuoPT4X1tS0pyCueRpG3DNPeTp1bNIyX4D
         X++LdCX1k/FV0zOeAcYc5pAw6GcbUrofKdVEDsH+ufmx/UAmezk9kDABp3WGPpq97DQP
         lhYdXmuP7+4njkxFkts0QQQsVGqgCF1DqRxT41jWf3uf7ytdPSUEUwQBYdH+GKPXPhhh
         j/weh58sUeUNIUJNcEAvbzohuYcP2BLDU3C6XIwP3HnVPGjr+6eHJgN6q2O3u+8T38Kp
         4EWXmn5fg6RdFL11uJSXQPHloN2CCqGAEcKBytgS/4CMawwZ+JlJHh55gyignziAyuGe
         j2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710923833; x=1711528633;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O0h9ShhKwKo94HpkMlCl4q0fJQvniE/fEbxFxlkuix8=;
        b=Qe3YBjK5CnDbBkAlokMZAyS5eQFgbPf/EYEEPCkBgn3b8mdCbCzKzXAWnWIDwFPCMe
         cqq2FY9qCWLddVFppHhIjG1qSzOnyrgCnuRfKyPdPlSGTRbDqeg283nqGSOpBzuVYiGw
         iilbLWtfPKZqczJqF28ssjadz3EeYSA9GSA7tPsQ/uyxJfe9XrPnSvRUmDMGQVd9LVTU
         ZAfwHlstDAXbq1kLX5TrH7piyLEnk1nJ19tuKiJozTNtRuuWdQyCDcqDWxEJL7wgAXuf
         QqWaLsNcGEsPFMlR4FPZ3R97cZSvQctJUN4BbdTaLZazDWJ6So+i/4B+vzSz3MJb5fZ+
         08vw==
X-Forwarded-Encrypted: i=1; AJvYcCU77Ho+AZ8syj4853OzzzD6nk44fwhZgdMhs2/JPt8h4Ol7rkBhhNoOdErMuB80Tv1j4Lbts6/51mKYg3iOQqodmwvSyyfpRx0Dwac1a2AZ9q9C6Aywvl4ekusmr4YWS4e+Zf1hT0LUb4A=
X-Gm-Message-State: AOJu0Yw6hmQ2/w16aFy4OH3ZJaBgza7Be+71qxDR62QBefpOXBkUlKvt
	R3HMzOAQ2S6MyNc7bOWTx07BLGpzxjU/18k2j2tQAmY8cO0RG/PB
X-Google-Smtp-Source: AGHT+IGa58nGCJKekIoS3MzHD3SUCd1Vz9UMMJhXb0mgycB8I8fgzPR69/0+gTJ7cpDNluNemiyHoA==
X-Received: by 2002:a5d:6450:0:b0:33d:a011:ae42 with SMTP id d16-20020a5d6450000000b0033da011ae42mr11461520wrw.38.1710923833161;
        Wed, 20 Mar 2024 01:37:13 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id dd15-20020a0560001e8f00b0033ce727e728sm14168784wrb.94.2024.03.20.01.37.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 01:37:12 -0700 (PDT)
Message-ID: <57c49fd1-a55f-47d5-a057-54d360c77906@gmail.com>
Date: Wed, 20 Mar 2024 09:37:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Linaro-mm-sig] [PATCH] dma-buf: Fix NULL pointer dereference in
 sanitycheck()
Content-Language: en-US
To: Pavel Sakharov <p.sakharov@ispras.ru>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 Arvind Yadav <Arvind.Yadav@amd.com>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, Fedor Pchelkin <pchelkin@ispras.ru>,
 lvc-project@linuxtesting.org
References: <20240319231527.1821372-1-p.sakharov@ispras.ru>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240319231527.1821372-1-p.sakharov@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 20.03.24 um 00:15 schrieb Pavel Sakharov:
> If due to a memory allocation failure mock_chain() returns NULL, it is
> passed to dma_fence_enable_sw_signaling() resulting in NULL pointer
> dereference there.
>
> Call dma_fence_enable_sw_signaling() only if mock_chain() succeeds.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: d62c43a953ce ("dma-buf: Enable signaling on fence for selftests")
> Signed-off-by: Pavel Sakharov <p.sakharov@ispras.ru>

Reviewed-by: Christian König <christian.koenig@amd.com>

Going to push it to drm-misc-fixes in a minute.

Thanks,
Christian.

>
> ---
>   drivers/dma-buf/st-dma-fence-chain.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/dma-buf/st-dma-fence-chain.c b/drivers/dma-buf/st-dma-fence-chain.c
> index 9c2a0c082a76..ed4b323886e4 100644
> --- a/drivers/dma-buf/st-dma-fence-chain.c
> +++ b/drivers/dma-buf/st-dma-fence-chain.c
> @@ -84,11 +84,11 @@ static int sanitycheck(void *arg)
>   		return -ENOMEM;
>
>   	chain = mock_chain(NULL, f, 1);
> -	if (!chain)
> +	if (chain)
> +		dma_fence_enable_sw_signaling(chain);
> +	else
>   		err = -ENOMEM;
>
> -	dma_fence_enable_sw_signaling(chain);
> -
>   	dma_fence_signal(f);
>   	dma_fence_put(f);
>
> --
> 2.44.0
>
> _______________________________________________
> Linaro-mm-sig mailing list -- linaro-mm-sig@lists.linaro.org
> To unsubscribe send an email to linaro-mm-sig-leave@lists.linaro.org


