Return-Path: <linux-kernel+bounces-77267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D858602C1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02C7E1C24426
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90935490D;
	Thu, 22 Feb 2024 19:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYUx/u7h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4DA14B82B;
	Thu, 22 Feb 2024 19:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708630606; cv=none; b=ptVIf8/S/ubl//M+ps6cXIlqIMZHDc6fbWPXbuOv5u+YZcBU1SJl1J6t/TLDSA+6XRI6KETfx9y27dfuzJEUw9Uab4c8XA9D9Z70DpZCI8dBX9AsVVe7CY+oa1GPRYi2kfli7cP91exZPDXlZ1mh+42pKXsvw+8mnactqxEHcv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708630606; c=relaxed/simple;
	bh=mimHLt883XdmFq/Wm0Rkx9D2WOF046CaBE6YY7gWH2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgQZJBTx58pErcHqLnpsQiHjlqyg/cmGaFqgdtChFtpJfUhyKvvH3bN0+FwuJrCv93dAvP2ZUrslirHhTHjx6b2+Mqv1yW36OpyBTWkslctwWyTm0TYDI6sUc1B8+83cim08/qUaIUwRMwz8cIrtFeXFKx0cZKb8V1PsOIFt3Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYUx/u7h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34538C433C7;
	Thu, 22 Feb 2024 19:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708630605;
	bh=mimHLt883XdmFq/Wm0Rkx9D2WOF046CaBE6YY7gWH2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JYUx/u7h25KDz8BfvyXWk5Tf63l5gzlGdWG7C8XiqHsI/6yue9cwssXR2nNZpWIwB
	 ExHMi7J9oCrTc+zR5MvO7AqoROap7Bo2JakJWx7x73uMKGtt0R2yH7O5a+iGZylPta
	 o4ptRFQjzoCDnLwqO18dAUhqBssmsY6Ousd0f/N7j+7ESSZDAHzxUAXvuBzE5l3oaS
	 yf2h+ncRZi+LXA/JGwkGqGPE3wwjhpK15Qt/057a7JfmYENTiPTrIVS7kgUvmQn2Sr
	 eTH2GFDoJCX7AIKDXzp0kJl+Q6+Q/xjum7G3dPR1zC8WhPm5O/J1+COxDVPliGM/uP
	 m5Lm4TY1NcDJQ==
Date: Thu, 22 Feb 2024 13:36:42 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Eric Lin <eric.lin@sifive.com>, Conor Dooley <conor@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 1/6] dt-bindings: cache: Document the
 sifive,perfmon-counters property
Message-ID: <20240222193642.GA3713418-robh@kernel.org>
References: <20240216000837.1868917-1-samuel.holland@sifive.com>
 <20240216000837.1868917-2-samuel.holland@sifive.com>
 <eeb2331d-10e6-4902-91ba-85896a8f0ee1@linaro.org>
 <72221da1-4a1a-4947-a202-9de203032f5c@sifive.com>
 <6ac4005b-01e6-48c2-971e-d6a127134d13@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ac4005b-01e6-48c2-971e-d6a127134d13@linaro.org>

On Sun, Feb 18, 2024 at 07:35:35PM +0100, Krzysztof Kozlowski wrote:
> On 18/02/2024 16:29, Samuel Holland wrote:
> > Hi Krzysztof,
> > 
> > On 2024-02-17 3:00 AM, Krzysztof Kozlowski wrote:
> >> On 16/02/2024 01:08, Samuel Holland wrote:
> >>> The SiFive Composable Cache controller contains an optional PMU with a
> >>> configurable number of event counters. Document a property which
> >>
> >> Configurable in what context? By chip designers or by OS? Why this
> >> cannot be deduced from the compatible?
> > 
> > This parameter is configurable by the chip designers.
> > 
> > The information certainly can be deduced from the SoC-specific compatible
> > string, but doing so makes the driver only work on that specific list of SoCs.
> 
> Usually that's exactly what's expected, so why here usual approach is wrong?
> 
> > When provided via a property, the driver can work without changes on any SoC
> > that uses this IP block. (None of the SoCs currently listed in the binding
> 
> Sorry, properties are not a work-around for missing compatibles.
> 
> > contain a PMU, so there is no backward compatibility concern with adding the new
> > property.)
> > 
> > My understanding of the purpose of the SoC-specific compatible string is to
> > handle eventualities (silicon bugs, integration quirks, etc.), not to
> > intentionally limit the driver to a narrow list of hardware.
> 
> Depends what is the hardware. For most of licensed blocks, the final
> design is the hardware so equals to its compatible.

While I generally agree, I think a property is fine here for 2 reasons. 

This is going to vary on just about every design. That's true for any 
PMU. So maybe this shouldn't even be SiFfive specific.

The second is counters available to the OS may not equal the number in 
h/w because counters could be reserved for different priviledge levels 
(secure, hypervisor, guest, etc.). No idea if Risc-V supports this, but 
if not it is a matter of time. That's more likely for a core PMU than an 
uncore PMU.

Rob

