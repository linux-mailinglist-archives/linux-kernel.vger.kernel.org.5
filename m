Return-Path: <linux-kernel+bounces-4362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C0C817C0D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A948B22394
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BF94C3B2;
	Mon, 18 Dec 2023 20:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="HB2ZDIZH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33041DA21;
	Mon, 18 Dec 2023 20:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702931774; x=1703536574; i=w_armin@gmx.de;
	bh=EWjs6RVH6Mv2uVAzaW7fNSkAiU6ccq0fUtiP//qCDt0=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=HB2ZDIZH1Kwb3aNwVXeISgVHt849Kufilp+OqD8DfH72HQyLbSn1ZpqaZQ8ILDMD
	 +tVejZG8JLDxA+6EM0AOCd5L376A1MV+D7IIqjQhmzfbPmlK5rueg8dlIEgbT2hMm
	 +QRhkCXxqhll7MtvBAQIamXK0vs1GWdojYIsEwihL+jjYx3Sj0N4LvT+Uj1iD+m7N
	 m90tSUAjvzSsJJaeHupjZNkzU4yxV+RS0FBtKExjnqvDq49XtRchhRvD286egNrjM
	 juK76DNw8pNwuqTbtSWYQJvX84084mb8sd7BD3B7Y5fwPLK/HveQAq9ItJhLv/mAl
	 7WMZe6HKSMefikt8GQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6sit-1rExGr3Yy7-018Kyz; Mon, 18
 Dec 2023 21:36:14 +0100
Message-ID: <6f4de52e-2aff-4f56-8407-e9caf81d4a54@gmx.de>
Date: Mon, 18 Dec 2023 21:34:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 2/6] platform/x86: wmi: Remove ACPI handlers
 after WMI devices
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231218201844.2860-1-W_Armin@gmx.de>
 <20231218201844.2860-3-W_Armin@gmx.de>
Content-Language: en-US
In-Reply-To: <20231218201844.2860-3-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:tGq217jpvXij+c3f1sTBkw44rdv7PqgBvn8hLMxiFoABKA+hFqE
 3zbhftY5qb3OeOm0wX/gFvAG9n9+Q4KywcoPjUo4ScZwhKceDVjvFf6xoDQIfsj1RPxa0L6
 SXTgwrca3aCbUbtSoIVu9ipz9ylalDrw+1Vf+WN9rNTojQPTfjgnm7w3Sea7FK+Tawaz2FA
 LP2Rpk7C4hbVu1L5i1QyA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qNS6FHYQqRY=;/vpsnJLI8pUJNlUs+TBarbscDao
 4sBnURXaJCgYc/LibQen9E4oZ0sV5oS3rb2Rph9AwPBAAL2a5VZr/UZv81Y3EjIoPLf7lM723
 81j0bxs01WlmnAs7ZGpjocwqS31DLxlk/g4dSDP7Awl/rNP8j/MMc0YnA0QoJfZHIhVvqEIZj
 IpVD79nP+v7ljbvYBFBzEiScpRD554OOaX+kwexwCTEGPJMmS9HvmAy4iVUJeS4qEj4gw5PSm
 MVd6De05ju+xVknO6NMwfWt3vcZmJB9evGcvROt16QCiI8hZ5Wupxrbole6BhuuPV+sn/AwxU
 2Q2z+stbFhbCKFCXNj0LGBwupAhJjioqE+7RivlLa/oqfM5r3ymhIbKz/lPLmnpTMHJJOwMiI
 mDFXqhIRG6CSktfKUUiDMIlR6KkD0Xn5I2EFS6ruJJUt3h8I0TQJbzHtM8xya39MfJI3Tr8WN
 S+Bsd7H71xUa/UXmZhF8uJbxoSgjHzNrdL94W9Ubf5fJOfIfw9t2bDdvfADn/L9ACPY+9drEf
 Jbho0tN0A9psTI2VH++dm8OVTA6zyJWTQEGRviF0kn9EReZ0hP8lpqCsiabH0WGC5O4GOWVuD
 Ccmd8uHSvzzaiBUOkVhv9mUb+pFaoVufP6MfPUu8lRbUxEx9J9fu0SMkvyPnNxDjo+x+Y327O
 8/SHPi/2avanjQOt6xQEO5FuZ6IZw+GN34FQcAc8Z1XIKIbjo1NSgKMVeRs2j75xFzHnBBKIH
 U0UK3HLu4z+jMYXE5hS4ewKziMWMLbkxNxcuPAP/Jh4VwYJK3k3CLI3EbRq3tpAioRIjOE23v
 yIJG/SKjGJnJ2KY6bytn3sWVRprwS5L4Hhc9e9QtPKZAgKqRucTW1eCi+p4zsq7KaaoED8780
 04DAlCtMDBpknDGyTxwCqG3H82p+nnYBXSVPlwu8xW3ew87p3dR5D7UK0IahJkHNvDkhgRYCG
 e6djVkWuG+BK3//e4ZhHNIqXe8E=

Am 18.12.23 um 21:18 schrieb Armin Wolf:

> When removing the ACPI notify/address space handlers, the WMI devices
> are still active and might still depend on ACPI EC access or
> WMI events.
> Fix this by removing the ACPI handlers after all WMI devices
> associated with an ACPI device have been removed.

Sorry for sending the patch series multiple times, it seems my mail provider has
some kind of issue which prevents me from receiving mail from this list (this is
the only patch i received from my series so far). Because this i thought that my
patch series got lost somehow.

Armin Wolf

>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>   drivers/platform/x86/wmi.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index 906d3a2831ae..2120c13e1676 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -1239,13 +1239,12 @@ static void acpi_wmi_remove(struct platform_device *device)
>   	struct acpi_device *acpi_device = ACPI_COMPANION(&device->dev);
>   	struct device *wmi_bus_device = dev_get_drvdata(&device->dev);
>
> -	acpi_remove_notify_handler(acpi_device->handle, ACPI_ALL_NOTIFY,
> -				   acpi_wmi_notify_handler);
> -	acpi_remove_address_space_handler(acpi_device->handle,
> -				ACPI_ADR_SPACE_EC, &acpi_wmi_ec_space_handler);
> -
>   	device_for_each_child_reverse(wmi_bus_device, NULL, wmi_remove_device);
>   	device_unregister(wmi_bus_device);
> +
> +	acpi_remove_notify_handler(acpi_device->handle, ACPI_ALL_NOTIFY, acpi_wmi_notify_handler);
> +	acpi_remove_address_space_handler(acpi_device->handle, ACPI_ADR_SPACE_EC,
> +					  &acpi_wmi_ec_space_handler);
>   }
>
>   static int acpi_wmi_probe(struct platform_device *device)
> --
> 2.39.2
>
>

