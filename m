Return-Path: <linux-kernel+bounces-159404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 025F68B2E30
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 03:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F45D1C21A7C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 01:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD4CEDB;
	Fri, 26 Apr 2024 01:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Wv4FMbZ5"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362F1620;
	Fri, 26 Apr 2024 01:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714093231; cv=none; b=Txuv4Oq4ufcB5gME2qYXs/wf/2uPlORyp9uu7IOCmBBR9o2ITndp4kUx+/RrB549+TOAwC1GscoO+V3ftCOU/cNZRjLE/WNBxTWnlJ2H1kdCN7tC+dxunqFgOhG+/gAzWoXiYkmLn8bRx25V3mX8ks7S7J3/IP4pDRT0q/RkPPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714093231; c=relaxed/simple;
	bh=cRoZePRAKHr699wCxkb13i+8DqCx1aRTztutQ8i4STc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=je8T4RVVetMf5++0UpZYGayv9SLOc7eZon0AY/xKZhziey0lvuFGhujtAATjadky1+eKSwjKS+A5HniMtgYFrNICR/cDCJSXrTXiWGEFJCg56GZTkbOWXL2MeAubX4aj9RoxOsYqpBmdO9d3VBK+VSuoNKonXn0yYFfSxVt0Ysg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Wv4FMbZ5; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp14-2-127-66.adl-apt-pir-bras32.tpg.internode.on.net [14.2.127.66])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 9D43020075;
	Fri, 26 Apr 2024 09:00:27 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1714093228;
	bh=cRoZePRAKHr699wCxkb13i+8DqCx1aRTztutQ8i4STc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Wv4FMbZ5y7oQ4w6gmISe53fWyR1AsCJyruMAfpLhvWBUXmbDsZkiLCuZXtZkqah43
	 4m/VOIs5N+ndo+leLMuI2E+jxFFrcjIBo3Ma9GreaZjxRNXYhF8bkVp6qke8ACRPba
	 HYvFtAXK0p0ILN9G4H9S/sKnmL3efsQmeCikSZ6yQ2YUyK/iGGSUKhkwq7npA6FwOn
	 QQ5NaKf8Tbail11cegjWHNMnF3B99vBXwAsPtySAPldtmIZSE+PmKl4I31es/RzCv4
	 w1I1CSgS+MCVe26T879QIuUz7OIYAWaAE7y1HP29A/zLD7EpJNV6/hm/IEtq3rWdj9
	 D4P2fow17rQYg==
Message-ID: <eb02333de3bfcfef586f393141d5aaf039889e7f.camel@codeconstruct.com.au>
Subject: Re: [PATCH] ARM: dts: aspeed: Add vendor prefixes to lm25066 compat
 strings
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
 Joel Stanley <joel@jms.id.au>, Zev Weiss <zev@bewilderbeest.net>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Fri, 26 Apr 2024 10:30:27 +0930
In-Reply-To: <171394189432.44668.6061047707500811188.b4-ty@linaro.org>
References: <20240224103712.20864-2-zev@bewilderbeest.net>
	 <171394189432.44668.6061047707500811188.b4-ty@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-04-24 at 08:58 +0200, Krzysztof Kozlowski wrote:
> On Sat, 24 Feb 2024 02:37:07 -0800, Zev Weiss wrote:
> > Due to the way i2c driver matching works (falling back to the driver's
> > id_table if of_match_table fails) this didn't actually cause any
> > misbehavior, but let's add the vendor prefixes so things actually work
> > the way they were intended to.
> >=20
> >=20
>=20
> Two months passed, no replies from maintainers about picking it up. Dunno=
,
> looks abandoned, so let me grab this. If anyone else wants to pick it up,=
 let
> me know.

Sorry, another one that fell in the hole mentioned previously.

I'm okay with it going via your tree if there are no conflicts.

Andrew


