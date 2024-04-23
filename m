Return-Path: <linux-kernel+bounces-155116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF3F8AE576
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E8821F242D7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2A8130AC9;
	Tue, 23 Apr 2024 11:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQjQw67U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C182F64CCC
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713873543; cv=none; b=JW42j92tWR5aCm5h5zOTbCjVenIIxrOCV+kAycN1VgePe39nSXYsrs6k1cP61DedGs4VeSSw0glQ7fHZZVmVeXVmqrSzw0R42mtvKgv81tYACt0Zj8hiuji+MjGoUzPh6kxwUw0TzcPRj/FavnM7xk0nInSImjrIq5mKaZtfzkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713873543; c=relaxed/simple;
	bh=nN7zGFg9PFQMqcmKgEdJAU83WoXJ9A3csJuwYHCvDXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o14SwWcTZqp82KFidD4tQD+6rF5eIt8zfhLfVykYXG8eKW2jgS3vYM5S3OcppaK69/JJUyLIXuNRLZnzX2TjfJOPpBURP68Iqu6BFn9gIKDGBb1YWoAjSEGSvFREi2PUKEbRNzSxxHxegwOXIq2Ucfxll4SaIV7iyVV51NJchEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQjQw67U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55606C116B1;
	Tue, 23 Apr 2024 11:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713873543;
	bh=nN7zGFg9PFQMqcmKgEdJAU83WoXJ9A3csJuwYHCvDXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OQjQw67U5QJS+GP8IG6Aech13cnh+ug8QkQhgdHfNEL85oXMk7qfT8doa+NR5fI5f
	 9fciWr0nRNiCnoquahI6tM92VkM+4vMw+o9OYYBbKVf0n1GN6WC+RAB5wLuE+TxbgA
	 ps4/jVTajB2yXo/kA7r+WXBbD4rOTFX6VzFheWgpryJZEwJFETyTQOdfUMOlygIflx
	 dyJ7bPdDIU/qeUmM/M8dYX6j2aZyAZ5+++cla4R/2Dg8sTkraYcJiF+SnaKOSd5IOb
	 RMeQTZPHQ3n2u3YcSPabaJbsicg7hN+iSueRoJcNJ8VQwMtl6APFGc2aXXaRWR2sWJ
	 I7aI6XDSBQSxQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rzEnd-000000005Mk-1kZS;
	Tue, 23 Apr 2024 13:59:01 +0200
Date: Tue, 23 Apr 2024 13:59:01 +0200
From: Johan Hovold <johan@kernel.org>
To: srinivas.kandagatla@linaro.org
Cc: broonie@kernel.org, perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: Re: [PATCH v2 0/4] ASoC: qcom: display port changes
Message-ID: <ZieihZRKe7OtP-nV@hovoldconsulting.com>
References: <20240422134354.89291-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422134354.89291-1-srinivas.kandagatla@linaro.org>

On Mon, Apr 22, 2024 at 02:43:50PM +0100, Srinivas Kandagatla wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patchset adds support for.
> 	1. parse Display Port module tokens from ASoC topology
> 	2. add support to DP/HDMI Jack events.
> 	3. fixes a typo in function name in sm8250
> 
> Verified these patches on X13s along with changes to tplg in 
> https://git.codelinaro.org/linaro/qcomlt/audioreach-topology/-/tree/topic/x13s-dp?ref_type=heads
> and ucm changes from https://github.com/Srinivas-Kandagatla/alsa-ucm-conf/tree/topic/x13s-dp

It looks like your UCM changes are still muxing the speaker and *each*
displayport output so that you can only use one device at a time (i.e.
only Speaker or DP1 or DP2 can be used).

As we discussed off list last week, this seems unnecessarily limited and
as far as I understood is mostly needed to work around some
implementation details (not sure why DP1 and DP2 can't be used in
parallel either).

Can you please describe the problem here so that we can discuss this
before merging an unnecessarily restricted solution which may later be
harder to change (e.g. as kernel, topology and ucm may again need to be
updated in lock step).

From what I could tell after a quick look, this series does not
necessarily depend on muxing things this way, but please confirm that
too.

Johan

