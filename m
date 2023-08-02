Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF7C76CDBF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 15:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbjHBNBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 09:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjHBNB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:01:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE36B268D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 06:01:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AFD561953
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 13:01:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E637C433C7;
        Wed,  2 Aug 2023 13:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690981285;
        bh=3ZwajZhEzeApjBQELJek4gb6BfmU4ntGVXjHJxmAhYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FPLlEt/kX6wxSP0TUFuVxsY90bMb8h+k4IfMnyIleZT0MN4ZZ5fRvypVttY252EVy
         CAOwI6yTJJ7OXE8DUUI0pmQSyqM4ThSvqo9brrAOdEFCvde7jT/zBYRAkLj3Ngsey2
         TwSeqzk+CYY7rmcEdKLUXJe8jhLgaPuSuccnQj5lKIFJ0o0J5SQhvQTGLFcU+668Cf
         4WCy48V8TZyDnxR+Tdxj8/1Eeuvy2S6sXaemOZgIz0sQpo82cI2GYU3p1regWmx1s1
         X64sjxx/knoUy7rBCy56pwBJMVHPi+d1Td5hpDtyz7k9OnGBVfD3sHkpocPiZ3BaGY
         ww7EFmhtFxhkw==
Date:   Wed, 2 Aug 2023 14:01:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Baojun.Xu" <jim_monkey@163.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        shenghao-ding@ti.com, kevin-lu@ti.com,
        krzysztof.kozlowski@linaro.org, rf@opensource.cirrus.com,
        shumingf@realtek.com, herve.codina@bootlin.com,
        povik+lin@cutebit.org, ryans.lee@analog.com,
        ckeepax@opensource.cirrus.com, sebastian.reichel@collabora.com,
        fido_max@inbox.ru, wangweidong.a@awinic.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        peeyush@ti.com, navada@ti.com, tiwai@suse.de,
        mengdong.lin@intel.com, Baojun Xu <baojun.xu@ti.com>
Subject: Re: [PATCH v1 1/2] ASoC: tas2783: Add source files for tas2783
 soundwire driver
Message-ID: <35849737-dbff-4655-9062-5d5d0fd861df@sirena.org.uk>
References: <20230801141858.130745-1-jim_monkey@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x1lTc6C+/UnWD+q0"
Content-Disposition: inline
In-Reply-To: <20230801141858.130745-1-jim_monkey@163.com>
X-Cookie: Humpty Dumpty was pushed.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x1lTc6C+/UnWD+q0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 01, 2023 at 10:18:57PM +0800, Baojun.Xu wrote:

> +       while (val_size) {
> +               /* to end of page */
> +               bytes =3D SDW_REG_NO_PAGE - (reg & SDW_REGADDR);

regmap has paging support, can't the driver use that?

> +static const struct regmap_config tasdevice_regmap =3D {
> +	.reg_bits =3D 32,
> +	.val_bits =3D 8,
> +	.readable_reg =3D tas2783_readable_register,
> +	.volatile_reg =3D tas2783_volatile_register,
> +	.max_register =3D 0x41008000 + TASDEVICE_REG(0xa1, 0x60, 0x7f),
> +	.reg_defaults =3D tas2783_reg_defaults,
> +	.num_reg_defaults =3D ARRAY_SIZE(tas2783_reg_defaults),
> +	.cache_type =3D REGCACHE_RBTREE,

Please use _MAPLE for new devices, it's more modern than _RBTREE.  It
should make little if any practical difference.

> +	.use_single_read =3D true,
> +	.use_single_write =3D true,
> +};

> +/*
> + * Registers are big-endian on I2C and SPI but little-endian on SoundWir=
e.
> + * Exported firmware controls are big-endian on I2C/SPI but little-endian
> + * on SoundWire.

Are you sure this isn't due to running on different host architecture?

> + * Firmware files are always big-endian and are opaque blobs.
> + * Present a big-endian regmap and hide the endianness swap,
> + * so that the ALSA byte controls always have the same byte order,
> + * and firmware file blobs can be written verbatim.
> + */
> +static const struct regmap_bus tas2783_regmap_bus_sdw =3D {
> +	.read =3D tas2783_sdw_read,
> +	.write =3D tas2783_sdw_write,
> +	.gather_write =3D tas2783_sdw_gather_write,
> +	.reg_format_endian_default =3D REGMAP_ENDIAN_LITTLE,
> +	.val_format_endian_default =3D REGMAP_ENDIAN_BIG,
> +};

None of the other SoundWire devices use a custom bus, this all feels
suspicous especially since there's a bunch of bypassing of the bus in
places and calling functions directly.  I would expect everything
outside the regmap code should be able to use the regmap, possibly
excluding firmware download, and that regmap should be able to
encapsulate any differences in endianness between the different buses.
At the minute the regmap is reported as having 8 bit registers which
should mean there are no endianness issues.

> +static int tas2783_digital_getvol(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *codec
> +		=3D snd_soc_kcontrol_component(kcontrol);
> +	struct tasdevice_priv *tas_dev =3D
> +		snd_soc_component_get_drvdata(codec);
> +	struct soc_mixer_control *mc =3D
> +		(struct soc_mixer_control *)kcontrol->private_value;
> +	int val;
> +	unsigned int invert =3D mc->invert;
> +	int max =3D mc->max;
> +	int ret =3D 0;
> +
> +	/* Read the primary device as the whole */
> +	ret =3D tasdevice_dev_read(tas_dev, &mc->reg, (unsigned int *)&val);

Why is this a custom control?

> +	val =3D ucontrol->value.integer.value[0];
> +	if (val > max)
> +		val =3D max;
> +	if (invert)
> +		val =3D max - val;
> +	if (val < 0)
> +		val =3D 0;

This is valid but it's preferable to report an error for out of range
values.

> +static int tas2783_calibration(struct tasdevice_priv *tas_priv)
> +{
> +	efi_guid_t efi_guid =3D EFI_GUID(0x1f52d2a1, 0xbb3a, 0x457d, 0xbc,
> +			0x09, 0x43, 0xa3, 0xf4, 0x31, 0x0a, 0x92);
> +	static efi_char16_t efi_name[] =3D L"CALI_DATA";
> +	struct tm *tm =3D &tas_priv->tm;
> +	unsigned int attr, crc;
> +	unsigned int *tmp_val;
> +	efi_status_t status;
> +
> +	tas_priv->cali_data.total_sz =3D 128;
> +	/* Get real size of UEFI variable */
> +	status =3D efi.get_variable(efi_name, &efi_guid, &attr,
> +		&tas_priv->cali_data.total_sz, tas_priv->cali_data.data);
> +	dev_dbg(tas_priv->dev, "cali get %lx bytes with result : %ld\n",
> +			tas_priv->cali_data.total_sz, status);
> +	if (status =3D=3D EFI_BUFFER_TOO_SMALL) {
> +		status =3D efi.get_variable(efi_name, &efi_guid, &attr,
> +			&tas_priv->cali_data.total_sz,
> +			tas_priv->cali_data.data);
> +		dev_dbg(tas_priv->dev, "cali get %lx bytes result:%ld\n",
> +			tas_priv->cali_data.total_sz, status);
> +	}

What if there is nothing in EFI?  What if the system is not using EFI at
all?

> +	while ((offset < img_sz) && (num_files < MAX_NO_FILES)) {
> +		p =3D (struct MYSWFTFile *)(buf + offset);
> +		tas_dev->m_swftFile[num_files].m_vendor_id =3D
> +			p->m_vendor_id;
> +		tas_dev->m_swftFile[num_files].m_file_id =3D p->m_file_id;
> +		tas_dev->m_swftFile[num_files].m_version =3D p->m_version;
> +		tas_dev->m_swftFile[num_files].m_Length =3D p->m_Length;
> +		tas_dev->m_swftFile[num_files].m_downloadAddr =3D
> +			p->m_downloadAddr;
> +		tas_dev->m_swftFile[num_files].m_startAdress =3D
> +			((char *)p) + sizeof(unsigned int)*5;

The driver should validate that there's enough space left in the buffer
to contain the struct.

> +static int tasdevice_dapm_event(struct snd_soc_dapm_widget *w,
> +			struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_component *codec =3D
> +		snd_soc_dapm_to_component(w->dapm);
> +	struct tasdevice_priv *tas_dev =3D
> +		snd_soc_component_get_drvdata(codec);
> +	int state =3D 1;
> +
> +	/* Codec Lock Hold */
> +	mutex_lock(&tas_dev->codec_lock);

I'm not clear what this lock is protecting?

> +static int tasdevice_startup(struct snd_pcm_substream *substream,
> +	struct snd_soc_dai *dai)
> +{
> +	int ret =3D 0;
> +
> +	return ret;
> +}

Remove empty functions.

> +static int tasdevice_set_dai_sysclk(struct snd_soc_dai *codec_dai,
> +	int clk_id, unsigned int freq, int dir)
> +{
> +	struct tasdevice_priv *tas_dev =3D
> +		snd_soc_dai_get_drvdata(codec_dai);
> +
> +	tas_dev->sysclk =3D freq;
> +
> +	return 0;
> +}

I can't see anything using the sysclk so you could just remove the
set_sysclk() operation and the driver data for it I think?

> +static int tasdevice_mute(struct snd_soc_dai *dai, int mute,
> +	int direction)
> +{
> +	struct snd_soc_component *component =3D dai->component;
> +	struct tasdevice_priv *tasdevice =3D
> +		snd_soc_component_get_drvdata(component);
> +	int ret =3D 0;
> +	unsigned char value_sdw =3D 0;
> +
> +	dev_dbg(tasdevice->dev, "%s: mute %d, %d\n",
> +		__func__, mute, direction);
> +	if (mute =3D=3D 0) {// Unmute.
> +		// FU21 Unmute
> +		value_sdw =3D 0;
> +		ret =3D sdw_nwrite_no_pm(tasdevice->sdw_peripheral,
> +			SDW_SDCA_CTL(1, 1, 1, 0), 1, &value_sdw);
> +		dev_dbg(tasdevice->dev,  "Unmuted %lx %x\n",
> +			SDW_SDCA_CTL(1, 1, 1, 0), ret);
> +		value_sdw =3D 0;
> +		ret =3D sdw_nwrite_no_pm(tasdevice->sdw_peripheral,
> +			0x40400090, 1, &value_sdw);
> +		dev_dbg(tasdevice->dev,  "Unmuted %x\n", ret);
> +		ret =3D sdw_nwrite_no_pm(tasdevice->sdw_peripheral,
> +			0x40402090, 1, &value_sdw);
> +		dev_dbg(tasdevice->dev,  "Unmuted %x\n", ret);

This feels very big/complicated for a mute/unmute operation - should
this just be a user controllable thing?  I'm a bit surprised a SoundWire
device would need a mute control, usually that's for stopping an I2S
controller outputting junk while it's starting up or shutting down but
I'd not expect that this is an issue with SoundWire.  Only one Cirrus
device has a control like that.

> +static int tasdevice_codec_probe(struct snd_soc_component *codec)
> +{
> +	struct tasdevice_priv *tas_dev =3D
> +		snd_soc_component_get_drvdata(codec);
> +	int ret =3D 0;
> +
> +	dev_dbg(tas_dev->dev, "%s called for TAS2783 start.\n",
> +		__func__);
> +	/* Codec Lock Hold */
> +	mutex_lock(&tas_dev->codec_lock);
> +
> +	crc8_populate_msb(tas_dev->crc8_lkp_tbl,
> +		TASDEVICE_CRC8_POLYNOMIAL);

I don't see anywhere where we reference this table after it is
initialised - what's it for?  Also could we do this on normal device
probe rather than waiting for the sound card to probe?

> +	tas_dev->codec =3D codec;
> +
> +	scnprintf(tas_dev->rca_binaryname, 64, "MY_SWFT_x%01x.bin",
> +		tas_dev->sdw_peripheral->id.unique_id);
> +
> +	ret =3D request_firmware_nowait(THIS_MODULE, FW_ACTION_UEVENT,
> +		tas_dev->rca_binaryname, tas_dev->dev, GFP_KERNEL,
> +		tas_dev, tasdevice_rca_ready);
> +	dev_dbg(tas_dev->dev,
> +		"%s: request_firmware %x open status: 0x%08x\n",
> +		__func__, tas_dev->sdw_peripheral->id.unique_id, ret);

Why wait until component probe to request the firmware - it seems like
something that could be requested in normal device probe? =20

> +	if (tasdevice->first_hw_init) {
> +		regcache_cache_only(tasdevice->regmap, false);
> +		regcache_cache_bypass(tasdevice->regmap, true);
> +	} else {
> +		/* PM runtime is only enabled when
> +		 * a Slave reports as Attached
> +		 * set autosuspend parameters
> +		 */
> +		pm_runtime_set_autosuspend_delay(&slave->dev, 3000);
> +		pm_runtime_use_autosuspend(&slave->dev);
> +
> +		/* update count of parent 'active' children */
> +		pm_runtime_set_active(&slave->dev);
> +
> +		/* make sure the device does not suspend immediately */
> +		pm_runtime_mark_last_busy(&slave->dev);
> +
> +		pm_runtime_enable(&slave->dev);
> +	}

This looks like it might've been templated from some of the other
drivers which had recent bug fixes in this area - check there's no
updates needed.

> +#define CH_L	1
> +#define CH_R	2
> +


> +#define MAX_NO_FILES			100
> +#define MAX_CALIBRATION_DATA_SIZE	252

Some of these constants look like they need namespacing.

> +#define SMS_HTONL(a, b, c, d)		((((a)&0x000000FF)<<24) | \
> +					(((b)&0x000000FF)<<16) | \
> +					(((c)&0x000000FF)<<8) | \
> +					((d)&0x000000FF))

The kernel has endianness conversion macros which you should use, apart
=66rom anything else they work for all architectures.

> +enum channel {
> +	top_left_Chn,
> +	top_right_chn,
> +	bottom_left_Chn,
> +	bottom_right_chn,
> +	max_chn,
> +};

This should be namespaced, but it's not used so could just be deleted.

> +struct MYSWFTFile {
> +	unsigned int m_vendor_id;
> +	unsigned int m_file_id;
> +	unsigned int m_version;
> +	unsigned int m_Length;
> +	unsigned int m_downloadAddr;
> +	unsigned char *m_startAdress;
> +};

Nothing about this struct fits the kernel naming style,=20

> +/*
> + * This item is used to store the generic i2c address of
> + * all the tas2781 devices for I2C broadcast during the multi-device
> + *	writes, useless in mono case.
> + */
> +struct global_addr {
> +	unsigned char cur_book;
> +	unsigned int dev_addr;
> +	int ref_cnt;
> +};

It looks like this is just the SoundWire side - perhaps just delete the
I2C references for now?  Though if the I2C/SPI support is likely to be
upstreamed it'd be good to split the SoundWire specific bits into a
separate file like other drivers with multiple buses do, this makes it
much easier to handle build dependencies on the different buses.

> +struct tasdevice_irqinfo {
> +	int irq_gpio;
> +	int irq;
> +};

There was no interrupt support in the driver, just remove this until you
need it.

> +struct tasdevice_priv {
> +	struct device *dev;
> +	struct snd_soc_component *component;
> +	struct sdw_slave *sdw_slave;
> +	enum sdw_slave_status status;
> +	struct sdw_bus_params params;
> +	struct regmap *regmap;
> +	struct mutex codec_lock;
> +	struct mutex dev_lock;
> +	int rst_gpio;
> +	struct tasdevice tasdevice[max_chn];

Why is there both a struct tasdevice and tasdevice_priv?  It looks like
there's some support for trying to group devices but it's not fully
implemented, probably best to just delete all that until you add the
multiple device support - it makes everything simpler not to have to
worry about it.

--x1lTc6C+/UnWD+q0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTKU50ACgkQJNaLcl1U
h9DbbQf7Bkb50+15O7LeQgTPJC8u9xyF08vcZuo3xbDYDEzyx+nMAPSLwykyFtiX
DmxTyQP1SLY0Jdzjsn3hf5MRvOnA6zPs6OWjmd9gRG9ytO9Xsy3c8iDU+VC8Rgpe
JVJ4qkdEOO78+rEHEq7Gp7KXM4m0acqK6i/6Uzm2rz2W3i1hHuGMZKGDcDsngSCk
kGh1sJFRnAnAhq/Xt0sHVFZyGZtITd6Hgan8BsxgEn52yPe8pcMCbFIz8HvFFwPl
Gduwkkj6Q+/s9Qr1onG4deQchEHYunG5uM+3fkHVjmtQf8bU8r2/zPtZKhyWwAo0
Y01AJiTnr65NlQ0lhfokVrCjLlrXCw==
=x/zg
-----END PGP SIGNATURE-----

--x1lTc6C+/UnWD+q0--
