Return-Path: <linux-kernel+bounces-27351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE12B82EE82
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61A6A1F23E6C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5011B961;
	Tue, 16 Jan 2024 11:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="LYE4vvZb"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24751B944;
	Tue, 16 Jan 2024 11:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1705406028; x=1706010828; i=w_armin@gmx.de;
	bh=wR22/Ilw+R8LR7NGyIT5Bx2OZcDaOEs1DUoo/pPXg2o=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=LYE4vvZbgjXQGVohrFUeok0bMLrgAauXBaMygMdHaiO2NFFGg1cOyXH+2P4guofv
	 FWzDKeSx+1q2kE3zRjeTdV7eYeCSeKpotQbDWNl32DemHq1KFhURef+Kl6EbbY2MN
	 dclbJ4xTSHsFgk/YuqrhrHFkNOYgjwTEiodx6ue4Eh3675fITI2vxiDu4pw7cMM8D
	 e+6qOTyhvfH5ukhKWEZXT3ePsCf2IiisecVgcq3YIDPeY6nn88mnZ7+v1WF94Z/Re
	 CYN0ZPGZfNQF5bKp/PfIvvafQOIFTOrXHk2KDI9J06DpElJM7iXBPo2f53Zphl1pW
	 hqURCN+HtS8xJTrViA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.35] ([91.137.126.34]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWigq-1rf0su0rAu-00X5RO; Tue, 16
 Jan 2024 12:53:48 +0100
Message-ID: <0d179914-5912-46ee-9c10-50b9bbcac718@gmx.de>
Date: Tue, 16 Jan 2024 12:53:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 6.7 15/18] platform/x86: wmi: Remove ACPI handlers
 after WMI devices
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org
References: <20240116001308.212917-1-sashal@kernel.org>
 <20240116001308.212917-15-sashal@kernel.org>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20240116001308.212917-15-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:njHnQiqoIe9NloKAY8hOxxY/caHZu23EngDXzDadwZL8+bEw7xq
 wg6YU4XIQGOHs+SHteWiJmtj4ENuEeXX4VKapNmhjeMf0O+T8xpe05FELHlH5tDJSdLhyJs
 PRUtEpgG8K8Nof8dzzfC3XagyZzqJLW5Re3rg2b6jV3YR/lNBfBh2aRUov1b8RMdq2WuEbF
 w3s+/klXG140LVS0oUjgg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uQSr3TEF+QQ=;FZrE8TJQfjooCxvSCEYhJXpIZDu
 qqUNqIZ4HIqmXamrxla1EsTOz5gHrpRU8ufF43sQsVzPM61WHIn3MsSXTR3Wne8kV6s3y+wz0
 Bz813arN68BqGub/SBVwTsrECusZjVx8U6pwXEDpXS+I79A30ejKFLyIrD/L2KqQcq97dZ+n9
 WIqPYRBWDKcMqLuFg6KlZdiCRLGRuYrf5DZ+DVl085eZgiyM4nNZAytoCwvyErw/hBMnNNRcp
 Xs26NkzdZiTVp87Z/4wiRfMsnKzxVsSITvm0KxfCfaMEjd0D0EOzBZcoEUcVv50PkYaXRVJTq
 nHgK4ZMl+1TndD5Ch85wXMsxIhUCtnhU+K4Pjw+3dNiY4pmXGEcB7YMMiiTVE7hxKXrmzYyYp
 A8fGATEHcKpI9Jlv31gps6YYcIpxyHT1Zd5Ri0zkvPMzpw55cf34cnVT1+yIXGNWtTZTmgnzA
 vSXBlVFy55WFeryEtN24PhBVE9jymh1KwW0GT/6ji/QuRt2RynLY3+I1aMha1lsQTsS+2SSHO
 p3aIDAs4LFzyHt24+489irN3RmFB1cmsLNIrSOHGDOIh1kZplwkPFMc9gcCAyW54uIs8KDxV3
 q3MKrXFS9Xp5cDGUQmkF2eeVpDwWrs1PQDevmiCw9jMZ/JXTBuZtNW1KZHfZ/+vxKrV3NRnxo
 gBYdDa/9UqJoz3hI6gA1ekxcROd43QJ6T3+VqsTzlb+THYEJNpDAIz2DFvj9fvpL0TgFT/fCD
 TU2ks+dV0KjBdrqO/YskqcZEzwFhvx5pVcBhK4ir65vApS+cDSSp44nsLSVeYUIwbieOyR1Fe
 w7akIGo3B9oY7k3jA0JcdDFaIPpEXmw75F96gtyjtwdUUExIBqNnwRa8DP7+t3fOY4iY6psXr
 4R16u8FIqSUERmNJbij1v6u0+TiVNfiIu+4hbASdkE/4MjnWGbt396Y0e4XowHci/WKpOZ+YA
 4qsriHg68kV8/PjOJxszBqEvHCg=

Am 16.01.24 um 01:12 schrieb Sasha Levin:

> From: Armin Wolf <W_Armin@gmx.de>
>
> [ Upstream commit 22574e17626391ad969af9a13aaa58a1b37ad384 ]
>
> When removing the ACPI notify/address space handlers, the WMI devices
> are still active and might still depend on ACPI EC access or
> WMI events.
> Fix this by removing the ACPI handlers after all WMI devices
> associated with an ACPI device have been removed.

Hello,

i would advise against including this patch in the next stable kernels.

The WMI ACPI notify handler is still using list_for_each_entry() which is
not safe when the WMI devices are removed before the ACPI notify handler.

This issue existed inside the WMI code for a long time, but this patch mig=
ht
trigger it. Since no users reported any issues regarding ACPI errors durin=
g
WMI removal, i would drop this patch.

Thanks,
Armin Wolf

> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> Link: https://lore.kernel.org/r/20231218192420.305411-3-W_Armin@gmx.de
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   drivers/platform/x86/wmi.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index 5dd22258cb3b..d400e61d6801 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -1494,13 +1494,12 @@ static void acpi_wmi_remove(struct platform_devi=
ce *device)
>   	struct acpi_device *acpi_device =3D ACPI_COMPANION(&device->dev);
>   	struct device *wmi_bus_device =3D dev_get_drvdata(&device->dev);
>
> -	acpi_remove_notify_handler(acpi_device->handle, ACPI_ALL_NOTIFY,
> -				   acpi_wmi_notify_handler);
> -	acpi_remove_address_space_handler(acpi_device->handle,
> -				ACPI_ADR_SPACE_EC, &acpi_wmi_ec_space_handler);
> -
>   	device_for_each_child_reverse(wmi_bus_device, NULL, wmi_remove_device=
);
>   	device_unregister(wmi_bus_device);
> +
> +	acpi_remove_notify_handler(acpi_device->handle, ACPI_ALL_NOTIFY, acpi_=
wmi_notify_handler);
> +	acpi_remove_address_space_handler(acpi_device->handle, ACPI_ADR_SPACE_=
EC,
> +					  &acpi_wmi_ec_space_handler);
>   }
>
>   static int acpi_wmi_probe(struct platform_device *device)

