Return-Path: <linux-kernel+bounces-110452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE06885F1E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A2AA281720
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008DD134433;
	Thu, 21 Mar 2024 16:55:06 +0000 (UTC)
Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AD313398E;
	Thu, 21 Mar 2024 16:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711040105; cv=none; b=bPo+5XOj3Y/alr5pBK4yanXsGGoM3M9G3EME3guf4svkq1wym5SYbo0wbA+cQ+qLuI6TwknY4QuU9l/wJi6+GELXgmnqATE4G630pi7NpPfCjCAp+ZuBhLWwFToWjZUv+GrSmGQA0aKS49fI/nkQ6lAJOo722a8O+ny0DgLrql8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711040105; c=relaxed/simple;
	bh=DAYUzvLgjGxzoLKaxbAegS32rjkdBP2mRLv51HBBX5g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:To:From:
	 References:In-Reply-To; b=EOYiIqroo2LzqUe9j0WbcS3mfHOxTeP07ZD/FNEnajI4/sGqMcTsum5fIdv4Zmh88yBjKFG8Ix2A2waDlXUWgdfHizaXIejYEZIeRf1dhf/8hi8gdnIHWVl3ZoLxweIO6Mxl9GN8FEJ1ZvFtEnopCe1uLf9VHJVYAE+nGqI88uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
Received: from localhost (koleje-wifi-0015.koleje.cuni.cz [78.128.191.15])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 42LGsiwb094691
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 17:54:46 +0100 (CET)
	(envelope-from balejk@matfyz.cz)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 Mar 2024 17:55:17 +0100
Message-Id: <CZZL3MNOT0QG.2WDSNX9XD2RET@matfyz.cz>
Cc: "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "Liam Girdwood"
 <lgirdwood@gmail.com>,
        "Mark Brown" <broonie@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-input@vger.kernel.org>,
        =?utf-8?q?Duje_Mihanovi=C4=87?=
 <duje.mihanovic@skole.hr>,
        <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>
Subject: Re: [RFC PATCH v4 2/5] mfd: add driver for Marvell 88PM886 PMIC
To: "Lee Jones" <lee@kernel.org>
From: "Karel Balej" <balejk@matfyz.cz>
References: <20240311160110.32185-1-karelb@gimli.ms.mff.cuni.cz>
 <20240311160110.32185-3-karelb@gimli.ms.mff.cuni.cz>
 <20240321154211.GA13211@google.com> <CZZK759UU6G7.MFPYOI0HBB6I@matfyz.cz>
 <20240321162045.GC13211@google.com>
In-Reply-To: <20240321162045.GC13211@google.com>

Lee Jones, 2024-03-21T16:20:45+00:00:
> On Thu, 21 Mar 2024, Karel Balej wrote:
>
> > Lee Jones, 2024-03-21T15:42:11+00:00:
> > > On Mon, 11 Mar 2024, Karel Balej wrote:
> > > > diff --git a/include/linux/mfd/88pm886.h b/include/linux/mfd/88pm88=
6.h
> > > > new file mode 100644
> > > > index 000000000000..a5e6524bb19d
> > > > --- /dev/null
> > > > +++ b/include/linux/mfd/88pm886.h
> > > > @@ -0,0 +1,38 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > > +#ifndef __MFD_88PM886_H
> > > > +#define __MFD_88PM886_H
> > > > +
> > > > +#include <linux/i2c.h>
> > > > +#include <linux/regmap.h>
> > > > +
> > > > +#define PM886_A1_CHIP_ID		0xa1
> > > > +
> > > > +#define PM886_REGMAP_CONF_MAX_REG	0xfe
> > > > +
> > > > +#define PM886_REG_ID			0x00
> > > > +
> > > > +#define PM886_REG_STATUS1		0x01
> > > > +#define PM886_ONKEY_STS1		BIT(0)
> > > > +
> > > > +#define PM886_REG_MISC_CONFIG1		0x14
> > > > +#define PM886_SW_PDOWN			BIT(5)
> > > > +
> > > > +#define PM886_REG_MISC_CONFIG2		0x15
> > > > +#define PM886_INT_INV			BIT(0)
> > > > +#define PM886_INT_CLEAR			BIT(1)
> > > > +#define PM886_INT_RC			0x00
> > > > +#define PM886_INT_WC			BIT(1)
> > > > +#define PM886_INT_MASK_MODE		BIT(2)
> > > > +
> > > > +struct pm886_chip {
> > > > +	struct i2c_client *client;
> > > > +	unsigned int chip_id;
> > > > +	struct regmap *regmap;
> > > > +};
> > > > +
> > > > +static const struct regmap_config pm886_i2c_regmap =3D {
> > > > +	.reg_bits =3D 8,
> > > > +	.val_bits =3D 8,
> > > > +	.max_register =3D PM886_REGMAP_CONF_MAX_REG,
> > > > +};
> > >
> > > Why is this in here?
> >=20
> > Because since I moved the regulators regmap initialization into the
> > regulators driver, I need to access it from there.
>
> So move it into the regulators driver?

It is used in the MFD driver too for the base regmap.

K. B.

