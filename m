Return-Path: <linux-kernel+bounces-139550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CCF8A0447
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60833B21166
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4F03FB94;
	Wed, 10 Apr 2024 23:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="eNNBNOCV"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B75622085;
	Wed, 10 Apr 2024 23:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712793376; cv=none; b=O2yNfftSwKwtf9HRAcbrKSFAY4d1tTd+G/9uHtmViotp8lr/jsAqKbL/jF0yG5yPgxYo2K7xudA2DnpWnNpi7ddF3+zrXtdkrnr5nOYNd2Rijtp9NJBPZuUGAF+D8hPbi4CAKhmXSMfkbzCj09yna0+l9vQpuoOT82n9GFb6Wts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712793376; c=relaxed/simple;
	bh=YdxX0RS+h6nnSZiOcpAQraGy37X8lj1yr1mlmdxdFNo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jMiSuVwvlbxfyk2/GFjXm+6mCUl2kM6riDD7Jegje6ZHsmpQnqmW/iX4GbcyHSeGYdMeyF3GS2l7uXGl8Ne0yE1+0//znH8xB5SvKVCXh4bZI8cDYFmYjW4AiAY0RA5ocn5O7xwZLkFnwIO36Vc/yg4kul3jOg287fsaAclJCIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=eNNBNOCV; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp118-210-182-70.adl-adc-lon-bras34.tpg.internode.on.net [118.210.182.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id A6E062013B;
	Thu, 11 Apr 2024 07:56:00 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1712793365;
	bh=YdxX0RS+h6nnSZiOcpAQraGy37X8lj1yr1mlmdxdFNo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eNNBNOCVIBdeD6MA602CoeG+fv9TZcwoHIND3RU9f2n7kGCuger+yYTZok3wq2C36
	 liHerJ2SOwUnHsI6TRvmCea/DyDOba2R/+WURTKua5t7Q0zg0FJ3iWaY4xkJAVHnRg
	 /QTFDkuarqYPx3oSFOV5HGr4ITEqSwxj+P5mh5YaFZsjNrlVvuIVUAYSRlA0H8r0Cs
	 zCNMclRDoOd1PCOA3eqbLvX17FoqRPc2S73GGtB6nLuyQ9zSWiVHv32Xk70EujLQJI
	 409aUYNElt5WrWmrT1UwNrKA3vJYnYMGeDHhgfHeFGlx5jA2FdO48pSxfcL30OA/3s
	 DSmyNjBO/vJBQ==
Message-ID: <6de98551118955bf68f4835b888730222a9ae015.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 1/4] dt-bindings: rtc: convert trivial devices into
 dtschema
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Vladimir
 Zapolskiy <vz@mleia.com>, Joel Stanley <joel@jms.id.au>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 11 Apr 2024 09:25:54 +0930
In-Reply-To: <20240410-rtc_dtschema-v2-1-d32a11ab0745@gmail.com>
References: <20240410-rtc_dtschema-v2-0-d32a11ab0745@gmail.com>
	 <20240410-rtc_dtschema-v2-1-d32a11ab0745@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-04-10 at 17:55 +0200, Javier Carrasco wrote:
> These RTCs meet the requirements for a direct conversion into
> trivial-rtc:
>=20
> - orion-rtc
> - google,goldfish-rtc
> - maxim,ds1742
> - rtc-aspped

Nit: s/aspped/aspeed/, but otherwise it still looks fine for the Aspeed
bits and you can keep my R-b tag.

Andrew

