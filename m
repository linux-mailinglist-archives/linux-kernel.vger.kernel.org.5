Return-Path: <linux-kernel+bounces-166261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D3D8B9831
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B81FB235D2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB3956B65;
	Thu,  2 May 2024 09:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPqyRPF+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9AA56457;
	Thu,  2 May 2024 09:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714643758; cv=none; b=ib+ebqdVtzzYCjbDmO+YMNwjTm1oI0L+YCBEl7aIWZav+qRP9z8Xsh7FG6rEmDt799Dwm/i2C7QCFBivK2JrAHVRxzD/xCh/Zx/72/vZV+nh2HiBlNAj5HRhd7q4D57mlnTsukKX2NkXKAeaylv0P5Tuj48frINzHQgx8poyWU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714643758; c=relaxed/simple;
	bh=ssWnVaIJikdkkjYTU5z1sAgnit9Q2Wj3oLCmC/RYMUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADiVCo5yJHkWDwuN00X8dpC5oq3grEzNp9XELSHZ5LfbPpawONAvgef/711J0M+3jPpGLcBjOB6pLoqG2ZnYISbugbhYk+C/XTvtPddsrz5sksBlx9wdilp/+8RRUq131NnZhQ8EK2CRBEMigh3kaeUAPhcXzrST1YNHBUOwEfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pPqyRPF+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38056C113CC;
	Thu,  2 May 2024 09:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714643758;
	bh=ssWnVaIJikdkkjYTU5z1sAgnit9Q2Wj3oLCmC/RYMUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pPqyRPF+pAOtrhqdNWI0T6K7VwtOspwfVEHF7RY5RiA64Uy0x55xE4V4E5oovDBek
	 vNhUSznMh3uibGmR8HuvWwK1CrhxW7KtLDkiHd/OThIZqAJNsTMJYA4gQlnrMxyT1v
	 KY1uW7Gun2w2dTNa3MEJS00KZHYFw/VSuwOM14xXRcdPgiYKDcjC6UqMAPRNEDUwbr
	 tOT9sCpQfaye42bYFm8bnenFWISkMueXnpvH/01YohjPAjYUY/PKRyBp8ajug0TiPH
	 9oKRqg+dg0kooHFCd3q6Ivhfu+C0nB31nmWuojp0YNZ8ymiQfnMjkHPPgzVln5FS/K
	 loL2enV9q4GRQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1s2TAW-000000002lB-0cpt;
	Thu, 02 May 2024 11:56:00 +0200
Date: Thu, 2 May 2024 11:56:00 +0200
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
Message-ID: <ZjNjMBNMegmTgN5B@hovoldconsulting.com>
References: <20240423134611.31979-1-johan+linaro@kernel.org>
 <20240423134611.31979-4-johan+linaro@kernel.org>
 <2e67e4e6-83a7-4153-b6a7-cdec0ab2c171@kernel.org>
 <Zii2CUeIyBwxzrBu@hovoldconsulting.com>
 <bde4884c-117b-4e6e-8c7b-401b8320655b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bde4884c-117b-4e6e-8c7b-401b8320655b@kernel.org>

Hi Krzysztof,

and sorry about the late reply. Got side-tracked.

On Thu, Apr 25, 2024 at 11:39:24AM +0200, Krzysztof Kozlowski wrote:
> On 24/04/2024 09:34, Johan Hovold wrote:
> > On Tue, Apr 23, 2024 at 06:29:44PM +0200, Krzysztof Kozlowski wrote:
> >> On 23/04/2024 15:46, Johan Hovold wrote:
> >>> When the power supply is shared with other peripherals the reset line
> >>> can be wired in such a way that it can remain deasserted regardless of
> >>> whether the supply is on or not.

> >>> This is important as it can be used to avoid holding the controller in
> >>> reset for extended periods of time when it remains powered, something
> >>> which can lead to increased power consumption. Leaving reset deasserted
> >>> also avoids leaking current through the reset circuitry pull-up
> >>> resistors.
> >>>
> >>> Add a new 'no-reset-on-power-off' devicetree property which can be used
> >>> by the OS to determine when reset needs to be asserted on power down.
> >>>
> >>> Note that this property can also be used when the supply cannot be
> >>> turned off by the OS at all.
> > 
> >>>    reset-gpios:
> >>>      description: Reset GPIO; not all touchscreens using eKTH6915 hook this up.
> >>>  
> >>> +  no-reset-on-power-off:
 
> >> Anyway, the property sounds like what the OS should be doing, which is
> >> not what we want. You basically instruct driver what to do. We want a
> >> described hardware configuration or hardware specifics.
> > 
> > Right, and this was why I at first rejected a property name like this in
> > favour of 'reset-pulled-to-supply' in my first draft. That name
> > obviously does not work as the 'supply' suffix is already claimed, but I
> > also realised that it doesn't really describe the hardware property that
> > allows the reset line to remain asserted.
> > 
> > The key feature in this hardware design is that the reset line will not
> > just be pulled to the supply voltage (what other voltage would it be
> > pulled to), but that it is also pulled to ground when the supply is
> > disabled.
> 
> OK, if the property was specific to the hardware, then I would propose
> something more hardware-related, e.g. "reset-supply-tied". However :
> 
> > Rather than trying to encode this in the property name, I settled on the
> > descriptive 'no-reset-on-power-off' after the seeing the prior art in
> > 'goodix,no-reset-during-suspend' property. The latter is too specific
> > and encodes policy, but the former could still be considered hardware
> > description and would also apply to other designs which have the
> > property that the reset line should be left deasserted.
> > 
> > One such example is when the supply can not be disabled at all (e.g. the
> > Goodix case), but I can imagine there being more than one way to design
> > such reset circuits.
> 
> It seems it is common problem. LEDs have property
> "retain-state-shutdown", to indicate that during system shutdown we
> should not touch them (like power off). Would some variant be applicable
> here? First, do we talk here about power off like system shutdown or
> runtime PM, thus suspend?

A name like 'retain-state-shutdown' would also be too specific as what
I'm describing here is that the reset line should be (or can be) left
deasserted whenever the OS wants to power off the device.

That could be during suspend, but more generally whenever the OS
determines that the device does not need to be powered (e.g. when
closing a character device).

Johan

