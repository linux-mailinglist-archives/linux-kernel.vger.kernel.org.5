Return-Path: <linux-kernel+bounces-164177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8472B8B7A3B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2F951C207BF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F04E143729;
	Tue, 30 Apr 2024 14:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/eSqWpf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47530152781;
	Tue, 30 Apr 2024 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714487792; cv=none; b=s7gPY42fBnqSxw2xq0Dk8o9zeEDxiGjP7slEcSzYGXWNrXVLMqEztPe6MaOi2MWudOlN+ER4UtdEnlItmhSEdhMbaQpwDtV6VCZV9YNWEA7r8XUQsRBHzUMyoqHiPo3iHv/ynDeiaNuMJcvhA6bT2jCKmlhd8aYYeIGXvG2aBBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714487792; c=relaxed/simple;
	bh=LKWI+SQd65kLKzL21w3huE0fLR5bApj1l+Rwvsz6QrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYISrOsgMFjisyVrYJlg4l8X2ULEvnjSOMEvaXapGjN8F9gNOomNAhX63dULhIpozjeZrDcWjIRE/1HlgNxvp5SNhc9eGD5wsQd0ChKDGywZMwl+iAwvJXWOlAuaq6dj4LQkvDQe4wxB/5EFuQgY0Xz8vnJ6Z4GaMywwiNhcowQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/eSqWpf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10BAC2BBFC;
	Tue, 30 Apr 2024 14:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714487790;
	bh=LKWI+SQd65kLKzL21w3huE0fLR5bApj1l+Rwvsz6QrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X/eSqWpfYx1YXb8Ql6syPez0TlFs75FQat7U+JvLQlpfPaC4jGzEyU67eSHiV4T/1
	 iF+1HqPG/rSTRjePgxheyyN9wffE5mFk+p4xTpGTdS4I8ydOhTXdG50yu8hdZzMYP+
	 8jBjrdipF5pt2sE0JsVdwId+QpRMy75fi+d6en0st1O3Y/yTMlD1k2PIqiEgZK9EeQ
	 fh0PHrBoB+PrEjDKGgxIUtyG58/XltX8YBioj/uhF+ePEyMJ6Cd4rcd3LkEg5mOy1m
	 5SCjzq0l1r/6wZCRa3fX+Tuo2BPfX8S7zjzQTIGO0ho3TQQ7yOQ8Kv3jHvsb81ZPyw
	 X5GZwjIheJWMg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1s1oat-000000000iZ-1cVz;
	Tue, 30 Apr 2024 16:36:32 +0200
Date: Tue, 30 Apr 2024 16:36:31 +0200
From: Johan Hovold <johan@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Janaki Ramaiah Thota <quic_janathot@quicinc.com>,
	Doug Anderson <dianders@chromium.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, quic_mohamull@quicinc.com,
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
Subject: Re: [PATCH] Bluetooth: qca: generalise device address check
Message-ID: <ZjEB75qDjoOb9F_3@hovoldconsulting.com>
References: <CAD=FV=V-pG9+5fLonNvydmjS=ziUFUHAyF8T7YTkEHiO405aSA@mail.gmail.com>
 <ZizKmtcUIYAMpvOQ@hovoldconsulting.com>
 <dbba45d2-f955-4d3a-aeab-26b0900d5823@quicinc.com>
 <Zi-ohCWv58d2h5VM@hovoldconsulting.com>
 <CABBYNZJyqrNKebwPPPqjOAdrkpBJ0fqHyD2iVtypeQKCDcL+AQ@mail.gmail.com>
 <CABBYNZJyRR9FA7TYN4+aWMtG9FPUBWMvCtMNUfvaEzxVcYOt-g@mail.gmail.com>
 <ZjCYu2pc8376rjXk@hovoldconsulting.com>
 <9eebd77b-c070-4260-a979-9b97f14eb5b1@quicinc.com>
 <ZjDtDRCHT3z-3nHh@hovoldconsulting.com>
 <CABBYNZLCw08oo+RRWkBYAdBLhFK5+pQi59dz-f+P1QusfYoAAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZLCw08oo+RRWkBYAdBLhFK5+pQi59dz-f+P1QusfYoAAw@mail.gmail.com>

On Tue, Apr 30, 2024 at 10:04:05AM -0400, Luiz Augusto von Dentz wrote:
> On Tue, Apr 30, 2024 at 9:07 AM Johan Hovold <johan@kernel.org> wrote:
> > On Tue, Apr 30, 2024 at 06:22:26PM +0530, Janaki Ramaiah Thota wrote:

> > > NVM Tag 2: bd address is default BD address (other than 0), should be
> > > configured as valid address and as its not unique address and it will
> > > be same for all devices so mark it is configured but still allow
> > > user-space to change the address.
> >
> > But here we disagree. A non-unique address is not a valid one as it will
> > cause collisions if you have more than one such controller.
> >
> > I understand that this may be convenient/good enough for developers in
> > some cases, but this can hurt end users that do not realise why things
> > break.
> >
> > And a developer can always configure an address manually or patch the
> > driver as needed for internal use.
> >
> > Are there any other reasons that makes you want to keep the option to
> > configure the device address through NVM files? I'm assuming you're not
> > relying on patching NVM files to provision device-specific addresses
> > after installation on target?
> 
> Exactly, a duplicated address is not a valid public/identity address.
> 
> Regarding them already been in use, we will need to have it fixed one
> way or the other, so it is better to change whatever it comer within
> the firmware file to 00:00:00:00:00:00 and have it setup a proper
> address after that rather than have a table that detect the use of
> duplicated addresses since the result would be the same since
> userspace stores pairing/devices based on adapter addresses they will
> be lost and the user will need to pair its peripherals again, so my
> recommendation is that this is done via firmware update rather than
> introducing a table containing duplicate addresses.

I'm not sure I fully understand you here. I agree that we should avoid
the table if we can, but as you noted below this is what the patch in
this thread does.

And the firmware comes from Qualcomm which pushes it directly to
linux-firmware so we can't control what they decide to put in these
files.

Perhaps the driver can clear the BD_ADDR tag instead of reading it back,
but yes, the end result would be the same in case the firmware can
handle that. May be better to just read out the address as this patch
does to be sure.

> That said it seems the patch in this thread actually reads the address
> with use of EDL_TAG_ID_BD_ADDR and then proceed to check if that is
> what the controller returns as address, while that is better than
> having a table I think there is still a risk that the duplicated
> address gets used on older kernels if that is not updated in the
> firmware directly, anyway perhaps we shall be doing both so we capture
> both cases where duplicated addresses are used or when BDADDR_ANY is.

Not sure we need to care too much about older kernels here. The patches
are currently marked for backport to 6.5 and that could serve as a
cut-off point, but I guess there is nothing preventing us from
backporting this to all stable trees if you prefer that.

Johan

