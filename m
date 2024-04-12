Return-Path: <linux-kernel+bounces-141829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0CA8A2403
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16172283A31
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC10212E6A;
	Fri, 12 Apr 2024 02:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBXPtoxV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB12A2581;
	Fri, 12 Apr 2024 02:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712890632; cv=none; b=mm5QEvdAxlJq2Gq/vHSSYFsCaAlDdvlWoZoVUt316rVgEwQ1IIZvjfUUfwExHLvaD/nlbSFg5pGWNWaNg7Y2IOTrzeh3i3JNT/Mkc6KRqGL82IFTeaERRh+ay+AxMJjvzsMoXaGfV7SR7WZHtXt9mg9KqmEhnmrTfNv2TeZJn4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712890632; c=relaxed/simple;
	bh=p+4XkXpOxunuKnnWO83NDMUzum9+mHSSGqv0fFD9r7s=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=L6JyFkn2NKnr/r1c1ydjG3XVmK4h0FWLV1miMn/3gXcXuBF0R2N3+scHv2ObOAu+HOlYug/HOV9iOrPvEiX4+RGMnjWrVD5F1Atnd3O+qPj2Y0JDmjt9Em8EqImeVTB7MlCutjNGDtT/WHEwETI6SCXibHkeAoj9kLQXp+xNGgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBXPtoxV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD58C072AA;
	Fri, 12 Apr 2024 02:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712890631;
	bh=p+4XkXpOxunuKnnWO83NDMUzum9+mHSSGqv0fFD9r7s=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=QBXPtoxV+vVyS1Qy7tf9k5jCPndXuhDBFvVab65uRIOAwl3+UUsVjhrMNQUyMB0U9
	 XWrzecCBpSJSY9I7tZfg98E82DlruZ0nEfe9Ebj6o4hw7cfP8Pe9Q+pT9QLqmUv2MF
	 Ua41VD2K+WiMR8pTxP61JOap3vM/LcNhERXRRRY+DpxhhBBzpTP9Aeobv0aIDhzjkt
	 LXu0X0iGFgWDydnmQJB9nuxUQoIkHlJp/C8J7tRJjPzd2atq3+WOyGRtIVQ9deYEYD
	 OKm6mRknWQLxRiZIP/r2Xv7wFQJOp3b+7oypEKXtTwIzx+piu5r8KAcEpn9MWFdc+x
	 TQEXkVRPsIM2A==
Message-ID: <58b23157c088cb4774d579cc8700de85.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <de4c56a8-488d-4cdb-9d6c-e9d6e63b22b9@skole.hr>
References: <20240402-pxa1908-lkml-v9-0-25a003e83c6f@skole.hr> <20240402-pxa1908-lkml-v9-5-25a003e83c6f@skole.hr> <3838e4684f98e1ce3818bfb6983844bc.sboyd@kernel.org> <de4c56a8-488d-4cdb-9d6c-e9d6e63b22b9@skole.hr>
Subject: Re: [PATCH v9 5/9] clk: mmp: Add Marvell PXA1908 clock driver
From: Stephen Boyd <sboyd@kernel.org>
Cc: phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, Karel Balej <balejk@matfyz.cz>, David Wronek <david@mainlining.org>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To: Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley <conor+dt@kernel.org>, Duje =?utf-8?q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, Guilherme G. Piccoli <gpiccoli@igalia.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Kees Cook <keescook@chromium.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Lubomir Rintel <lkundrak@v3.sk>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>, Tony Lindgren <tony@atomide.com>, Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Date: Thu, 11 Apr 2024 19:57:09 -0700
User-Agent: alot/0.10

Quoting Duje Mihanovi=C4=87 (2024-04-11 03:15:34)
> On 4/11/2024 10:00 AM, Stephen Boyd wrote:
> >=20
> > Is there a reason this file can't be a platform driver?
>=20
> Not that I know of, I did it like this only because the other in-tree=20
> MMP clk drivers do so. I guess the initialization should look like any=20
> of the qcom GCC drivers then?

Yes.

>=20
> While at it, do you think the other MMP clk drivers could use a conversio=
n?
>=20

Sure, go for it. I'm a little wary if the conversion cannot be tested
though. It doesn't hurt that other drivers haven't been converted.

