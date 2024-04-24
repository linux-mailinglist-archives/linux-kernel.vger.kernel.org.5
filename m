Return-Path: <linux-kernel+bounces-156492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB628B0340
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EF6FB26FCD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1185A1581E7;
	Wed, 24 Apr 2024 07:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbuj7NU9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3144843AB4;
	Wed, 24 Apr 2024 07:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713944076; cv=none; b=CI8Y6/aKd7RTfF8PwXc3+0WFDrZhVtkT93ksoitIAOD599/f90CL7Yr4c/b4uYFC3Mj33ok0N+INJrtd3UoR8Kbwmuz17liYOpaVm6ISHfXKYGkrUl0K9O+2Q1ehdqcdwlDoqyc9FsJf2MCzyxvKpDDxWjmdmM6RZDSrSbCSkhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713944076; c=relaxed/simple;
	bh=4R8VP2bGGUbK1I5I9LZAEojch3kkDKH4jZ7h7qyv9+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+aaPaSZ48yIbGU/JGtym2BvcIG+d9HSfm9qUhP+27U8yB/TKC5SAlfBUBbXCtXenZBQtCK/aX/dExu6wiei8M4NFNtyu7gQURh12/6fWf+CSf0L0UKIZ4p7CTo+hc0+zWap43+AFmyjykf1SsIMB1OJw9ja9lT6b5n/jO2jqo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbuj7NU9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B791DC113CE;
	Wed, 24 Apr 2024 07:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713944075;
	bh=4R8VP2bGGUbK1I5I9LZAEojch3kkDKH4jZ7h7qyv9+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sbuj7NU9trItTQqHFFuDzeiFFNiA6rmQONe7ZJ6/5Q+CYmvxNSRe2GRnzPS2RScBs
	 VH7HMU6/afnaFoLL6cYxfI2MnEqU/WknUBvfP+SEoaDK97DRE/UOWVgOPKQPWorfYh
	 j9wIrQJnhfeIg5hx4B57F5rUdNG0FzaCyW0AyKFvBSJoC9O/FgvsdXiCDfKkaeiUpC
	 JLiE/XiM5epgpFVHJKV4heEWipxlNmkzhbcGX2VSJlgfmqJm75AV4a76yZDDogaI4v
	 UZgcJxYWZbiBuNZKwDNs2LZhh01i59ILyR6BsK26zR9fQVNkwcZOp+nCYEBzWU0JYO
	 ZvYADlGsepF7A==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rzX9F-000000000aO-2nW1;
	Wed, 24 Apr 2024 09:34:34 +0200
Date: Wed, 24 Apr 2024 09:34:33 +0200
From: Johan Hovold <johan@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] dt-bindings: HID: i2c-hid: elan: add
 'no-reset-on-power-off' property
Message-ID: <Zii2CUeIyBwxzrBu@hovoldconsulting.com>
References: <20240423134611.31979-1-johan+linaro@kernel.org>
 <20240423134611.31979-4-johan+linaro@kernel.org>
 <2e67e4e6-83a7-4153-b6a7-cdec0ab2c171@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e67e4e6-83a7-4153-b6a7-cdec0ab2c171@kernel.org>

On Tue, Apr 23, 2024 at 06:29:44PM +0200, Krzysztof Kozlowski wrote:
> On 23/04/2024 15:46, Johan Hovold wrote:
> > When the power supply is shared with other peripherals the reset line
> > can be wired in such a way that it can remain deasserted regardless of
> > whether the supply is on or not.
> 
> To clarify: the reset line is still present and working in such case?

Yes.

> > This is important as it can be used to avoid holding the controller in
> > reset for extended periods of time when it remains powered, something
> > which can lead to increased power consumption. Leaving reset deasserted
> > also avoids leaking current through the reset circuitry pull-up
> > resistors.
> > 
> > Add a new 'no-reset-on-power-off' devicetree property which can be used
> > by the OS to determine when reset needs to be asserted on power down.
> > 
> > Note that this property can also be used when the supply cannot be
> > turned off by the OS at all.

> >    reset-gpios:
> >      description: Reset GPIO; not all touchscreens using eKTH6915 hook this up.
> >  
> > +  no-reset-on-power-off:
> 
> Missing vendor prefix. Unless you want to re-use existing property
> "keep-power-in-suspend", but the case here mentions power off, not suspend.

No, I left out the prefix on purpose as I mentioned in the cover letter.
There is nothing vendor specific about this property and I expect it to
be reused for other devices.

And "keep-power-in-suspend" is too specific and indeed looks like
instruction to the OS rather than hw description (more below), but
importantly it is not related to the problem here (which is about
reset, not power).
 
> Anyway, the property sounds like what the OS should be doing, which is
> not what we want. You basically instruct driver what to do. We want a
> described hardware configuration or hardware specifics.

Right, and this was why I at first rejected a property name like this in
favour of 'reset-pulled-to-supply' in my first draft. That name
obviously does not work as the 'supply' suffix is already claimed, but I
also realised that it doesn't really describe the hardware property that
allows the reset line to remain asserted.

The key feature in this hardware design is that the reset line will not
just be pulled to the supply voltage (what other voltage would it be
pulled to), but that it is also pulled to ground when the supply is
disabled.

Rather than trying to encode this in the property name, I settled on the
descriptive 'no-reset-on-power-off' after the seeing the prior art in
'goodix,no-reset-during-suspend' property. The latter is too specific
and encodes policy, but the former could still be considered hardware
description and would also apply to other designs which have the
property that the reset line should be left deasserted.

One such example is when the supply can not be disabled at all (e.g. the
Goodix case), but I can imagine there being more than one way to design
such reset circuits.

> Reset is pulled to something? What is exactly different in this hardware
> configuration comparing to other hardware setup (regular)?

The power supply is shared with other peripherals and the hardware
designers have made provisions so that the reset line can remain
deasserted regardless of the state of the supply in order to save power.
 
> > +    type: boolean
> > +    description:
> > +      Reset line is wired so that it can be left deasserted when the power
> > +      supply is off.

Johan

