Return-Path: <linux-kernel+bounces-71794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C1D85AA90
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB8901C2136E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4326F481C0;
	Mon, 19 Feb 2024 18:06:32 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39970481B1
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 18:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708365990; cv=none; b=m39E8HgRD5FViBF2JELy93x8yAhkq88wQ9hUjX04Yz6hAp+/HVIWKFZkfDAtbaGLpLX5VGWEwUAiC3FdfGQslP/dND2yKOxiSghpoGS4SeuSJreDPSdnBeavX80RfkKb+P/19cFNTvlx1zI8m9G2HjseNtaYLyTlzK4ikQGDJPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708365990; c=relaxed/simple;
	bh=KF1pZCe/DWR9/2VkjXJshGf9HNPhEh40rWQFs3PVeIo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V6+m/aP5hNg4fpAinMjcA95CDEu1NNt6av5HrBXFyWR2XZQug0TWWccnjf0At32UYBqzClAEJ8Oft6IZC1LoCLDElAXNWjVN5z3waLV5p0ehS3uea3FD/tJewfJm8ygjpn0FgAvYBUs2XOp3TMEP3T2Dcd2i6oHiiK62YPnIM7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from [192.168.2.4] (51b68f08.dsl.pool.telekom.hu [::ffff:81.182.143.8])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 00000000000734F0.0000000065D398A0.001D087C; Mon, 19 Feb 2024 19:06:24 +0100
Message-ID: <646973c48c4ee30c92de98aa027992e8ccdd325d.camel@irl.hu>
Subject: Re: [PATCH v8] ASoc: tas2783: Add tas2783 codec driver
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, broonie@kernel.org
Cc: andriy.shevchenko@linux.intel.com, lgirdwood@gmail.com,
  perex@perex.cz, pierre-louis.bossart@linux.intel.com,
  13916275206@139.com, alsa-devel@alsa-project.org,
  linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com,
  bard.liao@intel.com, mengdong.lin@intel.com,
  yung-chuan.liao@linux.intel.com, baojun.xu@ti.com, kevin-lu@ti.com,
  tiwai@suse.de
Date: Mon, 19 Feb 2024 19:06:23 +0100
In-Reply-To: <20240219022153.553-1-shenghao-ding@ti.com>
References: <20240219022153.553-1-shenghao-ding@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Shenghao,

On Mon, 2024-02-19 at 10:21 +0800, Shenghao Ding wrote:
> The tas2783 is a smart audio amplifier with integrated MIPI SoundWire
> interface (Version 1.2.1 compliant), I2C, and I2S/TDM interfaces designed
> for portable applications. An on-chip DSP supports Texas Instruments
> SmartAmp speaker protection algorithm. The integrated speaker voltage and
> current sense provides for real-time monitoring of lodspeakers.
>=20
> The ASoC component provides the majority of the functionality of the
> device, all the audio functions.
>=20
> Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
>=20
> ---
> Change in v8:
>  - simplify tasdevice_set_sdw_stream
>  - fixed some Linux coding style
>  - fixed the spelling mistakes
>  - Select left/right channel based on unique id
>  - a longer description has been added
>  - remove unused crc8 in KCONFIG
>  - Invert of RE here means reciprocal of RE
>  - correct indentation
>  - correct the wrong pow calibrated register
>  - correct comment on RESET register
>  - fixed usually lines don't end with an open parenthesis
>  - fixed tasdevice_sdw_shutdown
>  - use defines for function, entity, etc. for readable
>  - remove unnecessary codec_lock in component_probe()
>  - remove struct sdw_stream_data
>  - remove unused macro definitions
>  - use BIT(2) and BIT(1) instead of 0x2 and 0x1
>  - implement pm_runtime
>  - reg_start is u8, reg_start + i only adds i byte, it should be
>    reg_start + i * 4, because the calibration values
>  - fixed total_sz in tas2783_calibration
>  - add a define for TASDEVICE_REG(0, 0, 0x0a)
>  - rework macro style in header file
>  - Add select CRC32
>  - rewrite the mute and the return value handling
>  - Add comments on bin file
>  - Add link_id into the fw name to distinguish the same sdw id on differe=
nt
>    sdw id.
>  - remove unnecessary mutex_lock
>  - use set_active() in tasdevice_io_init and move all other parts in the
>    probe.
>  - move pm_runtime_get_noresume to the probe
>  - fix the return value of putvol function
>  - add put_noidle in tasdevice_sdw_remove
>  - remove unused header file(of.h)
>  - correct the style of the multi-line comment
>  - Set the readable registers in tas2783_readable_register for debugfs
>  - Use new PM macros
>  - Use default put and get inline SOC_SINGLE_RANGE_TLV and
>    SOC_SINGLE_SX_TLV
>  - Use respective %pt to log the calibrated time
>  - Remove unnecessary struct tm
>  - Add trailing comma tasdevice_dapm_widgets and tasdevice_audio_map
>  - Rewrite the return value handling in tasdevice_sdw_probe
>  - use dev_num instead of id.unique_id
>  - rework the log
> ---
>  sound/soc/codecs/Kconfig       |  16 +
>  sound/soc/codecs/Makefile      |   2 +
>  sound/soc/codecs/tas2783-sdw.c | 844 +++++++++++++++++++++++++++++++++
>  sound/soc/codecs/tas2783.h     | 103 ++++
>  4 files changed, 965 insertions(+)
>  create mode 100644 sound/soc/codecs/tas2783-sdw.c
>  create mode 100644 sound/soc/codecs/tas2783.h
>=20
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index 59f9742e9ff4..6ba3fd0c0811 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -247,6 +247,7 @@ config SND_SOC_ALL_CODECS
>  	imply SND_SOC_TAS2781_COMLIB
>  	imply SND_SOC_TAS2781_FMWLIB
>  	imply SND_SOC_TAS2781_I2C
> +	imply SND_SOC_TAS2783
>  	imply SND_SOC_TAS5086
>  	imply SND_SOC_TAS571X
>  	imply SND_SOC_TAS5720
> @@ -1847,6 +1848,21 @@ config SND_SOC_TAS2781_I2C
>  	  algo coefficient setting, for one, two or even multiple TAS2781
>  	  chips.
> =20
> +config SND_SOC_TAS2783
> +	tristate "Texas Instruments TAS2783 speaker amplifier (sdw)"
> +	depends on SOUNDWIRE
> +	depends on EFI
> +	select REGMAP
> +	select REGMAP_SOUNDWIRE
> +	select CRC32
> +	select CRC32_SARWATE
> +	help
> +	  Enable support for Texas Instruments TAS2783 Smart Amplifier
> +	  Digital input mono Class-D and DSP-inside audio power amplifiers.
> +	  TAS2783 supports the MIPI SoundWire v1.2 compatible interface
> +	  for audio and control data. At the end of calibrated data appends
> +	  the crc data with crc32_sarwate for error detection.
> +
>  config SND_SOC_TAS5086
>  	tristate "Texas Instruments TAS5086 speaker amplifier"
>  	depends on I2C
> diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
> index f53baa2b9565..6afceb126ae3 100644
> --- a/sound/soc/codecs/Makefile
> +++ b/sound/soc/codecs/Makefile
> @@ -284,6 +284,7 @@ snd-soc-tas2770-objs :=3D tas2770.o
>  snd-soc-tas2781-comlib-objs :=3D tas2781-comlib.o
>  snd-soc-tas2781-fmwlib-objs :=3D tas2781-fmwlib.o
>  snd-soc-tas2781-i2c-objs :=3D tas2781-i2c.o
> +snd-soc-tas2783-objs :=3D tas2783-sdw.o
>  snd-soc-tfa9879-objs :=3D tfa9879.o
>  snd-soc-tfa989x-objs :=3D tfa989x.o
>  snd-soc-tlv320adc3xxx-objs :=3D tlv320adc3xxx.o
> @@ -664,6 +665,7 @@ obj-$(CONFIG_SND_SOC_TAS2780)	+=3D snd-soc-tas2780.o
>  obj-$(CONFIG_SND_SOC_TAS2781_COMLIB)	+=3D snd-soc-tas2781-comlib.o
>  obj-$(CONFIG_SND_SOC_TAS2781_FMWLIB)	+=3D snd-soc-tas2781-fmwlib.o
>  obj-$(CONFIG_SND_SOC_TAS2781_I2C)	+=3D snd-soc-tas2781-i2c.o
> +obj-$(CONFIG_SND_SOC_TAS2783)	+=3D snd-soc-tas2783.o
>  obj-$(CONFIG_SND_SOC_TAS5086)	+=3D snd-soc-tas5086.o
>  obj-$(CONFIG_SND_SOC_TAS571X)	+=3D snd-soc-tas571x.o
>  obj-$(CONFIG_SND_SOC_TAS5720)	+=3D snd-soc-tas5720.o
> diff --git a/sound/soc/codecs/tas2783-sdw.c b/sound/soc/codecs/tas2783-sd=
w.c
> new file mode 100644
> index 000000000000..ebb7102828c5
> --- /dev/null
> +++ b/sound/soc/codecs/tas2783-sdw.c
> @@ -0,0 +1,844 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// ALSA SoC Texas Instruments TAS2783 Audio Smart Amplifier
> +//
> +// Copyright (C) 2023 - 2024 Texas Instruments Incorporated
> +// https://www.ti.com
> +//
> +// Author: Baojun Xu <baojun.xu@ti.com>
> +//	Kevin Lu <kevin-lu@ti.com>
> +//	Shenghao Ding <shenghao-ding@ti.com>
> +//
> +
> +#include <asm/unaligned.h>
> +#include <linux/acpi.h>
> +#include <linux/crc32.h>
> +#include <linux/efi.h>
> +#include <linux/err.h>
> +#include <linux/firmware.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/pm.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/soundwire/sdw.h>
> +#include <linux/soundwire/sdw_registers.h>
> +#include <linux/soundwire/sdw_type.h>
> +#include <sound/pcm_params.h>
> +#include <sound/sdw.h>
> +#include <sound/soc.h>
> +#include <sound/tlv.h>
> +
> +#include <sound/tas2781-tlv.h>
> +#include "tas2783.h"
> +
> +static const unsigned int tas2783_cali_reg[] =3D {
> +	TAS2783_CALIBRATION_RE,		/* Resistance */
> +	TAS2783_CALIBRATION_RE_LOW,	/* Low limitation of RE */
> +	TAS2783_CALIBRATION_INV_RE,	/* Reciprocal of RE */
> +	TAS2783_CALIBRATION_POW,	/* RMS Power */
> +	TAS2783_CALIBRATION_TLIMIT	/* Temperature limitation */
> +};
> +
> +static const struct reg_default tas2783_reg_defaults[] =3D {
> +	/* Default values for ROM mode. Activated. */
> +	{ 0x8002, 0x1a },	/* AMP inactive. */
> +	{ 0x8097, 0xc8 },
> +	{ 0x80b5, 0x74 },
> +	{ 0x8099, 0x20 },
> +	{ 0xfe8d, 0x0d },
> +	{ 0xfebe, 0x4a },
> +	{ 0x8230, 0x00 },
> +	{ 0x8231, 0x00 },
> +	{ 0x8232, 0x00 },
> +	{ 0x8233, 0x01 },
> +	{ 0x8418, 0x00 },	/* Set volume to 0 dB. */
> +	{ 0x8419, 0x00 },
> +	{ 0x841a, 0x00 },
> +	{ 0x841b, 0x00 },
> +	{ 0x8428, 0x40 },	/* Unmute channel */
> +	{ 0x8429, 0x00 },
> +	{ 0x842a, 0x00 },
> +	{ 0x842b, 0x00 },
> +	{ 0x8548, 0x00 },	/* Set volume to 0 dB. */
> +	{ 0x8549, 0x00 },
> +	{ 0x854a, 0x00 },
> +	{ 0x854b, 0x00 },
> +	{ 0x8558, 0x40 },	/* Unmute channel */
> +	{ 0x8559, 0x00 },
> +	{ 0x855a, 0x00 },
> +	{ 0x855b, 0x00 },
> +	{ 0x800a, 0x3a },	/* Enable both channel */
> +	{ 0x800e, 0x44 },
> +	{ 0x800f, 0x40 },
> +	{ 0x805c, 0x99 },
> +	{ SDW_SDCA_CTL(TAS2783_FUNC_TYPE_SMART_AMP, TAS2783_SDCA_ENT_FU21,
> +		TAS2783_SDCA_CTL_FU_MUTE, 0), 0 },
> +	{ SDW_SDCA_CTL(TAS2783_FUNC_TYPE_SMART_AMP, TAS2783_SDCA_ENT_FU21,
> +		TAS2783_SDCA_CTL_FU_VOLUME, 0), 0 },
> +	{ SDW_SDCA_CTL(TAS2783_FUNC_TYPE_SMART_AMP, TAS2783_SDCA_ENT_FU23,
> +		TAS2783_SDCA_CTL_FU_MUTE, 0), 0 },
> +};
> +
> +static bool tas2783_readable_register(struct device *dev,
> +	unsigned int reg)
> +{
> +	switch (reg) {
> +	case 0x8000 ... 0x807F:	/* Page 0 */
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool tas2783_volatile_register(struct device *dev,
> +	unsigned int reg)
> +{
> +	switch (reg) {
> +	/*
> +	 * Only software reset register was volatiled.
> +	 * Bit is self clearing.
> +	 * 0b =3D Don't reset
> +	 * 1b =3D reset
> +	 */
> +	case 0x8001:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static const struct regmap_config tasdevice_regmap =3D {
> +	.reg_bits =3D 32,
> +	.val_bits =3D 8,
> +	.readable_reg =3D tas2783_readable_register,
> +	.volatile_reg =3D tas2783_volatile_register,
> +	.max_register =3D 0x44ffffff,
> +	.reg_defaults =3D tas2783_reg_defaults,
> +	.num_reg_defaults =3D ARRAY_SIZE(tas2783_reg_defaults),
> +	.cache_type =3D REGCACHE_RBTREE,
> +	.use_single_read =3D true,
> +	.use_single_write =3D true,
> +};
> +
> +static const struct snd_kcontrol_new tas2783_snd_controls[] =3D {
> +	SOC_SINGLE_RANGE_TLV("Digital Volume", TAS2783_DVC_LVL,
> +		0, 0, 200, 1, dvc_tlv),
> +	SOC_SINGLE_SX_TLV("Amp Gain Volume", TAS2783_AMP_LEVEL,
> +		1, 0, 20, amp_vol_tlv),
> +};
> +
> +static void tas2783_apply_calib(struct tasdevice_priv *tas_dev,
> +	unsigned int *cali_data)
> +{
> +	struct regmap *map =3D tas_dev->regmap;
> +	u8 *cali_start;
> +	u16 dev_num;
> +	int ret;
> +
> +	if (!tas_dev->sdw_peripheral) {
> +		dev_err(tas_dev->dev, "%s: peripheral doesn't exist.\n",
> +			__func__);
> +		return;
> +	}
> +
> +	dev_num =3D clamp(tas_dev->sdw_peripheral->dev_num, 1, 4) - 1;
> +	/*
> +	 * The area saving tas2783 calibrated data is specified by its
> +	 * dev_num. cali_start is the first address of current tas2783's
> +	 * calibrated data.
> +	 */
> +	cali_start =3D (u8 *)(cali_data + dev_num * sizeof(tas2783_cali_reg));
> +	for (int i =3D 0; i < ARRAY_SIZE(tas2783_cali_reg); i++) {
> +		ret =3D regmap_bulk_write(map, tas2783_cali_reg[i],
> +			&cali_start[4 * i], 4);
> +		if (ret) {
> +			dev_err(tas_dev->dev, "Cali failed %x:%d\n",
> +				tas2783_cali_reg[i], ret);
> +			break;
> +		}
> +	}
> +}
> +
> +/*
> + * Load the calibration data, including speaker impedance, f0, etc.
> + * Calibration is done by the manufacturer in the factory. The calibrati=
on
> + * data are used by the algorithm for calculating the speaker temperatur=
e,
> + * speaker membrane excursion and f0 in real time during playback.
> + * The DSP will work with default data values if calibrated data are
> + * missing or are invalid.
> + * Layout of calibrated Data in UEFI:
> + *	Calibrated Data of Dev 0 (20 bytes)
> + *	Calibrated Data of Dev 1 (20 bytes)
> + *	Calibrated Data of Dev 2 (20 bytes)
> + *	Calibrated Data of Dev 3 (20 bytes)
> + *	CRC (4 bytes)
> + */
> +static void tas2783_calibration(struct tasdevice_priv *tas_dev)
> +{
> +	efi_guid_t efi_guid =3D EFI_GUID(0x1f52d2a1, 0xbb3a, 0x457d, 0xbc,
> +			0x09, 0x43, 0xa3, 0xf4, 0x31, 0x0a, 0x92);
> +	static efi_char16_t efi_name[] =3D L"CALI_DATA";
> +	unsigned int attr =3D 0, crc;
> +	unsigned int *tmp_val;
> +	efi_status_t status;
> +
> +	tas_dev->cali_data.total_sz =3D 0;
> +
> +	status =3D efi.get_variable(efi_name, &efi_guid, &attr,
> +		&tas_dev->cali_data.total_sz, tas_dev->cali_data.data);
> +	if (status =3D=3D EFI_BUFFER_TOO_SMALL) {
> +		status =3D efi.get_variable(efi_name, &efi_guid, &attr,
> +			&tas_dev->cali_data.total_sz,
> +			tas_dev->cali_data.data);

How do you check if the EFI variable is not longer than the fixed size
cali_data.data buffer?

Thanks,
Gergo

> +		dev_dbg(tas_dev->dev, "cali get %lx bytes result:%ld\n",
> +			tas_dev->cali_data.total_sz, status);
> +	}
> +	if (status !=3D 0) {
> +		/* Failed got calibration data from EFI. */
> +		dev_dbg(tas_dev->dev, "No calibration data in UEFI.");
> +		return;
> +	}
> +
> +	tmp_val =3D (unsigned int *)tas_dev->cali_data.data;
> +
> +	crc =3D crc32(~0, tas_dev->cali_data.data, 84) ^ ~0;
> +
> +	if (crc =3D=3D tmp_val[21]) {
> +		/* Date and time of when calibration was done. */
> +		tas2783_apply_calib(tas_dev, tmp_val);
> +		dev_dbg(tas_dev->dev, "%ptTs", &tmp_val[20]);
> +	} else {
> +		dev_dbg(tas_dev->dev, "CRC 0x%08x not match 0x%08x\n",
> +			crc, tmp_val[21]);
> +		tas_dev->cali_data.total_sz =3D 0;
> +	}
> +}
> +
> +static void tasdevice_dspfw_ready(const struct firmware *fmw,
> +	void *context)
> +{
> +	struct tasdevice_priv *tas_dev =3D
> +		(struct tasdevice_priv *) context;
> +	struct tas2783_firmware_node *p;
> +	struct regmap *map =3D tas_dev->regmap;
> +	unsigned char *buf =3D NULL;
> +	int offset =3D 0, img_sz;
> +	int ret;
> +
> +	if (!fmw || !fmw->data) {
> +		dev_warn(tas_dev->dev,
> +			"%s: failed to read %s: work in bypass-dsp mode.\n",
> +			__func__, tas_dev->dspfw_binaryname);
> +		return;
> +	}
> +	buf =3D (unsigned char *)fmw->data;
> +
> +	img_sz =3D get_unaligned_le32(&buf[offset]);
> +	offset  +=3D sizeof(img_sz);
> +	if (img_sz !=3D fmw->size) {
> +		dev_warn(tas_dev->dev, "%s: size not matching, %d %u.",
> +			__func__, (int)fmw->size, img_sz);
> +		return;
> +	}
> +
> +	while (offset < img_sz) {
> +		p =3D (struct tas2783_firmware_node *)(buf + offset);
> +		if (p->length > 1) {
> +			ret =3D regmap_bulk_write(map, p->download_addr,
> +			buf + offset + sizeof(unsigned int) * 5, p->length);
> +		} else {
> +			ret =3D regmap_write(map, p->download_addr,
> +				*(buf + offset + sizeof(unsigned int) * 5));
> +		}
> +
> +		if (ret !=3D 0) {
> +			dev_dbg(tas_dev->dev,
> +				"%s: load FW fail: %d, work in bypass.\n",
> +				__func__, ret);
> +			return;
> +		}
> +		offset +=3D sizeof(unsigned int) * 5 + p->length;
> +	}
> +
> +	tas2783_calibration(tas_dev);
> +}
> +
> +static const struct snd_soc_dapm_widget tasdevice_dapm_widgets[] =3D {
> +	SND_SOC_DAPM_AIF_IN("ASI", "ASI Playback", 0, SND_SOC_NOPM, 0, 0),
> +	SND_SOC_DAPM_AIF_OUT("ASI OUT", "ASI Capture", 0, SND_SOC_NOPM, 0, 0),
> +	SND_SOC_DAPM_OUTPUT("OUT"),
> +	SND_SOC_DAPM_INPUT("DMIC"),
> +};
> +
> +static const struct snd_soc_dapm_route tasdevice_audio_map[] =3D {
> +	{"OUT", NULL, "ASI"},
> +	{"ASI OUT", NULL, "DMIC"},
> +};
> +
> +static int tasdevice_set_sdw_stream(struct snd_soc_dai *dai,
> +	void *sdw_stream, int direction)
> +{
> +	snd_soc_dai_dma_data_set(dai, direction, sdw_stream);
> +
> +	return 0;
> +}
> +
> +static void tasdevice_sdw_shutdown(struct snd_pcm_substream *substream,
> +	struct snd_soc_dai *dai)
> +{
> +	snd_soc_dai_set_dma_data(dai, substream, NULL);
> +}
> +
> +static int tasdevice_sdw_hw_params(struct snd_pcm_substream *substream,
> +	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_component *component =3D dai->component;
> +	struct tasdevice_priv *tas_priv =3D
> +		snd_soc_component_get_drvdata(component);
> +	struct sdw_stream_config stream_config =3D {0};
> +	struct sdw_port_config port_config =3D {0};
> +	struct sdw_stream_runtime *sdw_stream;
> +	int ret;
> +
> +	dev_dbg(dai->dev, "%s: dai_name %s", __func__, dai->name);
> +	sdw_stream =3D snd_soc_dai_get_dma_data(dai, substream);
> +
> +	if (!sdw_stream)
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
> +	if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
> +		port_config.num =3D 1;
> +	else
> +		port_config.num =3D 2;
> +
> +	ret =3D sdw_stream_add_slave(tas_priv->sdw_peripheral,
> +		&stream_config, &port_config, 1, sdw_stream);
> +	if (ret) {
> +		dev_err(dai->dev, "%s: Unable to configure port\n", __func__);
> +		return ret;
> +	}
> +
> +	dev_dbg(dai->dev, "%s: format: %i rate: %i\n", __func__,
> +		params_format(params), params_rate(params));
> +
> +	return 0;
> +}
> +
> +static int tasdevice_sdw_pcm_hw_free(struct snd_pcm_substream *substream=
,
> +	struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_component *component =3D dai->component;
> +	struct tasdevice_priv *tas_priv =3D
> +		snd_soc_component_get_drvdata(component);
> +	struct sdw_stream_runtime *sdw_stream =3D
> +		snd_soc_dai_get_dma_data(dai, substream);
> +
> +	if (!tas_priv->sdw_peripheral)
> +		return -EINVAL;
> +
> +	sdw_stream_remove_slave(tas_priv->sdw_peripheral, sdw_stream);
> +
> +	return 0;
> +}
> +
> +static int tasdevice_mute(struct snd_soc_dai *dai, int mute,
> +	int direction)
> +{
> +	struct snd_soc_component *component =3D dai->component;
> +	struct tasdevice_priv *tas_dev =3D
> +		snd_soc_component_get_drvdata(component);
> +	struct regmap *map =3D tas_dev->regmap;
> +	int ret;
> +
> +	dev_dbg(tas_dev->dev, "%s: %d.\n", __func__, mute);
> +
> +	if (mute) {
> +		if (direction =3D=3D SNDRV_PCM_STREAM_CAPTURE) {
> +			ret =3D regmap_update_bits(map, TAS2873_REG_PWR_CTRL,
> +				TAS2783_REG_AEF_MASK,
> +				TAS2783_REG_AEF_INACTIVE);
> +			if (ret)
> +				dev_err(tas_dev->dev,
> +					"%s: Disable AEF failed.\n", __func__);
> +		} else {
> +			/* FU23 mute (0x40400108) */
> +			ret =3D regmap_write(map,
> +				SDW_SDCA_CTL(TAS2783_FUNC_TYPE_SMART_AMP,
> +				TAS2783_SDCA_ENT_FU23,
> +				TAS2783_SDCA_CTL_FU_MUTE, 0), 1);
> +			if (ret) {
> +				dev_err(tas_dev->dev,
> +					"%s: FU23 mute failed.\n", __func__);
> +				goto out;
> +			}
> +			/*
> +			 * Both playback and echo data will be shutdown in
> +			 * playback stream.
> +			 */
> +			ret =3D regmap_update_bits(map, TAS2873_REG_PWR_CTRL,
> +				TAS2783_REG_PWR_MODE_MASK |
> +				TAS2783_REG_AEF_MASK,
> +				TAS2783_REG_PWR_MODE_ACTIVE |
> +				TAS2783_REG_PWR_MODE_SW_PWD);
> +			if (ret) {
> +				dev_err(tas_dev->dev,
> +					"%s: PWR&AEF shutdown failed.\n",
> +					__func__);
> +				goto out;
> +			}
> +			tas_dev->pstream =3D false;
> +		}
> +	} else {
> +		/* FU23 Unmute, 0x40400108. */
> +		if (direction =3D=3D SNDRV_PCM_STREAM_PLAYBACK) {
> +			ret =3D regmap_write(map,
> +				SDW_SDCA_CTL(TAS2783_FUNC_TYPE_SMART_AMP,
> +				TAS2783_SDCA_ENT_FU23,
> +				TAS2783_SDCA_CTL_FU_MUTE, 0), 0);
> +			if (ret) {
> +				dev_err(tas_dev->dev,
> +					"%s: FU23 Unmute failed.\n", __func__);
> +				goto out;
> +			}
> +			ret =3D regmap_update_bits(map, TAS2873_REG_PWR_CTRL,
> +				TAS2783_REG_PWR_MODE_MASK,
> +				TAS2783_REG_PWR_MODE_ACTIVE);
> +			if (ret) {
> +				dev_err(tas_dev->dev,
> +					"%s: PWR Unmute failed.\n", __func__);
> +				goto out;
> +			}
> +			tas_dev->pstream =3D true;
> +		} else {
> +			/* Capture stream is the echo ref data for voice.
> +			 * Without playback, it can't be active.
> +			 */
> +			if (tas_dev->pstream =3D=3D true) {
> +				ret =3D regmap_update_bits(map,
> +					TAS2873_REG_PWR_CTRL,
> +					TAS2783_REG_AEF_MASK,
> +					TAS2783_REG_AEF_ACTIVE);
> +				if (ret) {
> +					dev_err(tas_dev->dev,
> +						"%s: AEF enable failed.\n",
> +						__func__);
> +					goto out;
> +				}
> +			} else {
> +				dev_err(tas_dev->dev,
> +					"%s: No playback, no AEF!", __func__);
> +				ret =3D -EINVAL;
> +			}
> +		}
> +	}
> +out:
> +	if (ret)
> +		dev_err(tas_dev->dev, "Mute or unmute %d failed %d.\n",
> +			mute, ret);
> +
> +	return ret;
> +}
> +
> +static const struct snd_soc_dai_ops tasdevice_dai_ops =3D {
> +	.mute_stream	=3D tasdevice_mute,
> +	.hw_params	=3D tasdevice_sdw_hw_params,
> +	.hw_free	=3D tasdevice_sdw_pcm_hw_free,
> +	.set_stream	=3D tasdevice_set_sdw_stream,
> +	.shutdown	=3D tasdevice_sdw_shutdown,
> +};
> +
> +static struct snd_soc_dai_driver tasdevice_dai_driver[] =3D {
> +	{
> +		.name =3D "tas2783-codec",
> +		.id =3D 0,
> +		.playback =3D {
> +			.stream_name	=3D "Playback",
> +			.channels_min	=3D 1,
> +			.channels_max	=3D 4,
> +			.rates		=3D TAS2783_DEVICE_RATES,
> +			.formats	=3D TAS2783_DEVICE_FORMATS,
> +		},
> +		.capture =3D {
> +			.stream_name	=3D "Capture",
> +			.channels_min	=3D 1,
> +			.channels_max	=3D 4,
> +			.rates		=3D TAS2783_DEVICE_RATES,
> +			.formats	=3D TAS2783_DEVICE_FORMATS,
> +		},
> +		.ops =3D &tasdevice_dai_ops,
> +		.symmetric_rate =3D 1,
> +	},
> +};
> +
> +static int tasdevice_comp_probe(struct snd_soc_component *comp)
> +{
> +	struct tasdevice_priv *tas_dev =3D snd_soc_component_get_drvdata(comp);
> +	acpi_handle handle =3D ACPI_HANDLE(tas_dev->dev);
> +	const struct firmware *fw_entry =3D NULL;
> +	const char *sub =3D NULL;
> +	int ret, value_sdw;
> +
> +	if (handle) {
> +		sub =3D acpi_get_subsystem_id(handle);
> +		if (IS_ERR(sub))
> +			sub =3D NULL;
> +	}
> +
> +	tas_dev->component =3D comp;
> +
> +	/*
> +	 * Each tas2783 in the system has its own dspfw.
> +	 */
> +	if (comp->name_prefix) {
> +		/*
> +		 * name_prefix.bin stores the dsp firmware including speaker
> +		 * protection algorithm, audio acoustic algorithm, speaker
> +		 * characters and algorithm params, it must be copied into
> +		 * firmware folder.
> +		 */
> +		scnprintf(tas_dev->dspfw_binaryname,
> +			TAS2783_DSPFW_FILENAME_LEN, "%s-tas2783.bin",
> +			comp->name_prefix);
> +	} else {
> +		/* Compatible with the previous naming rule */
> +		if (sub) {
> +		/*
> +		 * subsystem_id-link_id[0,1,...,N]-dev_num[1,...,4].bin stores
> +		 * the dsp firmware including speaker protection algorithm,
> +		 * audio acoustic algorithm, speaker characters and algorithm
> +		 * params, it must be copied into firmware folder.
> +		 */
> +			scnprintf(tas_dev->dspfw_binaryname,
> +				TAS2783_DSPFW_FILENAME_LEN,
> +				"%s-%d-%d.bin", sub,
> +				tas_dev->sdw_peripheral->bus->link_id,
> +				tas_dev->sdw_peripheral->dev_num);
> +		} else {
> +		/*
> +		 * tas2783-link_id[0,1,...,N]-dev_num[1,...,4].bin stores
> +		 * the dsp firmware including speaker protection algorithm,
> +		 * audio acoustic algorithm, speaker characters and algorithm
> +		 * params, it must be copied into firmware folder.
> +		 */
> +			scnprintf(tas_dev->dspfw_binaryname,
> +				TAS2783_DSPFW_FILENAME_LEN,
> +				"tas2783-%d-%d.bin",
> +				tas_dev->sdw_peripheral->bus->link_id,
> +				tas_dev->sdw_peripheral->dev_num);
> +		}
> +	}
> +
> +	ret =3D request_firmware(&fw_entry, tas_dev->dspfw_binaryname,
> +		tas_dev->dev);
> +	if (ret) {
> +		dev_err(tas_dev->dev,
> +			"%s: request_firmware %x open status: %d.\n", __func__,
> +			tas_dev->sdw_peripheral->id.unique_id, ret);
> +		goto out;
> +	}
> +
> +	tasdevice_dspfw_ready(fw_entry, tas_dev);
> +
> +	/* Select left/right channel based on device number. */
> +	value_sdw =3D 0x1a;
> +	value_sdw |=3D (tas_dev->sdw_peripheral->dev_num & BIT(0)) << 4;
> +	dev_dbg(tas_dev->dev, "%s: dev_num =3D %u", __func__,
> +		tas_dev->sdw_peripheral->dev_num);
> +	regmap_write(tas_dev->regmap, TAS2783_REG_TDM_RX_CFG, value_sdw);
> +	if (ret !=3D 0)
> +		dev_warn(tas_dev->dev, "%s: L/R setting failed: %d.\n",
> +			__func__, ret);
> +
> +out:
> +	if (fw_entry)
> +		release_firmware(fw_entry);
> +	return 0;
> +}
> +
> +static const struct snd_soc_component_driver
> +	soc_codec_driver_tasdevice =3D {
> +	.probe		=3D tasdevice_comp_probe,
> +	.controls	=3D tas2783_snd_controls,
> +	.num_controls	=3D ARRAY_SIZE(tas2783_snd_controls),
> +	.dapm_widgets	=3D tasdevice_dapm_widgets,
> +	.num_dapm_widgets =3D ARRAY_SIZE(tasdevice_dapm_widgets),
> +	.dapm_routes	=3D tasdevice_audio_map,
> +	.num_dapm_routes =3D ARRAY_SIZE(tasdevice_audio_map),
> +	.idle_bias_on	=3D 1,
> +	.endianness	=3D 1,
> +};
> +
> +static int tasdevice_init(struct tasdevice_priv *tas_dev)
> +{
> +	int ret;
> +
> +	dev_set_drvdata(tas_dev->dev, tas_dev);
> +
> +	ret =3D devm_snd_soc_register_component(tas_dev->dev,
> +		&soc_codec_driver_tasdevice,
> +		tasdevice_dai_driver, ARRAY_SIZE(tasdevice_dai_driver));
> +	if (ret) {
> +		dev_err(tas_dev->dev, "%s: codec register error:%d.\n",
> +			__func__, ret);
> +		return ret;
> +	}
> +
> +	/* set autosuspend parameters */
> +	pm_runtime_set_autosuspend_delay(tas_dev->dev, 3000);
> +	pm_runtime_use_autosuspend(tas_dev->dev);
> +
> +	/* make sure the device does not suspend immediately */
> +	pm_runtime_mark_last_busy(tas_dev->dev);
> +	pm_runtime_enable(tas_dev->dev);
> +
> +	return 0;
> +}
> +
> +static int tasdevice_read_prop(struct sdw_slave *slave)
> +{
> +	struct sdw_slave_prop *prop =3D &slave->prop;
> +	struct sdw_dpn_prop *dpn;
> +	unsigned long addr;
> +	int nval, i, j;
> +	u32 bit;
> +
> +	prop->scp_int1_mask =3D SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
> +	prop->quirks =3D SDW_SLAVE_QUIRKS_INVALID_INITIAL_PARITY;
> +
> +	prop->paging_support =3D true;
> +
> +	/* first we need to allocate memory for set bits in port lists */
> +	prop->source_ports =3D BIT(2); /* BITMAP: 00000100 */
> +	prop->sink_ports =3D BIT(1); /* BITMAP:  00000010 */
> +
> +	nval =3D hweight32(prop->source_ports);
> +	prop->src_dpn_prop =3D devm_kcalloc(&slave->dev, nval,
> +		sizeof(*prop->src_dpn_prop), GFP_KERNEL);
> +	if (!prop->src_dpn_prop)
> +		return -ENOMEM;
> +
> +	i =3D 0;
> +	dpn =3D prop->src_dpn_prop;
> +	addr =3D prop->source_ports;
> +	for_each_set_bit(bit, &addr, 32) {
> +		dpn[i].num =3D bit;
> +		dpn[i].type =3D SDW_DPN_FULL;
> +		dpn[i].simple_ch_prep_sm =3D true;
> +		dpn[i].ch_prep_timeout =3D 10;
> +		i++;
> +	}
> +
> +	/* do this again for sink now */
> +	nval =3D hweight32(prop->sink_ports);
> +	prop->sink_dpn_prop =3D devm_kcalloc(&slave->dev, nval,
> +		sizeof(*prop->sink_dpn_prop), GFP_KERNEL);
> +	if (!prop->sink_dpn_prop)
> +		return -ENOMEM;
> +
> +	j =3D 0;
> +	dpn =3D prop->sink_dpn_prop;
> +	addr =3D prop->sink_ports;
> +	for_each_set_bit(bit, &addr, 32) {
> +		dpn[j].num =3D bit;
> +		dpn[j].type =3D SDW_DPN_FULL;
> +		dpn[j].simple_ch_prep_sm =3D true;
> +		dpn[j].ch_prep_timeout =3D 10;
> +		j++;
> +	}
> +
> +	/* set the timeout values */
> +	prop->clk_stop_timeout =3D 20;
> +
> +	return 0;
> +}
> +
> +static int tasdevice_io_init(struct device *dev,
> +	struct sdw_slave *slave)
> +{
> +	struct tasdevice_priv *tas_priv =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	regcache_cache_only(tas_priv->regmap, false);
> +
> +	if (tas_priv->first_hw_init) {
> +		regcache_cache_bypass(tas_priv->regmap, true);
> +	} else {
> +	/*
> +	 * PM runtime is only enabled when a Slave reports as Attached
> +	 * Update count of parent 'active' children
> +	 */
> +		pm_runtime_set_active(&slave->dev);
> +	}
> +
> +	/* sw reset */
> +	ret =3D regmap_write(tas_priv->regmap, TAS2873_REG_SWRESET,
> +		TAS2873_REG_SWRESET_RESET);
> +	if (ret) {
> +		dev_err(tas_priv->dev, "Reset failed.\n");
> +		goto out;
> +	}
> +
> +	if (tas_priv->first_hw_init) {
> +		regcache_cache_bypass(tas_priv->regmap, false);
> +		regcache_mark_dirty(tas_priv->regmap);
> +	}
> +
> +	tas_priv->first_hw_init =3D true;
> +	tas_priv->hw_init =3D true;
> +
> +out:
> +	return ret;
> +}
> +
> +static int tasdevice_update_status(struct sdw_slave *slave,
> +	enum sdw_slave_status status)
> +{
> +	struct  tasdevice_priv *tas_priv =3D dev_get_drvdata(&slave->dev);
> +
> +	/* Update the status */
> +	tas_priv->status =3D status;
> +
> +	if (status =3D=3D SDW_SLAVE_UNATTACHED)
> +		tas_priv->hw_init =3D false;
> +	/*
> +	 * Perform initialization only if slave status
> +	 * is present and hw_init flag is false
> +	 */
> +	if (tas_priv->hw_init || tas_priv->status !=3D SDW_SLAVE_ATTACHED)
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
> +static const struct sdw_slave_ops tasdevice_sdw_ops =3D {
> +	.read_prop	=3D tasdevice_read_prop,
> +	.update_status	=3D tasdevice_update_status,
> +};
> +
> +static int tasdevice_sdw_probe(struct sdw_slave *peripheral,
> +	const struct sdw_device_id *id)
> +{
> +	struct device *dev =3D &peripheral->dev;
> +	struct tasdevice_priv *tas_dev;
> +
> +	tas_dev =3D devm_kzalloc(dev, sizeof(*tas_dev), GFP_KERNEL);
> +	if (!tas_dev)
> +		return -ENOMEM;
> +
> +	tas_dev->dev =3D dev;
> +	tas_dev->chip_id =3D id->driver_data;
> +	tas_dev->sdw_peripheral =3D peripheral;
> +	/*
> +	 * Mark hw_init to false
> +	 * HW init will be performed when device reports present
> +	 */
> +	tas_dev->hw_init =3D false;
> +	tas_dev->first_hw_init =3D false;
> +
> +	dev_set_drvdata(dev, tas_dev);
> +
> +	tas_dev->regmap =3D devm_regmap_init_sdw(peripheral, &tasdevice_regmap)=
;
> +	if (IS_ERR(tas_dev->regmap))
> +		return dev_err_probe(dev, PTR_ERR(tas_dev->regmap),
> +			"Failed devm_regmap_init_sdw.");
> +
> +	return tasdevice_init(tas_dev);
> +}
> +
> +static int tasdevice_sdw_remove(struct sdw_slave *peripheral)
> +{
> +	struct tasdevice_priv *tas_dev =3D dev_get_drvdata(&peripheral->dev);
> +
> +	if (tas_dev->first_hw_init)
> +		pm_runtime_disable(tas_dev->dev);
> +
> +	return 0;
> +}
> +
> +static const struct sdw_device_id tasdevice_sdw_id[] =3D {
> +	SDW_SLAVE_ENTRY(0x0102, 0x0000, 0),
> +	{}
> +};
> +MODULE_DEVICE_TABLE(sdw, tasdevice_sdw_id);
> +
> +static int __maybe_unused tas2783_sdca_dev_suspend(struct device *dev)
> +{
> +	struct tasdevice_priv *tas_priv =3D dev_get_drvdata(dev);
> +
> +	if (!tas_priv->hw_init)
> +		return 0;
> +
> +	regcache_cache_only(tas_priv->regmap, true);
> +
> +	return 0;
> +}
> +
> +#define TAS2783_PROBE_TIMEOUT_MS 5000
> +
> +static int __maybe_unused tas2783_sdca_dev_resume(struct device *dev)
> +{
> +	struct sdw_slave *slave =3D dev_to_sdw_dev(dev);
> +	struct tasdevice_priv *tas_priv =3D dev_get_drvdata(dev);
> +	unsigned long time;
> +
> +	if (!tas_priv->first_hw_init)
> +		return 0;
> +
> +	if (!slave->unattach_request)
> +		goto regmap_sync;
> +
> +	time =3D wait_for_completion_timeout(&slave->initialization_complete,
> +		msecs_to_jiffies(TAS2783_PROBE_TIMEOUT_MS));
> +	if (!time) {
> +		dev_err(&slave->dev, "Init not complete, timed out\n");
> +		sdw_show_ping_status(slave->bus, true);
> +
> +		return -ETIMEDOUT;
> +	}
> +
> +regmap_sync:
> +	slave->unattach_request =3D 0;
> +	regcache_cache_only(tas_priv->regmap, false);
> +	regcache_sync(tas_priv->regmap);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops tas2783_sdca_pm =3D {
> +	SYSTEM_SLEEP_PM_OPS(tas2783_sdca_dev_suspend,
> +		tas2783_sdca_dev_resume)
> +	RUNTIME_PM_OPS(tas2783_sdca_dev_suspend,
> +		tas2783_sdca_dev_resume, NULL)
> +};
> +
> +static struct sdw_driver tasdevice_sdw_driver =3D {
> +	.driver =3D {
> +		.name =3D "slave-tas2783",
> +		.pm =3D &tas2783_sdca_pm,
> +	},
> +	.probe =3D tasdevice_sdw_probe,
> +	.remove =3D tasdevice_sdw_remove,
> +	.ops =3D &tasdevice_sdw_ops,
> +	.id_table =3D tasdevice_sdw_id,
> +};
> +
> +module_sdw_driver(tasdevice_sdw_driver);
> +
> +MODULE_AUTHOR("Baojun Xu <baojun.xu@ti.com>");
> +MODULE_AUTHOR("Shenghao Ding <shenghao-ding@ti.com>");
> +MODULE_DESCRIPTION("ASoC TAS2783 SoundWire Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/sound/soc/codecs/tas2783.h b/sound/soc/codecs/tas2783.h
> new file mode 100644
> index 000000000000..41bdce1964ff
> --- /dev/null
> +++ b/sound/soc/codecs/tas2783.h
> @@ -0,0 +1,103 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * ALSA SoC Texas Instruments TAS2783 Audio Smart Amplifier
> + *
> + * Copyright (C) 2023 - 2024 Texas Instruments Incorporated
> + * https://www.ti.com
> + *
> + * Author: Baojun Xu <baojun.xu@ti.com>
> + *	Shenghao Ding <shenghao-ding@ti.com>
> + */
> +
> +#ifndef __TAS2783_H__
> +#define __TAS2783_H__
> +
> +#define TAS2783_DEVICE_RATES		(SNDRV_PCM_RATE_44100 | \
> +					SNDRV_PCM_RATE_48000 | \
> +					SNDRV_PCM_RATE_96000 | \
> +					SNDRV_PCM_RATE_88200)
> +
> +#define TAS2783_DEVICE_FORMATS		(SNDRV_PCM_FMTBIT_S16_LE | \
> +					SNDRV_PCM_FMTBIT_S24_LE | \
> +					SNDRV_PCM_FMTBIT_S32_LE)
> +
> +/* BOOK, PAGE Control Register */
> +#define TASDEVICE_REG(book, page, reg)	((book * 256 * 256) + 0x8000 + \
> +					(page * 128) + reg)
> +
> +/*Software Reset */
> +#define TAS2873_REG_SWRESET		TASDEVICE_REG(0x0, 0x00, 0x01)
> +#define TAS2873_REG_SWRESET_MASK	BIT(0)
> +#define TAS2873_REG_SWRESET_RESET	BIT(0)
> +
> +#define TAS2873_REG_PWR_CTRL		TASDEVICE_REG(0x0, 0x00, 0x02)
> +#define TAS2783_REG_AEF_MASK		GENMASK(4, 3)
> +#define TAS2783_REG_AEF_ACTIVE		0
> +#define TAS2783_REG_AEF_INACTIVE	GENMASK(4, 3)
> +#define TAS2783_REG_PWR_MODE_MASK	GENMASK(2, 0)
> +#define TAS2783_REG_PWR_MODE_ACTIVE	0
> +#define TAS2783_REG_PWR_MODE_SW_PWD	BIT(1)
> +
> +#define TAS2783_REG_TDM_RX_CFG		TASDEVICE_REG(0x0, 0x00, 0x0a)
> +
> +/* Volume control */
> +#define TAS2783_DVC_LVL			TASDEVICE_REG(0x0, 0x00, 0x1a)
> +#define TAS2783_AMP_LEVEL		TASDEVICE_REG(0x0, 0x00, 0x03)
> +#define TAS2783_AMP_LEVEL_MASK		GENMASK(5, 1)
> +
> +/* Calibration data */
> +#define TAS2783_CALIBRATION_RE		TASDEVICE_REG(0x0, 0x17, 0x74)
> +#define TAS2783_CALIBRATION_RE_LOW	TASDEVICE_REG(0x0, 0x18, 0x14)
> +#define TAS2783_CALIBRATION_INV_RE	TASDEVICE_REG(0x0, 0x18, 0x0c)
> +#define TAS2783_CALIBRATION_POW		TASDEVICE_REG(0x0, 0x13, 0x70)
> +#define TAS2783_CALIBRATION_TLIMIT	TASDEVICE_REG(0x0, 0x18, 0x7c)
> +
> +/* TAS2783 SDCA Control - function number */
> +#define TAS2783_FUNC_TYPE_SMART_AMP	0x01
> +
> +/* TAS2783 SDCA entity */
> +#define TAS2783_SDCA_ENT_FU21		0x01
> +#define TAS2783_SDCA_ENT_FU23		0x02
> +
> +/* TAS2783 SDCA control */
> +#define TAS2783_SDCA_CTL_REQ_POWER_STATE	0x01
> +#define TAS2783_SDCA_CTL_FU_MUTE	0x01
> +#define TAS2783_SDCA_CTL_FU_VOLUME	0x02
> +#define TAS2783_SDCA_CTL_UDMPU_CLUSTER	0x10
> +
> +#define TAS2783_DEVICE_CHANNEL_LEFT	1
> +#define TAS2783_DEVICE_CHANNEL_RIGHT	2
> +#define TAS2783_DSPFW_FILENAME_LEN	64
> +
> +#define TAS2783_MAX_CALIDATA_SIZE	252
> +
> +struct tas2783_firmware_node {
> +	unsigned int vendor_id;
> +	unsigned int file_id;
> +	unsigned int version_id;
> +	unsigned int length;
> +	unsigned int download_addr;
> +};
> +
> +struct calibration_data {
> +	unsigned long total_sz;
> +	unsigned char data[TAS2783_MAX_CALIDATA_SIZE];
> +};
> +
> +struct tasdevice_priv {
> +	struct snd_soc_component *component;
> +	struct calibration_data cali_data;
> +	struct sdw_slave *sdw_peripheral;
> +	enum sdw_slave_status status;
> +	struct sdw_bus_params params;
> +	struct regmap *regmap;
> +	struct device *dev;
> +	unsigned char dspfw_binaryname[TAS2783_DSPFW_FILENAME_LEN];
> +	unsigned char dev_name[32];
> +	unsigned int chip_id;
> +	bool pstream;
> +	bool hw_init;
> +	bool first_hw_init;
> +};
> +
> +#endif /*__TAS2783_H__ */


