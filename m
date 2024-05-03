Return-Path: <linux-kernel+bounces-167459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9026B8BA9D9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0DD01C2137B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D0F14F9C6;
	Fri,  3 May 2024 09:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0wlK9a7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC81A139CE5;
	Fri,  3 May 2024 09:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714728305; cv=none; b=iYUGlD0eGUpxFEGFQmrsRnYHI+EiIjmq+wkylH7VUDLTx1/cJgGVhq5hr0aR9evaI45wH4pKkpI0wsvkLiCW7yk1wDnRjTmJg9EHPkCGDmRk/Qw0c+5xMjUxzAnR6pilz+ABnx03rQSq9vDb/xD4huVYbpDmp+qqAJIKbWiDyaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714728305; c=relaxed/simple;
	bh=zK7UnGMi4p05jwvR3aEI2aFoiM1mhz4XLglPB41yM18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ap8zv9KBxyux9t681F+g0KB5IfsULxRBSgwO8D5xj3P5MJCv4nL8m3XoffU5MvotZuceDifjlhneRLAwINfykW5y/eJnCMwxt9f+gmLDFDIiuJ+ux38sDasPYn2ZCE9KiiQ6p99D0Tgsgn5KwbQHQKKIALu1afoBu6I4bAgvyg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0wlK9a7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BAA9C116B1;
	Fri,  3 May 2024 09:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714728304;
	bh=zK7UnGMi4p05jwvR3aEI2aFoiM1mhz4XLglPB41yM18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s0wlK9a72ouNQmoFhqXfgNKQI+xm31/6CJEtIYe198RlKClcGzA0e24vvV5nzjZYq
	 6TIok9pF1J9VamFuQfUy7yg7pG2NN58/sPl8L8TFHVG8qP3Uw41zPjt+X4+iz4Fi+4
	 QztH9oN5aKKBNLgua90geuYD2YIrv4DRX2Jvhu2enpkucIzsjI8pCPH72hHpqIp16W
	 O4FNsfkGxcqKEId4ayl9a9X17cCHtHdCH1AkK68tw8htrMeCIjQkQc7yrwyGDQ5S8l
	 Q5pkQazhInpMTXLXMlltCxzx+eS2Qlaq2xi+Wg4yaVoXscSsH2yj1CG6iMPDHa/mYq
	 QmExpUd9z37aA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1s2pA8-000000005Of-0cRG;
	Fri, 03 May 2024 11:25:04 +0200
Date: Fri, 3 May 2024 11:25:04 +0200
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
Message-ID: <ZjStcGBPlpygpKki@hovoldconsulting.com>
References: <20240423134611.31979-1-johan+linaro@kernel.org>
 <20240423134611.31979-4-johan+linaro@kernel.org>
 <2e67e4e6-83a7-4153-b6a7-cdec0ab2c171@kernel.org>
 <Zii2CUeIyBwxzrBu@hovoldconsulting.com>
 <bde4884c-117b-4e6e-8c7b-401b8320655b@kernel.org>
 <ZjNjMBNMegmTgN5B@hovoldconsulting.com>
 <48ec0bb5-a06e-4f18-97c3-1370b7facea4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48ec0bb5-a06e-4f18-97c3-1370b7facea4@kernel.org>

On Fri, May 03, 2024 at 11:11:16AM +0200, Krzysztof Kozlowski wrote:
> On 02/05/2024 11:56, Johan Hovold wrote:
> > On Thu, Apr 25, 2024 at 11:39:24AM +0200, Krzysztof Kozlowski wrote:

> >> It seems it is common problem. LEDs have property
> >> "retain-state-shutdown", to indicate that during system shutdown we
> >> should not touch them (like power off). Would some variant be applicable
> >> here? First, do we talk here about power off like system shutdown or
> >> runtime PM, thus suspend?
> > 
> > A name like 'retain-state-shutdown' would also be too specific as what
> > I'm describing here is that the reset line should be (or can be) left
> > deasserted whenever the OS wants to power off the device.
> 
> I don't think it is more specific than yours. It is actually more
> generic. First, shutdown=poweroff, so that part is the same.

My point is that 'shutdown' is a specific OS concept (i.e. turning the
whole system off), while powering off a *device* can be done for a
number of reasons including closing a character device, suspend and
system-wide shutdown.

The policy decision of when to power off a device is left up to kernel
(e.g. if a device needs to be kept on as it is currently configured as a
wakeup device).

Johan

