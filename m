Return-Path: <linux-kernel+bounces-110269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF28885C58
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 424131F24499
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6116D86279;
	Thu, 21 Mar 2024 15:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qBzuVRhQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82072A947;
	Thu, 21 Mar 2024 15:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711035737; cv=none; b=tnfCkS4DpfFbgEjCmwtr1IoU8rEIcjuIrnEbwZ/PugxwvbH8bQ5SOd9anqE9zBw1uh3lSyb3qBstzPKnwp6nUaEMiKIszbQSxe/4TRWHSq9x9PJaQJGHqjm4sJoCJutxpOx+WArgXWKDol5BOCZudkAdIpFZZb+E5bpnaCHNDbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711035737; c=relaxed/simple;
	bh=8wU+PN5cU0I4EEhB8JOIgJoIJA40lFgTVOanV0oEnWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMyoDxn9VRJDwu+h3TyoJnBfRRyQQS2y0Yb6OcskNYKdSavX6pWHFzx7cj22iue2DhVC9m+Ql6MinweP6NtSc5bMA3H+d0d6pqUxQ785DBpHItioZXUwbTApJ1h2G34mqZskg/GwYHDzSBskz3CgmWnP7e8Buqv6z3iBQD+19t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qBzuVRhQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC35C433F1;
	Thu, 21 Mar 2024 15:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711035737;
	bh=8wU+PN5cU0I4EEhB8JOIgJoIJA40lFgTVOanV0oEnWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qBzuVRhQdTtsKEthMcxXaa+/N5b8Tyu59i7h39aFD4yYJUXRn7HIMGMKK/kK+pkWH
	 vCBXYR9ouME4f1lXv9PWkqbVOCCX8gJeYX6SKeNgfrORtjKPQX8QrpIwTQ0FRpbUy4
	 eKEc385FPBkVg2gv9dK/G7v0OKxtXWdF5OEOERyY+mzu3uFkKfW5/U5vEZAa/4CDqY
	 Cdu5N1oL/wF8q3GULbCiDOqS4VVtiQBiwbJmR+fIygTZ26kfa2gO7KocjWdQvjRohO
	 9nU8gJtEV6+E5HAyHxBLKLT04MTcgUf/NpP5mW/3nIv8yQC/HgmdmyUENApL8MK8T8
	 wsIz+fBHCLn+Q==
Date: Thu, 21 Mar 2024 15:42:11 +0000
From: Lee Jones <lee@kernel.org>
To: Karel Balej <karelb@gimli.ms.mff.cuni.cz>
Cc: Karel Balej <balejk@matfyz.cz>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [RFC PATCH v4 2/5] mfd: add driver for Marvell 88PM886 PMIC
Message-ID: <20240321154211.GA13211@google.com>
References: <20240311160110.32185-1-karelb@gimli.ms.mff.cuni.cz>
 <20240311160110.32185-3-karelb@gimli.ms.mff.cuni.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240311160110.32185-3-karelb@gimli.ms.mff.cuni.cz>

On Mon, 11 Mar 2024, Karel Balej wrote:

> From: Karel Balej <balejk@matfyz.cz>
> 
> Marvell 88PM886 is a PMIC which provides various functions such as
> onkey, battery, charger and regulators. It is found for instance in the
> samsung,coreprimevelte smartphone with which this was tested. Implement
> basic support to allow for the use of regulators and onkey.
> 
> Signed-off-by: Karel Balej <balejk@matfyz.cz>
> ---
> 
> Notes:
>     RFC v4:
>     - Use MFD_CELL_* macros.
>     - Address Lee's feedback:
>       - Do not define regmap_config.val_bits and .reg_bits.
>       - Drop everything regulator related except mfd_cell (regmap
>         initialization, IDs enum etc.). Drop pm886_initialize_subregmaps.
>       - Do not store regmap pointers as an array as there is now only one
>         regmap. Also drop the corresponding enum.
>       - Move regmap_config to the header as it is needed in the regulators
>         driver.
>       - pm886_chip.whoami -> chip_id
>       - Reword chip ID mismatch error message and print the ID as
>         hexadecimal.
>       - Fix includes in include/linux/88pm886.h.
>       - Drop the pm886_irq_number enum and define the (for the moment) only
>         IRQ explicitly.
>     - Have only one MFD cell for all regulators as they are now registered
>       all at once in the regulators driver.
>     - Reword commit message.
>     - Make device table static and remove comma after the sentinel to signal
>       that nothing should come after it.
>     RFC v3:
>     - Drop onkey cell .of_compatible.
>     - Rename LDO page offset and regmap to REGULATORS.
>     RFC v2:
>     - Remove some abstraction.
>     - Sort includes alphabetically and add linux/of.h.
>     - Depend on OF, remove of_match_ptr and add MODULE_DEVICE_TABLE.
>     - Use more temporaries and break long lines.
>     - Do not initialize ret in probe.
>     - Use the wakeup-source DT property.
>     - Rename ret to err.
>     - Address Lee's comments:
>       - Drop patched in presets for base regmap and related defines.
>       - Use full sentences in comments.
>       - Remove IRQ comment.
>       - Define regmap_config member values.
>       - Rename data to sys_off_data.
>       - Add _PMIC suffix to Kconfig.
>       - Use dev_err_probe.
>       - Do not store irq_data.
>       - s/WHOAMI/CHIP_ID
>       - Drop LINUX part of include guard name.
>       - Merge in the regulator series modifications in order to have more
>         devices and modify the commit message accordingly. Changes with
>         respect to the original regulator series patches:
>         - ret -> err
>         - Add temporary for dev in pm88x_initialize_subregmaps.
>         - Drop of_compatible for the regulators.
>         - Do not duplicate LDO regmap for bucks.
>     - Rewrite commit message.
> 
>  drivers/mfd/88pm886.c       | 149 ++++++++++++++++++++++++++++++++++++
>  drivers/mfd/Kconfig         |  12 +++
>  drivers/mfd/Makefile        |   1 +
>  include/linux/mfd/88pm886.h |  38 +++++++++
>  4 files changed, 200 insertions(+)
>  create mode 100644 drivers/mfd/88pm886.c
>  create mode 100644 include/linux/mfd/88pm886.h

Looks mostly okay.

> diff --git a/include/linux/mfd/88pm886.h b/include/linux/mfd/88pm886.h
> new file mode 100644
> index 000000000000..a5e6524bb19d
> --- /dev/null
> +++ b/include/linux/mfd/88pm886.h
> @@ -0,0 +1,38 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef __MFD_88PM886_H
> +#define __MFD_88PM886_H
> +
> +#include <linux/i2c.h>
> +#include <linux/regmap.h>
> +
> +#define PM886_A1_CHIP_ID		0xa1
> +
> +#define PM886_REGMAP_CONF_MAX_REG	0xfe
> +
> +#define PM886_REG_ID			0x00
> +
> +#define PM886_REG_STATUS1		0x01
> +#define PM886_ONKEY_STS1		BIT(0)
> +
> +#define PM886_REG_MISC_CONFIG1		0x14
> +#define PM886_SW_PDOWN			BIT(5)
> +
> +#define PM886_REG_MISC_CONFIG2		0x15
> +#define PM886_INT_INV			BIT(0)
> +#define PM886_INT_CLEAR			BIT(1)
> +#define PM886_INT_RC			0x00
> +#define PM886_INT_WC			BIT(1)
> +#define PM886_INT_MASK_MODE		BIT(2)
> +
> +struct pm886_chip {
> +	struct i2c_client *client;
> +	unsigned int chip_id;
> +	struct regmap *regmap;
> +};
> +
> +static const struct regmap_config pm886_i2c_regmap = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = PM886_REGMAP_CONF_MAX_REG,
> +};

Why is this in here?

> +#endif /* __MFD_88PM886_H */

What would you like me to do with this RFC patch?

-- 
Lee Jones [李琼斯]

