Return-Path: <linux-kernel+bounces-67690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B879856F2E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE2411C21689
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC1513B7AA;
	Thu, 15 Feb 2024 21:18:04 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D2441C61;
	Thu, 15 Feb 2024 21:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708031884; cv=none; b=CGUZmc+bZFY42cuJezOs1UAYmPJeezhOqQoLlKJS4GjbUryEZAy3i0sIdrI14/sQ3NdFDhY+H2c0K8IDcA0pvzL+r8GXNfFoAY5dv3q7Hg54ZohmkeYjwrt/DghZb2Y7K0q24KaFZsfKaisvO477eX2EC3GD2hC5k3b131X8zVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708031884; c=relaxed/simple;
	bh=wKYFQJd0uZWlsl2zlOip9+kLfJKcOYvYrfvlJ8UN2uY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HD/NzGR2pKjF/ZNW/mWVe7OQD9PhgwoCiQeyMOLhF+Ui0Da2/ID8FjIglYSdAiSwhVxOVKr/48L4RAYrsDxRH+nV+DUP/v0WmXJR4W0A+VeMSwcw1mJtBGM2C5GmySjIJM5DM+eBjHgt2AGYKJRe6TWZB9vqbbFVmF19oaK85c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b6c.versanet.de ([83.135.91.108] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1raj73-0000Yz-48; Thu, 15 Feb 2024 22:17:45 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Conor Dooley <conor@kernel.org>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, sam@ravnborg.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, quentin.schulz@theobroma-systems.com,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Subject:
 Re: [PATCH 2/3] dt-bindings: display: ltk500hd1829: add variant compatible
 for ltk101b4029w
Date: Thu, 15 Feb 2024 22:17:43 +0100
Message-ID: <16747948.geO5KgaWL5@diego>
In-Reply-To: <20240215-boat-grid-d50f0eccec67@spud>
References:
 <20240215090515.3513817-1-heiko@sntech.de>
 <20240215090515.3513817-3-heiko@sntech.de>
 <20240215-boat-grid-d50f0eccec67@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Donnerstag, 15. Februar 2024, 18:06:06 CET schrieb Conor Dooley:
> On Thu, Feb 15, 2024 at 10:05:14AM +0100, Heiko Stuebner wrote:
> > From: Heiko Stuebner <heiko.stuebner@cherry.de>
> > 
> > Add the compatible for the ltk101b4029w panel, that is really similar
> > to the ltk500hd1829.
> 
> Please mention what makes the devices incompatible. "really similar" is
> vague and could be used for a device that was only cosmetically
> different.

ok, I'll modify the paragraph to:

=======
Add the compatible for the ltk101b4029w panel, that has the same
manufacturer, general bringup and supplies but a different dsi-init-
sequence as the ltk500hd1829 .
=======

> With that,
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Cheers,
> Conor.
> 
> > 
> > Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> > ---
> >  .../bindings/display/panel/leadtek,ltk500hd1829.yaml          | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/panel/leadtek,ltk500hd1829.yaml b/Documentation/devicetree/bindings/display/panel/leadtek,ltk500hd1829.yaml
> > index c5944b4d636c5..d589f16772145 100644
> > --- a/Documentation/devicetree/bindings/display/panel/leadtek,ltk500hd1829.yaml
> > +++ b/Documentation/devicetree/bindings/display/panel/leadtek,ltk500hd1829.yaml
> > @@ -14,7 +14,9 @@ allOf:
> >  
> >  properties:
> >    compatible:
> > -    const: leadtek,ltk500hd1829
> > +    enum:
> > +      - leadtek,ltk101b4029w
> > +      - leadtek,ltk500hd1829
> >    reg: true
> >    backlight: true
> >    reset-gpios: true
> 





