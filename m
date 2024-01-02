Return-Path: <linux-kernel+bounces-14351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09317821BC0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2AE81F2299F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F06F512;
	Tue,  2 Jan 2024 12:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P4RX/1v+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DBDFC1D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 12:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704199087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aOiIVnrfw3j/25sx9mj6iBNj7SDjBTnZ0tIKGyspww8=;
	b=P4RX/1v+vqu9EZfCGzczWzI13UmegwuYSeMFIFeuoehdpZ8d54Kdyhx3WCFC2II7MmqIjd
	Zv5ML+VPjNFAgvHdR+qgMxjzWUp5O0Rtzm3wbGGFD9yn+yI/yM8Vv0a40gjzr67VVK6nQy
	wuRlpjFTfb/XgMpp5/TVvyjl9T3c+Ik=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-bceJKRarPxisZxhXS7WmXQ-1; Tue, 02 Jan 2024 07:38:06 -0500
X-MC-Unique: bceJKRarPxisZxhXS7WmXQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5567953c4acso513826a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 04:38:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704199085; x=1704803885;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aOiIVnrfw3j/25sx9mj6iBNj7SDjBTnZ0tIKGyspww8=;
        b=PD9uI+ryc1M/lBp5J3ZGm3vCkRkpvoNMvX9Pl5SxGguI9uUEHbT6fep8cyPYWory13
         gJb12sxwr3Jvq14E3QIW7JBmEYvDA2/OQq8eKBpD/tcg9mkPz+xpYtHbuZjLP8plsuId
         UbgTEkW3S3g8sNv19xa4OAqfl/opCweJcJ2L9VLGH6oKKLlr0admtv38kLO0KmO4/R0L
         sdx2Geo4+t0X5eXyyjfWCAqfBmWr1SGRz8ej/Uq/T4a7I8Ny+qCy8euVr6pemkWjyqkn
         t6te9oSBZADCDodmsEQNzb4lJHOwuwrVzhe2msrgwtsrg2w0Ck78y7AvAS2sLLhup0+0
         VhPw==
X-Gm-Message-State: AOJu0YxaLP+fNBs40K7VUKLvjMLRNeti4p9Ymrh1zY2HQSUT4SkKDxhi
	JzVjvmGLe7r/mImzFanrsXUMun83BtE8KLt8R9dzyAmUBcUQCLvweVa9ijeBj1j9Akk1nWk3RC+
	0mzk5sqoH1LxSOoay9GlbIXT7DF15iTWA
X-Received: by 2002:a50:d5cd:0:b0:552:2b83:30b7 with SMTP id g13-20020a50d5cd000000b005522b8330b7mr10842114edj.32.1704199085141;
        Tue, 02 Jan 2024 04:38:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPhlfX49TZaOLQEbBJT0HoKBu157QSyNXUEAnI1EhtZHwGiRzr/5Z4syQ6r5VhLZ+aNCcRZg==
X-Received: by 2002:a50:d5cd:0:b0:552:2b83:30b7 with SMTP id g13-20020a50d5cd000000b005522b8330b7mr10842107edj.32.1704199084781;
        Tue, 02 Jan 2024 04:38:04 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id fd23-20020a056402389700b00553a86b7821sm15857865edb.74.2024.01.02.04.38.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 04:38:04 -0800 (PST)
Message-ID: <517ab423-4e10-489c-a56f-e5583a213b3a@redhat.com>
Date: Tue, 2 Jan 2024 13:38:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86/amd/pmf: Return a status code only as a
 constant in two functions
Content-Language: en-US, nl
To: Markus Elfring <Markus.Elfring@web.de>,
 platform-driver-x86@vger.kernel.org, kernel-janitors@vger.kernel.org,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <0d0c4876-37d7-4bee-912e-56324495454f@web.de>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <0d0c4876-37d7-4bee-912e-56324495454f@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

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


Hi,

On 12/28/23 10:54, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 28 Dec 2023 10:48:16 +0100
> 
> Return a status code without storing it in an intermediate variable.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>


> ---
>  drivers/platform/x86/amd/pmf/acpi.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/platform/x86/amd/pmf/acpi.c b/drivers/platform/x86/amd/pmf/acpi.c
> index 4ec7957eb707..ce00dd9a5391 100644
> --- a/drivers/platform/x86/amd/pmf/acpi.c
> +++ b/drivers/platform/x86/amd/pmf/acpi.c
> @@ -111,7 +111,6 @@ int apmf_os_power_slider_update(struct amd_pmf_dev *pdev, u8 event)
>  	struct os_power_slider args;
>  	struct acpi_buffer params;
>  	union acpi_object *info;
> -	int err = 0;
> 
>  	args.size = sizeof(args);
>  	args.slider_event = event;
> @@ -121,10 +120,10 @@ int apmf_os_power_slider_update(struct amd_pmf_dev *pdev, u8 event)
> 
>  	info = apmf_if_call(pdev, APMF_FUNC_OS_POWER_SLIDER_UPDATE, &params);
>  	if (!info)
> -		err = -EIO;
> +		return -EIO;
> 
>  	kfree(info);
> -	return err;
> +	return 0;
>  }
> 
>  static void apmf_sbios_heartbeat_notify(struct work_struct *work)
> @@ -148,7 +147,6 @@ int apmf_update_fan_idx(struct amd_pmf_dev *pdev, bool manual, u32 idx)
>  	union acpi_object *info;
>  	struct apmf_fan_idx args;
>  	struct acpi_buffer params;
> -	int err = 0;
> 
>  	args.size = sizeof(args);
>  	args.fan_ctl_mode = manual;
> @@ -158,14 +156,11 @@ int apmf_update_fan_idx(struct amd_pmf_dev *pdev, bool manual, u32 idx)
>  	params.pointer = (void *)&args;
> 
>  	info = apmf_if_call(pdev, APMF_FUNC_SET_FAN_IDX, &params);
> -	if (!info) {
> -		err = -EIO;
> -		goto out;
> -	}
> +	if (!info)
> +		return -EIO;
> 
> -out:
>  	kfree(info);
> -	return err;
> +	return 0;
>  }
> 
>  int apmf_get_auto_mode_def(struct amd_pmf_dev *pdev, struct apmf_auto_mode *data)
> --
> 2.43.0
> 


