Return-Path: <linux-kernel+bounces-86490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5471F86C62F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06C701F2471B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277786281F;
	Thu, 29 Feb 2024 09:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="L3PusnRP"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E765F86F;
	Thu, 29 Feb 2024 09:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709200599; cv=none; b=o1McPd2cAGXU/81mVh5yQ2+QwXKzLmNHjxSNQbL8+MvpDZeECNKnyDRjqvR8H4CiMvZffRIPkU2iZMmdoIRlzUFEwLmuyXmFYZxGFm/iRlnYiAYtyhjKQ+Ma+id5jsRWmNvYmlpNLiGMmB6WD06kwZ50mVx41dQ5hVlhFESBljI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709200599; c=relaxed/simple;
	bh=6r5UPWYkvqQFSDHNeLtsINM/kTHr8C9zl217UjTeoQQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=PKKNMEyNDjNQGugBZBiwidxh4Ew3Jo14JD0QQhJRbJlDdOXsCXYXXQyVqRaMRwcgkBhZmPCr/Uepa/+BQySDrBDadxSIJ4QxXO53qETz2qd7XvFfs4tlUgdlaTlTw2FLrbSpssQrK/ljKle+0RfsC5I23zXcvDDNH7Qt43cGdRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=L3PusnRP; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B5074240011;
	Thu, 29 Feb 2024 09:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709200594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k/PhTuZtbma+b2uqep16NcKtM46o621J394ZeTPTZI0=;
	b=L3PusnRPwEbDjYR4L9o8gH4UGu9vXKeMdR2QKBwtIJPNgNAXIEI+R36BHQ8lEnayZQfkpW
	R2bOAaawZ2iyC9hVzar02u9ocGEa/2L4vUD4N4ObBe14RalRlDKIzRwilBVoYgPK9/2SDw
	N5g2wiTrFKhSBWRymq2fI1gpCuSWxH+E908J0eDHmiTN72eNJ4eKgN/GJpOHOiqWbaIipM
	ehoa7OiNbYptLGA9no1SnMR3hR61e23++aiwj0vcWr6ko37Rn2SjPQu1tzDRyxYr4q27Gz
	Ux1m+dqzUgwWPxMD229EXKofRwfo5iQvOgg/iFCxVRkLkOFeGbahe6lcv15qwA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Feb 2024 10:56:32 +0100
Message-Id: <CZHH1KDAVDCC.1INC050YK8HU1@bootlin.com>
Subject: Re: [PATCH v2 00/30] Rework Nomadik GPIO to add Mobileye EyeQ5
 support
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
 <tawfik.bayouk@mobileye.com>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski@linaro.org>, "Stephen Warren" <swarren@wwwdotorg.org>,
 "Jonathan Corbet" <corbet@lwn.net>, <linux-doc@vger.kernel.org>
To: "Linus Walleij" <linus.walleij@linaro.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.15.2
References: <20240228-mbly-gpio-v2-0-3ba757474006@bootlin.com>
 <CACRpkdbK2Sa_4qp3VE0ivHP8W6F-QDkuxV-XnZYviAkO5ZBMsg@mail.gmail.com>
In-Reply-To: <CACRpkdbK2Sa_4qp3VE0ivHP8W6F-QDkuxV-XnZYviAkO5ZBMsg@mail.gmail.com>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Thu Feb 29, 2024 at 10:44 AM CET, Linus Walleij wrote:
> On Wed, Feb 28, 2024 at 12:28=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@bo=
otlin.com> wrote:
>
> > This patch series reworks the Nomadik GPIO driver to bring it up to dat=
e
> > to current kernel standards. We then add Mobileye EyeQ5 support that
> > uses the same IP block but with limited functionality. We also add
> > features required by our newly supported platform:
> >
> >  - Dynamic GPIO ID allocation;
> >  - Make clock optional;
> >  - Shared IRQ (usecase: EyeQ5 has two banks using the same IRQ);
> >  - Handle variadic GPIO counts (usecase: EyeQ5 has <32 GPIOs per bank);
> >  - Grab optional reset at probe (usecase: EyeQ5 has a shared GPIO reset=
).
> >
> > This GPIO platform driver was previously declared & registered inside
> > drivers/pinctrl/nomadik/pinctrl-nomadik.c, side-by-side with the
> > pinctrl driver. Both are tightly integrated, mostly for muxing reasons.
> > Now that gpio-nomadik is used for another platform, we loosen the
> > relationship. The behavior should not change on already supported
> > hardware but I do not have Nomadik hardware to test for that.
>
> I have queued the relevant patches to an immutable branch in the
> pinctrl tree for testing and I can also pick up some ACKs if they arrive.
>
> When I'm confident in the branch, I will send an optional pull request
> to Bartosz for it!

That is all great news, thanks Linus! I'm staying available if you
encounter anything that needs action.

Have a nice day,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


