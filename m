Return-Path: <linux-kernel+bounces-141841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D96A58A2424
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16A521C21726
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B3414006;
	Fri, 12 Apr 2024 03:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZ0kQvhQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00378179A7;
	Fri, 12 Apr 2024 03:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712890987; cv=none; b=cyIF1lSz4Rn5GBH/4UOyPKDhydL2ElxPO7BvcYZ06koyFEC402u6Oe4Lint2SWBDMoqxpupH864O4O5WMxac3AE/KNRvRR2FiPeVIrpA5JIUIWqxY99RbQdtt7O+abnFjmGAvgpLHQm0Gpr6cC1bgOth8McxgrXP5CKamLkdl6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712890987; c=relaxed/simple;
	bh=dL2vbLyBJ7fQbcvTp51l49lPhbA/iYRHmD1oK3utQ8k=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=u8hIKgYwyDo2T3woANU7EVebc1zkzF/23Bbo3kHqYiGQAL5uHfKg1mWbfz3XcJqXkKm+2dJnyBZEb2g6rVkx4g7hUY+vo+27HG8xCohbrBTaJC1n+HqJcruwePOiDtW+9QdSwmzrlvAR3OSsaigdc9Y21sazz2h7tzxNf7Zn2xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZ0kQvhQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54EEBC072AA;
	Fri, 12 Apr 2024 03:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712890986;
	bh=dL2vbLyBJ7fQbcvTp51l49lPhbA/iYRHmD1oK3utQ8k=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=IZ0kQvhQHE45vOxLKM9Qe1+1O2wckWfB7W2uk/KDf6B5evQgBBrQ8/wuutr3pm1fz
	 vwRDvGXSB6wAft8hI8c6K1mXqHQetBXyzoMIvw3a4XbBu058/dyBWmBkkjKWHvibds
	 zLm7dMYveplj67gHHolFcxTvypWINm3M+BkFDicpGyrgA7bUX8qQM2BCmFynycup1f
	 mGYgDjn+90vaqrH3ERNDyyfn8VPGn6e6y7wSaqS+R7A6Dn15x98lIVedR6fA/fPQ+B
	 x+AfxlLKrlvcan27uEYLW8Fyr6cUwB9SnI1GghSJZpS1V7kFscOaMRCqpASD/0K5nH
	 to2ESXtN/8AAQ==
Message-ID: <15b31289dfafa2516e524aadcb02a6af.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <SEZPR06MB69596A0104AA2385391049EA96052@SEZPR06MB6959.apcprd06.prod.outlook.com>
References: <20240225-pll-v1-0-fad6511479c6@outlook.com> <20240225-pll-v1-1-fad6511479c6@outlook.com> <d8dc639c2c6d188d2ce3728573d9a53d.sboyd@kernel.org> <SEZPR06MB6959E563B692827A3E5152DD96052@SEZPR06MB6959.apcprd06.prod.outlook.com> <fa5fe57faeda3323174e4caddc1ac2a6.sboyd@kernel.org> <SEZPR06MB69596A0104AA2385391049EA96052@SEZPR06MB6959.apcprd06.prod.outlook.com>
Subject: Re: [PATCH RFC 1/2] clk: hisilicon: rename hi3519 PLL registration function
From: Stephen Boyd <sboyd@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, Igor Opaniuk <igor.opaniuk@foundries.io>, Jorge Ramirez-Ortiz Gmail <jorge.ramirez.ortiz@gmail.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Yang Xiwen <forbidden405@outlook.com>, Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Thu, 11 Apr 2024 20:03:04 -0700
User-Agent: alot/0.10

Quoting Yang Xiwen (2024-04-11 03:31:58)
> On 4/11/2024 3:53 PM, Stephen Boyd wrote:
> > Quoting Yang Xiwen (2024-04-11 00:44:33)
> >> On 4/11/2024 2:52 PM, Stephen Boyd wrote:
> >>> Quoting Yang Xiwen via B4 Relay (2024-02-24 08:56:09)
> >>>> diff --git a/drivers/clk/hisilicon/clk-hi3559a.c b/drivers/clk/hisil=
icon/clk-hi3559a.c
> >>>> index ff4ca0edce06..77fa4203a428 100644
> >>>> --- a/drivers/clk/hisilicon/clk-hi3559a.c
> >>>> +++ b/drivers/clk/hisilicon/clk-hi3559a.c
> >>>> @@ -452,7 +452,7 @@ static const struct clk_ops hisi_clk_pll_ops =3D=
 {
> >>>>           .recalc_rate =3D clk_pll_recalc_rate,
> >>>>    };
> >>>>   =20
> >>>> -static void hisi_clk_register_pll(struct hi3559av100_pll_clock *clk=
s,
> >>>> +static void _hisi_clk_register_pll(struct hi3559av100_pll_clock *cl=
ks,
> >>> Prefix it with hi3559a then to be SoC specific please. But this is al=
so
> >>> static so I'm not sure why this patch is needed at all.
> >>
> >> it includes the header that marks this function non-static. Also the
> >> prototype is incompatible.
> > What is 'it'?
>=20
>=20
> The line 18 `#include "clk.h"`, and please see patch 2.
>=20
>=20
> Patch 2 added 2 functions to "clk.h", one of them reused the=20
> `hisi_clk_register_pll` name with a different prototype.
>=20
>=20
> >
> >   $ git grep hisi_clk_register_pll
> >   drivers/clk/hisilicon/clk-hi3559a.c:static void hisi_clk_register_pll=
(struct hi3559av100_pll_clock *clks,
> >   drivers/clk/hisilicon/clk-hi3559a.c:    hisi_clk_register_pll(hi3559a=
v100_pll_clks,
>=20
>=20
> a snippet copied from patch 2:
>=20
>=20
> +int hisi_clk_register_pll(struct device *dev, const struct hisi_pll_cloc=
k *clks,
> +                         int nums, struct hisi_clock_data *data);
>=20
>=20

Ok, got it. Prefix the existing hisi_clk_register_pll() as
hi3559a_clk_register_pll().

