Return-Path: <linux-kernel+bounces-128714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BCD895E89
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8CAC1F272FD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6F715E5B9;
	Tue,  2 Apr 2024 21:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KerdSiwZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375A015E5A7;
	Tue,  2 Apr 2024 21:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712092630; cv=none; b=fE+tPFwcA1P5VAtv/w2NJSvkgUk9+wLSvztJ7SlrVu1+3W9EYVrfcl+g+QR6YcxXc6ePMSh+MZfkKe0/r6UKCu9QKVHFJiZKHowo7mvEUxglHG2lvJwJCpCKJUTB9ZlBmhKSme1CnLkXisFRfTRw4TjL8f9dpu8kwVdj5BQpfu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712092630; c=relaxed/simple;
	bh=ZDpTfGaozL6O8R8tQSwfWhVOaDOz5UisKush+5x5SmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CiXbtjIll42YpTjFQkILefxe2IRldyiJaabghhOO7/vJlpQSEn8rYHRp8wwQIcyTBSwPD849P5Z+Fi6d3q9ytR7Yg7EqkBjQc+zMye1jIFrBHqj+3FyEMCnYifNwtQeRE1Rbx/zibLU+/8Wqc+eN1O4iNt3Lp8bBHewU21cWEWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KerdSiwZ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712092629; x=1743628629;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZDpTfGaozL6O8R8tQSwfWhVOaDOz5UisKush+5x5SmY=;
  b=KerdSiwZs8v2/XzW1qsMFBFALt8XZRG3A+pMj8/ImKgsxxkoBNE/ddZH
   Ks5ZtHVDa78fbZcL3MKh4nfeWDc0kzaXIwBzaPXFyV+hmrMBJBVOHu/+/
   xg1HYiPCAtSJaHPoo2DNTxa6bk6ibywCf9hLZUElXykuPgdX//v24KvyX
   2c1/r0aynSMV14F7KjIWbaZtkoWp7E9K56fZ61LsikDfqrbrsCjil1PAD
   nQh/z7Euxah+YarvyR++TRgQmMdB7lFfAHiWh0klDmdre9ILokyT5TVqR
   oX/32KeCKWndDI8ohevITDi4SPZBwt1FHuof25cNL0PcALrD71JBINm8W
   A==;
X-CSE-ConnectionGUID: VJqsj9VXQRKGoh+/n2XEGQ==
X-CSE-MsgGUID: 6xhhdoZ+TL+8pIJWClFkfA==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="11114945"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="11114945"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 14:17:09 -0700
X-CSE-ConnectionGUID: d5/GXcNtSIWoDbNVfCNicQ==
X-CSE-MsgGUID: i7E1/IzVTtWfABeuc15uqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="18654257"
Received: from ooginni-mobl.amr.corp.intel.com (HELO [10.209.114.45]) ([10.209.114.45])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 14:17:09 -0700
Message-ID: <fccce666-878a-4f5f-8899-8cc26f7f15bc@linux.intel.com>
Date: Tue, 2 Apr 2024 14:17:08 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] platform/x86: xiaomi-wmi: Fix race condition when
 reporting key events
To: Armin Wolf <W_Armin@gmx.de>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com
Cc: corbet@lwn.net, linux-doc@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240402143059.8456-1-W_Armin@gmx.de>
 <20240402143059.8456-2-W_Armin@gmx.de>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240402143059.8456-2-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 4/2/24 7:30 AM, Armin Wolf wrote:
> Multiple WMI events can be received concurrently, so multiple instances
> of xiaomi_wmi_notify() can be active at the same time. Since the input
> device is shared between those handlers, the key input sequence can be
> disturbed.
>
> Fix this by protecting the key input sequence with a mutex.
>
> Compile-tested only.
>
> Fixes: edb73f4f0247 ("platform/x86: wmi: add Xiaomi WMI key driver")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---

LGTM

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  drivers/platform/x86/xiaomi-wmi.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/platform/x86/xiaomi-wmi.c b/drivers/platform/x86/xiaomi-wmi.c
> index 1f5f108d87c0..7efbdc111803 100644
> --- a/drivers/platform/x86/xiaomi-wmi.c
> +++ b/drivers/platform/x86/xiaomi-wmi.c
> @@ -2,8 +2,10 @@
>  /* WMI driver for Xiaomi Laptops */
>
>  #include <linux/acpi.h>
> +#include <linux/device.h>
>  #include <linux/input.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/wmi.h>
>
>  #include <uapi/linux/input-event-codes.h>
> @@ -20,12 +22,21 @@
>
>  struct xiaomi_wmi {
>  	struct input_dev *input_dev;
> +	struct mutex key_lock;	/* Protects the key event sequence */
>  	unsigned int key_code;
>  };
>
> +static void xiaomi_mutex_destroy(void *data)
> +{
> +	struct mutex *lock = data;
> +
> +	mutex_destroy(lock);
> +}
> +
>  static int xiaomi_wmi_probe(struct wmi_device *wdev, const void *context)
>  {
>  	struct xiaomi_wmi *data;
> +	int ret;
>
>  	if (wdev == NULL || context == NULL)
>  		return -EINVAL;
> @@ -35,6 +46,11 @@ static int xiaomi_wmi_probe(struct wmi_device *wdev, const void *context)
>  		return -ENOMEM;
>  	dev_set_drvdata(&wdev->dev, data);
>
> +	mutex_init(&data->key_lock);
> +	ret = devm_add_action_or_reset(&wdev->dev, xiaomi_mutex_destroy, &data->key_lock);
> +	if (ret < 0)
> +		return ret;
> +
>  	data->input_dev = devm_input_allocate_device(&wdev->dev);
>  	if (data->input_dev == NULL)
>  		return -ENOMEM;
> @@ -59,10 +75,12 @@ static void xiaomi_wmi_notify(struct wmi_device *wdev, union acpi_object *dummy)
>  	if (data == NULL)
>  		return;
>
> +	mutex_lock(&data->key_lock);
>  	input_report_key(data->input_dev, data->key_code, 1);
>  	input_sync(data->input_dev);
>  	input_report_key(data->input_dev, data->key_code, 0);
>  	input_sync(data->input_dev);
> +	mutex_unlock(&data->key_lock);
>  }
>
>  static const struct wmi_device_id xiaomi_wmi_id_table[] = {
> --
> 2.39.2
>
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


