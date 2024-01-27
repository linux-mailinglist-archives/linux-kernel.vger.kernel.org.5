Return-Path: <linux-kernel+bounces-41322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8333483EEC8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3F7FB21333
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D61F2C6B9;
	Sat, 27 Jan 2024 16:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfMiPTPy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91FE2C856;
	Sat, 27 Jan 2024 16:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706374084; cv=none; b=oXhzk9L2fWstZIM6k7+8DsLeTwhZnsMCWiIFxFcSB2TdcVpeLe29+FEoA0NcUXDRn38OmAV9KGNpnL4QEos0Sem813K0Pse7Obay1m7ca6sKDhpA6zyw7uzGLjIkkDU4NtBdxSTl3mD8qWF2gxqzWCmxGySyRG6qhbxQjgbQk7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706374084; c=relaxed/simple;
	bh=q/4V6+CHHEyx3qZ1nXC9RESo9GGzm7+BJdPYTep/ZPc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QNR44HQhn2BttwvjWyUQIiXVu+CPZ4n4OM6yq+oDC+ztB1W0Pf7kmNHhQxvHZQ944bF/QAzsESrDkswZ87njCZMd6oIbak7hMFmkOrATCq7S27JEthOtKoFGQFkeFKImdHsXhDZetfLMmbF1SX2bPl0t0GRqnw/OtTh/m0ISHgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfMiPTPy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049D4C433F1;
	Sat, 27 Jan 2024 16:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706374084;
	bh=q/4V6+CHHEyx3qZ1nXC9RESo9GGzm7+BJdPYTep/ZPc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OfMiPTPylcmgWGePawbGBjH9q3fKwmRPgxYOYCqu3vSjZbQXoAlwQx4Gdk2RnWbqW
	 Ta1hE6Yaxyceip7mURiAa1orUlQuyqWFNWQuwYK06B0V8Ugpn0r9CAUu5YjvQvZb9y
	 tz5XiRdjm4IwNtiLaZ7cdc91UpbhBSTsFPD55N/z+pFSzsSzsgGG5f/M59xFqbQ4bD
	 KTU8FocSf1Loy4R5FaFgN6e8++yh5GvaC/z9w317r6vxwRC1v62/zD8F9+gHS9kQ7B
	 PNp4D0VDQvof/8wKIhQtwqmkBn8tLqIYCFYkRnhV5POjek9vbhDmkGYDUe2FlcjuQJ
	 zMTsbxjZ6s7tw==
Date: Sat, 27 Jan 2024 16:47:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: <marius.cristea@microchip.com>
Cc: <lars@metafoo.de>, <robh+dt@kernel.org>, <jdelvare@suse.com>,
 <linux@roeck-us.net>, <linux-hwmon@vger.kernel.org>,
 <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] iio: adc: adding support for PAC193x
Message-ID: <20240127164749.00d97fd7@jic23-huawei>
In-Reply-To: <20240122084712.11507-3-marius.cristea@microchip.com>
References: <20240122084712.11507-1-marius.cristea@microchip.com>
	<20240122084712.11507-3-marius.cristea@microchip.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jan 2024 10:47:12 +0200
<marius.cristea@microchip.com> wrote:

> From: Marius Cristea <marius.cristea@microchip.com>
> 
> This is the iio driver for Microchip
> PAC193X series of Power Monitor with Accumulator chip family.
> 
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
Hi Marius,

A few small things inline

Thanks,

Jonathan

> ---
>  .../ABI/testing/sysfs-bus-iio-adc-pac1934     |    9 +
>  MAINTAINERS                                   |    7 +
>  drivers/iio/adc/Kconfig                       |   12 +
>  drivers/iio/adc/Makefile                      |    1 +
>  drivers/iio/adc/pac1934.c                     | 1646 +++++++++++++++++
>  5 files changed, 1675 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-pac1934
>  create mode 100644 drivers/iio/adc/pac1934.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1934 b/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1934
> new file mode 100644
> index 000000000000..28a2d4283938
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1934
> @@ -0,0 +1,9 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/in_shunt_resistor_Y
For consistency with channels etc, I think
in_shunt_resistorY is more consistent.

> +KernelVersion:	6.7
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		The value of the shunt resistor may be known only at runtime
> +		and set by a client application. This attribute allows to
> +		set its value in micro-ohms. X is the IIO index of the device.
> +		Y is the channel number. The value is used to calculate
> +		current, power and accumulated energy.
..

> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 3b73c509bd68..5d2d3a45a7be 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -930,6 +930,18 @@ config NPCM_ADC
>  	  This driver can also be built as a module. If so, the module
>  	  will be called npcm_adc.
>  
> +config PAC1934
> +	tristate "Microchip Technology PAC1934 driver"
> +	depends on I2C
> +	depends on IIO

It's in the IIO menu under an if IIO, so this should not be needed.

> +	help
> +	  Say yes here to build support for Microchip Technology's PAC1931,
> +	  PAC1932, PAC1933, PAC1934 Single/Multi-Channel Power Monitor with
> +	  Accumulator.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called pac1934.

> diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
> new file mode 100644
> index 000000000000..b1a6f9f87817
> --- /dev/null
> +++ b/drivers/iio/adc/pac1934.c
> @@ -0,0 +1,1646 @@
..

> +
> +#include <linux/acpi.h>
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <asm/unaligned.h>
> +
> +#include <linux/device.h>
Why is this one not in the set above?
It's an unusual one to pull out of the main include block.

> +

> +
> +#define PAC1934_DEFAULT_CHIP_SAMP_SPEED		1024
Small thing, but if a name like this indicates units that is always helpful to the
reader _HZ maybe?

> +/*
> + * these indexes are exactly describing the element order within a single
> + * PAC1934 phys channel IIO channel descriptor; see the static const struct
> + * iio_chan_spec pac1934_single_channel[] declaration
> + */
> +enum pac1934_ch_idx {
> +	IIO_EN,
> +	IIO_POW,
> +	IIO_VOLT,
> +	IIO_CRT,
> +	IIO_VOLTAVG,
> +	IIO_CRTAVG
Don't use an IIO prefix for these as anyone seeing them being used inline will think they
are subsystem wise.
PAC1934_CH_ENERGY
etc. It's worth burning a few characters to make the code easier to understand.

> +};

> +
> +static int pac1934_match_samp_rate(struct pac1934_chip_info *info, u32 new_samp_rate)
> +{
> +	int cnt;
> +
> +	for (cnt = 0; cnt < ARRAY_SIZE(samp_rate_map_tbl); cnt++) {
> +		if (new_samp_rate == samp_rate_map_tbl[cnt]) {
> +			info->crt_samp_spd_bitfield = cnt;

Return this - don't hide away an internal state update inside a matching function.
It's not something a reader will expect to be happening so makes review harder

> +			return 0;
> +		}
> +	}
> +
> +	/* not a valid sample rate value */
> +	return -EINVAL;
> +}


..

> +
> +static int pac1934_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct pac1934_chip_info *info = iio_priv(indio_dev);
> +	struct i2c_client *client = info->client;
> +	int ret = -EINVAL;
> +	s32 old_samp_rate;
> +	u8 ctrl_reg;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = pac1934_match_samp_rate(info, val);
> +		if (ret)
> +			return ret;
> +
> +		old_samp_rate = info->sample_rate_value;
> +		info->sample_rate_value = val;

Why not just update it after succeeding rather than update the cached value
with a chance of having to revert that.  Note that you shouldn't update
 the info->crt_samp_spd_bitfield value either until the write succeeds.
(if it has an purpose after that - if not don't have it in info).

> +
> +		/* write the new sampling value and trigger a snapshot(incl refresh) */
> +		scoped_guard(mutex, &info->lock) {
> +			ctrl_reg = FIELD_PREP(PAC1934_CRTL_SAMPLE_RATE_MASK,
> +					      info->crt_samp_spd_bitfield);
> +			ret = i2c_smbus_write_byte_data(client, PAC1934_CTRL_REG_ADDR, ctrl_reg);
> +			if (ret) {
> +				dev_err(&client->dev,
> +					"%s - can't update sample rate\n",
> +					__func__);
> +				info->sample_rate_value = old_samp_rate;
> +				return ret;
> +			}
> +		}
> +
> +		/*
> +		 * now, force a snapshot with refresh - call retrieve
> +		 * data in order to update the refresh timer
> +		 * alter the timestamp in order to force trigger a
> +		 * register snapshot and a timestamp update
> +		 */
> +		info->tstamp -= msecs_to_jiffies(PAC1934_MIN_POLLING_TIME_MS);
> +		ret = pac1934_retrieve_data(info, (1024 / old_samp_rate) * 1000);
> +		if (ret < 0) {
> +			dev_err(&client->dev,
> +				"%s - cannot snapshot ctrl and measurement regs\n",
> +				__func__);
> +			return ret;
> +		}
> +
> +		return 0;
> +	case IIO_CHAN_INFO_ENABLE:
> +		scoped_guard(mutex, &info->lock) {
> +			info->enable_energy[chan->channel - 1] = val ? true : false;
> +			info->chip_reg_data.energy_sec_acc[chan->channel - 1] = 0;
> +		}
> +
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
..

> +/*
> + * documentation related to the ACPI device definition
> + * https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ApplicationNotes/ApplicationNotes/PAC1934-Integration-Notes-for-Microsoft-Windows-10-and-Windows-11-Driver-Support-DS00002534.pdf
> + */
> +static bool pac1934_acpi_parse_channel_config(struct i2c_client *client,
> +					      struct pac1934_chip_info *info)
> +{
> +	acpi_handle handle;
> +	union acpi_object *rez;
> +	struct device *dev = &client->dev;
> +	unsigned short bi_dir_mask;
> +	int idx, i;
> +	guid_t guid;
> +	const struct acpi_device_id *id;
> +
> +	handle = ACPI_HANDLE(&client->dev);
> +
> +	id = acpi_match_device(dev->driver->acpi_match_table, dev);

I'd like to see a comment on why we might fail to match here.
(I think someone using PRP0001 is the only path I can think of).

> +	if (!id)
> +		return false;
> +
> +	guid_parse(PAC1934_DSM_UUID, &guid);
> +
> +	rez = acpi_evaluate_dsm(handle, &guid, 0, PAC1934_ACPI_GET_NAMES_AND_MOHMS_VALS, NULL);
> +	if (!rez)
> +		return false;
> +
> +	for (i = 0; i < rez->package.count; i += 2) {
> +		idx = i / 2;
> +		info->labels[idx] =
> +			devm_kmemdup(&client->dev, rez->package.elements[i].string.pointer,
> +				     (size_t)rez->package.elements[i].string.length + 1,
> +				     GFP_KERNEL);
> +		info->labels[idx][rez->package.elements[i].string.length] = '\0';
> +		info->shunts[idx] =
> +			rez->package.elements[i + 1].integer.value * 1000;
> +		info->active_channels[idx] = (info->shunts[idx] != 0);
> +	}
> +
> +	ACPI_FREE(rez);
> +
> +	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1934_ACPI_GET_UOHMS_VALS, NULL);
> +	if (!rez) {
> +		/*
> +		 * initializing with default values
> +		 * we assume all channels are unidirectional(the mask is zero)
> +		 * and assign the default sampling rate
> +		 */
> +		info->sample_rate_value = PAC1934_DEFAULT_CHIP_SAMP_SPEED;
> +		return true;
> +	}
> +
> +	for (i = 0; i < rez->package.count; i++) {
> +		idx = i;
> +		info->shunts[idx] = rez->package.elements[i].integer.value;
> +		info->active_channels[idx] = (info->shunts[idx] != 0);
> +	}
> +
> +	ACPI_FREE(rez);
> +
> +	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1934_ACPI_GET_BIPOLAR_SETTINGS, NULL);
> +	if (!rez)
> +		return false;
> +
> +	bi_dir_mask = rez->package.elements[0].integer.value;
> +	info->bi_dir[0] = ((bi_dir_mask & (1 << 3)) | (bi_dir_mask & (1 << 7))) != 0;
> +	info->bi_dir[1] = ((bi_dir_mask & (1 << 2)) | (bi_dir_mask & (1 << 6))) != 0;
> +	info->bi_dir[2] = ((bi_dir_mask & (1 << 1)) | (bi_dir_mask & (1 << 5))) != 0;
> +	info->bi_dir[3] = ((bi_dir_mask & (1 << 0)) | (bi_dir_mask & (1 << 4))) != 0;
> +
> +	ACPI_FREE(rez);
> +
> +	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1934_ACPI_GET_SAMP, NULL);
> +	if (!rez)
> +		return false;
> +
> +	info->sample_rate_value = rez->package.elements[0].integer.value;
> +
> +	ACPI_FREE(rez);
> +
> +	return true;
> +}

> +
> +static int pac1934_chip_configure(struct pac1934_chip_info *info)
> +{
> +	int cnt, ret;
> +	struct i2c_client *client = info->client;
> +	u8 regs[PAC1934_CTRL_STATUS_INFO_LEN], idx, ctrl_reg;
> +	u32 wait_time;
> +
> +	info->chip_reg_data.num_enabled_channels = 0;
> +	for (cnt = 0;  cnt < info->phys_channels; cnt++) {
> +		if (info->active_channels[cnt])
> +			info->chip_reg_data.num_enabled_channels++;
> +	}
> +
> +	/*
> +	 * read whatever information was gathered before the driver was loaded
> +	 * establish which channels are enabled/disabled and then establish the
> +	 * information retrieval mode (using SKIP or no).
> +	 * Read the chip ID values
> +	 */
> +	ret = i2c_smbus_read_i2c_block_data(client, PAC1934_CTRL_STAT_REGS_ADDR,
> +					    ARRAY_SIZE(regs),
> +					    (u8 *)regs);
> +	if (ret < 0) {
> +		dev_err_probe(&client->dev, ret,
> +			      "%s - cannot read regs from 0x%02X\n",
> +			      __func__, PAC1934_CTRL_STAT_REGS_ADDR);
> +		return ret;
> +	}
> +
> +	/* write the CHANNEL_DIS and the NEG_PWR registers */
> +	regs[PAC1934_CHANNEL_DIS_REG_OFF] =
> +		FIELD_PREP(PAC1934_CHAN_DIS_CH1_OFF_MASK, !(info->active_channels[0])) |
> +		FIELD_PREP(PAC1934_CHAN_DIS_CH2_OFF_MASK, !(info->active_channels[1])) |
> +		FIELD_PREP(PAC1934_CHAN_DIS_CH3_OFF_MASK, !(info->active_channels[2])) |
> +		FIELD_PREP(PAC1934_CHAN_DIS_CH4_OFF_MASK, !(info->active_channels[3])) |
> +		FIELD_PREP(PAC1934_SMBUS_TIMEOUT_MASK, 0) |
> +		FIELD_PREP(PAC1934_SMBUS_BYTECOUNT_MASK, 0) |
> +		FIELD_PREP(PAC1934_SMBUS_NO_SKIP_MASK, 0);
> +
> +	regs[PAC1934_NEG_PWR_REG_OFF] =
> +		FIELD_PREP(PAC1934_NEG_PWR_CH1_BIDI_MASK, info->bi_dir[0]) |
> +		FIELD_PREP(PAC1934_NEG_PWR_CH2_BIDI_MASK, info->bi_dir[1]) |
> +		FIELD_PREP(PAC1934_NEG_PWR_CH3_BIDI_MASK, info->bi_dir[2]) |
> +		FIELD_PREP(PAC1934_NEG_PWR_CH4_BIDI_MASK, info->bi_dir[3]) |
> +		FIELD_PREP(PAC1934_NEG_PWR_CH1_BIDV_MASK, info->bi_dir[0]) |
> +		FIELD_PREP(PAC1934_NEG_PWR_CH2_BIDV_MASK, info->bi_dir[1]) |
> +		FIELD_PREP(PAC1934_NEG_PWR_CH3_BIDV_MASK, info->bi_dir[2]) |
> +		FIELD_PREP(PAC1934_NEG_PWR_CH4_BIDV_MASK, info->bi_dir[3]);
> +
> +	/* no SLOW triggered REFRESH, clear POR */
> +	regs[PAC1934_SLOW_REG_OFF] = 0;
> +
> +	ret =  i2c_smbus_write_block_data(client, PAC1934_CTRL_STAT_REGS_ADDR,
> +					  ARRAY_SIZE(regs), (u8 *)regs);
> +	if (ret)
> +		return ret;
> +
> +	ctrl_reg = FIELD_PREP(PAC1934_CRTL_SAMPLE_RATE_MASK, info->crt_samp_spd_bitfield);
> +
> +	ret = i2c_smbus_write_byte_data(client, PAC1934_CTRL_REG_ADDR, ctrl_reg);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * send a REFRESH to the chip, so the new settings take place
> +	 * as well as resetting the accumulators
> +	 */
> +	ret = i2c_smbus_write_byte(client, PAC1934_REFRESH_REG_ADDR);
> +	if (ret) {
> +		dev_err(&client->dev,
> +			"%s - cannot send 0x%02X\n",
> +			__func__, PAC1934_REFRESH_REG_ADDR);
> +		return ret;
> +	}
> +
> +	/*
> +	 * get the current(in the chip) sampling speed and compute the
> +	 * required timeout based on its value
> +	 * the timeout is 1/sampling_speed
> +	 */
> +	idx = regs[PAC1934_CTRL_ACT_REG_OFF] >> PAC1934_SAMPLE_RATE_SHIFT;
> +	wait_time = (1024 / samp_rate_map_tbl[idx]) * 1000;
> +
> +	/*
> +	 * wait the maximum amount of time to be on the safe side
> +	 * the maximum wait time is for 8sps
> +	 */
> +	usleep_range(wait_time, wait_time + 100);
> +
> +	INIT_DELAYED_WORK(&info->work_chip_rfsh, pac1934_work_periodic_rfsh);
> +	/* Setup the latest moment for reading the regs before saturation */
> +	schedule_delayed_work(&info->work_chip_rfsh,
> +			      msecs_to_jiffies(PAC1934_MAX_RFSH_LIMIT_MS));
> +
> +	devm_add_action_or_reset(&client->dev, pac1934_cancel_delayed_work,
> +				 &info->work_chip_rfsh);

Can fail.  Check the return value (it's very unlikely to fail but good practice
to check it anyway).

> +
> +	return 0;
> +}
> +
> +static int pac1934_prep_iio_channels(struct pac1934_chip_info *info, struct iio_dev *indio_dev)
> +{
> +	struct i2c_client *client;
> +	struct iio_chan_spec *ch_sp;
> +	int channel_size, attribute_count, cnt;
> +	void *dyn_ch_struct, *tmp_data;
> +
> +	client = info->client;

Only used to get to client->dev.  A struct device *dev = &info->client.dev;
would be more useful in making the code more readable.

> +
> +	/* find out dynamically how many IIO channels we need */
> +	attribute_count = 0;
> +	channel_size = 0;
> +	for (cnt = 0; cnt < info->phys_channels; cnt++) {
> +		if (!info->active_channels[cnt])
> +			continue;
> +
> +		/* add the size of the properties of one chip physical channel */
> +		channel_size += sizeof(pac1934_single_channel);
> +		/* count how many enabled channels we have */
> +		attribute_count += ARRAY_SIZE(pac1934_single_channel);
> +		dev_info(&client->dev, ":%s: Channel %d active\n",
> +			 __func__, cnt + 1);
> +	}
> +
> +	dyn_ch_struct = devm_kzalloc(&client->dev, channel_size, GFP_KERNEL);
> +	if (!dyn_ch_struct)
> +		return -EINVAL;
> +
> +	tmp_data = dyn_ch_struct;
> +
> +	/* populate the dynamic channels and make all the adjustments */
> +	for (cnt = 0; cnt < info->phys_channels; cnt++) {
> +		if (!info->active_channels[cnt])
> +			continue;
> +
> +		memcpy(tmp_data, pac1934_single_channel, sizeof(pac1934_single_channel));
> +		ch_sp = (struct iio_chan_spec *)tmp_data;
> +		ch_sp[IIO_EN].channel = cnt + 1;
> +		ch_sp[IIO_EN].scan_index = cnt;
> +		ch_sp[IIO_EN].address = cnt + PAC1934_VPOWER_ACC_1_ADDR;
> +		ch_sp[IIO_POW].channel = cnt + 1;
> +		ch_sp[IIO_POW].scan_index = cnt;
> +		ch_sp[IIO_POW].address = cnt + PAC1934_VPOWER_1_ADDR;
> +		ch_sp[IIO_VOLT].channel = cnt + 1;
> +		ch_sp[IIO_VOLT].scan_index = cnt;
> +		ch_sp[IIO_VOLT].address = cnt + PAC1934_VBUS_1_ADDR;
> +		ch_sp[IIO_CRT].channel = cnt + 1;
> +		ch_sp[IIO_CRT].scan_index = cnt;
> +		ch_sp[IIO_CRT].address = cnt + PAC1934_VSENSE_1_ADDR;
> +		/*
> +		 * In order to be able to use labels for IIO_VOLT and IIO_VOLTAVG,
> +		 * respectively IIO_CRT and IIO_CRTAVG we need to use different
> +		 * channel numbers. We will add  +5 (+1 to maximum PAC channels).
> +		 */
> +		ch_sp[IIO_VOLTAVG].channel = cnt + 5;
> +		ch_sp[IIO_VOLTAVG].scan_index = cnt;
> +		ch_sp[IIO_VOLTAVG].address = cnt + PAC1934_VBUS_AVG_1_ADDR;
> +		ch_sp[IIO_CRTAVG].channel = cnt + 5;
> +		ch_sp[IIO_CRTAVG].scan_index = cnt;
> +		ch_sp[IIO_CRTAVG].address = cnt + PAC1934_VSENSE_AVG_1_ADDR;
> +
> +		/*
> +		 * now modify the parameters in all channels if the
> +		 * whole chip rail(channel) is bi-directional
> +		 */
> +		if (info->bi_dir[cnt]) {
> +			ch_sp[IIO_EN].scan_type.sign = 's';
> +			ch_sp[IIO_EN].scan_type.realbits = 47;
> +			ch_sp[IIO_POW].scan_type.sign = 's';
> +			ch_sp[IIO_POW].scan_type.realbits = 27;
> +			ch_sp[IIO_VOLT].scan_type.sign = 's';
> +			ch_sp[IIO_VOLT].scan_type.realbits = 15;
> +			ch_sp[IIO_CRT].scan_type.sign = 's';
> +			ch_sp[IIO_CRT].scan_type.realbits = 15;
> +			ch_sp[IIO_VOLTAVG].scan_type.sign = 's';
> +			ch_sp[IIO_VOLTAVG].scan_type.realbits = 15;
> +			ch_sp[IIO_CRTAVG].scan_type.sign = 's';
> +			ch_sp[IIO_CRTAVG].scan_type.realbits = 15;
> +		}
> +		tmp_data += sizeof(pac1934_single_channel);
> +	}
> +
> +	/*
> +	 * send the updated dynamic channel structure information towards IIO
> +	 * prepare the required field for IIO class registration
> +	 */
> +	indio_dev->num_channels = attribute_count;
> +
> +	indio_dev->channels = (const struct iio_chan_spec *)dyn_ch_struct;
> +
> +	if (!indio_dev->channels)

How could this condition be hit?

> +		return -EINVAL;
> +
> +	return 0;
> +}

..

> +static void pac1934_mutex_destroy(void *data)
> +{
> +	struct mutex *lock = data;
> +
> +	mutex_destroy(lock);

I'm of the school of thought that it's not worth destroying mutexes if we aren't
dealing with a situation where we have complex lifetimes for the containing structure.

I don't feel that strongly about it and would like the devm_mutex_init() proposals
to finally go upstream but for now I'd just drop this.

> +}
> +
> +static int pac1934_probe(struct i2c_client *client)
> +{
> +	struct pac1934_chip_info *info;
> +	const struct pac1934_features *chip;
> +	struct iio_dev *indio_dev;
> +	int cnt, ret;
> +	bool match = false;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*info));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	info = iio_priv(indio_dev);
> +
> +	i2c_set_clientdata(client, indio_dev);

Why?  I don't think this is ever read back by your driver
(I might be missing something!)



> +	info->client = client;
> +
> +	/* always start with energy accumulation enabled */
> +	for (cnt = 0; cnt < PAC1934_MAX_NUM_CHANNELS; cnt++)
> +		info->enable_energy[cnt] = true;
> +
> +	info->crt_samp_spd_bitfield = PAC1934_SAMP_1024SPS;
> +
> +	ret = pac1934_chip_identify(info);
> +	if (ret < 0) {
> +		/*
> +		 * If failed to identify the hardware based on internal registers,
> +		 * try using fallback compatible in device tree to deal with some newer part number.

Overly long line and it won't hurt readability to break it.
Try to keep to 80 char limit unless there is a good reason to go longer.

> +		 */
> +		chip = i2c_get_match_data(client);
> +		if (!chip)
> +			return -EINVAL;
> +
> +		info->phys_channels = chip->phys_channels;
> +		indio_dev->name = chip->name;
> +	} else {
> +		info->phys_channels = pac1934_chip_config[ret].phys_channels;
> +		indio_dev->name = pac1934_chip_config[ret].name;
> +	}
> +
> +	if (ACPI_HANDLE(&client->dev))

This gets messy because of PRP0001.  In theory the of_parse routine might be
the right one even though we have an ACPI FW.  I guess that's unlikely enough
that we can just fail to probe if we do.

> +		match = pac1934_acpi_parse_channel_config(client, info);
> +	else
> +		match = pac1934_of_parse_channel_config(client, info);
> +
> +	if (!match) {
> +		dev_dbg(&client->dev, "parameter parsing returned an error\n");
> +		return -EINVAL;
I'd promote this to a
		return dev_err_probe(&client->dev, -EINVAL, "....)

> +	}
> +
> +	mutex_init(&info->lock);
> +	ret = devm_add_action_or_reset(&client->dev, pac1934_mutex_destroy,
> +				       &info->lock);
As already noted, check ret.

> +
> +	/*
> +	 * do now any chip specific initialization (e.g. read/write
> +	 * some registers), enable/disable certain channels, change the sampling
> +	 * rate to the requested value
> +	 */
> +	ret = pac1934_chip_configure(info);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* prepare the channel information */
> +	ret = pac1934_prep_iio_channels(info, indio_dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = pac1934_prep_custom_attributes(info, indio_dev);
> +	if (ret < 0) {
> +		dev_err_probe(&client->dev, ret,
> +			      "Can't configure custom attributes for PAC1934 device\n");
> +		return ret;
		return dev_err_probe()

> +	}
> +
> +	info->iio_info.read_raw = pac1934_read_raw;
> +	info->iio_info.read_avail = pac1934_read_avail;
> +	info->iio_info.write_raw = pac1934_write_raw;
> +	info->iio_info.read_label = pac1934_read_label;

Looks const. If it is, then make it so (look at other drivers for this)

> +
> +	indio_dev->info = &info->iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	/*
> +	 * read whatever has been accumulated in the chip so far
> +	 * and reset the accumulators
> +	 */
> +	ret = pac1934_reg_snapshot(info, true, PAC1934_REFRESH_REG_ADDR,
> +				   PAC1934_MIN_UPDATE_WAIT_TIME_US);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = devm_iio_device_register(&client->dev, indio_dev);
> +	if (ret < 0)
> +		dev_err_probe(&client->dev, ret,
> +			      "Can't register IIO device\n");
Feels odd to not return this
		return dev_err_probe()

	return 0;
> +
> +	return ret;
> +}

> +
> +/* using MCHP1930 to be compatible with BIOS ACPI */

That is apparent from the table. Comment doesn't add anything.
If you have a particular bios to point at that might be useful to mention here.

> +static const struct acpi_device_id pac1934_acpi_match[] = {
> +	{ "MCHP1930", .driver_data = (kernel_ulong_t)&pac1934_chip_config[PAC1934] },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(acpi, pac1934_acpi_match);
> +
> +static struct i2c_driver pac1934_driver = {
> +	.driver	 = {
> +		.name = "pac1934",
> +		.of_match_table = pac1934_of_match,
> +		.acpi_match_table = pac1934_acpi_match
> +		},
Normal style is to align this with . above. E.g.
	},

> +	.probe = pac1934_probe,
> +	.id_table = pac1934_id,
> +};


