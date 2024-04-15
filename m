Return-Path: <linux-kernel+bounces-144452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DF68A4695
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 03:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6C5628318C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 01:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF61379E3;
	Mon, 15 Apr 2024 01:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="lDgqEDHA"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28869BE58;
	Mon, 15 Apr 2024 01:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713144846; cv=none; b=an02j9S5pZyr3OkhFyrarjKWQtSQ5jWxuai2/Pp9CGH4HocXPOug/M3E6j67bFtpEVehz2PDECPi4b4+NJ6tJF+jiIq0Zha/00Ze2ziRnUaLdNeA0XYnd9skJaMfG61kHraUNusJCOs7QDUyuA7N4bTms4oFoQ14cTJl46QJHuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713144846; c=relaxed/simple;
	bh=WGAdQkTH9rCbCFpFlh1ykbW/XFvwiK0fk8p7CK6ZRBM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JiYziWzUUKy5SFVdP3YtiKr+CG/hAOIdbxszXa5HKRJGwiVw8wBHPB+5GmemvCMUAEL2nNK1+/BZSmi/qPQU+y7/JeNRPKDbMuhrkNUzreG5OmV3Pw3KJC+Ym+e189m1lWVf7wAvTvc+t80hN3C3KNpKC2wzNW8P7IqrUupn3aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=lDgqEDHA; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp14-2-127-66.adl-apt-pir-bras32.tpg.internode.on.net [14.2.127.66])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 7F48F20178;
	Mon, 15 Apr 2024 09:33:59 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1713144841;
	bh=WGAdQkTH9rCbCFpFlh1ykbW/XFvwiK0fk8p7CK6ZRBM=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=lDgqEDHAg1RXJVPjPJsL1Nipc2p5NibKJpJLBhuB7aGfoxPFDDAk3AwqR0iaipjik
	 JjJEenbSECxVoK7JgRvf7DXiZDpPc/0RsEYJLaX2gLgHiAJs1aQGyCSSve+3sRW3Ab
	 gaLxVLXU/DDPM1gUVnkg7W7CzeXWY60W3c6vCSMDRm7iCumOJigi9dED7PqDyX1JQC
	 cZo+bPjKv5/Ge5tTW2foG7LmNMJ69Y/09FkhTAZfFmKwi2AkX1gOCTM02GKhu+cn5/
	 wB8KySadAPnP2UoWH1PUI599p3/gKg/5d3cnzTo33CzTUnceGXhtmC0DXKtSbxHhIN
	 ZO5z+wylMZ3UQ==
Message-ID: <7af48dcfba938ea45a78e8a23088a09a8eeeabdd.camel@codeconstruct.com.au>
Subject: Re: [PATCH] ARM: dts: aspeed: Remove Facebook Cloudripper dts
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: rentao.bupt@gmail.com, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 devicetree@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org,  linux-kernel@vger.kernel.org,
 taoren@meta.com
Date: Mon, 15 Apr 2024 11:03:58 +0930
In-Reply-To: <20240411045622.7915-1-rentao.bupt@gmail.com>
References: <20240411045622.7915-1-rentao.bupt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-04-10 at 21:56 -0700, rentao.bupt@gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
>=20
> Remove Facebook Cloudripper dts because the switch platform is not
> actively maintained (all the units are deprecated).
>=20
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>

I've applied this to my tree to be picked up by Joel.

Andrew

PS: Sorry if you already have mail saying as much, I ran into issues
with our mail server late last week.

