Return-Path: <linux-kernel+bounces-84985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE2286AE90
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A116C1C24946
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79E473507;
	Wed, 28 Feb 2024 11:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HwbBgPwl"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227BF73509;
	Wed, 28 Feb 2024 11:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709121503; cv=none; b=RbJMHh+bE2n6P5Aa/vv60IuOWgeVuLTFuDfSXY0AnHLiWYLjovAT4IGRnTENN4/d8QJKENDyH3ICK1775elOn0/PBoGJHyU0dDkoYdX/u7RbwXd8QaMR3/XCjZ4HlQDhofl1bKYx5j86lMR2OdeXduMoIuJpjM6nqjhXyYrwr/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709121503; c=relaxed/simple;
	bh=bmJVxea+oEzT3EtoYlqAmW+AUuUsUmFi5hATLsmQHjI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=XYOYiuj/jMVfKu/7ZjL1gJPHjb5A0cXDMgAYdBXHXk1ewGcso6iCMvBI/5rxpM5nbIx3l37MLCA3GrkxxyuiAQQ7jQZR8Cf/Dx8xMOr0RHH/XJV5i85JWxImyeSmQeVKLLZMumllijgsMIZ+YXn6gYNX5ZfftZiIS0bdGQtmnCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HwbBgPwl; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay1-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::221])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 255A0C3B08;
	Wed, 28 Feb 2024 11:44:19 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1A1BC240010;
	Wed, 28 Feb 2024 11:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709120650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bmJVxea+oEzT3EtoYlqAmW+AUuUsUmFi5hATLsmQHjI=;
	b=HwbBgPwlUGwdkKqhxPs0I6nUKj3VWccKez2XcK0QCJRc1E5t+YCDn6NmazS+VoH+UYgi81
	7OWOMPQ6f+vavnK5g2BIgbR/LB0rBSZcyik1mHXAvwWnxAPJtEAKl45Ic74VkP8JHM8bD+
	J/Qa20DdB8EK6mbrj+f6aFPqevmHv3KZHgiGoOYPyHBoyogseRFUwazKRn9nvoq87yfVWr
	u1fo5QuK+MOiX3zstLjuf5jzJnHQgJLhwrXmpb74ingV3ccMfqVHASR/J8SyS8IzxKDd1Q
	HYiOqUCybVVa8cFJHv7NDK4j87ys693VUgMOwKel7/h25ksp9Tnkabl2a8LlBA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Feb 2024 12:44:09 +0100
Message-Id: <CZGOPF51JA1R.2YN65K6WUH9N4@bootlin.com>
Cc: "Paul Burton" <paulburton@kernel.org>, <linux-mips@vger.kernel.org>,
 "Jiaxun Yang" <jiaxun.yang@flygoat.com>, "Rob Herring"
 <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>, "Alexandre Belloni"
 <alexandre.belloni@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
To: "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v8 00/14] Add support for the Mobileye EyeQ5 SoC
X-Mailer: aerc 0.15.2
References: <20240216174227.409400-1-gregory.clement@bootlin.com>
 <ZdSst3fM3EOQGH03@alpha.franken.de>
In-Reply-To: <ZdSst3fM3EOQGH03@alpha.franken.de>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello Thomas,

On Tue Feb 20, 2024 at 2:44 PM CET, Thomas Bogendoerfer wrote:
> On Fri, Feb 16, 2024 at 06:42:09PM +0100, Gregory CLEMENT wrote:
> > Hello,
> >=20
> > The EyeQ5 SoC from Mobileye is based on the MIPS I6500 architecture
> > and features multiple controllers such as the classic UART, I2C, SPI,
> > as well as CAN-FD, PCIe, Octal/Quad SPI Flash interface, Gigabit
> > Ethernet, MIPI CSI-2, and eMMC 5.1. It also includes a Hardware
> > Security Module, Functional Safety Hardware, and MJPEG encoder.

[...]

> series applied to mips-next.
>
> I've fixed generic|ingenic|realtek builds by adding select MACH_GENERIC_C=
ORE
> in arch/mips/Kconfig.

Would it be possible to provide an immutable branch containing the two
series? I've got quite a few series that depend on them as they target
EyeQ5 devicetrees and defconfig.

It's been a request from Bartosz for the GPIO series, see [0].

Series are:
 - Jiaxun's "Unify register numbering macros for uasm" [1];
 - Gr=C3=A9gory's "Add support for the Mobileye EyeQ5 SoC".

Have a nice day,

[0]: https://lore.kernel.org/lkml/CAMRc=3DMfLXCDXBiKKuEPZRjNoNiFN+gvhu+GjZk=
Z1SQuF1s4=3DUQ@mail.gmail.com/
[1]: https://lore.kernel.org/linux-mips/20240209-regname-v1-0-2125efa016ef@=
flygoat.com/
[2]: https://lore.kernel.org/lkml/20240216174227.409400-1-gregory.clement@b=
ootlin.com/

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


