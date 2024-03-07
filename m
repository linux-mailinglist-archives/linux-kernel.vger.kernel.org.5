Return-Path: <linux-kernel+bounces-95115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E0A874951
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CD661F227B0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0228763415;
	Thu,  7 Mar 2024 08:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="blvw5orK"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6090C6313B;
	Thu,  7 Mar 2024 08:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709799325; cv=none; b=HGTLjHaqYrmAH9FECmSMnWHzrCtm+7QKVWaYITKbvZ0upTG6Ge77yOJthLjvzU4eYFHTJtvrB1kDfKJJl1c/oYheg657NX2hOEM5Uq65NQPNSbdZhh0nUbLjS5yP2NGa8hwh7YnmTtjg/nSDB6Bqvs/hukRcPmz2I9+SBvSg6dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709799325; c=relaxed/simple;
	bh=ZstXiN8BCb6FOQN96D81OboJCXKA33Stl82Xuecf8cg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=vFCeS7Z5L4cQ4E2+Nap7YXaxLSNTaJ8xiZlQdTLpYtxrjdduSv7fmeb5e2bSw0+EvDDRf9Ta4GhmM4Sjumw6Q19/HjPosZRLvc86MbegenSzmYgiPzfLQ8ZFH0kBKEHbbZ11Nzvx6m+e5FxQSq8WRNv70mOz3y1KDVyM/PT5/TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=blvw5orK; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 432FE240003;
	Thu,  7 Mar 2024 08:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709799320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=buhNLZyABPkypJJr6jjWYuCWSEEmx3G3WXbzfi/P7uA=;
	b=blvw5orKpmVdJ/dB539TbEIfgeahPbmYw365thGcbpUH75juP7CDVqDlaI73HRofGBHhjT
	rSUx+luK9x/JspZBrKcrQA17WCLNSz4AqQFFOhje2kCoIG1I/Rx1rhE0HEvXz1YROKA7R3
	bTHZpEQstUB92nTHj4zqd7vFh6Dsz6cSXtz2nAIPajHvOeX79alwbXDAoq3SccCYjjl3Vk
	b1NPOf8100775Jyc5YgySmD4sMdov+G0yHW3czaj/oKWL8PLvoU2QifgzjNWyA/4ft8Z2E
	+P10YYalHRf5t+cJEhkC8qsHO0EOsNtCdEwB0BVRKyLC/dcV6m7HnKe3183WTg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Mar 2024 09:15:18 +0100
Message-Id: <CZND9VGAGS45.210DYP50RTA9F@bootlin.com>
Cc: "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>,
 <linux-mips@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>, <linux-gpio@vger.kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski@linaro.org>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, "Gregory
 CLEMENT" <gregory.clement@bootlin.com>, "Michael Turquette"
 <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>, "Rob Herring"
 <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>, "Linus Walleij"
 <linus.walleij@linaro.org>, =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?=
 <rafal@milecki.pl>, "Philipp Zabel" <p.zabel@pengutronix.de>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v9 0/9] Add support for Mobileye EyeQ5 system controller
X-Mailer: aerc 0.15.2
References: <20240301-mbly-clk-v9-0-cbf06eb88708@bootlin.com>
In-Reply-To: <20240301-mbly-clk-v9-0-cbf06eb88708@bootlin.com>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Fri Mar 1, 2024 at 5:22 PM CET, Th=C3=A9o Lebrun wrote:
> Here again for a new revision of the system-controller on Mobileye
> EyeQ5. It deals with clk, reset and pinctrl. Drivers are meant to be
> merged in their respective trees. Each already have their dt-bindings
> in -next.

I'd be curious to get the state of mind of the involved maintainers
about this series?
 - clk, reset, pinctrl: I feel like the three drivers look in good shape
   now that we've done a few review iterations.
 - MIPS: dt-bindings have been queued in their respective branches so
   devicetree patches have no reason to change.

Can patches be queued before the upcoming merge window?

Have a nice day,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


