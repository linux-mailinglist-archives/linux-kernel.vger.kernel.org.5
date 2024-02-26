Return-Path: <linux-kernel+bounces-82403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6218683BD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7526A1F240A3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A69133299;
	Mon, 26 Feb 2024 22:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="XBlCq1DE"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864461DDD7;
	Mon, 26 Feb 2024 22:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708986544; cv=none; b=p9ch4sGGd+sAvr6pLoEFt3NpH+ISy4HS4jr0MLw9LuO9aLkDzFVvWbRfCvdD4aArMewjPv2qAcm4ftaQ2917cDPv1cuYFFGxLvq9B+h1VvC+3fLsb+FhAQ0SWCxHKLwM0PxtFsjqsqMzMO5rwhWUTIUC5OSt1WgoO7PidrpeMUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708986544; c=relaxed/simple;
	bh=huo/vjj5S//g2ksHGxO/GrVhnULxzjju8V8Mw6hlVFM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M7lIePbhV6safjR+9kudOJV7Yj4GiDU+PqBdzZC/P791aZHfG4W2O0TD1XOuVAIp0LxGqfjf89yHuw78gFvST1dBSDX55DTrkzMVpDiU7R23ueE6uAQ7dFFw3V157GLQRyjbTD3u4PyAvBwW6YJ5Ixx1BgMOlPPP1lDoK+fBlHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=XBlCq1DE; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp118-210-168-240.adl-adc-lon-bras34.tpg.internode.on.net [118.210.168.240])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 0645720127;
	Tue, 27 Feb 2024 06:28:56 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1708986539;
	bh=8eEw/FtaaqWX/jVY5OVj7vtAlz28XQ3GCy3aQ75fMEc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XBlCq1DEyt1YVQIrQWcOGMdZNCgE4w/xv4+a5wqpEiRCjnKTnasyBg//tPzMkesFu
	 OILCdfmqH9X1RCfZ1SN9zNaCARMT/sB3IO58WyUKoHmLfCMl8QIYtp2qt2lSootyW+
	 /hdBMOBZ0cgiOyl978UBaqVV13gT+mca0bkKhBxd15+1dDcpYg/VrDLVfHyHJhWUQc
	 pD5t+Brn1TewzecmHZFl2kpVnBbPY6JpFOEHBsfmuLUmWMXeFTPTfabdwQC32xk6u8
	 cx8gWGIJzWGwVASAbrtEuoS0pTDUiRSDwU+Ef/49Ky/RQCAl2BtuVug+WjKFYkBsdd
	 Ka47d+jW2KUgA==
Message-ID: <afee602b57f95a2d3162a601832d3a087ea5f0d6.camel@codeconstruct.com.au>
Subject: Re: [PATCH] ARM: dts: aspeed: ahe50dc: Update lm25066 regulator name
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Zev Weiss <zev@bewilderbeest.net>
Cc: Guenter Roeck <linux@roeck-us.net>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, linux-kernel@vger.kernel.org, Joel
 Stanley <joel@jms.id.au>, Rob Herring <robh+dt@kernel.org>,
 devicetree@vger.kernel.org,  linux-arm-kernel@lists.infradead.org, Conor
 Dooley <conor+dt@kernel.org>,  linux-aspeed@lists.ozlabs.org
Date: Tue, 27 Feb 2024 08:58:52 +1030
In-Reply-To: <170896502304.859066.13236138723073669130.robh@kernel.org>
References: <20240226091754.16027-2-zev@bewilderbeest.net>
	 <170896502304.859066.13236138723073669130.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-02-26 at 10:54 -0600, Rob Herring wrote:
> On Mon, 26 Feb 2024 01:17:53 -0800, Zev Weiss wrote:
> > A recent change to the lm25066 driver changed the name of its
> > regulator from vout0 to vout; device-tree users of lm25066's regulator
> > functionality (of which ahe50dc is the only one) thus require a
> > corresponding update.
> >=20
> > Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> > Cc: Conor Dooley <conor+dt@kernel.org>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  arch/arm/boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dts | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
>=20
>=20
> My bot found new DT warnings on the .dts files added or changed in this
> series.
>=20

For what it's worth I've put together a set of patches that resolve
almost all the warnings in the Aspeed DTSIs. My current approach is to
progressively send them out - I'm starting slow so where possible I can
avoid making the same mistake multiple times.

Andrew

