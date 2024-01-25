Return-Path: <linux-kernel+bounces-38866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEA983C784
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE01F293850
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3876776906;
	Thu, 25 Jan 2024 16:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="S5L1hga8"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5964373172;
	Thu, 25 Jan 2024 16:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706198833; cv=none; b=iHi5VNiOHZn+W/PVqbIgB8CUqn2si9xfvdbOtsDSO5+yPHcljYEuPirhFOMwJbwEBT/XPeu5em+U7sh+6BR4IUSe468SbzWQW+qreHTWcnvcIk5cSUuJv0lBVYi4AAe9ztygplaahRsPrgzrgIsEV0oRtFS3wR5MVC8tclHO1Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706198833; c=relaxed/simple;
	bh=1R8Tsnw39pDJRDpK6iQc1QiNNzEwa4k5D+wsrAe9HRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+BvpNhjOKpubUUzLjtIaYGGgkY2HKEm6MhMQB13QOqQh5NOLjJFZnnF0JiL5U6dSNK6BFFSIy87p8PmFTInfFrNCWertvWmpWLcz5Ay4uqLw7ueVbdAw/jVJnGgxpEPwPynA0WC0TaNKXR1Z9/NbI/f6Ozkp3ctzTwVXaHhoTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=S5L1hga8; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C67A820002;
	Thu, 25 Jan 2024 16:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706198823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g8O9S6ZCxXvlbxXPVkuBT2M73T4nL1DEMeJ7/7DeNYs=;
	b=S5L1hga8uirymSF7qVywd04XVvAQhEigQFQvMmLPFLvECP6Pv+3LFTjB8kTae7Vfx660hF
	tklxCUF716Cl3E1FhYjOGyF0skgKAawhJHHH4O89ql9ZeMTWKvnA0mRQjAUk1+85M9+wFC
	2V34SEa8bIARm6pVQsR1atg37l76lAKVfZUkksTlyJp0OCfxOkhQWen8FV/isAdEaNmBh4
	xEZY/8B9MgOPShwtyhuHa8Bht/+gIrVgF9j0b3ngSIuQMPm0+uVPJe9gIbSc8QpAed2P0P
	t6q3mbt6igIQ6dE4qNBftV+cKuDZzAqCYLbCsR2/hWOybllNdZi510zjHtnt4A==
Date: Thu, 25 Jan 2024 17:07:01 +0100
From: Kamel Bouhara <kamel.bouhara@bootlin.com>
To: Jeff LaBundy <jeff@labundy.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Marco Felsch <m.felsch@pengutronix.de>,
	catalin.popescu@leica-geosystems.com,
	mark.satterthwaite@touchnetix.com, bartp@baasheep.co.uk,
	hannah.rossiter@touchnetix.com,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	bsp-development.geo@leica-geosystems.com
Subject: Re: [PATCH v5 3/3] Input: Add TouchNetix axiom i2c touchscreen driver
Message-ID: <20240125160701.GB2933@kb-xps>
References: <20231211121430.1689139-1-kamel.bouhara@bootlin.com>
 <20231211121430.1689139-4-kamel.bouhara@bootlin.com>
 <ZY5An58Rffrcpfpn@nixie71>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZY5An58Rffrcpfpn@nixie71>
X-GND-Sasl: kamel.bouhara@bootlin.com

On Thu, Dec 28, 2023 at 09:44:31PM -0600, Jeff LaBundy wrote:
> Hi Kamel,
>

Hello Jeff,

Thanks for your review again and sorry for those late answers below.

..

> +#include <linux/module.h>
> > +#include <linux/of.h>
>
> As I mention in the v3 review, the entire of.h is not necessary in the
> case of this driver; mod_devicetable.h is sufficient. Please see:
>
> dbce1a7d5dce ("Input: Explicitly include correct DT includes")
>

Ok.

> > +
> > +#define AXIOM_PROX_LEVEL		-128
> > +/*
> > + * Register group u31 has 2 pages for usage table entries.
> > + */
> > +#define AXIOM_U31_MAX_USAGES		((2 * AXIOM_COMMS_PAGE_SIZE) / AXIOM_U31_BYTES_PER_USAGE)
> > +#define AXIOM_U31_BYTES_PER_USAGE	6
> > +#define AXIOM_U31_PAGE0_LENGTH		0x0C
> > +#define AXIOM_U31_BOOTMODE_MASK		BIT(7)
> > +#define AXIOM_U31_DEVID_MASK		GENMASK(14, 0)
> > +
> > +#define AXIOM_CMD_HEADER_READ_MASK	BIT(15)
> > +#define AXIOM_U41_MAX_TARGETS		10
> > +
> > +#define AXIOM_U46_AUX_CHANNELS		4
> > +#define AXIOM_U46_AUX_MASK		GENMASK(11, 0)
> > +
> > +#define AXIOM_COMMS_MAX_USAGE_PAGES	3
> > +#define AXIOM_COMMS_PAGE_SIZE		256
> > +#define AXIOM_COMMS_REPORT_LEN_MASK	GENMASK(6, 0)
> > +
> > +#define AXIOM_REPORT_USAGE_ID		0x34
> > +#define AXIOM_DEVINFO_USAGE_ID		0x31
> > +#define AXIOM_USAGE_2HB_REPORT_ID	0x01
> > +#define AXIOM_USAGE_2AUX_REPORT_ID	0x46
> > +#define AXIOM_USAGE_2DCTS_REPORT_ID	0x41
> > +
> > +#define AXIOM_PAGE_OFFSET_MASK		GENMASK(6, 0)
> > +
> > +struct axiom_devinfo {
> > +	u16 device_id;
>
> Assuming this is a packed struct into which data is directly read over
> I2C, this member needs declared as __be16 or __le16 depending on the
> endianness of the device, and then all accesses to it resolved using
> be16_to_cpu() or le16_to_cpu().
>
> > +	u8 fw_minor;
> > +	u8 fw_major;
> > +	u8 fw_info_extra;
> > +	u8 tcp_revision;
> > +	u8 bootloader_fw_minor;
> > +	u8 bootloader_fw_major;
> > +	u16 jedec_id;
>
> And here.
>

Ack and applied to v6, thanks.

> > +	u8 num_usages;
> > +} __packed;
> > +
> > +/*
> > + * Describes parameters of a specific usage, essentially a single element of
> > + * the "Usage Table"
> > + */
> > +struct axiom_usage_entry {
> > +	u8 id;
> > +	u8 is_report;
> > +	u8 start_page;
> > +	u8 num_pages;
> > +};
> > +
> > +/*
> > + * Represents state of a touch or target when detected prior a touch (eg.
> > + * hover or proximity events).
> > + */
>
> Nit: prior to a touch
>

Fixed.

> > +enum axiom_target_state {
> > +	AXIOM_TARGET_STATE_NOT_PRESENT = 0,
> > +	AXIOM_TARGET_STATE_PROX = 1,
> > +	AXIOM_TARGET_STATE_HOVER = 2,
> > +	AXIOM_TARGET_STATE_TOUCHING = 3,
> > +};
> > +
> > +struct axiom_u41_target {
> > +	enum axiom_target_state state;
> > +	u16 x;
> > +	u16 y;
> > +	s8 z;
> > +	bool insert;
> > +	bool touch;
> > +};
> > +
> > +struct axiom_target_report {
> > +	u8 index;
> > +	u8 present;
> > +	u16 x;
> > +	u16 y;
> > +	s8 z;
> > +};
> > +
> > +struct axiom_cmd_header {
> > +	__le16 target_address;
> > +	__le16 length;
> > +} __packed;
> > +
> > +struct axiom_data {
> > +	struct axiom_devinfo devinfo;
> > +	struct device *dev;
> > +	struct gpio_desc *reset_gpio;
> > +	struct i2c_client *client;
> > +	struct input_dev *input_dev;
> > +	u32 max_report_len;
> > +	char rx_buf[AXIOM_COMMS_MAX_USAGE_PAGES * AXIOM_COMMS_PAGE_SIZE];
>
> Please use standard kernel type definitions (e.g. u8).

Applied.

>
> > +	struct axiom_u41_target targets[AXIOM_U41_MAX_TARGETS];
> > +	struct axiom_usage_entry usage_table[AXIOM_U31_MAX_USAGES];
> > +	bool usage_table_populated;
> > +	struct regulator *vdda;
> > +	struct regulator *vddi;
> > +};
> > +
> > +/*
> > + * axiom devices are typically configured to report
> > + * touches at a rate of 100Hz (10ms). For systems
> > + * that require polling for reports.
>
> It's not entirely clear what this is saying; is the first period meant to be
> replaced with a comma? It's also odd to see some comments limited to half the
> column width of others. Please make another pass through these to give the
> commentary a consistent voice.

I believe second sentence is not required indeed, fixed the column
width as well, thanks.

>
> > + * When reports are polled, it will be expected to
> > + * occasionally observe the overflow bit being set
> > + * in the reports. This indicates that reports are not
> > + * being read fast enough.
> > + */
> > +#define POLL_INTERVAL_DEFAULT_MS 10
> > +
> > +/* Translate usage/page/offset triplet into physical address. */
> > +static u16 axiom_usage_to_target_address(struct axiom_data *ts, char usage, char page,
> > +					 char offset)
> > +{
> > +	u32 i;
>
> It's more common in kernel code for iterators to be declared as 'int' than
> u32, even if they're only used as unsigned integers in this case.
>

Ack.

[...]

> +	msg[1].len = len;
> > +	msg[1].buf = (char *)buf;
>
> My comment here from v3 seems to have been missed; please check it.
>

Applied to v6.

> > +
> > +	error = i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
> > +	if (error != ARRAY_SIZE(msg)) {
> > +		dev_err(&client->dev,
> > +			"Failed reading usage %#x page %#x, error=%d\n",
> > +			usage, page, error);
> > +		return -EIO;
> > +	}
>
> As I mention in the v3 review, you should preserve the original error code
> in case of a negative return value instead of returning -EIO in all cases.
> Please check my original comment.
>
> I also recommend you call this 'ret' and not 'error', because a non-zero
> return value (2) actually indicates success. In the input subsystem at least,
> 'error' is typically used for return values that can only be zero or negative.
>
> > +
> > +	usleep_range(250, 300);
> > +
> > +	return 0;
> > +}
>
> During the v3 review, I suggested you use regmap, since SPI support may come
> later. You can override both I2C and SPI callbacks with your own in case the
> hardware requires it. What was the reason not to use regmap now, and minimize
> rip-up later?

Suggestion applied to v6.

>
> > +
> > +/*
> > + * One of the main purposes for reading the usage table is to identify
> > + * which usages reside at which target address.
> > + * When performing subsequent reads or writes to AXIOM, the target address
> > + * is used to specify which usage is being accessed.
> > + * Consider the following discovery code which will build up the usage table.
> > + */
> > +static u32 axiom_populate_usage_table(struct axiom_data *ts)
> > +{
> > +	struct axiom_usage_entry *usage_table;
> > +	u32 max_report_len = 0;
> > +	char *rx_data = ts->rx_buf;
>
> Please use u8 here.
>
> > +	u32 usage_id;
> > +	int error;
> > +
> > +	usage_table = ts->usage_table;
> > +
> > +	/* Read the second page of usage u31 to get the usage table */
> > +	error = axiom_i2c_read(ts->client, AXIOM_DEVINFO_USAGE_ID, 1, rx_data,
> > +			       (AXIOM_U31_BYTES_PER_USAGE * ts->devinfo.num_usages));
> > +	if (error)
> > +		return error;
> > +
> > +	for (usage_id = 0; usage_id < ts->devinfo.num_usages; usage_id++) {
> > +		u16 offset = (usage_id * AXIOM_U31_BYTES_PER_USAGE);
> > +		u8 id = rx_data[offset + 0];
> > +		u8 start_page = rx_data[offset + 1];
> > +		u8 num_pages = rx_data[offset + 2];
> > +		u32 max_offset = ((rx_data[offset + 3] & AXIOM_PAGE_OFFSET_MASK) + 1) * 2;
> > +
> > +		if (!num_pages)
> > +			usage_table[usage_id].is_report = true;
> > +
> > +		/* Store the entry into the usage table */
> > +		usage_table[usage_id].id = id;
> > +		usage_table[usage_id].start_page = start_page;
> > +		usage_table[usage_id].num_pages = num_pages;
> > +
> > +		dev_dbg(ts->dev, "Usage u%02x Info: %*ph\n", id,
> > +			AXIOM_U31_BYTES_PER_USAGE, &rx_data[offset]);
> > +
> > +		/* Identify the max report length the module will receive */
> > +		if (usage_table[usage_id].is_report && max_offset > max_report_len)
> > +			max_report_len = max_offset;
> > +	}
> > +
> > +	ts->usage_table_populated = true;
> > +
> > +	return max_report_len;
> > +}
> > +
> > +static int axiom_discover(struct axiom_data *ts)
> > +{
> > +	int error;
> > +
> > +	/*
> > +	 * Fetch the first page of usage u31 to get the
> > +	 * device information and the number of usages
> > +	 */
> > +	error = axiom_i2c_read(ts->client, AXIOM_DEVINFO_USAGE_ID, 0, (char *)&ts->devinfo,
> > +			       AXIOM_U31_PAGE0_LENGTH);
>
> If you're set on using bespoke I2C helpers instead of regmap, then 'buf'
> should be defined as a void * as opposed to casting outside of axiom_i2c_read().
>
> > +	if (error)
> > +		return error;
> > +
> > +	dev_dbg(ts->dev, "  Boot Mode      : %s\n",
> > +		FIELD_GET(AXIOM_U31_BOOTMODE_MASK, ts->devinfo.device_id) ? "BLP" : "TCP");
> > +	dev_dbg(ts->dev, "  Device ID      : %04lx\n",
> > +		FIELD_GET(AXIOM_U31_DEVID_MASK,	ts->devinfo.device_id));
> > +	dev_dbg(ts->dev, "  Firmware Rev   : %02x.%02x\n", ts->devinfo.fw_major,
> > +		ts->devinfo.fw_minor);
> > +	dev_dbg(ts->dev, "  Bootloader Rev : %02x.%02x\n", ts->devinfo.bootloader_fw_major,
> > +		ts->devinfo.bootloader_fw_minor);
> > +	dev_dbg(ts->dev, "  FW Extra Info  : %04x\n", ts->devinfo.fw_info_extra);
> > +	dev_dbg(ts->dev, "  Silicon        : %04x\n", ts->devinfo.jedec_id);
> > +	dev_dbg(ts->dev, "  Number usages        : %04x\n", ts->devinfo.num_usages);
> > +
> > +	ts->max_report_len = axiom_populate_usage_table(ts);
> > +	if (!ts->max_report_len || !ts->devinfo.num_usages)
>
> This seems worthy of a dev_err(), otherwise the customer has no way to
> know something is wrong with the controller's FW.
>
> > +		return -EINVAL;
> > +
> > +	dev_dbg(ts->dev, "Max Report Length: %u\n", ts->max_report_len);
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * Support function to axiom_process_u41_report.
> > + * Generates input-subsystem events for every target.
> > + * After calling this function the caller shall issue
> > + * a Sync to the input sub-system.
> > + */
> > +static bool axiom_process_u41_report_target(struct axiom_data *ts,
> > +					    struct axiom_target_report *target)
> > +{
> > +	struct input_dev *input_dev = ts->input_dev;
> > +	struct axiom_u41_target *target_prev_state;
> > +	enum axiom_target_state current_state;
> > +	bool update = false;
> > +	int slot;
> > +
> > +	/* Verify the target index */
> > +	if (target->index >= AXIOM_U41_MAX_TARGETS) {
> > +		dev_dbg(ts->dev, "Invalid target index! %u\n", target->index);
>
> Should this be dev_err()?
>
> > +		return false;
> > +	}
> > +
> > +	target_prev_state = &ts->targets[target->index];
> > +
> > +	current_state = AXIOM_TARGET_STATE_NOT_PRESENT;
> > +
> > +	if (target->present) {
> > +		if (target->z >= 0)
> > +			current_state = AXIOM_TARGET_STATE_TOUCHING;
> > +		else if (target->z > AXIOM_PROX_LEVEL && target->z < 0)
> > +			current_state = AXIOM_TARGET_STATE_HOVER;
> > +		else if (target->z == AXIOM_PROX_LEVEL)
> > +			current_state = AXIOM_TARGET_STATE_PROX;
> > +	}
> > +
> > +	if (target_prev_state->state == current_state &&
> > +	    target_prev_state->x == target->x &&
> > +	    target_prev_state->y == target->y &&
> > +	    target_prev_state->z == target->z) {
> > +		return false;
> > +	}
>
> No need for curly braces here; please refer to the kernel style guidelines.
>
> > +
> > +	slot = target->index;
> > +
> > +	dev_dbg(ts->dev, "U41 Target T%u, slot:%u present:%u, x:%u, y:%u, z:%d\n",
> > +		target->index, slot, target->present,
> > +		target->x, target->y, target->z);
> > +
> > +	switch (current_state) {
> > +	case AXIOM_TARGET_STATE_NOT_PRESENT:
> > +	case AXIOM_TARGET_STATE_PROX:
> > +		if (!target_prev_state->insert)
> > +			break;
> > +		update = true;
> > +		target_prev_state->insert = false;
> > +		input_mt_slot(input_dev, slot);
> > +
> > +		if (!slot)
> > +			input_report_key(input_dev, BTN_TOUCH, 0);
> > +
> > +		input_mt_report_slot_inactive(input_dev);
> > +		/*
> > +		 * make sure the previous coordinates are
> > +		 * all off screen when the finger comes back
> > +		 */
> > +		target->x = 65535;
> > +		target->y = 65535;
> > +		target->z = AXIOM_PROX_LEVEL;
> > +		break;
> > +	case AXIOM_TARGET_STATE_HOVER:
> > +	case AXIOM_TARGET_STATE_TOUCHING:
> > +		target_prev_state->insert = true;
> > +		update = true;
> > +		input_mt_slot(input_dev, slot);
> > +		input_report_abs(input_dev, ABS_MT_TRACKING_ID, slot);
> > +		input_report_abs(input_dev, ABS_MT_POSITION_X, target->x);
> > +		input_report_abs(input_dev, ABS_X, target->x);
>
> You do not need to explicitly report ABS_X and ABS_Y values, as calling
> input_mt_sync_frame() effectively takes care of this by way of pointer
> emulation.

Applied thanks.

>
> > +		input_report_abs(input_dev, ABS_MT_POSITION_Y, target->y);
> > +		input_report_abs(input_dev, ABS_Y, target->y);
> > +
> > +		if (current_state == AXIOM_TARGET_STATE_TOUCHING) {
> > +			input_report_abs(input_dev, ABS_MT_DISTANCE, 0);
> > +			input_report_abs(input_dev, ABS_DISTANCE, 0);
> > +			input_report_abs(input_dev, ABS_MT_PRESSURE, target->z);
> > +			input_report_abs(input_dev, ABS_PRESSURE, target->z);
> > +		} else {
> > +			input_report_abs(input_dev, ABS_MT_DISTANCE, -target->z);
> > +			input_report_abs(input_dev, ABS_DISTANCE, -target->z);
> > +			input_report_abs(input_dev, ABS_MT_PRESSURE, 0);
> > +			input_report_abs(input_dev, ABS_PRESSURE, 0);
> > +		}
> > +
> > +		if (!slot)
> > +			input_report_key(input_dev, BTN_TOUCH, (current_state ==
> > +					 AXIOM_TARGET_STATE_TOUCHING));
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +
> > +	target_prev_state->state = current_state;
> > +	target_prev_state->x = target->x;
> > +	target_prev_state->y = target->y;
> > +	target_prev_state->z = target->z;
> > +
> > +	return update;
> > +}
>
> I appreciate that some clean-up was done here, but it still seems you can
> get rid of the 'update' flag. Can you not re-shuffle this a bit so that
> you return true at the bottom of the function, and simply return false
> early for the few cases where there is no update?
>

Sure.

> > +
> > +/*
> > + * U41 is the output report of the 2D CTS and contains the status of targets
> > + * (including contacts and pre-contacts) along with their X,Y,Z values.
> > + * When a target has been removed (no longer detected),
> > + * the corresponding X,Y,Z values will be zeroed.
> > + */
> > +static bool axiom_process_u41_report(struct axiom_data *ts, char *rx_buf)
> > +{
> > +	struct axiom_target_report target;
> > +	bool update_done = false;
> > +	u16 target_status;
> > +	u32 i;
> > +
> > +	target_status = ((rx_buf[1]) | (rx_buf[2] << 8));
>
> Please use get_unaligned_le16() instead of open-coding this math.

Interesting, thanks for the suggestions that will indeed improve
readability.

>
> > +
> > +	for (i = 0; i < AXIOM_U41_MAX_TARGETS; i++) {
> > +		char target_step = i * 4;
>
> Please use u8 here.

Ack.

>
> > +
> > +		target.index = i;
> > +		target.present = ((target_status & (1 << i)) != 0) ? 1 : 0;
> > +		target.x = (rx_buf[(target_step + 3)] | (rx_buf[target_step + 4] << 8));
> > +		target.y = (rx_buf[(target_step + 5)] | (rx_buf[target_step + 6] << 8));
> > +		target.z = (s8)(rx_buf[i + 43]);
> > +		update_done |= axiom_process_u41_report_target(ts, &target);
> > +	}
> > +
> > +	return update_done;
> > +}
> > +
> > +/*
> > + * U46 report contains a low level measurement data generated by the CDS
> > + * algorithms from the AUX channels. This information is useful when tuning
> > + * multi-press to assess mechanical consistency in the unit's construction.
> > + */
>
> What does CDS stand for, and what in user space is interested in these
> events? I'm guessing some kind of production-line calibration tool? I
> appreciate the additional comments in this revision; please add a bit
> more here.

CDS here stands for Capacitive Displacement Sensor and I think you are
right about the calibration tool.

>
> > +static void axiom_process_u46_report(struct axiom_data *ts, char *rx_buf)
> > +{
> > +	struct input_dev *input_dev = ts->input_dev;
> > +	u32 event_value;
> > +	u16 aux_value;
> > +	u32 i = 0;
>
> There is no need to initialize this iterator.
>

Fixed, thanks.

> > +
> > +	for (i = 0; i < AXIOM_U46_AUX_CHANNELS; i++) {
> > +		char target_step = i * 2;
> > +
> > +		aux_value = ((rx_buf[target_step + 2] << 8) | (rx_buf[target_step + 1]))
> > +			     & AXIOM_U46_AUX_MASK;
>
> This looks like another opportunity to use get_unaligned_le16().
>

Ack.

> > +		event_value = (i << 16) | (aux_value);
> > +		input_event(input_dev, EV_MSC, MSC_RAW, event_value);
> > +	}
> > +}
> > +
> > +/*
> > + * Validates the crc and demultiplexes the axiom reports to the appropriate
> > + * report handler
> > + */
> > +static int axiom_handle_events(struct axiom_data *ts)
> > +{
> > +	struct input_dev *input_dev = ts->input_dev;
> > +	char *report_data = ts->rx_buf;
>
> Please use u8 here.
>
> > +	struct device *dev = ts->dev;
> > +	u16 crc_report;
> > +	u16 crc_calc;
> > +	int error;
> > +	char len;
>
> And here.
>
> > +
> > +	error = axiom_i2c_read(ts->client, AXIOM_REPORT_USAGE_ID, 0, report_data,
> > +			       ts->max_report_len);
> > +	if (error)
> > +		return error;
> > +
> > +	len = (report_data[0] & AXIOM_COMMS_REPORT_LEN_MASK) << 1;
> > +	if (!len) {
> > +		dev_err(dev, "Zero length report discarded.\n");
> > +		return -ENODATA;
> > +	}
>
> Since you're expecting at least two bytes to get a CRC, it seems you should
> check that len >= 2 instead of > 0, otherwise 'len - 2' below will panic.
>
> > +
> > +	/* Validate the report CRC */
> > +	crc_report = (report_data[len - 1] << 8) | (report_data[len - 2]);
>
> We can use get_unaligned_le16() here too.
>
> > +	/* Length is in 16 bit words and remove the size of the CRC16 itself */
> > +	crc_calc = crc16(0, report_data, (len - 2));
> > +
> > +	if (crc_calc != crc_report) {
> > +		dev_err(dev,
> > +			"CRC mismatch! Expected: %#x, Calculated CRC: %#x.\n",
> > +			crc_report, crc_calc);
> > +		return -EINVAL;
> > +	}
> > +
> > +	switch (report_data[1]) {
> > +	case AXIOM_USAGE_2DCTS_REPORT_ID:
> > +		if (axiom_process_u41_report(ts, &report_data[1])) {
> > +			input_mt_sync_frame(input_dev);
> > +			input_sync(input_dev);
> > +		}
> > +		break;
> > +
> > +	case AXIOM_USAGE_2AUX_REPORT_ID:
> > +		/* This is an aux report (force) */
> > +		axiom_process_u46_report(ts, &report_data[1]);
> > +		input_mt_sync(input_dev);
>
> This call to input_mt_sync() seems unnecessary; we are not touching any MT
> slots in this case.
>
> > +		input_sync(input_dev);
> > +		break;
> > +
> > +	case AXIOM_USAGE_2HB_REPORT_ID:
> > +		/* This is a heartbeat report */
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void axiom_i2c_poll(struct input_dev *input_dev)
> > +{
> > +	struct axiom_data *ts = input_get_drvdata(input_dev);
> > +
> > +	axiom_handle_events(ts);
> > +}
> > +
> > +static irqreturn_t axiom_irq(int irq, void *dev_id)
> > +{
> > +	struct axiom_data *ts = dev_id;
> > +
> > +	axiom_handle_events(ts);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static void axiom_reset(struct gpio_desc *reset_gpio)
> > +{
> > +	gpiod_set_value_cansleep(reset_gpio, 1);
> > +	usleep_range(1000, 2000);
> > +	gpiod_set_value_cansleep(reset_gpio, 0);
> > +	msleep(110);
> > +}
> > +
> > +static int axiom_i2c_probe(struct i2c_client *client)
> > +{
> > +	struct device *dev = &client->dev;
> > +	struct input_dev *input_dev;
> > +	struct axiom_data *ts;
> > +	u32 startup_delay_ms;
> > +	u32 poll_interval;
> > +	int target;
> > +	int error;
> > +
> > +	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
> > +	if (!ts)
> > +		return -ENOMEM;
> > +
> > +	ts->client = client;
> > +	i2c_set_clientdata(client, ts);
> > +	ts->dev = dev;
> > +
> > +	ts->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> > +	if (IS_ERR(ts->reset_gpio))
> > +		return dev_err_probe(dev, PTR_ERR(ts->reset_gpio), "failed to get reset GPIO\n");
> > +
> > +	if (ts->reset_gpio)
> > +		axiom_reset(ts->reset_gpio);
> > +
> > +	ts->vddi = devm_regulator_get_optional(dev, "VDDI");
>
> I don't think there is any rule against doing so, but I have never seen any
> customers name a regulator in all caps.
>
> > +	if (!IS_ERR(ts->vddi)) {
> > +		error = regulator_enable(ts->vddi);
> > +		if (error)
> > +			return dev_err_probe(&client->dev, error,
> > +					     "Failed to enable VDDI regulator\n");
> > +	}
> > +
> > +	ts->vdda = devm_regulator_get_optional(dev, "VDDA");
> > +	if (!IS_ERR(ts->vdda)) {
> > +		error = regulator_enable(ts->vdda);
> > +		if (error) {
> > +			dev_err(dev, "Failed to get VDDA regulator\n");
> > +			regulator_disable(ts->vddi);
>
> You're turning off VDDI in case VDDA fails to be enabled, but you never turn
> either off in case the rest of probe (e.g. I2C read) fails, or any other time
> for that matter. Please schedule the regulator_disable() calls using
> devm_add_action_or_reset() so that they are automatically disabled in sequence
> in case probe terminates early, or the driver is unloaded.

I fixed this just by using devm_regulator_get_enable() instead, this
should also make sure regulators ar disabled in case of probe issue.

>
> > +			return error;
> > +		}
> > +		if (!device_property_read_u32(dev, "startup-time-ms", &startup_delay_ms))
> > +			msleep(startup_delay_ms);
>
> This seems like it should be a constraint handled by the regulator core and
> not your driver.

Not sure this fits well in regulator's ramp-delay feature, this delay is
required only after the regulator is enabled.

>
> > +	}
> > +
> > +	error = axiom_discover(ts);
> > +	if (error)
> > +		return dev_err_probe(dev, error, "Failed touchscreen discover\n");
> > +
> > +	input_dev = devm_input_allocate_device(ts->dev);
> > +	if (!input_dev)
> > +		return -ENOMEM;
> > +
> > +	input_dev->name = "TouchNetix axiom Touchscreen";
> > +	input_dev->phys = "input/axiom_ts";
> > +
> > +	/* Single Touch */
> > +	input_set_abs_params(input_dev, ABS_X, 0, 65535, 0, 0);
> > +	input_set_abs_params(input_dev, ABS_Y, 0, 65535, 0, 0);
>
> As I explained in the v3 review, you do not need to do this. Please refer to my
> previous comments.
>
> > +
> > +	/* Multi Touch */
>
> This comment is unnecessary.
>

Fixed in v6.

> > +	/* Min, Max, Fuzz (expected noise in px, try 4?) and Flat */
>
> What is the point of this comment, and the one below? Should fuzz have been 4?
>
> > +	input_set_abs_params(input_dev, ABS_MT_POSITION_X, 0, 65535, 0, 0);
> > +	/* Min, Max, Fuzz (expected noise in px, try 4?) and Flat */
> > +	input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0, 65535, 0, 0);
> > +	input_set_abs_params(input_dev, ABS_MT_TOOL_TYPE, 0, MT_TOOL_MAX, 0, 0);
> > +	input_set_abs_params(input_dev, ABS_MT_DISTANCE, 0, 127, 0, 0);
> > +	input_set_abs_params(input_dev, ABS_MT_PRESSURE, 0, 127, 0, 0);
>
> It seems you are forcing 65535 by 65535 resolution; is there no way to
> adjust this? Most controllers can scale it in their FW. You should either
> accept a customer-defined resolution using touchscreen_parse_properties()
> and write it through to the FW, read it from FW and report it through
> input_set_abs_params(), or both.

Ack, I will take this as well, thanks.

>
> > +
> > +	input_set_capability(input_dev, EV_KEY, BTN_TOUCH);
>
> This is unnecessary; input_mt_init_slots() will do it based on the contact type.
>
> > +
> > +	/* Registers the axiom device as a touchscreen instead of a mouse pointer */
> > +	error = input_mt_init_slots(input_dev, AXIOM_U41_MAX_TARGETS, INPUT_MT_DIRECT);
> > +	if (error)
> > +		return error;
> > +
> > +	/* Enables the raw data for up to 4 force channels to be sent to the input subsystem */
> > +	set_bit(EV_REL, input_dev->evbit);
> > +	set_bit(EV_MSC, input_dev->evbit);
> > +	/* Declare that we support "RAW" Miscellaneous events */
> > +	set_bit(MSC_RAW, input_dev->mscbit);
> > +
> > +	ts->input_dev = input_dev;
> > +	input_set_drvdata(ts->input_dev, ts);
> > +
> > +	/* Ensure that all reports are initialised to not be present. */
> > +	for (target = 0; target < AXIOM_U41_MAX_TARGETS; target++)
> > +		ts->targets[target].state = AXIOM_TARGET_STATE_NOT_PRESENT;
> > +
> > +	error = input_register_device(input_dev);
> > +	if (error)
> > +		return dev_err_probe(ts->dev, error,
> > +				     "Could not register with Input Sub-system.\n");
> > +
> > +	error = devm_request_threaded_irq(dev, client->irq, NULL,
> > +					  axiom_irq, IRQF_ONESHOT, dev_name(dev), ts);
> > +	if (error < 0) {
>
> if (error)
>
> > +		dev_warn(dev, "Request irq failed, falling back to polling mode");
> > +
> > +		error = input_setup_polling(input_dev, axiom_i2c_poll);
> > +		if (error)
> > +			return dev_err_probe(ts->dev, error, "Unable to set up polling mode\n");
> > +
> > +		if (!device_property_read_u32(ts->dev, "poll-interval", &poll_interval))
> > +			input_set_poll_interval(input_dev, poll_interval);
> > +		else
> > +			input_set_poll_interval(input_dev, POLL_INTERVAL_DEFAULT_MS);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct i2c_device_id axiom_i2c_id_table[] = {
> > +	{ "ax54a" },
> > +	{},
>
> Nit: add a space inside the sentinel like you do below.
>
> > +};
> > +MODULE_DEVICE_TABLE(i2c, axiom_i2c_id_table);
> > +
> > +static const struct of_device_id axiom_i2c_of_match[] = {
> > +	{ .compatible = "touchnetix,ax54a", },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, axiom_i2c_of_match);
> > +
> > +static struct i2c_driver axiom_i2c_driver = {
> > +	.driver = {
> > +		   .name = "axiom",
> > +		   .of_match_table = axiom_i2c_of_match,
> > +	},
> > +	.id_table = axiom_i2c_id_table,
> > +	.probe = axiom_i2c_probe,
> > +};
> > +module_i2c_driver(axiom_i2c_driver);
>
> Nit: please add a newline here.
>
> > +MODULE_AUTHOR("Bart Prescott <bartp@baasheep.co.uk>");
> > +MODULE_AUTHOR("Pedro Torruella <pedro.torruella@touchnetix.com>");
> > +MODULE_AUTHOR("Mark Satterthwaite <mark.satterthwaite@touchnetix.com>");
> > +MODULE_AUTHOR("Hannah Rossiter <hannah.rossiter@touchnetix.com>");
> > +MODULE_AUTHOR("Kamel Bouhara <kamel.bouhara@bootlin.com>");
> > +MODULE_DESCRIPTION("TouchNetix axiom touchscreen I2C bus driver");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.25.1
> >
>
> Kind regards,
> Jeff LaBundy

--
Kamel Bouhara, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

