Return-Path: <linux-kernel+bounces-133161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A05EC899FC8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4157B1F2352A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738FC16F8FA;
	Fri,  5 Apr 2024 14:30:53 +0000 (UTC)
Received: from luna.linkmauve.fr (luna.linkmauve.fr [82.65.109.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFB016F859;
	Fri,  5 Apr 2024 14:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.65.109.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712327453; cv=none; b=S+F/FzL3xoEeErcZzhvkKPPuBUKvj6SkrtY4w2S4pmflLvq2vllVj5gw0IfWPlNuBk/L2IRqJjjT9DrkwtuaZEyAJzKLKz+/QqDXRCBHNYbNIrZ30qvCoh7RfQlOWKeToC4Ti/aGHwXx+dnq0VsTDbzx6hzMwDkMglUJpxljyDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712327453; c=relaxed/simple;
	bh=OAIDc5kctipri1hRyW8oc3G7ind5HlKJOPmKLgo/ZtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7YDRKzmZn0eaGWoqRomB68i8KwWjYUQ1g54whtA3rs1FVsNkmbeRf03SCEgG56gdzKPSbKt7LBiplDv0b/Hw2gR9Y9ys1pMRHo3NP7gTKNOsi8yXKlK7C32OinRKaShC8W9kYM7A17j7oq/H0U0jiuCmvRjmsH0s3tQSshwjjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass smtp.mailfrom=linkmauve.fr; arc=none smtp.client-ip=82.65.109.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linkmauve.fr
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
	id BA81A106966F; Fri,  5 Apr 2024 16:21:30 +0200 (CEST)
Date: Fri, 5 Apr 2024 16:21:30 +0200
From: Link Mauve <linkmauve@linkmauve.fr>
To: Nicolas Dufresne <nicolas@ndufresne.ca>
Cc: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
	linux-kernel@vger.kernel.org,
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
Message-ID: <ZhAI6tQZTD7BTosI@desktop>
References: <20240327134115.424846-1-linkmauve@linkmauve.fr>
 <bbcb66e9499120a86b367e7abdac2d8e2e704bfb.camel@ndufresne.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bbcb66e9499120a86b367e7abdac2d8e2e704bfb.camel@ndufresne.ca>
Jabber-ID: linkmauve@linkmauve.fr

On Thu, Apr 04, 2024 at 01:41:15PM -0400, Nicolas Dufresne wrote:
> Hi,

Hi,

> 
> Le mercredi 27 mars 2024 à 14:41 +0100, Emmanuel Gil Peyrot a écrit :
> > Only the JPEG encoder is available for now, although there are patches
> > for the undocumented VP8 encoder floating around[0].
> 
> [0] seems like a broken link. The VP8 encoder RFC is for RK3399 (and Hantro H1
> posted by ST more recently). The TRM says "VEPU121(JPEG encoder only)", which
> suggest that the H.264 and VP8 encoders usually found on the VEPU121 are
> removed. As Rockchip have remove the synthesize register while modifying the H1
> IP, it is difficult to verify. Confusingly the H.264 specific registers are
> documented in the TRM around VEPU121.

Ah, the link became, and was indeed ST’s series:
https://patchwork.kernel.org/project/linux-rockchip/list/?series=789885&archive=both

But the TRM part 1 says the VEPU121 supports H.264 encoding (page 367),
and it’s likely they didn’t remove just VP8 support since the codec
features are pretty close to H.264’s.

> 
> > 
> > This has been tested on a rock-5b, resulting in four /dev/video*
> > encoders.  The userspace program I’ve been using to test them is
> > Onix[1], using the jpeg-encoder example, it will pick one of these four
> > at random (but displays the one it picked):
> > % ffmpeg -i <input image> -pix_fmt yuvj420p temp.yuv
> > % jpeg-encoder temp.yuv <width> <height> NV12 <quality> output.jpeg
> 
> I don't like that we exposing each identical cores a separate video nodes. I
> think we should aim for 1 device, and then multi-plex and schedule de cores from
> inside the Linux kernel.

I agree, but this should be handled in the driver not in the device
tree, and it can be done later.

> 
> Not doing this now means we'll never have an optimal hardware usage
> distribution. Just consider two userspace software wanting to do jpeg encoding.
> If they both take a guess, they may endup using a single core. Where with proper
> scheduling in V4L2, the kernel will be able to properly distribute the load. I
> insist on this, since if we merge you changes it becomes an ABI and we can't
> change it anymore.

Will it really become ABI just like that?  Userspace should always
discover the video nodes and their capabilities and not hardcode e.g. a
specific /dev/videoN file for a specific codec.  I would argue that this
series would let userspace do JPEG encoding right away, even if in a
less optimal way than if the driver would round-robin them through a
single video node, but that can always be added in a future version.

> 
> I understand that this impose a rework of the mem2mem framework so that we can
> run multiple jobs, but this will be needed anyway on RK3588, since the rkvdec2,
> which we don't have a driver yet is also multi-core, but you need to use 2 cores
> when the resolution is close to 8K.

I think the mediatek JPEG driver already supports that, would it be ok
to do it the same way?

> 
> Nicolas
> 
> > 
> > [0] https://patchwork.kernel.org/project/linux-rockchip/list/?series=789885
> > [1] https://crates.io/crates/onix
> > 
> > Changes since v1:
> > - Dropped patches 1 and 4.
> > - Use the proper compatible form, since this device should be fully
> >   compatible with the VEPU of rk356x.
> > - Describe where the VEPU121 name comes from, and list other encoders
> >   and decoders present in this SoC.
> > - Properly test the device tree changes, I previously couldn’t since I
> >   was using a too recent version of python-jsonschema…
> > 
> > Emmanuel Gil Peyrot (2):
> >   media: dt-binding: media: Document rk3588’s VEPU121
> >   arm64: dts: rockchip: Add VEPU121 to rk3588
> > 
> >  .../bindings/media/rockchip,rk3568-vepu.yaml  |  8 +-
> >  arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 80 +++++++++++++++++++
> >  2 files changed, 86 insertions(+), 2 deletions(-)
> > 
> 

-- 
Link Mauve

