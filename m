Return-Path: <linux-kernel+bounces-22410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 185F3829D51
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23E151C22445
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133214C3C0;
	Wed, 10 Jan 2024 15:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JxnLaiNS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F134C3B0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 15:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704899742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5JGJI1VcJxIq9FSZAk+YXHh5hWwjkFg4rzjnZUUwDRs=;
	b=JxnLaiNSs1ru3MaFGv6+x1S83hQd6iHze6uRayksUtmd2K6nG50Shp95nrZUOV+vBqJMax
	lfWADB+Jr+yUNiABwb5VX8bXiWjaCtCZZ5G47q4/zCVDWAImed8LTUgvgr0UV/Il7Lkgy/
	NgoRUsmVwDlQ8N0v9sW5kzySUU1TFcU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-Zf-EAqpdO9Ojoeu9hC2-tA-1; Wed, 10 Jan 2024 10:15:41 -0500
X-MC-Unique: Zf-EAqpdO9Ojoeu9hC2-tA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40e49906305so21282155e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 07:15:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704899740; x=1705504540;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5JGJI1VcJxIq9FSZAk+YXHh5hWwjkFg4rzjnZUUwDRs=;
        b=IXzG8PmezIAnsQkmYJbY1Ma2QlUK46Ix6BHbp+8MR6Q4E94mHLsw/rC0jyuORjKB6c
         gmooLvJCC23wdUTBJ437+jSkHIZAox/P5s+nKNhaTNJTDkzmaR4ybf4pKwuiwZLAoep2
         O2x2dsD7mqMgPEvcdEEOYP2pZaTmf8p7BAWlx9AZ74aRbjOnNfLgERQKZPyyGtohRcvV
         4yLzX2gPl9VxiX155GrIviqwVo5huIqslhLL52CKRYRZWZXg2qp8kBWIJb/C/l6XdI8x
         FbLNRoOk/dGrAlTvAd5wpiw9XxasO/iErpFZjwQ/zPfIMaKmP0AgEu/xiBjM0LqX4jNy
         kkQw==
X-Gm-Message-State: AOJu0YyJLAfxoOZIbrB+bDisUp24n2Ky7dpn3HI3u4gMfsJrTeD2jVko
	CRo16B84emhlNaJ2xqDIC4djE9GIQG8/pO1FpRGb8g9DV9nOawkptNfzPCOGUfmarG+cuibb6E7
	1Fe6THhFL/utEQt0iXYKq8sY0PUkn4V2MC9coUUVN
X-Received: by 2002:a05:600c:1f83:b0:40e:370b:4298 with SMTP id je3-20020a05600c1f8300b0040e370b4298mr604832wmb.121.1704899740225;
        Wed, 10 Jan 2024 07:15:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHV1mAnohcPqa6WbaN10hLF2MjTnkWjenEX7L+NbOpBinPvlTLE2blAeeYMSnT60VguWzpeOQ==
X-Received: by 2002:a05:600c:1f83:b0:40e:370b:4298 with SMTP id je3-20020a05600c1f8300b0040e370b4298mr604816wmb.121.1704899739941;
        Wed, 10 Jan 2024 07:15:39 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:ee94:abf:b8ff:feee:998b? ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id fa24-20020a05600c519800b0040e490cb666sm2441340wmb.12.2024.01.10.07.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 07:15:39 -0800 (PST)
Message-ID: <c8bbb32d-5fc5-4682-a92c-e5e102fa0866@redhat.com>
Date: Wed, 10 Jan 2024 16:15:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next v2] drm/nouveau/disp: switch to use kmemdup()
 helper
Content-Language: en-US
To: yang.guang5@zte.com.cn
Cc: cgel.zte@gmail.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, chen.haonan2@zte.com.cn,
 bskeggs@redhat.com, jiang.xuexin@zte.com.cn, nouveau@lists.freedesktop.org,
 keescook@chromium.org, kherbst@redhat.com
References: <202401091424115185126@zte.com.cn>
From: Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <202401091424115185126@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/9/24 07:24, yang.guang5@zte.com.cn wrote:
> From: Chen Haonan <chen.haonan2@zte.com.cn>
> 
> Use kmemdup() helper instead of open-coding to
> simplify the code.
> 
> Signed-off-by: Chen Haonan <chen.haonan2@zte.com.cn>
> Reviewed-by: Yang Guang <yang.guang5@zte.com.cn>

Applied to drm-misc-next, thanks!

> ---
>   drivers/gpu/drm/nouveau/nvif/outp.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvif/outp.c b/drivers/gpu/drm/nouveau/nvif/outp.c
> index 5d3190c05250..6daeb7f0b09b 100644
> --- a/drivers/gpu/drm/nouveau/nvif/outp.c
> +++ b/drivers/gpu/drm/nouveau/nvif/outp.c
> @@ -452,13 +452,12 @@ nvif_outp_edid_get(struct nvif_outp *outp, u8 **pedid)
>   	if (ret)
>   		goto done;
> 
> -	*pedid = kmalloc(args->size, GFP_KERNEL);
> +	*pedid = kmemdup(args->data, args->size, GFP_KERNEL);
>   	if (!*pedid) {
>   		ret = -ENOMEM;
>   		goto done;
>   	}
> 
> -	memcpy(*pedid, args->data, args->size);
>   	ret = args->size;
>   done:
>   	kfree(args);


