Return-Path: <linux-kernel+bounces-155405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D30438AE9F4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8E5FB23E8B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534C313B582;
	Tue, 23 Apr 2024 14:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lavk+HSl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6B519BBA
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 14:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713884312; cv=none; b=jvbBQq8JaANDgTM8+eIe/81ByAHOXpexfDhTZDFzx1V/tghUhX2+XlT553Qez4wM6cUt88L5aP4+/66w2yiZrNjEC7P2+jhmgtgaBB5j7y2HvgEgr5YnK4YU6wsahu1BAY8Yevvc+pZLX0YSnISerdwTKl5abXl2JfORRHCMyow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713884312; c=relaxed/simple;
	bh=1YHO87gpuA4GWmgj2Um/hut9wEBNIU7DZW6ecVbdQog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5oXs2S8xBHzWnLv97AZr7OMeFH8q97Bl4WXik9uaQIrAVJxgcYm5s4pAK2gjLwLXHvd5ri96m3YB+I57cUKivfSS4j7Ze2cv0D2O9R/UKgwUZCWD05W+/NykzeHXVWhhUsi6lcUdEBLtnNTtzY5axwJdWr22IeKiRUpcuVoAIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lavk+HSl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23513C116B1;
	Tue, 23 Apr 2024 14:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713884311;
	bh=1YHO87gpuA4GWmgj2Um/hut9wEBNIU7DZW6ecVbdQog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lavk+HSlkvCpvWHOmB/TRotL7IHCxCKW0b2IhHibrA+Y11LllPj7SumxIUl+BAtUl
	 x0Wn4ntm5NdIfBQ3kQRItM+vrb1U4IqGNr0ZsJ/t1abxEjfEh4lhsIltm/s8Aouw7c
	 RkT9s5MSw1Q8zp65Dcdf7bEVqVlGuAoyuVh7dROOGhV0PxW60PEPIl8jOFfn0SlVkD
	 3TdYDtV21DgzEFowxzeviKHhQnZ9eIlLGLeyjZ1QfW1sUNY1TGnZTr4CEsKRkGGPHT
	 NrqKPxTDm/H0cHAfUv8v1auQMVEhEoSc6CXD/jz0w43X58sRq9B6t/OP0NXCKroCq4
	 fO0bVZD6FVGxg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rzHbJ-000000002ag-1MYj;
	Tue, 23 Apr 2024 16:58:29 +0200
Date: Tue, 23 Apr 2024 16:58:29 +0200
From: Johan Hovold <johan@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: broonie@kernel.org, perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: Re: [PATCH v2 0/4] ASoC: qcom: display port changes
Message-ID: <ZifMlc_rLV6_LhUy@hovoldconsulting.com>
References: <20240422134354.89291-1-srinivas.kandagatla@linaro.org>
 <ZieihZRKe7OtP-nV@hovoldconsulting.com>
 <92b02fd3-5eba-42a7-a166-21b14724b10c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92b02fd3-5eba-42a7-a166-21b14724b10c@linaro.org>

On Tue, Apr 23, 2024 at 01:38:18PM +0100, Srinivas Kandagatla wrote:
> On 23/04/2024 12:59, Johan Hovold wrote:

> > It looks like your UCM changes are still muxing the speaker and *each*
> > displayport output so that you can only use one device at a time (i.e.
> > only Speaker or DP1 or DP2 can be used).

> that is true.
> 
> What is the use-case to use more than one audio sink devices at the same 
> time for a laptops?

I can imagine streaming audio and video to a TV (or audio to a soundbar)
over DP while playing systems sounds and doing video conferencing using
the internal speakers (or the other DP port).

> How do you test it? I never tested anything like that on a full desktop 
> setup.

You can select the sink per application in pavucontrol. Just verified
that playing audio over the 3.5 mm jack while playing system sounds
using the internal speakers works just fine.

> > As we discussed off list last week, this seems unnecessarily limited and
> > as far as I understood is mostly needed to work around some
> > implementation details (not sure why DP1 and DP2 can't be used in
> > parallel either).
> 
> It is absolutely possible to run all the streams in parallel from the 
> Audio hardware and DSP point of view.
> 
> One thing to note is, On Qualcomm DP IP, we can not read/write registers 
> if the DP port is not connected, which means that we can not send data 
> in such cases.
> 
> This makes it challenging to work with sound-servers like pipewire or 
> pulseaudio as they tend to send silence data at very early stages in the 
> full system boot up, ignoring state of the Jack events.

This bit sounds like it can and should be worked around by the driver to
avoid hard-coding policy which would prevent use cases such as the ones
mentioned above.

> > Can you please describe the problem here so that we can discuss this
> > before merging an unnecessarily restricted solution which may later be
> > harder to change (e.g. as kernel, topology and ucm may again need to be
> > updated in lock step).
> > 
> >  From what I could tell after a quick look, this series does not
> > necessarily depend on muxing things this way, but please confirm that
> > too.
> 
> These patches have nothing to do with how we model the muxing in UCM or 
> in tplg.
> 
> so these can go as it is irrespective of how we want to model the DP 
> sinks in the UCM or tplg.

Thanks for confirming.

Johan

