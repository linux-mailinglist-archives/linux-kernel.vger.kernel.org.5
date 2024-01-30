Return-Path: <linux-kernel+bounces-44653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B08842585
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 845F31F22262
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB056DD13;
	Tue, 30 Jan 2024 12:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRMR0jzX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CA66DCFD;
	Tue, 30 Jan 2024 12:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706619221; cv=none; b=BnxT1k6Di0IzxIXH7yxKncW0WPT3TXeMLfIAVJ+WVneLFzpm/xsIgFfI8Zwn0lZxRURuD7URqO5SNGcwSfH1hxkLVnLJJ5CKOH+ouiBkOX6reYyRrcDNdoMABZtzTW9fQluAQKjHOkwCFdYLNIeMfJQCESjXZqnJstTYmLdT63w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706619221; c=relaxed/simple;
	bh=fOjlZzbAVw9Cqy4DTeoEpYu4QFxaBTIi8IHtqdYkjJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXpK2qvXMX6dRhRNRQfGILj0faq4bAdwxKO1GjKUdU0CgzuLl0FT06lPHqDbv74QNPn5h04lAv1NqojGY0ve5RmL/Grgm055LajEfG6rbOEBFBadKIuG2KVbQeYXVuar3BOQr43TDlHF9eb0vk21NeXQuloo1s77qizn0p5eIMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRMR0jzX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE48CC433C7;
	Tue, 30 Jan 2024 12:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706619220;
	bh=fOjlZzbAVw9Cqy4DTeoEpYu4QFxaBTIi8IHtqdYkjJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KRMR0jzXNgH0yE18/Nq++DuaSZ5VUmCWGSZmBaGGqW1yG4dN/bZCncvIwsTst3vV9
	 qjaqYdLRiEFINOQwB8ivSQv9nKTFAkgvR9nFCHsTo7sT5Q7sjHgsggmyLwvhl1I2lq
	 KJYDal/kunx40IAsYL/K7qcVYTCcUG9J9+o3A6KDfR5aeCxM/MNClYEWGM3WghRrRu
	 w/sUb5zAE3sxKuV1qodJoOuMgFs/FWF/vHEXoaJh1XTB3B5HtNKaFD327KeCVMLxHO
	 r5njrU4eEp7QOXNu8cjITb+zQE0Sc2mW0jbgpMsckkpS7maAVxjkaX66SBBZUMYPQI
	 4epTlhzdh24PA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rUncO-000000003iL-1S0t;
	Tue, 30 Jan 2024 13:53:37 +0100
Date: Tue, 30 Jan 2024 13:53:36 +0100
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v5 0/4] ASoC: qcom: volume fixes and codec
 cleanups
Message-ID: <ZbjxUF2IV3A5zNw5@hovoldconsulting.com>
References: <20240122181819.4038-1-johan+linaro@kernel.org>
 <170596045583.161959.6600754837297158632.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170596045583.161959.6600754837297158632.b4-ty@kernel.org>

Hi Mark and Takashi,

On Mon, Jan 22, 2024 at 09:54:15PM +0000, Mark Brown wrote:
> On Mon, 22 Jan 2024 19:18:15 +0100, Johan Hovold wrote:
> > To reduce the risk of speaker damage the PA gain needs to be limited on
> > machines like the Lenovo Thinkpad X13s until we have active speaker
> > protection in place.
> > 
> > Limit the gain to the current default setting provided by the UCM
> > configuration which most user have so far been using (due to a bug in
> > the configuration files which prevented hardware volume control [1]).
> > 
> > [...]
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

alsa-ucm-conf 1.2.11 was released yesterday, which means that it is now
very urgent to get the speaker volume limitation backported to the
stable trees.

Could you please try to make sure that these fixes get to Linus this
week?

Johan

