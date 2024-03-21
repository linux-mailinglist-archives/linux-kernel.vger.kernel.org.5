Return-Path: <linux-kernel+bounces-110329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B76CC885D4C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CBBE281A20
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD5212CD96;
	Thu, 21 Mar 2024 16:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQfOvwGG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5C912C7FD;
	Thu, 21 Mar 2024 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711038053; cv=none; b=oP3m7LspuWuWchcjngqMROpUHjrrB8W//P0CQXJtRWJS2Tx77sVRFi1Vg8PYFCCrNf4PLZ5WsBAAwGhunCAR0zq+jVoDU1/zLKC7HL7p29TG5do6MDCA+EaTQnAVB7ZZ2bTTeqdBUCFZjcf36MPOUe//2p8AlcYnOnf+fhhELz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711038053; c=relaxed/simple;
	bh=XZyjOkWc9QSQZf4NA8aTEMhj5g0bWu5Yi9eO+24xidg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zn24WOx4+U3uSgRDhLLUnpL3wCh2RmWEa4yZbk3CL6H3iX6ybMWl3lciiyThROB4VRddpWdKxmCl/BIWsQGLBRzUiY5tL5jUt5PZregkK6bJEgIJ1Z/HIqcaAGLN684/kE4rZXJDd+K0AzQYbKrWInKHIJcF0cpyurVbhJwxa/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQfOvwGG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C7EC43390;
	Thu, 21 Mar 2024 16:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711038053;
	bh=XZyjOkWc9QSQZf4NA8aTEMhj5g0bWu5Yi9eO+24xidg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bQfOvwGGSx11S83DBOGW3bYlLQ3MWHCcYDK+g+EuLNr+q3bImTgAMbGgxSfTVuIXG
	 xK4C6wGRl3O9SyuI9K+6w0s8pwxBHTjmckC7dX2Oe1oZF2hLeYvOvRz0RZY27BjclH
	 SAuuqCpF2y1iMdgUIAuF5gGYiQgU5Ki8XJjEL8syToTKw23JFWGPoMR0KyaT9oYZBp
	 2SKLPQ6kwjF9/8M1zOro/Y8Bh/0lHo/Aza1KYphM5GywltEYLL/ds+NTD8rmQWQ6h5
	 UlIHQVErk9ogbuZOQ3s2ijgIhTcHu//QIDWWBDZSxLeBn9rFGMe2iS8i+4cF6he9Ef
	 nSfJMeb1MyDiw==
Date: Thu, 21 Mar 2024 16:20:45 +0000
From: Lee Jones <lee@kernel.org>
To: Karel Balej <balejk@matfyz.cz>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [RFC PATCH v4 2/5] mfd: add driver for Marvell 88PM886 PMIC
Message-ID: <20240321162045.GC13211@google.com>
References: <20240311160110.32185-1-karelb@gimli.ms.mff.cuni.cz>
 <20240311160110.32185-3-karelb@gimli.ms.mff.cuni.cz>
 <20240321154211.GA13211@google.com>
 <CZZK759UU6G7.MFPYOI0HBB6I@matfyz.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CZZK759UU6G7.MFPYOI0HBB6I@matfyz.cz>

On Thu, 21 Mar 2024, Karel Balej wrote:

> Lee Jones, 2024-03-21T15:42:11+00:00:
> > On Mon, 11 Mar 2024, Karel Balej wrote:
> >
> > > From: Karel Balej <balejk@matfyz.cz>
> > > 
> > > Marvell 88PM886 is a PMIC which provides various functions such as
> > > onkey, battery, charger and regulators. It is found for instance in the
> > > samsung,coreprimevelte smartphone with which this was tested. Implement
> > > basic support to allow for the use of regulators and onkey.
> > > 
> > > Signed-off-by: Karel Balej <balejk@matfyz.cz>
> > > ---
> > > 
> > > Notes:
> > >     RFC v4:
> > >     - Use MFD_CELL_* macros.
> > >     - Address Lee's feedback:
> > >       - Do not define regmap_config.val_bits and .reg_bits.
> > >       - Drop everything regulator related except mfd_cell (regmap
> > >         initialization, IDs enum etc.). Drop pm886_initialize_subregmaps.
> > >       - Do not store regmap pointers as an array as there is now only one
> > >         regmap. Also drop the corresponding enum.
> > >       - Move regmap_config to the header as it is needed in the regulators
> > >         driver.
> > >       - pm886_chip.whoami -> chip_id
> > >       - Reword chip ID mismatch error message and print the ID as
> > >         hexadecimal.
> > >       - Fix includes in include/linux/88pm886.h.
> > >       - Drop the pm886_irq_number enum and define the (for the moment) only
> > >         IRQ explicitly.
> > >     - Have only one MFD cell for all regulators as they are now registered
> > >       all at once in the regulators driver.
> > >     - Reword commit message.
> > >     - Make device table static and remove comma after the sentinel to signal
> > >       that nothing should come after it.
> > >     RFC v3:
> > >     - Drop onkey cell .of_compatible.
> > >     - Rename LDO page offset and regmap to REGULATORS.
> > >     RFC v2:
> > >     - Remove some abstraction.
> > >     - Sort includes alphabetically and add linux/of.h.
> > >     - Depend on OF, remove of_match_ptr and add MODULE_DEVICE_TABLE.
> > >     - Use more temporaries and break long lines.
> > >     - Do not initialize ret in probe.
> > >     - Use the wakeup-source DT property.
> > >     - Rename ret to err.
> > >     - Address Lee's comments:
> > >       - Drop patched in presets for base regmap and related defines.
> > >       - Use full sentences in comments.
> > >       - Remove IRQ comment.
> > >       - Define regmap_config member values.
> > >       - Rename data to sys_off_data.
> > >       - Add _PMIC suffix to Kconfig.
> > >       - Use dev_err_probe.
> > >       - Do not store irq_data.
> > >       - s/WHOAMI/CHIP_ID
> > >       - Drop LINUX part of include guard name.
> > >       - Merge in the regulator series modifications in order to have more
> > >         devices and modify the commit message accordingly. Changes with
> > >         respect to the original regulator series patches:
> > >         - ret -> err
> > >         - Add temporary for dev in pm88x_initialize_subregmaps.
> > >         - Drop of_compatible for the regulators.
> > >         - Do not duplicate LDO regmap for bucks.
> > >     - Rewrite commit message.
> > > 
> > >  drivers/mfd/88pm886.c       | 149 ++++++++++++++++++++++++++++++++++++
> > >  drivers/mfd/Kconfig         |  12 +++
> > >  drivers/mfd/Makefile        |   1 +
> > >  include/linux/mfd/88pm886.h |  38 +++++++++
> > >  4 files changed, 200 insertions(+)
> > >  create mode 100644 drivers/mfd/88pm886.c
> > >  create mode 100644 include/linux/mfd/88pm886.h
> >
> > Looks mostly okay.
> >
> > > diff --git a/include/linux/mfd/88pm886.h b/include/linux/mfd/88pm886.h
> > > new file mode 100644
> > > index 000000000000..a5e6524bb19d
> > > --- /dev/null
> > > +++ b/include/linux/mfd/88pm886.h
> > > @@ -0,0 +1,38 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > +#ifndef __MFD_88PM886_H
> > > +#define __MFD_88PM886_H
> > > +
> > > +#include <linux/i2c.h>
> > > +#include <linux/regmap.h>
> > > +
> > > +#define PM886_A1_CHIP_ID		0xa1
> > > +
> > > +#define PM886_REGMAP_CONF_MAX_REG	0xfe
> > > +
> > > +#define PM886_REG_ID			0x00
> > > +
> > > +#define PM886_REG_STATUS1		0x01
> > > +#define PM886_ONKEY_STS1		BIT(0)
> > > +
> > > +#define PM886_REG_MISC_CONFIG1		0x14
> > > +#define PM886_SW_PDOWN			BIT(5)
> > > +
> > > +#define PM886_REG_MISC_CONFIG2		0x15
> > > +#define PM886_INT_INV			BIT(0)
> > > +#define PM886_INT_CLEAR			BIT(1)
> > > +#define PM886_INT_RC			0x00
> > > +#define PM886_INT_WC			BIT(1)
> > > +#define PM886_INT_MASK_MODE		BIT(2)
> > > +
> > > +struct pm886_chip {
> > > +	struct i2c_client *client;
> > > +	unsigned int chip_id;
> > > +	struct regmap *regmap;
> > > +};
> > > +
> > > +static const struct regmap_config pm886_i2c_regmap = {
> > > +	.reg_bits = 8,
> > > +	.val_bits = 8,
> > > +	.max_register = PM886_REGMAP_CONF_MAX_REG,
> > > +};
> >
> > Why is this in here?
> 
> Because since I moved the regulators regmap initialization into the
> regulators driver, I need to access it from there.

So move it into the regulators driver?

> > What would you like me to do with this RFC patch?
> 
> I was hoping that you would take this through the MFD tree (after the
> regulator subsystem maintainers approve the regulators driver).
> 
> I have added the remaining regulators to the driver just today and plan
> to send the first non-RFC version of the series after I test it, likely
> over the weekend. Hopefully the regulators patch will finally get some
> attention then.

Don't forget that the merge-window is open.

Many maintainers take a well deserved nap during this period.

-- 
Lee Jones [李琼斯]

