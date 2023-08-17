Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8522E77F91F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351942AbjHQObn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352011AbjHQObd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:31:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1990B359B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692282677; x=1723818677;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=j/9P0gmQQHFlMHYDGkbBJX+RpwJHwEw+zK5VGhRAXCo=;
  b=h0WDffYLZZzIR1tTzMwgpL/xNSIThjCxQq6egn9JW7nijsuphqbFtLYA
   e/1m/mOSvJgF1S6LOOEdoxDI2N1gfQNAo9S+BivCUuds46RcLl1ciolrK
   oLLuBmiYOX3axPYXXrcSGx8YNnjRfe1h7K3x8Wiks7hWo4JYVHiQHIF59
   IRReo58ns0+Ks3zl04EjafFs+xmZ7qxmVM+h+u2swLOLUjf8jVqcL5meC
   af3bKW4T+n0UBCkyg+GiW8cZdOJQ39bteZ4jR8/mRWzD4qRLg9Ib5jayh
   n05zo5OxuuuPDLIHADB9r0AS/tptpOW/IsWlgpxa0Z4wU0Pvtk0piZhC5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="439199941"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="439199941"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 07:17:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="1065278587"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="1065278587"
Received: from cerondon-mobl1.amr.corp.intel.com (HELO [10.212.36.16]) ([10.212.36.16])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 07:17:50 -0700
Message-ID: <b28b5187-e775-4c4d-635e-9b867a19588e@linux.intel.com>
Date:   Thu, 17 Aug 2023 09:17:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v2] ASoC: tas2783: Add source files for tas2783 soundwire
 driver
To:     Baojun Xu <baojun.xu@ti.com>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc:     shenghao-ding@ti.com, kevin-lu@ti.com,
        krzysztof.kozlowski@linaro.org, rf@opensource.cirrus.com,
        shumingf@realtek.com, herve.codina@bootlin.com,
        povik+lin@cutebit.org, ryans.lee@analog.com,
        ckeepax@opensource.cirrus.com, sebastian.reichel@collabora.com,
        fido_max@inbox.ru, wangweidong.a@awinic.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        peeyush@ti.com, navada@ti.com, tiwai@suse.de,
        mengdong.lin@intel.com
References: <20230814121158.4668-1-baojun.xu@ti.com>
Content-Language: en-US
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230814121158.4668-1-baojun.xu@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +config SND_SOC_TAS2783
> +       tristate "Texas Instruments TAS2783 speaker amplifier (sdw)"
> +       depends on SOUNDWIRE
> +       select REGMAP
> +       select CRC32_SARWATE
> +       help
> +         Enable support for Texas Instruments TAS2783 Smart Amplifier
> +         Digital input mono Class-D and DSP-inside audio power amplifiers.
> +         Note the TAS2783 driver implements a flexible and configurable
> +         algo coff setting, for one, two, even multiple TAS2783 chips.

Algorithm coefficient

> +#include <linux/crc32.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/efi.h>

is this really needed?

> +#include <linux/err.h>
> +#include <linux/firmware.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/pm.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/soundwire/sdw.h>
> +#include <linux/soundwire/sdw_registers.h>
> +#include <linux/soundwire/sdw_type.h>
> +#include <sound/pcm_params.h>
> +#include <sound/sdw.h>
> +#include <sound/soc.h>
> +#include <sound/tlv.h>
> +#include <sound/tas2781-tlv.h>
> +
> +#include "tas2783.h"
> +
> +static const unsigned int tas2783_calibration_reg[] = {
> +	TAS2783_CALIBRATION_RE,
> +	TAS2783_CALIBRATION_RE_LOW,
> +	TAS2783_CALIBRATION_INV_RE,
> +	TAS2783_CALIBRATION_POW,
> +	TAS2783_CALIBRATION_TLIMIT,
> +	0,

what is the purpose of this zero, presumably you can use ARRAY_SIZE and
don't need a zero-terminated value?

> +static bool tas2783_volatile_register(struct device *dev,
> +	unsigned int reg)
> +{
> +	switch (reg) {
> +	case 0x8001:
> +		// Only reset register was volatiled.
> +		return true;

can you explain the concept of a volatile reset register?

> +	default:
> +		return false;
> +	}
> +}

> +static int tas2783_digital_getvol(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *codec
> +		= snd_soc_kcontrol_component(kcontrol);
> +	struct tasdevice_priv *tas_dev =
> +		snd_soc_component_get_drvdata(codec);
> +	struct soc_mixer_control *mc =
> +		(struct soc_mixer_control *)kcontrol->private_value;
> +	struct regmap *map = tas_dev->regmap;
> +	int val = 0, ret;

different line when a variable is initialized?

> +
> +	if (!map) {
> +		ret = -EINVAL;
> +		dev_err(tas_dev->dev, "%s, regmap doesn't exist.\n",
> +			__func__);
> +		goto out;
> +	}
> +	/* Read the primary device as the whole */

I can't figure out what this comment means

> +	ret = regmap_read(map, mc->reg, &val);
> +	dev_dbg(tas_dev->dev, "%s, get digital vol %d from %x with %d\n",
> +		__func__, val, mc->reg, ret);
> +	if (ret) {
> +		dev_err(tas_dev->dev, "%s, get digital vol error %x.\n",
> +			__func__, ret);
> +		goto out;
> +	}
> +	ucontrol->value.integer.value[0] =
> +		tasdevice_clamp(val, mc->max, mc->invert);
> +
> +out:
> +	return ret;
> +}

> +static int tas2783_amp_getvol(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *codec
> +		= snd_soc_kcontrol_component(kcontrol);
> +	struct tasdevice_priv *tas_dev =
> +		snd_soc_component_get_drvdata(codec);
> +	struct soc_mixer_control *mc =
> +		(struct soc_mixer_control *)kcontrol->private_value;
> +	struct regmap *map = tas_dev->regmap;
> +	unsigned char mask;
> +	int ret, val;
> +
> +	if (!map) {
> +		dev_err(tas_dev->dev, "%s, regmap doesn't exist.\n",
> +			__func__);
> +		return -EINVAL;
> +	}
> +	/* Read the primary device */

What is a primary device?

> +	ret = regmap_read(map, mc->reg, &val);
> +	dev_dbg(tas_dev->dev, "%s, get AMP vol %d from %x with %d\n",
> +		__func__, val, mc->reg, ret);
> +
> +	mask = (1 << fls(mc->max)) - 1;
> +	mask <<= mc->shift;
> +	val = (val & mask) >> mc->shift;
> +	ucontrol->value.integer.value[0] = tasdevice_clamp(val,	mc->max,
> +		mc->invert);
> +
> +	return ret;
> +}

> +static int tas2783_calibration(struct tasdevice_priv *tas_priv)
> +{
> +	efi_guid_t efi_guid = EFI_GUID(0x1f52d2a1, 0xbb3a, 0x457d, 0xbc,
> +		0x09, 0x43, 0xa3, 0xf4, 0x31, 0x0a, 0x92);
> +	static efi_char16_t efi_name[] = TAS2783_CALIDATA_NAME;
> +	struct tm *tm = &tas_priv->tm;
> +	unsigned int attr, crc;
> +	unsigned int *tmp_val;
> +	efi_status_t status;
> +
> +	tas_priv->cali_data.total_sz = TAS2783_MAX_CALIDATA_SIZE;
> +	/* Get real size of UEFI variable */
> +	status = efi.get_variable(efi_name, &efi_guid, &attr,
> +		&tas_priv->cali_data.total_sz, tas_priv->cali_data.data);
> +	dev_dbg(tas_priv->dev, "cali get %lx bytes with result : %ld\n",
> +			tas_priv->cali_data.total_sz, status);
> +	if (status == EFI_BUFFER_TOO_SMALL) {
> +		status = efi.get_variable(efi_name, &efi_guid, &attr,
> +			&tas_priv->cali_data.total_sz,
> +			tas_priv->cali_data.data);
> +		dev_dbg(tas_priv->dev, "cali get %lx bytes result:%ld\n",
> +			tas_priv->cali_data.total_sz, status);
> +	}
> +	/* Failed got calibration data from EFI. */

I don't get what the dependency on EFI is. First time I see a codec
needing this.

Please describe in details what you are trying to accomplish.
Edit: there's also a dependency on firmware but the firmware name SWFT
will hint at ACPI uses for anyone that has read the SDCA draft. This is
beyond confusing.

> +	if (status != 0) {
> +		dev_dbg(tas_priv->dev, "cali get %lx error with:%ld\n",
> +			tas_priv->cali_data.total_sz, status);
> +		return 0;
> +	}
> +	/* Print all content of calibration data for debug. */
> +	for (int i = 0; i < tas_priv->cali_data.total_sz; i += 4) {
> +		dev_dbg(tas_priv->dev, "cali get %02x %02x %02x %02x",
> +			tas_priv->cali_data.data[i],
> +			tas_priv->cali_data.data[i+1],
> +			tas_priv->cali_data.data[i+2],
> +			tas_priv->cali_data.data[i+3]);
> +	}
> +
> +	tmp_val = (unsigned int *)tas_priv->cali_data.data;
> +
> +	crc = crc32(~0, tas_priv->cali_data.data, 84) ^ ~0;
> +	dev_dbg(tas_priv->dev, "cali crc 0x%08x PK tmp_val 0x%08x\n",
> +		crc, tmp_val[21]);
> +
> +	if (crc == tmp_val[21]) {
> +		time64_to_tm(tmp_val[20], 0, tm);
> +		dev_dbg(tas_priv->dev, "%4ld-%2d-%2d, %2d:%2d:%2d\n",
> +			tm->tm_year, tm->tm_mon, tm->tm_mday,
> +			tm->tm_hour, tm->tm_min, tm->tm_sec);

What is this about? Why would a codec care about time?

> +		tas2783_apply_calib(tas_priv, tmp_val);
> +	} else {
> +		dev_dbg(tas_priv->dev, "CRC error!\n");
> +		tas_priv->cali_data.total_sz = 0;
> +	}
> +
> +	return 0;
> +}
> +
> +static void tasdevice_rca_ready(const struct firmware *fmw, void *context)
> +{
> +	struct tasdevice_priv *tas_dev =
> +		(struct tasdevice_priv *) context;
> +	struct regmap *map = tas_dev->regmap;
> +	struct tas2783_firmware_node *p;
> +	int offset = 0, num_nodes = 0, img_sz, ret;
> +	unsigned char *buf;
> +
> +	mutex_lock(&tas_dev->codec_lock);
> +
> +	if (!fmw || !fmw->data) {
> +		dev_err(tas_dev->dev,
> +		"Failed to read %s, no side - effect on driver running\n",

side-effect

> +		tas_dev->rca_binaryname);
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	if (!map) {
> +		dev_err(tas_dev->dev, "Failed to load regmap.\n");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	buf = (unsigned char *)fmw->data;
> +
> +	img_sz = le32_to_cpup((__le32 *)&buf[offset]);
> +	dev_dbg(tas_dev->dev,  "Got %x:%lx.\n",	img_sz, fmw->size);
> +	offset  += sizeof(img_sz);
> +	if (img_sz != fmw->size) {
> +		dev_err(tas_dev->dev,
> +			"Size not match, %d %u", (int)fmw->size, img_sz);

Size does not match or size not matching

> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	while ((offset < img_sz) && (num_nodes < TAS2783_MAX_NODES)) {
> +		/* Store firmware into context of driver. */
> +		p = (struct tas2783_firmware_node *)(buf + offset);
> +		tas_dev->firmware_node[num_nodes].vendor_id =
> +			p->vendor_id;
> +		tas_dev->firmware_node[num_nodes].file_id = p->file_id;
> +		tas_dev->firmware_node[num_nodes].version_id =
> +			p->version_id;
> +		tas_dev->firmware_node[num_nodes].length = p->length;
> +		tas_dev->firmware_node[num_nodes].download_addr =
> +			p->download_addr;
> +		tas_dev->firmware_node[num_nodes].start_addr =
> +			((char *)p) + sizeof(unsigned int)*5;
> +
> +		ret = regmap_bulk_write(map, p->download_addr,
> +			p->start_addr, p->length);
> +		dev_dbg(tas_dev->dev, "Wr %d :%x:%x:%x:%x:%x:%x %d.\n",
> +			num_nodes, p->vendor_id, p->file_id,
> +			p->version_id, p->length, p->download_addr,
> +			p->start_addr[0], ret);
> +
> +		offset += sizeof(unsigned int)*5 + p->length;
> +		num_nodes++;
> +	}
> +
> +	tas2783_calibration(tas_dev);
> +
> +out:
> +	mutex_unlock(&tas_dev->codec_lock);
> +	if (fmw)
> +		release_firmware(fmw);
> +}
> +
> +static const struct snd_soc_dapm_widget tasdevice_dapm_widgets[] = {
> +	SND_SOC_DAPM_AIF_IN("ASI", "ASI Playback", 0, SND_SOC_NOPM, 0, 0),
> +	SND_SOC_DAPM_AIF_OUT("ASI OUT", "ASI Capture", 0, SND_SOC_NOPM,
> +		0, 0),
> +	SND_SOC_DAPM_OUTPUT("OUT"),
> +	SND_SOC_DAPM_INPUT("DMIC")

Can you clarify what "ASI" is?
Also what is the plan for DMIC - this is an amplifier, no?

> +};
> +
> +static const struct snd_soc_dapm_route tasdevice_audio_map[] = {
> +	{"OUT", NULL, "ASI"},
> +	{"ASI OUT", NULL, "DMIC"}
> +};
> +
> +static int tasdevice_set_sdw_stream(
> +	struct snd_soc_dai *dai, void *sdw_stream, int direction)
> +{
> +	struct sdw_stream_data *stream;
> +
> +	if (!sdw_stream)
> +		return 0;
> +
> +	stream = kzalloc(sizeof(*stream), GFP_KERNEL);
> +	if (!stream)
> +		return -ENOMEM;
> +
> +	stream->sdw_stream = sdw_stream;
> +
> +	/* Use tx_mask or rx_mask to set dma_data */
> +	snd_soc_dai_dma_data_set(dai, direction, stream);
> +
> +	return 0;
> +}

this can be simplied, just look at all other existing codecs and
implement the same, e.g.

static int cs42l42_sdw_dai_set_sdw_stream(struct snd_soc_dai *dai, void
*sdw_stream,
					  int direction)
{
	snd_soc_dai_dma_data_set(dai, direction, sdw_stream);

	return 0;
}

> +
> +static void tasdevice_sdw_shutdown(struct snd_pcm_substream *substream,
> +				struct snd_soc_dai *dai)
> +{
> +	struct sdw_stream_data *stream;
> +
> +	stream = snd_soc_dai_get_dma_data(dai, substream);
> +	snd_soc_dai_set_dma_data(dai, substream, NULL);
> +	kfree(stream);

same, this can be simplified

> +}
> +

> +static struct snd_soc_dai_driver tasdevice_dai_driver[] = {
> +	{
> +		.name = "tas2783-codec",
> +		.id = 0,
> +		.playback = {
> +			.stream_name	= "Playback",
> +			.channels_min	= 1,
> +			.channels_max	= 4,
> +			.rates		= TAS2783_DEVICE_RATES,
> +			.formats	= TAS2783_DEVICE_FORMATS,
> +		},
> +		.capture = {
> +			.stream_name	= "Capture",
> +			.channels_min	= 1,
> +			.channels_max	= 4,
> +			.rates		= TAS2783_DEVICE_RATES,
> +			.formats	= TAS2783_DEVICE_FORMATS,
> +		},

what is the capture part? Feedback or DMIC?

> +		.ops = &tasdevice_dai_ops,
> +		.symmetric_rate = 1,
> +	},
> +};
> +
> +static void tas2783_reset(struct tasdevice_priv *tas_dev)
> +{
> +	struct regmap *map = tas_dev->regmap;
> +	unsigned char value_sdw;
> +	int ret;
> +
> +	if (!map) {
> +		dev_err(tas_dev->dev, "Failed to load regmap.\n");
> +		return;
> +	}
> +	value_sdw = TAS2873_REG_SWRESET_RESET;
> +	ret = regmap_write(map, TAS2873_REG_SWRESET, value_sdw);
> +	dev_dbg(tas_dev->dev, "%s TAS2783 was reseted %d.\n",
> +		__func__, ret);
> +	usleep_range(1000, 1050);

don't we need some sort of regmap_sync here?

> +}
> +
> +static int tasdevice_codec_probe(struct snd_soc_component *codec)

the naming is poor, this is the component probe, not the codec driver probe.

> +{
> +	struct tasdevice_priv *tas_dev =
> +		snd_soc_component_get_drvdata(codec);
> +	int ret;
> +
> +	dev_dbg(tas_dev->dev, "%s called for TAS2783 start.\n",
> +		__func__);
> +	/* Codec Lock Hold */
> +	mutex_lock(&tas_dev->codec_lock);> +
> +	tas2783_reset(tas_dev);

Isn't this something you would do in a driver probe?

> +
> +	tas_dev->codec = codec;
> +
> +	scnprintf(tas_dev->rca_binaryname, 64, "MY_SWFT_x%01x.bin",

The naming is rather controversial...

You need to have some sort of identifier that is TI specific, and/or a
prefix to find this file in /lib/firmware.

It's really unclear to me why this is part of a component probe and not
a driver probe.

> +		tas_dev->sdw_peripheral->id.unique_id);
> +
> +	ret = request_firmware_nowait(THIS_MODULE, FW_ACTION_UEVENT,
> +		tas_dev->rca_binaryname, tas_dev->dev, GFP_KERNEL,
> +		tas_dev, tasdevice_rca_ready);
> +	dev_dbg(tas_dev->dev,
> +		"%s: request_firmware %x open status: 0x%08x\n",
> +		__func__, tas_dev->sdw_peripheral->id.unique_id, ret);
> +
> +	/* Codec Lock Release*/
> +	mutex_unlock(&tas_dev->codec_lock);
> +
> +	dev_dbg(tas_dev->dev, "%s was called end.\n",  __func__);
> +	return ret;
> +}

> +static int tasdevice_io_init(struct device *dev, struct sdw_slave *slave)
> +{
> +	struct tasdevice_priv *tasdevice = dev_get_drvdata(dev);
> +
> +	if (tasdevice->hw_init)
> +		return 0;
> +
> +	/* PM runtime is only enabled when
> +	 * a Slave reports as Attached
> +	 * set autosuspend parameters
> +	 */
> +	pm_runtime_set_autosuspend_delay(&slave->dev, 3000);
> +	pm_runtime_use_autosuspend(&slave->dev);
> +
> +	/* update count of parent 'active' children */
> +	pm_runtime_set_active(&slave->dev);
> +
> +	/* make sure the device does not suspend immediately */
> +	pm_runtime_mark_last_busy(&slave->dev);
> +
> +	pm_runtime_enable(&slave->dev);
> +
> +	pm_runtime_get_noresume(&slave->dev);
> +
> +	/* Mark Slave initialization complete */
> +	tasdevice->hw_init = true;
> +
> +	pm_runtime_mark_last_busy(&slave->dev);
> +	pm_runtime_put_autosuspend(&slave->dev);
> +
> +	dev_dbg(&slave->dev, "%s hw_init complete\n", __func__);
> +	return 0;

This is really not aligned with the latest upstream code. Intel (and
specifically me myself and I) contributed a change where the pm_runtime
is enabled in the driver probe, but the device status changes to active
in the io_init.

In addition, it's rather surprising that on attachment there is not a
single regmap access?


> +static void tasdevice_remove(struct tasdevice_priv *tas_dev)
> +{
> +	snd_soc_unregister_component(tas_dev->dev);
> +
> +	mutex_destroy(&tas_dev->dev_lock);
> +	mutex_destroy(&tas_dev->codec_lock);

I didn't really look into the locking parts but you will need a lot more
explanations on what you are trying to protect and the concurrency issues.

> +}
> +
> +static int tasdevice_sdw_probe(struct sdw_slave *peripheral,
> +	const struct sdw_device_id *id)
> +{
> +	struct device *dev = &peripheral->dev;
> +	struct tasdevice_priv *tas_dev;
> +	int ret;
> +
> +	dev_dbg(dev, "%s was called.\n",  __func__);
> +
> +	tas_dev = devm_kzalloc(dev, sizeof(*tas_dev), GFP_KERNEL);
> +	if (!tas_dev) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +	tas_dev->dev = &peripheral->dev;
> +	tas_dev->chip_id = id->driver_data;
> +	tas_dev->sdw_peripheral = peripheral;
> +	tas_dev->hw_init = false;
> +
> +	dev_dbg(dev, "%d chip id %x for TAS2783.\n",
> +	peripheral->id.unique_id, tas_dev->chip_id);
> +
> +	dev_set_drvdata(dev, tas_dev);
> +
> +	tas_dev->regmap = devm_regmap_init_sdw(peripheral,
> +		&tasdevice_regmap);
> +	if (IS_ERR(tas_dev->regmap)) {
> +		ret = PTR_ERR(tas_dev->regmap);
> +		dev_err(dev, "Failed devm_regmap_init: %d\n", ret);
> +		goto out;
> +	}
> +	ret = tasdevice_init(tas_dev);
> +
> +out:
> +	if (ret < 0 && tas_dev != NULL)
> +		tasdevice_remove(tas_dev);
> +
> +	return ret;

like I said above, this is missing the pm_runtime stuff.

> +
> +}
> +
> +static int tasdevice_sdw_remove(struct sdw_slave *peripheral)
> +{
> +	struct tasdevice_priv *tas_dev =
> +		dev_get_drvdata(&peripheral->dev);
> +
> +	if (tas_dev)
> +		tasdevice_remove(tas_dev);
> +
> +	return 0;
> +}
> +
> +static const struct sdw_device_id tasdevice_sdw_id[] = {
> +	SDW_SLAVE_ENTRY(0x0102, 0x0, 0),

0x0102 is the legit TI manufacturer ID, that's good.

What's not so good is that the part ID is *ZERO*? Is this really
intentional?

> +#define TASDEVICE_REG(book, page, reg)	((book * 256 * 256) + 0x8000 +\
> +					(page * 128) + reg)
> +
> +/*Software Reset */

/* Software


