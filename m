Return-Path: <linux-kernel+bounces-60473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA27C850567
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCA541C2402E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 16:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E7F5C909;
	Sat, 10 Feb 2024 16:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3zLzifv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3F95C8E2;
	Sat, 10 Feb 2024 16:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707583614; cv=none; b=OxzdQVyHKRxYPvsKK2wNj2reR89B1fxJdcgJIGzMeeJ5Te2a5+vtJOtTB1NdTCi9JBXqMHXO8PUMTTOg9PC42OpolrJYRwPFnZOHA3q1fi2g3fvjMVrHxZ9cxUg/a4eWijkevVrAecjTEgojOhSrF6ia9aiMIFrdDuy8X+wusdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707583614; c=relaxed/simple;
	bh=3XLFL1ro5i0dI0fsCV0D+QJ/wvNwCKeAITScA7QxGRo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BHc4Ry5vgqRKrMa9aFYYmIYNoWdrtJRkTufQuh9m7JlQYMHF5FgN+3xOMOBrVxlQhOpCrPK/1scJEBn5JiIlcsp3AiPIe33jDWT13ujoJHlihbLk+zEcgQLpdr5Ae4AnhYI+3HMkKJHC5QmsbLKGLob/bYqdTn7pUfzdZsRENSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3zLzifv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16861C433C7;
	Sat, 10 Feb 2024 16:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707583613;
	bh=3XLFL1ro5i0dI0fsCV0D+QJ/wvNwCKeAITScA7QxGRo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I3zLzifvvXbdRWEhANCGAmbhDCJUTtnTroSEO+mveCKSTifkr1iWNNMkxB3fCPEcJ
	 +A28YxSdeZXYqFBOqMla3/KlT70zceA8dd8DYPqdGdPlkZSuLAlBdlcP2/mdUx9F1Q
	 BNWeP+WKQKWL9oHig2vo5grFKS+vy577NmGzKu/sQYLydMBjcnSVg9aCXk9138JlaQ
	 H9RdyESooTeE/ICtorve0n/nJMsI0UtAV90fsShKLGkx7zFsUOwH4s8ChR08pS1oMu
	 ctF/8isL7rc6xEQgr1jrfJ/I/JtslsWnbrETvXm+u8ZjK9qVy95x380BnnKZYj489/
	 pIzanpGLPmVTQ==
Date: Sat, 10 Feb 2024 16:46:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Naresh Solanki <naresh.solanki@9elements.com>, Peter Rosin
 <peda@axentia.se>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 mazziesaccount@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: iio: afe: voltage-divider: Add
 io-channel-cells
Message-ID: <20240210164641.52631ce6@jic23-huawei>
In-Reply-To: <20240206-washboard-sustained-990e97d86d78@spud>
References: <20240206105502.648255-1-naresh.solanki@9elements.com>
	<20240206-washboard-sustained-990e97d86d78@spud>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Feb 2024 15:22:29 +0000
Conor Dooley <conor@kernel.org> wrote:

> On Tue, Feb 06, 2024 at 04:25:01PM +0530, Naresh Solanki wrote:
> > Enable the voltage divider to both receive and provide measurement
> > services by adding #io-channel-cells.
> > 
> > This is especially valuable in scenarios where an ADC has an analog
> > frontend, like a voltage divider, and obtaining its raw value isn't
> > interesting. It is desired to get the real voltage before the voltage
> > divider.
> > 
> > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>  
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Thanks for adding the example. I have one comment about the wording, cos
> the last sentence doesn't really make sense without something referring
> back to the scenario you describe.
> 
> > ---
> >  .../devicetree/bindings/iio/afe/voltage-divider.yaml  | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml b/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
> > index dddf97b50549..fd3c511e1beb 100644
> > --- a/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
> > +++ b/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
> > @@ -39,6 +39,17 @@ properties:
> >      description: |
> >        Channel node of a voltage io-channel.
> >  
> > +  '#io-channel-cells':
> > +    description:
> > +      In addition to consuming the measurement services of a voltage
> > +      output channel, the voltage divider can act as a provider of
> > +      measurement services to other devices. This is particularly
> > +      useful in scenarios wherein an ADC has an analog frontend,
> > +      such as a voltage divider, and then consuming its raw value
> > +      isn't interesting.  
> 
> > It is desired to get the real voltage
> > +      before the voltage divider.  
> 
> "In this case, the voltage before the divider is desired".
> 
> Perhaps Jonathan can make that change, provided you are okay with it.
I've made the change and applied this patch. Given it will only initially
be pushed out for 0-day to take a look at it, feel free to shout if you'd
prefer different wording from Conor's suggestion.

Thanks,

Jonathan

> 
> Cheers,
> Conor.
> 
> > +    const: 1
> > +
> >    output-ohms:
> >      description:
> >        Resistance Rout over which the output voltage is measured. See full-ohms.
> > 
> > base-commit: 99bd3cb0d12e85d5114425353552121ec8f93adc
> > -- 
> > 2.42.0
> >   


