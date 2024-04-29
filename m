Return-Path: <linux-kernel+bounces-162413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDC68B5AD5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3E31C21F28
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E457BAE3;
	Mon, 29 Apr 2024 14:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIQAiOwY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5707350E;
	Mon, 29 Apr 2024 14:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714399366; cv=none; b=rzxDTs5nriDPFuwnris9c8KD1rhu2noB13Ug+tOiLQipMhCS0LSfvilOsTLNVkGEi0ns6VGnLdG+qXA3cN+yHaQgX4GUgmeGr7IYbcOpEOrQirHKf2cY4R5ZSurL4NAYmLMZGOXu/HV1rfHL6hlZxWCJ+H1icFv0SnW/E5UvvJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714399366; c=relaxed/simple;
	bh=835iAcXRfjIYlXFFIwTdN1EOMd6MN3KDBFjtdpw5a40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbUe4wh+6uUb3TrU4E3p60GILpjjEjNW4cdfxI1i9/huV8htQfYCSyGIOT6G/KxDNCIY7sC8RRhmX3iClF6zY4ToH53Jq934CrcNeTSdMOGHu8kpbhkG89foXOWaDgIOukE623nPeEvO1/4+DFjBwVhPmIARpkuhHkfDNSFGegQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mIQAiOwY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77BA2C4AF19;
	Mon, 29 Apr 2024 14:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714399365;
	bh=835iAcXRfjIYlXFFIwTdN1EOMd6MN3KDBFjtdpw5a40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mIQAiOwY1X+S90URPul8ZL26gdeBGQLXhnXDeQTxIa9KM0vKzNqP617ep23xAxHIy
	 HQTxTRtMK//6MVqQmnif3WNYgzKoeENyXTBUNKtVRPRimNodrWIqLylyT0VWKVhdCh
	 gls/b9VJftbfJCNIFHj9dlE0UcP/4vXJwuiPuXWOurv3ojJqBwSnluGK3VrqWOnb6N
	 qYgyAW8fYDw96zokhC9yx2Zt8QIhHPVCWxPkerfplACVIE7+jY2AgqP8lXbgVtmBZy
	 LFX2TbJJq0gVAd7UaaUyb0ZZ8a++pX75g69OAOoEQKxC6+FIF0nAeC5hAdgTRzSTc1
	 2bN3YBjgBhsSA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1s1Rae-000000004KY-3wOG;
	Mon, 29 Apr 2024 16:02:45 +0200
Date: Mon, 29 Apr 2024 16:02:44 +0200
From: Johan Hovold <johan@kernel.org>
To: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Cc: Doug Anderson <dianders@chromium.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, quic_mohamull@quicinc.com,
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
Subject: Re: [PATCH] Bluetooth: qca: generalise device address check
Message-ID: <Zi-ohCWv58d2h5VM@hovoldconsulting.com>
References: <20240426155801.25277-1-johan+linaro@kernel.org>
 <CAD=FV=V-pG9+5fLonNvydmjS=ziUFUHAyF8T7YTkEHiO405aSA@mail.gmail.com>
 <ZizKmtcUIYAMpvOQ@hovoldconsulting.com>
 <dbba45d2-f955-4d3a-aeab-26b0900d5823@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbba45d2-f955-4d3a-aeab-26b0900d5823@quicinc.com>

Hi Janaki,

Please avoid top and remember to trim unnecessary context when replying
to the mailing lists.

On Mon, Apr 29, 2024 at 03:34:32PM +0530, Janaki Ramaiah Thota wrote:

> Having a default BDA list from NVM BDA tag value will prevent developers
> from using the device if there is no user space app(In Fluoride) to set
> the BDA. Therefore, we are requesting to use default address check patch,
> so that developer can change the NVM BDA to make use of the device.

But a developer on such an old platform that can patch and replace the
NVM configuration file should also be able to just disable the check in
the driver right (e.g. by commenting out the call to
qca_check_bdaddr())?

>   List Of default Addresses:
>   ---------------------------------------------------------
> |       BDA          |      Chipset                       |
>   ---------------------------------------------------------
> | 39 80 10 00 00 20  |  WCN3988 with ROM Version 0x0200   |
>   ---------------------------------------------------------
> | 39 80 12 74 08 00  |  WCN3988 with ROM Version 0x0201   |
>   ---------------------------------------------------------
> | 39 90 21 64 07 00  |  WCN3990                           |
>   ---------------------------------------------------------
> | 39 98 00 00 5A AD  |  WCN3991                           |
>   ---------------------------------------------------------
> | 00 00 00 00 5A AD  |  QCA DEFAULT                       |
>   ---------------------------------------------------------

What about WCN6750 and 64:90:00:00:5a:ad?

And then there's currently also:

> > bluetooth hci0: bd_addr = 61:47:aa:31:22:14 (qca/nvm_00130300.bin)
> > bluetooth hci0: bd_addr = 61:47:aa:32:44:07 (qca/nvm_00130302.bin)

Which controllers use these configurations?

Johan

