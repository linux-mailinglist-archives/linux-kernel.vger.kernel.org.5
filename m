Return-Path: <linux-kernel+bounces-4446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA642817D33
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4486FB236FA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 22:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A1274E18;
	Mon, 18 Dec 2023 22:20:11 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188AE5D746;
	Mon, 18 Dec 2023 22:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id E1BDC6343B3B;
	Mon, 18 Dec 2023 23:10:21 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 9keEN92ZV6OF; Mon, 18 Dec 2023 23:10:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 6AB616343B3C;
	Mon, 18 Dec 2023 23:10:21 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id nR8uZpRh0SkQ; Mon, 18 Dec 2023 23:10:21 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 2459D6343B3B;
	Mon, 18 Dec 2023 23:10:21 +0100 (CET)
Date: Mon, 18 Dec 2023 23:10:20 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: Mark Brown <broonie@kernel.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	pratyush <pratyush@kernel.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, 
	sbinding@opensource.cirrus.com, Lee Jones <lee@kernel.org>, 
	james schulman <james.schulman@cirrus.com>, 
	david rhodes <david.rhodes@cirrus.com>, rf@opensource.cirrus.com, 
	Jaroslav Kysela <perex@perex.cz>, tiwai@suse.com, 
	linux-spi <linux-spi@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Michael Walle <michael@walle.cc>, 
	linux-mtd <linux-mtd@lists.infradead.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	michal simek <michal.simek@amd.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	alsa-devel <alsa-devel@alsa-project.org>, 
	patches@opensource.cirrus.com, linux-sound@vger.kernel.org, 
	git@amd.com, amitrkcian2002@gmail.com
Message-ID: <1953466568.133535.1702937420979.JavaMail.zimbra@nod.at>
In-Reply-To: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
Subject: Re: [PATCH v11 00/10] spi: Add support for stacked/parallel
 memories
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Add support for stacked/parallel memories
Thread-Index: Gp+EE7t5zvexUhLdnkyaadGyCIq7oQ==

----- Urspr=C3=BCngliche Mail -----
> Von: "Amit Kumar Mahapatra" <amit.kumar-mahapatra@amd.com>

> This patch series updated the spi-nor, spi core and the AMD-Xilinx GQSPI
> driver to add stacked and parallel memories support.

I wish the series had a real cover letter which explains the big picture
in more detail.

What I didn't really get so far, is it really necessary to support multiple
chip selects within a single mtd?
You changes introduce hard to maintain changes into the spi-nor/mtd core co=
de
which alert me.
Why can't we have one mtd for each cs and, if needed, combine them later?
We have drivers such as mtdconcat for reasons.

Thanks,
//richard

