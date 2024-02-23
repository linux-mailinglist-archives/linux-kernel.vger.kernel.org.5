Return-Path: <linux-kernel+bounces-77774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D300D860A16
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F76F1C220FA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCAB11731;
	Fri, 23 Feb 2024 04:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQ2o3Tq8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5E1111B7;
	Fri, 23 Feb 2024 04:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708664200; cv=none; b=qogRkkNk9pzNLLnKmN8NRQcEJno8ufxe0rmIt38UdB0JC0gl73FYidt2VzFhRaGt7Lb8a30I3jxQ1EYJBhHvjPXcAoQuCs7YV+q3i/4y6arU8Q4fEjCaOhcykkU2CeuVpE5OJkUhnkAQ3hQPBUoWKJiR6OPWo3jAhCkVXxm4drc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708664200; c=relaxed/simple;
	bh=L8JdLJIOPT7SiDgt1sNgOXc6HQyxnRcj+oNXHWOfILY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GA+zIC9RQXiMcqvBUBhIZNvcCnjsZ/dt5yy6CAWSxJR9wpLyqLCrFbfLDwOQUkF2y4kU7mx6S9uNrJ3f2pEXJhb3E4RgxbQSFnUt/NP2p899zprzaRu9lwd39UVTTkATDZEfhjmJ9z5cHrkzW8eKV+1NlOpw7uR8Qh/Dqi18i8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQ2o3Tq8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C613C433C7;
	Fri, 23 Feb 2024 04:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708664199;
	bh=L8JdLJIOPT7SiDgt1sNgOXc6HQyxnRcj+oNXHWOfILY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mQ2o3Tq8wLW451fEuRAyWrxRjveeCXKHZ1+S1Ok1khINwFiaLvH7V9NdJlDILhHf8
	 XI7NcxUXo8up8b0ppbHK0Zm2Gg5B6mnoNnkHjDpleF8O4QDBRiIc/FvmoInPJVEDfC
	 YLb037PuZEWQp52/GQRGhEUGkfJbUoMKoP9zwnLZKpnEKgOUC2seApF3O6Y8ZiuSGo
	 U9sGqMEBzTIG1X3hxE/2+kCasSJru2XrT44kMFba7uPTQHflERxduzmIoj6fnwHIGr
	 1K6bob0JcNCSsQbwZLR7tkm2NEct7IqGYEhr5vc/HlgXAHX2cUwVgB7jFWeD8Ctp9r
	 O0WJHhrSly6qw==
Date: Thu, 22 Feb 2024 21:56:37 -0700
From: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Nikita Travkin <nikita@trvn.ru>, Sebastian Reichel <sre@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	cros-qcom-dts-watchers@chromium.org, Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: power: supply: Add Acer Aspire 1 EC
Message-ID: <20240223045637.GA3983053-robh@kernel.org>
References: <20240220-aspire1-ec-v3-0-02cb139a4931@trvn.ru>
 <20240220-aspire1-ec-v3-1-02cb139a4931@trvn.ru>
 <20240220-splinter-jackpot-ac1571af5b2d@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220-splinter-jackpot-ac1571af5b2d@spud>

On Tue, Feb 20, 2024 at 06:41:06PM +0000, Conor Dooley wrote:
> Rob,
> 
> On Tue, Feb 20, 2024 at 04:57:12PM +0500, Nikita Travkin wrote:
> > Add binding for the EC found in the Acer Aspire 1 laptop.
> > 
> > Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> > ---
> >  .../bindings/power/supply/acer,aspire1-ec.yaml     | 69 ++++++++++++++++++++++
> >  1 file changed, 69 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/power/supply/acer,aspire1-ec.yaml b/Documentation/devicetree/bindings/power/supply/acer,aspire1-ec.yaml
> > new file mode 100644
> > index 000000000000..984cf19cf806
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/supply/acer,aspire1-ec.yaml
> > @@ -0,0 +1,69 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/power/supply/acer,aspire1-ec.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Acer Aspire 1 Embedded Controller
> > +
> > +maintainers:
> > +  - Nikita Travkin <nikita@trvn.ru>
> > +
> > +description:
> > +  The Acer Aspire 1 laptop uses an embedded controller to control battery
> > +  and charging as well as to provide a set of misc features such as the
> > +  laptop lid status and HPD events for the USB Type-C DP alt mode.
> > +
> > +properties:
> > +  compatible:
> > +    const: acer,aspire1-ec
> > +
> > +  reg:
> > +    const: 0x76
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  acer,fn-selects-media-keys:
> > +    description: Configure the keyboard layout to invert the Fn key.
> > +      By default the function row of the keyboard inputs media keys
> > +      (i.e Vol-Up) when Fn is not pressed. With this option set, pressing
> > +      the key without Fn would input function keys (i.e. F11). The
> > +      firmware may choose to add this property when user selects the fn
> > +      mode in the firmware setup utility.
> > +    type: boolean
> 
> We both had some comments on this property, and Nikita tried to follow
> up on yours (which was much more substantive than mine) but got no
> response:
> https://lore.kernel.org/all/20231214220210.GA988134-robh@kernel.org/
> 
> Reading what you said, I'm not entirely sure what you were looking for,
> my guess is that you were wanted something controllable from userspace,
> but I'm not sure how you figured that should work where the firmware
> alone is able to control this.

I replied there, but what I want is whatever the solution is to work on 
any laptop, not just this Acer device.

Rob

