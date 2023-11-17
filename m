Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35377EFB78
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 23:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346223AbjKQWcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 17:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjKQWcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 17:32:20 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C34D50;
        Fri, 17 Nov 2023 14:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1700260308; x=1700865108; i=w_armin@gmx.de;
        bh=PsXYnaI2T53D8H5qrzK8vpKaHF+HAJvZZKNrV4eU6Lg=;
        h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:
         In-Reply-To;
        b=rajSrZ4VMg32ZBgBbGdvf1a7Zpp1KuAjel3h7f5hAMxGKdX+JPUPmftN4SGVoOTM
         Rm/wBUNQOrCJzQ+fdjYyjrvZKwo4eO8HNgoIy+gWMpUMFbJT5nc9jDOtrl8Rv8V52
         15f1yocifhuY95HKXMDxNFMI8rT3coPlcLc89dFk7VSswBThQcAeirvV0+fwT8gPs
         Ums8hkqVC6jxBqag5zQAG1N6eMTzDDR0lUNjtJaSMNRe+1zSfUUr8H5JIdHmUwl+i
         8YDrDO5IzW9m3ZzL3TzbTEkWADIt6CsGKXLWXB5RJvOKSXAfEp5gOC4N2SAqjxgU6
         uZxnpJN5K/zhhuU/Dw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEm6F-1r9rsV0055-00GGKM; Fri, 17
 Nov 2023 23:31:48 +0100
Message-ID: <80f66f8f-84a7-4992-8d9d-e12f16915490@gmx.de>
Date:   Fri, 17 Nov 2023 23:31:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/9] hwmon: (dell-smm) Add support for WMI SMM
 interface
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
References: <20231106064351.42347-1-W_Armin@gmx.de>
 <20231106064351.42347-8-W_Armin@gmx.de>
 <20231114141259.culmdxsoa3hduudm@pali>
Content-Language: en-US
Cc:     jdelvare@suse.com, Guenter Roeck <linux@roeck-us.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, markgross@kernel.org
From:   Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20231114141259.culmdxsoa3hduudm@pali>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VhacByqGV0UnBketf8qhmFBkP8EkzaasOtoEfFHKn40Gq5Qph5x
 DRFuRkfNLQ8KtrydvQPHGaLphHvZG1ia8p7e1P1odFhHbrEluMfpIREgGarYSAElzxPaBlV
 ruc0goc8jugRLzLNERnWQowQy/41PnhQik2VvymVjlZLDp/TP3WJbnuqCT9HSfggX/GWaDZ
 hjgSWkd5MEHcR/h8oQXgg==
UI-OutboundReport: notjunk:1;M01:P0:nrnFH7bXO5Q=;nolmpfcMndYQZx+qFq+UCI4dnOj
 5kknALJAzPZoc28If+vy+vqPSd6HK+OQHkytdY7h5dHkkRs90yGD0VNLAYEieZYtlihw86dFx
 /xYTZ1J6V5y/2Ex0p8auq6k6+WqnNHqkIlZid/jnSirSOgA4luqnIIvQ2BMQh3bV5V8Sh7UvQ
 ZYolpcvCcgJ8Y42dWDheG+kVaTUnGzv0AFIYekITioOCTNZWEvPmYtDT7AKsBBj+/IFwV8LO5
 n5weuu2ktRNqGIk06TEBY9zc8C7n7guPpv8HZWYmfa+aNlFaKtR+QP6QvriJ//ppWtGXkejsO
 GQLaSmObZ9OK1n34DiTxI/9YLLAv9dmNgF7pfFamSTV+VjCLeLZLbQmwIK+misZuTMuhRU7gv
 mf+ieEabQx2H064CWipUt9UaJllI2506i6E55JVPbpvC1fgMHLKnSvaGWAQTH4dAxyTiSAhVI
 GG3an/pUcNVcd4BiaVscxfKrKS0Q/JLF3WzY+pu4Pm3cXZY6LFLtchpddzA1zTaFZSyBh+81z
 hwFEK6hYhlUoLsS5tUfVGybtVlm7+duhERjnkCpn5Im+OZFbe5JWBWl2JLHvAH2EfqI/7B7Tr
 nSHuiPBrdy3Le7FuY/SLlho92faVTN/jecW5vb7sQSHIGkMABEZ4bJnmE79o+edtIn2n/lPHn
 3cMPIkNTWh26qbfxLoNkhhyAwaqE3/H5w5D7rUYvQSGA9BkYON8xMGffCcmpVg06BJnzFlRBw
 Q9wOjWM4bErbEacLm38MSpBTfglB5XbAmSAJkecSOOERyGovo2THrHEa9gEmJxlS6RyS1UpsV
 BSt3JW5bNhDG7qTT2/TIlGj/N2pt+RkxRKeNmffiQAkYP0UthC3iXuwQA+JyBfQdEIc8Xi9Og
 4HhAZ/rZ2trHQy1/xhoA7FIJ83+7ROiD3WE1tFOOXSl1vz62Hu/YTKnv81+UY9xeikasf0MlM
 WIq0KgBk2rlYz+6nfzDRrHa4vRQ=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 14.11.23 um 15:12 schrieb Pali Roh=C3=A1r:

> On Monday 06 November 2023 07:43:49 Armin Wolf wrote:
>> Some Dell machines like the Dell Optiplex 7000 do not support
>> the legacy SMM interface, but instead expect all SMM calls
>> to be issued over a special WMI interface.
>> Add support for this interface so users can control the fans
>> on those machines.
>>
>> Tested-by: <serverror@serverror.com>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>>   drivers/hwmon/Kconfig          |   1 +
>>   drivers/hwmon/dell-smm-hwmon.c | 198 +++++++++++++++++++++++++++++---=
-
>>   drivers/platform/x86/wmi.c     |   1 +
>>   3 files changed, 181 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>> index cf27523eed5a..76cb05db1dcf 100644
>> --- a/drivers/hwmon/Kconfig
>> +++ b/drivers/hwmon/Kconfig
>> @@ -512,6 +512,7 @@ config SENSORS_DS1621
>>
>>   config SENSORS_DELL_SMM
>>   	tristate "Dell laptop SMM BIOS hwmon driver"
>> +	depends on ACPI_WMI
>>   	depends on X86
>>   	imply THERMAL
>>   	help
>> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hw=
mon.c
>> index 2547b09929e6..d1bcfd447bb0 100644
>> --- a/drivers/hwmon/dell-smm-hwmon.c
>> +++ b/drivers/hwmon/dell-smm-hwmon.c
>> @@ -12,6 +12,7 @@
>>
>>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>
>> +#include <linux/acpi.h>
>>   #include <linux/capability.h>
>>   #include <linux/cpu.h>
>>   #include <linux/ctype.h>
>> @@ -34,8 +35,10 @@
>>   #include <linux/thermal.h>
>>   #include <linux/types.h>
>>   #include <linux/uaccess.h>
>> +#include <linux/wmi.h>
>>
>>   #include <linux/i8k.h>
>> +#include <asm/unaligned.h>
>>
>>   #define I8K_SMM_FN_STATUS	0x0025
>>   #define I8K_SMM_POWER_STATUS	0x0069
>> @@ -66,6 +69,9 @@
>>   #define I8K_POWER_AC		0x05
>>   #define I8K_POWER_BATTERY	0x01
>>
>> +#define DELL_SMM_WMI_GUID	"F1DDEE52-063C-4784-A11E-8A06684B9B01"
>> +#define DELL_SMM_LEGACY_EXECUTE	0x1
>> +
>>   #define DELL_SMM_NO_TEMP	10
>>   #define DELL_SMM_NO_FANS	3
>>
>> @@ -219,6 +225,102 @@ static const struct dell_smm_ops i8k_smm_ops =3D =
{
>>   	.smm_call =3D i8k_smm_call,
>>   };
>>
>> +/*
>> + * Call the System Management Mode BIOS over WMI.
>> + */
>> +static int wmi_parse_register(u8 *buffer, u32 length, int *reg)
>> +{
>> +	__le32 value;
>> +	u32 reg_size;
>> +
>> +	if (length <=3D sizeof(reg_size))
>> +		return -ENODATA;
>> +
>> +	reg_size =3D get_unaligned_le32(buffer);
>> +	if (!reg_size || reg_size > sizeof(value))
>> +		return -ENOMSG;
>> +
>> +	if (length < sizeof(reg_size) + reg_size)
>> +		return -ENODATA;
>> +
>> +	memcpy_and_pad(&value, sizeof(value), buffer + sizeof(reg_size), reg_=
size, 0);
> Hello! In one of the patches in this patch series you changed type of
> register from unsigned 32 bit integer to signed 32 bit integers. I'm not
> sure if this change is really intended and what is the real reason for
> it (because there is no explanation for it in the commit message). But
> this memcpy_and_pad would not work correctly for signed negative values
> because it is the highest bit which indicates negative number.
>
> In my opinion, numbers and registers are unsigned. But if you have
> figure out that they has to be treated as signed with possible negative
> values then this fact has to be somehow handled.

That change was by mistake, i will send an updated patch series once Hans
has finished his review.

>> +	*reg =3D le32_to_cpu(value);
>> +
>> +	return (int)(reg_size + sizeof(reg_size));
>> +}
>> +
>> +static int wmi_parse_response(u8 *buffer, u32 length, struct smm_regs =
*regs)
>> +{
>> +	int *registers[] =3D {
>> +		&regs->eax,
>> +		&regs->ebx,
>> +		&regs->ecx,
>> +		&regs->edx
>> +	};
>> +	u32 offset =3D 0;
>> +	int ret, i;
>> +
>> +	for (i =3D 0; i < ARRAY_SIZE(registers); i++) {
>> +		if (offset >=3D length)
>> +			return -ENODATA;
>> +
>> +		ret =3D wmi_parse_register(buffer + offset, length - offset, registe=
rs[i]);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		offset +=3D ret;
>> +	}
>> +
>> +	if (offset !=3D length)
>> +		return -ENOMSG;
>> +
>> +	return 0;
>> +}
>> +
>> +static int wmi_smm_call(struct device *dev, struct smm_regs *regs)
>> +{
>> +	struct wmi_device *wdev =3D container_of(dev, struct wmi_device, dev)=
;
>> +	struct acpi_buffer out =3D { ACPI_ALLOCATE_BUFFER, NULL };
>> +	u32 wmi_payload[] =3D {
>> +		sizeof(regs->eax),
>> +		regs->eax,
>> +		sizeof(regs->ebx),
>> +		regs->ebx,
>> +		sizeof(regs->ecx),
>> +		regs->ecx,
>> +		sizeof(regs->edx),
>> +		regs->edx
>> +	};
>> +	const struct acpi_buffer in =3D {
>> +		.length =3D sizeof(wmi_payload),
>> +		.pointer =3D &wmi_payload,
>> +	};
>> +	union acpi_object *obj;
>> +	acpi_status status;
>> +	int ret;
>> +
>> +	status =3D wmidev_evaluate_method(wdev, 0x0, DELL_SMM_LEGACY_EXECUTE,=
 &in, &out);
>> +	if (ACPI_FAILURE(status))
>> +		return -EIO;
>> +
>> +	obj =3D out.pointer;
>> +	if (!obj)
>> +		return -ENODATA;
>> +
>> +	if (obj->type !=3D ACPI_TYPE_BUFFER) {
>> +		ret =3D -ENOMSG;
>> +
>> +		goto err_free;
>> +	}
>> +
>> +	ret =3D wmi_parse_response(obj->buffer.pointer, obj->buffer.length, r=
egs);
>> +
>> +err_free:
>> +	kfree(obj);
>> +
>> +	return ret;
>> +}
>> +
> ...
>> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
>> index a78ddd83cda0..0b3e63c21d26 100644
>> --- a/drivers/platform/x86/wmi.c
>> +++ b/drivers/platform/x86/wmi.c
>> @@ -106,6 +106,7 @@ MODULE_DEVICE_TABLE(acpi, wmi_device_ids);
>>   static const char * const allow_duplicates[] =3D {
>>   	"05901221-D566-11D1-B2F0-00A0C9062910",	/* wmi-bmof */
>>   	"8A42EA14-4F2A-FD45-6422-0087F7A7E608",	/* dell-wmi-ddv */
>> +	"F1DDEE52-063C-4784-A11E-8A06684B9B01", /* dell-smm-hwmon */
> Here you used space instead of TAB after the comma.

You are right, i will fix this in the updated patch series.

Thanks,
Armin Wolf

>>   	NULL
>>   };
>>
>> --
>> 2.39.2
>>
