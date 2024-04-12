Return-Path: <linux-kernel+bounces-142756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C6E8A2FC6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C621D1C23CAA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023CB84DE4;
	Fri, 12 Apr 2024 13:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iOu+FDfi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68FC84A3B;
	Fri, 12 Apr 2024 13:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712929504; cv=none; b=TYbmmoUtMCXvS5vC/nYd5LXlURXzzdXqG/KvuNKNM3ZCIXHy3hFV5OkW9Wob9Hz0ZJ4L/zabo3Jx1vNp6/WRMckYDzzL8znKmQD5DZ1ZL/AboFsmwAPZxtvDYKXR2JEoLmmcqD6yZ1OXxPr/mhDUVXxN2fe00Sd6SSLxcCT6sLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712929504; c=relaxed/simple;
	bh=WkOse5NWhetwI4hvIS8h085YA8LZIv0m1x0ud7AY7rg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jEfyEFwbkpPoXfSvpvqWayssQsiDj198tlrVPUuMrc52nAm7gA0x5lUA3KPAa7+je/XjMzRsWlC/1Gk/BOQYhlO1MUc3TiDzsBGfWBusTUGwrXjDI34Od7gbXQripEBw4wzpE+Gceg2l70FRH52VkKP8LCI3uRl++yPbRJdACpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iOu+FDfi; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712929503; x=1744465503;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WkOse5NWhetwI4hvIS8h085YA8LZIv0m1x0ud7AY7rg=;
  b=iOu+FDfiMPme3oiefH5dDS8MIeA/FmEyEmUmljCn4Csepe2ITiOt6hcc
   AswwhVtrPGg6wL0QeyADnNyTcR7iEBIJ8wbnYu0WEeigARWvOdgkCMVu0
   KPJCgBi0hAir4ueaGKBIQkAVIwiT4U32Mtk5p9nLI4ARi8ye4XnPHg1Gt
   rm2ukSJUDKS5RUefrRwtdhCbR4RoD0i8WoJrmlRB/7SfoeJzUnCGDllSB
   pFcloVNiLHXpPiNhVL72fUWlYWXiyrTrQptJLOD0Jjet3HI/fWN7KjlRG
   cUDJ3uWTZpZWb5eNgA62yAa3hTmvDkSHuTPvmZ4oGAN/6iKS435Q0Tw8U
   A==;
X-CSE-ConnectionGUID: KSWXZywwSqS8rhX/bLCaaw==
X-CSE-MsgGUID: 105MRIKbTuGE8gFMMoiyFQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="18990272"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="18990272"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 06:45:02 -0700
X-CSE-ConnectionGUID: 2Op4pL7YRdigt8obJOPcmg==
X-CSE-MsgGUID: /Id2MiN8RtWDJLYRVyoYqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="25914397"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.32])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 06:44:59 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 12 Apr 2024 16:44:55 +0300 (EEST)
To: Parker Newman <parker@finest.io>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v2 3/7] serial: exar: add support for config/set single
 MPIO
In-Reply-To: <20240412093613.0cbb4362@SWDEV2.connecttech.local>
Message-ID: <90e76b4c-10f8-2c06-2c86-51bdf822f968@linux.intel.com>
References: <cover.1712863999.git.pnewman@connecttech.com> <3e671b6c0d11a2d0c292947675ed087eaaa5445e.1712863999.git.pnewman@connecttech.com> <b057b1e2-1cf9-2f20-2453-b359a1e89f01@linux.intel.com> <20240412093613.0cbb4362@SWDEV2.connecttech.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2064743525-1712929495=:1014"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2064743525-1712929495=:1014
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 12 Apr 2024, Parker Newman wrote:

> On Fri, 12 Apr 2024 13:20:41 +0300 (EEST)
> Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
>=20
> > On Thu, 11 Apr 2024, parker@finest.io wrote:
> >=20
> > > From: Parker Newman <pnewman@connecttech.com>
> > >=20
> > > Adds support for configuring and setting a single MPIO
> > >=20
> > > Signed-off-by: Parker Newman <pnewman@connecttech.com>
> > > ---
> > >  drivers/tty/serial/8250/8250_exar.c | 88 +++++++++++++++++++++++++++=
++
> > >  1 file changed, 88 insertions(+)
> > >=20
> > > diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial=
/8250/8250_exar.c
> > > index 49d690344e65..9915a99cb7c6 100644
> > > --- a/drivers/tty/serial/8250/8250_exar.c
> > > +++ b/drivers/tty/serial/8250/8250_exar.c
> > > @@ -305,6 +305,94 @@ static int exar_ee_read(struct exar8250 *priv, u=
int8_t ee_addr)
> > >  =09return data;
> > >  }
> > >=20
> > > +/**
> > > + * exar_mpio_config() - Configure an EXar MPIO as input or output
> > > + * @priv: Device's private structure
> > > + * @mpio_num: MPIO number/offset to configure
> > > + * @output: Configure as output if true, inout if false
> > > + *
> > > + * Configure a single MPIO as an input or output and disable trisate=
=2E =20
> >=20
> > tristate
> >=20
> > > + * If configuring as output it is reccomended to set value with
> > > + * exar_mpio_set prior to calling this function to ensure default st=
ate. =20
> >=20
> > Use () if talking about function.
> >=20
> > > + *
> > > + * Return: 0 on success, negative error code on failure
> > > + */
> > > +static int exar_mpio_config(struct exar8250 *priv,
> > > +=09=09=09unsigned int mpio_num, bool output)
> > > +{
> > > +=09uint8_t sel_reg; //MPIO Select register (input/output)
> > > +=09uint8_t tri_reg; //MPIO Tristate register
> > > +=09uint8_t value;
> > > +=09unsigned int bit;
> > > +
> > > +=09if (mpio_num < 8) {
> > > +=09=09sel_reg =3D UART_EXAR_MPIOSEL_7_0;
> > > +=09=09tri_reg =3D UART_EXAR_MPIO3T_7_0;
> > > +=09=09bit =3D mpio_num;
> > > +=09} else if (mpio_num >=3D 8 && mpio_num < 16) {
> > > +=09=09sel_reg =3D UART_EXAR_MPIOSEL_15_8;
> > > +=09=09tri_reg =3D UART_EXAR_MPIO3T_15_8;
> > > +=09=09bit =3D mpio_num - 8;
> > > +=09} else {
> > > +=09=09return -EINVAL;
> > > +=09}
> > > +
> > > +=09//Disable MPIO pin tri-state
> > > +=09value =3D exar_read_reg(priv, tri_reg);
> > > +=09value &=3D ~(BIT(bit)); =20
> >=20
> > Use more meaningful variable name than "bit", it could perhaps even avo=
id=20
> > the need to use the comment if the code is self-explanary with better=
=20
> > variable name.
> >=20
> > > +=09exar_write_reg(priv, tri_reg, value);
> > > +
> > > +=09value =3D exar_read_reg(priv, sel_reg);
> > > +=09//Set MPIO as input (1) or output (0) =20
> >=20
> > Unnecessary comment.
> >=20
> > > +=09if (output)
> > > +=09=09value &=3D ~(BIT(bit)); =20
> >=20
> > Unnecessary parenthesis.
> >=20
> > > +=09else
> > > +=09=09value |=3D BIT(bit);
> > > +
> > > +=09exar_write_reg(priv, sel_reg, value); =20
> >=20
> > Don't leave empty line into RMW sequence.
> >=20
> > > +
> > > +=09return 0;
> > > +}
> > > +/**
> > > + * exar_mpio_set() - Set an Exar MPIO output high or low
> > > + * @priv: Device's private structure
> > > + * @mpio_num: MPIO number/offset to set
> > > + * @high: Set MPIO high if true, low if false
> > > + *
> > > + * Set a single MPIO high or low. exar_mpio_config must also be call=
ed
> > > + * to configure the pin as an output.
> > > + *
> > > + * Return: 0 on success, negative error code on failure
> > > + */
> > > +static int exar_mpio_set(struct exar8250 *priv,
> > > +=09=09unsigned int mpio_num, bool high)
> > > +{
> > > +=09uint8_t reg;
> > > +=09uint8_t value;
> > > +=09unsigned int bit;
> > > +
> > > +=09if (mpio_num < 8) {
> > > +=09=09reg =3D UART_EXAR_MPIOSEL_7_0;
> > > +=09=09bit =3D mpio_num;
> > > +=09} else if (mpio_num >=3D 8 && mpio_num < 16) {
> > > +=09=09reg =3D UART_EXAR_MPIOSEL_15_8;
> > > +=09=09bit =3D mpio_num - 8;
> > > +=09} else {
> > > +=09=09return -EINVAL;
> > > +=09}
> > > +
> > > +=09value =3D exar_read_reg(priv, reg);
> > > +
> > > +=09if (high)
> > > +=09=09value |=3D BIT(bit);
> > > +=09else
> > > +=09=09value &=3D ~(BIT(bit)); =20
> >=20
> > Extra parenthesis.
> >=20
> > > +
> > > +=09exar_write_reg(priv, reg, value); =20
> >=20
> > Again, I'd put this kind of simple RMW sequence without newlines.
> >=20
> > > +
> > > +=09return 0;
> > > +} =20
>=20
> I will fix above.=20
>=20
> > There are zero users of these functions so I couldn't review if two=20
> > functions are really needed, or if the difference could be simply handl=
ed=20
> > using a boolean parameter.
> >=20
>=20
> The functions are used by code in other patches in this series.=20
>=20
> I kept exar_mpio_set() and exar_mpio_config() separate because we plan on
> adding support for other features in the future that require reading and=
=20
> writing MPIO.=20

Ok. After getting up to the point where the callers were, I started to=20
understand things somewhat better so keeping them separate seems fine=20
with how I ended up understanding things.

But please put these functions into the patch which is using them when you=
=20
reorganize the series.

--=20
 i.

--8323328-2064743525-1712929495=:1014--

