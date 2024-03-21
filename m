Return-Path: <linux-kernel+bounces-110741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4200288630F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 655DD1C20B2A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB72137907;
	Thu, 21 Mar 2024 22:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="O6H+EuOa"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8346136653;
	Thu, 21 Mar 2024 22:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711059017; cv=none; b=AqSRBH5lczcFPj3AWAOTj/9iWw/bcic8lBWcWRbqy0sgF6uzDkTSDVl3M/miB7LtA5YO6OSgTYF035ui/l7MJb+0Vm/3vDD1sJHw17HrT1VFBDcDMVxr3G9gJK77RZqvIUizP1WhgJHiyRHkTgixGz46uhsChvIKUatJ2runD9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711059017; c=relaxed/simple;
	bh=mLjZrpzWrUzujXyXA53GWcvzFQctkeVPVbWC5+9omdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+XHCVoumYKkMhTkrHi5oAj2Ev0o64gOraJKGvrjHs5yOFgqFCdA3m/6VxX3JAdai0BRkkKs/lBC7YnVFT7pLJt+dMDz85F2oOclQHurni7jhHSvhBIbJUuiy+0WxLzcp7ivjfZEWvdur4nYbe3HWPN20Ny3N8nyYNAMhMSA6aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=O6H+EuOa; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 3CDA21C0071; Thu, 21 Mar 2024 23:10:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1711059005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=baJbHNFesYdsQGg2SHQydVd7GbUwkJqAdso+SdWMIW8=;
	b=O6H+EuOa6C8ysSVKamAtuty2XopZZvSdNxX7G1mSZMSdFwCmjmeN+CKSn1EvM22C7DYB4/
	IzHlN1+TeE1D3/byZlth+MxyZ0QWb9+lYBqwiaSZ69APScpTKmANDmIAmjD4tRL4Oat6jB
	RpRfuI7QqRrOCcCjJEEkuqARxq0t7wY=
Date: Thu, 21 Mar 2024 23:10:04 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: phone-devel@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>,
	fiona.klute@gmx.de, martijn@brixit.nl, samuel@sholland.org,
	gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, megi@xff.cz
Subject: Re: [PATCHv2 2/2] usb: typec: anx7688: Add driver for ANX7688 USB-C
 HDMI bridge
Message-ID: <ZfywPHEgYEhFSkGS@duo.ucw.cz>
References: <ZcaCXYOf6o4VNneu@duo.ucw.cz>
 <ZdkOESbty6iMfyhj@duo.ucw.cz>
 <ZfBi5Qj3zV9ffkwQ@kuha.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrV6wORQT5PAs+bk"
Content-Disposition: inline
In-Reply-To: <ZfBi5Qj3zV9ffkwQ@kuha.fi.intel.com>


--lrV6wORQT5PAs+bk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I'm sorry to keep you waiting.

Thanks for comments.

> > +	struct gpio_desc *gpio_reset;
> > +	struct gpio_desc *gpio_cabledet;
> > +
> > +	uint32_t src_caps[8];
>=20
> Use u32 instead of uint32_t.

Will replace globally.

> > +static int anx7688_reg_read(struct anx7688 *anx7688, u8 reg_addr)
> > +{
> > +	int ret;
> > +
> > +	ret =3D i2c_smbus_read_byte_data(anx7688->client, reg_addr);
> > +	if (ret < 0)
> > +		dev_err(anx7688->dev, "i2c read failed at 0x%x (%d)\n",
> > +			reg_addr, ret);
>=20
> dev_dbg instead.

I'd prefer not to. i2c functions should not really fail, and if they
do, we want the error log. This is not debugging, this is i2c failing.

> > +static void anx7688_power_enable(struct anx7688 *anx7688)
> > +{
> > +	gpiod_set_value(anx7688->gpio_reset, 1);
> > +	gpiod_set_value(anx7688->gpio_enable, 1);
> > +
> > +	/* wait for power to stabilize and release reset */
> > +	msleep(10);
>=20
> So is it okay that the sleep may take up to 20ms?

I don't see how that would be a problem.

> > +	gpiod_set_value(anx7688->gpio_reset, 0);
> > +	udelay(2);
>=20
> Use usleep_range() instead.

Can do, but it makes no difference.

> > +	gpiod_set_value(anx7688->gpio_reset, 1);
> > +	msleep(5);
>=20
> The same question here, is it a problem if the sleep ends up taking
> 20ms?

Again, I expect that to be ok.

> > +	ret =3D anx7688_tcpc_reg_read(anx7688, ANX7688_TCPC_REG_INTERFACE_SEN=
D);
> > +	if (ret) {
> > +		dev_err(anx7688->dev,
> > +			"failed to send pd packet (tx buffer full)\n");
>=20
> One line should be enought for that one.

That makes it go over 80 columns, but yes, can be one line.

> > +	// wait until the message is processed (30ms max)
> > +	for (i =3D 0; i < 300; i++) {
> > +		ret =3D anx7688_tcpc_reg_read(anx7688, ANX7688_TCPC_REG_INTERFACE_SE=
ND);
> > +		if (ret <=3D 0)
> > +			return ret;
> > +
> > +		udelay(100);
> > +	}
> > +
> > +	dev_err(anx7688->dev, "timeout waiting for the message queue flush\n"=
);
>=20
> Maybe dev_dbg for this too.

Let's not hide these. If they happen, we can downgrade them, but they
should not.

> > +	/* wait till the firmware is loaded (typically ~30ms) */
> > +	for (i =3D 0; i < 100; i++) {
> > +		ret =3D anx7688_reg_read(anx7688, ANX7688_REG_EEPROM_LOAD_STATUS0);
> > +
> > +		if (ret >=3D 0 && (ret & ANX7688_EEPROM_FW_LOADED) =3D=3D ANX7688_EE=
PROM_FW_LOADED) {
> > +			dev_dbg(anx7688->dev, "eeprom0 =3D 0x%02x\n", ret);
> > +			dev_info(anx7688->dev, "fw loaded after %d ms\n", i * 10);
>=20
> Debugging information. Use dev_dbg.

Ok.

> > +	set_bit(ANX7688_F_FW_FAILED, anx7688->flags);
> > +	dev_err(anx7688->dev, "boot firmware load failed (you may need to fla=
sh FW to anx7688 first)\n");
> > +	ret =3D -ETIMEDOUT;
> > +	goto err_vconoff;
> > +
> > +fw_loaded:
>=20
> This label looks a bit messy to me. You could also move that firmware
> loading wait to its own function.

Ok, let me try to refactor this.

> > +static int anx7688_handle_pd_message_response(struct anx7688 *anx7688,
> > +					      u8 to_cmd, u8 resp)
> > +{
=2E..
> > +	return 0;
> > +}
>=20
> Noise. Drop this whole function. If you need this kind of information,
> then please consider trace points, or just use some debugfs trick like
> what we have in drivers/usb/typec/tcpm/tcpm.c and few other drivers.

Ok.

> > +	switch (cmd) {
> > +	case ANX7688_OCM_MSG_PWR_SRC_CAP:
> > +		dev_info(anx7688->dev, "received SRC_CAP\n");
>=20
> Noise.

Ok, let me convert these to dev_dbg.

> > +
> > +		if (len % 4 !=3D 0) {
> > +			dev_warn(anx7688->dev, "received invalid sized PDO array\n");
> > +			break;
> > +		}
> > +
> > +		/* the partner is PD capable */
> > +		anx7688->pd_capable =3D true;
> > +
> > +		for (i =3D 0; i < len / 4; i++) {
> > +			pdo =3D le32_to_cpu(pdos[i]);
> > +
> > +			if (pdo_type(pdo) =3D=3D PDO_TYPE_FIXED) {
> > +				unsigned int voltage =3D pdo_fixed_voltage(pdo);
> > +				unsigned int max_curr =3D pdo_max_current(pdo);
> > +
> > +				dev_info(anx7688->dev, "SRC_CAP PDO_FIXED (%umV %umA)\n", voltage,=
 max_curr);
>=20
> Noise.
>=20
> > +			} else if (pdo_type(pdo) =3D=3D PDO_TYPE_BATT) {
> > +				unsigned int min_volt =3D pdo_min_voltage(pdo);
> > +				unsigned int max_volt =3D pdo_max_voltage(pdo);
> > +				unsigned int max_pow =3D pdo_max_power(pdo);
> > +
> > +				dev_info(anx7688->dev, "SRC_CAP PDO_BATT (%umV-%umV %umW)\n", min_=
volt, max_volt, max_pow);
>=20
> Noise. That line also really should be split in two.
>=20
> I'm stopping my review here. This driver is too noisy. All dev_info
> calls need to be dropped. If the driver is working correctly then it
> needs to quiet.
>=20
> Most of those prints are useful for debugging only, so I think similar
> debugfs log like the one tcpm.c uses could be a good idea for them
> since you already use debugfs in this driver in any case.

Ok, let me convert the non-error ones to dev_dbg() and split the long
lines. Debug needs to be enabled, so it should not bother anyone, and
it is easier than refactoring driver to use debugfs.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--lrV6wORQT5PAs+bk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZfywPAAKCRAw5/Bqldv6
8gIQAKC/C1qVjFitBa1yebJvld78j9IKrQCfU01Nel525hI5ZTDxawgxmllFMlo=
=RPal
-----END PGP SIGNATURE-----

--lrV6wORQT5PAs+bk--

