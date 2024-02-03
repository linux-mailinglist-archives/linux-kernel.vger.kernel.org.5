Return-Path: <linux-kernel+bounces-50808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 765CA847E2A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 02:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AD1F1C24D68
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 01:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D571FA2;
	Sat,  3 Feb 2024 01:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnTBbdpk"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2554C63AE;
	Sat,  3 Feb 2024 01:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706923674; cv=none; b=oy100GllZgWu1XCnYd1WO80KUX0N+hqBuUxwrrB6CZM+0fL0wD4KfLxFUOBSp6HIROdpW+LqKkMIcFHHRxnb54du21HITIepAGVQMKdgVAGpaXX36xkBdhxUCsVUXv7j2DuyQ4Q3502hqJg2obc1OgnD2JqVOhVsGjH7TfxvYF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706923674; c=relaxed/simple;
	bh=Gl1G2fIsmLDZRV8pG0yE4+nlf0H6J3/BoRBolCHSNZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1vbL6tbGGzA7IJ84X5wpZbYc5kNSfSZq8+Yn9Fj3p9QeeQ3IYDN0lb3vVptlQTYUIXBTR8n5YgmPWY5kjAQDbm83lCMLGuPGEtjttfFvci2yE7r4aIm472CF3dqwkEMLJ1BuR6/ao7s1KaUgd+rmzJ+dTIYEwmuR9zAvdpMI10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnTBbdpk; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6de070a4cadso1938810b3a.2;
        Fri, 02 Feb 2024 17:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706923671; x=1707528471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rfN7PEXKkbRajYyXkiAJhiqOd4ro2FrRiAL+D+SIWtk=;
        b=jnTBbdpkDSzHJNOxRW4LivntQi81Z4J/J0NUpxZf1kcUjP5QvAhHEbcpsPCrx6zMiZ
         BcGBJ+ZT/2ZbB9bkqmLY5/2jIy76b1DSXfyPP+iCgAn6MWZtYL2yCTzipmmUUnBJ6cpn
         7tpHpkJOzD4mgu6jrb0yOkWjNRJm9eSL+pKj3Sufu4/gheeAftT1bLcZUvK0MjQOVNRW
         xksxiwogFDDnSBPhNfGDgZ68AN4Th1jTHmAWKImVoEARJ2xQdglFFLSU5lp/a9EZiNlV
         v57WiV3m+NINJpENT2V51F1B6mBpi3YbdXQo61c4VMIr3m02DxZ8Nan7vXs7h9e/gSfF
         tlew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706923671; x=1707528471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rfN7PEXKkbRajYyXkiAJhiqOd4ro2FrRiAL+D+SIWtk=;
        b=Ri1ZQonyuFnJhbqT7EZOroJ3DInHq3prPL24n6k2+xdfwFd5h3lnNu7hgN1+IX9uxj
         3S0hyHZwa5wnLjlaUMwHoBZ502lZc6NnQRF3lpxEKAQRGvRMQr0zl7DSgDQPSA6DP1zU
         pMZsK8qubQTL1Oz51JKQqKePEAoqKyIHesgKQ/jn4uTZUgOGK8PapKjrUgvbhQdy4vng
         IhjlzM/KcvWzWIvqRohYEAHNN84r5pfr6Ten4AMbrMKFMEQtJxwzzwC0rC9urbCJEqHK
         TN4clR7NAs06LBd9IrJxjeyyLWjti3PrFUB9rm018rXQSr4rQZzNh2ggkLoNIHElkpDJ
         vJ/g==
X-Gm-Message-State: AOJu0Yw9YP392FgL+SMDMTXey+s2wCHKOD5cpfYDH8wHSwCr49a0czrh
	aGJLJmpWLKJMStvh9oHyAyNKY4lp+s+vNUj9yD1pIg6z/JP+Hcla
X-Google-Smtp-Source: AGHT+IFQfJ7fyb7+t1JdoP1NdLqyDn9eoAnVt1s4pkkNULctQkyaMxJRZPPk8YlHBqXEElfxciOkBw==
X-Received: by 2002:aa7:9d10:0:b0:6dd:6caa:aecc with SMTP id k16-20020aa79d10000000b006dd6caaaeccmr3833419pfp.31.1706923671093;
        Fri, 02 Feb 2024 17:27:51 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXMx9ySJG3R+xo+HPJtstnuBlU29DPUy1KOJi/kf+q9w4ch0uNSp5kGuwIJXGlLVZYR34SVx+ihsbKyT8ZgGgWEK4vYtpnNbAp0Jl9qYUtGtziaE+NYIICVV5K/9aNNJxDW306Yk/m+roVF5gW67zdlhla20dhRN8eLe4QW0x2z3MxK8IV3FNzHJwIh4ki/Li+eN1bRW8C1ZgynM9cVaVr6YjgM//cqB14CqPMUEEs5F34UuGM/w80=
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bn7-20020a056a00324700b006db87354a8fsm2278170pfb.119.2024.02.02.17.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 17:27:50 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 2 Feb 2024 17:27:48 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: David Ober <dober6023@gmail.com>
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, jdelvare@suse.com, corbet@lwn.net,
	dober@lenovo.com, mpearson-lenovo@squebb.ca
Subject: Re: [PATCH v3] hwmon:Add MEC172x Micro Chip driver for Lenovo
 motherboards
Message-ID: <b30d8725-5fe8-41bc-9f5d-253b090fc529@roeck-us.net>
References: <20240109193557.4946-1-dober6023@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109193557.4946-1-dober6023@gmail.com>

On Tue, Jan 09, 2024 at 02:35:57PM -0500, David Ober wrote:
> This addition adds in the ability for the system to scan the
> MEC172x EC chip in Lenovo ThinkStation systems to get the
> current fan RPM speeds and the Maximum speed value for each
> fan also provides the current CPU and DIMM thermal status
> 
> Signed-off-by: David Ober <dober6023@gmail.com>
> 
> Written by David Ober from Lenovo using this gmail address since
> my corporate email address does not comply with git email

One way to handle that would be to use the coprporate e-mail address
as author, your corporate e-mail address as first sign-off, and your
gmail address as second sign-off.

> 
> v2 fixed mixcased naming
> v2 add mutex protection
> v2 removed references to ACPI as it is not used
> v2 added comment to explain why returning a -1 is needed
> v3 verify running on a ThinkStation before calling probe function
> V3 replaced empty strings with N/A value in lable arrays
> V3 rename p7_amd to p8 since the name is now changed formally
> V3 removed returning -1 now returns ENODEV
> V3 fixed compiler warning from version 2
> ---

Change log should be after "---".

>  drivers/hwmon/Kconfig             |  10 +
>  drivers/hwmon/Makefile            |   1 +
>  drivers/hwmon/lenovo-ec-sensors.c | 490 ++++++++++++++++++++++++++++++

Documentation is missing.

>  3 files changed, 501 insertions(+)
>  create mode 100644 drivers/hwmon/lenovo-ec-sensors.c
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index ec38c8892158..821741ec0d2f 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -862,6 +862,16 @@ config SENSORS_LAN966X
>  	  This driver can also be built as a module. If so, the module
>  	  will be called lan966x-hwmon.
>  
> +config SENSORS_LENOVO_EC
> +        tristate "Microchip MEC172X Chip for Lenovo ThinkStation"

It is completely irrelevant that the EC chip is MEC172X. This would work
just as well on another Lenovo ThinkStation with an EC from another
vendor as long as the API is the same.

Didn't I say this before ? I am  quite sure I did.

> +        depends on I2C
> +        help
> +          If you say yes here you get support for LENOVO
> +          EC Sensors on newer ThinkStation systems
> +
> +          This driver can also be built as a module. If so, the module
> +          will be called lenovo_ec_sensors.
> +
>  config SENSORS_LINEAGE
>  	tristate "Lineage Compact Power Line Power Entry Module"
>  	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 4ac9452b5430..aa3c2dc390ec 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -104,6 +104,7 @@ obj-$(CONFIG_SENSORS_JC42)	+= jc42.o
>  obj-$(CONFIG_SENSORS_K8TEMP)	+= k8temp.o
>  obj-$(CONFIG_SENSORS_K10TEMP)	+= k10temp.o
>  obj-$(CONFIG_SENSORS_LAN966X)	+= lan966x-hwmon.o
> +obj-$(CONFIG_SENSORS_LENOVO_EC)	+= lenovo-ec-sensors.o
>  obj-$(CONFIG_SENSORS_LINEAGE)	+= lineage-pem.o
>  obj-$(CONFIG_SENSORS_LOCHNAGAR)	+= lochnagar-hwmon.o
>  obj-$(CONFIG_SENSORS_LM63)	+= lm63.o
> diff --git a/drivers/hwmon/lenovo-ec-sensors.c b/drivers/hwmon/lenovo-ec-sensors.c
> new file mode 100644
> index 000000000000..731d75e06977
> --- /dev/null
> +++ b/drivers/hwmon/lenovo-ec-sensors.c
> @@ -0,0 +1,490 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * HWMON driver for MEC172x chip that publishes some sensor values

Again, no, that is not what it is.

> + * via the embedded controller registers specific to Lenovo Systems.
> + *
> + * Copyright (C) 2023 David Ober (Lenovo) <dober@lenovo.com>
> + *
> + * EC provides:
> + * - CPU temperature
> + * - DIMM temperature
> + * - Chassis zone temperatures
> + * - CPU fan RPM
> + * - DIMM fan RPM
> + * - Chassis fans RPM
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/delay.h>
> +#include <linux/dmi.h>
> +#include <linux/hwmon.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/units.h>
> +
> +#define MCHP_SING_IDX			0x0000
> +#define MCHP_EMI0_APPLICATION_ID	0x090C
> +#define MCHP_EMI0_EC_ADDRESS_LSB	0x0902
> +#define MCHP_EMI0_EC_ADDRESS_MSB	0x0903
> +#define MCHP_EMI0_EC_DATA_BYTE0		0x0904
> +#define MCHP_EMI0_EC_DATA_BYTE1		0x0905
> +#define MCHP_EMI0_EC_DATA_BYTE2		0x0906
> +#define MCHP_EMI0_EC_DATA_BYTE3		0x0907
> +

The driver should reserve this i/o space using devm_request_region() or
similar to ensure that it is not used by other drivers. It should also
use acpi_check_resource_conflict() to ensure that there is no resource
conflict with ACPI.

> +#define io_write8(a, b)	outb_p(b, a)
> +#define io_read8(a)	inb_p(a)
> +
> +static inline uint8_t
> +get_ec_reg(unsigned char page, unsigned char index)

Unnecessary line break

> +{
> +	u8 onebyte;
> +	unsigned short m_index;
> +	unsigned short phy_index = page * 256 + index;
> +
> +	io_write8(MCHP_EMI0_APPLICATION_ID, 0x01);
> +
> +	m_index = phy_index & 0x7FFC;
> +	io_write8(MCHP_EMI0_EC_ADDRESS_LSB, m_index);
> +	io_write8(MCHP_EMI0_EC_ADDRESS_MSB, m_index >> 8);
> +
> +	switch (phy_index & 0x0003) {
> +	case 0:
> +		onebyte = io_read8(MCHP_EMI0_EC_DATA_BYTE0);
> +		break;
> +	case 1:
> +		onebyte = io_read8(MCHP_EMI0_EC_DATA_BYTE1);
> +		break;
> +	case 2:
> +		onebyte = io_read8(MCHP_EMI0_EC_DATA_BYTE2);
> +		break;
> +	case 3:
> +		onebyte = io_read8(MCHP_EMI0_EC_DATA_BYTE3);
> +		break;
> +	}

Why not just something like the following ?
	io_read8(MCHP_EMI0_EC_DATA_BYTE0 + (index & 3));

> +
> +	io_write8(MCHP_EMI0_APPLICATION_ID, 0x01);  /* write same data to clean */

That comment doesn't explain anything. What is "same data" ?
"write 0x01 again to clean" would be more useful if that is what it means.

> +	return onebyte;
> +}
> +
> +static const char * const systems[] = {
> +	"Tomcat",
> +	"Hornet",
> +	"Falcon",
> +	"Manta_",
> +};
> +
> +static const char * const lenovo_px_ec_temp_label[] = {
> +	"CPU1",
> +	"CPU2",
> +	"R_DIMM1",
> +	"L_DIMM1",
> +	"R_DIMM2",
> +	"L_DIMM2",
> +	"PCH",
> +	"M2_R",
> +	"M2_Z1R",
> +	"M2_Z2R",
> +	"PCI_Z1",
> +	"PCI_Z2",
> +	"PCI_Z3",
> +	"PCI_Z4",
> +	"AMB",
> +};
> +
> +static const char * const lenovo_gen_ec_temp_label[] = {
> +	"CPU1",
> +	"N/A",
> +	"R_DIMM",
> +	"L_DIMM",
> +	"N/A",
> +	"N/A",
> +	"PCH",
> +	"M2_R",
> +	"M2_Z1R",
> +	"M2_Z2R",
> +	"PCI_Z1",
> +	"PCI_Z2",
> +	"PCI_Z3",
> +	"PCI_Z4",
> +	"AMB",
> +};
> +
> +static const char * const px_ec_fan_label[] = {
> +	"CPU1_Fan",
> +	"CPU2_Fan",
> +	"Front_Fan1-1",
> +	"Front_Fan1-2",
> +	"Front_Fan2",
> +	"Front_Fan3",
> +	"MEM_Fan1",
> +	"MEM_Fan2",
> +	"Rear_Fan1",
> +	"Rear_Fan2",
> +	"Flex_Bay_Fan1",
> +	"Flex_Bay_Fan2",
> +	"Flex_Bay_Fan2",
> +	"PSU_HDD_Fan",
> +	"PSU1_Fan",
> +	"PSU2_Fan",
> +};
> +
> +static const char * const p7_ec_fan_label[] = {
> +	"CPU1_Fan",
> +	"N/A",
> +	"HP_CPU_Fan1",
> +	"HP_CPU_Fan2",
> +	"PCIE1_4_Fan",
> +	"PCIE5_7_Fan",
> +	"MEM_Fan1",
> +	"MEM_Fan2",
> +	"Rear_Fan1",
> +	"N/A",
> +	"BCB_Fan",
> +	"Flex_Bay_Fan",
> +	"N/A",
> +	"N/A",
> +	"PSU_Fan",
> +	"N/A",
> +};
> +
> +static const char * const p5_ec_fan_label[] = {
> +	"CPU_Fan",
> +	"N/A",
> +	"N/A",
> +	"N/A",
> +	"N/A",
> +	"HDD_Fan",
> +	"Duct_Fan1",
> +	"MEM_Fan",
> +	"Rear_Fan",
> +	"N/A",
> +	"Front_Fan",
> +	"Flex_Bay_Fan",
> +	"N/A",
> +	"N/A",
> +	"PSU_Fan",
> +	"N/A",

If "N/A" means that there are no such sensors, those should not be
instantiated to start with. If the sensors exist but their use is unknown,
there should be no label attribute. The label attribute is supposed to
provide information about _known_ sensors, not some unspecified data.

> +};
> +
> +static const char * const p8_ec_fan_label[] = {
> +	"CPU1_Fan",
> +	"CPU2_Fan",
> +	"HP_CPU_Fan1",
> +	"HP_CPU_Fan2",
> +	"PCIE1_4_Fan",
> +	"PCIE5_7_Fan",
> +	"DIMM1_Fan1",
> +	"DIMM1_Fan2",
> +	"DIMM2_Fan1",
> +	"DIMM2_Fan2",
> +	"Rear_Fan",
> +	"HDD_Bay_Fan",
> +	"Flex_Bay_Fan",
> +	"N/A",
> +	"PSU_Fan",
> +	"N/A",
> +};
> +
> +struct ec_sensors_data {
> +	struct mutex mec_mutex; /* lock for sensors write */

Not really "lock for sensors write", because it is also used
when reading sensor values. More like "lock for sensor access".

> +	u8 platform_id;
> +	const char *const *fan_labels;
> +	const char *const *temp_labels;
> +};
> +
> +static int
> +lenovo_ec_do_read_temp(struct ec_sensors_data *data, u32 attr, int channel, long *val)
> +{
> +	u8   LSB;

Please refrain from using upper case for variables. "lsb" is sufficient.
Use upper case for definitions.

> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		mutex_lock(&data->mec_mutex);
> +		LSB = get_ec_reg(2, 0x81 + channel);
> +		mutex_unlock(&data->mec_mutex);
> +		if (LSB > 0x40)
> +			*val = (LSB - 0x40) * 1000;
> +		else
> +			return -ENODEV;

Wrong return code. This is not "No such device". -EIO, maybe.
Also, error handling comes first.

		if (lsb <= 0x40)
			return -EIO;
		*val = (LSB - 0x40) * 1000;


> +		return 0;
> +	default:
> +		break;
> +	}
> +	return -EOPNOTSUPP;
> +}
> +
> +static int
> +lenovo_ec_do_read_fan(struct ec_sensors_data *data, u32 attr, int channel, long *val)
> +{
> +	u8    LSB, MSB;
> +
> +	channel *= 2;
> +	switch (attr) {
> +	case hwmon_fan_input:
> +		mutex_lock(&data->mec_mutex);
> +		LSB = get_ec_reg(4, 0x60 + channel);
> +		MSB = get_ec_reg(4, 0x61 + channel);
> +		mutex_unlock(&data->mec_mutex);
> +		if (MSB || LSB) {
> +			mutex_lock(&data->mec_mutex);
> +			LSB = get_ec_reg(4, 0x20 + channel);
> +			MSB = get_ec_reg(4, 0x21 + channel);
> +			mutex_unlock(&data->mec_mutex);
> +			*val = (MSB << 8) + LSB;
> +			return 0;
> +		}
> +		return -ENODATA; /* enodata has the sensors tool mark the FAN speed as N/A */

Again, should be reverse

		if (!msb && !lsb)
			return -ENODATA;
		...
		return 0;

Also, please explain this sequence in more detail. It appears that
the data is only valid (for both input and max speed) if at least
one of the registers 0x60/0x61 + channel * 2 is valid. At the same
time, it does not seem to matter if an unspecified amoutn of time passes
between reading those registers and deading the current / max speed.

If this is static, it could be read once. If not, it might make sense
to have a function such as

bool fan_valid(data, channel)
{
	mutex_lock(&data->mec_mutex);
	lsb = get_ec_reg(4, 0x60 + channel);
	lsb = get_ec_reg(4, 0x61 + channel);
	mutex_unlock(&data->mec_mutex);

	return lsb || msb;
}

but then the question is what happens if lsb and lsb are zero
after the second mutex_lock().

> +	case hwmon_fan_max:
> +		mutex_lock(&data->mec_mutex);
> +		LSB = get_ec_reg(4, 0x60 + channel);
> +		MSB = get_ec_reg(4, 0x61 + channel);
> +		mutex_unlock(&data->mec_mutex);
> +		if (MSB || LSB) {
> +			mutex_lock(&data->mec_mutex);
> +			LSB = get_ec_reg(4, 0x40 + channel);
> +			MSB = get_ec_reg(4, 0x41 + channel);
> +			mutex_unlock(&data->mec_mutex);
> +			*val = (MSB << 8) + LSB;
> +		} else {
> +			*val = 0;
> +		}
> +		return 0;
> +	case hwmon_fan_min:
> +	case hwmon_fan_div:
> +	case hwmon_fan_alarm:
> +		break;
> +	default:
> +		break;
> +	}
> +	return -EOPNOTSUPP;
> +}
> +
> +static int get_platform(struct ec_sensors_data *data)
> +{
> +	char system_type[6];
> +	int ret = -1;

Consider returning a valid error code.

> +	int idx;
> +
> +	for (idx = 0 ; idx < 6 ; idx++) {
> +		mutex_lock(&data->mec_mutex);
> +		system_type[idx] = get_ec_reg(0xC, 0x10 + idx);
> +		mutex_unlock(&data->mec_mutex);
> +	}

What is the point of the repeated lock / unlock sequence ? get_platform()
is only called from the probe function, so I don't see why locking
would be necessary to start with. Even if it is necessary, I don't see
why it would make sense to lock for each read instead of for the entire
loop.

> +
> +	for (idx = 0 ; idx < 4 ; idx++) {
> +		if (!strncmp(systems[idx], system_type, 6)) {
> +			ret = idx;
> +			break;
> +		}
> +	}

In my opinion it would make much more sense to declare system_type as
	char system_type[7];
zero-terminate it, and change the code to

	for (idx = 0 ; idx < 4 ; idx++) {
		if (!strcmp(systems[idx], system_type))
			return idx;
	}

	dev_err(dev, "Unsupported ThinkStation Model %s", system_type);
	return -ENODEV;

> +	return ret;
> +}
> +
> +static int
> +lenovo_ec_hwmon_read_string(struct device *dev, enum hwmon_sensor_types type,
> +			    u32 attr, int channel, const char **str)
> +{
> +	struct ec_sensors_data *state = dev_get_drvdata(dev);
> +
> +	switch (type) {
> +	case hwmon_temp:
> +		*str = state->temp_labels[channel];
> +		break;
> +
> +	case hwmon_fan:
> +		*str = state->fan_labels[channel];
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +	return 0;
> +}
> +
> +static int
> +lenovo_ec_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> +		     u32 attr, int channel, long *val)
> +{
> +	struct ec_sensors_data *data = dev_get_drvdata(dev);
> +
> +	switch (type) {
> +	case hwmon_temp:
> +		return lenovo_ec_do_read_temp(data, attr, channel, val);
> +	case hwmon_fan:
> +		return lenovo_ec_do_read_fan(data, attr, channel, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static umode_t
> +lenovo_ec_hwmon_is_visible(const void *data, enum hwmon_sensor_types type,
> +			   u32 attr, int channel)
> +{
> +	switch (type) {
> +	case hwmon_temp:
> +		if (attr == hwmon_temp_input || attr == hwmon_temp_label)
> +			return 0444;
> +		break;
> +	case hwmon_fan:
> +		if (attr == hwmon_fan_input || attr == hwmon_fan_max || attr == hwmon_fan_label)
> +			return 0444;
> +		break;
> +	default:
> +		return 0;
> +	}
> +	return 0;
> +}
> +
> +static const struct hwmon_channel_info *lenovo_ec_hwmon_info[] = {
> +	HWMON_CHANNEL_INFO(temp,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL),
> +	HWMON_CHANNEL_INFO(fan,
> +			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
> +			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
> +			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
> +			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
> +			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
> +			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
> +			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
> +			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
> +			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
> +			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
> +			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
> +			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
> +			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
> +			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
> +			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
> +			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX),
> +	NULL
> +};
> +
> +static const struct hwmon_ops lenovo_ec_hwmon_ops = {
> +	.is_visible = lenovo_ec_hwmon_is_visible,
> +	.read = lenovo_ec_hwmon_read,
> +	.read_string = lenovo_ec_hwmon_read_string,
> +};
> +
> +static struct hwmon_chip_info lenovo_ec_chip_info = {
> +	.ops = &lenovo_ec_hwmon_ops,
> +	.info = lenovo_ec_hwmon_info,
> +};
> +
> +static int lenovo_ec_probe(struct platform_device *pdev)
> +{
> +	struct device *hwdev;
> +	struct ec_sensors_data *ec_data;
> +	const struct hwmon_chip_info *chip_info;
> +	struct device *dev = &pdev->dev;
> +
> +	ec_data = devm_kzalloc(dev, sizeof(struct ec_sensors_data), GFP_KERNEL);
> +	if (!ec_data)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(dev, ec_data);
> +
> +	chip_info = &lenovo_ec_chip_info;
> +
> +	mutex_init(&ec_data->mec_mutex);
> +
> +	mutex_lock(&ec_data->mec_mutex);
> +	if (io_read8(MCHP_EMI0_APPLICATION_ID) != 0) { /* check EMI Application BIT */

This checks a byte, though, not a bit.

> +		io_write8(0x90C, io_read8(0x90C)); /* set EMI Application BIT to 0 */

Writing the value read from 0x90C back to 0x90C does that ?
I mean, I have no choice but to believe that, but it seems odd.

Also, why not use MCHP_EMI0_APPLICATION_ID instead of 0x90C,
and why read the value twice ? Or, in other words, why not
something like the following and a comment explaining what
this actually does and why it is needed.

	app_id = io_read8(MCHP_EMI0_APPLICATION_ID);
	if (app_id)
		io_write8(MCHP_EMI0_APPLICATION_ID, app_id);

As a general comment, I hope this code works on _all_ thinkstations,
not only on the ones supported by this driver. 

> +	}
> +	io_write8(MCHP_EMI0_EC_ADDRESS_LSB, MCHP_SING_IDX);
> +	io_write8(MCHP_EMI0_EC_ADDRESS_MSB, MCHP_SING_IDX >> 8);
> +	mutex_unlock(&ec_data->mec_mutex);

What is the purpose of those locks ? Even if they were needed,
this being the probe function, what would prevent other code
from stepping in after the mutex_unlock() and changing the content
of MCHP_EMI0_EC_DATA_BYTE[0123] ?

> +
> +	if ((io_read8(MCHP_EMI0_EC_DATA_BYTE0) == 'M') &&
> +	    (io_read8(MCHP_EMI0_EC_DATA_BYTE1) == 'C') &&
> +	    (io_read8(MCHP_EMI0_EC_DATA_BYTE2) == 'H') &&
> +	    (io_read8(MCHP_EMI0_EC_DATA_BYTE3) == 'P')) {

Error handling should be first.

	if ((io_read8(MCHP_EMI0_EC_DATA_BYTE0) != 'M') ||
	    (io_read8(MCHP_EMI0_EC_DATA_BYTE1) != 'C') ||
	    (io_read8(MCHP_EMI0_EC_DATA_BYTE2) != 'H') ||
	    (io_read8(MCHP_EMI0_EC_DATA_BYTE3) != 'P')) {
		return -ENODEV;
	
	ec_data->platform_id = get_platform(ec_data);
	...

platform_id is defined as u8. While this technically works
because the returned -1 is converted to 0xff or 255, it is still
incorrect.

> +		switch (ec_data->platform_id) {
> +		case 0:
> +			ec_data->fan_labels = px_ec_fan_label;
> +			ec_data->temp_labels = lenovo_px_ec_temp_label;
> +			break;
> +		case 1:
> +			ec_data->fan_labels = p7_ec_fan_label;
> +			ec_data->temp_labels = lenovo_gen_ec_temp_label;
> +			break;
> +		case 2:
> +			ec_data->fan_labels = p5_ec_fan_label;
> +			ec_data->temp_labels = lenovo_gen_ec_temp_label;
> +			break;
> +		case 3:
> +			ec_data->fan_labels = p8_ec_fan_label;
> +			ec_data->temp_labels = lenovo_gen_ec_temp_label;
> +			break;
> +		default:
> +			dev_err(dev, "Unsupported ThinkStation Model");
> +			return -EINVAL;

			return -ENODEV;

> +		}
> +
> +		hwdev = devm_hwmon_device_register_with_info(dev, "lenovo_ec",
> +							     ec_data,
> +							     chip_info, NULL);
> +
> +		return PTR_ERR_OR_ZERO(hwdev);
> +	}
> +	return -ENODEV;
> +}
> +
> +static struct platform_driver lenovo_ec_sensors_platform_driver = {
> +	.driver = {
> +		.name	= "lenovo-ec-sensors",
> +	},
> +	.probe = lenovo_ec_probe,
> +};
> +
> +static struct platform_device *lenovo_ec_sensors_platform_device;
> +
> +static int __init lenovo_ec_init(void)
> +{
> +	char const *s;
> +
> +	s = dmi_get_system_info(DMI_PRODUCT_NAME);
> +	if (s && !(strncasecmp(s, "ThinkStation", 12))) {

Unnecessary () around strncasecmp()

> +		lenovo_ec_sensors_platform_device =
> +			platform_create_bundle(&lenovo_ec_sensors_platform_driver,
> +					       lenovo_ec_probe, NULL, 0, NULL, 0);
> +

The i/o resource should be assigned and validated here,
and be reserved in the probe function.

> +		if (IS_ERR(lenovo_ec_sensors_platform_device))
> +			return PTR_ERR(lenovo_ec_sensors_platform_device);
> +
> +		return 0;
> +	}
> +	return -ENODEV;

Again, error handling first.

	if (!s || strncasecmp(s, "ThinkStation", 12))
		return -ENODEV;
	...

> +}
> +
> +static void __exit lenovo_ec_exit(void)
> +{
> +	platform_device_unregister(lenovo_ec_sensors_platform_device);
> +	platform_driver_unregister(&lenovo_ec_sensors_platform_driver);
> +}
> +
> +module_init(lenovo_ec_init);
> +module_exit(lenovo_ec_exit);
> +
> +MODULE_AUTHOR("David Ober <dober@lenovo.com>");
> +MODULE_DESCRIPTION("HWMON driver for MEC172x EC sensors on LENOVO motherboards");
> +MODULE_LICENSE("GPL");

