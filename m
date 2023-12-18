Return-Path: <linux-kernel+bounces-3551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5586A816DB9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D0061C2314E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9834B141;
	Mon, 18 Dec 2023 12:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HKm6x0Uw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738A54B129
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 12:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702901590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2HfwW6VTl4oHBrRVr940R0bKleCMAQTGxmFnIxKjn7k=;
	b=HKm6x0UwgRIq5pBeG5B0RD93wInO0jYXi/7Pqxu/AWiPBiA52++m1sc0WTHagxusbuJnk0
	5tMyEfpa0WCwESRlwQR1lXnDddkmKKnOxpJvjqA+PtkH11LYO0gAP8Ru8MQFqNRw2eCrM+
	HyzRuYgXN95yrOa8wof3vYxbhDX4mKY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-JXtJml5BNRGZO0uU6itQFA-1; Mon, 18 Dec 2023 07:13:08 -0500
X-MC-Unique: JXtJml5BNRGZO0uU6itQFA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a00dd93a5f9so179107366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 04:13:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702901587; x=1703506387;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2HfwW6VTl4oHBrRVr940R0bKleCMAQTGxmFnIxKjn7k=;
        b=T7LtDteaSDtuU7YkQYgim2ieQvZPw5arpNotu94RxKz8+7H/NzS+ubnKirpHQueT3M
         DBuKnKnWaVTWqLrTpvbY1FMx90kmChKvSQrNJNf0zg3geHLbXq90SSyNTvEVnXLv0dp0
         /1QhUHyQMxYi30Pff+gb05dg9xsRXOJj3kMFc301MIvMF/A7RSBWVfSOoIl2jw1vOfuD
         oBNrkSLsHnagHRO7xx8SoenXGFYgtERTtlyC8PaKh/K48UDEGe1FHIl6UYUKQ2zUULTN
         LcWveNT/10zZ1ZoBH3Ozsnt2I6WGiL9mhR4dFCGgc+aJDq75/GFyVqqkaOm1wPZwnq7/
         hpFw==
X-Gm-Message-State: AOJu0Yw95T9hG6VHgV3gjLCcNOyJpX4BEov+9+hh30joUNgS/SuGeFlp
	3gNkAfo99u5DDaSKJFqUgH1LGbmtWtT7kDIRr5iipJpX7XiAjZvCDa5nzvAghXXKxl6W8FUq8jj
	I/6TadcC+28RjlGobrUQ/kfvHERbgEY0U
X-Received: by 2002:a17:906:943:b0:a1c:f2a8:4cfc with SMTP id j3-20020a170906094300b00a1cf2a84cfcmr3840186ejd.139.1702901587107;
        Mon, 18 Dec 2023 04:13:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwBXXWoNzXul9RbZZTHR07rYXwg4MMUdWr0G+c8lXxfJ9n+g+SJjClBVoJJossMGhEl8ojvg==
X-Received: by 2002:a17:906:943:b0:a1c:f2a8:4cfc with SMTP id j3-20020a170906094300b00a1cf2a84cfcmr3840182ejd.139.1702901586798;
        Mon, 18 Dec 2023 04:13:06 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id tl12-20020a170907c30c00b009fd585a2155sm13941443ejc.0.2023.12.18.04.13.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 04:13:06 -0800 (PST)
Message-ID: <24090583-2882-4961-a238-c964b099ee55@redhat.com>
Date: Mon, 18 Dec 2023 13:13:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ACPI: utils: Introduce helper for _DEP list lookup
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
References: <12358058.O9o76ZdvQC@kreacher>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <12358058.O9o76ZdvQC@kreacher>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 12/14/23 12:07, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The ACPI LPSS driver and the Surface platform driver code use almost the
> same code pattern for checking if one ACPI device is present in the list
> returned by _DEP for another ACPI device.
> 
> To reduce the resulting code duplication, introduce a helper for that
> called acpi_device_dep() and invoke it from both places.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This depends on the following series sent last week:
> 
> https://lore.kernel.org/linux-acpi/6008018.lOV4Wx5bFT@kreacher/

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

feel free to merge this through the linux-pm/ACPI tree.

Regards,

Hans





> 
> ---
>  drivers/acpi/acpi_lpss.c                       |   29 +--------------------
>  drivers/acpi/utils.c                           |   33 +++++++++++++++++++++++++
>  drivers/platform/surface/surface_acpi_notify.c |   28 ---------------------
>  include/acpi/acpi_bus.h                        |    1 
>  4 files changed, 37 insertions(+), 54 deletions(-)
> 
> Index: linux-pm/drivers/acpi/acpi_lpss.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/acpi_lpss.c
> +++ linux-pm/drivers/acpi/acpi_lpss.c
> @@ -563,31 +563,6 @@ static struct device *acpi_lpss_find_dev
>  	return bus_find_device(&pci_bus_type, NULL, &data, match_hid_uid);
>  }
>  
> -static bool acpi_lpss_dep(struct acpi_device *adev, acpi_handle handle)
> -{
> -	struct acpi_handle_list dep_devices;
> -	bool ret = false;
> -	int i;
> -
> -	if (!acpi_has_method(adev->handle, "_DEP"))
> -		return false;
> -
> -	if (!acpi_evaluate_reference(adev->handle, "_DEP", NULL, &dep_devices)) {
> -		dev_dbg(&adev->dev, "Failed to evaluate _DEP.\n");
> -		return false;
> -	}
> -
> -	for (i = 0; i < dep_devices.count; i++) {
> -		if (dep_devices.handles[i] == handle) {
> -			ret = true;
> -			break;
> -		}
> -	}
> -
> -	acpi_handle_list_free(&dep_devices);
> -	return ret;
> -}
> -
>  static void acpi_lpss_link_consumer(struct device *dev1,
>  				    const struct lpss_device_links *link)
>  {
> @@ -598,7 +573,7 @@ static void acpi_lpss_link_consumer(stru
>  		return;
>  
>  	if ((link->dep_missing_ids && dmi_check_system(link->dep_missing_ids))
> -	    || acpi_lpss_dep(ACPI_COMPANION(dev2), ACPI_HANDLE(dev1)))
> +	    || acpi_device_dep(ACPI_HANDLE(dev2), ACPI_HANDLE(dev1)))
>  		device_link_add(dev2, dev1, link->flags);
>  
>  	put_device(dev2);
> @@ -614,7 +589,7 @@ static void acpi_lpss_link_supplier(stru
>  		return;
>  
>  	if ((link->dep_missing_ids && dmi_check_system(link->dep_missing_ids))
> -	    || acpi_lpss_dep(ACPI_COMPANION(dev1), ACPI_HANDLE(dev2)))
> +	    || acpi_device_dep(ACPI_HANDLE(dev1), ACPI_HANDLE(dev2)))
>  		device_link_add(dev1, dev2, link->flags);
>  
>  	put_device(dev2);
> Index: linux-pm/drivers/acpi/utils.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/utils.c
> +++ linux-pm/drivers/acpi/utils.c
> @@ -450,6 +450,39 @@ void acpi_handle_list_free(struct acpi_h
>  }
>  EXPORT_SYMBOL_GPL(acpi_handle_list_free);
>  
> +/**
> + * acpi_device_dep - Check ACPI device dependency
> + * @target: ACPI handle of the target ACPI device.
> + * @match: ACPI handle to look up in the target's _DEP list.
> + *
> + * Return true if @match is present in the list returned by _DEP for
> + * @target or false otherwise.
> + */
> +bool acpi_device_dep(acpi_handle target, acpi_handle match)
> +{
> +	struct acpi_handle_list dep_devices;
> +	bool ret = false;
> +	int i;
> +
> +	if (!acpi_has_method(target, "_DEP"))
> +		return false;
> +
> +	if (!acpi_evaluate_reference(target, "_DEP", NULL, &dep_devices)) {
> +		acpi_handle_debug(target, "Failed to evaluate _DEP.\n");
> +		return false;
> +	}
> +
> +	for (i = 0; i < dep_devices.count; i++) {
> +		if (dep_devices.handles[i] == match) {
> +			ret = true;
> +			break;
> +		}
> +	}
> +
> +	acpi_handle_list_free(&dep_devices);
> +	return ret;
> +}
> +
>  acpi_status
>  acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld)
>  {
> Index: linux-pm/drivers/platform/surface/surface_acpi_notify.c
> ===================================================================
> --- linux-pm.orig/drivers/platform/surface/surface_acpi_notify.c
> +++ linux-pm/drivers/platform/surface/surface_acpi_notify.c
> @@ -736,32 +736,6 @@ do {										\
>  #define san_consumer_warn(dev, handle, fmt, ...) \
>  	san_consumer_printk(warn, dev, handle, fmt, ##__VA_ARGS__)
>  
> -static bool is_san_consumer(struct platform_device *pdev, acpi_handle handle)
> -{
> -	struct acpi_handle_list dep_devices;
> -	acpi_handle supplier = ACPI_HANDLE(&pdev->dev);
> -	bool ret = false;
> -	int i;
> -
> -	if (!acpi_has_method(handle, "_DEP"))
> -		return false;
> -
> -	if (!acpi_evaluate_reference(handle, "_DEP", NULL, &dep_devices)) {
> -		san_consumer_dbg(&pdev->dev, handle, "failed to evaluate _DEP\n");
> -		return false;
> -	}
> -
> -	for (i = 0; i < dep_devices.count; i++) {
> -		if (dep_devices.handles[i] == supplier) {
> -			ret = true;
> -			break;
> -		}
> -	}
> -
> -	acpi_handle_list_free(&dep_devices);
> -	return ret;
> -}
> -
>  static acpi_status san_consumer_setup(acpi_handle handle, u32 lvl,
>  				      void *context, void **rv)
>  {
> @@ -770,7 +744,7 @@ static acpi_status san_consumer_setup(ac
>  	struct acpi_device *adev;
>  	struct device_link *link;
>  
> -	if (!is_san_consumer(pdev, handle))
> +	if (!acpi_device_dep(handle, ACPI_HANDLE(&pdev->dev)))
>  		return AE_OK;
>  
>  	/* Ignore ACPI devices that are not present. */
> Index: linux-pm/include/acpi/acpi_bus.h
> ===================================================================
> --- linux-pm.orig/include/acpi/acpi_bus.h
> +++ linux-pm/include/acpi/acpi_bus.h
> @@ -33,6 +33,7 @@ bool acpi_handle_list_equal(struct acpi_
>  void acpi_handle_list_replace(struct acpi_handle_list *dst,
>  			      struct acpi_handle_list *src);
>  void acpi_handle_list_free(struct acpi_handle_list *list);
> +bool acpi_device_dep(acpi_handle target, acpi_handle match);
>  acpi_status
>  acpi_evaluate_ost(acpi_handle handle, u32 source_event, u32 status_code,
>  		  struct acpi_buffer *status_buf);
> 
> 
> 


