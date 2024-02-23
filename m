Return-Path: <linux-kernel+bounces-78517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 234CD861464
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2D7C284F8A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C482E412;
	Fri, 23 Feb 2024 14:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="lQ+oLqDH"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEC96FB9
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 14:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699441; cv=none; b=BIzcS49vX84vJaVUSInIxG9SGAOzYUJY9mvUBRJgmvXtGIWGG36fZYLTRZ/eo3SODkG+1enRd4L/bU/dKKiMBoimDQDlwItsB4Zqpl51D5+KK2biodlo3o/ua/FzGhbyIEaacA/YnAsTOuF1fnhVQOgIW0LtT1uSopyFag5eGAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699441; c=relaxed/simple;
	bh=PsFvtja6vC3aa0yewfFUSPD4Shvj+fBkBT8wbqH92wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PkoarwNYmekR2Iv2CM3sK1dkZ1N62cZbLKyxAZ4dn7ppdmpDuLoxwGUVxp7DOKxaLH3xthlGccOk+FthfZPpIYZe1cXTqt0dPAvsh/GOVFhUZwX2QdiFUB+9Tor0UaSTL/hhSkx0NV1lFmF6uoO5/vk7J/LI8Mm03q0Mp+Go2S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=lQ+oLqDH; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=u/aavTwccFRcAG7ut7q4MQxLB8Quxo5JTYbXqtZujLA=;
	b=lQ+oLqDH54vwPb/2DxXNxJwrA6cCwjSvXCLU//q3PnzyNF4WwIy9KdQOfdiIs5
	OPXhIyh06YbsSq+H5wDDctOU1/aPxbL+HL6ms0I9hQixQGr7Yq6hd0GXtZlMyo4o
	5hvH5/fqqYQLkkK3CsevrTA4+KQVmTuxvoobl5vePCJTQ=
Received: from dragon (unknown [183.213.196.200])
	by smtp1 (Coremail) with SMTP id ClUQrAAn6R3yrthlVxU3BA--.6479S3;
	Fri, 23 Feb 2024 22:43:00 +0800 (CST)
Date: Fri, 23 Feb 2024 22:42:58 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Matthias Brugger <mbrugger@suse.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	Olof Johansson <olof@lixom.net>,
	Chester Lin <chester62515@gmail.com>,
	krzysztof.kozlowski+dt@linaro.org,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Rob Herring <robh+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	soc@kernel.org, NXP S32 Linux Team <s32@nxp.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: Add maintainer for NXP S32G boards
Message-ID: <Zdiu8s5Cgz9s6dLP@dragon>
References: <20240221120123.1118552-1-ghennadi.procopciuc@oss.nxp.com>
 <20240221120123.1118552-2-ghennadi.procopciuc@oss.nxp.com>
 <f4465547-1fb1-4578-9a69-7d399e7661b3@linaro.org>
 <403e32c2-910e-4745-9ebe-fbf377c3fde8@linaro.org>
 <ad856766-8903-46c0-93af-24e101ad51dc@oss.nxp.com>
 <e538ded0-bd3a-4ca4-b2bd-8d20d8c8c3fe@linaro.org>
 <bcb79af4-56d9-4204-9503-cff996f1ba41@oss.nxp.com>
 <e6f6070e-8355-4a0b-a904-1a24970f249b@linaro.org>
 <e530d504-dfa3-4d39-b903-b2570bb8b014@suse.com>
 <c3e68c62-b81f-475b-9b15-c983c94aed8b@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3e68c62-b81f-475b-9b15-c983c94aed8b@app.fastmail.com>
X-CM-TRANSID:ClUQrAAn6R3yrthlVxU3BA--.6479S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr43trW8GFyftry8ZFWxCrg_yoW5Jr4UpF
	W8CF98Kr4kKr1kAwnF9r129a40v3y5JFW3XrykW345JasIqw1ftryI9r4a9asxursYgF4a
	yF4UXas29a15Za7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jIrWrUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiGBSNZV6NnjDVsQAAs9

On Fri, Feb 23, 2024 at 01:29:10PM +0100, Arnd Bergmann wrote:
> On Fri, Feb 23, 2024, at 13:02, Matthias Brugger wrote:
> > On 22/02/2024 12:13, Krzysztof Kozlowski wrote:
> >> On 21/02/2024 18:00, Ghennadi Procopciuc wrote:
> >> 
> >> Andreas or Matthias,
> >> Maybe you could change your R: into M: and take s32g patches?
> >> 
> >> If not, then I will ack this patch making Ghennadi the maintainer.
> >> 
> >
> > Normal process would be that Arnd would contact Chester to see if he is 
> > not able 
> > to do the maintainer work any more. In that case maybe Arnd could take 
> > over.
> 
> I was hoping to see a reply from Chester one way or another,
> I see he has been on Cc for the entire thread but not
> chimed in.
> 
> > I'm not saying that Ghennadi won't be able to defend this, if it ever occurs. 
> > Basically because I don't have a good track record of him due to missing 
> > upstream collaboration.
> >
> > I would prefer that Arnd (or Andreas) step up to take the maintainer role. I 
> > already have one and it's difficult for me to find the time to do it in an 
> > acceptable way.
> 
> It appears that we already cover the dts files in the IMX
> entry, whether that is intentional or not:
> 
> ARM/FREESCALE IMX / MXC ARM ARCHITECTURE
> M:      Shawn Guo <shawnguo@kernel.org>
> M:      Sascha Hauer <s.hauer@pengutronix.de>
> R:      Pengutronix Kernel Team <kernel@pengutronix.de>
> R:      Fabio Estevam <festevam@gmail.com>
> R:      NXP Linux Team <linux-imx@nxp.com> 
> L:      linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> S:      Maintained
> T:      git git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
> F:      arch/arm/boot/dts/nxp/imx/
> F:      arch/arm/boot/dts/nxp/mxs/
> F:      arch/arm64/boot/dts/freescale/
> 
> Added everyone there to Cc, having any s32 patches go through
> the imx tree would be the easiest way as far as I'm concerned.
> I've added the maintainers to Cc, let's see what they think.

It's unintentional that IMX entry covers s32 dts files, as they have a
dedicated entry.

ARM/NXP S32G ARCHITECTURE
M:      Chester Lin <chester62515@gmail.com>
R:      Andreas Färber <afaerber@suse.de>
R:      Matthias Brugger <mbrugger@suse.com>
R:      NXP S32 Linux Team <s32@nxp.com>
L:      linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
S:      Maintained
F:      arch/arm64/boot/dts/freescale/s32g*.dts*

However I'm fine with collecting and sending patches through IMX tree,
if S32G folks help review them.

Shawn


