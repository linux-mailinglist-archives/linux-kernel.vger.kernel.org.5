Return-Path: <linux-kernel+bounces-110096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE068859F8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C12A1F21891
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5632E84A4D;
	Thu, 21 Mar 2024 13:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPnRGmSi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9828083CC9;
	Thu, 21 Mar 2024 13:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711027973; cv=none; b=ByXATUIALwCwaLIg/uBvHmFbR2u+a5wEe4uipyRA37UdMJm2V2gsUteeaJ8ZTOBFzYp/ZR99PjaoRiuCJ7cOvc7EuEIeHgWgtgf590+seru26WZQP4EPVpubaygurXIkS1htB3WZcBi3fz4c8nXfThufZHa19ybcgOVy0wZ/B1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711027973; c=relaxed/simple;
	bh=U4+3vwCSjy3fEIwZBChHYsiJozqRlEPMAlHzlGK6vwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6k2qel1ktunGQwQmD17KzXFWGnUTqu9+pmEWmOFqAWCsMQtJxtjZ8GLtDEo4ZMskKAkNv5EkPXulOW1MhIyb/HhjzJ/dT4fi1weV1aQuC6iPyx4wRLupRFLru22QtsoBK8okZ5ApR0IhabA1mf1fP+NyqSUQIniNg4ffyiIQhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPnRGmSi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0068DC433F1;
	Thu, 21 Mar 2024 13:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711027973;
	bh=U4+3vwCSjy3fEIwZBChHYsiJozqRlEPMAlHzlGK6vwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SPnRGmSiHpVQdgumJveGdl+QUflxSvzlU5oJDsw+78Qtdme49Ewn95IHMy4AzuPXd
	 f0gXOu3eFmBNiWhwl+jnx2dAsinb8BvP9i86Pj4jPLZ4Zaj0swaHoZEnKDAh3IVkEU
	 OfDvosEWyjTVDRtJdW74w2FltY0HdxzG4Srx9AWCfgahhyRG0nUoZz3Wo/iFEORTrK
	 jVCU5FMScrKgkfxwLVPovuWoF9ewSW/jfxz7GlSLbZvuL8JZ46AN7L2whVVzLSF6IF
	 8/vRkD3LwKvjGEEN1wUuQexKET3qPp96DNWWXMd46mqE6f+VvRrK71P8IXWnxecP2q
	 LUN7NXf9m3jaQ==
Date: Thu, 21 Mar 2024 08:32:50 -0500
From: Rob Herring <robh@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sudan Landge <sudanl@amazon.com>, tytso@mit.edu, Jason@zx2c4.com,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	sathyanarayanan.kuppuswamy@linux.intel.com, thomas.lendacky@amd.com,
	dan.j.williams@intel.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, graf@amazon.de, bchalios@amazon.es,
	xmarcalx@amazon.co.uk, ardb@kernel.org,
	benh <benh@kernel.crashing.org>
Subject: Re: [PATCH v1 0/4] virt: vmgenid: Add devicetree bindings support
Message-ID: <20240321133250.GA1600070-robh@kernel.org>
References: <20240319143253.22317-1-sudanl@amazon.com>
 <23692c07-98bd-477d-b244-bba14c50352c@linaro.org>
 <38aad6c0e698c8e804694276d1762d61f2068ce8.camel@infradead.org>
 <20240320161531.GA1810860-robh@kernel.org>
 <60404403932a984d1f75d111ff53b9053af03579.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60404403932a984d1f75d111ff53b9053af03579.camel@infradead.org>

On Wed, Mar 20, 2024 at 04:55:45PM +0000, David Woodhouse wrote:
> On Wed, 2024-03-20 at 11:15 -0500, Rob Herring wrote:
> > On Wed, Mar 20, 2024 at 01:50:43PM +0000, David Woodhouse wrote:
> > > On Tue, 2024-03-19 at 16:24 +0100, Krzysztof Kozlowski wrote:
> > > > On 19/03/2024 15:32, Sudan Landge wrote:
> > > > > This small series of patches aims to add devicetree bindings support for
> > > > > the Virtual Machine Generation ID (vmgenid) driver.
> > > > > 
> > > > > Virtual Machine Generation ID driver was introduced in commit af6b54e2b5ba
> > > > > ("virt: vmgenid: notify RNG of VM fork and supply generation ID") as an
> > > > > ACPI only device.
> > > > > We would like to extend vmgenid to support devicetree bindings because:
> > > > > 1. A device should not be defined as an ACPI or DT only device.
> > 
> > This (and the binding patch) tells me nothing about what "Virtual 
> > Machine Generation ID driver" is and isn't really justification for 
> > "why".
> 
> It's a reference to a memory area which the OS can use to tell whether
> it's been snapshotted and restored (or 'forked'). A future submission
> should have a reference to something like
> https://www.qemu.org/docs/master/specs/vmgenid.html or the Microsoft
> doc which is linked from there.

That doc mentions fw_cfg for which we already have a binding. Why can't 
it be used/extended here?

Rob

[1] https://www.kernel.org/doc/Documentation/devicetree/bindings/firmware/qemu%2Cfw-cfg-mmio.yaml

