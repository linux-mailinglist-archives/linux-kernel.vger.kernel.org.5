Return-Path: <linux-kernel+bounces-103200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DEE87BC42
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 457BE1C2172C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C384D6F06F;
	Thu, 14 Mar 2024 11:54:10 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A13960ED0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 11:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710417250; cv=none; b=KqOnLv0gEtaRx+75THjtcNiP/nCW0snnPqj5oZ5XFcrGGBtQ1DWkVmwRdjUAiDcTUu7U4LfM2m1nOfxzaNWUYWyzF2rGO0q8XoCEJKZuYGnk6eyPzFjTvRGYD8+YdhXYxF13R4SuWJHUr0znvIjNxp1z6URbSUzLvJXXk48+cQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710417250; c=relaxed/simple;
	bh=mezzzORJG8MInwmquEBVYXZEJoV8f0g/Bv7pZi+KWb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AowjytsEQMGITc0lChhXtveTqwnXxIsGYDTDOKbkYjSwYgNKewgDg3QGAbJiH6EeBVF28/NsmNEtqi4bQ971jYlgWP1SOjQW41xeGSoWD3bfvEs3CtvKR6U8/arxMjRlmrbZcSNM/Kz3nGS+E9p8Hnh+Epsia2Xn6SZso0sPLUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5684c3313cdso1054463a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 04:54:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710417247; x=1711022047;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XY9AnvArjYT7RETUszjV+RTASINeKdsvUgO5fnPO4HU=;
        b=kVGh++FKSBTPqcXHkdiug+BFdrYkx4sWCKqafPd/IVZsLA4BTzN40q3j8CX4o+qU5Q
         jg5Xk/a1Nx211V94tcPbWPsmIrCo7t7T4NVJe6lrP11hPTNi1O/IskQME2asHZr641lZ
         +dZLNu8x+pTDo5tvVyMF16PR7gUicYZc9WoTnT+mUTvuIMU4QssM3FtQarPfCHlkGAMD
         8px0QUWWHwfidB0acUVVNOlxVeXxIjx2dDMGz2JdYJZMHeQyPS5PPN2M/xmVJYPlayXZ
         5Glfch5c5sPzZqqnyyjdrSKkaSJnzGkwXM4wGf01oWEfS6Vsb3JczIU15Cz3hXa7U8r8
         DKcw==
X-Forwarded-Encrypted: i=1; AJvYcCVwZCPnni1Hu485Ft2fohF7v7TIxvacOqLhmsm6DoL7ZwDoL9Slz785WPeeD6AjCfXjIn/GuqJL6ccOk6bfE4+ylobwZXginvKFmTO2
X-Gm-Message-State: AOJu0YzS3yiW0GVLxrsUnnmtcVcSbu8MegUJUdVNn3BhyQU6Gxmdyi3G
	B4cxvubuXf3DyH50vUsHzFZRpmmOKZSDHbwVsB+V0Zm9Rf+vR7XvrXF73DWq
X-Google-Smtp-Source: AGHT+IEuolq7Y0oiADgiN48/UycSxA8WBrcMiYWoBqWagrXvG4keU/JnB4Puxyckmi7on5ktuSMV0w==
X-Received: by 2002:a05:6402:b34:b0:568:32cc:f808 with SMTP id bo20-20020a0564020b3400b0056832ccf808mr294291edb.15.1710417246653;
        Thu, 14 Mar 2024 04:54:06 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id t26-20020a056402241a00b005689f73704csm599051eda.38.2024.03.14.04.54.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 04:54:05 -0700 (PDT)
Message-ID: <5d10552a-1c73-4f35-84be-ce6c1dcd800b@kernel.org>
Date: Thu, 14 Mar 2024 12:54:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kexec: fix the unexpected kexec_dprintk() macro
To: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org, akpm@linux-foundation.org, joe@perches.com,
 dyoung@redhat.com
References: <20240314103947.717991-1-bhe@redhat.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240314103947.717991-1-bhe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14. 03. 24, 11:39, Baoquan He wrote:
> Jiri reported that the current kexec_dprintk() always prints out
> debugging message whenever kexec/kdmmp loading is triggered. That is
> not wanted. The debugging message is supposed to be printed out when
> 'kexec -s -d' is specified for kexec/kdump loading.
> 
> After investigating, the reason is the current kexec_dprintk() takes
> printk(KERN_INFO) or printk(KERN_DEBUG) depending on whether '-d' is
> specified. However, distros usually have defaulg log level like below:
> 
>   [~]# cat /proc/sys/kernel/printk
>   7	 4	1	7
> 
> So, even though '-d' is not specified, printk(KERN_DEBUG) also always
> prints out. I thought printk(KERN_DEBUG) is equal to pr_debug(), it's
> not.
> 
> Fix it by changing to use pr_info() and pr_debug() instead which are
> expected to work.

Hi,

sow, you'd need both -d, and dyndbg updates. Hence, again my question:
===
Actually what was wrong on the pr_debug()s? Can you simply turn them on 
from the kernel when -d is passed to kexec instead of all this?
===

And yet, it is still missing a prefix :).

> Signed-off-by: Baoquan He <bhe@redhat.com>
> Reported-by: Jiri Slaby <jirislaby@kernel.org>
> Closes: https://lore.kernel.org/all/4c775fca-5def-4a2d-8437-7130b02722a2@kernel.org
> ---
>   include/linux/kexec.h | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 400cb6c02176..09688e681bf7 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -502,10 +502,13 @@ static inline unsigned int crash_get_elfcorehdr_size(void) { return 0; }
>   
>   extern bool kexec_file_dbg_print;
>   
> -#define kexec_dprintk(fmt, ...)					\
> -	printk("%s" fmt,					\
> -	       kexec_file_dbg_print ? KERN_INFO : KERN_DEBUG,	\
> -	       ##__VA_ARGS__)
> +#define kexec_dprintk(fmt, args...)				\
> +	do {							\
> +		if (kexec_file_dbg_print)			\
> +			pr_info(fmt, ##args);			\
> +		else						\
> +			pr_debug(fmt, ##args);			\
> +	} while (0)
>   
>   #else /* !CONFIG_KEXEC_CORE */
>   struct pt_regs;

-- 
js
suse labs


