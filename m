Return-Path: <linux-kernel+bounces-45014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDC1842A75
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18C22283C4D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C8112BF1B;
	Tue, 30 Jan 2024 17:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xn0xm2dy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB9382D8C;
	Tue, 30 Jan 2024 17:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706634388; cv=none; b=YKWO1FMdBoDjO0NOD8L84JkYT3gkFcX0UrwuaeoOBgt0xeIAudWrqGkMilrk6X6MzfAZaGRfpoxcZGIz4utQSzyA69mH7/pjskorZGlsOhu8ofdlT1VD6/gf/8LtkrC0/kcuWxX2sEnh7uuaFc8RWsbLFghIn7is41+sNRSnfek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706634388; c=relaxed/simple;
	bh=W7q1fsdzkaCUOnQPYx3OTuBUZH48Q7ZLU/F8ISrqV3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlwC951+Idn47V7JR0fKQ3cX1N1qPRlfCl9AF6a1hTht4m39t80IHJ/WoRybwuf7f3NZKhr2MtYOVLhSEL6RS7pJUGqRZLMqj5l5lYt/L3ZjoGoncfo4AHwbsO2pArk7nQMdaMd1EWBawLnwo3JRPagjeIKu5FmOvrV7lIvpVY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xn0xm2dy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61880C433F1;
	Tue, 30 Jan 2024 17:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706634387;
	bh=W7q1fsdzkaCUOnQPYx3OTuBUZH48Q7ZLU/F8ISrqV3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xn0xm2dyBaFOijOJCGeNsNaumXj3m4bgdli1OpyA6hzUGSY2J23SJXRTLYmkx6CT2
	 LwP8PRUlqyobXdzoRrDSQMPHENr4J7m6a62jelmwlqTz2MAEuytStBU5urdHtyXyZV
	 LnEyX7n05ya7BQR3SOgVQyxPEVTPDujRmm+65JxqHo1GL2Qfqj7mbmq409iGuN1nT5
	 cECBQ5IswOLmDuolUEQpGDE5GNRGqPIyG94Lk8rAMBhFsp6RbLsyatZJidW2Y12Yit
	 VSTJ6hbJp9DcHNk2rvGxLmsdWXBiuNI9oQ7lOWxWgBLcm9j7n+Gw1AMu9YHFZMWXY3
	 TVUVU3QX6tFWg==
Date: Tue, 30 Jan 2024 11:06:25 -0600
From: Rob Herring <robh@kernel.org>
To: David Heidelberg <david@ixit.cz>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: opp: switch inner and outer min/maxItems
 rules for opp-hz
Message-ID: <20240130170625.GA1847581-robh@kernel.org>
References: <20231229191038.247258-1-david@ixit.cz>
 <2c9e91c7-8588-4260-8f5d-22c822019f62@linaro.org>
 <20240102235815.GA3700567-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102235815.GA3700567-robh@kernel.org>

On Tue, Jan 02, 2024 at 04:58:15PM -0700, Rob Herring wrote:
> On Sat, Dec 30, 2023 at 03:17:21PM +0100, Krzysztof Kozlowski wrote:
> > On 29/12/2023 20:10, David Heidelberg wrote:
> > > Fixes issue as:
> > > ```
> > 
> > Drop, it's not RST, but commit msg.
> > 
> > > arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dtb: opp-table: opp-200000000:opp-hz:0: [200000000, 0, 0, 150000000, 0, 0, 0, 0, 300000000] is too long
> > > ```
> > > 
> > > Fixes: 3cb16ad69bef ("dt-bindings: opp: accept array of frequencies")
> > > 
> > > Signed-off-by: David Heidelberg <david@ixit.cz>
> > > ---
> > >  Documentation/devicetree/bindings/opp/opp-v2-base.yaml | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> > > index e2f8f7af3cf4..86d3aa0eb435 100644
> > > --- a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> > > +++ b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> > > @@ -55,10 +55,9 @@ patternProperties:
> > >            to relate the values to their clocks or the order in which the clocks
> > >            need to be configured and that is left for the implementation
> > >            specific binding.
> > > -        minItems: 1
> > > -        maxItems: 32
> > >          items:
> > > -          maxItems: 1
> > > +          minItems: 1
> > > +          maxItems: 32
> > 
> > This does not look like correct fix. The original code looked fine -
> > only one item is allowed in each sub-element (array).
> 
> This one is special being 64-bit values so we have an exception in 
> property-units.yaml. The constraints here don't get used in decoding the 
> dtb and the default way of 1 outer element is used.
> 
> It doesn't look like opp-hz needs to be a matrix as it is really just an 
> array. Perhaps it should just be changed to an array type. 
> Alternatively, adding 'items: { maxItems: 1 }' to the definition in 
> property-units.yaml fixes the issue as well.
> 
> Though we can fix this, I'm looking into if we have other cases where we 
> need this to work as-is. There's probably some room for improvement in 
> how matrix dimensions are handled.

I've made some improvements on matrix dimensions, but this one is still 
an issue. Can you respin this dropping 'items: {maxItems: 1}'. I'm going 
to change the definition in property-units.yaml to uint64-array.

Rob

