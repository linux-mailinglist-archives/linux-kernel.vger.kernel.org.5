Return-Path: <linux-kernel+bounces-79952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE3C8628E8
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 03:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6674CB212F2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 02:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8E953A0;
	Sun, 25 Feb 2024 02:51:17 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0501810F4;
	Sun, 25 Feb 2024 02:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708829477; cv=none; b=ePOL8KHWIACol63WngJqS9hTkq/HippwRihoVu+Z8DOj6vw8KNDJfe70Egt0W17o0A3VV/kfVjUoplDwsQXUqdwxK7yfuZdIX/zRGaEYYs2ITJ0SioN877MEwCa2ncq+3BJKbZH0BsooULpMjMD8nbuSb3WkgmK1RHaninrYhH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708829477; c=relaxed/simple;
	bh=6aWbXWwDnTIBCUXTmZIxvXi/QjPi1BY7aUu7t00Edb0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aYnjJXacKm+HRCuNH3bLZws9HeAsDdjFTugvbZLwZQG2ysTGq0Zt753v2jKVljvSwLPGFwyPffy3+v+Y4FIxZz9IAwLTUzSD9RjSxoo1uTD5ArN2ZLDS5Sz2xexguJ5gfYdT+6Bccv8sUzGJGyAhIuq+pqoFWhQ+HyIIfNmcYik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from [192.168.2.4] (51b68dc5.dsl.pool.telekom.hu [::ffff:81.182.141.197])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000073ABF.0000000065DAAB20.001E12A8; Sun, 25 Feb 2024 03:51:12 +0100
Message-ID: <7fb3bd72ec06f29608e43cc75128dd2374ad8ff7.camel@irl.hu>
Subject: Re: [PATCH v3] ALSA: hda/realtek: Add special fixup for Lenovo
 14IRP8
From: Gergo Koteles <soyer@irl.hu>
To: Willian Wang <git@willian.wang>, linux-sound@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.com, perex@perex.cz,
  stable@vger.kernel.org
Date: Sun, 25 Feb 2024 03:51:11 +0100
In-Reply-To: <170879111795.8.6687687359006700715.273812184@willian.wang>
References: <170879111795.8.6687687359006700715.273812184@willian.wang>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-02-24 at 13:11 -0300, Willian Wang wrote:
> Lenovo Slim/Yoga Pro 9 14IRP8 requires a special fixup because there is
> a collision of its PCI SSID (17aa:3802) with Lenovo Yoga DuetITL 2021
> codec SSID.
>=20
> Fixes: 3babae915f4c ("ALSA: hda/tas2781: Add tas2781 HDA driver")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D208555
> Link: https://lore.kernel.org/all/d5b42e483566a3815d229270abd668131a0d9f3=
a.camel@irl.hu
> Cc: stable@vger.kernel.org
> Signed-off-by: Willian Wang <git@willian.wang>

Reviewed-by: Gergo Koteles <soyer@irl.hu>

> ---
>  sound/pci/hda/patch_realtek.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
>=20
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.=
c
> index 0ec1312bffd5..f3b847f38153 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -7444,6 +7444,7 @@ enum {
>  	ALC287_FIXUP_LEGION_15IMHG05_AUTOMUTE,
>  	ALC287_FIXUP_YOGA7_14ITL_SPEAKERS,
>  	ALC298_FIXUP_LENOVO_C940_DUET7,
> +	ALC287_FIXUP_LENOVO_14IRP8_DUETITL,
>  	ALC287_FIXUP_13S_GEN2_SPEAKERS,
>  	ALC256_FIXUP_SET_COEF_DEFAULTS,
>  	ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE,
> @@ -7495,6 +7496,26 @@ static void alc298_fixup_lenovo_c940_duet7(struct =
hda_codec *codec,
>  	__snd_hda_apply_fixup(codec, id, action, 0);
>  }
> =20
> +/* A special fixup for Lenovo Slim/Yoga Pro 9 14IRP8 and Yoga DuetITL 20=
21;
> + * 14IRP8 PCI SSID will mistakenly be matched with the DuetITL codec SSI=
D,
> + * so we need to apply a different fixup in this case. The only DuetITL =
codec
> + * SSID reported so far is the 17aa:3802 while the 14IRP8 has the 17aa:3=
8be
> + * and 17aa:38bf. If it weren't for the PCI SSID, the 14IRP8 models woul=
d
> + * have matched correctly by their codecs.
> + */
> +static void alc287_fixup_lenovo_14irp8_duetitl(struct hda_codec *codec,
> +					      const struct hda_fixup *fix,
> +					      int action)
> +{
> +	int id;
> +
> +	if (codec->core.subsystem_id =3D=3D 0x17aa3802)
> +		id =3D ALC287_FIXUP_YOGA7_14ITL_SPEAKERS; /* DuetITL */
> +	else
> +		id =3D ALC287_FIXUP_TAS2781_I2C; /* 14IRP8 */
> +	__snd_hda_apply_fixup(codec, id, action, 0);
> +}
> +
>  static const struct hda_fixup alc269_fixups[] =3D {
>  	[ALC269_FIXUP_GPIO2] =3D {
>  		.type =3D HDA_FIXUP_FUNC,
> @@ -9379,6 +9400,10 @@ static const struct hda_fixup alc269_fixups[] =3D =
{
>  		.type =3D HDA_FIXUP_FUNC,
>  		.v.func =3D alc298_fixup_lenovo_c940_duet7,
>  	},
> +	[ALC287_FIXUP_LENOVO_14IRP8_DUETITL] =3D {
> +		.type =3D HDA_FIXUP_FUNC,
> +		.v.func =3D alc287_fixup_lenovo_14irp8_duetitl,
> +	},
>  	[ALC287_FIXUP_13S_GEN2_SPEAKERS] =3D {
>  		.type =3D HDA_FIXUP_VERBS,
>  		.v.verbs =3D (const struct hda_verb[]) {
> @@ -10247,7 +10272,7 @@ static const struct snd_pci_quirk alc269_fixup_tb=
l[] =3D {
>  	SND_PCI_QUIRK(0x17aa, 0x31af, "ThinkCentre Station", ALC623_FIXUP_LENOV=
O_THINKSTATION_P340),
>  	SND_PCI_QUIRK(0x17aa, 0x334b, "Lenovo ThinkCentre M70 Gen5", ALC283_FIX=
UP_HEADSET_MIC),
>  	SND_PCI_QUIRK(0x17aa, 0x3801, "Lenovo Yoga9 14IAP7", ALC287_FIXUP_YOGA9=
_14IAP7_BASS_SPK_PIN),
> -	SND_PCI_QUIRK(0x17aa, 0x3802, "Lenovo Yoga DuetITL 2021", ALC287_FIXUP_=
YOGA7_14ITL_SPEAKERS),
> +	SND_PCI_QUIRK(0x17aa, 0x3802, "Lenovo Yoga Pro 9 14IRP8 / DuetITL 2021"=
, ALC287_FIXUP_LENOVO_14IRP8_DUETITL),
>  	SND_PCI_QUIRK(0x17aa, 0x3813, "Legion 7i 15IMHG05", ALC287_FIXUP_LEGION=
_15IMHG05_SPEAKERS),
>  	SND_PCI_QUIRK(0x17aa, 0x3818, "Lenovo C940 / Yoga Duet 7", ALC298_FIXUP=
_LENOVO_C940_DUET7),
>  	SND_PCI_QUIRK(0x17aa, 0x3819, "Lenovo 13s Gen2 ITL", ALC287_FIXUP_13S_G=
EN2_SPEAKERS),


