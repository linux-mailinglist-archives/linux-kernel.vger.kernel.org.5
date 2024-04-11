Return-Path: <linux-kernel+bounces-140722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A47128A183E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6CC91C21710
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9C313FF6;
	Thu, 11 Apr 2024 15:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b="aZbdSLyI"
Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EA8D534;
	Thu, 11 Apr 2024 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712848186; cv=none; b=GsPnhbzsbh8HiwH02qo+4HfOs+0VwGin7oEwumyELaYWq2Izt5toVkxKXHw25z1zW3QmWTRIq24VNo+JYaXVas2MdAHQnhHPBjWvZoUMzbGnJZopSWwYcIP426HUMzO7eu493A/hepGOBQFICLStSBm8HxF8EGGPf+sruKfuzyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712848186; c=relaxed/simple;
	bh=Weouvo161mz85+Ws3kWCHEAN8xCME/9Sry1jGNBqSMk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:To:From:
	 References:In-Reply-To; b=jSDbCY6qQws53GZUgVbNSNtz062+J71d1hcs7nycPv1yY6ocP7ZeoPV3dULSz7AYLbf/IomDudIpfvbEvMUNRleLaV0DIeGytQ/udepXPnH7eGlpeS6FcQbyTUcgGowP7A4YmjLA2dr+g8NXdTeXjw5lwUh39luxnSDb9qBF020=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b=aZbdSLyI; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mff.cuni.cz;
	s=submission; t=1712848147; x=1714148147;
	bh=cCeEsEVNtOvyeZAP8P6CFO9h6vuYp0g9sWCTeF8QBqc=; h=From;
	b=aZbdSLyIVl3tvrFOIk+Zr5D1SzvZAbhOXUdHCwd0UGiy1HV/xtG2xvif53SQKGZVD
	 GlSQSwoDJnZAU18Tn8N3UoMiINOwj2Eoh9Ohs4RAg/Qas/XfZmkqHLHTDowJHhz9Dn
	 zGAK1q4EoU6T42iW01R3rM7xDiNXGiajh8N5VqD6uf4tPE55vigQj1M7/TdSu7MPVx
	 PG9bfGFkXeRhofxZXZ56749LgtBba2obs6DrXTd+2FGglYVN5OVvLJXRVSjunagMRg
	 iEE93/oB2n+Mdp12ees3RkmlxOcetPxmkq0hrmM17dPmR59egM5i/0fDQ48QZXOICh
	 dhBomyUksKlPQ==
Received: from localhost (koleje-wifi-0017.koleje.cuni.cz [78.128.191.17])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 43BF95MH032359
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 11 Apr 2024 17:09:07 +0200 (CEST)
	(envelope-from balejk@matfyz.cz)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 17:09:40 +0200
Message-Id: <D0HE07BHD1T8.HQLIBUHTRVGT@matfyz.cz>
Cc: "Rob Herring" <robh@kernel.org>,
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
Subject: Re: [PATCH 2/5] mfd: add driver for Marvell 88PM886 PMIC
To: "Lee Jones" <lee@kernel.org>
From: "Karel Balej" <balejk@matfyz.cz>
References: <20240331105608.7338-2-balejk@matfyz.cz>
 <20240331105608.7338-4-balejk@matfyz.cz>
 <20240411113726.GH1980182@google.com>
In-Reply-To: <20240411113726.GH1980182@google.com>

Lee Jones, 2024-04-11T12:37:26+01:00:
[...]
> > diff --git a/drivers/mfd/88pm886.c b/drivers/mfd/88pm886.c
> > new file mode 100644
> > index 000000000000..e06d418a5da9
> > --- /dev/null
> > +++ b/drivers/mfd/88pm886.c
> > @@ -0,0 +1,157 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +#include <linux/i2c.h>
> > +#include <linux/mfd/core.h>
> > +#include <linux/module.h>
> > +#include <linux/notifier.h>
> > +#include <linux/of.h>
> > +#include <linux/reboot.h>
> > +#include <linux/regmap.h>
> > +
> > +#include <linux/mfd/88pm886.h>
> > +
> > +#define PM886_REG_INT_STATUS1			0x05
> > +
> > +#define PM886_REG_INT_ENA_1			0x0a
> > +#define PM886_INT_ENA1_ONKEY			BIT(0)
> > +
> > +#define PM886_IRQ_ONKEY				0
> > +
> > +#define PM886_REGMAP_CONF_MAX_REG		0xef
>
> Why have you split the defines up between here and the header?

I tried to keep defines tied to the code which uses them and only put
defines needed in multiple places in the header. With the exception of
closely related things, such as register bits which I am keeping
together with the respective register definitions for clarity. Does that
not make sense?

> Please place them all in the header.

Would you then also have me move all the definitions from the regulators
driver there?

[...]

> > +	err =3D devm_mfd_add_devices(dev, 0, pm886_devs, ARRAY_SIZE(pm886_dev=
s),
>
> Why 0?

PLATFORM_DEVID_AUTO then? Or will PLATFORM_DEVID_NONE suffice since the
cells all have different names now (it would probably cause problems
though if the driver was used multiple times for some reason, wouldn't
it?)?

Thank you,
K. B.

