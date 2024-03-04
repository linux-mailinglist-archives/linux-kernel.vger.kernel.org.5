Return-Path: <linux-kernel+bounces-91122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCF68709CB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE79BB22346
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68EF7869E;
	Mon,  4 Mar 2024 18:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MN8E5iwp"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE231E52C;
	Mon,  4 Mar 2024 18:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709577657; cv=none; b=c6A7P7ojeBpso5MZdwmEr36JMdYcR6OTJ3GMHiOSxMASfkm4ARt7KBFNN5HDXsWh8MJBA1dtCfAfStfmgd78i2RZGnTJM6OSEJVm8488dx928+GuZEv3d/Ln9Tll1CQ23DSTj9aGgfQKepPI8sieoAJp08FJDkeV60In1PZfzeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709577657; c=relaxed/simple;
	bh=miYY9RwfRJE8WkrwLLPO2juR8/18chYnQ9ipeVKQmqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Re6e30HItU//tRV13t029cFOXvF62EQiSlbZAxTrwZz/Rl20sZ/htAJOJ7kIWLPBf9kJCIgx+9kKoP1CfnGrB+o6i9LXAH2AC+xqbv2mkXrilDXIAWRYFCj555xYvBD6BkG3/xh9W/m7cFIM+5y+puvEPq3zPvPYLoMZflhldw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MN8E5iwp; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-412e795f458so6131505e9.3;
        Mon, 04 Mar 2024 10:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709577654; x=1710182454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOixF9Qxs6pxfRAaa7GK40PcUljg6mYkWOsLVdP8gg4=;
        b=MN8E5iwp0tG50J8rV/3a78h4Blqt41tOJfXpY9ZtdsZJNDRW2c2mD0AIO4WWouHkTP
         f4tenhwSomSnul0/akacFESDPQ8eHScWrZQKlKU4Lju7MEcvoiJ1diqk4qIF8U4Qd/HN
         iQ7lvEkXdwVphaY1MSCQzXv/s29phAXhTQ5kWFLRJm9YwXM/BZDNE5mlITbQ4BKhGrye
         y4kQub4fWnaBNELYZndX0T1flgdwbcSHahTJJ+/uORp0ZGhhz6WO28v5gCF7NN86AiKr
         fkfqlG+NHysJu/wB7iNFZVxz59IAIHi9GltE7Sicz3ijrJRFJMYqU+HJ3c9CZU5Y//T2
         DaqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709577654; x=1710182454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OOixF9Qxs6pxfRAaa7GK40PcUljg6mYkWOsLVdP8gg4=;
        b=BdCcqSuC3IbYtaHPf4sOoT0pWRP+7H4vbWWKa9dE5THUx5S1P4oYdQya6ipHxjzIhE
         Kg9wkh2WuvbhwCgpfcpZJAbR9h5/n5ePApXr/m+Fw3nZvoXQZ93BV3xrBg0u2RSqa+uZ
         AIbTtplUiHQ/juLODXD6NogXZDm3tCu5vzgmmz71eWIlEucOMXJCQ3QpH7ypMMyoSi49
         VGaKyEirKFdIv92Wz6NMkpC69mJXNc00HyV+Sy6lH9gukmPY6IoPm4cC4ZigjzgTVgZX
         WaJUenzKJizxj/H3amGcUGXBBBHanX9IjjrvjncTNThFe/HXNk6MoexdddptrNTrir00
         IfZg==
X-Forwarded-Encrypted: i=1; AJvYcCVpL4jlQ0Ms+IbRiNaxe440tECzH1mf7von+rs839A3JGYu+L7YQ1EggpHIBQQpJRfZ20lxTzvb2B0sYDVD0BTAc+zLcGodB4hIii2YIou/Lbot7+nbMOLI/SGHQa3E2TgQs3QbRKQo6f1Dy2/LKWOcAQfV0v5V+gNd6VjT+VDZEayHrxJ7
X-Gm-Message-State: AOJu0YzfuLIQDnagjhc/kFudQUmJJbR5HwBVaugfUQl2gicX7nOnUQ/B
	i7AP7pLSxxljknWSHh5gTVDsJqu7DsFvNLbkpaaknuNnp35fO1Uk
X-Google-Smtp-Source: AGHT+IHp+fPd0u9tR3oVnca0W3S2vjfm9vhip8fmj8clro5oK6GajwyKFIeNXhiPXVu/A5z0KmuEkw==
X-Received: by 2002:a05:600c:470a:b0:412:b8ce:fa1e with SMTP id v10-20020a05600c470a00b00412b8cefa1emr7893177wmo.29.1709577653933;
        Mon, 04 Mar 2024 10:40:53 -0800 (PST)
Received: from archbook.localnet (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id l21-20020a05600c4f1500b004101543e843sm18552858wmq.10.2024.03.04.10.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 10:40:53 -0800 (PST)
From: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-rockchip@lists.infradead.org, linux-sound@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject:
 Re: [PATCH v3 1/7] ASoC: rockchip: i2s-tdm: Fix inaccurate sampling rates
Date: Mon, 04 Mar 2024 19:40:52 +0100
Message-ID: <2509388.gFrL1EYhQU@archbook>
In-Reply-To: <20240221-rk3308-audio-codec-v3-1-dfa34abfcef6@bootlin.com>
References:
 <20240221-rk3308-audio-codec-v3-0-dfa34abfcef6@bootlin.com>
 <20240221-rk3308-audio-codec-v3-1-dfa34abfcef6@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Mittwoch, 21. Februar 2024 11:22:45 CET Luca Ceresoli wrote:
> The sample rates set by the rockchip_i2s_tdm driver in master mode are
> inaccurate up to 5% in several cases, due to the driver logic to configure
> clocks and a nasty interaction with the Common Clock Framework.
> 
> To understand what happens, here is the relevant section of the clock tree
> (slightly simplified), along with the names used in the driver:
> 
>        vpll0 _OR_ vpll1               "mclk_root"
>           clk_i2s2_8ch_tx_src         "mclk_parent"
>              clk_i2s2_8ch_tx_mux
>                 clk_i2s2_8ch_tx       "mclk" or "mclk_tx"
> 
> This is what happens when playing back e.g. at 192 kHz using
> audio-graph-card (when recording the same applies, only s/tx/rx/):
> 
>  0. at probe, rockchip_i2s_tdm_set_sysclk() stores the passed frequency in
>     i2s_tdm->mclk_tx_freq (*) which is 50176000, and that is never modified
>     afterwards
> 
>  1. when playback is started, rockchip_i2s_tdm_hw_params() is called and
>     does the following two calls
> 
>  2. rockchip_i2s_tdm_calibrate_mclk():
> 
>     2a. selects mclk_root0 (vpll0) as a parent for mclk_parent
>         (mclk_tx_src), which is OK because the vpll0 rate is a good for
>         192000 (and sumbultiple) rates
> 
>     2b. sets the mclk_root frequency based on ppm calibration computations
> 
>     2c. sets mclk_tx_src to 49152000 (= 256 * 192000), which is also OK as
>         it is a multiple of the required bit clock
> 
>  3. rockchip_i2s_tdm_set_mclk()
> 
>     3a. calls clk_set_rate() to set the rate of mclk_tx (clk_i2s2_8ch_tx)
>         to the value of i2s_tdm->mclk_tx_freq (*), i.e. 50176000 which is
>         not a multiple of the sampling frequency -- this is not OK
> 
>         3a1. clk_set_rate() reacts by reparenting clk_i2s2_8ch_tx_src to
>              vpll1 -- this is not OK because the default vpll1 rate can be
> 	     divided to get 44.1 kHz and related rates, not 192 kHz
> 
> The result is that the driver does a lot of ad-hoc decisions about clocks
> and ends up in using the wrong parent at an unoptimal rate.
> 
> Step 0 is one part of the problem: unless the card driver calls set_sysclk
> at each stream start, whatever rate is set in mclk_tx_freq during boot will
> be taken and used until reboot. Moreover the driver does not care if its
> value is not a multiple of any audio frequency.
> 
> Another part of the problem is that the whole reparenting and clock rate
> setting logic is conflicting with the CCF algorithms to achieve largely the
> same goal: selecting the best parent and setting the closest clock
> rate. And it turns out that only calling once clk_set_rate() on
> clk_i2s2_8ch_tx picks the correct vpll and sets the correct rate.
> 
> The fix is based on removing the custom logic in the driver to select the
> parent and set the various clocks, and just let the Clock Framework do it
> all. As a side effect, the set_sysclk() op becomes useless because we now
> let the CCF compute the appropriate value for the sampling rate.  It also
> implies that the whole calibration logic is now dead code and so it is
> removed along with the "PCM Clock Compensation in PPM" kcontrol, which has
> always been broken anyway. The handling of the 4 optional clocks also
> becomes dead code and is removed.
> 
> The actual rates have been tested playing 30 seconds of audio at various
> sampling rates before and after this change using sox:
> 
>     time play -r <sample_rate> -n synth 30 sine 950 gain -3
> 
> The time reported in the table below is the 'real' value reported by the
> 'time' command in the above command line.
> 
>      rate        before     after
>    ---------     ------     ------
>      8000 Hz     30.60s     30.63s
>     11025 Hz     30.45s     30.51s
>     16000 Hz     30.47s     30.50s
>     22050 Hz     30.78s     30.41s
>     32000 Hz     31.02s     30.43s
>     44100 Hz     30.78s     30.41s
>     48000 Hz     29.81s     30.45s
>     88200 Hz     30.78s     30.41s
>     96000 Hz     29.79s     30.42s
>    176400 Hz     27.40s     30.41s
>    192000 Hz     29.79s     30.42s
> 
> While the tests are running the clock tree confirms that:
> 
>  * without the patch, vpll1 is always used and clk_i2s2_8ch_tx always
>    produces 50176000 Hz, which cannot be divided for most audio rates
>    except the slowest ones, generating inaccurate rates
>  * with the patch:
>    - for 192000 Hz vpll0 is used
>    - for 176400 Hz vpll1 is used
>    - clk_i2s2_8ch_tx always produces (256 * <rate>) Hz
> 
> Fixes: 081068fd6414 ("ASoC: rockchip: add support for i2s-tdm controller")
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> ---
> 
> I don't know why such a complex yet incorrect logic is present, but it is
> possibly a remnant of the downstream 4.19 driver
> (https://github.com/rockchip-linux/kernel/blob/develop-4.19/sound/soc/rockchip/rockchip_i2s_tdm.c).
> It might be that the CCF was not yet capable of optimally reparenting back
> in 4.19, so it did make sense back then.
> 
> <snip>


Hello,

thank you for your patch series fixing this driver. Since I am the person
currently listed as the maintainer of it and was the person who originally
upstreamed it, I think I can provide some insight.

The mclk calculation and reparenting code indeed originates from the
downstream driver. As for why that driver did these calculations itself,
I do not know, but I do know why I did not remove them and rely on the
CCF to do the reparenting and such for me.

For starters, I did not know that the DAI and CCF code have functionality
to automatically reparent clocks based on the audio rate. The reason I did
not know this is because after looking at the official kernel documentation
at [1], I did not see any mention of this.

Similarly, the documentation for the CCF at [2] also makes no mention of
this feature. In general, guidance for how to properly write a DAI driver
in the kernel documentation is sparse, though I am extremely grateful to
broonie for his patience in answering some of my questions I had at the
time. The input of any of the reviewers at the time, including that of
Rockchip's engineer who wrote the downstream driver, made it a lot better
than it initially was.

Had somebody brought up the existence of this functionality during the
reviews of this driver's original submission, I would of course have
fixed this. I do not blame the reviewers or maintainers, as they have
enough on their plate as-is and don't owe me anything. But I am trying
to explain the circumstances here that lead to mclk being slightly broken
for this driver.

Naturally, now that I know that this functionality does exist, I can do
a web search (since in-tree documentation search was fruitless) for
"linux common clock framework reparenting", which as its second result
brings up a PDF of the slides of a talk by one of your co-workers.[3] The
slides do not contain the string "reparent", though they do tell me that
I am able to purchase Linux kernel development training from your
employer.

What I'm trying to say here is that I still don't know how the DAI
reparenting mclk through the CCF works, and I'd probably need to dig
into the implementation to even know that it does this. Furthermore,
your employer has an economic incentive to keep this information out
of the in-tree documentation.

I hope that clears up any confusion as to "why such a complex yet
incorrect logic is present", and what ultimately lead you to having
to write this patch.

As for the patch itself, I'll hopefully get around to testing it this
week on an RK3566 board, as your cover letter does not list the platforms
this was tested for regressions on, so I assume you're just using RK3308.

The RK356x has some linked clock things going on which mainline does not
yet model properly as far as I know (which is why some video related clocks
are marked as critical, and why things like [4] are needed for MIPI-DSI
output to work. So any changes that might fiddle with the parent clocks
I'd like to validate. If I don't get around to it in a timely manner
however, I'm fine with this patch as-is.

Regards,
Nicolas Frattaroli

[1]: https://docs.kernel.org/sound/index.html
[2]: https://docs.kernel.org/driver-api/clk.html
[3]: https://elinux.org/images/b/b8/Elc2013_Clement.pdf
[4]: https://github.com/CounterPillow/overlay-examples/blob/main/quartz64a/pine64-lcd-panel.dts#L56-L62



