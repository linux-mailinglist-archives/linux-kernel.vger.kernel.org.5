Return-Path: <linux-kernel+bounces-25973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E9482D915
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBFC31F21F4E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 12:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F44E156DD;
	Mon, 15 Jan 2024 12:51:45 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B011841
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 12:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55760f84177so1736677a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 04:51:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705323101; x=1705927901;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PX4w1eO8SQ4miExZH1g1NHHO884JSkp7W4e0LRAChEM=;
        b=lCa5RhvMh3UW+MLSmWQPxxddXmP76PLXY3BS7FCqKEqMihciURxQUAgzF4BEKgJjGB
         Qt9x3YRNFKutT7RgJxwiiVGEYwitPi33hTXbgXMZA2bFm/zseLe13iGMCCvv4YnCNKPr
         ffzXfpX/WIMyU45y2323o75hfD0n/8879poftppq5rINxIn0fJvfjIQIxa4H6tKaAfCe
         IdbeHOL1awPaF1uc4u0wc9Q94O34mMDoZB73rUxh/F339m1S6useoI6+joZdjlQ/oFBd
         xerxkka6QL0+lBk6tLH8r1XnI48I9z/8T7tSTzP80uGRVB0LLhJM2zJPOwCXkGejNh1w
         4m+A==
X-Gm-Message-State: AOJu0YwkClcZsGILdPvrC4z8PuGC9CtCOZwTALOfv9omdHQR9dWPui6E
	lu49H3QAB3dDyFL2zgXhxFM=
X-Google-Smtp-Source: AGHT+IEfK6avEZem+pRkHHZunH+Pl4RVkxYgQRbCbCnUJ9HnI1xylja2qQdlAg0A0Ss/urlYNoB4eA==
X-Received: by 2002:aa7:da4a:0:b0:558:f40b:4581 with SMTP id w10-20020aa7da4a000000b00558f40b4581mr4126744eds.1.1705323101613;
        Mon, 15 Jan 2024 04:51:41 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j7-20020aa7ca47000000b00556ee10cfe3sm5395358edt.92.2024.01.15.04.51.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 04:51:41 -0800 (PST)
Message-ID: <4ad9d0a8-00b6-4970-9127-ccbe1d2f26bf@grimberg.me>
Date: Mon, 15 Jan 2024 14:51:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme/auth: optimize code redundancy and provide code
 quality
Content-Language: en-US
To: mengfanhui <mengfanhui@kylinos.cn>, kbusch@kernel.org, axboe@kernel.dk
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20240115065231.12733-1-mengfanhui@kylinos.cn>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240115065231.12733-1-mengfanhui@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> Improve code quality. Reduce code redundancy.

Why does this improve code quality? Why does this
reduce code redundancy?

It's just a different style, seems like a useless change to me.

> 
> Signed-off-by: mengfanhui <mengfanhui@kylinos.cn>
> ---
>   drivers/nvme/common/auth.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
> index a23ab5c968b9..4f9d06afdc38 100644
> --- a/drivers/nvme/common/auth.c
> +++ b/drivers/nvme/common/auth.c
> @@ -250,9 +250,7 @@ struct nvme_dhchap_key *nvme_auth_transform_key(
>   	if (key->hash == 0) {
>   		key_len = nvme_auth_key_struct_size(key->len);
>   		transformed_key = kmemdup(key, key_len, GFP_KERNEL);
> -		if (!transformed_key)
> -			return ERR_PTR(-ENOMEM);
> -		return transformed_key;
> +		return transformed_key ? transformed_key : ERR_PTR(-ENOMEM);
>   	}
>   	hmac_name = nvme_auth_hmac_name(key->hash);
>   	if (!hmac_name) {
> 
> base-commit: c29901006179c4c87f9335771e50814ec5707239

