Return-Path: <linux-kernel+bounces-119472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 776E688C970
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 211751F8214C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E8E1B964;
	Tue, 26 Mar 2024 16:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="KmeApJWj"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A97F1CFBD;
	Tue, 26 Mar 2024 16:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711470806; cv=none; b=itwVp8bMvjnIyHbeMO8IZVqszFUtaw5bYDIXA5daQXiRZ9JMQEciQ1Pq/vlU80sBnI0chk4wfHGWb04BL+Atpbd7M+jabhwAKpk/MdbSjDF7VZFcDYln6tAnFC+Pgg0KGPQ+s7AHyClL0fqY3vL3rPXNxKTRInxMW3mhFLEU41U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711470806; c=relaxed/simple;
	bh=CleG5/amzFryHUGk0qi21He4sc6qBTmF2lsXmm/dW1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPhJhAHlEH1r9G+joaYsIHWHAhqP7Nqw3lk6syOeYix+XsM340Em9SiA6qQVlMyDnUuaVQyJWVjt3JexeAaReEV9VjeKeUFWF9QTOcDh0N6jCkDKtM77MqrendrnGRuATPqCaRwWyUdt57qcVfynNPuwspkETs8z+JEpFEk+pYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=KmeApJWj; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1711470794; bh=CleG5/amzFryHUGk0qi21He4sc6qBTmF2lsXmm/dW1Y=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=KmeApJWjNNXi6WuapEfvIV+WeLpX2gT8+KizMYv9ifPSw4NGc/sIb0r+NRP/Q5RxF
	 WbV2jOf9weUe0VVvUtOcB62/69819MpZsZkBufP1exdcaer1uTpFFkGR1N4WMilfg+
	 Wl0z7DPQTlN3wnaFLALPnFEQUA4z5WwEJcwQbZYw=
Date: Tue, 26 Mar 2024 17:33:14 +0100
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Arnaud Ferraris <arnaud.ferraris@collabora.com>, linux-sound@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v3 0/4] Add support for jack detection to codec present
 in A64 SoC
Message-ID: <2vhd45kylttgonosdcfn7ugwyy2vx56gijwf3ealz4tel65iqr@cs3kxrl6d2hh>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, 
	Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
	linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20240302140042.1990256-1-megi@xff.cz>
 <171146686191.132239.8280140430376443574.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <171146686191.132239.8280140430376443574.b4-ty@kernel.org>

Hello Mark,

On Tue, Mar 26, 2024 at 03:27:41PM +0000, Mark Brown wrote:
> On Sat, 02 Mar 2024 15:00:34 +0100, Ondřej Jirman wrote:
> > This series adds support for jack detection to this codec. I used
> > and tested this on Pinephone. It works quite nicely. I tested it
> > against Android headset mic button resistor specification.
> > 
> > The patches are a rewritten and debugged version of the original
> > ones from Arnaud Ferraris and Samuel Holland, improved to better
> > handle headset button presses and with more robust plug-in/out
> > event debouncing, and to use set_jack API instead of sniffing
> > the sound card widget names, to detect the type of jack connector.
> > 
> > [...]
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thank you.

Coincidentally, Intel kernel test bot found an issue today that this fails to
build with CONFIG_SND_JACK_INPUT_DEV disabled. Should I send a followup fix or
should I send v5 with the fix integrated into the patch that breaks?

Kind regards,
	o.

> Thanks!
> 
> [1/4] ASoC: sun50i-codec-analog: Move suspend/resume to set_bias_level
>       commit: c0454d31e05062b1c7df7eef21855ba1f56c5158
> [2/4] ASoC: sun8i-codec: Enable bus clock at STANDBY and higher bias
>       commit: c556814b926c3f16fdca3d18cac793ccf0d14c44
> [3/4] ASoC: sun50i-codec-analog: Enable jack detection on startup
>       commit: d5961e43b28668088087befbf4f7a043bd0ae65c
> [4/4] ASoC: sun8i-codec: Implement jack and accessory detection
>       commit: 21fa98f4197bb3365dda1417708b318f403c13c1
> 
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
> 
> Thanks,
> Mark
> 

