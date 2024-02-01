Return-Path: <linux-kernel+bounces-47665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B878450EC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 997041F26526
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D377D41D;
	Thu,  1 Feb 2024 05:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="csrgW1yR"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2884878B7D;
	Thu,  1 Feb 2024 05:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706766427; cv=none; b=fDu65c8kR+GqeA8FS8RPUsqvAuJI5pPuW8j0asRpACTXmjDEs2HtR1Z5pm82fForpEhZCLK1aw3/s0Mh32DUMT2cLxSA4mip7qbwrWMMvAxG10UyPY8RJkpTs9I34cOtb8gC/SwwdjyE3H16TGUUSQTjZptpJs1yLcknrZdwME0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706766427; c=relaxed/simple;
	bh=9YqF9j5eXI5m6rmyqlPkPEUF6K4pUnYhH1ZqLxBaF7o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SIIy4rYKw/52FK1lic0UGcObXUx8vsL50HcB6bOaH/O2jQVkspuHIBYZiZw7t+ItoT35PApbdPe05VgJyCtjd8uzDt88HplXUvs6Csd7eWzIXC2hzZ5UHkX4WUlP2G1TtnbvhEP71A20VI41zNA8Xa/EAy9poJtntNThbQqZxVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=csrgW1yR; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp14-2-76-194.adl-apt-pir-bras31.tpg.internode.on.net [14.2.76.194])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 5AD962017A;
	Thu,  1 Feb 2024 13:47:03 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1706766424;
	bh=9YqF9j5eXI5m6rmyqlPkPEUF6K4pUnYhH1ZqLxBaF7o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=csrgW1yRPwbVDkKYJ7CMeWN+mWAlUmM356hIDTCiFgUDp4/HQ9r+vT6eIscwZhYNC
	 EKXplHCg+ehFXNcjmNR4gtCem+OTOeybhmJgt0pGj3YZkV3WVMoKs8qB8V4uc88wa1
	 +et5YT+jlVwNqPufhum88ESnb0gEFaR8gaDwelOrKzn1Ul11wuQqBWa89yYmNA08W/
	 VV4w1JqBc3pzqc30almb5pN1Kti9hZtDaUlBePL8jnklbXjZ8//EaGBZBCyDhz1XDk
	 s7WBVYwmwNanBmQCrrDjiswgfbrJjgU7RZEr3se4DEsCRczSHvV9MtbSzTAdm0X5+s
	 1c3VLYo7nxKPQ==
Message-ID: <85fd9e31695c343121d5f6ad2cbebe7d8d8490b2.camel@codeconstruct.com.au>
Subject: Re: [PATCH v5 15/21] ARM: dts: aspeed: yosemite4: Remove idle state
 setting for yosemite4 NIC connection
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Joel Stanley <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Thu, 01 Feb 2024 16:17:02 +1030
In-Reply-To: <20240131084134.328307-16-Delphine_CC_Chiu@wiwynn.com>
References: <20240131084134.328307-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240131084134.328307-16-Delphine_CC_Chiu@wiwynn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-31 at 16:41 +0800, Delphine CC Chiu wrote:
> Remove idle state setting for yosemite4 NIC connection

But why? Is this fixing a bug? What is the motivation?

Andrew

