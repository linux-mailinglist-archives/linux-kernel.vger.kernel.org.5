Return-Path: <linux-kernel+bounces-13678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D814820AE8
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 10:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3F321F22289
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 09:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5413211;
	Sun, 31 Dec 2023 09:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I9D30rdu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73E623D9
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 09:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704016208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tK113Awfl6OWkpPlOKRE5e32nRk0EPC7dusyF+tpu2M=;
	b=I9D30rduLZ0UsKf0Hl63QlQ6gbYKtgKv2WHABe156GdeNEMegRCnBZpzFIR8eC+cZsm63w
	jgiIBZfRL9I2fYayuUZ3odvAtBYZifKQ4Z/8hyYeG/TTY/8QiTc2mAgq99z/SacK6gVGEU
	Tk855FbovYfsc0QqstQAdt+tz6lqwck=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-IuZ6WGJUOjWexQaUcC8wEQ-1; Sun, 31 Dec 2023 04:50:01 -0500
X-MC-Unique: IuZ6WGJUOjWexQaUcC8wEQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5555b254926so1397591a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 01:50:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704016200; x=1704621000;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tK113Awfl6OWkpPlOKRE5e32nRk0EPC7dusyF+tpu2M=;
        b=S/4rbt9D9Mippi/1Do0whetyRvDC+YaBgpbSrD3twlfkGjuxs9ws/qjsyPNScLZKDr
         Xei343ZCXL5urBrPWYAFt7eTl0uAx/QdjgCleuwe5C8gISDXa7MsBn2wGr02eYeCrt3I
         SIBHEeodO+4ltvD2oMaOS4n9JkIRT1vd/6H1iY5UQ/DbdFfhaXvEeLspQHc9Zb8ym4Pi
         7tlVWRhG+tVrw+5nB1sjAB/MzyOFR0vcjCr0lqrl5pu5Ph+hSGXFt5bbY1wW5/RvUBg8
         sWwSCfY7t7HEm5A0NKW4uUk/NyaUuCTn2vzQMM1FIMQ61PPGPxxX02PS9kG4Bt6mQdRq
         9+yQ==
X-Gm-Message-State: AOJu0YyHcLQpmrjOCTam6F6MGxxS7C2W/CW0QPw8K2gfNANYtzLoncMR
	IBngiwuJSbZi4HpcoadEg4+0uzYEEY/ri2qoGYymzC/i291Rq/KQvTYYguJlk1eKkQ6hbMW5w1q
	a0exE2CJl0ZHldpF9KemWQJmy+mwDifwx
X-Received: by 2002:aa7:dac5:0:b0:555:65c0:e72b with SMTP id x5-20020aa7dac5000000b0055565c0e72bmr3651943eds.62.1704016199978;
        Sun, 31 Dec 2023 01:49:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/Hd8+uyhttvW+IY+lq2OUulSHmV7vOvPZBgbXZNJOHhyGzh3vYz6wI+KQXJ17t0X6E4g63Q==
X-Received: by 2002:aa7:dac5:0:b0:555:65c0:e72b with SMTP id x5-20020aa7dac5000000b0055565c0e72bmr3651933eds.62.1704016199772;
        Sun, 31 Dec 2023 01:49:59 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id p12-20020a05640243cc00b0055493aa8905sm9894390edc.63.2023.12.31.01.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Dec 2023 01:49:59 -0800 (PST)
Message-ID: <8cfc7753-37f6-48be-b7ae-dc28022989ae@redhat.com>
Date: Sun, 31 Dec 2023 10:49:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: media/atomisp/pci/runtime/rmgr/src: Fix spelling
 mistakes in rmgr_vbuf.c
Content-Language: en-US, nl
To: Dipendra Khadka <kdipendra88@gmail.com>, mchehab@kernel.org,
 sakari.ailus@linux.intel.com, gregkh@linuxfoundation.org, hpa@redhat.com
Cc: linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
References: <20231223072245.81630-1-kdipendra88@gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231223072245.81630-1-kdipendra88@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 12/23/23 08:22, Dipendra Khadka wrote:
> codespell reported following spelling mistake
> in rmgr_vbuf.cas below:
> 
> '''
> ./runtime/rmgr/src/rmgr_vbuf.c:201: succes ==> success
> ./runtime/rmgr/src/rmgr_vbuf.c:211: succes ==> success
> ./runtime/rmgr/src/rmgr_vbuf.c:215: succes ==> success
> '''
> This patch fixes these spelling mistakes.
> It is good to use variable name that gives
> proper meaning and spelling error free.
> 
> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>

Thank you for your patch.

I have merged this in my media-atomisp branch:
https://git.kernel.org/pub/scm/linux/kernel/git/hansg/linux.git/log/?h=media-atomisp

And this patch will be included in my next
pull-request to Mauro (to media subsystem maintainer)

Regards,

Hans



> ---
>  .../staging/media/atomisp/pci/runtime/rmgr/src/rmgr_vbuf.c  | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/media/atomisp/pci/runtime/rmgr/src/rmgr_vbuf.c b/drivers/staging/media/atomisp/pci/runtime/rmgr/src/rmgr_vbuf.c
> index 2e07dab8bf51..1f24db77fe38 100644
> --- a/drivers/staging/media/atomisp/pci/runtime/rmgr/src/rmgr_vbuf.c
> +++ b/drivers/staging/media/atomisp/pci/runtime/rmgr/src/rmgr_vbuf.c
> @@ -198,7 +198,7 @@ void rmgr_push_handle(struct ia_css_rmgr_vbuf_pool *pool,
>  		      struct ia_css_rmgr_vbuf_handle **handle)
>  {
>  	u32 i;
> -	bool succes = false;
> +	bool success = false;
>  
>  	assert(pool);
>  	assert(pool->recycle);
> @@ -208,11 +208,11 @@ void rmgr_push_handle(struct ia_css_rmgr_vbuf_pool *pool,
>  		if (!pool->handles[i]) {
>  			ia_css_rmgr_refcount_retain_vbuf(handle);
>  			pool->handles[i] = *handle;
> -			succes = true;
> +			success = true;
>  			break;
>  		}
>  	}
> -	assert(succes);
> +	assert(success);
>  }
>  
>  /*


