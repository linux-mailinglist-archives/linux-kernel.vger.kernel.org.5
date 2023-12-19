Return-Path: <linux-kernel+bounces-4976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2348184A9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2697B2434A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71A914002;
	Tue, 19 Dec 2023 09:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KuR2rHsp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE411426D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 09:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702978765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gcH9WS2tVG3ovLiBypnFZ2jVXWEukuXIC7hmC0v5Ihs=;
	b=KuR2rHspOaclWiHN7L4nqOfEWffJ/993sXGDOCBw8OsF9QFtfFGJPWKsKQpSkt2kQeygzC
	FuS5m3TDaWlpAQJZZoA2cU6325tTBQrWFCDFULnvef+QD2ByQb7Tjb6DWvlPPmWcK4Ldy9
	aToJT87g1wt5ypOKYIJg4P/QzXu4MuQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450--b7QjJjxMVO4mACzibjo1g-1; Tue, 19 Dec 2023 04:39:23 -0500
X-MC-Unique: -b7QjJjxMVO4mACzibjo1g-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a1f99db3dd0so222265566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 01:39:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702978762; x=1703583562;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gcH9WS2tVG3ovLiBypnFZ2jVXWEukuXIC7hmC0v5Ihs=;
        b=TP8Y1EdCXAYDEzSYgsLWk+jYXZqQz5c4OLwq8RR3KwAtrAwl0UrfNTi13esOu4gzjn
         d4210uOr/vwWiOmsRDsElvGJmCP8n49Fdvg2vC5zzKTRfyjgQpenGu0HZt72Lsk5s6FF
         +O3H9wepIe/1SxBpYTwP9GmbIzJlDldNuA8gTTO/JYStT7aWyewllmEIEIOxbvc7QV+1
         FkFzzcZSTI0KgpL0UC+6yh3c2sbWpY5bWIHnB/VfWVxSPn0I/FWptfc3wVrt0+eBJphZ
         zSIuIrEwn0p/hLUZbBS53vlXY/Yf/T6kCxeTFdWauwkubjz4WsqAU3z0cBwoYxa7XMOe
         8buQ==
X-Gm-Message-State: AOJu0Ywjmz1Kfnp6b7rB0yAulN8+OmObFH0SyoOhTrBtP7+gZ91TZu9p
	cNSw84gwBL3rRv6R8VVngt4lAmbgUwitc0B3PuRCTgS6FK/c7IO7W4z09nyPCJNJeq0J0G0nU0S
	uJSjpMsDqqwOyBXeZQXDE7h/f
X-Received: by 2002:a50:85cc:0:b0:551:9675:53c2 with SMTP id q12-20020a5085cc000000b00551967553c2mr5808130edh.49.1702978762222;
        Tue, 19 Dec 2023 01:39:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKfnNFd7LXTG5/FqkrDtnXygjq8cbwnZ4/FHh5lYrk4L380+jZTKSy80sPESk36D0Ocow0sg==
X-Received: by 2002:a50:85cc:0:b0:551:9675:53c2 with SMTP id q12-20020a5085cc000000b00551967553c2mr5808125edh.49.1702978761947;
        Tue, 19 Dec 2023 01:39:21 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id d32-20020a056402402000b0055380bc3b4bsm847680eda.90.2023.12.19.01.39.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 01:39:20 -0800 (PST)
Message-ID: <b4c96284-1ae8-498b-84ae-34a9f65e9da8@redhat.com>
Date: Tue, 19 Dec 2023 10:39:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vboxsf: Remove usage of the deprecated ida_simple_xx()
 API
Content-Language: en-US, nl
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <2752888783edaed8576777e1763dc0489fd07000.1702963000.git.christophe.jaillet@wanadoo.fr>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <2752888783edaed8576777e1763dc0489fd07000.1702963000.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 12/19/23 06:17, Christophe JAILLET wrote:
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> This is less verbose.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

vboxsf is not really undergoing any active development,
if there is a tree which is collecting other ida related
patches feel free to route this through that tree.

Regards,

Hans







> ---
>  fs/vboxsf/super.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
> index 1fb8f4df60cb..cd8486bc91bd 100644
> --- a/fs/vboxsf/super.c
> +++ b/fs/vboxsf/super.c
> @@ -155,7 +155,7 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
>  		}
>  	}
>  
> -	sbi->bdi_id = ida_simple_get(&vboxsf_bdi_ida, 0, 0, GFP_KERNEL);
> +	sbi->bdi_id = ida_alloc(&vboxsf_bdi_ida, GFP_KERNEL);
>  	if (sbi->bdi_id < 0) {
>  		err = sbi->bdi_id;
>  		goto fail_free;
> @@ -221,7 +221,7 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
>  	vboxsf_unmap_folder(sbi->root);
>  fail_free:
>  	if (sbi->bdi_id >= 0)
> -		ida_simple_remove(&vboxsf_bdi_ida, sbi->bdi_id);
> +		ida_free(&vboxsf_bdi_ida, sbi->bdi_id);
>  	if (sbi->nls)
>  		unload_nls(sbi->nls);
>  	idr_destroy(&sbi->ino_idr);
> @@ -268,7 +268,7 @@ static void vboxsf_put_super(struct super_block *sb)
>  
>  	vboxsf_unmap_folder(sbi->root);
>  	if (sbi->bdi_id >= 0)
> -		ida_simple_remove(&vboxsf_bdi_ida, sbi->bdi_id);
> +		ida_free(&vboxsf_bdi_ida, sbi->bdi_id);
>  	if (sbi->nls)
>  		unload_nls(sbi->nls);
>  


