Return-Path: <linux-kernel+bounces-148092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A268A7D9E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 850641C21A34
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A3F79B77;
	Wed, 17 Apr 2024 08:01:00 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91FC71B24
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 08:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713340859; cv=none; b=WBbZSudUF7fL9FwuEqLXtw/yN1709B+cyIU/4w5IrBYbi6W599u9Xjz4OdSIC/g7GZNCUaG28ud8eS0pMByV4SP5lFkC8fTsRqZD3hDGaf0dsTsEQg3p75w+aQ8lVbPNk8vG/U7jOqkbRtcZU02eTa/7vmF+9ErkG3XBiJWkl7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713340859; c=relaxed/simple;
	bh=w4qwjK5657n7xVlg+DKxr5XmFH0x9Pv+H+yUAvRdkHs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I6ydJNKxQO3gJN29zkZAVl1t9eOBOInbap7Cdhhnf3gH8ZM8qzHdQifVpiRaCC4og76cYPXBnKLBtrGoCjw4yOKngfwPfiPXPT50MFU6QD2wAsSNQwzClojQel6Z9IyNXpYlNfsCRX0T1G1jQ8zuvnDn1lujwU+/s7yZv9ycyqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1rx0Db-0000Xm-FZ; Wed, 17 Apr 2024 10:00:35 +0200
Message-ID: <47cd522d09fbfb4cce7d1d82e6657b6b21fa04d7.camel@pengutronix.de>
Subject: Re: [PATCH v1] arm64: dts: imx8mm: fix missing pgc_vpu_* power
 domain parent
From: Lucas Stach <l.stach@pengutronix.de>
To: Vitor Soares <ivitro@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,  Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>
Cc: Vitor Soares <vitor.soares@toradex.com>, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 17 Apr 2024 10:00:34 +0200
In-Reply-To: <c064940ba46449b540a3cba14ebab96d31ba19de.camel@gmail.com>
References: <20240409085802.290439-1-ivitro@gmail.com>
	 <9ce35b9bb5a15891f6bd01bd54b7dc84b3ba4021.camel@pengutronix.de>
	 <e1552a3008a30ef7ed9097b4b80cda23ccb9e840.camel@gmail.com>
	 <fcd6acc268b8642371cf289149b2b1c3e90c7f45.camel@pengutronix.de>
	 <bd4d7198e58bd89b46a4c721546f6975b287a5fc.camel@gmail.com>
	 <c76d98a300a9d65d236d334da62916a7d658ef27.camel@gmail.com>
	 <564fa534b32f4a6e96da6752f531fc7447ec633d.camel@gmail.com>
	 <c064940ba46449b540a3cba14ebab96d31ba19de.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Vitor,

Am Dienstag, dem 16.04.2024 um 17:08 +0100 schrieb Vitor Soares:
> On Tue, 2024-04-16 at 11:53 +0100, Vitor Soares wrote:
> > ++ Peng Fan <peng.fan@nxp.com>
> >=20
> > Greetings,
> >=20
> >=20
> > On Wed, 2024-04-10 at 12:01 +0100, Vitor Soares wrote:
> > > Hi Lucas,
> > >=20
> > > On Tue, 2024-04-09 at 17:44 +0100, Vitor Soares wrote:
> > > > On Tue, 2024-04-09 at 16:36 +0200, Lucas Stach wrote:
> > > > > Am Dienstag, dem 09.04.2024 um 14:22 +0100 schrieb Vitor Soares:
> > > > > > Hi Lucas,
> > > > > >=20
> > > > > > Thanks for your feedback.
> > > > > >=20
> > > > > > On Tue, 2024-04-09 at 11:13 +0200, Lucas Stach wrote:
> > > > > > > Hi Vitor,
> > > > > > >=20
> > > > > > > Am Dienstag, dem 09.04.2024 um 09:58 +0100 schrieb Vitor
> > > > > > > Soares:
> > > > > > > > From: Vitor Soares <vitor.soares@toradex.com>
> > > > > > > >=20
> > > > > > > > The pgc_vpu_* nodes miss the reference to the power domain
> > > > > > > > parent,
> > > > > > > > leading the system to hang during the resume.
> > > > > > > >=20
> > > > > > > This change is not correct. The vpumix domain is controlled
> > > > > > > through
> > > > > > > the
> > > > > > > imx8mm-vpu-blk-ctrl and must not be directly triggered by the
> > > > > > > child
> > > > > > > domains in order to guarantee proper power sequencing.
> > > > > > >=20
> > > > > > > If the sequencing is incorrect for resume, it needs to be
> > > > > > > fixed
> > > > > > > in
> > > > > > > the
> > > > > > > blk-ctrl driver. I'll happily assist if you have any
> > > > > > > questions
> > > > > > > about
> > > > > > > this intricate mix between GPC and blk-ctrl hardware/drivers.
> > > > > > =C2=A0
> > > > > > I'm new into the topic, so I tried to follow same approach as
> > > > > > in
> > > > > > imx8mp
> > > > > > DT.
> > > > > >=20
> > > > > That's a good hint, the 8MP VPU GPC node additions missed my
> > > > > radar.
> > > > > The
> > > > > direct dependency there between the GPC domains is equally wrong.
> > > > >=20
> > > > > > I also checked the imx8mq DT and it only have one domain for
> > > > > > the
> > > > > > VPU in the GPC. It seem blk-ctrl also dependes on pgc_vpu_* to
> > > > > > work
> > > > > > properly.
> > > > > >=20
> > > > > > The blk-ctrl driver hangs on imx8m_blk_ctrl_power_on() when
> > > > > > access
> > > > > > the
> > > > > > ip registers for the soft reset. I tried to power-up the before
> > > > > > the
> > > > > > soft reset, but it didn't work.
> > > > > >=20
> > > > > The runtime_pm_get_sync() at the start of that function should
> > > > > ensure
> > > > > that bus GPC domain aka vpumix is powered up. Can you check if
> > > > > that
> > > > > is
> > > > > happening?
> > > >=20
> > > > I checked bc->bus_power_dev->power.runtime_status and it is
> > > > RPM_ACTIVE.
> > > >=20
> > > > Am I looking to on the right thing? It is RPM_ACTIVE event before
> > > > runtime_pm_get_sync().
> > >=20
> > > During the probe I can see that
> > > bus_power_dev->power.runtime_status =3D RPM_SUSPENDED and then vpumix
> > > is
> > > powered up on GPC driver.
> > >=20
> > > On resume routine I can't see this flow. bus_power_dev-
> > > > power.runtime_status =3D RPM_ACTIVE and vpumix end up not being
> > > > powered-
> > > up.
> > >=20
> > > I checked the suspend flow and the GPC tries to poweroff vpumix.
> > >=20
> > >=20
> >=20
> > My understanding is that when resuming the 38310000.video-codec, the
> > vpumix isn't powered up. It happens because runtime_status and
> > runtime_last_status =3D RPM_ACTIVE.=20
> >=20
> > I tried to change blk-ctrl suspend routine to force the runtime_status
> > =3D RPM_SUSPENDED, but the system ended up hanging on another device.
> >=20
> > From the comment in blk-ctrl suspend, we rely on PM_SLEEP code that
> > iterates over dpm_list for suspend/resume.
> > I did look at the dpm_list, and it changes the order on every boot.=20
> >=20
> > With all the tests, I also found that the system randomly hangs on
> > dispblk-lcdif suspend. I have confirmed this device is in a different
> > place in the dpm_list (not sure if it is the root cause).=20
> > I haven't understood how blk-ctrl ensures the correct order there yet.=
=20
> >=20
Random order of the DPM list seems like a good find to investigate
further.

> > Taking the following dpm_list excerpt:
> > idx - device
> > ------------------------------
> > ...=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > 191 - imx-pgc-domain.7=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0
> > 192 - imx-pgc-domain.8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0
> > 193 - imx-pgc-domain.9=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0
> > 194 - 38330000.blk-ctrl=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0
> > 195 - 38310000.video-codec=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > 196 - 38300000.video-codec=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > ...
> > 205 - genpd:0:38330000.blk-ctrl
> > 206 - genpd:1:38330000.blk-ctrl
> > 207 - genpd:2:38330000.blk-ctrl
> > 208 - genpd:3:38330000.blk-ctrl
> > ------------------------------
> >=20
> > Shouldn't genpd devices be before 38330000.blk-ctrl?
> > As their power domain is GPC and the blk-ctrl power domain is genpd.
> >=20
>=20
> I did the following change to have genpd device before 38330000.blk-ctrl
> on dpm_list and it did work.
>=20
> diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx=
/imx8m-blk-ctrl.c
> index ca942d7929c2..0f1471dcd4e8 100644
> --- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> @@ -220,6 +220,7 @@ static int imx8m_blk_ctrl_probe(struct platform_devic=
e *pdev)
>                         return dev_err_probe(dev, PTR_ERR(bc->bus_power_d=
ev),
>                                              "failed to attach power doma=
in \"bus\"\n");
>         }
> +       device_move(dev, bc->bus_power_dev, DPM_ORDER_PARENT_BEFORE_DEV);
> =20
>         for (i =3D 0; i < bc_data->num_domains; i++) {
>                 const struct imx8m_blk_ctrl_domain_data *data =3D &bc_dat=
a->domains[i];
> @@ -268,6 +269,7 @@ static int imx8m_blk_ctrl_probe(struct platform_devic=
e *pdev)
>                                       data->gpc_name);
>                         goto cleanup_pds;
>                 }
> +               device_move(dev, domain->power_dev, DPM_ORDER_PARENT_BEFO=
RE_DEV);
> =20
>                 domain->genpd.name =3D data->name;
>                 domain->genpd.power_on =3D imx8m_blk_ctrl_power_on;
>=20
> any concern about this approach?
>=20
I'm a bit uncomfortable with calling such a low-level function from
this driver. Also we don't really want to move the device to a new
parent, but just want to ensure proper order on the dpm list. Adding a
device_link between the devices seems like the better way to do so.

Regards,
Lucas

> Best regards,
> Vitor Soares
> >=20
> > >=20
> > > >=20
> > > >=20
> > > > >=20
> > > > > Regards,
> > > > > Lucas
> > > > >=20
> > > > > > Do you have an idea how we can address this within blk-ctrl?
> > > > > >=20
> > > > > > Best regards,
> > > > > > Vitor
> > > >=20
> > >=20
> >=20
>=20


