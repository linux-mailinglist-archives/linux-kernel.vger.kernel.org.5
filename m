Return-Path: <linux-kernel+bounces-19727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EE38271F8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81B441F23305
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6475146B81;
	Mon,  8 Jan 2024 14:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OUHu2MZc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B39C4C3A9
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 14:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704725808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NZYr/5wbdSTN5KMNy+kx/4t5MRG0j7fZAQY8NjpcndI=;
	b=OUHu2MZcVEABte7Ts82U1o7MFLz1QGNiNtqWZh/ZSAlHtXfSeG/JQgD6j7dI2c3m5Bedf2
	Cu2er6yQc9Lf+pije19NY2jHSoO0ScyemfZVVTZbveepgq58koAk0c+oWErFaYPNfkKQho
	mMpcgI65kj4LvHiSUJWuNEwQWt/20+Y=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-ZOTuimiGOTapmaivbQynTA-1; Mon, 08 Jan 2024 09:56:46 -0500
X-MC-Unique: ZOTuimiGOTapmaivbQynTA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a28fd25f1fdso84561166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 06:56:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704725805; x=1705330605;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NZYr/5wbdSTN5KMNy+kx/4t5MRG0j7fZAQY8NjpcndI=;
        b=TAR/s4zD5ija4K5E2FKB7dazoD0Jfoisic6/z4oG/GTZpaGiHFAenfPVHHMt24oFSa
         E8aH6mS5RqbaTrqyjc4OHdMADJlRc9UXPP68DykwRUvQz3uu4wp1tPOk9PEuxM6evBUi
         EkFj1/GDnRm9jVk5ZdFFGOVmyBM1tsPZVPQKBw5PXZzRaDiURtofdw9SNUA2chM0KXjQ
         CEsfIp7AK9y8j21eJI5cJhP9gwpvWsXXoWOXqThzvFDU/kkYHDmwgBZuK2IXJUf8XODK
         h4i2/RIxqIs/k5sCO5/oFZ7R7yzuKcIvyUJuYJ01au4EJxg2Ga3yeBWIKfn9ndZkfZF3
         wHjg==
X-Gm-Message-State: AOJu0YxtDhCVnnS06TW3dvRBxXbPnPDphogGW72XPwLt2Mivcv9sGV+O
	Zw3ru8ojbMIHTXBFcqVjL3+49Fw7F4/t0ZVOiYZrxTXur0ZkHcKFWhzMhE+o0aSIyD3q8czMbpz
	2bYFQt1lQr79MT8L792kyGvZRHYDwbJWh
X-Received: by 2002:a17:906:74c1:b0:a28:cf39:bf68 with SMTP id z1-20020a17090674c100b00a28cf39bf68mr1467990ejl.115.1704725805345;
        Mon, 08 Jan 2024 06:56:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESoC/LElRzDXS+V1sKd0uJqNqNVKwSj/kxkoY2fKBTyVs7saX56ulstF6COrGNKnx/PRlTVw==
X-Received: by 2002:a17:906:74c1:b0:a28:cf39:bf68 with SMTP id z1-20020a17090674c100b00a28cf39bf68mr1467986ejl.115.1704725805097;
        Mon, 08 Jan 2024 06:56:45 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id oq3-20020a170906cc8300b00a293c6cc184sm3788783ejb.24.2024.01.08.06.56.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 06:56:44 -0800 (PST)
Message-ID: <f7bf65b4-c562-4d40-b02a-56c165138dd3@redhat.com>
Date: Mon, 8 Jan 2024 15:56:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] platform/x86: thinkpad_acpi: remove redundant
 assignment to variable i
Content-Language: en-US
To: Colin Ian King <colin.i.king@gmail.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240106154740.55202-1-colin.i.king@gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240106154740.55202-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 1/6/24 16:47, Colin Ian King wrote:
> The variable i is being initialized with the value 0 that is never
> read, it is being re-assigned 0 again in a for-loop statement later
> on. The initialization is redundant and can be removed.
> 
> The initialization of variable n can also be deferred after the
> sanity check on pointer n and the declaration of all the int variables
> can be combined as a final code clear-up.
> 
> Cleans up clang scan build warning:
> warning: Value stored to 'i' is never read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/platform/x86/thinkpad_acpi.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index c4895e9bc714..7bf91cfd3e51 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -6208,17 +6208,15 @@ static int thermal_get_sensor(int idx, s32 *value)
>  
>  static int thermal_get_sensors(struct ibm_thermal_sensors_struct *s)
>  {
> -	int res, i;
> -	int n;
> -
> -	n = 8;
> -	i = 0;
> +	int res, i, n;
>  
>  	if (!s)
>  		return -EINVAL;
>  
>  	if (thermal_read_mode == TPACPI_THERMAL_TPEC_16)
>  		n = 16;
> +	else
> +		n = 8;
>  
>  	for (i = 0 ; i < n; i++) {
>  		res = thermal_get_sensor(i, &s->temp[i]);


