Return-Path: <linux-kernel+bounces-127906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F141895299
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF9A1B2654D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205A67FBC3;
	Tue,  2 Apr 2024 12:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="kKT+zZZF"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D92757FB;
	Tue,  2 Apr 2024 12:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712059785; cv=none; b=pH1fpBrQkh/56Giqiq//B1brugB/jol6JYtK6fHCKDOFiiage7C5ZXrUtDujTFGEEctLanMhDZpiVeRSid3h0SQ1BGAZ5L5izJEQvF0Y20mAFT1Ik1upnRpnJ6DTL8NoOvrnP1DVssncmnXgDKD50zZbqnz91UVfLA6AevL/uBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712059785; c=relaxed/simple;
	bh=YwIUUX0x/WQwrkVO7VhtyyQYHpaR1vN10gFVa337qkM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KSpBXNFVMJllD1v87EIuOFzr5Kr20NBLShERIOeOhZSnLHeSjZTaxLwcqY6IS1G74TsgjAJHRDSXnuTttYkkg/m09q3rJY6/ODZgdSZQ1PmKe/A4CRCF+gtgEpdbgsWJ2d59tYfn0ywOHliA9PzWHNi/gsq96n0iJaoD50j2d+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=kKT+zZZF; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp118-210-182-70.adl-adc-lon-bras34.tpg.internode.on.net [118.210.182.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 5ED4C200E0;
	Tue,  2 Apr 2024 20:09:40 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1712059781;
	bh=emjzUDDqOpO14ZhysyWQJh3ovWJjdiQOg95LkukSphw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kKT+zZZFOaNhupP6tEx0DyFImtF+6Wo0ztnhUlc5gxPF4+Pfk/3j0oCL/A10KJUPK
	 RV+VoLqisLrabWfWiYigDtSLNIkECYXhHgcsvJvlfhIBEo7EgWC0Bg/eZXwIVck4Ai
	 bgLdLs0Ip2od48f6AtTZM/k8u0HBqv6kbdVm4z1ufRukbJfIhnRJlNiakJOORYsso7
	 9DAS1bv8lNQOezoNo5BtqnX3T9fdt90SXU75gYayzkH/IzPmysCTmc7lTODLwfwNCH
	 M0dCwPoJm1MkLDKbYFxoQuqq7KYqvfXGVYsNStcrzFU1Hz2Twn3HfF5EXeOpO5Aqrv
	 lJZf7Wvm6yrjw==
Message-ID: <ab76b0549172cf3e33d6242fa9ea3e6a87b4a58e.camel@codeconstruct.com.au>
Subject: Re: [PATCH v6 3/4] dt-bindings: watchdog: aspeed-wdt: Add aspeed,scu
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Peter Yin <peteryin.openbmc@gmail.com>
Cc: patrick@stwcx.xyz, Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter
 Roeck <linux@roeck-us.net>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
 Joel Stanley <joel@jms.id.au>, linux-watchdog@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Tue, 02 Apr 2024 22:39:32 +1030
In-Reply-To: <20240401135637.GA342928-robh@kernel.org>
References: <20240328022231.3649741-1-peteryin.openbmc@gmail.com>
	 <20240328022231.3649741-4-peteryin.openbmc@gmail.com>
	 <20240401135637.GA342928-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-04-01 at 08:56 -0500, Rob Herring wrote:
> On Thu, Mar 28, 2024 at 10:22:30AM +0800, Peter Yin wrote:
> > To use the SCU register to obtain reset flags for supporting
> > bootstatus.
> >=20
> > Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt =
b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> > index 3208adb3e52e..80a1f58b5a2e 100644
> > --- a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> > +++ b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> > @@ -8,6 +8,8 @@ Required properties:
> > =20
> >   - reg: physical base address of the controller and length of memory m=
apped
> >     region
> > + - aspeed,scu: a reference to the System Control Unit node of the Aspe=
ed
> > +   SOC.
>=20
> You cannot add new required properties as that is an ABI break.
>=20
> If there's only 1 SCU instance, you can just fetch its node by=20
> compatible with no DT change.
>=20
> What's the plan for converting this binding to schema? This is the 2nd=
=20
> new property in 6 months.

I had a patch converting it in a local branch which I've now sent:

https://lore.kernel.org/all/20240402120118.282035-1-andrew@codeconstruct.co=
m.au/

Perhaps we can pull it into this series?

Andrew

