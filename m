Return-Path: <linux-kernel+bounces-107359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A39487FB6A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD26A1F21D3C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E5E7D3FB;
	Tue, 19 Mar 2024 10:04:09 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054CF53379;
	Tue, 19 Mar 2024 10:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710842649; cv=none; b=LDc+nMda18L38MeEe/hzENLgLF7FxBGtD5gzXq2R/qpdlESKD2lkvmrHyoYVnOUJuf+9mvLgHQxkPeldqb5VhSBHhyRHTX/KGX48k552COji43hRqPIxcBgQaKOZaxFbxYBR+1JyCJylCztZ0NeBNCP/GTKuM+smSYsKKCq5FhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710842649; c=relaxed/simple;
	bh=2VvVMjvfambqjXZ1T8nnoCYzbaI/w+R+rm24F/1bDZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jRXr786sW6gl8yuxkNRyz6J+/wAzrDvZ/1rHkg1poarVZF2UPmiFNd7Snx42VOJAXoJvANdVtmxat7y3hnI+HzJ0iMvJWRq0lE6yUxWaQokB+RD8v2fLZ2afNDQPkIIY0dEK6zTM9GrqG4tKJhziolgDyqWp8ZzEN6L2IMlI4wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a466e53f8c0so691944166b.1;
        Tue, 19 Mar 2024 03:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710842645; x=1711447445;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5r8iCGbK/JuO1K6UtgurAqx6hodLR82qMZT3AOXNhM=;
        b=aaPLncloJjkAxiyRStdscFQU2nvERYTp66bN2Ur9b2WODkUyoG6gR77KghuNauIZKZ
         CSRe7iiuzCxI96aZXDf52tchpeC/PwT0YfND0FX2FJj//0zfj1KMv2DzmzHtng+3f4xl
         s5heJlzk4GuGMBrEM6rhqHfflwvkzqz+uHAlan8kfrpOA1S3jd/iLBaf6Ls1zwJW+tU8
         V/gpqYjbRH3CKBQ42uK91fJIx0mJ9/GvWADBLuvIBkoR0QbfL/L/gpIOql5NlY4EbLil
         Hzp8Jk/b+CjYv9A/K3p4vHVlqbwHK14LfSf/VyZLZmslUeRqM18Y89xEsiUe04LvHZPi
         9t3Q==
X-Gm-Message-State: AOJu0YzY9+gCX7U/uVndAJZIrsQNAkbHOC4kvaT00vLjIAjpBrlEa10D
	zndVFht24iIMeXumTxERyslcCyKe95E+9gQTfyhySk4MUm7ZyH/ONa24y+3c
X-Google-Smtp-Source: AGHT+IES/OzzJJSTzTSR5COWQmiOcMe/GuVCEnt8ohnvGeTXQxQdgYqbP/YA8/NLWNxgyZfLntdToA==
X-Received: by 2002:a17:906:19c6:b0:a46:8c9f:f783 with SMTP id h6-20020a17090619c600b00a468c9ff783mr1450343ejd.67.1710842644571;
        Tue, 19 Mar 2024 03:04:04 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id ww2-20020a170907084200b00a46cc48ab07sm1613836ejb.221.2024.03.19.03.04.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 03:04:03 -0700 (PDT)
Message-ID: <fdadff27-9d3f-4bd6-8934-41c1db00904a@kernel.org>
Date: Tue, 19 Mar 2024 11:04:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] kfifo: fix typos in kernel-doc
Content-Language: en-US
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Stefani Seibold <stefani@seibold.net>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20240319095315.27624-1-jirislaby@kernel.org>
 <20240319095315.27624-5-jirislaby@kernel.org>
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240319095315.27624-5-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Ignore this one, this is some old patch present in the output directory.

On 19. 03. 24, 10:53, Jiri Slaby (SUSE) wrote:
> Obviously:
> "This macro finish" -> "This macro finishes"
> and similar.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Stefani Seibold <stefani@seibold.net>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>   include/linux/kfifo.h | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/kfifo.h b/include/linux/kfifo.h
> index 0491bc526240..d8533e700bed 100644
> --- a/include/linux/kfifo.h
> +++ b/include/linux/kfifo.h
> @@ -584,7 +584,7 @@ __kfifo_uint_must_check_helper( \
>    * @buf: pointer to the storage buffer
>    * @n: max. number of elements to get
>    *
> - * This macro get some data from the fifo and return the numbers of elements
> + * This macro gets some data from the fifo and returns the numbers of elements
>    * copied.
>    *
>    * Note that with only one concurrent reader and one concurrent
> @@ -611,7 +611,7 @@ __kfifo_uint_must_check_helper( \
>    * @n: max. number of elements to get
>    * @lock: pointer to the spinlock to use for locking
>    *
> - * This macro get the data from the fifo and return the numbers of elements
> + * This macro gets the data from the fifo and returns the numbers of elements
>    * copied.
>    */
>   #define	kfifo_out_spinlocked(fifo, buf, n, lock) \
> @@ -739,7 +739,7 @@ __kfifo_int_must_check_helper( \
>    * @fifo: address of the fifo to be used
>    * @len: number of bytes to received
>    *
> - * This macro finish a DMA IN operation. The in counter will be updated by
> + * This macro finishes a DMA IN operation. The in counter will be updated by
>    * the len parameter. No error checking will be done.
>    *
>    * Note that with only one concurrent reader and one concurrent
> @@ -790,7 +790,7 @@ __kfifo_int_must_check_helper( \
>    * @fifo: address of the fifo to be used
>    * @len: number of bytes transferred
>    *
> - * This macro finish a DMA OUT operation. The out counter will be updated by
> + * This macro finishes a DMA OUT operation. The out counter will be updated by
>    * the len parameter. No error checking will be done.
>    *
>    * Note that with only one concurrent reader and one concurrent
> @@ -807,7 +807,7 @@ __kfifo_int_must_check_helper( \
>    * @buf: pointer to the storage buffer
>    * @n: max. number of elements to get
>    *
> - * This macro get the data from the fifo and return the numbers of elements
> + * This macro gets the data from the fifo and returns the numbers of elements
>    * copied. The data is not removed from the fifo.
>    *
>    * Note that with only one concurrent reader and one concurrent

-- 
js
suse labs


