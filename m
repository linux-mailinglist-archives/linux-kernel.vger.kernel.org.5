Return-Path: <linux-kernel+bounces-105819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE4287E504
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4B57B21440
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3399B286BF;
	Mon, 18 Mar 2024 08:34:36 +0000 (UTC)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3760E28DA5;
	Mon, 18 Mar 2024 08:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710750875; cv=none; b=ocoZ7OTOv9p3sBI1jLf2K2FA2g8JydPsw9n3iYK7dPvD9lO+tMl7yEX6yAthlqpol5usQgTvydZ+zbu4WABPQ1kTfB0dQOhQE6lT4vnMO2gxGjQYpbHPf7eYGdygEVKVMY3Vf+nihGM7Eulm3n5rH7I/K7g3uJZtkM7cGH8ifBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710750875; c=relaxed/simple;
	bh=GsSIX3/CTa3M1g8uCjDs57wTL5NgRRrzEvE8JpLC1fo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o/B4OuhmY99QKRUb9No/k89+hTGBKMn/Ro+K2OmEaxFNDkoDitg+YJMcqO8JK10pDvAjOAoyYckVZ7gItjWEXoYbIBtUIzPyndKe39EhLBzthRc1G8H3r+9QujMfrq6GwNePhro4fKNfQCA9kDTW1Uy1Pl9OurvCmcD8WjwkP0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c213690558so2066500b6e.0;
        Mon, 18 Mar 2024 01:34:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710750873; x=1711355673;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CvZQxWeSLOGmfnR+hu9jNLf/b2B+AxMGzTGTFwxzF5I=;
        b=r9JOi+YXdcP+O4/DEU3jCw3elX3i1qg5WGBVAyzRB3A1jMgGjWQLanWF6XXExWmGPy
         UuSQVo1QCalrRryabrBscjq328twg4rKSBbuof6tLdrfmvrF2c1GHC6rZryawQMffBrB
         wZl5UFb5w7ttgQeoaqw7o8MutRk+T/b9oYIms0nkIY5faQQ89pvQXB6ZYVirDDrftvKK
         MfoOUUhYI5Ry0Y/3KLTFuRard96R5h12pPj64S+UUl+iISipsb1+aEgIY2Zo8NEUrX9a
         P00pPdnxQetdP/zmNXuVwTLnKy9CA3kn8u1kOsCCcuE0G+Giahf6vfI/YqRaJ54DJror
         kTDw==
X-Forwarded-Encrypted: i=1; AJvYcCUGB0KDrzSZ/yfzm3U0VytxH+Wekg5QRpqOni8Zbb7JoJIQUUiZBepP/a2VEtMF+meLKA0rbgRyjfBRxbSxHI47tWuwknRwM/1Stq0kuvD0jNQyplHcBfWcRVdNoChRU94wGDtnn/uAvgM=
X-Gm-Message-State: AOJu0Yz2Y3QuIMPwiOOGQyHshTXGB/c1zWPbDqtOV0tYOKc6qI5Oztx8
	QqOYMYpuySf1ywZYjOmy4wYgtJtMol9sNE0jEAUvgztPkfW9BEr2cXY2ej45
X-Google-Smtp-Source: AGHT+IGCTIYygH5ykNVKGapiN9rp8xjMRzpLhbU6cnFH/ODSTdenylh9aj9/DXgQizVHZfFwtpUnFQ==
X-Received: by 2002:a05:6808:20a9:b0:3c3:7434:78be with SMTP id s41-20020a05680820a900b003c3743478bemr11360013oiw.27.1710750873353;
        Mon, 18 Mar 2024 01:34:33 -0700 (PDT)
Received: from [10.16.0.238] ([5.32.53.86])
        by smtp.gmail.com with ESMTPSA id v2-20020aa78082000000b006e6b39e040esm7385003pff.165.2024.03.18.01.34.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 01:34:32 -0700 (PDT)
Message-ID: <7ce0d4b7-2e4d-44a7-b268-3e2505e01abe@linux.com>
Date: Mon, 18 Mar 2024 12:34:24 +0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] floppy: remove duplicated code, unlock_fdc() function has
 the same code "do_floppy = NULL" inside.
Content-Language: en-US
To: Yufeng Wang <wangyufeng@kylinos.cn>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20240318060756.18649-1-wangyufeng@kylinos.cn>
From: Denis Efremov <efremov@linux.com>
In-Reply-To: <20240318060756.18649-1-wangyufeng@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

Please, add a small commit message to the patch. The commit title
is too long and can be reduced to something like "floppy: remove duplicated
code in redo_fd_request()". Rest can be added to the commit message.

On 3/18/24 10:07, Yufeng Wang wrote:
> Cc: stable@vger.kernel.org

We don't need to send this patch to stable. It's not a bugfix.

Please, send v2 with commit message and new title.
The change looks good to me.

> Signed-off-by: Yufeng Wang <wangyufeng@kylinos.cn>
> ---
>  drivers/block/floppy.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index 1b399ec8c07d..25c9d85667f1 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -2787,7 +2787,6 @@ static void redo_fd_request(void)
>  		pending = set_next_request();
>  		spin_unlock_irq(&floppy_lock);
>  		if (!pending) {
> -			do_floppy = NULL;
>  			unlock_fdc();
>  			return;
>  		}

Thanks,
Denis

