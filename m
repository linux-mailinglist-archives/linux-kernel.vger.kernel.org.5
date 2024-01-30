Return-Path: <linux-kernel+bounces-45033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D80D4842AC2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1692C1C21401
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33458129A60;
	Tue, 30 Jan 2024 17:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmWXiDzF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750E112836C;
	Tue, 30 Jan 2024 17:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706635319; cv=none; b=RHBbozkPZThP2GroBXYfvPNg5cRW64Z+EZlD6RuxJphMEj6o/3QLQdyFSVu8o6b+ZRovrIbB63alc9bc1ORb++0w10wo/pO+Ggx/J5vjbzIHpwMUPvEO0ElIgPExMxsOBufsi4RcyLMwk2ZvT/LTZry+OtJjKz05fO7Pmbr3Mq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706635319; c=relaxed/simple;
	bh=4wWtwu39k0xPKfG1c0t6Pd+ipT50TOdvHg/dYeAN4AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YwwzMr8M/5CyCABAldMX1xclvLtDQfNu6MkGEhs9QGHSMQaLRQV2EDMKl5ZdMxUfuivQIRISYrYNlU/bnOp/06SIumjCcwm8nR2YXUboBMq1sIrVtc5gGJtzqNrzIr4WAIXuYK1GFSEHUdmqRHMa2UOVhQ4z5Vc6mjjBXOeELzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmWXiDzF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB412C433F1;
	Tue, 30 Jan 2024 17:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706635318;
	bh=4wWtwu39k0xPKfG1c0t6Pd+ipT50TOdvHg/dYeAN4AY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kmWXiDzFUZWMZzmBpA4YYhgxS/sibS2eQcWpJvG1LA1+FZUYuc4kD2PbTzNoe036L
	 wYJKCwdrnHW7bBjNmXHyy8rgOVYVsejkz3nh71I0n3LOa/8TvyUVadKn8sCQ0gSJ/C
	 aAvDPnVAQKBuUw0wGxr97lIUE4fyGPbIWebRkfIiqV6jtg3Wsbn9wcJH4POQzdOiEq
	 woKbFV9NOfEOOFaAzQfCzXP/UzV33va2G+x2r0t1Q4XFJu1SYiUPYxLMZM7Qnh9ZyM
	 QRZw0o3pTGGHBr/CrZGen3PvVQRFXtsel6if2VsexK0EHc9ypSF3Qvz44AgM3qYOhc
	 9FELK1rhUbM1Q==
Date: Tue, 30 Jan 2024 11:21:56 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: remoteproc: Add compatibility for
 TEE support
Message-ID: <20240130172156.GA2008728-robh@kernel.org>
References: <20240118100433.3984196-1-arnaud.pouliquen@foss.st.com>
 <20240118100433.3984196-3-arnaud.pouliquen@foss.st.com>
 <75429209-8f30-4880-8f92-ecb3cf90ae33@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75429209-8f30-4880-8f92-ecb3cf90ae33@linaro.org>

On Fri, Jan 26, 2024 at 12:03:25PM +0100, Krzysztof Kozlowski wrote:
> On 18/01/2024 11:04, Arnaud Pouliquen wrote:
> > The "st,stm32mp1-m4-tee" compatible is utilized in a system configuration
> > where the Cortex-M4 firmware is loaded by the Trusted execution Environment
> > (TEE).
> > For instance, this compatible is used in both the Linux and OP-TEE
> > device-tree:
> > - In OP-TEE, a node is defined in the device tree with the
> >   st,stm32mp1-m4-tee to support signed remoteproc firmware.
> >   Based on DT properties, OP-TEE authenticates, loads, starts, and stops
> >   the firmware.
> > - On Linux, when the compatibility is set, the Cortex-M resets should not
> >   be declared in the device tree.
> > 
> > Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> > ---
> > V1 to V2 updates
> > - update "st,stm32mp1-m4" compatible description to generalize
> > - remove the 'reset-names' requirement in one conditional branch, as the
> >   property is already part of the condition test.
> > ---
> >  .../bindings/remoteproc/st,stm32-rproc.yaml   | 52 +++++++++++++++----
> >  1 file changed, 43 insertions(+), 9 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
> > index 370af61d8f28..6af821b15736 100644
> > --- a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
> > +++ b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
> > @@ -16,7 +16,12 @@ maintainers:
> >  
> >  properties:
> >    compatible:
> > -    const: st,stm32mp1-m4
> > +    enum:
> > +      - st,stm32mp1-m4
> > +      - st,stm32mp1-m4-tee
> 
> The patch looks good to me, but I wonder about this choice of two
> compatibles.
> 
> Basically this is the same hardware with the same interface, but two
> compatibles to differentiate a bit different firmware setup. We have
> already such cases for Qualcomm [1] [2] and new ones will be coming. [3]
> 
> I wonder whether this should be rather the same compatible with
> additional property, e.g. "st,tee-control" or "remote-control".
> 
> [1]
> https://elixir.bootlin.com/linux/v6.7.1/source/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml#L54
> 
> [2]
> https://elixir.bootlin.com/linux/v6.7.1/source/Documentation/devicetree/bindings/net/qcom,ipa.yaml#L129
> (that's a bit different)
> 
> [3] https://lore.kernel.org/linux-devicetree/20240124103623.GJ4906@thinkpad/
> 
> @Rob,
> Any general guidance for this and Qualcomm?

I think we have cases using compatible already as well. Either way is 
fine with me.

Rob

