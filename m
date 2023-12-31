Return-Path: <linux-kernel+bounces-13668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDB0820AC9
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 10:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C17C28284D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 09:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E180211C;
	Sun, 31 Dec 2023 09:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BIfymaVE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FA633D1
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 09:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704015547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HdM5Vkomds4h/QuK6n7mA0GCkNM9rwKnYx1KoPXzk3M=;
	b=BIfymaVEjZxIS0yZktcgfzUIOJ+pshNWEE9Ig7XtJjos9IQGrCzgXEMAp7a8PMM0IfpmL/
	Jdkyqj6YRgUIBiU/0CZ8homJeVH28STPFXpe7XQ0z7+mkMFp3+tyz2U8UUZ5aHs+v17+bv
	QoHxIWxw8jOhVE+SxpmygzDRQbFHCqw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-q7izAHVmOhyGwyU6b0yoIw-1; Sun, 31 Dec 2023 04:39:05 -0500
X-MC-Unique: q7izAHVmOhyGwyU6b0yoIw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-555f630f901so518186a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 01:39:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704015544; x=1704620344;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HdM5Vkomds4h/QuK6n7mA0GCkNM9rwKnYx1KoPXzk3M=;
        b=ZNm/cdWjdCQgug25HkL6ndXeuhoUKlJCjj8I78FablAO2UfXYncpPspa+zyrpWo1My
         kzyGYPwj5a9ovo3lcT6Cl6wwftaAXt+zx5Q7G6292OzGMuV3eojRxSlj25cNdf2xtoog
         xjCJVV2FCSwCgLIXQfvms1AZP/WA710BmRb23yFE/9UkmRe4sO+tqElUbldZjX9T+5GG
         t925zGmPHMs3ARCa1mdGveX4/3Xpdtn7RtMAFqZy0AE2UuyBQbpaJa4Vzyn0aYbtJaWt
         vQD4gkBEWeR8OKHVlgyFE+vmBXkiBhTnIQU0MsDr+44shlQ8ihnmjt5059RHZD13/CM8
         H/mA==
X-Gm-Message-State: AOJu0YyF+0nsuIbIKX7Sox+BjdzxosTfsAD/PlsY3Tz2elo2F9dMWvMF
	fUi1JnNObF/8EwUWEFqdoTA3XdBcFWKaMc9xqgyjHYRl0JJyX5Hp/P87hnpNzeOGJ13+NcIEefs
	8QEjUQGI5mU/NJqezxL+/djJqIwHgfMlH
X-Received: by 2002:a50:c10a:0:b0:555:226:764d with SMTP id l10-20020a50c10a000000b005550226764dmr5011594edf.70.1704015544345;
        Sun, 31 Dec 2023 01:39:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKA4bIPmpXp944hcEIeAaNCeCPsFiUapyDLV3C65+FtIjZ6pKJ+8TZ+8J3pxtFD0ToWuT4Sw==
X-Received: by 2002:a50:c10a:0:b0:555:226:764d with SMTP id l10-20020a50c10a000000b005550226764dmr5011587edf.70.1704015544056;
        Sun, 31 Dec 2023 01:39:04 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ew10-20020a056402538a00b005546ba152f4sm10900308edb.71.2023.12.31.01.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Dec 2023 01:39:03 -0800 (PST)
Message-ID: <32c5d324-c768-40d0-9c67-5038a24a89b6@redhat.com>
Date: Sun, 31 Dec 2023 10:39:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: staging: media: atomisp: pci: Fixes spelling
 mistakes in ia_css_irq.h
Content-Language: en-US, nl
To: Dipendra Khadka <kdipendra88@gmail.com>, mchehab@kernel.org,
 sakari.ailus@linux.intel.com, gregkh@linuxfoundation.org
Cc: linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
References: <20231218151704.449883-1-kdipendra88@gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231218151704.449883-1-kdipendra88@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 12/18/23 16:17, Dipendra Khadka wrote:
> The script checkpatch.pl reported spelling errors
> in ia_css_irq.h as below:
> 
> '''
> WARNING: Possible repeated word: 'in'
>         /** the input system in in error */
> 
> WARNING: Possible repeated word: 'in'
>         /** the input formatter in in error */
> 
> WARNING: Possible repeated word: 'in'
>         /** the dma in in error */
> '''
> 
> This patch corrects spelling errors,
> changing "in" to "is" in all three comments.
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
>  drivers/staging/media/atomisp/pci/ia_css_irq.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/media/atomisp/pci/ia_css_irq.h b/drivers/staging/media/atomisp/pci/ia_css_irq.h
> index 26b1b3c8ba62..00e2fd1f9647 100644
> --- a/drivers/staging/media/atomisp/pci/ia_css_irq.h
> +++ b/drivers/staging/media/atomisp/pci/ia_css_irq.h
> @@ -84,11 +84,11 @@ enum ia_css_irq_info {
>  	IA_CSS_IRQ_INFO_ISP_BINARY_STATISTICS_READY   = BIT(17),
>  	/** ISP binary statistics are ready */
>  	IA_CSS_IRQ_INFO_INPUT_SYSTEM_ERROR            = BIT(18),
> -	/** the input system in in error */
> +	/** the input system is in error */
>  	IA_CSS_IRQ_INFO_IF_ERROR                      = BIT(19),
> -	/** the input formatter in in error */
> +	/** the input formatter is in error */
>  	IA_CSS_IRQ_INFO_DMA_ERROR                     = BIT(20),
> -	/** the dma in in error */
> +	/** the dma is in error */
>  	IA_CSS_IRQ_INFO_ISYS_EVENTS_READY             = BIT(21),
>  	/** end-of-frame events are ready in the isys_event queue */
>  };


