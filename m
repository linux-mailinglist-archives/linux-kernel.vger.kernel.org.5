Return-Path: <linux-kernel+bounces-123908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44508890FA0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE71328F62C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1112610A0A;
	Fri, 29 Mar 2024 00:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="hAqQAUfQ"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EA1F9F5;
	Fri, 29 Mar 2024 00:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711672004; cv=none; b=Z0xqDqJYhEkkyB9tOO4bXox/VUhvky5ObUWtITD8lksW6pgkPmOrRxsJMANX6QkxhHdUPueilB7SZi+yo3FyT6Tlg9WVJxnkBsvBkhWbLWxVFYkV44vMTtJ0iZTev7VWz9XYLc0+JVd8gGTLqACSCkjGriOtyFPzSV3JZPm5aZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711672004; c=relaxed/simple;
	bh=/RyTmpEs6u/P4fbexE9k22xTGTCu+7WJCN5jpKzGScE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ja0+OnShoxiDzLhXA/03c/rQIbouwsx9gdd+Fy3wEPVaa6uWn3F1Fg/t8uuucWDKvgTykNAd1OTZDYMdIbJF/aAvCrl4lYdKxpVVPodNN3XiBntVq5WtqYyOE1jdWADduenfLyHVNyC5yzDRkfuGZz4oAMKKpGSxejLCyaLUj0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=hAqQAUfQ; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1711671991; x=1712276791; i=w_armin@gmx.de;
	bh=hH9tb/ABgMBjmS58aLfFbzUo9NffBHa2IJqSYOGE9QE=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=hAqQAUfQh8/He0hCcxMPrvi/OLwfmKiZn1QDqkAcwRUeYxLhda2W3FvbVes60iun
	 vz9CKchqmePbEMqnrXH2njVu5N9YpdVv2uFFxpGeHXRsvgDX0HsWMWn26QPfBiW4B
	 oyRJ9eARbOOl+UgpHghhQcQwIpABN3gzm+pNlgaWDRhiFKscY+eujgnolpsNKm/iT
	 mmc+97EhASOPObhSdTPHjPZ744wepl3RDgt5aD3ai/OAoU6Ry7+Wc7cbBCUEGtfc2
	 R+mraBp9g4BrgYhA2xrpbb8fCjPg94mVCw+2raomyInHvlrifX9IK0RzKKSW7g9Qt
	 3Y1xzW7c0F/vhU4HcA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFsZ3-1s44QC2sd5-00HRsm; Fri, 29
 Mar 2024 01:26:31 +0100
Message-ID: <3e41e132-98b9-496d-987f-6838289926b6@gmx.de>
Date: Fri, 29 Mar 2024 01:26:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] platform/x86: xiaomi-wmi: Fix race condition when
 reporting key events
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com
Cc: corbet@lwn.net, linux-doc@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240328012336.145612-1-W_Armin@gmx.de>
 <20240328012336.145612-2-W_Armin@gmx.de>
 <b82ded95-d599-4ef7-b984-ac4d8a5c2370@linux.intel.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <b82ded95-d599-4ef7-b984-ac4d8a5c2370@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:bvn4eBut9GPNTsu7g3IOMs00gYVqoM8iXVOzxQC20UlpStf8ATf
 OjZx97NzIvW38hCxN+OFCdi1zqGPc6KRVOor/1pYPuXokswLGpySVRZcIPuwKGKxAJqOBqH
 Hi+TkISNWRfBea4Pwrb1m+2tY2jyYx4pikx7UUtBOlgJTpNuGK/3ye/2x3+Zqs7n0M1NdCQ
 lYWYGiFK6sJdKQg1b79mw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GVUMHmdiY4Y=;rsjU+U4UG60bsDxcEsJbQ4VpeSj
 prrDNQB1FoJNNWvmX+udk6qVn8WFxVxVrrD5igsZ6XpiMhzpG569xlSW6F+rcVRSb1Efas9C9
 uyo+au1cecDbHqjpj5OdN8jdHbPbh+tpJaiJ0Vk5DaCdmzEuXQHJQ80oiO9GlHPV7uqy/LEP5
 sR08m/Af97SlkcJsTJ8QZ+1PhvdjBfut5ao/Kfs6Kjy6zhYiqQstq4poySLTNIwrzyQJtIV/I
 b1S2EPumMcLLtKpwi1vc4U0xeHjKc23epg42RGyick3d+yMecb5/YTm21Pmton439HzjI1MgC
 Ar3fdCLyW4TsQuxft5A7S/69SAcmeSr1NXujIQsL1AawOVmqT4/el/ncJbdNhiMa2HgstT2pv
 9P0ACIlYOtprqXLY7F2sGdf0yXQI+DNhljl+3Taoo/fyNz7n3xEQr/kFOcuydXwcCXt36rz04
 rD/i9laElSe7kUB2a2e2ssbUreocCzDibwNnesaOVPS2zaIuvOQWDnWWqn3HC9q5Uf4nN+gvW
 ABcnEi1aGo4UUTVJNldnpnkS5qNxDBD9cQqDd/aMYCDWIbTUqd6tln6EK7pFnJgsU3PZGQSFp
 kLpbkoAyCXnvgdvSuv0fbZ0awSA5sCyStYRnIfmw+akW2Y6SyDe+v5BIYk52g9B9kEMJgNDBO
 boy4XXjr3+LxN2AuLNkV2Po/FEJYpyl+h9D2Wh0F2MewxzcIxjbgJaAYwmnZOeSLjSWWRJEY+
 l7AHkylKvBT8PrwpJkYGTWhjJnCh3K0VZAQz3vinWz79D/Xd1rmByd56uGCQNeVeMBvCGVOMl
 2FZJD3tWpyWqB8iHn6HNSzldv7KY4cMyD+WWbQMN01T28=

Am 28.03.24 um 03:58 schrieb Kuppuswamy Sathyanarayanan:

> On 3/27/24 6:23 PM, Armin Wolf wrote:
>> Multiple WMI events can be received concurrently, so multiple instances
>> of xiaomi_wmi_notify() can be active at the same time. Since the input
>> device is shared between those handlers, the key input sequence can be
>> disturbed.
> Since locking is needed for all notify related calls in all WMI drivers,
> is there a generic way to add this support in WMI core driver? Like
> defining some common function which will hold the lock and call
> driver specific notify handler? I am just thinking aloud.. If it is not
> feasible, then it is fine.

Hi,

actually, not all notify-related calls need locking. It just so happens that
input drivers must protect their key sequence, other WMI drivers might not need
to use any locking at all.

I would prefer if the WMI driver does the locking, so it can be optimized for
each WMI driver.

Thanks,
Armin Wolf

>> Fix this by protecting the key input sequence with a mutex.
>>
>> Compile-tested only.
>>
>> Fixes: edb73f4f0247 ("platform/x86: wmi: add Xiaomi WMI key driver")
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>>   drivers/platform/x86/xiaomi-wmi.c | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/drivers/platform/x86/xiaomi-wmi.c b/drivers/platform/x86/xiaomi-wmi.c
>> index 1f5f108d87c0..7efbdc111803 100644
>> --- a/drivers/platform/x86/xiaomi-wmi.c
>> +++ b/drivers/platform/x86/xiaomi-wmi.c
>> @@ -2,8 +2,10 @@
>>   /* WMI driver for Xiaomi Laptops */
>>
>>   #include <linux/acpi.h>
>> +#include <linux/device.h>
>>   #include <linux/input.h>
>>   #include <linux/module.h>
>> +#include <linux/mutex.h>
>>   #include <linux/wmi.h>
>>
>>   #include <uapi/linux/input-event-codes.h>
>> @@ -20,12 +22,21 @@
>>
>>   struct xiaomi_wmi {
>>   	struct input_dev *input_dev;
>> +	struct mutex key_lock;	/* Protects the key event sequence */
>>   	unsigned int key_code;
>>   };
>>
>> +static void xiaomi_mutex_destroy(void *data)
>> +{
>> +	struct mutex *lock = data;
>> +
>> +	mutex_destroy(lock);
>> +}
>> +
>>   static int xiaomi_wmi_probe(struct wmi_device *wdev, const void *context)
>>   {
>>   	struct xiaomi_wmi *data;
>> +	int ret;
>>
>>   	if (wdev == NULL || context == NULL)
>>   		return -EINVAL;
>> @@ -35,6 +46,11 @@ static int xiaomi_wmi_probe(struct wmi_device *wdev, const void *context)
>>   		return -ENOMEM;
>>   	dev_set_drvdata(&wdev->dev, data);
>>
>> +	mutex_init(&data->key_lock);
>> +	ret = devm_add_action_or_reset(&wdev->dev, xiaomi_mutex_destroy, &data->key_lock);
>> +	if (ret < 0)
>> +		return ret;
>> +
>>   	data->input_dev = devm_input_allocate_device(&wdev->dev);
>>   	if (data->input_dev == NULL)
>>   		return -ENOMEM;
>> @@ -59,10 +75,12 @@ static void xiaomi_wmi_notify(struct wmi_device *wdev, union acpi_object *dummy)
>>   	if (data == NULL)
>>   		return;
>>
>> +	mutex_lock(&data->key_lock);
>>   	input_report_key(data->input_dev, data->key_code, 1);
>>   	input_sync(data->input_dev);
>>   	input_report_key(data->input_dev, data->key_code, 0);
>>   	input_sync(data->input_dev);
>> +	mutex_unlock(&data->key_lock);
>>   }
>>
>>   static const struct wmi_device_id xiaomi_wmi_id_table[] = {
>> --
>> 2.39.2
>>
>>

