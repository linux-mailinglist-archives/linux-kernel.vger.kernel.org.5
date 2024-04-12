Return-Path: <linux-kernel+bounces-142898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6308A31CD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADDC6B219C3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D9F147C99;
	Fri, 12 Apr 2024 15:07:30 +0000 (UTC)
Received: from luna.linkmauve.fr (luna.linkmauve.fr [82.65.109.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF74D85285;
	Fri, 12 Apr 2024 15:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.65.109.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934449; cv=none; b=ApxkWRAqKwfOg5I1tQXQMHlhKuVeYi+oefgbWFt3kiVuhYIjeCIawXuTec8ozUT/ChtIvoOMW0I6zHNFRFAyIL6BJLQ87JJUL7PAia60qIrnSRYBuP4MMCE5IHQKJ8jSSvOhZphaeDHQN/4CtXS8c9ssUJP3OeTYaddGodIdYqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934449; c=relaxed/simple;
	bh=voCHpxixn5k41RDfN/siqd8KEKEYBlLi9myAWQrB8c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7F4Pn3Yi2EsaF6+XMhwfg4S/6W0XpO51tWeV16tF/aAGx9kP6YV3SEDbJdk8Z23K0bs10qBQsSF/b85KsPKlGkMq9tM1uPVnbPn5prQUNkuHNqb4kqgzHow33Elc4qtvK+3ordMCi3tDpAhzGbLNWlzrpk3zCXDrYFaWI2GGgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass smtp.mailfrom=linkmauve.fr; arc=none smtp.client-ip=82.65.109.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linkmauve.fr
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
	id 4EDA110A25E8; Fri, 12 Apr 2024 17:07:19 +0200 (CEST)
Date: Fri, 12 Apr 2024 17:07:19 +0200
From: Link Mauve <linkmauve@linkmauve.fr>
To: Nicolas Dufresne <nicolas@ndufresne.ca>
Cc: Link Mauve <linkmauve@linkmauve.fr>, linux-kernel@vger.kernel.org,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Shreeya Patel <shreeya.patel@collabora.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
	linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v2 0/2] Enable JPEG encoding on rk3588
Message-ID: <ZhlOJ4gOuO9k-A37@desktop>
References: <20240327134115.424846-1-linkmauve@linkmauve.fr>
 <bbcb66e9499120a86b367e7abdac2d8e2e704bfb.camel@ndufresne.ca>
 <ZhAI6tQZTD7BTosI@desktop>
 <ed0b32ec6da10f46ff5d820612bfe700388fae1e.camel@ndufresne.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed0b32ec6da10f46ff5d820612bfe700388fae1e.camel@ndufresne.ca>
Jabber-ID: linkmauve@linkmauve.fr

On Sun, Apr 07, 2024 at 10:08:58AM +0200, Nicolas Dufresne wrote:
> Le vendredi 05 avril 2024 à 16:21 +0200, Link Mauve a écrit :
> > On Thu, Apr 04, 2024 at 01:41:15PM -0400, Nicolas Dufresne wrote:
> > > Hi,
> > 
> > Hi,
> > 
> > > 
> > > Le mercredi 27 mars 2024 à 14:41 +0100, Emmanuel Gil Peyrot a écrit :
> > > > Only the JPEG encoder is available for now, although there are patches
> > > > for the undocumented VP8 encoder floating around[0].
> > > 
> > > [0] seems like a broken link. The VP8 encoder RFC is for RK3399 (and Hantro H1
> > > posted by ST more recently). The TRM says "VEPU121(JPEG encoder only)", which
> > > suggest that the H.264 and VP8 encoders usually found on the VEPU121 are
> > > removed. As Rockchip have remove the synthesize register while modifying the H1
> > > IP, it is difficult to verify. Confusingly the H.264 specific registers are
> > > documented in the TRM around VEPU121.
> > 
> > Ah, the link became, and was indeed ST’s series:
> > https://patchwork.kernel.org/project/linux-rockchip/list/?series=789885&archive=both
> > 
> > But the TRM part 1 says the VEPU121 supports H.264 encoding (page 367),
> > and it’s likely they didn’t remove just VP8 support since the codec
> > features are pretty close to H.264’s.
> > 
> > > 
> > > > 
> > > > This has been tested on a rock-5b, resulting in four /dev/video*
> > > > encoders.  The userspace program I’ve been using to test them is
> > > > Onix[1], using the jpeg-encoder example, it will pick one of these four
> > > > at random (but displays the one it picked):
> > > > % ffmpeg -i <input image> -pix_fmt yuvj420p temp.yuv
> > > > % jpeg-encoder temp.yuv <width> <height> NV12 <quality> output.jpeg
> > > 
> > > I don't like that we exposing each identical cores a separate video nodes. I
> > > think we should aim for 1 device, and then multi-plex and schedule de cores from
> > > inside the Linux kernel.
> > 
> > I agree, but this should be handled in the driver not in the device
> > tree, and it can be done later.
> 
> As the behaviour we want is that these cores becomes a group and get schedule
> together, its certainly a good time to slow down and evaluate if that part needs
> to be improve in the DT too.
> 
> Hantro G1/H1 and VEPU/VDPU121 combos originally shared the same sram region. Its
> not clear if any of these cores have this limitation and if this should be
> expressed in the DT / driver.

The TRM on page 369 mentions that:
> Please note that VDPU121 and VDPU381 and VDPU720 and AV1 and VEPU121 and VEPU580
> is different IP cores, so these processing core can be work together.

I understand that as them not sharing any memory and being able to work
independently.

> 
> > 
> > > 
> > > Not doing this now means we'll never have an optimal hardware usage
> > > distribution. Just consider two userspace software wanting to do jpeg encoding.
> > > If they both take a guess, they may endup using a single core. Where with proper
> > > scheduling in V4L2, the kernel will be able to properly distribute the load. I
> > > insist on this, since if we merge you changes it becomes an ABI and we can't
> > > change it anymore.
> > 
> > Will it really become ABI just like that?  Userspace should always
> > discover the video nodes and their capabilities and not hardcode e.g. a
> > specific /dev/videoN file for a specific codec.  I would argue that this
> > series would let userspace do JPEG encoding right away, even if in a
> > less optimal way than if the driver would round-robin them through a
> > single video node, but that can always be added in a future version.
> 
> Might be on the gray side, but there is good chances software written for your
> specific board can stop working after te grouping is done.

I will send a new series shortly which enables only one of these four
cores, the functionality should be the same, it will just expose only
one video node which can get a four times throughput upgrade later once
we implement multi-core support in the driver.

> 
> > 
> > > 
> > > I understand that this impose a rework of the mem2mem framework so that we can
> > > run multiple jobs, but this will be needed anyway on RK3588, since the rkvdec2,
> > > which we don't have a driver yet is also multi-core, but you need to use 2 cores
> > > when the resolution is close to 8K.
> > 
> > I think the mediatek JPEG driver already supports that, would it be ok
> > to do it the same way?
> 
> I don't know for JPEG, the MTK vcoder do support cascading cores. This is
> different from concurrent cores. In MTK architecture, for some of the codec,
> there is LAT (entropy decoder) and CORE (the reconstruction block) that are
> split.

Ah, that’s different then, I only had a cursory look at them back when I
implemented the JPEG decoder for sunxi.

> 
> Nicolas

-- 
Link Mauve

