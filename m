Return-Path: <linux-kernel+bounces-14988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C59F8225BF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 00:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8632D283E70
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 23:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6769A17981;
	Tue,  2 Jan 2024 23:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqKXyvap"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A893817980;
	Tue,  2 Jan 2024 23:58:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B06C433C9;
	Tue,  2 Jan 2024 23:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704239897;
	bh=Dbcu2HMKJdgZOFIcgm2z6JbgCtq1iCqB4x9KNyEY55s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QqKXyvapVjE9s3RZop7zgv7u/8fP9h+EKsC6yP3Pg1o5Z4T2tNaljwwv+Olm+9LIK
	 HDhJvTRCWf3yf7y2A2mONyEk5K/VHW1xM4oTg+eoYDBzAW97t4OEBW2l+oC8eub58y
	 gxUbyhwfFtmQfryQs98cSA9fplQKteA5qkTgk559Rtw4olfEJi0dtU9SP4JDrm3Sgn
	 999Oqf8F9g1Ff0eV8+52uxUKrek6KPT95kooSqg47nRa2P/K7MlALm5sMJoikBHoar
	 TQ3ftFH/0NLR7MJNE+iKEIwsTRlIdg2Bx6Ab7SBWtO8izUBaWPF+ZCV3bX12E3uxxi
	 KxjPWm/qsNn1w==
Received: (nullmailer pid 3968482 invoked by uid 1000);
	Tue, 02 Jan 2024 23:58:15 -0000
Date: Tue, 2 Jan 2024 16:58:15 -0700
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: David Heidelberg <david@ixit.cz>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: opp: switch inner and outer min/maxItems
 rules for opp-hz
Message-ID: <20240102235815.GA3700567-robh@kernel.org>
References: <20231229191038.247258-1-david@ixit.cz>
 <2c9e91c7-8588-4260-8f5d-22c822019f62@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c9e91c7-8588-4260-8f5d-22c822019f62@linaro.org>

On Sat, Dec 30, 2023 at 03:17:21PM +0100, Krzysztof Kozlowski wrote:
> On 29/12/2023 20:10, David Heidelberg wrote:
> > Fixes issue as:
> > ```
> 
> Drop, it's not RST, but commit msg.
> 
> > arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dtb: opp-table: opp-200000000:opp-hz:0: [200000000, 0, 0, 150000000, 0, 0, 0, 0, 300000000] is too long
> > ```
> > 
> > Fixes: 3cb16ad69bef ("dt-bindings: opp: accept array of frequencies")
> > 
> > Signed-off-by: David Heidelberg <david@ixit.cz>
> > ---
> >  Documentation/devicetree/bindings/opp/opp-v2-base.yaml | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> > index e2f8f7af3cf4..86d3aa0eb435 100644
> > --- a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> > +++ b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> > @@ -55,10 +55,9 @@ patternProperties:
> >            to relate the values to their clocks or the order in which the clocks
> >            need to be configured and that is left for the implementation
> >            specific binding.
> > -        minItems: 1
> > -        maxItems: 32
> >          items:
> > -          maxItems: 1
> > +          minItems: 1
> > +          maxItems: 32
> 
> This does not look like correct fix. The original code looked fine -
> only one item is allowed in each sub-element (array).

This one is special being 64-bit values so we have an exception in 
property-units.yaml. The constraints here don't get used in decoding the 
dtb and the default way of 1 outer element is used.

It doesn't look like opp-hz needs to be a matrix as it is really just an 
array. Perhaps it should just be changed to an array type. 
Alternatively, adding 'items: { maxItems: 1 }' to the definition in 
property-units.yaml fixes the issue as well.

Though we can fix this, I'm looking into if we have other cases where we 
need this to work as-is. There's probably some room for improvement in 
how matrix dimensions are handled.

Rob

