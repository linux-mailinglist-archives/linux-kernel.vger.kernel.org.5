Return-Path: <linux-kernel+bounces-13666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7C9820AC4
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 10:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E6AA1F21551
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 09:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D9720F0;
	Sun, 31 Dec 2023 09:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AAIm335N"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5302186C
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 09:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704015499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6GH49fe9P1LFfC/zNntRaTyPi/DVVoaN4qHiWXM/OtM=;
	b=AAIm335NguKHy+dgaMyyv+clmi/kknrpO4zMxcv2uUi9jwKMbHaFhpee4E8sqkI8Fx+NNF
	+MqGZuwzDeWv3E1YzW4U+nMskci/GhGp5g8HkhzYIRH7nDGegHOngKr8mLnRKZET/Yaj95
	y1RqbgyYmjVNvs9RnGA/BIyz9TQYxtI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-hjPEpgKaMDe0DofdINKG2w-1; Sun, 31 Dec 2023 04:38:16 -0500
X-MC-Unique: hjPEpgKaMDe0DofdINKG2w-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-553a628773bso4097935a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 01:38:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704015495; x=1704620295;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6GH49fe9P1LFfC/zNntRaTyPi/DVVoaN4qHiWXM/OtM=;
        b=BCv3HAoN94BXNXEToVwnYlk1BybNng0wHl0OVX62zZ5Fyg/4QJypxU7MSFj+RZsWXm
         KG/fnYjeDKia3T86VR+KWZ0ddVq+xJ9tZ+pT0JQKHTBe+syx5iKzKqKTvLAGGRi/ggQw
         3XRbxRCJWIA/JKmDSSZR4io75QCtb831A/nfY5ekeUEgyAUh3YillitfoFncQKSIZonI
         2CFnT6f9FK3D1x/2VwVWNdaslLL3wzXMLAtGhncb/CIckK2C/6JsGKZflH++MeSpxXhG
         LYgTSDGHqKNdlKXEDF0kixnnF0jp3Mw0gwTLQJ4Z8wfS5+iH4cdmsBIqgzEB+Eb2yQWz
         4Wlw==
X-Gm-Message-State: AOJu0YxszdwDh+6gnxcl0gHY10q+6pFTcuM8Pv1u98FdHIterEIDHCWk
	1jko4VuPQtMShsvbcEs4FRgnJpFn3AUmyc403uKUx09azX3e33ni25r8gdpjNGShfqwOKPn5HEg
	AnzkaBTok5iz+H/Qp0+xecgZM9b5p+1gT
X-Received: by 2002:a50:d659:0:b0:554:4dde:6646 with SMTP id c25-20020a50d659000000b005544dde6646mr9319617edj.9.1704015495640;
        Sun, 31 Dec 2023 01:38:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsdLgr/QXBiJ4I44Y8+TgG/zaD+DgQPBwKYBPXU1QroyHu/Mjj3koypyIhrQjThHzW7bCHEg==
X-Received: by 2002:a50:d659:0:b0:554:4dde:6646 with SMTP id c25-20020a50d659000000b005544dde6646mr9319610edj.9.1704015495186;
        Sun, 31 Dec 2023 01:38:15 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ew10-20020a056402538a00b005546ba152f4sm10900308edb.71.2023.12.31.01.38.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Dec 2023 01:38:14 -0800 (PST)
Message-ID: <e48ff1b3-73fc-4668-840e-129417ce2c08@redhat.com>
Date: Sun, 31 Dec 2023 10:38:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: media: atomisp: Removed duplicate comment and
 fixed comment format
Content-Language: en-US, nl
To: Jonathan Bergh <bergh.jonathan@gmail.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231014083545.173238-1-bergh.jonathan@gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231014083545.173238-1-bergh.jonathan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 10/14/23 10:35, Jonathan Bergh wrote:
> Fixed the following issues:
>  * Removed a duplicate comment
>  * Fixed up minor comment format issue
> 
> Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>

Thank you for your patch.

I have merged this in my media-atomisp branch:
https://git.kernel.org/pub/scm/linux/kernel/git/hansg/linux.git/log/?h=media-atomisp

And this patch will be included in my next
pull-request to Mauro (to media subsystem maintainer)

Regards,

Hans



> ---
>  drivers/staging/media/atomisp/i2c/gc2235.h | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/media/atomisp/i2c/gc2235.h b/drivers/staging/media/atomisp/i2c/gc2235.h
> index 55ea422291ba..ade28950db73 100644
> --- a/drivers/staging/media/atomisp/i2c/gc2235.h
> +++ b/drivers/staging/media/atomisp/i2c/gc2235.h
> @@ -74,9 +74,6 @@
>  #define GC2235_COARSE_INTG_TIME_MIN 1
>  #define GC2235_COARSE_INTG_TIME_MAX_MARGIN 6
>  
> -/*
> - * GC2235 System control registers
> - */
>  /*
>   * GC2235 System control registers
>   */
> @@ -167,7 +164,7 @@ enum gc2235_tok_type {
>  	GC2235_TOK_MASK = 0xfff0
>  };
>  
> -/**
> +/*
>   * struct gc2235_reg - MI sensor  register format
>   * @type: type of the register
>   * @reg: 8-bit offset to register


