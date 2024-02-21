Return-Path: <linux-kernel+bounces-75075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5695A85E29B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 864AF1C21332
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51A481751;
	Wed, 21 Feb 2024 16:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jB2y2QNw"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E5E81742;
	Wed, 21 Feb 2024 16:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708531521; cv=none; b=E3IZV/llhIAWrPUm7EfcOBK1yxzQJfarfSR1wm9usgOkiL0WsauLbN7pjST/6i65dXe4BF5zl4/900YZWhsIEc2b1+LWhrW+TZcsRXrQsCqdzHi6ZqcPMB+elPZ3xySbw9Vt5c2DsH47zmSQAErYXmjlPH2FkLZOIycBMwpE3Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708531521; c=relaxed/simple;
	bh=4osHeqTpGZbNF+WwFOeN/1hOUN/aK+g+cz/1SRJB+9E=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=NdmFB497uoovKSCJN8K+jeSGbkBmpRtHwOjhz/+fcE5d34v32RZCL0O1wLfOjGIFrSDqNjEVLWZ4bJDs8xM2gOKeX1nVl7Kv4u9LG98PJqBV2Fr1yjMUBQ49gHTKDYmFRDBC/DmL6Yvmt7/K+FhpsO5mOYakmugOT9SEYp2izlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jB2y2QNw; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DAA2EC0013;
	Wed, 21 Feb 2024 16:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708531516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KMfvDi1Z7NgcdHnP3iiFwTVbi7e7yWaAr0kgZz77890=;
	b=jB2y2QNwjiyNS83wMYPNJMm+XgYPGyoUtT68qdAcfISdumDjJnAr5ntNT7dGwok2HL4NFj
	12GzGwCkAwWNFq+EbRQvj5zbXIGTQq7s2RzdCCfyaAOuibep9mEJpmFn5v5vlNzpf3Z8rX
	eWIh/K0nbUoWeTtZEm78NCgOVVzVPizrG2HQfW6I6HkiEpRLVrhScpd4/Ekg24F9nMTrGF
	vbsV+08topQMABL2LlP90n4ytitLV4/ihLVQx2w7plXfvhUON02JXjxPmNpf+tZb+TYUPk
	ZBs/cLF51a/rLam1ul/DfP0K+LmrRBXD7lUdgN8+UchNJJmbyAadX9gR4LDYbA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Feb 2024 17:05:15 +0100
Message-Id: <CZAVVISSTXS3.1ZTSEY6PV6LOT@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH 13/23] gpio: nomadik: fix offset bug in nmk_pmx_set()
Cc: "Bartosz Golaszewski" <brgl@bgdev.pl>, "Rob Herring"
 <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Philipp Zabel" <p.zabel@pengutronix.de>, "Thomas Bogendoerfer"
 <tsbogend@alpha.franken.de>, <linux-gpio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-mips@vger.kernel.org>,
 "Gregory CLEMENT" <gregory.clement@bootlin.com>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
To: "Linus Walleij" <linus.walleij@linaro.org>
X-Mailer: aerc 0.15.2
References: <20240214-mbly-gpio-v1-0-f88c0ccf372b@bootlin.com>
 <20240214-mbly-gpio-v1-13-f88c0ccf372b@bootlin.com>
 <CACRpkdbq_QxdftNGOv3+-SpfrV_qPTB-m-atdY0hCE_s8DK64A@mail.gmail.com>
In-Reply-To: <CACRpkdbq_QxdftNGOv3+-SpfrV_qPTB-m-atdY0hCE_s8DK64A@mail.gmail.com>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Mon Feb 19, 2024 at 10:56 PM CET, Linus Walleij wrote:
> On Wed, Feb 14, 2024 at 5:24=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@boo=
tlin.com> wrote:
>
> > Previously, the statement looked like:
> >
> >     slpm[x] &=3D ~BIT(g->pins[i]);
> >
> > Where:
> >  - slpm is a unsigned int pointer;
> >  - g->pins[i] is a pin number which can grow to more than 32.
> >
> > The expected shift amount is a pin bank offset.
> >
> > This bug does not occur on every group or pin: the altsetting must be
> > NMK_GPIO_ALT_C and the pin must be 32 or above. It is possible that it
> > occurred. For example, in pinctrl-nomadik-db8500.c, pin group i2c3_c_2
> > has the right altsetting and has pins 229 and 230.
> >
> > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>
> Ah good catch!
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> I this something I could just apply as a fix or are there
> dependencies on other patches?

There are dependencies. As Bartosz and you asked, I'll try my best to
avoid them and move this patch up in the series, with an appropriate
Fixes: trailer (to the initial driver commit I believe).

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

