Return-Path: <linux-kernel+bounces-19885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A96E1827630
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 556EA2832D2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5D05466F;
	Mon,  8 Jan 2024 17:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X0lCmOCA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F8D53E36
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 17:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704734359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4n0GXMevIXNEHu349Rlctj8rXBEsAzbKnDlggCcCpro=;
	b=X0lCmOCAyKkIBsMcoq0WX+nOZ4oQiNfHdTVT7E5CGX4zcGDZGLt/TgInSwl0BZ1THjFqjU
	EJ2XojIN+70tGnyVtYvnA3Jma2muD2a27bsVSrYhmadl/TUEfs73njKImq47Jjrwb7IiVf
	EmYkqDRq+kzq7nCpIxUcg401xzPfpdc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-AJTNVU1ZPCGdhfJ5mEoK2g-1; Mon, 08 Jan 2024 12:19:17 -0500
X-MC-Unique: AJTNVU1ZPCGdhfJ5mEoK2g-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7816e45f957so360529185a.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 09:19:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704734337; x=1705339137;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4n0GXMevIXNEHu349Rlctj8rXBEsAzbKnDlggCcCpro=;
        b=EhvOImunjRJlD4m0jXxsSwHOg2+OoVeoK3COGtttzLT1A58HWOgEnhPwWhuSnieXF0
         fXmrNMiYMn6tOI02ejz5945Pxujk27MGGp7toKpWgXsjpf3Df0X0703e8TNMuQz0C05C
         Yulogs3A61rapT90LQkGWSsaXHwULp1MWZY6J49wpmC6tBVp561Y3fS7HjN+XM5o6sRM
         mRLKbTxTcAse2l6FLS9/dRZyeq3FcOlAQS8wa+xHi5sgduQgNEc8QIx4k4BgXZJ7a+jp
         yLgdVawh6PJNnfXXh29wKXfI2uYv6gyGOy7s5954pI5Q++151In3TVcMrzzO/lTwVlFy
         J+Qw==
X-Gm-Message-State: AOJu0YzgBei2DkUJ979I/7HrnNrkqvOl+yF311/nPKovgav8RAVXcMLn
	vNi2+6vf9Ds9KaealmnXsR4nOzkdg7zOXpv76cA5mdO1av5vG0T2wo/hC2WJnj6py1ZpmEL6sSC
	YDFzrY6mnr24J6QMGBYSLh5nLfu7f10ad
X-Received: by 2002:a05:620a:470a:b0:783:2607:13f5 with SMTP id bs10-20020a05620a470a00b00783260713f5mr1285289qkb.20.1704734337497;
        Mon, 08 Jan 2024 09:18:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbsXsbxoXlECp8+ORoJitLSD8fGeGAumNZ2yTKrmI2VxodrvKisab55OD1FQr1IN7iJllKVQ==
X-Received: by 2002:a05:620a:470a:b0:783:2607:13f5 with SMTP id bs10-20020a05620a470a00b00783260713f5mr1285278qkb.20.1704734337276;
        Mon, 08 Jan 2024 09:18:57 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:ee94:abf:b8ff:feee:998b? ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id y11-20020a05620a25cb00b007830ce180basm43109qko.120.2024.01.08.09.18.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 09:18:56 -0800 (PST)
Message-ID: <9413ee17-70d6-4c27-ad8c-2cd4e0f7bb0b@redhat.com>
Date: Mon, 8 Jan 2024 18:18:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next] drm/nouveau/disp: switch to use kmemdup()
 helper
Content-Language: en-US
To: yang.guang5@zte.com.cn
Cc: jiang.xuexin@zte.com.cn, chen.haonan2@zte.com.cn, cgel.zte@gmail.com,
 lyude@redhat.com, airlied@gmail.com, daniel@ffwll.ch, bskeggs@redhat.com,
 keescook@chromium.org, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kherbst@redhat.com
References: <202312142003220684160@zte.com.cn>
From: Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <202312142003220684160@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Yang,

On 12/14/23 13:03, yang.guang5@zte.com.cn wrote:
> From: Yang Guang <yang.guang5@zte.com.cn>
> 
> Use kmemdup() helper instead of open-coding to
> simplify the code.
> 
> Signed-off-by: Chen Haonan <chen.haonan2@zte.com.cn>

Please add your "Signed-off-by" tag to this patch. If the above is intended to indicate
that Chan was involved in creating this patch (e.g. as co-author, reporter, etc.) please
use the corresponding tag instead. See also [1].

Once this is fixed, I'll apply the patch.

- Danilo

[1] https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

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


