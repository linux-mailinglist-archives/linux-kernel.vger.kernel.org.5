Return-Path: <linux-kernel+bounces-78115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC664860F1A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D1C1B21DB9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CB55CDF2;
	Fri, 23 Feb 2024 10:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4dR1Hon"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02070D29B;
	Fri, 23 Feb 2024 10:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708683646; cv=none; b=rd2RRdtJRIbtw5TAxp/muF1jVax1JBy8A8tYJT9l2wh6ky9Y7IX0hZD+z9m1uHYs0pQaHI7Tcu/NNEnZdnRbho8BCZwD9jh9wmtTyFLtFht9zVULe80jcTIfPppWakNDMSQilM/ekdbsaOBZed/NulRWb11F3XJXR8WsapexiSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708683646; c=relaxed/simple;
	bh=Y++Qoouf/06I7Qr2MljkIDCSHYasSsdWAIyi4ziBcZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIRrpcB1Ui06JmLNe6bAEfBYF4f6mpzvrvKk1S9i/4TA7H8eWMQ1uI/6b5Z8MqHldOJExUENniBTBJks5Xj/qxAiYFe6Orwj/Qnzd6J/eomw/diTBSm1sHY1wyb4L7x6uyCNaUhx0gAZxPERPKpPX/nXYVJLxQcmQc8T9Nx1+gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4dR1Hon; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A64B7C433C7;
	Fri, 23 Feb 2024 10:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708683645;
	bh=Y++Qoouf/06I7Qr2MljkIDCSHYasSsdWAIyi4ziBcZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c4dR1HonarJ2lveceEyBRuzECpwTCRR8GvTwn7IS4afEFPc/VrOAxltBu5XM0IMSc
	 7O9f5aznQ2UshBu9vf/u3fCJChN4OzOqET5bRbntXvrqnoBcCELLnGOv3gLA5AafNd
	 mABJMBwYYNxHjL3/frTT9rRGdJrN3E9p4qOEnG17A1iq2kZGNq1j4wBlD88fkwHVn/
	 gQZTt3daxT6hmTeMVU7GPy7vofNurkEdVm4HVTGcrbBqQBcnZK5znMHf65TXMt6RsK
	 EpiWHsKEdQviQFuxSuBoiY8v5Q+w28JL4XHfRifQTWCwYwRzevU+BoYfYl+sMae+IG
	 e4FtJ7Sasr8Gg==
Date: Fri, 23 Feb 2024 10:20:39 +0000
From: Lee Jones <lee@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Stephen Boyd <swboyd@chromium.org>, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev, devicetree@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	Douglas Anderson <dianders@chromium.org>,
	Pin-yen Lin <treapking@chromium.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH 1/2] dt-bindings: cros-ec: Add properties for GPIO
 controller
Message-ID: <20240223102039.GK10170@google.com>
References: <20240219202325.4095816-1-swboyd@chromium.org>
 <20240219202325.4095816-2-swboyd@chromium.org>
 <CAMRc=Mft4R83NSknze0BMMvJd7Yz3yNGqaBSRVBePgh_S3QU1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mft4R83NSknze0BMMvJd7Yz3yNGqaBSRVBePgh_S3QU1g@mail.gmail.com>

On Tue, 20 Feb 2024, Bartosz Golaszewski wrote:

> On Mon, Feb 19, 2024 at 9:23 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > The ChromeOS embedded controller (EC) supports setting the state of
> > GPIOs when the system is unlocked, and getting the state of GPIOs in all
> > cases. The GPIOs are on the EC itself, so the EC acts similar to a GPIO
> > expander. Add the #gpio-cells and gpio-controller properties to the
> > cros-ec binding so that other devices described in DT can get the GPIOs
> > on the EC.
> >
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> > Cc: Conor Dooley <conor+dt@kernel.org>
> > Cc: Lee Jones <lee@kernel.org>
> > Cc: Benson Leung <bleung@chromium.org>
> > Cc: Guenter Roeck <groeck@chromium.org>
> > Cc: <devicetree@vger.kernel.org>
> > Cc: <chrome-platform@lists.linux.dev>
> > Cc: Pin-yen Lin <treapking@chromium.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  Documentation/devicetree/bindings/mfd/google,cros-ec.yaml | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> > index e1ca4f297c6d..aac8819bd00b 100644
> > --- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> > @@ -93,6 +93,11 @@ properties:
> >    '#size-cells':
> >      const: 0
> >
> > +  '#gpio-cells':
> > +    const: 2
> > +
> > +  gpio-controller: true
> > +
> >    typec:
> >      $ref: /schemas/chrome/google,cros-ec-typec.yaml#
> >
> > @@ -275,6 +280,8 @@ examples:
> >              interrupts = <99 0>;
> >              interrupt-parent = <&gpio7>;
> >              spi-max-frequency = <5000000>;
> > +            #gpio-cells = <2>;
> > +            gpio-controller;
> >
> >              proximity {
> >                  compatible = "google,cros-ec-mkbp-proximity";
> > --
> > https://chromeos.dev
> >
> 
> Applied, thanks!

Why are you applying this MFD patch?

-- 
Lee Jones [李琼斯]

