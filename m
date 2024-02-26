Return-Path: <linux-kernel+bounces-81139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1108670F5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F06FB1C27E6A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2990C5DF2D;
	Mon, 26 Feb 2024 10:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oeLVSXrQ"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95F95D90F;
	Mon, 26 Feb 2024 10:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708942428; cv=none; b=TdwlDiuGJv+stVs8NKPi8pZx9v8T0AsPQ5/w6p6kEP+pmyX0kI+Ci5xLtkhVtsj92meSFf+YyXtkrLvWHTYb88BCTEp5fQZvhMLsWZVwpfNyNjEdrAlUZ3BFTnqwD5hVXynAJg8iAUKgD+4jY4VsWlwk/Effmpnu3Zm6JMwd0Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708942428; c=relaxed/simple;
	bh=B3YjOE5PYheV7HjsnV+dA52LtrK2wRs5zzXZdAO4pdg=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=F4AWDHTd5OxFxe94I7yTzhFVj1HP0hric0idBKAXBL3nrgFjEOd1zL+UmGs78jGSOOYWdSeQIDJlmcWz5q+oXEM99pdTXXvwGGG+IrBaMcu0TMPORhUc1wyFEFor8rUFmeKAxfxy/Q5Ptu5LIOCIEGhpZNJ9QkDz0+z7PqruV9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oeLVSXrQ; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 927CDFF80A;
	Mon, 26 Feb 2024 10:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708942418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LpmeEW2KPcAcnRm7IcTOCA1adY+H9eQbBF8a76zUX6A=;
	b=oeLVSXrQr6IIzClrt1tDu/K6oB8jB3gPpSrBVvhAw2j/KeY9Hx5gNwc/9oiM2b4C+VjOgC
	hv3cbSLvBTO8qLMhNd+CYQUjf26yK5wic4Q/FpJbUi66lNVR5/Lc9gFW3OLKCJAKKYGgTx
	uTQ4Q+33Wg5WY8xGJ7E8qYy6xTHVgS7gbmfRFmUtpUFhMswU0Cex+tAu2CTGaEfh8vCRZo
	nJbuk0HrQirievwIPJRntrdd7GuLa/WzdXRm4srSNLymiga5lsGP/dDFk8lQOqUkY3nOqF
	Ur+42OQ45ic6IG32xDfH0H6m0bPti8gyXwvLvs9CBC25fZxnjjTfk49xiABOrg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Feb 2024 11:13:36 +0100
Message-Id: <CZEXIZWQO1XB.1YY4P72A2K1HJ@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v3 4/8] usb: cdns3-ti: support reset-on-resume behavior
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Kevin
 Hilman" <khilman@kernel.org>, "Alan Stern" <stern@rowland.harvard.edu>,
 <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
To: "Sergei Shtylyov" <sergei.shtylyov@gmail.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rob Herring" <robh+dt@kernel.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Roger Quadros" <rogerq@kernel.org>, "Peter Chen"
 <peter.chen@kernel.org>, "Pawel Laszczak" <pawell@cadence.com>, "Nishanth
 Menon" <nm@ti.com>, "Vignesh Raghavendra" <vigneshr@ti.com>, "Tero Kristo"
 <kristo@kernel.org>
X-Mailer: aerc 0.15.2
References: <20240223-j7200-usb-suspend-v3-0-b41c9893a130@bootlin.com>
 <20240223-j7200-usb-suspend-v3-4-b41c9893a130@bootlin.com>
 <b778d2e8-3fcf-afe4-2e48-0348be19a085@gmail.com>
In-Reply-To: <b778d2e8-3fcf-afe4-2e48-0348be19a085@gmail.com>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello Sergey,

On Sat Feb 24, 2024 at 10:08 AM CET, Sergei Shtylyov wrote:
> On 2/23/24 7:05 PM, Th=C3=A9o Lebrun wrote:
> > Add match data support, with one boolean to indicate whether the
> > hardware resets after a system-wide suspend. If hardware resets, we
> > force execute ->runtime_resume() at system-wide resume to run the
> > hardware init sequence.
> >=20
> > No compatible exploits this functionality, just yet.
> >=20
> > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> > ---
> >  drivers/usb/cdns3/cdns3-ti.c | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >=20
> > diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.=
c
> > index 4c8a557e6a6f..f76327566798 100644
> > --- a/drivers/usb/cdns3/cdns3-ti.c
> > +++ b/drivers/usb/cdns3/cdns3-ti.c
> [...]
> > @@ -220,8 +226,29 @@ static int cdns_ti_runtime_resume(struct device *d=
ev)
> >  	return 0;
> >  }
> > =20
> > +static int cdns_ti_suspend(struct device *dev)
> > +{
> > +	struct cdns_ti *data =3D dev_get_drvdata(dev);
> > +
> > +	if (data->match_data && data->match_data->reset_on_resume)
> > +		return pm_runtime_force_suspend(dev);
> > +	else
>
>    Pointless *else* after *return*...

Indeed! I used this form explicitely as it reads nicely: "if reset on
reset, force suspend, else do nothing". It also prevents the error of
adding behavior below the if-statement without seeing that it won't
apply to both cases.

If you do believe it would make the code better I'll happily change it
for the next revision, I do not mind.

Thanks for the review Sergey!

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

