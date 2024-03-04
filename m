Return-Path: <linux-kernel+bounces-90017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8170A86F8EF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 04:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BE671C20917
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 03:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D464C64;
	Mon,  4 Mar 2024 03:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="MG91fMa5"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F196116;
	Mon,  4 Mar 2024 03:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709523430; cv=none; b=u20g09z0LWZPTmQXoJCYJuWKxHy2honITwckepX7KiP8FXCcgmlfx7tbPXI2Leyz3a9apDQe0Oe8rqcioETq5ETF2ykBOMQqjZcUINu+8g6q0M9cpfQH/TriHggkDslbP+LM4/7Yim3Atrp6DwGPmXSeIf2FXSJ7quP7QMeTfh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709523430; c=relaxed/simple;
	bh=Ub2TVSCczszte0SH6YnSG2kxRnFXdOaAJHV7P++nO/4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OULVivubscNWnJrJbFllXQ3+tfE/qs7dDqTzQ2FRaPdRwGDTsGzeXsBOZLt7+YdMfwa6cQ+ypqxBpfSetdoosFTJ9GkZrkEBPLRjF1UN29VGuWxMjkREPPjZcKxJU3wnjmYAENTb/xFjdnkNo2MzeV5UKPAttUSPGfn5TSOsVYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=MG91fMa5; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (unknown [118.211.81.9])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id D378C20135;
	Mon,  4 Mar 2024 11:36:56 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1709523420;
	bh=Ub2TVSCczszte0SH6YnSG2kxRnFXdOaAJHV7P++nO/4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MG91fMa5eFHS5RGG6Z+Mz9vdgov4oJt8iz+az5ejbgvd6W6Fvohwi6rTaxktmDOEp
	 0pZaqZTcq7QzyTtVEPYSl9ssScIrHNT9qeUanuLX7KQ+dVtDT03DnRHFpD+4oElSUs
	 EhTKK+XeZoh+/6WB6ClLDHBhODiJAuH/2nFzdQwsdKFqRepkg0BvazWm9PEyBpKoBi
	 6wSoiYK7g/iic3lBK+hpxLcrQzUWJVHKm0Ioqgk1oGs0gKWP1N17ptFkjXmAl6fWG9
	 BRgXrlBErNl0bXjpmE7oOSz6/Ezg2YytteBdGuxhc3hSgQTuU5sr8abaFkmYrRVq/F
	 gGwodKlOgpwmA==
Message-ID: <33f423783b71a4e4dd6e8c37a8909a69c25fb24c.camel@codeconstruct.com.au>
Subject: Re: [PATCH v6] dt-bindings: gpio: aspeed,ast2400-gpio: Convert to
 DT schema
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linus.walleij@linaro.org, krzysztof.kozlowski+dt@linaro.org,
 robh+dt@kernel.org,  conor+dt@kernel.org, joel@jms.id.au,
 linux-gpio@vger.kernel.org,  devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,  linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Mon, 04 Mar 2024 14:06:55 +1030
In-Reply-To: <CAMRc=Mfa1uUhkPNpLdcMsGC4=G+_MGzaxXRL7UVdfKJD_zF0+w@mail.gmail.com>
References: <20240228003043.1167394-1-andrew@codeconstruct.com.au>
	 <c2060450-4b76-4740-afe4-d14717245f01@linaro.org>
	 <16ddd99007176da3f84462de217cb76c8fa4e1bd.camel@codeconstruct.com.au>
	 <CAMRc=MeEyo7y-G1saydxtTRedNtHPaEeLANuzXt6KsiDU2jOWw@mail.gmail.com>
	 <e55aa1321ccac8e6391ab65a5a439b49d265bfce.camel@codeconstruct.com.au>
	 <CAMRc=Mfa1uUhkPNpLdcMsGC4=G+_MGzaxXRL7UVdfKJD_zF0+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-03-01 at 09:18 +0100, Bartosz Golaszewski wrote:
> On Fri, Mar 1, 2024 at 12:23=E2=80=AFAM Andrew Jeffery
> <andrew@codeconstruct.com.au> wrote:
> >=20
> > On Thu, 2024-02-29 at 09:52 +0100, Bartosz Golaszewski wrote:
> > > On Thu, Feb 29, 2024 at 4:21=E2=80=AFAM Andrew Jeffery
> > > <andrew@codeconstruct.com.au> wrote:
> > > >=20
> > > > On Wed, 2024-02-28 at 08:47 +0100, Krzysztof Kozlowski wrote:
> > > > >=20
> > > > > You still have way too many examples. One is enough, two is still=
 okay.
> > > > > We really do not want more of examples with minor differences.
> > > >=20
> > > > Noted, I'll keep them to a minimum in the future.
> > > >=20
> > >=20
> > > As in: I'll still send a v7? I can trim the examples when applying,
> > > just tell me which ones to drop.
> >=20
> > Ah, thanks. I wasn't planning to send a v7 given the R-b tag from
> > Krzysztof for v6. I intended for "in the future" to mean for patches
> > converting other bindings to DT schema. But if you're keen to trim some
> > examples out I'd drop the aspeed,ast2400-gpio and aspeed,ast2500-gpio
> > nodes, keeping just the aspeed,ast2600-gpio example.
> >=20
> > Andrew
>=20
> It's ok, I applied it as is.

Thanks!

Andrew

