Return-Path: <linux-kernel+bounces-165848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D31D78B925D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 01:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74D0A1F2146B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 23:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539CC16C6B9;
	Wed,  1 May 2024 23:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvS+vGrR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900AA16C6A4;
	Wed,  1 May 2024 23:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714605976; cv=none; b=k9zAJ8iGFjnChCBhOFCdnJMFfFWg0xTwJ7jdP5F0pv1Q7ujGcUX5cZbPUqUnVlSrURzVbt0/eR9CNrQ14tzzNyoPW/5LOAJOfBzVkuH9OI6rUON2HL6bIdiwJkdslsEKPV1zP9y68wBJ3BgZyhw6GcHKYkGRgXgkOWKYuhkS8q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714605976; c=relaxed/simple;
	bh=wHBTAMKIcvRLwkC8AoFZJyXUiPOkQ5EwhQFLUq2hD7U=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=U0BbBOILEp1vv8Lsx4Fw4rHO78v7v4waTsDgcGBh/ddIC7S319o/L3CSgzk1UGMUiJ6TuihT0TfKQ7j3klGHiAhQxh5EN6A6LLbfF+ZhTFO1syCVRGoWUMEHP0vWIzLce9n7fOavex6tMU/zn/4nz3trtDiH7olfUgT98Sloo8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvS+vGrR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD41C072AA;
	Wed,  1 May 2024 23:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714605976;
	bh=wHBTAMKIcvRLwkC8AoFZJyXUiPOkQ5EwhQFLUq2hD7U=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=YvS+vGrRQQ5MFS7uuvjRk413GdyPc4CrxN/UjqvtEftCzRL272O+XbR1KnFGOF2tS
	 o5VlQ2rUJRpD2xSFGkwQ+9G1LW0qBOSLI2VmALGqAARjoU4lRZruYU4Qtmok4iWWU8
	 T69i5THHhZ6rvB1hXuuKH6eDWZzOUJMLYFkf5pEIMGChOIdz2mUbrRab8EpTn/qu1Y
	 +x8H0rpzY7YsbZW8JeuofflDIsLoWjfmHidorRtxq7z5ZY87+V/fTrW0YA2c9LZ+fY
	 dTpmSvgWkdpUrEqd1mr5y42x7knLd9sRhVI6xMEL3sH4OHFZJuY4a6wgs5TYqO6MJm
	 SdvPER2T5vVTQ==
Message-ID: <b58509db1147e9290e1a006a03e5fec1.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240501144445.892045-1-abel.vesa@linaro.org>
References: <20240501144445.892045-1-abel.vesa@linaro.org>
Subject: Re: [GIT PULL] clk: imx: Updates for v6.10
From: Stephen Boyd <sboyd@kernel.org>
Cc: imx@lists.linux.dev, NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Abel Vesa <abel.vesa@linaro.org>, Mike Turquette <mturquette@baylibre.com>
Date: Wed, 01 May 2024 16:26:13 -0700
User-Agent: alot/0.10

Quoting Abel Vesa (2024-05-01 07:44:45)
> The following changes since commit 4cece764965020c22cff7665b18a0120063590=
95:
>=20
>   Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git/ tags/=
clk-imx-6.10
>=20
> for you to fetch changes up to f5072cffb35c122ec85d91ef327fa8814f04297b:
>=20
>   clk: imx: imx8mp: Convert to platform remove callback returning void (2=
024-05-01 14:40:49 +0300)
>=20
> ----------------------------------------------------------------

Thanks. Pulled into clk-next

