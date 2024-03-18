Return-Path: <linux-kernel+bounces-105813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 795EB87E4F3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D7891F220E0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B228F288B0;
	Mon, 18 Mar 2024 08:26:15 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C8B25761;
	Mon, 18 Mar 2024 08:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710750375; cv=none; b=KJ5/rihAIfhXwcyAjcZAcjr/KFUEsCyH5H15MMSpkiu9lLmApCW8jdliwKotzMBOLpRLVe1BbcBs4Pk3J+FwqnczIQaUbdgO5hk/P/TcGlJMTXfFxdjeL+sWOV7N4f5jtT4tKjxZkompDSeGXLMSyCcMqxw7nFiR3LeFKDNO5v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710750375; c=relaxed/simple;
	bh=n/+BUC7RfmYBK8x7pBrx9xX40ouKwNH/toP128a3gAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NmH0adGXYh9LTouv48c4VrQNITt9U8nP8kx652le3gV4pOLbxpKmgQN5K0Qzd0EHozjlvsiV3wd1dGVr4AYo+QEa9f2bLkKc+hal5ehMQS71T7nTFkotZNA+C7r9MQMC7fORyaenFQ0YlTdk6ZzoOu09UqoWVSrgl6ceHEg2uLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-34175878e3cso332100f8f.0;
        Mon, 18 Mar 2024 01:26:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710750369; x=1711355169;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a9kyHu1UWlkDyox3goz2HfEhPT5QiJkRChK6QBLxt3w=;
        b=AINyOZrWcz0UuTgZuzYZ8a1y1lEKANBQjz1QFetq7VihZHbXDDha9JJ6Wxu9NdFgbs
         TedidoqcgDB/l8x61aLLVbCXvKXjlQgYbYJLr9MTI8LZ/KJRyCwag8FdfHhzwzTr8GNN
         O+ptu0tSRsMCqNwhj1C2otjwz4lII5QTIhLgDLiREu5Drc7ZP+DDzj/H4477IqF5dvuw
         8k7ewIJ5cbrbxLu4GtYgHwcjQ5t39khEQQbl5stI4GF222GLuQd1YkN3CHfy4HNc/hVQ
         MC5fKs7BkTLdHW7/P9cUtB4ZKSL8nxQOeA/zyHB2llQpIjkAIkUWetx7Ac49a0ai2XtH
         dn+A==
X-Forwarded-Encrypted: i=1; AJvYcCVA+qOVFH+8X7yJmpqiBeBrkf5aujyhdgx7juK2Ej2eUs/Hr5oqR8+HMgqilGsUJm4JTOQt/inL6oNk/JF0O+v3VVvmQ7MAgLdjfyNvdulluJTtyXk0zDV+lVbma9nHgX9Dw4pUvf9f7a/RQK6jabePUsmYiWMN3bYuEWBD4foKhPM=
X-Gm-Message-State: AOJu0Yz/eu0EChZfI1jnIYrzwp/ILxqr3+y6T+Yzj+6o2o85ttCO9w2T
	HWPL6sMQCIdbhGqid69jmk0jsSxfThKaQfVzucqpy0Zql9IihDybeY8oTx/p
X-Google-Smtp-Source: AGHT+IHDewQohYECkFvf872qtt3onRjjtDOZf4w7eiCEgZ9ol4tMs/dOGH40E5nWYdXZI0jREKc84w==
X-Received: by 2002:a05:6000:22d:b0:33d:d4c2:8ba5 with SMTP id l13-20020a056000022d00b0033dd4c28ba5mr6717194wrz.5.1710750368888;
        Mon, 18 Mar 2024 01:26:08 -0700 (PDT)
Received: from [10.16.0.238] ([5.32.53.74])
        by smtp.gmail.com with ESMTPSA id f1-20020a5d4dc1000000b0033e99b7cfa8sm4062318wru.13.2024.03.18.01.26.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 01:26:08 -0700 (PDT)
Message-ID: <f1be501c-51fa-4a0b-a11f-893b185571c5@linux.com>
Date: Mon, 18 Mar 2024 12:26:05 +0400
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
Cc: inux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240318060453.18538-1-wangyufeng@kylinos.cn>
From: Denis Efremov <efremov@linux.com>
In-Reply-To: <20240318060453.18538-1-wangyufeng@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 3/18/24 10:04, Yufeng Wang wrote:
> Cc: stable@vger.kernel.org
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

I'll answer to the 2nd email.

Thanks,
Denis

