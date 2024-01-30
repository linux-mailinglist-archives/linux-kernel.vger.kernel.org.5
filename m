Return-Path: <linux-kernel+bounces-45146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E53842C29
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99730284839
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A0F79936;
	Tue, 30 Jan 2024 18:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="N5gVK9I+"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99B37992D;
	Tue, 30 Jan 2024 18:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706640918; cv=none; b=WIcxmm1rH6OA3O3HZmcm51ao47axJZIwZAbwGPGILQ4kMtlH0J1aBCPz+CxLqufjMbkolivaIZAwleEYaRjAo/jvAgahcvUPvkn9hKX9Kz+UvsFKtTEcJz6sENn2Q54PiPJJ6+edjUuitHQxe/xuGlkDcpnP6GesRnT9hEjbx/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706640918; c=relaxed/simple;
	bh=K6OCEfNXoeLE7q13YNFu+bO9JL2T+WhFDg7I0Idncck=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aZMYTuVdQRYTED9OdCwT5h9TI45HPmcLNzHriDI1QMVP85RlFSerKssXbwLy0dfJCZr1EHEPzrRC8MnI7luzw2xpJEJVwpeKTLDMTcFTQte+4UJYbNNhQHm+NBfrgSZnwwwZRkezQFp0KfKE7WkWgUa5lmY2LX51mH7FqKePH30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=N5gVK9I+; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BD35AE0004;
	Tue, 30 Jan 2024 18:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706640913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zo+y7U6fF32E540j/J6PY7BxhMmSuUIbZmzVgcghKB8=;
	b=N5gVK9I+lk/0dNGLameBqkHfYwcfbgI+ySBF8S/0qZfgZzoJK0hNnmTZuusOkHP+9CyWdB
	AMo/FxJ83hhpMGB+DvAEIVXTKv1agm0ch7gw0OlVL+wmiIINYzTxMdqGj2VLztgyfJdLwc
	CwlNFL9LRXk8+fallnNvS1z1LYwpiqbXKpkUpTBu8yZToa0A1mNb+fmJGypWuqNDZ80PJ1
	VcgGMIHGV3ZDQQkVYeuSGFoO3QCQJ6d/vYKCfAprNGBPAxcYJe2TosY5t6c25QstSAsgaE
	AQgUBrda/UDRsuwbVZ51w8AgxzjUqyi9OexJ/O9RLTUE7X5MfEJOJXkyDLfbJQ==
Date: Tue, 30 Jan 2024 19:55:04 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: David Regan <dregan@broadcom.com>
Cc: William Zhang <william.zhang@broadcom.com>, dregan@mail.com, Richard
 Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 computersforpeace@gmail.com, kdasu.kdev@gmail.com,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Joel Peshkin
 <joel.peshkin@broadcom.com>, Tomer Yacoby <tomer.yacoby@broadcom.com>, Dan
 Beygelman <dan.beygelman@broadcom.com>, Anand Gore
 <anand.gore@broadcom.com>, Kursad Oney <kursad.oney@broadcom.com>, Florian
 Fainelli <florian.fainelli@broadcom.com>, rafal@milecki.pl,
 bcm-kernel-feedback-list@broadcom.com, andre.przywara@arm.com,
 baruch@tkos.co.il, linux-arm-kernel@lists.infradead.org, Dan Carpenter
 <dan.carpenter@linaro.org>
Subject: Re: [PATCH v3 10/10] mtd: rawnand: brcmnand: allow for on-die ecc
Message-ID: <20240130195504.506fb446@xps-13>
In-Reply-To: <CAA_RMS577vw=QWN9_NHfmWqt+_cDG22tA01aU019CPNjAgHqJQ@mail.gmail.com>
References: <20240124030458.98408-1-dregan@broadcom.com>
	<20240124030458.98408-11-dregan@broadcom.com>
	<20240124184027.712b1e47@xps-13>
	<CAA_RMS42FaiN+Za1iY12o0YUANH9rJarBTBa=9jNn8x6_g-Fng@mail.gmail.com>
	<20240126071913.699c3795@xps-13>
	<CAA_RMS5gX88v_Qt1csgSL_ffMNsqo2G8B164EB_Hg=hXd620eg@mail.gmail.com>
	<20240129115228.06dc2292@xps-13>
	<2a3edcf5-7afc-410c-a402-3d8cd3feb1da@broadcom.com>
	<20240130120155.3cb6feed@xps-13>
	<CAA_RMS577vw=QWN9_NHfmWqt+_cDG22tA01aU019CPNjAgHqJQ@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi David,

dregan@broadcom.com wrote on Tue, 30 Jan 2024 07:26:02 -0800:

> Hi Miquel,
>=20
> On Tue, Jan 30, 2024 at 3:01=E2=80=AFAM Miquel Raynal <miquel.raynal@boot=
lin.com> wrote:
> >
> > Hi William,
> >
> > william.zhang@broadcom.com wrote on Tue, 30 Jan 2024 00:11:32 -0800:
> > =20
> > > Hi Miquel,
> > >
> > > On 1/29/24 02:52, Miquel Raynal wrote: =20
> > > > Hi David,
> > > >
> > > > dregan@broadcom.com wrote on Fri, 26 Jan 2024 11:57:39 -0800:
> > > > =20
> > > >> Hi Miqu=C3=A8l,
> > > >>
> > > >> On Thu, Jan 25, 2024 at 10:19=E2=80=AFPM Miquel Raynal
> > > >> <miquel.raynal@bootlin.com> wrote: =20
> > > >>>
> > > >>> Hi David,
> > > >>>
> > > >>> dregan@broadcom.com wrote on Thu, 25 Jan 2024 11:47:46 -0800: =20
> > > >>>   >>>> Hi Miqu=C3=A8l, =20
> > > >>>>
> > > >>>> On Wed, Jan 24, 2024 at 9:40=E2=80=AFAM Miquel Raynal <miquel.ra=
ynal@bootlin.com> wrote: =20
> > > >>>>>
> > > >>>>> Hi David,
> > > >>>>>
> > > >>>>> dregan@broadcom.com wrote on Tue, 23 Jan 2024 19:04:58 -0800: =
=20
> > > >>>>>   >>>>>> Allow settings for on-die ecc such that if on-die ECC =
is selected =20
> > > >>>>>> don't error out but require ECC strap setting of zero
> > > >>>>>>
> > > >>>>>> Signed-off-by: David Regan <dregan@broadcom.com>
> > > >>>>>> Reviewed-by: William Zhang <william.zhang@broadcom.com>
> > > >>>>>> ---
> > > >>>>>> Changes in v3: None
> > > >>>>>> ---
> > > >>>>>> Changes in v2:
> > > >>>>>> - Added to patch series
> > > >>>>>> ---
> > > >>>>>>   drivers/mtd/nand/raw/brcmnand/brcmnand.c | 14 ++++++++++----
> > > >>>>>>   1 file changed, 10 insertions(+), 4 deletions(-)
> > > >>>>>>
> > > >>>>>> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/driver=
s/mtd/nand/raw/brcmnand/brcmnand.c
> > > >>>>>> index a4e311b6798c..42526f3250c9 100644
> > > >>>>>> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > > >>>>>> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > > >>>>>> @@ -2727,9 +2727,11 @@ static int brcmnand_setup_dev(struct br=
cmnand_host *host)
> > > >>>>>>        cfg->blk_adr_bytes =3D get_blk_adr_bytes(mtd->size, mtd=
->writesize);
> > > >>>>>>
> > > >>>>>>        if (chip->ecc.engine_type !=3D NAND_ECC_ENGINE_TYPE_ON_=
HOST) {
> > > >>>>>> -             dev_err(ctrl->dev, "only HW ECC supported; selec=
ted: %d\n",
> > > >>>>>> -                     chip->ecc.engine_type);
> > > >>>>>> -             return -EINVAL;
> > > >>>>>> +             if (chip->ecc.strength) {
> > > >>>>>> +                     dev_err(ctrl->dev, "ERROR!!! HW ECC must=
 be set to zero for non-hardware ECC; selected: %d\n",
> > > >>>>>> +                             chip->ecc.strength); =20
> > > >>>>>
> > > >>>>> Can you use a more formal string? Also clarify it because I don=
't
> > > >>>>> really understand what it leads to. =20
> > > >>>>
> > > >>>> How about:
> > > >>>>
> > > >>>> dev_err(ctrl->dev, "HW ECC set to %d, must be zero for on-die EC=
C\n", =20
> > > >>>
> > > >>> Actually I am wondering how legitimate this is. Just don't enable=
 the
> > > >>> on host ECC engine if it's not in use. No need to check the core's
> > > >>> choice. =20
> > > >>
> > > >> Our chip ECC engine will either be on if it's needed or off if it'=
s not.
> > > >> Either I can do that in one place or put checks in before each
> > > >> read/write to turn on/off the ECC engine, which seems a lot more
> > > >> work and changes and possible issues/problems.
> > > >> Turning it on/off as needed has not been explicitly tested and
> > > >> could cause unforeseen consequences. This
> > > >> is a minimal change which should have minimal impact.
> > > >> =20
> > > >>>   >>>>   >>>>>   >>>>>> +                     return -EINVAL; =20
> > > >>>>>> +             }
> > > >>>>>>        }
> > > >>>>>>
> > > >>>>>>        if (chip->ecc.algo =3D=3D NAND_ECC_ALGO_UNKNOWN) {
> > > >>>>>> @@ -2797,7 +2799,11 @@ static int brcmnand_setup_dev(struct br=
cmnand_host *host)
> > > >>>>>>        if (ret)
> > > >>>>>>                return ret;
> > > >>>>>>
> > > >>>>>> -     brcmnand_set_ecc_enabled(host, 1);
> > > >>>>>> +     if (chip->ecc.engine_type =3D=3D NAND_ECC_ENGINE_TYPE_ON=
_DIE) {
> > > >>>>>> +             dev_dbg(ctrl->dev, "Disable HW ECC for on-die EC=
C\n"); =20
> > > >>>>>
> > > >>>>> Not needed. =20
> > > >>>>
> > > >>>> Will remove. =20
> > > >>>>   >>>>>   >>>>>> +             brcmnand_set_ecc_enabled(host, 0)=
; =20
> > > >>>>>> +     } else
> > > >>>>>> +             brcmnand_set_ecc_enabled(host, 1); =20
> > > >>>>>
> > > >>>>> Style is wrong, but otherwise I think ECC should be kept disabl=
ed while
> > > >>>>> not in active use, so I am a bit surprised by this line. =20
> > > >>>>
> > > >>>> This is a double check to turn on/off our hardware ECC. =20
> > > >>>
> > > >>> I expect the engine to be always disabled. Enable it only when you
> > > >>> need (may require an additional patch before this one). =20
> > > >>
> > > >> We are already turning on the ECC enable at this point,
> > > >> this is just adding the option to turn it off if the NAND chip
> > > >> itself will be doing the ECC instead of our controller. =20
> > > >
> > > > Sorry if I have not been clear.
> > > >
> > > > This sequence:
> > > > - init
> > > > - enable hw ECC engine
> > > > Is broken.
> > > > =20
> > > ECC engine is not enabled for all the cases. Here we only intended to=
 enable it for the nand chip that is set to use NAND_ECC_ENGINE_TYPE_ON_HOS=
T. The logic here should better change to:
> > > if (chip->ecc.engine_type =3D=3D NAND_ECC_ENGINE_TYPE_ON_HOST)
> > >      brcmnand_set_ecc_enabled(host, 1);
> > > else
> > >      brcmnand_set_ecc_enabled(host, 0);
> > > =20
> > > > It *cannot* work as any operation going through exec_op now may
> > > > perform page reads which should be unmodified by the ECC engine. Yo=
u > driver *must* follow the following sequence:
> > > > - init and disable (or keep disabled) the hw ECC engine
> > > > - when you perform a page operation with correction you need to
> > > >     - enable the engine
> > > >     - perform the operation
> > > >     - disable the engine
> > > > Maybe I am missing something here but are you saying the exec_op ca=
n have different ecc type for page read/write at run time on the same nand =
chip? I don't see the op instr structure has the ecc type field and thought=
 it is only bind to the nand chip and won't change at run time. So looks to=
 me the init time setting to the engine based on ecc.engine_type should be =
sufficient. =20
> > >
> > > What you described here can work for the hw.ecc read path (ecc.read_p=
age =3D brcmnand_read_page) which always assumes ecc is enabled. Although i=
t is probably not too bad with these two extra operation, it would be bette=
r if we don't have to add anything as our current code does. For the brcmna=
nd_read_page_raw,  we currently disable the engine and then re-enable it(bu=
t we need to fix it to only enable it with hw ecc engine type).  So it is j=
ust opposite of you logic but works the same with no impact on the most per=
formance critical path. =20
> >
> > This is not "my" logic, this is the "core's" logic. I am saying: your
> > approach is broken because that is not how the API is supposed to work,
> > but it mostly works in the standard case. =20
>=20
> In the interest of minimizing register writes, would it be acceptable to
> enable/disable ECC at the beginning of a standard
> path transfer but not, after the transfer, turn off the ECC? This should =
not
> affect other standard path operations nor affect the exec_op path as those
> are low level transfers which our ECC engine would not touch and the NAND
> device driver should be responsible for turning on/off its own ECC.

Do you have legitimate concerns about this register write taking way
more time than I could expect? Because compared to the transfer of a
NAND page + tR/tPROG it should not be noticeable. I don't see how you
could even measure such impact actually, unless the register write does
way more than usual. I'm fine with the above idea if you show me it has
an interest.

Thanks,
Miqu=C3=A8l

