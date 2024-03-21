Return-Path: <linux-kernel+bounces-110318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D96C7885D1E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E2CE284468
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB5412C541;
	Thu, 21 Mar 2024 16:13:02 +0000 (UTC)
Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E126374DB;
	Thu, 21 Mar 2024 16:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711037582; cv=none; b=hBp0QSqEDqLNNZsB4VGllertCKe0OJTt/kDhuO/2qfV+0T/gmW+35kSukVNhFo0XKwtMmF6KdOiI5jHQnRhcjG8r8xWJLvh7HEnIDfUX9c6f/ptCaFqN3Lm9xzGfLgzafE4ilOQVMfBkSLAhMDMUHjat//Ttun9frckiTQlylqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711037582; c=relaxed/simple;
	bh=9R4gCox+E9eEsiYc1eXiYAUN243WaEBdwfQKvOV43eo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:To:From:
	 References:In-Reply-To; b=lSCm3t9Ibm0+SIfxZuyzKPfpLDbeaIVOua8QnnXxyg0Ucv6ZT6TeXi02YY8msXvexqMwksFQrAaKpwGP3NX5dvJ5FgBH/SyxsKGpgBgxg8e0Z9o0wClYhoMdHbAiUaDNKZbpkTyhEgb9hvfDriAQobMsoKu0zNKGiMcBu0d42Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
Received: from localhost (koleje-wifi-0015.koleje.cuni.cz [78.128.191.15])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 42LGCJZi093335
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 17:12:20 +0100 (CET)
	(envelope-from balejk@matfyz.cz)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 Mar 2024 17:12:52 +0100
Message-Id: <CZZK759UU6G7.MFPYOI0HBB6I@matfyz.cz>
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
 <20240321154211.GA13211@google.com>
In-Reply-To: <20240321154211.GA13211@google.com>

Lee Jones, 2024-03-21T15:42:11+00:00:
> On Mon, 11 Mar 2024, Karel Balej wrote:
>
> > From: Karel Balej <balejk@matfyz.cz>
> >=20
> > Marvell 88PM886 is a PMIC which provides various functions such as
> > onkey, battery, charger and regulators. It is found for instance in the
> > samsung,coreprimevelte smartphone with which this was tested. Implement
> > basic support to allow for the use of regulators and onkey.
> >=20
> > Signed-off-by: Karel Balej <balejk@matfyz.cz>
> > ---
> >=20
> > Notes:
> >     RFC v4:
> >     - Use MFD_CELL_* macros.
> >     - Address Lee's feedback:
> >       - Do not define regmap_config.val_bits and .reg_bits.
> >       - Drop everything regulator related except mfd_cell (regmap
> >         initialization, IDs enum etc.). Drop pm886_initialize_subregmap=
s.
> >       - Do not store regmap pointers as an array as there is now only o=
ne
> >         regmap. Also drop the corresponding enum.
> >       - Move regmap_config to the header as it is needed in the regulat=
ors
> >         driver.
> >       - pm886_chip.whoami -> chip_id
> >       - Reword chip ID mismatch error message and print the ID as
> >         hexadecimal.
> >       - Fix includes in include/linux/88pm886.h.
> >       - Drop the pm886_irq_number enum and define the (for the moment) =
only
> >         IRQ explicitly.
> >     - Have only one MFD cell for all regulators as they are now registe=
red
> >       all at once in the regulators driver.
> >     - Reword commit message.
> >     - Make device table static and remove comma after the sentinel to s=
ignal
> >       that nothing should come after it.
> >     RFC v3:
> >     - Drop onkey cell .of_compatible.
> >     - Rename LDO page offset and regmap to REGULATORS.
> >     RFC v2:
> >     - Remove some abstraction.
> >     - Sort includes alphabetically and add linux/of.h.
> >     - Depend on OF, remove of_match_ptr and add MODULE_DEVICE_TABLE.
> >     - Use more temporaries and break long lines.
> >     - Do not initialize ret in probe.
> >     - Use the wakeup-source DT property.
> >     - Rename ret to err.
> >     - Address Lee's comments:
> >       - Drop patched in presets for base regmap and related defines.
> >       - Use full sentences in comments.
> >       - Remove IRQ comment.
> >       - Define regmap_config member values.
> >       - Rename data to sys_off_data.
> >       - Add _PMIC suffix to Kconfig.
> >       - Use dev_err_probe.
> >       - Do not store irq_data.
> >       - s/WHOAMI/CHIP_ID
> >       - Drop LINUX part of include guard name.
> >       - Merge in the regulator series modifications in order to have mo=
re
> >         devices and modify the commit message accordingly. Changes with
> >         respect to the original regulator series patches:
> >         - ret -> err
> >         - Add temporary for dev in pm88x_initialize_subregmaps.
> >         - Drop of_compatible for the regulators.
> >         - Do not duplicate LDO regmap for bucks.
> >     - Rewrite commit message.
> >=20
> >  drivers/mfd/88pm886.c       | 149 ++++++++++++++++++++++++++++++++++++
> >  drivers/mfd/Kconfig         |  12 +++
> >  drivers/mfd/Makefile        |   1 +
> >  include/linux/mfd/88pm886.h |  38 +++++++++
> >  4 files changed, 200 insertions(+)
> >  create mode 100644 drivers/mfd/88pm886.c
> >  create mode 100644 include/linux/mfd/88pm886.h
>
> Looks mostly okay.
>
> > diff --git a/include/linux/mfd/88pm886.h b/include/linux/mfd/88pm886.h
> > new file mode 100644
> > index 000000000000..a5e6524bb19d
> > --- /dev/null
> > +++ b/include/linux/mfd/88pm886.h
> > @@ -0,0 +1,38 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +#ifndef __MFD_88PM886_H
> > +#define __MFD_88PM886_H
> > +
> > +#include <linux/i2c.h>
> > +#include <linux/regmap.h>
> > +
> > +#define PM886_A1_CHIP_ID		0xa1
> > +
> > +#define PM886_REGMAP_CONF_MAX_REG	0xfe
> > +
> > +#define PM886_REG_ID			0x00
> > +
> > +#define PM886_REG_STATUS1		0x01
> > +#define PM886_ONKEY_STS1		BIT(0)
> > +
> > +#define PM886_REG_MISC_CONFIG1		0x14
> > +#define PM886_SW_PDOWN			BIT(5)
> > +
> > +#define PM886_REG_MISC_CONFIG2		0x15
> > +#define PM886_INT_INV			BIT(0)
> > +#define PM886_INT_CLEAR			BIT(1)
> > +#define PM886_INT_RC			0x00
> > +#define PM886_INT_WC			BIT(1)
> > +#define PM886_INT_MASK_MODE		BIT(2)
> > +
> > +struct pm886_chip {
> > +	struct i2c_client *client;
> > +	unsigned int chip_id;
> > +	struct regmap *regmap;
> > +};
> > +
> > +static const struct regmap_config pm886_i2c_regmap =3D {
> > +	.reg_bits =3D 8,
> > +	.val_bits =3D 8,
> > +	.max_register =3D PM886_REGMAP_CONF_MAX_REG,
> > +};
>
> Why is this in here?

Because since I moved the regulators regmap initialization into the
regulators driver, I need to access it from there.

> What would you like me to do with this RFC patch?

I was hoping that you would take this through the MFD tree (after the
regulator subsystem maintainers approve the regulators driver).

I have added the remaining regulators to the driver just today and plan
to send the first non-RFC version of the series after I test it, likely
over the weekend. Hopefully the regulators patch will finally get some
attention then.

Thank you, best regards,
K. B.

