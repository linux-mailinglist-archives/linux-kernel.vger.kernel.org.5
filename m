Return-Path: <linux-kernel+bounces-25852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2393482D6BD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99196B217B1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE86D12E70;
	Mon, 15 Jan 2024 10:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="JJNov7xM"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26E717727;
	Mon, 15 Jan 2024 10:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Q+8/IEjFJ6FaUC9Is4EXtyjT3oDpArt5eWtCr0Ef22I=; b=JJNov7xMP1eeUqF57OqkVV0Nd8
	CG4eDIjLaLjDGy6lnktp+/oCd1AapYBTwa0aVcSRDn6eMl+ozeWKaxL2EvkduGLpeSJ+D2PcfkoK3
	1q9HRivJr99rsTBVN3y6SG1Ght43y31YvvRoLrwFitMGQajaTin7lqJTrCb1iUSMKcU2+kClKYNH2
	THPlLOupz6L9+vqzRqp12TOTK1wKnM5RFpXVYPdRR7NFMf5W9OW4fJZq4dJaBQQ2dR6NCmpWqpBjZ
	X1h7cPV9HwWu6dqwaZyVjTXIBRGDE0h4rWcVj9Z/gf6yT3BX5UzIeFKABGYKjJYaUBUsf+V7oyKyA
	w/rwAJJg==;
Received: from p200301077700f3001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7700:f300:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andreas@kemnade.info>)
	id 1rPJc6-008P8Q-Iv; Mon, 15 Jan 2024 10:50:38 +0100
Date: Mon, 15 Jan 2024 10:50:35 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Maxime Ripard <mripard@kernel.org>, Andrew Davis <afd@ti.com>, Frank
 Binns <frank.binns@imgtec.com>, Donald Robson <donald.robson@imgtec.com>,
 Matt Coster <matt.coster@imgtec.com>, Adam Ford <aford173@gmail.com>,
 Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 =?UTF-8?B?QmVub8OudA==?= Cousson <bcousson@baylibre.com>, Tony Lindgren
 <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, Paul Cercueil
 <paul@crapouillou.net>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-omap@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH RFC v2 04/11] ARM: dts: omap4: Add device tree entry for
 SGX GPU
Message-ID: <20240115105035.06e6af86@aktux>
In-Reply-To: <7BC64F03-A4DF-411F-9B6F-6BCA436D9B50@goldelico.com>
References: <20240108183302.255055-1-afd@ti.com>
	<20240108183302.255055-5-afd@ti.com>
	<122DC5ED-2AA7-46A0-845F-083922458385@goldelico.com>
	<vpcgccul53oibwoqb3barj3rjxoyskoldjyfvjdzmytic3tonm@wq4aqsenk7rp>
	<7BC64F03-A4DF-411F-9B6F-6BCA436D9B50@goldelico.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi, 

On Mon, 15 Jan 2024 09:55:00 +0100
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> > There's no reason to disable it in the DT: the hardware block would
> > still be there and it's rendering to memory so it still could be useful.  
> 
> Well, if you know that the board does not have a dm3730 but a dm3725 without
> GPU it is better to disable the GPU completely instead of loading the driver
> and make it detect by some internal bits that it has no GPU on the SoC.
> 
That is at least some valid reason.

> > If there's no display on the board and you really don't want the GPU
> > driver, then you can disable the driver or block the module loading, but
> > it should be a distro / package / user decision, not a DT / kernel one
> > still.  
> 
> The same holds for aes: dss: dsi: hdmi: etc. If they are not used by some
> board file, they don't change a single bit of the DTB [1] which IMHO would
> be of reasonable concern to question additional labels.

There is some difference here, some hardware can just not be used without
wired external pins, the gpu can be used even if no display is connected
either to accelerate some remote access or you could use the gpu for something
completely else...
Maybe mining bitcoins if temperate gets too low to warm you pocket ;-)

But as these labels do not harm, I have no strong opinion against it.

Regards,
Andreas

