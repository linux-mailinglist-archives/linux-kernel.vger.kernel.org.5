Return-Path: <linux-kernel+bounces-23952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 885D182B45E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF86B1C24263
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BE652F9F;
	Thu, 11 Jan 2024 17:56:01 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E8452F6A;
	Thu, 11 Jan 2024 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d426ad4433so36044285ad.0;
        Thu, 11 Jan 2024 09:55:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704995757; x=1705600557;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n9arcEUo79iuH5i+dQJ8o/Ftr9e8e+zqckCAA6/vHao=;
        b=KkEZCKXgczUxYmGnsgzbrQajIB3ag9cDauf3ow20j+Cdh7gSiBnsei0R7Ycs0ThJwN
         RKEs/2KoOkljZS2+dKNmqoUfpG4sm6BsKyDpB5HqBGZ1ZdNyJETkdz7KdZVA/4JAKRpZ
         YDh0tVKiCpAJIFpJcHy0rVpSeXQN/P12SeSTLv60wMo03RKt201cuHolOh3qNbTTJhQb
         yBzg567e7BfZpPBUfyCVZktMhACllh4nKn9ace+9lIDClLr6Y48NOEnp/WDxPQqtUm2A
         QTNQwgb5nGo1Qdi4Sh1lreHtrhmlShko0FHOp+uI4Sw5tWBFBm8tKsSu3ihqJoAYfMfI
         Wq0g==
X-Gm-Message-State: AOJu0Yy5GmRRjk+a1LN+Y7R8vOf7nAw2G9xmeR8JkLRDRgxKLUt8as70
	eyubw55ilA578VcfQfYh7Ak=
X-Google-Smtp-Source: AGHT+IGCKXP/Me2EyaazqGPGYzpfCDrjY+044h6PG7i2KrkVjz4fSS4fq8NYYdUCrD//ET7yh10kZA==
X-Received: by 2002:a05:6a20:3c91:b0:19a:41b2:7d98 with SMTP id b17-20020a056a203c9100b0019a41b27d98mr210749pzj.89.1704995757236;
        Thu, 11 Jan 2024 09:55:57 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:2b84:6ee3:e813:3d8d? ([2620:0:1000:8411:2b84:6ee3:e813:3d8d])
        by smtp.gmail.com with ESMTPSA id u25-20020a62d459000000b006db056542e6sm1500847pfl.190.2024.01.11.09.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 09:55:56 -0800 (PST)
Message-ID: <5b643088-7110-494e-9c5b-dd271c291894@acm.org>
Date: Thu, 11 Jan 2024 09:55:54 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: core: Safe warning about bad dev info string
Content-Language: en-US
To: Petr Mladek <pmladek@suse.com>,
 "James E . J . Bottomley" <jejb@linux.ibm.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chris Down <chris@chrisdown.name>, oe-kbuild-all@lists.linux.dev,
 kernel test robot <lkp@intel.com>
References: <20240111162419.12406-1-pmladek@suse.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240111162419.12406-1-pmladek@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/11/24 08:24, Petr Mladek wrote:
> Both "model" and "strflags" are passed to "%s" even when one or both
> are NULL.
> 
> It is safe because vsprintf() would detect the NULL pointer and print
> "(null)". But it is a kernel-specific feature and compiler warns
> about it:
> 
> <warning>
>     In file included from include/linux/kernel.h:19,
>                      from arch/x86/include/asm/percpu.h:27,
>                      from arch/x86/include/asm/current.h:6,
>                      from include/linux/sched.h:12,
>                      from include/linux/blkdev.h:5,
>                      from drivers/scsi/scsi_devinfo.c:3:
>     drivers/scsi/scsi_devinfo.c: In function 'scsi_dev_info_list_add_str':
>>> include/linux/printk.h:434:44: warning: '%s' directive argument is null [-Wformat-overflow=]
>       434 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
>           |                                            ^
>     include/linux/printk.h:430:3: note: in definition of macro 'printk_index_wrap'
>       430 |   _p_func(_fmt, ##__VA_ARGS__);    \
>           |   ^~~~~~~
>     drivers/scsi/scsi_devinfo.c:551:4: note: in expansion of macro 'printk'
>       551 |    printk(KERN_ERR "%s: bad dev info string '%s' '%s'"
>           |    ^~~~~~
>     drivers/scsi/scsi_devinfo.c:552:14: note: format string is defined here
>       552 |           " '%s'\n", __func__, vendor, model,
>           |              ^~
> </warning>
> 
> Do not rely on the kernel specific behavior and print the message a safe way.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202401112002.AOjwMNM0-lkp@intel.com/
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
> Note: The patch is only compile tested.
> 
>   drivers/scsi/scsi_devinfo.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_devinfo.c b/drivers/scsi/scsi_devinfo.c
> index 3fcaf10a9dfe..ba7237e83863 100644
> --- a/drivers/scsi/scsi_devinfo.c
> +++ b/drivers/scsi/scsi_devinfo.c
> @@ -551,9 +551,9 @@ static int scsi_dev_info_list_add_str(char *dev_list)
>   		if (model)
>   			strflags = strsep(&next, next_check);
>   		if (!model || !strflags) {
> -			printk(KERN_ERR "%s: bad dev info string '%s' '%s'"
> -			       " '%s'\n", __func__, vendor, model,
> -			       strflags);
> +			pr_err("%s: bad dev info string '%s' '%s' '%s'\n",
> +			       __func__, vendor, model ? model : "",
> +			       strflags ? strflags : "");
>   			res = -EINVAL;
>   		} else
>   			res = scsi_dev_info_list_add(0 /* compatible */, vendor,

Expressions like "model ? model : """ can be shortened into "model ? : """.

Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

