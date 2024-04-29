Return-Path: <linux-kernel+bounces-162507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 863EB8B5C40
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1281B23500
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5EA8120D;
	Mon, 29 Apr 2024 15:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vy+Ua44h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B7C80630
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 15:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714402842; cv=none; b=GdbHt9SA8G2EBXxSDb2xViOurCoJmUIb8HhLcD45WR1ZgtQ5hmx7ith3acZ9zMmk0oDdhcUSG8KEDHtSu/mL8YOba55u0+upJtUp7dUHcKoI1+gIIM4CQJnbLPcMtoDscvx3+Gp90gRxT1oKIve8sNSsaTs+0RIC+mwgn/MOYSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714402842; c=relaxed/simple;
	bh=1EwieA7QUF9rLJWyLDX+qUl7U2/uRBK3RtLbBgX3Hww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e80rmFDpPwelUaIo+scuwM/oefPCz9KQgxnAS5F+Y3XLSD+r16muhqRrbX6Psl/m2hynHy/dHyE0uXiglSh8Qni/IefdDR00v0oHrJ3oZmD0YNyGQskPnh2UH1g+7nU35GeYJI/t2bxqUKtuDM88VoU1OFsOsvPzrZDELjVQzH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vy+Ua44h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4025C113CD;
	Mon, 29 Apr 2024 15:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714402842;
	bh=1EwieA7QUF9rLJWyLDX+qUl7U2/uRBK3RtLbBgX3Hww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vy+Ua44hajpgT2+BhYXGsME5V8NCe8v21/S768xNPsTQnz2zGWqtiIGDYg0cem1IQ
	 2kpWL9AIxmhHYNFt7U7OHCFKPdGhP1npPJgRH0zsZG6q9oaBsTHX1wwB72vpN6W2pV
	 w6a8zfnUHIEPeQpTDBZslcLWfx4q7rFU6Bn7Er53CI1Iko6CsACOHrjUy0KQ7GAib+
	 s753iW4wcAVzxKby6OaK3OraQdvZBcQN0Rng1G64S4XQQ+yCol/sejf7DOa07FQROy
	 MdqXkWq+8b54M+1rEYed0DhZ+DYt2Km/dWs7WTNWvxe/Kwusp4eKT3cdGZ5VQxO3qN
	 xL6KBfcREkVaQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1s1SUj-000000005LT-3cUe;
	Mon, 29 Apr 2024 17:00:41 +0200
Date: Mon, 29 Apr 2024 17:00:41 +0200
From: Johan Hovold <johan@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: broonie@kernel.org, perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: Re: [PATCH v2 0/4] ASoC: qcom: display port changes
Message-ID: <Zi-2GVGZvWoIXO2c@hovoldconsulting.com>
References: <20240422134354.89291-1-srinivas.kandagatla@linaro.org>
 <ZieihZRKe7OtP-nV@hovoldconsulting.com>
 <92b02fd3-5eba-42a7-a166-21b14724b10c@linaro.org>
 <ZifMlc_rLV6_LhUy@hovoldconsulting.com>
 <fc3d849d-3a7e-439a-8d71-2b70ac75ae86@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc3d849d-3a7e-439a-8d71-2b70ac75ae86@linaro.org>

On Tue, Apr 23, 2024 at 04:59:56PM +0100, Srinivas Kandagatla wrote:
> On 23/04/2024 15:58, Johan Hovold wrote:

> >> It is absolutely possible to run all the streams in parallel from the
> >> Audio hardware and DSP point of view.
> >>
> >> One thing to note is, On Qualcomm DP IP, we can not read/write registers
> >> if the DP port is not connected, which means that we can not send data
> >> in such cases.
> >>
> >> This makes it challenging to work with sound-servers like pipewire or
> >> pulseaudio as they tend to send silence data at very early stages in the
> >> full system boot up, ignoring state of the Jack events.

> > This bit sounds like it can and should be worked around by the driver to
> > avoid hard-coding policy which would prevent use cases such as the ones
> > mentioned above.

> This is not simple as you say. We have to fit these into a proper DPCM.
> Either we have a dummy Backend connected for each of these pcm 
> sub-devices when DP port is not connected and then switch back to DP 
> when its connected.

I don't know how best to implement it, but we shouldn't necessarily let
that determine the user experience.

> Or somehow find a way to not let the pipewire talk to devices which are 
> not connected.

Yes, perhaps it requires a change in user space.

But it seems the kernel should be able to fake whatever probing user
space currently does to determine if the there is a DP jack (even when
there is nothing connected).

Johan

