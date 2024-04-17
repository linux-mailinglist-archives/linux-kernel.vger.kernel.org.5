Return-Path: <linux-kernel+bounces-148536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAF68A8419
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC1371C21276
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD48513DDAE;
	Wed, 17 Apr 2024 13:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="Jf2vggop"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E94513D61A;
	Wed, 17 Apr 2024 13:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713359876; cv=none; b=YyvzdYL4R0S8HssaEymYhhcEECkKsD+KS4ExrmPSI68RsEu3zsQYOf72jGzYrDuxO0urzkdY2bN77/qnFSx+1qE0Z67hF81gU4+mWqCcAgagMYIT78SyoJaz9Zru6r1Qvv2bx0iWSYvzto89J5q0DteWUv974Q91PtEIGQ4PWt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713359876; c=relaxed/simple;
	bh=rvFtC/qvGiX9LgdBwi+/+H81t6uI0zOxVKurDnXgb5s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jad5J/uUHY3n9zXFU1865sHwfPY37Ba+h36E0f/h/M3by2a6up6mpSHr0wkSKJIo/KUEX0A+J8pTq0Sr3hOoSTu4MU4DZ+aC5nTTMtPTnuv/TKNNMDERtyI/oxMa0L8lm/A8CmVX1Eic5sz6hDJ6/LlGkNHAcx32UtHciZJLFa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=Jf2vggop; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1713359856; x=1713964656; i=parker@finest.io;
	bh=BgfUerVH0kd2KFVCkaj5Es5/WSw+AOv3AubeVBIVuyI=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Jf2vggop2FGO/81lVb2b1wXvv5TofUn30HgqrujVfGp9mJe6RT4FXfdbyopC2jsH
	 LV7YrT23kOS8cEEuF2lTrkUp+FpRQwHg9el1axIjgGtQXTF43LXzysSG1RXUG211v
	 A9790qzbVrQelEEasEEEbMu5nDpiTVsumcp9Z7G3abXnA1jp0wjua34j2OPzjSsWm
	 Fel0sUtIGe7d+QyLDHAG4rFx67ozfR7S9duX8ul/vkGxkjOXYI+25viN0yEMe8vD5
	 TTzvu29mFNRJMLRsDRIOqwgnE28CdI/8CyjZP7a8oyshL3meI7BVoOSY0hdt/G7tL
	 59OHmOaFpZeyCv6Dkw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0M39Wb-1slkRj1qvn-010oZ9; Wed, 17 Apr 2024 15:17:36 +0200
Date: Wed, 17 Apr 2024 09:17:35 -0400
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v3 7/8] serial: exar: add CTI specific setup code
Message-ID: <20240417091735.17686470@SWDEV2.connecttech.local>
In-Reply-To: <2024041726-fall-debunk-6cc5@gregkh>
References: <cover.1713270624.git.pnewman@connecttech.com>
	<354ff4aa9d8bdea1a21c503e685e81ac3df48eb8.1713270624.git.pnewman@connecttech.com>
	<2024041726-fall-debunk-6cc5@gregkh>
Organization: Connect Tech Inc.
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s26PEoG6OXqDjHRA4nFr6baAoEBSz4dvMDsYyfdhq6DjrfMp/ua
 wr4u/aOiZ3BaZnnYy9XRZRJLqBuSpq0ojJ/D0fTCDtGIO9PxmnOEF2tYP1UY9pbJCBhCo0N
 +vhSETt869d8IaL35I3lxw5FwEaWL3S4d5cZiVLFh3vNNlyhVGl/eOi7TP7fKgIgCMqFXUc
 4iDF41eUeaCd4Xsc4dHQw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KFn6XB/g77w=;bS2dE+5r+ISIlTwNXr5YUaHmTX2
 vmKjNHqb/h0j45VCQQ48V+aCS+HpHTvC30y15zPvuFJuYNto8ggeutT8ir374S71RtxSYDxNY
 5Z4YHSt5FpzADA8m0uc2PAvaVUUckG6lXNIz3t91/MS1dngcSfLJHVtPzrsaSynFWJBD4jRyv
 weLDdkofogN2j3sazw3YXzZASi+qHlmY0yq5ABDgOOLTlLUylMWhshBQtS5G5zJso8phYO53l
 Ha8AtaVXDgbNKBAYqxOD/SL6i1V006gGGPfMLkxlAd8V9S0AUaJhN67sm81j4UPTN/cPglni0
 tko0vU8Q1Al9yNOrw8wXNNdLMsYbidr3yFG/6ttQYB58wofv1QdMZCwrDW5CF+zavGbtLdmvu
 9Ekh58/UveEkvqsvqogEr7nBb5HuagSWucVxuDMu/yfTsLNyoWzmgkq7oJZ/CYRN3K/DPSUxU
 MrgOF+qFa4sMyucNEU2mi9kOmKduc0QER/il4A7tTiYfy2yapWgNQes7+zq/mURMNYXUwuKC2
 /hKMFZEWZ9a7Epyt8knudbuYjHM3sqtgCA+r3yUKbgBZFCSWKAXHCki87TQOLh06Bxtowv2zK
 XKY4lfWY1/Xl93WTW9Q7pcQ97KjmtMO4SqN7QZ6PYv3HI2ZFXjph3/VcNxQJabu/hsytBDUkQ
 huQpHgIz8o31hm5AxJdFrhEVtRBfrobZ6x4HmPSltxOWvMwzUdDLfy8ywM+rkHlgBU0XXGEXz
 Y3FHNMXr+tA/jhuydpI4Mc+SMAvCL43tLdaNZtKVOHD01PjVGQ4Zis=

On Wed, 17 Apr 2024 13:24:20 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Tue, Apr 16, 2024 at 08:55:34AM -0400, Parker Newman wrote:
> >  struct exar8250 {
> >  	unsigned int		nr;
> > +	unsigned int		osc_freq;
> > +	struct pci_dev		*pcidev;
> > +	struct device		*dev;
>
> Why do you need both a pci_dev and a device?  Aren't they the same thing
> here?
>

I added dev to make the prints cleaner. I personally prefer:

	dev_err(priv->dev, ...);
to
	dev_err(&priv->pcidev->dev, ...);

or to adding a:
	struct device *dev =3D &priv->pcidev->dev;

to every function just for printing.

However, I do understand your point. I can drop dev if you prefer.

> > +/**
> > + * _cti_set_tristate() - Enable/Disable RS485 transciever tristate
> > + * @priv: Device's private structure
> > + * @port_num: Port number to set tristate on/off
> > + * @enable: Enable tristate if true, disable if false
> > + *
> > + * Most RS485 capable cards have a power on tristate jumper/switch th=
at ensures
> > + * the RS422/RS485 transciever does not drive a multi-drop RS485 bus =
when it is
> > + * not the master. When this jumper is installed the user must set th=
e RS485
> > + * mode to disable tristate prior to using the port.
> > + *
> > + * Some Exar UARTs have an auto-tristate feature while others require=
 setting
> > + * an MPIO to disable the tristate.
> > + *
> > + * Return: 0 on success, negative error code on failure
> > + */
> > +static int _cti_set_tristate(struct exar8250 *priv,
> > +			unsigned int port_num, bool enable)
> > +{
> > +	int ret =3D 0;
> > +
> > +	if (port_num >=3D priv->nr)
> > +		return -EINVAL;
> > +
> > +	// Only Exar based cards use MPIO, return 0 otherwise
> > +	if (priv->pcidev->vendor !=3D PCI_VENDOR_ID_EXAR)
> > +		return 0;
>
> How can this ever happen?  Only the exar devices will call this
> function, or am I missing a path here?
>

Yes that can go now, it used to be needed but not now. I will remove.

>
> > +
> > +	dev_dbg(priv->dev, "%s tristate for port %u\n",
> > +		str_enable_disable(enable), port_num);
> > +
> > +	if (enable)
> > +		ret =3D exar_mpio_set_low(priv, port_num);
> > +	else
> > +		ret =3D exar_mpio_set_high(priv, port_num);
> > +	if (ret)
> > +		return ret;
> > +
> > +	// Ensure MPIO is an output
> > +	ret =3D exar_mpio_config_output(priv, port_num);
> > +
> > +	return ret;
> > +}
> > +
> > +static int cti_tristate_disable(struct exar8250 *priv, unsigned int p=
ort_num)
> > +{
> > +	return _cti_set_tristate(priv, port_num, false);
> > +}
>
> Do you ever call _cti_set_tristate() with "true"?
>

Currently no. However, re-enabling tristate via a custom ioctl was a featu=
re in
our old out-of-tree driver (which was created prior to linux RS485 support=
).

I am not sure how it would be activated now, but I left enabling tristate =
as an
option in to make it easier down the line when we need it.

I can add a note to the patch or remove it if you would prefer.

> > +
> > +/**
> > + * _cti_set_plx_int_enable() - Enable/Disable PCI interrupts
> > + * @priv: Device's private structure
> > + * @enable: Enable interrupts if true, disable if false
>
> But false is never used here, so why have this at all?
>
> > + *
> > + * Some older CTI cards require MPIO_0 to be set low to enable the PC=
I
> > + * interupts from the UART to the PLX PCI->PCIe bridge.
> > + *
> > + * Return: 0 on success, negative error code on failure
> > + */
> > +static int _cti_set_plx_int_enable(struct exar8250 *priv, bool enable=
)
> > +{
> > +	int ret =3D 0;
> > +
> > +	// Only Exar based cards use MPIO, return 0 otherwise
> > +	if (priv->pcidev->vendor !=3D PCI_VENDOR_ID_EXAR)
> > +		return 0;
>
> Same question here.
>

Same as above, not needed. I will remove.

> > +
> > +	if (enable)
> > +		ret =3D exar_mpio_set_low(priv, 0);
> > +	else
> > +		ret =3D exar_mpio_set_high(priv, 0);
> > +	if (ret)
> > +		return ret;
> > +
> > +	// Ensure MPIO is an output
> > +	ret =3D exar_mpio_config_output(priv, 0);
> > +
> > +	return ret;
> > +}
> > +
> > +static int cti_plx_int_enable(struct exar8250 *priv)
> > +{
> > +	return _cti_set_plx_int_enable(priv, true);
>
> Again, no wrapper needed if you never actually call that function with
> "false", right?  Or am I missing a path here?
>

This one is similar to _cti_set_tristate() but is less likely to be used.

Thanks again,
Parker

> thanks,
>
> greg k-h


