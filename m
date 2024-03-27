Return-Path: <linux-kernel+bounces-121374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A06C688E712
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E0B01F31108
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A491159911;
	Wed, 27 Mar 2024 13:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="hQBohv5M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lXM24WwO"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0120513D88E;
	Wed, 27 Mar 2024 13:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711546749; cv=none; b=QUl1RzxPhambIt1i/AmQVo34nBAKAyHQr/zswh/otV2Egl6ZiqCr/cj9GVZcoCMKSf4jNYZoqN4q8KElzHgM3moTmYT8v2ndyMkAZAhLksOJK/YuGQzj6ZhSQHgBu25ffKh3MBM/ngg51zpRT3wknwXrY439xvNaNxhr+IqB5SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711546749; c=relaxed/simple;
	bh=qUFiWNXiUrR77Gv7KOV/6YydyP+bT/nhCwdUzTXgoWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijJZbnONTO/fxO8T99CdMcfhH4Kagnp0LG4t+ncqAvlaU79RC7gDU97+juQ0Cu2iKGCH6fOTfez0wLl8FZGrPLNnpHuFzIkJ0hG4BQZ2maDIKN3vKwe0X8/NiLZQyXeMe1lWzoyi89QYna005gEOW4KPrJzA53agqI6TSJU9ekk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=hQBohv5M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lXM24WwO; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id F41EB114013B;
	Wed, 27 Mar 2024 09:39:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 Mar 2024 09:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1711546745;
	 x=1711633145; bh=hFePx7NNk9uBLYJHp+RoxkcN879v2VFyWa6LPIRbuuQ=; b=
	hQBohv5Ml5iGIWhncp6Rz8mMnGwxGbpxIfeGporsTET/hqCfPO19S6XQaTDX5F6V
	ORQdj8e/gZSZieuG8x0BE54cjCZzSCWFbuTOx14iQp1pVOBt/XQU7IsmLPEnaKYB
	Hfj0v6QhhdwGn1INqI3cd9LrKPo3eyQMzHd69CjMi4a8QB8xq2HwvGuAEKxTWczV
	CS0BvFXzMkR5JPI5Tv5JU+00POpkEjl5wJeXt8w5SaN5BsUBFA/1/23DCZg0c4QY
	NIYnTcgCvegYqlVDynTVUHPG0Q8fMzQhtJPr2LSSHaSW3m4fxJ0B1+BWC9ZLgckT
	0FUGC6Q0oZtZPEzTRigK3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711546745; x=
	1711633145; bh=hFePx7NNk9uBLYJHp+RoxkcN879v2VFyWa6LPIRbuuQ=; b=l
	XM24WwO9dsLcc8MvC8RdkIpah3CWFB6oWjp0VV5CfEvNKS3eFIvCpTIjIRNPXXpr
	5Mm5kg4dlQwxzyZYYN2gG1lND2MKLpTbPUJYSHsMNf/1LegMLWltAtJe83hwApYV
	vlQ7REWmN1+Glifg/CoADv6wO28bDDkAoS6/wPgr1C28Ga9kkTJf9916+UigXanD
	1RHhDYpI03c0BGJl2oVuk3r8Ow/HEuf/FCq1HthxW3Fpt4xr2zJWZL9hCCpA8NKw
	BHJ94irZvtROQR8+zZHiXQK8Bsyz1brx0dbtScAZ6E1Xb24Rl+F6G1TVmmGNkD+U
	/wvB5VAkD0GJ6wMM0rkuA==
X-ME-Sender: <xms:eSEEZh1VmVc-Qh9pIuXUa9FYR9sg52o1LtZwctNhPOCkofyJ_6nSWw>
    <xme:eSEEZoFnc_PsSoC1o6eks8sYEFuJh3Wumw_HhO78Ihg-Fp1poXT8K5511a9XpeJHx
    7o1a14ddVpyug>
X-ME-Received: <xmr:eSEEZh5QbZeYzGrHcmGBQnFJpkMpJ1blZ_Ne9y710VEBvwfxRGduSIw2LMfxyV2MAeB4O1VIVFwydekKXu5sFsvKepGeGwgBuBdLcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduiedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeelke
    ehjeejieehjedvteehjeevkedugeeuiefgfedufefgfffhfeetueeikedufeenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:eSEEZu18EdSvRN8OWJqhwXCkw8Vy8MPWHRNkad5Ke_6wEUBhgREGfA>
    <xmx:eSEEZkHjbu5Uzcf75EyMLNbKJhYopxlw6vgqNVfKGS2Fq6qIQoQuqA>
    <xmx:eSEEZv_ENYTorHRTrxCcqEMyB6K8_wJS4PS2f_v4z2ESKGip_ivfEw>
    <xmx:eSEEZhmMk8kMX6bCcu8JIhhMzxIvlU74PHU74HRt2JAHlzMI62fefg>
    <xmx:eSEEZoGnm4HTlM18VtuHpdB_VaXi0s_GKLnzoazvpd-LIzLjw-_NiQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Mar 2024 09:39:04 -0400 (EDT)
Date: Wed, 27 Mar 2024 14:39:03 +0100
From: Greg KH <greg@kroah.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 5.15 110/317] arm64: dts: renesas: r8a779a0: Update to
 R-Car Gen4 compatible values
Message-ID: <2024032754-alias-frosted-0903@gregkh>
References: <20240324233458.1352854-1-sashal@kernel.org>
 <20240324233458.1352854-111-sashal@kernel.org>
 <CAMuHMdUK0YYELTN=JQDtGuYg03Em6c7kskpqUR0Y6NbNuR7hfQ@mail.gmail.com>
 <ZgMfbenM7Kav2BTJ@sashalap>
 <CAMuHMdUU0TYKhm3FkqjgrYQdS58oLPQJFPxYidjn0h-ZJ9qeFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdUU0TYKhm3FkqjgrYQdS58oLPQJFPxYidjn0h-ZJ9qeFg@mail.gmail.com>

On Wed, Mar 27, 2024 at 10:41:22AM +0100, Geert Uytterhoeven wrote:
> Hi Sasha,
> 
> On Tue, Mar 26, 2024 at 8:18 PM Sasha Levin <sashal@kernel.org> wrote:
> > On Mon, Mar 25, 2024 at 09:43:31AM +0100, Geert Uytterhoeven wrote:
> > >On Mon, Mar 25, 2024 at 12:36 AM Sasha Levin <sashal@kernel.org> wrote:
> > >> From: Geert Uytterhoeven <geert+renesas@glider.be>
> > >>
> > >> [ Upstream commit a1721bbbdb5c6687d157f8b8714bba837f6028ac ]
> > >>
> > >> Despite the name, R-Car V3U is the first member of the R-Car Gen4
> > >> family.  Hence update the compatible properties in various device nodes
> > >> to include family-specific compatible values for R-Car Gen4 instead of
> > >> R-Car Gen3:
> > >>   - DMAC,
> > >>   - (H)SCIF,
> > >>   - I2C,
> > >>   - IPMMU,
> > >>   - WDT.
> > >>
> > >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > >> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > >> Link: https://lore.kernel.org/r/73cea9d5e1a6639422c67e4df4285042e31c9fd5.1651497071.git.geert+renesas@glider.be
> > >> Stable-dep-of: 0c51912331f8 ("arm64: dts: renesas: r8a779a0: Correct avb[01] reg sizes")
> > >> Signed-off-by: Sasha Levin <sashal@kernel.org>
> > >> ---
> > >>  arch/arm64/boot/dts/renesas/r8a779a0.dtsi | 24 +++++++++++------------
> > >>  1 file changed, 12 insertions(+), 12 deletions(-)
> > >>
> > >> diff --git a/arch/arm64/boot/dts/renesas/r8a779a0.dtsi b/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
> > >> index 26899fb768a73..c7d1b79692c11 100644
> > >> --- a/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
> > >> +++ b/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
> > >> @@ -583,7 +583,7 @@ hscif3: serial@e66a0000 {
> > >>
> > >>                 avb0: ethernet@e6800000 {
> > >>                         compatible = "renesas,etheravb-r8a779a0",
> > >> -                                    "renesas,etheravb-rcar-gen3";
> > >> +                                    "renesas,etheravb-rcar-gen4";
> > >
> > >This change will break Ethernet, as the Renesas EtherAVB driver in
> > >v5.15.x does not handle "renesas,etheravb-rcar-gen4" yet.
> > >
> > >That can be fixed by also backporting commit 949f252a8594a860
> > >("net: ravb: Add R-Car Gen4 support") in v6.1.
> >
> > I'll just drop this patch instead, thanks!
> 
> Looks like it still made v5.15.153?
> The easiest fix is to backport 949f252a8594a860, too.

Now applied, thanks.

greg k-h

