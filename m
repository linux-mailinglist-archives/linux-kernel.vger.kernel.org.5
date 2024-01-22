Return-Path: <linux-kernel+bounces-33952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBED8370D7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B42D2931E1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECC741227;
	Mon, 22 Jan 2024 18:15:35 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F357740C1E;
	Mon, 22 Jan 2024 18:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705947335; cv=none; b=bDxUPy6tP7E+vnW9OnvLiVTQd2qx9ZTihyVy2VHbMrEJshW3843DAdHP1nyFkVMJUDXUl0Tt3mgWePnEt7XG5s9EbclkGQizJ5F8t6kKOJyXHYb6YbGYCEyOs64EV5KAoOmBOFAQaPgiAeI3agrn8QEnBjY1dl4LyMBH59iFp8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705947335; c=relaxed/simple;
	bh=69GGm0pNRQTM69t2Rq+BKa1TrZijGf27F8TvqUvTRV4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X4NB6i20KD+2doRKCHEBztaYmgFJwDQyVmV+mTjThnWxG4AutEZpOVX5zfzLFSWWE3xK8qfYCyRNEo57J2PH/istrguDBjX1DwuDctYgqS5OfT8Qh8+vvJcBUsvkjqua905CoSgMMq3Ly6RyahwmP0Spe/2l99sNoIRvKvzaBx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from [192.168.2.4] (51b68f75.dsl.pool.telekom.hu [::ffff:81.182.143.117])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 00000000000736C1.0000000065AEAF8C.00184B08; Mon, 22 Jan 2024 19:10:20 +0100
Message-ID: <3ce7c90b5cebb56b1035eb51d7a75f49acfcbed9.camel@irl.hu>
Subject: Re: [PATCH AUTOSEL 6.7 72/88] ALSA: hda/tas2781: add fixup for
 Lenovo 14ARB7
From: Gergo Koteles <soyer@irl.hu>
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
  stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>, perex@perex.cz, tiwai@suse.com,
  sbinding@opensource.cirrus.com, kailang@realtek.com, luke@ljones.dev,
  andy.chi@canonical.com, shenghao-ding@ti.com,
  ruinairas1992@gmail.com, vitalyr@opensource.cirrus.com,
  linux-sound@vger.kernel.org
Date: Mon, 22 Jan 2024 19:10:19 +0100
In-Reply-To: <20240122145608.990137-72-sashal@kernel.org>
References: <20240122145608.990137-1-sashal@kernel.org>
	 <20240122145608.990137-72-sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Sasha,

This patch needs additional patches to work:

dcaca1b5f0d4 ALSA: hda/tas2781: annotate calibration data endianness
c3ca4458cc2f ALSA: hda/tas2781: add TAS2563 support for 14ARB7
c021ca729fe8 ALSA: hda/tas2781: add configurable global i2c address
76f5f55c45b9 ALSA: hda/tas2781: add ptrs to calibration functions
68f7f3ff6c2a ALSA: hda/tas2781: configure the amp after firmware load

Please add these if possible, or drop this patch from 6.6 and 6.7.

Thanks,
Gergo


On Mon, 2024-01-22 at 09:51 -0500, Sasha Levin wrote:
> From: Gergo Koteles <soyer@irl.hu>
>=20
> [ Upstream commit b5cb53fd32779f3a971c45bcd997ae2608aa1086 ]
>=20
> The 14ARB7 has two tas2563 amplifier on i2c.
> Connect it to the tas2781 driver.
>=20
> Signed-off-by: Gergo Koteles <soyer@irl.hu>
> Link: https://lore.kernel.org/r/abce9ee55689523562feb72383377171a489ddc7.=
1703891777.git.soyer@irl.hu
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  sound/pci/hda/patch_realtek.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.=
c
> index 70b17b08d4ff..9606f2448fda 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -6984,6 +6984,12 @@ static void tas2781_fixup_i2c(struct hda_codec *cd=
c,
>  	 tas2781_generic_fixup(cdc, action, "i2c", "TIAS2781");
>  }
> =20
> +static void yoga7_14arb7_fixup_i2c(struct hda_codec *cdc,
> +	const struct hda_fixup *fix, int action)
> +{
> +	 tas2781_generic_fixup(cdc, action, "i2c", "INT8866");
> +}
> +
>  /* for alc295_fixup_hp_top_speakers */
>  #include "hp_x360_helper.c"
> =20
> @@ -7454,6 +7460,7 @@ enum {
>  	ALC236_FIXUP_DELL_DUAL_CODECS,
>  	ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI,
>  	ALC287_FIXUP_TAS2781_I2C,
> +	ALC287_FIXUP_YOGA7_14ARB7_I2C,
>  	ALC245_FIXUP_HP_MUTE_LED_COEFBIT,
>  	ALC245_FIXUP_HP_X360_MUTE_LEDS,
>  	ALC287_FIXUP_THINKPAD_I2S_SPK,
> @@ -9568,6 +9575,12 @@ static const struct hda_fixup alc269_fixups[] =3D =
{
>  		.chained =3D true,
>  		.chain_id =3D ALC269_FIXUP_THINKPAD_ACPI,
>  	},
> +	[ALC287_FIXUP_YOGA7_14ARB7_I2C] =3D {
> +		.type =3D HDA_FIXUP_FUNC,
> +		.v.func =3D yoga7_14arb7_fixup_i2c,
> +		.chained =3D true,
> +		.chain_id =3D ALC285_FIXUP_THINKPAD_HEADSET_JACK,
> +	},
>  	[ALC245_FIXUP_HP_MUTE_LED_COEFBIT] =3D {
>  		.type =3D HDA_FIXUP_FUNC,
>  		.v.func =3D alc245_fixup_hp_mute_led_coefbit,
> @@ -10221,6 +10234,7 @@ static const struct snd_pci_quirk alc269_fixup_tb=
l[] =3D {
>  	SND_PCI_QUIRK(0x17aa, 0x3853, "Lenovo Yoga 7 15ITL5", ALC287_FIXUP_YOGA=
7_14ITL_SPEAKERS),
>  	SND_PCI_QUIRK(0x17aa, 0x3855, "Legion 7 16ITHG6", ALC287_FIXUP_LEGION_1=
6ITHG6),
>  	SND_PCI_QUIRK(0x17aa, 0x3869, "Lenovo Yoga7 14IAL7", ALC287_FIXUP_YOGA9=
_14IAP7_BASS_SPK_PIN),
> +	SND_PCI_QUIRK(0x17aa, 0x3870, "Lenovo Yoga 7 14ARB7", ALC287_FIXUP_YOGA=
7_14ARB7_I2C),
>  	SND_PCI_QUIRK(0x17aa, 0x387d, "Yoga S780-16 pro Quad AAC", ALC287_FIXUP=
_TAS2781_I2C),
>  	SND_PCI_QUIRK(0x17aa, 0x387e, "Yoga S780-16 pro Quad YC", ALC287_FIXUP_=
TAS2781_I2C),
>  	SND_PCI_QUIRK(0x17aa, 0x3881, "YB9 dual power mode2 YC", ALC287_FIXUP_T=
AS2781_I2C),


