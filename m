Return-Path: <linux-kernel+bounces-57235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 445E784D56E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B662CB22E0E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C5113849B;
	Wed,  7 Feb 2024 21:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjHfDvJC"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB0F137C59;
	Wed,  7 Feb 2024 21:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341582; cv=none; b=MHKeU5aOU7DTKHIHPQZLQF0kQ2bQkCqKKWivqIO6DjS/6IH8B+e8Zr92bA/4CQGAEXx1fkrYm7k517e2eS0Qa+Gu1bCi+BAU7/x7YqYDP1Oq1VyAppyNTjs5cN3W+zqqmqP1nFRCNRlx9/YBk1aVwEPB0Hj05bcIUlGJtkIHcbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341582; c=relaxed/simple;
	bh=BgJr60RLz7YbrRe/F2VbrbzqYVEwhrQILqWUNZqI7sY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PEPqoZfj6KagSS0jqcD4hPUhBVwVQfrLx+IPjUMDrYJ5rD8DgrFDQeDDTPMc3e+vm6tVs0yDvLXlKM9BzzMcqgo8capwEEayJraXwJkZEM4lmop5OOeo/b14o2jSFWmh61RuZ4QRQDGp/TGjefm8O1T3dTLCy0lcCIcUOT0K8oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjHfDvJC; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3864258438so53158266b.0;
        Wed, 07 Feb 2024 13:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707341578; x=1707946378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ypOGpo3jI1ua7j3ovv/PFLVTfWwn/rZoGHLQKXG/FiQ=;
        b=fjHfDvJC4kfQXssmpPHJmYxl0M4JHZwyec+LoWc+P+a4ZYE5tknxva7pmA2B1/9hlO
         lNrUULONVAYQjCqfLQOQm1Li1UhMCJMxR1fuo+bq0ASvB+RhCxSzdOscS7VMy/IBU8XX
         n+b3QnEGoywbPhK7BpnJPQSHmGns4ZqQ/PQ5tZcObRbMcYPVcm8lEfys+m4PyUIB95Ru
         EdPTX9yEKKjB9C+E1wl337kqXZdcP6BkEuPwDjhoA/pXi+wh59OWRPyrjNmDZODLemDg
         Kftj0Q5NmgAArQadZmsOjPy2RTHJ7yMOtQcqBKQ6QvSLnOqmt5XHPZCKqltS0f8ZIXCd
         fn7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707341578; x=1707946378;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ypOGpo3jI1ua7j3ovv/PFLVTfWwn/rZoGHLQKXG/FiQ=;
        b=YjXOHC6mVUTKSkZ8mBohmz+7S2cXlzrDFK963DRJRx7xv1BnP0fBeechyXv4yLIIlV
         2GCuqO9OdO9G5BcpYkLI5oHAshG25UmgQRv5jV9l4vx2DUsvx9LMz3UooavDzw+fXLbZ
         7w4kTrV6NSQZOp3gJpNEBXbKpZ/fdbNcIVkQdbTh4m3WMbAJ/uZB7FkSzDXfr/zyBfTl
         1CTnSNWR6DD37QIOk8sxOqGAbLYKDudtvLTQPp4o8eNf6c9jKrLfp/izFD5PI9qODr1n
         o52n656jekVGQydEvg5GZYLlbU58vs+f98DT+C0qfPc2wmakpzEpZoeZusjiZRrmP/zN
         y0wg==
X-Forwarded-Encrypted: i=1; AJvYcCUEajus7FCOkWCoppCke97y9tSRFa8UOlzgIjcTvbET00oKevjb2+UUiCG77Zjsf3Qgb6QGptiL1NrskvzxZeYE5KDI9aLWd7BpBf5QJ1BPhYLQPva4HW7Qm+BQZKzDUn0aSrB5o8jyxKtRnMM=
X-Gm-Message-State: AOJu0YzYBRFoScGl7YVKNW+k6S4YopErZ7yjpNGnPj0QLNdtocipG0CH
	t45aFDGXAciQ559yjP93TXlQs2oFyNoVbVwNv8axiOU4sWMMysu4sYOpEVA9
X-Google-Smtp-Source: AGHT+IHNxhZy/enIjBSkZKjiEn/FKmkhjb7XAYp9yO9ifX2+qkE7FarftEjuhu5UpkGn3mrznvlwtg==
X-Received: by 2002:a17:906:c103:b0:a39:8df1:6c57 with SMTP id do3-20020a170906c10300b00a398df16c57mr601623ejc.28.1707341578071;
        Wed, 07 Feb 2024 13:32:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUOZ+02x45djWY7l+Cr23m+dLvPlYxPqmy4jEoc3n6zzsGK6I/O+2Tz3J/3zc6PSAn44K7lEYIuN6CWlDqIWPku4U+Dd5FbiSjXcAA92632TWzzzNRSBmaujFiFse7JyAIketiBUgrK1SbbCHD1cf4Khod4wIybhduftxghHcs=
Received: from shift.daheim (p200300d5ff48c600aaa159fffeeb01f1.dip0.t-ipconnect.de. [2003:d5:ff48:c600:aaa1:59ff:feeb:1f1])
        by smtp.gmail.com with ESMTPSA id w8-20020a17090633c800b00a381a3a7081sm1152618eja.156.2024.02.07.13.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 13:32:57 -0800 (PST)
Received: from localhost.daheim ([127.0.0.1])
	by shift.daheim with esmtp (Exim 4.97)
	(envelope-from <chunkeey@gmail.com>)
	id 1rXpXN-00000000436-1Zsk;
	Wed, 07 Feb 2024 22:32:57 +0100
Message-ID: <41ac1eca-ff9c-4a1c-be53-f37aca8aa178@gmail.com>
Date: Wed, 7 Feb 2024 22:32:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] carl9170: Remove redundant assignment to pointer
 super
To: Colin Ian King <colin.i.king@gmail.com>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240207171524.2458418-1-colin.i.king@gmail.com>
Content-Language: de-DE
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <20240207171524.2458418-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/7/24 18:15, Colin Ian King wrote:
> The pointer super is being assigned a value that is not being read, it
> is being re-assigned later. The assignment is redundant and can be
> removed.
> 
> Cleans up clang scan warning:
> drivers/net/wireless/ath/carl9170/tx.c:192:34: warning: Value stored to
> 'super' during its initialization is never read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Acked-by: Christian Lamparter <chunkeey@gmail.com>

> ---
>   drivers/net/wireless/ath/carl9170/tx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/carl9170/tx.c b/drivers/net/wireless/ath/carl9170/tx.c
> index 6bb9aa2bfe65..e902ca80eba7 100644
> --- a/drivers/net/wireless/ath/carl9170/tx.c
> +++ b/drivers/net/wireless/ath/carl9170/tx.c
> @@ -189,7 +189,7 @@ static void carl9170_tx_accounting_free(struct ar9170 *ar, struct sk_buff *skb)
>   
>   static int carl9170_alloc_dev_space(struct ar9170 *ar, struct sk_buff *skb)
>   {
> -	struct _carl9170_tx_superframe *super = (void *) skb->data;
> +	struct _carl9170_tx_superframe *super;
>   	unsigned int chunks;
>   	int cookie = -1;
>   


