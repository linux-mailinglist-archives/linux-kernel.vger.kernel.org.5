Return-Path: <linux-kernel+bounces-166287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF25B8B9894
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 303D0B23B7C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900925788E;
	Thu,  2 May 2024 10:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/AgVljf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2B654913;
	Thu,  2 May 2024 10:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714644698; cv=none; b=LS247pIhh0x1HDPLUpNvEtnb9rI792/sOlROVX2FkCvzAO5Xmsfnva2mqbOX6zLcwHvM6ouZ7SJFeO7aaTRnSkvIoe/1u0Wyaw6TSVt/jHJ/VxBgKdeQohPC0TpGG5hX1roucwqVdeC2SothFGwSwI9kCMY8+31mKDymbB7H7d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714644698; c=relaxed/simple;
	bh=ixIk4+Ib9R0B/PKantFlBunF8yD6KgiqU/N/XKxUe/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrG5YyIx/73tAJaXju3UTx1qUmC/edR5UEupHj2SRgFbWntVndTBBkY8vbRFp5AN/51VHvCkRBBZP9bzFkeRYvgTjthtwAW+2nQWnau7gcRjO00KGj+KIIQd3PfK1NxsAMhe/+yjmuunOnIB/SfoSp3LhhCPwuFEcWIymieg3nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/AgVljf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35CDBC116B1;
	Thu,  2 May 2024 10:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714644698;
	bh=ixIk4+Ib9R0B/PKantFlBunF8yD6KgiqU/N/XKxUe/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K/AgVljfod0csCf+106igPRO76SJrX3V/8ZERm1qfozq8tvFdA8/oL5k+kfwJRSEM
	 2JfbmSVMrqkS73goSP9ITFerrNm1GlxeVbRIZnaYeZWSoUK2ETbRaHPPgVFxuN3mYY
	 Z4svoIkoXToJl9jejL2GL01hLMWnbjYRCtAdp8mZTbfnKmdLyjou8nVVVOfXwW5AQn
	 AMwv6DpLdxYhqexPSjsMwklbqPGRzGI3A0FXAERYKjpmO3uT2EGS2FFQog7r/C6sHm
	 ScKjXi891vuDMvCVafYO5OdABmRxz6mf1ZVifM3VB62ksg0YyzwrlEGfJjsqQK2Ljo
	 neaO/kuip2Omw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1s2TPg-000000002y3-1jla;
	Thu, 02 May 2024 12:11:41 +0200
Date: Thu, 2 May 2024 12:11:40 +0200
From: Johan Hovold <johan@kernel.org>
To: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Doug Anderson <dianders@chromium.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, quic_mohamull@quicinc.com,
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
Subject: Re: [PATCH] Bluetooth: qca: generalise device address check
Message-ID: <ZjNm3OnJ1fdHctaZ@hovoldconsulting.com>
References: <CAD=FV=V-pG9+5fLonNvydmjS=ziUFUHAyF8T7YTkEHiO405aSA@mail.gmail.com>
 <ZizKmtcUIYAMpvOQ@hovoldconsulting.com>
 <dbba45d2-f955-4d3a-aeab-26b0900d5823@quicinc.com>
 <Zi-ohCWv58d2h5VM@hovoldconsulting.com>
 <CABBYNZJyqrNKebwPPPqjOAdrkpBJ0fqHyD2iVtypeQKCDcL+AQ@mail.gmail.com>
 <CABBYNZJyRR9FA7TYN4+aWMtG9FPUBWMvCtMNUfvaEzxVcYOt-g@mail.gmail.com>
 <ZjCYu2pc8376rjXk@hovoldconsulting.com>
 <9eebd77b-c070-4260-a979-9b97f14eb5b1@quicinc.com>
 <ZjDtDRCHT3z-3nHh@hovoldconsulting.com>
 <a09ab4e3-699b-4eb7-bc64-44c9de6db78d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a09ab4e3-699b-4eb7-bc64-44c9de6db78d@quicinc.com>

On Thu, May 02, 2024 at 12:35:19PM +0530, Janaki Ramaiah Thota wrote:
> On 4/30/2024 6:37 PM, Johan Hovold wrote:

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

> We prefer unique address to be flashed on OTP (persistent) memory of
> BT-Chip, which is supported by almost all QC BT-chips.

Yes, that is certainly the best option for everyone.

> If someone is not able to do that/ does not prefer that, they still
> have an option to flash unique address in firmware binary (NVM)file.
> This does not require setting BD address from user space.
> 
> Also until a developer flashes OTP/ keep unique BD-Address in NVM,
> he should be able to run most of the use cases from Device, that's
> why we want to make it as configured.

Ok, but a developer can still do this since they can patch the driver to
disable the check temporarily or, alternatively, just update the
devicetree with a valid unique address.

> In our opinion this provides best Out of box experience.

You can also look into improving support in user space (e.g. bluez) for
providing a valid unique address in a simple text-based configuration
file.

That would be useful for all Linux users and not require having access
to Qualcomm specific tools to update the NVM configuration file (which
could also be in a read-only file system, e.g. on Android).

Johan

