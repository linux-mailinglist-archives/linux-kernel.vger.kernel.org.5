Return-Path: <linux-kernel+bounces-141334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DF18A1CCB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C891C1C23AE1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE1D1BAA8F;
	Thu, 11 Apr 2024 16:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rn0ESlg4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFF243ADA;
	Thu, 11 Apr 2024 16:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712853557; cv=none; b=RImuLkac/YCLXivnif8Ng+yO3HgKinxRNiplY9ON4IUVXqPfkzr2LzlwsqiJBiN+LlD1pbeBDOVuhNkRvTQDtmp3fwhgrzbGrVqReprvERWIjR8howD/aPTb50/yLLcDYPFGLKZCpFMHj9swEvpdAMvjVKeu+d1Ms/qysdpWAEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712853557; c=relaxed/simple;
	bh=KA0gmwx5RKIsM+SMGYg8VxRvhIzvngglfYJ4j6bCzqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSV/lMdgt325tSH8x0W5DukmEMcO1LENLQeV0iGl57EK2xpHy678lkbVe2pmSXSzB/Di0kZVRKCTuF5FD2Uwcw0Gkr3F3pegd5KOrSJTOCDfs52BoHSy4BuI4Ec3KA4Kiq2Ap2Ne0dazSSNYIG4ig2QOdIzogGNyDOQC7RD0XKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rn0ESlg4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A48EC072AA;
	Thu, 11 Apr 2024 16:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712853557;
	bh=KA0gmwx5RKIsM+SMGYg8VxRvhIzvngglfYJ4j6bCzqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rn0ESlg4jtpBagbAkT5po/N7qvhzWQy6/9Sx7TaKfeWCIsILTCVpTiBNXjaZwIQBG
	 dyjURdnyg0YlITzPxqnTPvyR0/mVD34GWYx4jFShg7xGGgWqNtbUu1HvVp2/pHmHSd
	 Ru+piYEQ1rOrjDwuFrfO6kOW31UPGdCScil/+mNQDF3MvZyN4zgGI0oX8VDb3hW7ut
	 ZMmND06bgNpHIdPEh0aEzN6sh9nTCKBtTEmZdvOc8rXqjKzK3+0ekK7nVjFQl2fWjY
	 /AXmrcieLHDYX7M+JUFH9RyUIRk+6cUUpGXvqIcoekPvjG2XR0ESXlmmLrh/OBwN39
	 k1OcPMGHmRnpA==
Date: Thu, 11 Apr 2024 17:39:11 +0100
From: Lee Jones <lee@kernel.org>
To: Karel Balej <balejk@matfyz.cz>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH 2/5] mfd: add driver for Marvell 88PM886 PMIC
Message-ID: <20240411163911.GJ2399047@google.com>
References: <20240331105608.7338-2-balejk@matfyz.cz>
 <20240331105608.7338-4-balejk@matfyz.cz>
 <20240411113726.GH1980182@google.com>
 <D0HE07BHD1T8.HQLIBUHTRVGT@matfyz.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D0HE07BHD1T8.HQLIBUHTRVGT@matfyz.cz>

On Thu, 11 Apr 2024, Karel Balej wrote:

> Lee Jones, 2024-04-11T12:37:26+01:00:
> [...]
> > > diff --git a/drivers/mfd/88pm886.c b/drivers/mfd/88pm886.c
> > > new file mode 100644
> > > index 000000000000..e06d418a5da9
> > > --- /dev/null
> > > +++ b/drivers/mfd/88pm886.c
> > > @@ -0,0 +1,157 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +#include <linux/i2c.h>
> > > +#include <linux/mfd/core.h>
> > > +#include <linux/module.h>
> > > +#include <linux/notifier.h>
> > > +#include <linux/of.h>
> > > +#include <linux/reboot.h>
> > > +#include <linux/regmap.h>
> > > +
> > > +#include <linux/mfd/88pm886.h>
> > > +
> > > +#define PM886_REG_INT_STATUS1			0x05
> > > +
> > > +#define PM886_REG_INT_ENA_1			0x0a
> > > +#define PM886_INT_ENA1_ONKEY			BIT(0)
> > > +
> > > +#define PM886_IRQ_ONKEY				0
> > > +
> > > +#define PM886_REGMAP_CONF_MAX_REG		0xef
> >
> > Why have you split the defines up between here and the header?
> 
> I tried to keep defines tied to the code which uses them and only put
> defines needed in multiple places in the header. With the exception of
> closely related things, such as register bits which I am keeping
> together with the respective register definitions for clarity. Does that
> not make sense?

It makes sense and it's a nice thought, but I think it's nicer to keep
them all together, rather than have to worry about which ones are and
which ones are not used here or there.  Also, there will be holes in the
definitions, etc.

> > Please place them all in the header.
> 
> Would you then also have me move all the definitions from the regulators
> driver there?

I think it would be nice to have them all nice and contiguous.

So, yes.

> [...]
> 
> > > +	err = devm_mfd_add_devices(dev, 0, pm886_devs, ARRAY_SIZE(pm886_devs),
> >
> > Why 0?
> 
> PLATFORM_DEVID_AUTO then? Or will PLATFORM_DEVID_NONE suffice since the
> cells all have different names now (it would probably cause problems
> though if the driver was used multiple times for some reason, wouldn't
> it?)?

You tell me.  Please try and understand the code you author. :)

-- 
Lee Jones [李琼斯]

