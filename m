Return-Path: <linux-kernel+bounces-14348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 305E3821BB4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D71FC1F21DF3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB1DF4FC;
	Tue,  2 Jan 2024 12:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XH70b9PU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A374EED7
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 12:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704199061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eTOeUCtDb5GVXFc7f9ZKRWPTysZoCC8la1hp9HQwt0I=;
	b=XH70b9PUayDDvqpr1UiCAJb6CoVqc5nesDNuIoVSRwkalYWBz5h976JygX7BzfAMIoMtFt
	DpBv4qMTsFFO+sPYjansY/bMLy/25PYqwX9kD6H3gkmR7PGddfx8hVdX5lsN36ducxB1ly
	9N63tHvW9lYf5J9wYCSmA6X0E6h/g6w=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-OGoJU-gANHKJOJ5vxCRBSg-1; Tue, 02 Jan 2024 07:37:40 -0500
X-MC-Unique: OGoJU-gANHKJOJ5vxCRBSg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-50e7ddf4dacso4465105e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 04:37:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704199058; x=1704803858;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eTOeUCtDb5GVXFc7f9ZKRWPTysZoCC8la1hp9HQwt0I=;
        b=ETe/D/cXYNDnalqmRiKwYMlXhiduybH6CI4BHn/jLAIVtLPBPDbKIPyuzdq6ld5Fwb
         l8HlsnIO4Q1iPtru1RyvyCYmjkTNdwnjigvKVGg2yh3aj5nl5mYPQbEDR3Ms5uEjEr4U
         D7iQIN+Bg36S29dinO/mzhVHxBJEJWO2D/ibG3kbSuZ24UY8s844apY+uaIun+gW6IXX
         HTg3RwwUw8ietJcAVMImDMkYiUrYI/5DZ+cZHLDnSJbyw4bWQG3FHStOeRJe4wKtWVeC
         XuM/z0w+j2L8rsYvTmkN+lSVkYTLF3C/EE+uEiBFL78pw3oZRsR+Ir2nS7o0c/FLuRHS
         b1+A==
X-Gm-Message-State: AOJu0YyIoGxhMRai9Eg6Vamuz/6roCVxy06nU3tSH0CUYo4Q96rQSSaT
	Wkqg9GKQb+brp/XtdU2OyVxtp41CxnDtEQQeRKOOBI0VpJ0mjp11GMLLtkAi8jUKa+ESjVjO1wT
	xf5VKUwnVks9hJW6xm2/v+VwVyJpIV6Qa
X-Received: by 2002:a05:6512:158d:b0:50e:6b4f:9809 with SMTP id bp13-20020a056512158d00b0050e6b4f9809mr7894830lfb.20.1704199058783;
        Tue, 02 Jan 2024 04:37:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEaOrzDnMM39k8oG/LEnKD1O5kbB1x6EzMJtPdL+gUeRD4kNmp1BOet/oWi4/JjhhlRJRftzg==
X-Received: by 2002:a05:6512:158d:b0:50e:6b4f:9809 with SMTP id bp13-20020a056512158d00b0050e6b4f9809mr7894823lfb.20.1704199058489;
        Tue, 02 Jan 2024 04:37:38 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id fd23-20020a056402389700b00553a86b7821sm15857865edb.74.2024.01.02.04.37.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 04:37:38 -0800 (PST)
Message-ID: <14940411-0da9-45bf-ba88-d3bd3b3c643f@redhat.com>
Date: Tue, 2 Jan 2024 13:37:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] platform/x86: wmi: linux/wmi.h: fix Excess kernel-doc
 description warning
Content-Language: en-US, nl
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, platform-driver-x86@vger.kernel.org
References: <20231223194321.23084-1-rdunlap@infradead.org>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231223194321.23084-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 12/23/23 20:43, Randy Dunlap wrote:
> Remove the "private:" comment to prevent the kernel-doc warning:
> 
> include/linux/wmi.h:27: warning: Excess struct member 'setable' description in 'wmi_device'
> 
> Either a struct member is documented (via kernel-doc) or it's private,
> but not both.
> 
> Fixes: b4cc979588ee ("platform/x86: wmi: Add kernel doc comments")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Armin Wolf <W_Armin@gmx.de>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Cc: platform-driver-x86@vger.kernel.org
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> ---
> v2: add Fixes: tag and Rev-by: Armin


Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> 
>  include/linux/wmi.h |    2 --
>  1 file changed, 2 deletions(-)
> 
> diff -- a/include/linux/wmi.h b/include/linux/wmi.h
> --- a/include/linux/wmi.h
> +++ b/include/linux/wmi.h
> @@ -21,8 +21,6 @@
>   */
>  struct wmi_device {
>  	struct device dev;
> -
> -	/* private: used by the WMI driver core */
>  	bool setable;
>  };
>  
> 


