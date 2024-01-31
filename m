Return-Path: <linux-kernel+bounces-46581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFE3844192
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F21271F273F8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6945E7F48F;
	Wed, 31 Jan 2024 14:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LN4XxyPn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A753D762DD;
	Wed, 31 Jan 2024 14:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706710505; cv=none; b=umIcJ8VGCWyCuO5bP68qjIGoUm67CHy30lGHcxnfc56CppI1DGJjvAy2ictxlREFW1YX7hupgDPg/ZWFbnF6DlUKG/RUox8W+riIq8QtjTOqhVPDD9+peF6vS2r06OXyiFe0c2mcc5VDBIvoGsdKefL9kptjOJFOOhZQuywFQCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706710505; c=relaxed/simple;
	bh=ab7imJk06Aq8BClWfw1+COONXRv86lAFnRitwwNKZ20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UoF+RFR1CdjEJ5X7UKf2N8FgrrXLCsNBavsG6BOqhIM39Ze33XrDDUTyOjnUii5fg1p04vIBrzU2K38V1BQSQzdl2LL9obtcCVrsC31kBnwy90acyrfrz7/BYsqdBFCujQbV2P41bywDNJnnrgr0P3jdTzBux1NB60XL8X1+Ckw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LN4XxyPn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D88C433F1;
	Wed, 31 Jan 2024 14:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706710505;
	bh=ab7imJk06Aq8BClWfw1+COONXRv86lAFnRitwwNKZ20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LN4XxyPnvDNtHC5lLts6xq3PdjkeOuf8MF48OfdOSQY/zB/xqrre8HfU2YaMN14v+
	 70AGSIrkyCGfsl9ux3ydXKr9qvlLKvCUdO4/HcOSGwAxl2HMilm6TiIMEh1g07TDev
	 fkvpNwJWUZjoRlPhVDX2MeX6pwdcCL6+LUtR+hHNfrgD0tVgtYGH2Gx7ERn38OPI/d
	 o/G9Uuky2iBd8LgQe08BH2b1xxC/l16Zclk17U3uqbXiFAxWXyq9mqhg9gtMqu/Xex
	 t8Wzi7FdxwNfrudlpUKCV9Z9Ghk0tVSNOUonihMmMYIpoP7lav9vo05XeUdTCm2S+O
	 lyk5CAaD5Q+zw==
Date: Wed, 31 Jan 2024 08:15:02 -0600
From: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Johan Jonker <jbx6244@gmail.com>, hjc@rock-chips.com, heiko@sntech.de,
	andy.yan@rock-chips.com, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, airlied@gmail.com, daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
	mripard@kernel.org, markyao0591@gmail.com,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/6] dt-bindings: display: rockchip: rockchip,dw-hdmi:
 deprecate port property
Message-ID: <20240131141502.GB966672-robh@kernel.org>
References: <6626d288-ecf1-436b-b0a3-3417308a8633@gmail.com>
 <20240130-denim-capacity-e1617595ac9f@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130-denim-capacity-e1617595ac9f@spud>

On Tue, Jan 30, 2024 at 06:18:49PM +0000, Conor Dooley wrote:
> On Tue, Jan 30, 2024 at 03:55:43PM +0100, Johan Jonker wrote:
> > The hdmi-connector nodes are now functional and the new way to model
> > hdmi nodes with, so deprecate the port property and
> 
> This doesn't really explain what makes having hdmi-connector nodes
> replace the usecase for "port".
> 
> > make port@0 and
> > port@1 a requirement.
> 
> Why?

That means the deprecated way will always have warnings which makes 
documenting the deprecated stuff a bit pointless. Technically, new 
required properties are ABI break and something I'm working on making 
the tools check (by comparing 2 versions of schemas). That said, if all 
the upstream dts files are fixed already, then I don't care too much.


> > Also update example.
> 
> "Also do x" is a red flag when it comes to commit messages, as it
> immediately makes me think that this should be more than one commit.
> I'd probably write this as "Update the example to avoid use of the
> deprecated property" or something to avoid bad gut reactions.
> That's not worth resending for though obviously...
> 
> > 
> > Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> > ---
> >  .../display/rockchip/rockchip,dw-hdmi.yaml    | 27 ++++++++++++++++---
> >  1 file changed, 23 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml
> > index 7e59dee15a5f..cd0a42f35f24 100644
> > --- a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml
> > +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml
> > @@ -97,8 +97,11 @@ properties:
> >    ports:
> >      $ref: /schemas/graph.yaml#/properties/ports
> > 
> > -    patternProperties:
> > -      "^port(@0)?$":
> > +    properties:
> > +      port:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        deprecated: true
> 
> This change makes the deprecated property's description incomplete,
> since it doesn't cover the endpoints any more. It also doesn't make
> port@0 and port mutually exclusive.

graph.yaml has a check that effectively does that.

Rob

