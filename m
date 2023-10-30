Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB047DBE5E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 17:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbjJ3Q4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 12:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbjJ3Q4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 12:56:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3641098
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 09:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698684997; x=1730220997;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xyRO51r613biejKjgturJHD0BDGGjSmZFtKlhQ5JEQQ=;
  b=hJdcn78bsGixGsE80+mKpcWQxjqTlC5C8sDB7Bu2zpSVBpbF37C+p3HZ
   9rV9UYtXCFIMxpFC7DIzN9BdB1uQfn3RUmctVP3riF/rZG4oxshyBIlb2
   WOmDGCsYamvJbz8+ejRsnyVYqJ1VYnM+fO2QaSnH/03v2T2ezUSmAVBGm
   8AUOY3hnsiKM6g9Xa5iGt5SwQz6lUeOlDgNkGnSraCPOtDBkxkK5Sj5gO
   HgnKmTyIXvqFULy9685obAOKDyB3iXm4rhMu40reazLnAYpz/PQacQ/AC
   L0LQQgQ76ZCEBlOGYtNsgYVX3/2Yv1Q8O5YB+mN5YvSKA4yz8TrbvOcQn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="957298"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="957298"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 09:56:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="830736409"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="830736409"
Received: from wezedi-mobl1.amr.corp.intel.com (HELO [10.212.223.192]) ([10.212.223.192])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 09:56:35 -0700
Message-ID: <7f4465c1-5e8e-4c5f-bbff-d2c930326986@linux.intel.com>
Date:   Mon, 30 Oct 2023 11:05:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ASoC: tas2783: Add source files for tas2783 driver.
Content-Language: en-US
To:     Baojun Xu <baojun.xu@ti.com>, broonie@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kevin-lu@ti.com, shenghao-ding@ti.com, peeyush@ti.com,
        navada@ti.com, tiwai@suse.de
References: <20231028092409.96813-1-baojun.xu@ti.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20231028092409.96813-1-baojun.xu@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am afraid there are quite a few v2 comments that were not adressed,
and specifically the EFI handling, pm_runtime and firmware
paths/handling need to be clarified.

> +config SND_SOC_TAS2783
> +        tristate "Texas Instruments TAS2783 speaker amplifier (sdw)"

(SoundWire)

> +        depends on SOUNDWIRE
> +        select REGMAP
> +        select REGMAP_SOUNDWIRE
> +        select CRC32
> +        help
> +          Enable support for Texas Instruments TAS2783 Smart Amplifier
> +          Digital input mono Class-D and DSP-inside audio power amplifiers.
> +          Note the TAS2783 driver implements a flexible and configurable
> +          algorithm cofficient setting, for one, two or multiple TAS2783

typo: coefficient

> new file mode 100644
> index 000000000000..d9719f15b17c
> --- /dev/null
> +++ b/sound/soc/codecs/tas2783-sdw.c
> @@ -0,0 +1,856 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// ALSA SoC Texas Instruments TAS2783 Audio Smart Amplifier
> +//
> +// Copyright (C) 2023 Texas Instruments Incorporated
> +// https://www.ti.com
> +//
> +// The TAS2783 driver implements a flexible and configurable
> +// algo coefficient setting for single TAS2783 chips.

The comment is a bit weird, what happens if there are multiple
amplifiers? Also what is "flexible and configurable"?

> +static const unsigned int tas2783_cali_reg[] = {
> +	TAS2783_CALIBRATION_RE,
> +	TAS2783_CALIBRATION_RE_LOW,
> +	TAS2783_CALIBRATION_INV_RE,

what does "RE" stand for?

> +	TAS2783_CALIBRATION_POW,

POWER?

> +	TAS2783_CALIBRATION_TLIMIT

TIME_LIMIT?

> +};
> +
> +static const struct reg_default tas2783_reg_defaults[] = {
> +	/* Default values for ROM mode. Activated. */
> +	{ 0x8002, 0x1a},	/* AMP inactive. */
> +	{ 0x8097, 0xc8},
> +	{ 0x80b5, 0x74},
> +	{ 0x8099, 0x20},
> +	{ 0xfe8d, 0x0d},
> +	{ 0xfebe, 0x4a},
> +	{ 0x8230, 0x00},
> +	{ 0x8231, 0x00},
> +	{ 0x8232, 0x00},
> +	{ 0x8233, 0x01},
> +	{ 0x8418, 0x00},	/* Set volume to 0 dB. */
> +	{ 0x8419, 0x00},
> +	{ 0x841a, 0x00},
> +	{ 0x841b, 0x00},
> +	{ 0x8428, 0x40},	/* Unmute channel */
> +	{ 0x8429, 0x00},
> +	{ 0x842a, 0x00},
> +	{ 0x842b, 0x00},
> +	{ 0x8548, 0x00},	/* Set volume to 0 dB. */
> +	{ 0x8549, 0x00},
> +	{ 0x854a, 0x00},
> +	{ 0x854b, 0x00},
> +	{ 0x8558, 0x40},	/* Unmute channel */
> +	{ 0x8559, 0x00},
> +	{ 0x855a, 0x00},
> +	{ 0x855b, 0x00},
> +	{ 0x800a, 0x3a},	/* Enable both channel */
> +	{ 0x800e, 0x44},
> +	{ 0x800f, 0x40},
> +	{ 0x805c, 0x99},
> +	{ 0x40400088, 0},	/* FUNC_1, FU21, SEL_1(Mute) */
> +	{ 0x40400090, 0},	/* FUNC_1, FU21, SEL_2(Channel volume) */
> +	{ 0x40400108, 0},	/* FUNC_1, FU23, MUTE */
> +};
> +
> +static bool tas2783_readable_register(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case 0x000 ... 0x080:	/* Data port 0. */

No, this is wrong. All the data port 'standard' registers are "owned" by
the SoundWire core and handled during the port prepare/configure/bank
switch routines. Do not use them for regmap.

In other words, you *shall* only define vendor-specific registers in
this codec driver.

> +	case 0x100 ... 0x140:	/* Data port 1. */
> +	case 0x200 ... 0x240:	/* Data port 2. */
> +	case 0x300 ... 0x340:	/* Data port 3. */
> +	case 0x400 ... 0x440:	/* Data port 4. */
> +	case 0x500 ... 0x540:	/* Data port 5. */
> +	case 0x8000 ... 0xc000:	/* Page 0 ~ 127. */
> +	case 0xfe80 ... 0xfeff:	/* Page 253. */
> +	case SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, TAS2783_SDCA_ENT_UDMPU21,
> +		TAS2783_SDCA_CTL_UDMPU_CLUSTER, 0):
> +	case SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, TAS2783_SDCA_ENT_FU21,
> +		TAS2783_SDCA_CTL_FU_MUTE, TAS2783_DEVICE_CHANNEL_LEFT):
> +	case SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, TAS2783_SDCA_ENT_FU21,
> +		TAS2783_SDCA_CTL_FU_MUTE, TAS2783_DEVICE_CHANNEL_RIGHT):
> +	case SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, TAS2783_SDCA_ENT_PDE23,
> +		TAS2783_SDCA_CTL_REQ_POWER_STATE, 0):
> +	case SDW_SDCA_CTL(FUNC_NUM_SMART_AMP, TAS2783_SDCA_ENT_PDE22,
> +		TAS2783_SDCA_CTL_REQ_POWER_STATE, 0):
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool tas2783_volatile_register(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case 0x8001:
> +		/* Only reset register was volatiled.

volatile.

> +		 * Write any value into this register, mean RESET device.

If it's volatile, then the value can change on its own. I asked a
question on this in v1 and it's not clear to me. Can the device reset on
its own? If yes, what parts are reset and how should software react?

> +		 */
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static const struct regmap_config tasdevice_regmap = {
> +	.reg_bits = 32,
> +	.val_bits = 8,
> +	.readable_reg = tas2783_readable_register,
> +	.volatile_reg = tas2783_volatile_register,
> +	.max_register = 0x41008000 + TASDEVICE_REG(0xa1, 0x60, 0x7f),

you probably want a define and some comments....

> +	.reg_defaults = tas2783_reg_defaults,
> +	.num_reg_defaults = ARRAY_SIZE(tas2783_reg_defaults),
> +	.cache_type = REGCACHE_RBTREE,
> +	.use_single_read = true,
> +	.use_single_write = true,
> +};
> +
> +static int tasdevice_clamp(int val, int max, unsigned int invert)
> +{
> +	/* Keep in valid area, out of range value don't care. */
> +	if (val > max)
> +		val = max;
> +	if (invert)
> +		val = max - val;
> +	if (val < 0)
> +		val = 0;
> +	return val;
> +}
> +
> +static int tas2783_digital_getvol(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component
> +		= snd_soc_kcontrol_component(kcontrol);
> +	struct tasdevice_priv *tas_dev =
> +		snd_soc_component_get_drvdata(component);
> +	struct soc_mixer_control *mc =
> +		(struct soc_mixer_control *)kcontrol->private_value;
> +	struct regmap *map = tas_dev->regmap;
> +	int val = 0, ret;

different line when a variable is initialized

> +
> +	if (!map || !ucontrol) {
> +		dev_err(tas_dev->dev, "%s, wrong regmap.\n", __func__);
> +		return -EINVAL;
> +	}
> +	/* Read current volume from the device. */
> +	ret = regmap_read(map, mc->reg, &val);
> +	if (ret) {
> +		dev_err(tas_dev->dev, "%s, get digital vol error %x.\n",
> +			__func__, ret);
> +		return ret;
> +	}
> +	ucontrol->value.integer.value[0] =
> +		tasdevice_clamp(val, mc->max, mc->invert);
> +
> +	return ret;
> +}
> +
> +static int tas2783_digital_putvol(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component
> +		= snd_soc_kcontrol_component(kcontrol);
> +	struct tasdevice_priv *tas_dev =
> +		snd_soc_component_get_drvdata(component);
> +	struct soc_mixer_control *mc =
> +		(struct soc_mixer_control *)kcontrol->private_value;
> +	struct regmap *map = tas_dev->regmap;
> +	int val, ret;
> +
> +	if (!map || !ucontrol) {
> +		dev_err(tas_dev->dev, "%s, wrong regmap.\n", __func__);
> +		return -EINVAL;
> +	}
> +	val = tasdevice_clamp(ucontrol->value.integer.value[0],
> +		mc->max, mc->invert);
> +
> +	ret = regmap_write(map, mc->reg, val);
> +	if (ret != 0) {
> +		dev_dbg(tas_dev->dev, "%s, Put vol %d into %x %x.\n",
> +		__func__, val, mc->reg, ret);
> +	}
> +
> +	return ret;
> +}
> +
> +static int tas2783_amp_getvol(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component
> +		= snd_soc_kcontrol_component(kcontrol);
> +	struct tasdevice_priv *tas_dev =
> +		snd_soc_component_get_drvdata(component);
> +	struct soc_mixer_control *mc =
> +		(struct soc_mixer_control *)kcontrol->private_value;
> +	struct regmap *map = tas_dev->regmap;
> +	unsigned char mask = 0;
> +	int ret = 0, val = 0;

useless unit for ret

> +
> +	if (!map || !ucontrol) {
> +		dev_err(tas_dev->dev, "%s, wrong regmap.\n", __func__);
> +		return -EINVAL;
> +	}
> +	/* Read current volume from the device. */
> +	ret = regmap_read(map, mc->reg, &val);
> +	if (ret != 0) {
> +		dev_err(tas_dev->dev, "%s get AMP vol from %x with %d.\n",
> +			__func__, mc->reg, ret);
> +		return ret;
> +	}
> +
> +	mask = (1 << fls(mc->max)) - 1;
> +	mask <<= mc->shift;
> +	val = (val & mask) >> mc->shift;
> +	ucontrol->value.integer.value[0] = tasdevice_clamp(val,	mc->max,
> +		mc->invert);
> +
> +	return ret;
> +}
> +
> +static int tas2783_amp_putvol(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component
> +		= snd_soc_kcontrol_component(kcontrol);
> +	struct tasdevice_priv *tas_dev =
> +		snd_soc_component_get_drvdata(component);
> +	struct soc_mixer_control *mc =
> +		(struct soc_mixer_control *)kcontrol->private_value;
> +	struct regmap *map = tas_dev->regmap;
> +	unsigned char mask;
> +	int val, ret;
> +
> +	if (!map || !ucontrol) {
> +		dev_err(tas_dev->dev, "%s, wrong regmap.\n", __func__);
> +		return -EINVAL;
> +	}
> +	mask = (1 << fls(mc->max)) - 1;
> +	mask <<= mc->shift;
> +	val = tasdevice_clamp(ucontrol->value.integer.value[0], mc->max,
> +		mc->invert);
> +	ret = regmap_update_bits(map, mc->reg, mask, val << mc->shift);
> +	if (ret != 0) {
> +		dev_err(tas_dev->dev, "Write @%#x..%#x:%d\n",
> +			mc->reg, val, ret);
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct snd_kcontrol_new tas2783_snd_controls[] = {
> +	SOC_SINGLE_RANGE_EXT_TLV("Amp Gain Volume", TAS2783_AMP_LEVEL,
> +		1, 0, 20, 0, tas2783_amp_getvol,
> +		tas2783_amp_putvol, amp_vol_tlv),
> +	SOC_SINGLE_RANGE_EXT_TLV("Digital Volume", TAS2783_DVC_LVL,
> +		0, 0, 200, 1, tas2783_digital_getvol,
> +		tas2783_digital_putvol, dvc_tlv),
> +};
> +
> +static void tas2783_apply_calib(
> +	struct tasdevice_priv *tas_dev, unsigned int *cali_data)
> +{
> +	struct regmap *map = tas_dev->regmap;
> +	u8 *reg_start;
> +	int ret;
> +
> +	if (!map) {
> +		dev_err(tas_dev->dev, "%s, wrong regmap.\n", __func__);
> +		return;
> +	}
> +	if (!tas_dev->sdw_peripheral) {
> +		dev_err(tas_dev->dev, "%s, slaver doesn't exist.\n",

did you mean "peripheral"?

Can this really happen?

> +			__func__);
> +		return;
> +	}
> +	if ((tas_dev->sdw_peripheral->id.unique_id < TAS2783_ID_MIN) ||
> +		(tas_dev->sdw_peripheral->id.unique_id > TAS2783_ID_MAX))
> +		return;
> +	reg_start = (u8 *)(cali_data+(tas_dev->sdw_peripheral->id.unique_id
> +		- TAS2783_ID_MIN)*sizeof(tas2783_cali_reg));
> +	for (int i = 0; i < ARRAY_SIZE(tas2783_cali_reg); i++) {
> +		ret = regmap_bulk_write(map, tas2783_cali_reg[i],
> +			reg_start + i, 4);
> +		if (ret != 0) {
> +			dev_err(tas_dev->dev, "Cali failed %x:%d\n",
> +			tas2783_cali_reg[i], ret);
> +			break;
> +		}
> +	}
> +}
> +
> +static int tas2783_calibration(struct tasdevice_priv *tas_dev)
> +{
> +	efi_guid_t efi_guid = EFI_GUID(0x1f52d2a1, 0xbb3a, 0x457d, 0xbc,
> +			0x09, 0x43, 0xa3, 0xf4, 0x31, 0x0a, 0x92);
> +	static efi_char16_t efi_name[] = L"CALI_DATA";
> +	struct tm *tm = &tas_dev->tm;
> +	unsigned int attr = 0, crc;
> +	unsigned int *tmp_val;
> +	efi_status_t status;
> +
> +	tas_dev->cali_data.total_sz = 128;
> +	/* Sometimes, calibration was performed from Windows,
> +	 * and data was saved in UEFI.
> +	 * So we can share it from linux, and data size is variable.
> +	 * Get real size and read it from UEFI.

So what happens if Windows was never installed? Would the calibration be
run from Linux?

I am also not sure what is meant by calibration if there are multiple
devices in a system.  It seems that you are reading ONE variable, so
would the access to the EFI variable be done multiple times?

> +	 */
> +	status = efi.get_variable(efi_name, &efi_guid, &attr,
> +		&tas_dev->cali_data.total_sz, tas_dev->cali_data.data);
> +	if (status == EFI_BUFFER_TOO_SMALL) {
> +		status = efi.get_variable(efi_name, &efi_guid, &attr,
> +			&tas_dev->cali_data.total_sz,
> +			tas_dev->cali_data.data);
> +		dev_dbg(tas_dev->dev, "cali get %lx bytes result:%ld\n",
> +			tas_dev->cali_data.total_sz, status);
> +	}
> +	if (status != 0) {
> +		/* Failed got calibration data from EFI. */
> +		dev_dbg(tas_dev->dev, "No calibration data in UEFI.");
> +		return 0;
> +	}
> +
> +	tmp_val = (unsigned int *)tas_dev->cali_data.data;
> +
> +	crc = crc32(~0, tas_dev->cali_data.data, 84) ^ ~0;
> +
> +	if (crc == tmp_val[21]) {
> +		/* Date and time of calibration was done. */
> +		time64_to_tm(tmp_val[20], 0, tm);
> +		dev_dbg(tas_dev->dev, "%4ld-%2d-%2d, %2d:%2d:%2d\n",
> +			tm->tm_year, tm->tm_mon, tm->tm_mday,
> +			tm->tm_hour, tm->tm_min, tm->tm_sec);
> +		tas2783_apply_calib(tas_dev, tmp_val);
> +	} else {
> +		dev_dbg(tas_dev->dev, "CRC 0x%08x not match 0x%08x\n",
> +			crc, tmp_val[21]);
> +		tas_dev->cali_data.total_sz = 0;
> +	}
> +
> +	return 0;
> +}
> +
> +static void tasdevice_rca_ready(const struct firmware *fmw, void *context)
> +{
> +	struct tasdevice_priv *tas_dev =
> +		(struct tasdevice_priv *) context;

one line

> +	struct tas2783_firmware_node *p;
> +	struct regmap *map = tas_dev->regmap;
> +	unsigned char *buf = NULL;

init not needed

> +	int offset = 0, img_sz;
> +	int ret, value_sdw;
> +
> +	mutex_lock(&tas_dev->codec_lock);
> +
> +	if (!map) {
> +		dev_err(tas_dev->dev, "%s, wrong regmap.\n", __func__);
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	if (!fmw || !fmw->data) {
> +		/* No firmware binary, devices will work in ROM mode. */
> +		dev_err(tas_dev->dev,
> +		"Failed to read %s, no side-effect on driver running\n",
> +		tas_dev->rca_binaryname);
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	buf = (unsigned char *)fmw->data;
> +
> +	img_sz = le32_to_cpup((__le32 *)&buf[offset]);
> +	offset  += sizeof(img_sz);
> +	if (img_sz != fmw->size) {
> +		dev_err(tas_dev->dev, "Size not matching, %d %u",
> +			(int)fmw->size, img_sz);
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	while (offset < img_sz) {
> +		p = (struct tas2783_firmware_node *)(buf + offset);
> +		if (p->length > 1) {
> +			ret = regmap_bulk_write(map, p->download_addr,
> +			buf + offset + sizeof(unsigned int)*5, p->length);

what is 5?

You have missing spaces anyways, this looks like a cast...

> +		} else {
> +			ret = regmap_write(map, p->download_addr,
> +			*(buf + offset + sizeof(unsigned int)*5));
> +		}
> +		if (ret != 0) {
> +			dev_dbg(tas_dev->dev, "Load FW fail: %d.\n", ret);
> +			goto out;
> +		}
> +		offset += sizeof(unsigned int)*5 + p->length;
> +	}
> +	/* Select left-right channel based on unique id. */
> +	value_sdw = 0x1a;
> +	value_sdw += ((tas_dev->sdw_peripheral->id.unique_id & 1) << 4);

what happens if there are more than 2 devices on the same link?

What happens if the two amplifiers are on separate links, in that case
the unique id is irrelevant. IIRC we only use the unique ID if there is
indeed more than one device with the same manufacturer/part ID.

if these are hard-coded assumptions, please add a very detailed comment.

> +	regmap_write(map, TASDEVICE_REG(0, 0, 0x0a), value_sdw);
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
> +	SND_SOC_DAPM_SPK("SPK", NULL),
> +	SND_SOC_DAPM_OUTPUT("OUT"),
> +	SND_SOC_DAPM_INPUT("DMIC")
> +};

v2 comments not addressed:

Can you clarify what "ASI" is?
Also what is the plan for DMIC - this is an amplifier, no?


> +
> +static const struct snd_soc_dapm_route tasdevice_audio_map[] = {
> +	{"SPK", NULL, "ASI"},
> +	{"OUT", NULL, "SPK"},
> +	{"ASI OUT", NULL, "DMIC"}
> +};
> +
> +static int tasdevice_set_sdw_stream(struct snd_soc_dai *dai,
> +	void *sdw_stream, int direction)
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
> +	 snd_soc_dai_dma_data_set(dai, direction, stream);
> +
> +	return 0;
> +}

v2 comments not addressed:

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
> +	struct snd_soc_dai *dai)
> +{
> +	struct sdw_stream_data *stream;
> +
> +	stream = snd_soc_dai_get_dma_data(dai, substream);
> +	snd_soc_dai_set_dma_data(dai, substream, NULL);
> +	kfree(stream);
> +}

v2 comments not adressed:

same, this can be simplified


> +
> +static int tasdevice_sdw_hw_params(struct snd_pcm_substream *substream,
> +	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_component *component = dai->component;
> +	struct tasdevice_priv *tas_priv =
> +		snd_soc_component_get_drvdata(component);
> +	struct sdw_stream_config stream_config = {0};
> +	struct sdw_port_config port_config = {0};
> +	struct sdw_stream_data *stream;
> +	int ret;
> +
> +	dev_dbg(dai->dev, "%s %s", __func__, dai->name);
> +	stream = snd_soc_dai_get_dma_data(dai, substream);
> +
> +	if (!stream)
> +		return -EINVAL;
> +
> +	if (!tas_priv->sdw_peripheral)
> +		return -EINVAL;
> +
> +	/* SoundWire specific configuration */
> +	snd_sdw_params_to_config(substream, params,
> +		&stream_config, &port_config);
> +
> +	/* port 1 for playback */
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +		port_config.num = 1;
> +	else
> +		port_config.num = 2;

earlier you had up to 6 ports listed, what is so special about port1 and
port2? Or what do you use port 3..5 for?

> +
> +	ret = sdw_stream_add_slave(tas_priv->sdw_peripheral,
> +		&stream_config, &port_config, 1, stream->sdw_stream);
> +	if (ret) {
> +		dev_err(dai->dev, "Unable to configure port\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}

> +static int tasdevice_mute(struct snd_soc_dai *dai, int mute,
> +	int direction)
> +{
> +	struct snd_soc_component *component = dai->component;
> +	struct tasdevice_priv *tas_dev =
> +		snd_soc_component_get_drvdata(component);
> +	struct regmap *map = tas_dev->regmap;
> +	int ret;
> +
> +	if (!map) {
> +		dev_err(tas_dev->dev, "%s, wrong regmap.\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	if (mute == 0) {/* Unmute. */
> +		/* FU23 Unmute, 0x40400108. */
> +		ret = regmap_write(map, SDW_SDCA_CTL(1, 2, 1, 0), 0);
> +		ret += regmap_write(map, TASDEVICE_REG(0, 0, 0x02), 0x0);

I've never seen error codes being added, this makes no sense to me...

> +	} else {/* Mute */
> +		/* FU23 mute */
> +		ret = regmap_write(map, SDW_SDCA_CTL(1, 2, 1, 0), 1);
> +		ret += regmap_write(map, TASDEVICE_REG(0, 0, 0x02), 0x1a);
> +	}
> +	if (ret) {
> +		dev_err(tas_dev->dev, "Mute or unmute %d failed %d.\n",
> +			mute, ret);
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct snd_soc_dai_ops tasdevice_dai_ops = {
> +	.mute_stream	= tasdevice_mute,
> +	.hw_params	= tasdevice_sdw_hw_params,
> +	.hw_free	= tasdevice_sdw_pcm_hw_free,
> +	.set_stream	= tasdevice_set_sdw_stream,
> +	.shutdown	= tasdevice_sdw_shutdown,
> +};
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
> +		.ops = &tasdevice_dai_ops,
> +		.symmetric_rate = 1,
> +	},
> +};
> +
> +static void tas2783_reset(struct tasdevice_priv *tas_dev)
> +{
> +	struct regmap *map = tas_dev->regmap;
> +	int ret;
> +
> +	if (!map) {
> +		dev_err(tas_dev->dev, "Failed to load regmap.\n");
> +		return;
> +	}
> +	ret = regmap_write(map, TAS2873_REG_SWRESET, 1);
> +	if (ret) {
> +		dev_err(tas_dev->dev, "Reset failed.\n");
> +		return;
> +	}
> +	usleep_range(1000, 1050);
> +}
> +
> +static int tasdevice_component_probe(struct snd_soc_component *component)
> +{
> +	struct tasdevice_priv *tas_dev =
> +		snd_soc_component_get_drvdata(component);
> +
> +	/* Codec Lock Hold */
> +	mutex_lock(&tas_dev->codec_lock);
> +
> +	tas_dev->component = component;

is locking really necessary?

> +	/* Codec Lock Release*/
> +	mutex_unlock(&tas_dev->codec_lock);
> +
> +	dev_dbg(tas_dev->dev, "%s was called.\n", __func__);
> +
> +	return 0;
> +}
> +
> +static const struct snd_soc_component_driver
> +	soc_codec_driver_tasdevice = {
> +	.probe		= tasdevice_component_probe,
> +	.controls	= tas2783_snd_controls,
> +	.num_controls	= ARRAY_SIZE(tas2783_snd_controls),
> +	.dapm_widgets	= tasdevice_dapm_widgets,
> +	.num_dapm_widgets = ARRAY_SIZE(tasdevice_dapm_widgets),
> +	.dapm_routes	= tasdevice_audio_map,
> +	.num_dapm_routes = ARRAY_SIZE(tasdevice_audio_map),
> +	.idle_bias_on	= 1,
> +	.endianness	= 1,
> +};
> +
> +static int tasdevice_init(struct tasdevice_priv *tas_dev)
> +{
> +	int ret;
> +
> +	dev_set_drvdata(tas_dev->dev, tas_dev);
> +
> +	mutex_init(&tas_dev->codec_lock);
> +	ret = devm_snd_soc_register_component(tas_dev->dev,
> +		&soc_codec_driver_tasdevice,
> +		tasdevice_dai_driver, ARRAY_SIZE(tasdevice_dai_driver));
> +	if (ret) {
> +		dev_err(tas_dev->dev, "%s: codec register error:%d.\n",
> +			__func__, ret);
> +	}
> +
> +	tas2783_reset(tas_dev);
> +	/* tas2783-8[9,...,f].bin was copied into /lib/firmware/ */

don't you need a /lib/firmware/ti/ path?

And shouldn't this OEM-specific? This isn't going to work well for
distributions in this include calibrated data that need to be different
for each form-factor.

> +	scnprintf(tas_dev->rca_binaryname, 64, "tas2783-%01x.bin",
> +		tas_dev->sdw_peripheral->id.unique_id);
> +
> +	ret = request_firmware_nowait(THIS_MODULE, FW_ACTION_UEVENT,
> +		tas_dev->rca_binaryname, tas_dev->dev, GFP_KERNEL,
> +		tas_dev, tasdevice_rca_ready);
> +	if (ret) {
> +		dev_dbg(tas_dev->dev,
> +		"%s: request_firmware %x open status: %d.\n",
> +		__func__, tas_dev->sdw_peripheral->id.unique_id, ret);
> +	}
> +
> +	/* set autosuspend parameters */
> +	pm_runtime_set_autosuspend_delay(tas_dev->dev, 3000);
> +	pm_runtime_use_autosuspend(tas_dev->dev);
> +
> +	/* make sure the device does not suspend immediately */
> +	pm_runtime_mark_last_busy(tas_dev->dev);
> +
> +	pm_runtime_enable(tas_dev->dev);
> +
> +	dev_dbg(tas_dev->dev, "%s was called for TAS2783.\n",  __func__);
> +
> +	return ret;
> +}
> +
> +static int tasdevice_read_prop(struct sdw_slave *slave)
> +{
> +	struct sdw_slave_prop *prop = &slave->prop;
> +	int nval;
> +	int i, j;
> +	u32 bit;
> +	unsigned long addr;
> +	struct sdw_dpn_prop *dpn;
> +
> +	prop->scp_int1_mask =
> +		SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
> +	prop->quirks = SDW_SLAVE_QUIRKS_INVALID_INITIAL_PARITY;
> +
> +	prop->paging_support = true;
> +
> +	/* first we need to allocate memory for set bits in port lists */
> +	prop->source_ports = 0x04; /* BITMAP: 00000100 */
> +	prop->sink_ports = 0x2; /* BITMAP:  00000010 */

now you only declare port1 and port2 so the regmap comment was indeed
completely wrong.

> +	nval = hweight32(prop->source_ports);
> +	prop->src_dpn_prop = devm_kcalloc(&slave->dev, nval,
> +		sizeof(*prop->src_dpn_prop), GFP_KERNEL);
> +	if (!prop->src_dpn_prop)
> +		return -ENOMEM;
> +
> +	i = 0;
> +	dpn = prop->src_dpn_prop;
> +	addr = prop->source_ports;
> +	for_each_set_bit(bit, &addr, 32) {
> +		dpn[i].num = bit;
> +		dpn[i].type = SDW_DPN_FULL;
> +		dpn[i].simple_ch_prep_sm = true;
> +		dpn[i].ch_prep_timeout = 10;
> +		i++;
> +	}
> +
> +	/* do this again for sink now */
> +	nval = hweight32(prop->sink_ports);
> +	prop->sink_dpn_prop = devm_kcalloc(&slave->dev, nval,
> +		sizeof(*prop->sink_dpn_prop), GFP_KERNEL);
> +	if (!prop->sink_dpn_prop)
> +		return -ENOMEM;
> +
> +	j = 0;
> +	dpn = prop->sink_dpn_prop;
> +	addr = prop->sink_ports;
> +	for_each_set_bit(bit, &addr, 32) {
> +		dpn[j].num = bit;
> +		dpn[j].type = SDW_DPN_FULL;
> +		dpn[j].simple_ch_prep_sm = true;
> +		dpn[j].ch_prep_timeout = 10;
> +		j++;
> +	}
> +
> +	/* set the timeout values */
> +	prop->clk_stop_timeout = 20;
> +
> +	return 0;
> +}
> +
> +static int tasdevice_io_init(struct device *dev, struct sdw_slave *slave)
> +{
> +	struct tasdevice_priv *tas_priv = dev_get_drvdata(dev);
> +
> +	if (tas_priv->hw_init)
> +		return 0;
> +
> +	/* Mark Slave initialization complete */
> +	tas_priv->hw_init = true;
> +
> +	return 0;

v2 comment not adressed:


This is really not aligned with the latest upstream code. Intel (and
specifically me myself and I) contributed a change where the pm_runtime
is enabled in the driver probe, but the device status changes to active
in the io_init.

In addition, it's rather surprising that on attachment there is not a
single regmap access?

> +}
> +
> +static int tasdevice_update_status(struct sdw_slave *slave,
> +	enum sdw_slave_status status)
> +{
> +	struct  tasdevice_priv *tas_priv = dev_get_drvdata(&slave->dev);
> +
> +	/* Update the status */
> +	tas_priv->status = status;
> +
> +	if (status == SDW_SLAVE_UNATTACHED)
> +		tas_priv->hw_init = false;
> +
> +	/* Perform initialization only if slave status
> +	 * is present and hw_init flag is false
> +	 */
> +	if (tas_priv->hw_init || tas_priv->status != SDW_SLAVE_ATTACHED)
> +		return 0;
> +
> +	/* perform I/O transfers required for Slave initialization */
> +	return tasdevice_io_init(&slave->dev, slave);
> +}
> +
> +/*
> + * slave_ops: callbacks for get_clock_stop_mode, clock_stop and
> + * port_prep are not defined for now
> + */
> +static const struct sdw_slave_ops tasdevice_sdw_ops = {
> +	.read_prop	= tasdevice_read_prop,
> +	.update_status	= tasdevice_update_status,
> +};
> +
> +static void tasdevice_remove(struct tasdevice_priv *tas_dev)
> +{
> +	snd_soc_unregister_component(tas_dev->dev);

no. you've used

ret = devm_snd_soc_register_component(tas_dev->dev,
	&soc_codec_driver_tasdevice,

earlier

Pick one. Either devm_ or no devm_

> +
> +	mutex_destroy(&tas_dev->codec_lock);
> +}
> +
> +static int tasdevice_sdw_probe(struct sdw_slave *peripheral,
> +	const struct sdw_device_id *id)
> +{
> +	struct device *dev = &peripheral->dev;
> +	struct tasdevice_priv *tas_dev;
> +	int ret;
> +
> +	tas_dev = devm_kzalloc(dev, sizeof(*tas_dev), GFP_KERNEL);
> +	if (!tas_dev) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +	tas_dev->dev = dev;
> +	tas_dev->chip_id = id->driver_data;
> +	tas_dev->sdw_peripheral = peripheral;
> +	tas_dev->hw_init = false;
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
> +}
> +
> +static int tasdevice_sdw_remove(struct sdw_slave *peripheral)
> +{
> +	struct tasdevice_priv *tas_dev = dev_get_drvdata(&peripheral->dev);
> +
> +	if (tas_dev) {
> +		pm_runtime_disable(tas_dev->dev);
> +		tasdevice_remove(tas_dev);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct sdw_device_id tasdevice_sdw_id[] = {
> +	SDW_SLAVE_ENTRY(0x0102, 0x0000, 0),
> +	{},
> +};
> +MODULE_DEVICE_TABLE(sdw, tasdevice_sdw_id);
> +
> +static struct sdw_driver tasdevice_sdw_driver = {
> +	.driver = {
> +		.name = "slave-tas2783",
> +	},
> +	.probe = tasdevice_sdw_probe,
> +	.remove = tasdevice_sdw_remove,
> +	.ops = &tasdevice_sdw_ops,
> +	.id_table = tasdevice_sdw_id,
> +};
> +
> +module_sdw_driver(tasdevice_sdw_driver);
> +
> +MODULE_AUTHOR("Baojun Xu <baojun.xu@ti.com>");
> +MODULE_DESCRIPTION("ASoC TAS2783 SoundWire Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/sound/soc/codecs/tas2783.h b/sound/soc/codecs/tas2783.h
> new file mode 100644
> index 000000000000..1fe56f05b9d9
> --- /dev/null
> +++ b/sound/soc/codecs/tas2783.h
> @@ -0,0 +1,100 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * ALSA SoC Texas Instruments TAS2781 Audio Smart Amplifier
> + *
> + * Copyright (C) 2023 Texas Instruments Incorporated
> + * https://www.ti.com
> + *
> + * The TAS2783 driver implements a flexible and configurable
> + * algo coff setting for single TAS2783 chips.
> + *
> + * Author: Baojun Xu <baojun.xu@ti.com>
> + */
> +
> +#ifndef __TAS2783_H__
> +#define __TAS2783_H__
> +
> +#define TAS2783_DEVICE_RATES	(SNDRV_PCM_RATE_44100 | \
> +				SNDRV_PCM_RATE_48000 | \
> +				SNDRV_PCM_RATE_96000 | \
> +				SNDRV_PCM_RATE_88200)
> +
> +#define TAS2783_DEVICE_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
> +				SNDRV_PCM_FMTBIT_S24_LE | \
> +				SNDRV_PCM_FMTBIT_S32_LE)
> +
> +/* BOOK, PAGE Control Register */
> +#define TASDEVICE_REG(book, page, reg)	((book * 256 * 256) + 0x8000 +\
> +					(page * 128) + reg)
> +
> +/*Software Reset */

v2 comment not addressed

/* Software Reset */

Run checkpatch.pl please

