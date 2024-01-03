Return-Path: <linux-kernel+bounces-16021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6634D823716
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 22:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16663B24392
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9101D6AC;
	Wed,  3 Jan 2024 21:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="bubHF3IK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA551DA22;
	Wed,  3 Jan 2024 21:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1704317027; x=1704921827; i=w_armin@gmx.de;
	bh=yO7sUoFBz10D4BbdlI/Pa5souxOjv3EhM/T5i4KQEpc=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=bubHF3IKiJFzq5b+30WnnG2RvOv17jku/EFF7QrQoWrtoTGyGuaQdRVQrkWHf4vf
	 +e6GR/PcHxkjYc27IiHiUwamshYnwMv/78MVrLs+j/tFfuvA0t4ADe3FfGmL8V5Aa
	 LAJWsgUmnDiTbfJdtWHHEs9Nnu5yQwqtA2hq8S02AakuM8N2Lo944QUaHoNHl+ybd
	 2dwJXXU4cgl1+Ax8HJiHBxaU65pydHrijgqj0hdWNoquSgVTfhm9xsPDi4gCFmoAU
	 ewv8VLAF7ByKMV7w4W7nCUXmN64dvoU32Yd80kcaipWJArzH827+dy/2m3byCzLEe
	 Rd3JbZtJK2K8dXgBzA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MwwZX-1r1P8y0gkF-00ySrw; Wed, 03
 Jan 2024 22:23:47 +0100
Message-ID: <430501f6-47fc-49c8-8db8-9cbdf2ba1ae5@gmx.de>
Date: Wed, 3 Jan 2024 22:23:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hwmon: (acpi_power_meter) Ensure IPMI space handler is
 ready on Dell systems
Content-Language: en-US
To: Kai-Heng Feng <kai.heng.feng@canonical.com>, jdelvare@suse.com,
 linux@roeck-us.net
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 acpica-devel@lists.linux.dev
References: <20231227040401.548977-1-kai.heng.feng@canonical.com>
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20231227040401.548977-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oB8ghZbp5DNMxKkEt+cWRBNblI0o7wFwtVdXY8jsgybXH3fPfdq
 aFZb2DMHX4kOG5LYxuCLWywDJSr0g7r8HZGB/Ur7y1AtdEJeLCDiNGLo8Fw4dtbMMdE5fyR
 jjghZ2Wrfyu21joNtdqG9HUMeqqUQ/2If6i0KHHtK2PsJbVVQHFXD16KedbAqruqdMMyJKx
 qsi4gYHCEwyy8wLSmgaCw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jWNTYdIKL4k=;Fa7BTiBq3zDax/4BRvmo2KH5vrz
 /yCgBJSzTB8wgOlP+Em2Bx9ExqMlAWF0MpgJyai3aS6ETaNa3rXO2aeEuySGdXqzblmIxKi2Y
 Ktlb0Pavd819YcwaRORdJfxRfJV4+6Ivac0zBCtkMBEg6DeEQm6joGQXN20vJrqMAM8hDKLJg
 Y9k4UJh2FHEmdsaDuk/P9NHXdfFJ559V4G04Ahot6BNIZeBqPOSuKmMVjPyFs+zWM5IrziaiU
 NfC/2SJomw3Nn1zCiBK285gWlqyjQb+YtLC8pqN9o/7W4tHeH97mykcmAtXVCCvgrG9LMYfTp
 h1EsI28Sd+uKeic/rSyJuNkg3mbdHSlEaE2KJ86jBOKQ+WfK2jHfUvqI7ibt/i2snphf7tSa9
 dtTknPIN/JmuWdXb1B5saA8F+aNCrFGxRDIeiR+hFRbfLFUWUBdnpwjd5bW02sL/1v9mdow/Q
 0yL9At3mKYTOQ+onNnU+tGd5QDH//MQccqtHz82Ai8kGSQW4INAX0+qqXYC6dwVecNQ+uRHTq
 IunZW7PHRw4Jb1pY5l3nnVuMLC0O4nV3LHU4nF0TbZ0ROCR84sP7fRVbbkJncy/R4hv9WlbE5
 W6lidre87uJtmTtGw6yaQzvxlYcIpAuPk23wNNEXQX0pJHSD1i66fsmUjDXDqqUvPkUAr6TCp
 BOjp+2IsgdguhzfnB+mtfAx6DYds4LLFj8bbZjiE3B90WcXIfDGY1SLEp3/8axHIOVE8xmury
 VPeEQDkPhwJbX9xmZ6gjR8hntFUYD0a5D7bJqnD79qVo+xufPFBElAgdBNv9hlqcT7cA3Yd0b
 RmJzPBsjvswA2dfXhDH82wMh2Q/360NzfAoHLwiRKqy5QEacjD8wzP/1yfv8/QLjYMef4E/Mx
 BDXGa4YEOnWEN2X7dw3YIsZOVGqRb5XTecjIfvUU5vZD21XQ+rjsKPNYsO27U+iZVnospSm7O
 tKkR5/Okt/3wM3zu8vVdiXEyPco=

Am 27.12.23 um 05:04 schrieb Kai-Heng Feng:

> The following error can be observed at boot:
> [    3.717920] ACPI Error: No handler for Region [SYSI] (00000000ab9e62c=
5) [IPMI] (20230628/evregion-130)
> [    3.717928] ACPI Error: Region IPMI (ID=3D7) has no handler (20230628=
/exfldio-261)
>
> [    3.717936] No Local Variables are initialized for Method [_GHL]
>
> [    3.717938] No Arguments are initialized for method [_GHL]
>
> [    3.717940] ACPI Error: Aborting method \_SB.PMI0._GHL due to previou=
s error (AE_NOT_EXIST) (20230628/psparse-529)
> [    3.717949] ACPI Error: Aborting method \_SB.PMI0._PMC due to previou=
s error (AE_NOT_EXIST) (20230628/psparse-529)
> [    3.717957] ACPI: \_SB_.PMI0: _PMC evaluation failed: AE_NOT_EXIST
>
> On Dell systems several methods of acpi_power_meter access variables in
> IPMI region [0], so wait until IPMI space handler is installed by
> acpi_ipmi and also wait until SMI is selected to make the space handler
> fully functional.

Hi,

could it be that the ACPI firmware expects us to support the ACPI SPMI tab=
le?
The ACPI SPMI table contains a description of the IPMI interface used by t=
he platform,
and its purpose seems to be similar to the ACPI ECDT table in that it allo=
ws the OS
to access IPMI resources before all ACPI namespaces are enumerated.

Adding support for this table would solve this problem without stalling th=
e boot
process by waiting for the ACPI IPMI device to probe. It would also avoid =
any issues
should the ACPI IPMI device be removed later.

Armin Wolf

>
> [0] https://www.dell.com/support/manuals/en-us/redhat-enterprise-linux-v=
8.0/rhel8_rn_pub/advanced-configuration-and-power-interface-acpi-error-mes=
sages-displayed-in-dmesg?guid=3Dguid-0d5ae482-1977-42cf-b417-3ed5c3f5ee62
>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2:
>   - Use completion instead of request_module().
>
>   drivers/acpi/acpi_ipmi.c         | 13 ++++++++++++-
>   drivers/hwmon/acpi_power_meter.c |  4 ++++
>   include/acpi/acpi_bus.h          |  4 ++++
>   3 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
> index 0555f68c2dfd..2ea8b7e6cebf 100644
> --- a/drivers/acpi/acpi_ipmi.c
> +++ b/drivers/acpi/acpi_ipmi.c
> @@ -23,6 +23,8 @@ MODULE_LICENSE("GPL");
>   #define IPMI_TIMEOUT			(5000)
>   #define ACPI_IPMI_MAX_MSG_LENGTH	64
>
> +static struct completion smi_selected;
> +
>   struct acpi_ipmi_device {
>   	/* the device list attached to driver_data.ipmi_devices */
>   	struct list_head head;
> @@ -463,8 +465,10 @@ static void ipmi_register_bmc(int iface, struct dev=
ice *dev)
>   		if (temp->handle =3D=3D handle)
>   			goto err_lock;
>   	}
> -	if (!driver_data.selected_smi)
> +	if (!driver_data.selected_smi) {
>   		driver_data.selected_smi =3D ipmi_device;
> +		complete(&smi_selected);
> +	}
>   	list_add_tail(&ipmi_device->head, &driver_data.ipmi_devices);
>   	mutex_unlock(&driver_data.ipmi_lock);
>
> @@ -578,10 +582,17 @@ acpi_ipmi_space_handler(u32 function, acpi_physica=
l_address address,
>   	return status;
>   }
>
> +void wait_for_acpi_ipmi(void)
> +{
> +	wait_for_completion_interruptible_timeout(&smi_selected, 2 * HZ);
> +}
> +EXPORT_SYMBOL_GPL(wait_for_acpi_ipmi);
> +
>   static int __init acpi_ipmi_init(void)
>   {
>   	int result;
>   	acpi_status status;
> +	init_completion(&smi_selected);
>
>   	if (acpi_disabled)
>   		return 0;
> diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power=
_meter.c
> index 703666b95bf4..acaf1ae68dc8 100644
> --- a/drivers/hwmon/acpi_power_meter.c
> +++ b/drivers/hwmon/acpi_power_meter.c
> @@ -883,6 +883,10 @@ static int acpi_power_meter_add(struct acpi_device =
*device)
>   	strcpy(acpi_device_class(device), ACPI_POWER_METER_CLASS);
>   	device->driver_data =3D resource;
>
> +	if (dmi_match(DMI_SYS_VENDOR, "Dell Inc.") &&
> +	    acpi_dev_get_first_match_dev("IPI0001", NULL, -1))
> +		wait_for_acpi_ipmi();
> +
>   	res =3D read_capabilities(resource);
>   	if (res)
>   		goto exit_free;
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 1216d72c650f..ed59fb89721e 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -655,6 +655,7 @@ bool acpi_device_override_status(struct acpi_device =
*adev, unsigned long long *s
>   bool acpi_quirk_skip_acpi_ac_and_battery(void);
>   int acpi_install_cmos_rtc_space_handler(acpi_handle handle);
>   void acpi_remove_cmos_rtc_space_handler(acpi_handle handle);
> +void wait_for_acpi_ipmi(void);
>   #else
>   static inline bool acpi_device_override_status(struct acpi_device *ade=
v,
>   					       unsigned long long *status)
> @@ -672,6 +673,9 @@ static inline int acpi_install_cmos_rtc_space_handle=
r(acpi_handle handle)
>   static inline void acpi_remove_cmos_rtc_space_handler(acpi_handle hand=
le)
>   {
>   }
> +static inline void wait_for_acpi_ipmi(void)
> +{
> +}
>   #endif
>
>   #if IS_ENABLED(CONFIG_X86_ANDROID_TABLETS)

