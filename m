Return-Path: <linux-kernel+bounces-37365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7611C83AED6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E4282866AF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB1C7F7C2;
	Wed, 24 Jan 2024 16:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oewtlB0j"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDEB7E783;
	Wed, 24 Jan 2024 16:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115376; cv=none; b=RyVXUlaedqSlqg/YJK5RfJwmlaq/an4MeiF6uXxv7gcF5xSXpisxn7qAQs4srQkqHw/IW33IVXO0Wy4HAIwDCMXR7G65GssH677LUOEoQn64ROiDTwBcNNwZVyHj84lnj23tq1yDp5EbB8OEcq2rEuvuWmEnqaHxKOxirMA51dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115376; c=relaxed/simple;
	bh=zojqvcFyH7e0pEAxvrCo+kQYydC3cgGEhKL7MMYmQMk=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=s5zsFIunVb2n1wgRR7O+pXbqR3eAjH/WOPJMB6WJcndNsYlqVWjF0nLJ+Q8S7sq2cxyXCiPfF2TFeqljKBirOeImsX5Z6jnsjQI10c9OKn+miaBHjUpeCOK5eLdz/A1rADtt6lSoNcT6dli3OiLmu4Z8sCDQhSIUkVz9ruZoJWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oewtlB0j; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 71604C0007;
	Wed, 24 Jan 2024 16:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706115371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QGhpZ0/KGVAf350a9l1/TZxjJU4Ix7cVLvMDV1t/OjU=;
	b=oewtlB0jQO7QQQ3Ym/hyu3j6Codja3nqtgafBOK8nAw3AN3APrSQ4nriB5ugoc2onuul3L
	xiOyrEPoy8WzWMYAOf15AoIGxIukZvVSsrWYgJgJAdm39BnOtc/50O0Oj558oXdzzhe3yt
	3hJkVkDVtrFxTYfJI9IVhU8DltPUGAv/m1E1fQ2hTqYVgEVQcFwT5xVfsB/QGLQpxV6SRE
	7HisNSpHq1xbCY74gVOrhwQKSsafqi1YcSXTc0NdD8+7COMiEJSvtvwHfh8/iwfCb2O+5G
	YGilBmqVssS1fg/PPla0lqCqVtq8gO4VJhH17ivY45/DNodtBxtRaKjCvVax0w==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Jan 2024 17:56:10 +0100
Message-Id: <CYN3F8VEU3MU.17HS71MGWI3TG@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v3 12/17] MIPS: mobileye: eyeq5: remove reg-io-width
 property from OLB syscon
Cc: "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>,
 <linux-mips@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>, <linux-gpio@vger.kernel.org>
To: "Sergei Shtylyov" <sergei.shtylyov@gmail.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, "Michael Turquette"
 <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>, "Rob Herring"
 <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>, "Linus Walleij"
 <linus.walleij@linaro.org>, =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?=
 <rafal@milecki.pl>, "Philipp Zabel" <p.zabel@pengutronix.de>
X-Mailer: aerc 0.15.2
References: <20240123-mbly-clk-v3-0-392b010b8281@bootlin.com>
 <20240123-mbly-clk-v3-12-392b010b8281@bootlin.com>
 <30ab446a-c00d-12d6-0f54-4bcf7c42a6fe@gmail.com>
In-Reply-To: <30ab446a-c00d-12d6-0f54-4bcf7c42a6fe@gmail.com>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Wed Jan 24, 2024 at 9:33 AM CET, Sergei Shtylyov wrote:
> On 1/23/24 9:46 PM, Th=C3=A9o Lebrun wrote:
>
> > Remove the `reg-io-width` property from the olb@e00000 syscon. The
>
>    The diff says it's system-controller@e00000 now... :-)

Oops, nice catch!

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

