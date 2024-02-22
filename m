Return-Path: <linux-kernel+bounces-75969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E4D85F152
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF19B2835E4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8F817583;
	Thu, 22 Feb 2024 06:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FT6BOzjV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C8A1642B;
	Thu, 22 Feb 2024 06:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708582399; cv=none; b=u5RRDIPkDynqRUweNhvKe+kWX/sLka3auMVUfjH9geLnMH6dFfxjYMX+tNktkgpYOCVrAzXcNQQU5H1P2zC2Bxv89/aGVJdT7XJgrqE5c8djIcHU40ggrY9f3JY1hKQhy3t1I9mtW89snfn811+qLH85cCb2FdiT4OK7Dhzd0VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708582399; c=relaxed/simple;
	bh=3D4XNY0tn/7mR/t/EaEf8fOLVmE3aQudhqYfRJU1Owo=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=qg4s373NUwOTU+txpEzIMj8pOvcxdxhx0zNhyJuyHpMBcqZVVJpK5YsJtGu+IsCJHz4PqZ2VvdDs5vfvsk0MPby2mQDSQZbEjtFl9d+L5wa5ZAQTprDMhnY9vYBOSgjuJnTmzawLF+N4bNhdzH8K01mJb8RHVNP+JKX4Bv6t71k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FT6BOzjV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF10AC433F1;
	Thu, 22 Feb 2024 06:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708582399;
	bh=3D4XNY0tn/7mR/t/EaEf8fOLVmE3aQudhqYfRJU1Owo=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=FT6BOzjVT1npJU5bqbEqb7SqzVKvjL+ie624eEmdFee24K044Q/LjKUUc4RP7rlSh
	 XA6/hzTf9hr4SoQd3/P+3Xzv/JXHxsOeEN2IDvmDJbkWAFRP0UKQvLpbkm8L1HWobB
	 CmY2b0R0SZFrVdM1IVXGOfjplsr19WhfjOE2ps0DS5K9MubONpH75dJtmiuomp8jgI
	 qx0Nmqu+xMdE5qQvURT4Xj2LDnnJAbNtlP9+QMa3mPExYM2BLy+Drnm77F2Ar5lpn7
	 qhzACUoauSj0xooP34OQeiRQcYTArHsufCCVbLp+YzLnV40SyS1J1GwEEF4GwkX/Az
	 pIOUY63uGNKPA==
Message-ID: <654a33c729af90d8d5bd70d320fa6f6f.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240221-mbly-clk-v7-2-31d4ce3630c3@bootlin.com>
References: <20240221-mbly-clk-v7-0-31d4ce3630c3@bootlin.com> <20240221-mbly-clk-v7-2-31d4ce3630c3@bootlin.com>
Subject: Re: [PATCH v7 02/14] clk: fixed-factor: add fwname-based constructor functions
From: Stephen Boyd <sboyd@kernel.org>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, linux-mips@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>, linux-gpio@vger.kernel.org, =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>
To: Conor Dooley <conor+dt@kernel.org>, Gregory CLEMENT <gregory.clement@bootlin.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Philipp Zabel <p.zabel@pengutronix.de>, =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, Rob Herring <robh+dt@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>
Date: Wed, 21 Feb 2024 22:13:16 -0800
User-Agent: alot/0.10

Quoting Th=C3=A9o Lebrun (2024-02-21 10:22:10)
> Add four functions to register clk_hw based on the fw_name field in
> clk_parent_data, ie the value in the DT property `clock-names`.
>=20
> There are variants for devm or not and passing an accuracy or not
> passing one:
>=20
>  - clk_hw_register_fixed_factor_fwname
>  - clk_hw_register_fixed_factor_with_accuracy_fwname
>  - devm_clk_hw_register_fixed_factor_fwname
>  - devm_clk_hw_register_fixed_factor_with_accuracy_fwname
>=20
> The `struct clk_parent_data` init is extracted from
> __clk_hw_register_fixed_factor to each calling function. It is required
> to allow each function to pass whatever field they want, not only index.
>=20
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> ---

Applied to clk-next

Hopefully these are all going to be used.

