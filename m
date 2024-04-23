Return-Path: <linux-kernel+bounces-154356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 047F38ADB2E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31B661C20EFF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A51E574;
	Tue, 23 Apr 2024 00:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTll7Hu7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78AB184;
	Tue, 23 Apr 2024 00:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713832720; cv=none; b=j4b8hipABbIK61kxk9DuthcyujGIdGAb5Zj7Mgjhyo7eMFsgeJD6CEMtnTUHKnVonA58+2U7kHwL8vQD9zR8BQFJcx398/xov/gfvE8JiNzVQwIX172YkwdbNT+6OpCptkzD0l6ix04O4PTYlan4I4BBXI0rStn/6+Z+Eitkyls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713832720; c=relaxed/simple;
	bh=Mu7unsryILuvM3Nf4rtyuH+NnGl/Ag6KmANbCK5/2A4=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=NimtZvSp4BY0FkYUHFLmKYB0TNNz3VTqyhyXUOy9rbNA13fHQpWy+m4LxeHEYpw6mVu4knaeUqrr/nl9RSQhE2I6mf4YXMC8y1fY26hgucNcXqURRzR8X/G8yklnBohLR9xA+ceq91BMDqxIjwimIvD3RWbiFJl8vbLHTuD3bEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTll7Hu7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26AC3C113CC;
	Tue, 23 Apr 2024 00:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713832720;
	bh=Mu7unsryILuvM3Nf4rtyuH+NnGl/Ag6KmANbCK5/2A4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=JTll7Hu7wF1BKHSgU8lKwIEL8hfr25t3ek+6NP5oW5+ShsrBaqQxD7sfBZFQdPk+x
	 L+2+LOIS3x3RAUoeIcsVM5+JZmlF5DkB8ezeM2plNruKpD3fqnng/RomOYEvnH7LBD
	 0KmaMANR6rnRRIaD0S1XEYQOMGImnsWtw2hvxUa2ZiDcFdS2a7/IE3RN8rURKVcUpq
	 OwSlcgK+tPnnj/3PiZH1FpL8GZy4kiZKEdT+KXRh1QeTkyzpfb0+oS7TKyGBHX6Eri
	 PQY26zMwJRRA9RUcx12XelpDstx/304B41rFNc1pBSigH/+mYctSdN1ASRmUw8oMYk
	 yfacwyHNuCAQQ==
Message-ID: <2473d3ddeea21640b20735d660e48f98.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <eb221864-0044-4ea5-bbee-7545d10cb130@skole.hr>
References: <20240402-pxa1908-lkml-v9-0-25a003e83c6f@skole.hr> <de4c56a8-488d-4cdb-9d6c-e9d6e63b22b9@skole.hr> <58b23157c088cb4774d579cc8700de85.sboyd@kernel.org> <3287993.aeNJFYEL58@radijator> <d7ff7dd609cd1b9a50e5ffa882d05b90.sboyd@kernel.org> <eb221864-0044-4ea5-bbee-7545d10cb130@skole.hr>
Subject: Re: [PATCH v9 5/9] clk: mmp: Add Marvell PXA1908 clock driver
From: Stephen Boyd <sboyd@kernel.org>
Cc: phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, Karel Balej <balejk@matfyz.cz>, David Wronek <david@mainlining.org>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To: Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley <conor+dt@kernel.org>, Duje =?utf-8?q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, Guilherme G. Piccoli <gpiccoli@igalia.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Kees Cook <keescook@chromium.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Lubomir Rintel <lkundrak@v3.sk>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>, Tony Lindgren <tony@atomide.com>, Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Date: Mon, 22 Apr 2024 17:38:38 -0700
User-Agent: alot/0.10

Quoting Duje Mihanovi=C4=87 (2024-04-20 06:32:56)
> On 4/20/24 00:24, Stephen Boyd wrote:
> > Quoting Duje Mihanovi=C4=87 (2024-04-19 07:31:14)
> >> On Friday, April 12, 2024 4:57:09=E2=80=AFAM GMT+2 Stephen Boyd wrote:
> >>> Quoting Duje Mihanovi=C4=87 (2024-04-11 03:15:34)
> >>>
> >>>> On 4/11/2024 10:00 AM, Stephen Boyd wrote:
> >>>>> Is there a reason this file can't be a platform driver?
> >>>>
> >>>> Not that I know of, I did it like this only because the other in-tree
> >>>> MMP clk drivers do so. I guess the initialization should look like a=
ny
> >>>> of the qcom GCC drivers then?
> >>>
> >>> Yes.
> >>
> >> With the entire clock driver code in one file this is quite messy as I=
 also
> >> needed to add module_init and module_exit functions to (un)register ea=
ch
> >> platform driver, presumably because the module_platform_driver macro d=
oesn't
> >> work with multiple platform drivers in one module. If I split up the d=
river
> >> code for each clock controller block into its own file (such as clk-of-
> >> pxa1908-apbc.c) as I believe is the best option, should the commits be=
 split
> >> up accordingly as well?
> >=20
> > Sure. Why is 'of' in the name? Maybe that is unnecessary?
>=20
> That seems to be a historical leftover from when Marvell was just adding =

> DT support to the ARM32 MMP SoCs which Rob followed along with in the=20
> PXA1928 clk driver and so have I. Should I drop it then as Marvell has=20
> in the PXA1908 vendor kernel?
>=20

Sounds good to me.

