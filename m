Return-Path: <linux-kernel+bounces-132252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF47689920E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 01:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 912F7B22750
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEBA13C3EF;
	Thu,  4 Apr 2024 23:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Q9fzQBfV"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE5F70CC2;
	Thu,  4 Apr 2024 23:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712272931; cv=none; b=qhl4YMpzAjcH/Ik1b7nh6mOyrwNBrcGf2E5gvWQm5O2X59tdoOixL+rVtHxIIoWvGYERIABHG+QTcfHjK1DZjYXsfqmtrz304M60do3rJ8R0IrabKtntg4ZPu4ydg+ztnEuEtah63Vsgr054Y1MVqs/hXzI9KTTzKNpfO7VxkfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712272931; c=relaxed/simple;
	bh=ey4GqAHux/uUwj8BtmXxU8XUTPio3nZ5PlidLIzywYg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DkXp1dl/6Yq2hDRorJoH/h0+uUD+mte9KwG3YP7MQ6Bz5iS8031bu7lvM7BAF6iKLUf5z5JxPMCDLtQeO9qnnRs3beGe+SaArjLeDDMxlhrWt6oqKBw9F+l/Fc68A5eGbXrGB5e9LjIJOkT0R4Fh9gEz47TFWAq20iDqYrG8sjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Q9fzQBfV; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp118-210-182-70.adl-adc-lon-bras34.tpg.internode.on.net [118.210.182.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 17A952009F;
	Fri,  5 Apr 2024 07:22:03 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1712272926;
	bh=DeXkWmpOi6oUYa3S4c0rBgKp2W+RLiC/o+BtoZVa4y0=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=Q9fzQBfV+G1TSrVUb3PfB6R/0M7livAjsMyuXMMDxwzmzFUV70CAnhtF/QjKDfVTR
	 7OxiMJbtBUeUSRelXxt/hJY8qQHz1UBq2hm2nv1qe11cbfNYlRqiToGkBvXpX1j0Bo
	 JBgxIKoqYMkyWVNfHRPoG7DSth+2TYkdmISGREiWsC07KpLPAkFV0EqL/nPZgCXISX
	 lBEv3OoPYQAPNwnQQMi3cYQL7iucQm2uz8byiGrKlPiyn7lDpWW247halIBInp0lR2
	 cxzheewfll+rzFBi2ekKZPkqScxPtzNUstslOOfrObc/lquKY68lBSDZMv1LJAA/NV
	 zNt3hz5K9a41Q==
Message-ID: <65060691d4649c4a8da46e5ba762a3c905ade690.camel@codeconstruct.com.au>
Subject: Re: [PATCH 1/4] ARM: dts: aspeed: greatlakes: correct Mellanox
 multi-host property
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
 Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org
Date: Fri, 05 Apr 2024 09:51:59 +1030
In-Reply-To: <c3902c6e-c38e-4604-b79e-2b5406274d8f@linaro.org>
References: <20231209104412.12916-1-krzysztof.kozlowski@linaro.org>
	 <171213860535.16780.4635499105199545058.b4-ty@linaro.org>
	 <8610e0a8aa5c2916fa04292a10e8a843862ff0ee.camel@codeconstruct.com.au>
	 <c3902c6e-c38e-4604-b79e-2b5406274d8f@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-04-04 at 08:13 +0200, Krzysztof Kozlowski wrote:
> On 04/04/2024 03:41, Andrew Jeffery wrote:
> > On Wed, 2024-04-03 at 12:04 +0200, Krzysztof Kozlowski wrote:
> > > On Sat, 09 Dec 2023 11:44:09 +0100, Krzysztof Kozlowski wrote:
> > > > "mlx,multi-host" is using incorrect vendor prefix and is not docume=
nted.
> > > >=20
> > > >=20
> > >=20
> > > These wait for ~4 months and they were not picked up. Let me know if =
anyone
> > > else wants to take these.
> > >=20
> > > Applied, thanks!
> > >=20
> > > [1/4] ARM: dts: aspeed: greatlakes: correct Mellanox multi-host prope=
rty
> > >       https://git.kernel.org/krzk/linux-dt/c/7da85354c4fa35b862294dbb=
b450baeb405b5a92
> > > [2/4] ARM: dts: aspeed: minerva-cmc: correct Mellanox multi-host prop=
erty
> > >       https://git.kernel.org/krzk/linux-dt/c/e515719c17beb9625a90039f=
6c45fa36d58bdda2
> > > [3/4] ARM: dts: aspeed: yosemite4: correct Mellanox multi-host proper=
ty
> > >       https://git.kernel.org/krzk/linux-dt/c/af3deaf9bcb4571feb89a405=
0c7ad75de9aa8e1e
> > > [4/4] ARM: dts: aspeed: yosemitev2: correct Mellanox multi-host prope=
rty
> > >       https://git.kernel.org/krzk/linux-dt/c/cac1c1dda6130771e06ace03=
0b1b0ed62096a912
> > >=20
> > > Best regards,
> >=20
> > Ah, my apologies. Joel's on leave and I'm accumulating patches in a
> > tree for him in the mean time. I've had some things going on
> > professionally (changed jobs) and personally, and these fell into a bit
> > of a hole.
> >=20
> > I'm okay for these patches to be integrated through your tree, given
> > you've already applied them. Feel free to add acks if your branch
> > allows:
> >=20
> > Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> >=20
> > I'm working to stay on top of things a bit more now than I have in the
> > recent past, so hopefully I won't miss patches again in the future.
>=20
> Stephen reported conflict, although trivial, but maybe better if you
> take them?
>=20

Yeah, happy to.

> I can rebase and resend.

Thanks.

Andrew

