Return-Path: <linux-kernel+bounces-9776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC7081CB41
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC1471F22436
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B69C1D52B;
	Fri, 22 Dec 2023 14:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="O/agRZZV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hRpiyzI5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EACE1CF92
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 14:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 7AACE5C010C;
	Fri, 22 Dec 2023 09:22:08 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 22 Dec 2023 09:22:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1703254928; x=1703341328; bh=Y+t6ngTWXD
	Ac1tuGwonBj1jr9elBH/3ETk2fEmC02OE=; b=O/agRZZVGVZSm/uGpaZyILxyYp
	KGO0weNQm4OrvRxsLmjjpsVlT05qQXvR4B4dfzFnmxGw2LecBQcnEPFMfbAfnmx7
	xbbmDRtIorGcYintaGTZine1t8OoaQoN8xU2F+4RXIRFnvdkXCjRye+uHvU8uPlz
	Z5j0xxYqzCXtXzJLPkY7YPX2VhFHXmi2RgGH9ejDcqflccFWrG6eugvsJEtQKnHz
	y/BzGJ4we07PA1N+ZeghuYrNvNx21GEoGAwIpz4nykDhq5mhJVO+7h0GAFieSNyC
	Bxhko4fXvUYsoGgrZBgfpgG9gpxGhYy7kEQw2BoM649x8o+gHa9XqUx2fe+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703254928; x=1703341328; bh=Y+t6ngTWXDAc1tuGwonBj1jr9elB
	H/3ETk2fEmC02OE=; b=hRpiyzI5S6dsAuQb9HPuKF2UmcIHWGyX8CWTe7W2gkOV
	oaD/UB9jpaKShGzJmHZDBeTYQ3/Fdef4ybw7vMa9VYekZcRQeeBfKxIQGvsXkW+K
	R4o1bcbKy9OWsk5NcforAfXTVqImt7/etih0S9TiWRrLGlUPozd+vx7sRyc9dwhV
	KLaxWTuf4aIisYnOJdzDbnoQTx2JrOaVvLOM4phA0g/XAojciLGi0QE8MtAjGccG
	7PbKmBJk/1JrJ0BxwJ8b8ShZisoxEHAO7KxzoMQ29JnYXR7xW1KlQDQqeeUErKSl
	1oclHTWocaIqj+RGAL4hgy9upm9SA1CFZOfDMwC7MQ==
X-ME-Sender: <xms:jpuFZbLAghcbyrJfSkiAHK43j3cI45k767miMqOjvwkh5flMLzBhEA>
    <xme:jpuFZfIT2sP5zu8ZGApwBVz2jIODOGNHzQm0IuhOk6eLohlCN_-qi1dzi5lcfzPQR
    UayusSyeVYWRPchUqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddujedgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:jpuFZTtCPogCaC_yOlI8Qmx3WPz7i4AxZaJ6dBFKJNl5893W6NxMkQ>
    <xmx:jpuFZUahSm9WFimU0VKFe7RbkONeEYXocyaPuQnHJ0VRBLBSPx93BQ>
    <xmx:jpuFZSZTdwydH6eCDBXCx-NcAC3ji4-8wBjFab4F1GyF166Mi6BIvA>
    <xmx:kJuFZa5-mCruwCQT4g1ALkuWedDpC6A8jq8nNtXgv3TnHn9Cm9aPZQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C7FCEB60093; Fri, 22 Dec 2023 09:22:06 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8853b024-4f1f-4acf-ac52-6b20bbd2ba12@app.fastmail.com>
In-Reply-To: <20230515160234.289631-8-afd@ti.com>
References: <20230515160234.289631-1-afd@ti.com>
 <20230515160234.289631-8-afd@ti.com>
Date: Fri, 22 Dec 2023 14:21:49 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andrew Davis" <afd@ti.com>, "Russell King" <linux@armlinux.org.uk>,
 "Baruch Siach" <baruch@tkos.co.il>, "Vladimir Zapolskiy" <vz@mleia.com>,
 "Kunihiko Hayashi" <hayashi.kunihiko@socionext.com>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>,
 "Linus Walleij" <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] ARM: mach-hpe: Rework support and directory structure
Content-Type: text/plain

On Mon, May 15, 2023, at 16:02, Andrew Davis wrote:
> Having a platform need a mach-* directory should be seen as a negative,
> it means the platform needs special non-standard handling. ARM64 support
> does not allow mach-* directories at all. While we may not get to that
> given all the non-standard architectures we support, we should still try
> to get as close as we can and reduce the number of mach directories.
>
> The mach-hpe/ directory and files, provides just one "feature":
> having the kernel print the machine name if the DTB does not also contain
> a "model" string (which they always do). To reduce the number of mach-*
> directories let's do without that feature and remove this directory.
>
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  MAINTAINERS                |  1 -
>  arch/arm/Kconfig           |  2 --
>  arch/arm/Kconfig.platforms | 25 +++++++++++++++++++++++++
>  arch/arm/Makefile          |  1 -
>  arch/arm/mach-hpe/Kconfig  | 23 -----------------------
>  arch/arm/mach-hpe/Makefile |  1 -
>  arch/arm/mach-hpe/gxp.c    | 16 ----------------

I'm dropping this patch from the series:

> -/* Copyright (C) 2022 Hewlett-Packard Enterprise Development Company, L.P. */
> -
> -#include <linux/of_platform.h>
> -#include <asm/mach/arch.h>
> -
> -static const char * const gxp_board_dt_compat[] = {
> -	"hpe,gxp",
> -	NULL,
> -};
> -
> -DT_MACHINE_START(GXP_DT, "HPE GXP")
> -	.dt_compat	= gxp_board_dt_compat,
> -	.l2c_aux_val = 0,
> -	.l2c_aux_mask = ~0,
> -MACHINE_END

As Russell had previously pointed out, removing the l2c settings
from a machine file breaks these machines if there is an actual
l2c node, which for gxp there is, same for most other Cortex-A9
and A5 based platforms.

The Uniphier machine that you also modify here is an exception
because they use a custom L2 cache implementation.

      Arnd

