Return-Path: <linux-kernel+bounces-65354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1533854BC1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EC19B22218
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0755B03A;
	Wed, 14 Feb 2024 14:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xoeUcrDv"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4A4535DA;
	Wed, 14 Feb 2024 14:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707921878; cv=none; b=K/Zr3CPkxjrSBUISYnllwGHne/vQbBK5pflhawXYbr1ehnTwesGcxXQP3tmURahrpN1QTumJNPov+GG3fOrWsWIOd4/yV+ydfKT12eR2HKhHQRuxfeCEPlU9jlRhdI6hodTucKHGrb+aSHnk913CcmqsEeeB9w3MIm8Ze5lIx24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707921878; c=relaxed/simple;
	bh=/aCJdNcQ2gUxVbvYr+aiPG/bK475wx4EPI5asZy5xw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7gFScb9CIwF+mGJPkEba9SjaOt3T0lrfeNLRxv0yMd9mtCIFVCESn+mRZsn4uXSJqcXSQ8u97Qex2tKEacz2tWVajno5oQcQyuT3TCilXfjpTzBxqRSTbpSwUnOW5SKKFoyamQOsePQMIeYIU7CuSv+5xbquCHE42ZwdTobDkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xoeUcrDv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0tpb0RNPezxVKElZqD1Rek43u032J0ugCVH6syrQd1I=; b=xoeUcrDvq4K+OUZK+djhAC7gJ1
	11TLVVHjWpUL4i6Z6jFB971SBtiREh9bHQ/wNyHswz2ICvD7uGd2px2KTu/3+0e0xca47GMxoE1wA
	BMlc076ALUy9PHehfLJpfAiWjvdKIj5d7ccFN3wWgrUDJSO65JXRZkOh413JJSdRrLYk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1raGV5-007nGX-4G; Wed, 14 Feb 2024 15:44:39 +0100
Date: Wed, 14 Feb 2024 15:44:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/8] clk: qcom: ipq5332: enable few nssnoc clocks in
 driver probe
Message-ID: <17e2400e-6881-4e9e-90c2-9c4f77a0d41d@lunn.ch>
References: <20240122-ipq5332-nsscc-v4-0-19fa30019770@quicinc.com>
 <20240122-ipq5332-nsscc-v4-2-19fa30019770@quicinc.com>
 <7a69a68d-44c2-4589-b286-466d2f2a0809@lunn.ch>
 <11fda059-3d8d-4030-922a-8fef16349a65@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11fda059-3d8d-4030-922a-8fef16349a65@quicinc.com>

On Wed, Feb 14, 2024 at 02:49:41PM +0530, Kathiravan Thirumoorthy wrote:
> 
> 
> On 1/26/2024 1:35 AM, Andrew Lunn wrote:
> > On Mon, Jan 22, 2024 at 11:26:58AM +0530, Kathiravan Thirumoorthy wrote:
> > > gcc_snoc_nssnoc_clk, gcc_snoc_nssnoc_1_clk, gcc_nssnoc_nsscc_clk are
> > > enabled by default and it's RCG is properly configured by bootloader.
> > 
> > Which bootloader? Mainline barebox?
> 
> 
> Thanks for taking time to review the patches. I couldn't get time to respond
> back, sorry for the delay.
> 
> I was referring to the U-boot which is delivered as part of the QSDK. I will
> call it out explicitly in the next patch.

I've never used QSDK u-boot, so i can only make comments based on my
experience with other vendors build of u-boot. That experience is, its
broken for my use cases, and i try to replace it as soon as possible
with upstream.

I generally want to TFTP boot the kernel and the DT blob. Sometimes
vendor u-boot has networking disabled. Or the TFTP client is
missing. If it is there, the IP addresses are fixed, and i don't want
to modify my network to make it compatible with the vendor
requirements. If the IP addresses can be configured, sometimes there
is no FLASH support so its not possible to actually write the
configuration to FLASH so that it does the right thing on reboot
etc...

Often the vendor u-boot is a black box, no sources. Can you give me a
git URL for the u-boot in QSDK? If the sources are open, i could at
least rebuild it with everything turned on.

But still, it is better that Linux makes no assumptions about what the
boot loader has done. That makes it much easier to change the
bootloader.

> > > Some of the NSS clocks needs these clocks to be enabled. To avoid
> > > these clocks being disabled by clock framework, drop these entries
> > > from the clock table and enable it in the driver probe itself.
> > 
> > If they are critical clocks, i would expect a device to reference
> > them. The CCF only disabled unused clocks in late_initcall_sync(),
> > which means all drivers should of probed and taken a reference on any
> > clocks they require.
> 
> 
> Some of the NSSCC clocks are enabled by bootloaders and CCF disables the
> same (because currently there are no consumers for these clocks available in
> the tree. These clocks are consumed by the Networking drivers which are
> being upstreamed).

If there is no network drivers, you don't need clocks to the
networking hardware. So CCF turning them off seems correct.

Once you have actual drivers, this should solve itself, the drivers
will consume the clocks.

> However looking back, gcc_snoc_nssnoc_clk, gcc_snoc_nssnoc_1_clk,
> gcc_nssnoc_nsscc_clk are consumed by the networking drivers only. So is it
> okay to drop these clocks from the GCC driver and add it back once the
> actual consumer needs it?

But why should you remove them. If nothing is using them, they should
be turned off.

   Andrew

