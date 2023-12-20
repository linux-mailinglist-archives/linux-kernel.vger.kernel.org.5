Return-Path: <linux-kernel+bounces-7482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A839F81A8B7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 650BF28B80C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FC749F8F;
	Wed, 20 Dec 2023 22:05:35 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47B2495EA;
	Wed, 20 Dec 2023 22:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rG4Ro-0001hx-00; Wed, 20 Dec 2023 22:49:48 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 0075DC028A; Wed, 20 Dec 2023 22:49:33 +0100 (CET)
Date: Wed, 20 Dec 2023 22:49:33 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Paul Burton <paulburton@kernel.org>, linux-mips@vger.kernel.org,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 00/22] Add support for the Mobileye EyeQ5 SoC
Message-ID: <ZYNhbQjMbAH6I0kI@alpha.franken.de>
References: <20231212163459.1923041-1-gregory.clement@bootlin.com>
 <878r5vctdg.fsf@BL-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878r5vctdg.fsf@BL-laptop>

On Fri, Dec 15, 2023 at 05:39:39PM +0100, Gregory CLEMENT wrote:
> Hello Thomas,
> 
> > Hello,
> >
> > The EyeQ5 SoC from Mobileye is based on the MIPS I6500 architecture
> > and features multiple controllers such as the classic UART, I2C, SPI,
> > as well as CAN-FD, PCIe, Octal/Quad SPI Flash interface, Gigabit
> > Ethernet, MIPI CSI-2, and eMMC 5.1. It also includes a Hardware
> > Security Module, Functional Safety Hardware, and MJPEG encoder.
> >
> > One peculiarity of this SoC is that the physical address of the DDDR
> > exceeds 32 bits. Given that the architecture is 64 bits, this is not
> > an issue, but it requires some changes in how the mips64 is currently
> > managed during boot.
> >
> > In this fifth version, there aren't many changes, mostly just tweaking
> > commit messages based on Sergey's feedback and fixing up the code
> > style. But, the real reason for this series is a bit of a whoopsie on
> > my end. It turns out, despite what I confidently claimed in the last
> > round, some configuration tweaks were missing. All sorted now, though!
> >
> 
> A few weeks ago, you were concerned about the introduction of the
> specific kconfig CONFIG_USE_XKPHYS to support EyeQ5, and you wanted us
> to set up a new platform instead. Since then, Jiaxun proposed a series
> that was merged here to provide more generic support.

well, there is more to improve and stuff I don't like in Jaixun series.
For example misusing CONFIG_PHYSICAL_START to force a load address via config
(IMHO it's already a hack for CRASH_DUMP).

As there is your series and Jiaxun series, where should I comment more
detailed ?

> I had other issues in the initial series, and I think that now I've
> fixed all of them. So, I would like to know what your opinion is now
> about this series.
> 
> Will you accept it, or do you still think that a new platform has to be
> set up?

things have improved, but I'm still in favor to use a new platform.
And my main point stays. A "generic" kernel compiled for EyeQ5 will
just run on that platform, which doesn't sound generic to me.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

