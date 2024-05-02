Return-Path: <linux-kernel+bounces-165895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 030DA8B9311
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 03:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EE8E1F223AF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 01:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1731E12E40;
	Thu,  2 May 2024 01:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="jRQ9UR1Z"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F093C12E6D;
	Thu,  2 May 2024 01:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714612588; cv=none; b=gQlUXLrAIofff6eKzTbVLKQijmDS+8uNxveQvueHejj5cFxmRLRMOIUlM8SKfTDTukf442/5uY7QhA3x7gumg0q6n5YrF3Qeq9/brSgRFaBGy96KhbrxQTJ+XbBoX8pfduj5rab/Nm+cyi7Oed2d+TYKVqcM+h86OjFY5G4wSEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714612588; c=relaxed/simple;
	bh=I1H2b5dmLu+h090Wf3JV8wPJG4mgtbGH1NdOaoBnM7U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mly47vhfEiPoBH3RYY2j5FZ/XZuflwx/Eq9E7rtpJEfUJdZ75GCdGBNkatarrJGOK07HjgoF5zVeeBjx+Pr65N467tIfca+Rv33G4rHrNih3l/zP0KieTwxPKbt8rzFYy/ZWKtjU+d1KS+7mfO5way4VLzF+tHL1B6SB0OR0wgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=jRQ9UR1Z; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.148.88] (unknown [120.20.105.107])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id AF26D20009;
	Thu,  2 May 2024 09:16:23 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1714612584;
	bh=I1H2b5dmLu+h090Wf3JV8wPJG4mgtbGH1NdOaoBnM7U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jRQ9UR1ZZ2FVs0XozVicmEwg1CRNhSKmKccCABEs31nGicFn/2prKvEeQ2rbh+rWa
	 WAaWf/S4eh7Lp/yTx0jVmqReJh/6AlvwZAFcK/6YQ0uAo/NfkeUqNEAxQQ76DSIHdS
	 HUzavRDOacprdfMmSg0DbVM7TTH/3qWIL2E69NZwhYRo6bexYncEA03PzojNt2gCaQ
	 kchPJIOrTNKRxid89ZHpzHIVThucjhfR7q/y5kkaxLOja2otHPXBjoFCoevzrcNSUF
	 9rf2y4Dkp1mgEwkaDZp44VxNdZrn+ev3hdWMwvdOt8ytjK/6LOLPUhbUJV1FlTMzS4
	 aHu5HfKEy+b4A==
Message-ID: <73284390fda1971eb6727102eba75324a1886a2a.camel@codeconstruct.com.au>
Subject: Re: [PATCH] dt-bindings: mfd: aspeed: Drop 'oneOf' for pinctrl node
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
 Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,  linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Thu, 02 May 2024 10:46:23 +0930
In-Reply-To: <CAL_JsqJmciSKp4H2KXcqv78Vga5gDi0JU_PY4Dth7LJrq6swMA@mail.gmail.com>
References: <20240430172520.535179-1-robh@kernel.org>
	 <4f3ce3439e3d996471085e906902e508528308d3.camel@codeconstruct.com.au>
	 <CAL_JsqJmciSKp4H2KXcqv78Vga5gDi0JU_PY4Dth7LJrq6swMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-05-01 at 07:39 -0500, Rob Herring wrote:
> On Tue, Apr 30, 2024 at 7:40=E2=80=AFPM Andrew Jeffery
> <andrew@codeconstruct.com.au> wrote:
> >=20
> > On Tue, 2024-04-30 at 12:25 -0500, Rob Herring (Arm) wrote:
> > > The use of 'oneOf' to include 1 of 3 possible child node schemas resu=
lts
> > > in error messages containing the actual error message(s) for the corr=
ect
> > > SoC buried in the tons of error messages from the 2 schemas that don'=
t
> > > apply. It also causes the pinctrl schema to be applied twice as it wi=
ll
> > > be applied when the compatible matches.
> > >=20
> > > All that's really needed in the parent schema is to ensure one of the
> > > possible compatible strings is present in the pinctrl node so that it=
s
> > > schema will be applied separately.
> >=20
> > Thanks, I think it improves the readability of intent in the binding as
> > well.
> >=20
> > To understand the impact better I grabbed the patch and diffed the
> > output of `make CHECK_DTBS=3Dy aspeed/aspeed-ast2600-evb.dtb` before an=
d
> > after applying it, but there was no significant difference in output.
> > Should that not demonstrate the errors being cleaned up? If not, what
> > should?
>=20
> Try it on one of the new boards posted in the last 1-2 days. It showed
> up on my testing dtbs_check on patches. I didn't send a report because
> there was so much noise in it.

I tried with aspeed/aspeed-bmc-ibm-blueridge.dtb and yeah, it does
clean up a lot of barf. Nice. Thanks.

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

[1]: https://lore.kernel.org/lkml/20240429210131.373487-14-eajames@linux.ib=
m.com/

