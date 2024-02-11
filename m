Return-Path: <linux-kernel+bounces-60842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C34D850A17
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5163A1C20F36
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 15:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0935B691;
	Sun, 11 Feb 2024 15:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b="dtbevJw2"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812945B668;
	Sun, 11 Feb 2024 15:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707666176; cv=none; b=e4e3eIpLIENHWH1hsRoCn8WHWV1RD6+ydshnGNKS72i4Uo46bAnMMlpVkpIKsujf9dCJnEDe2Q173sSI4lwOI/4+hUXfdEPKSISSVUUtQz9n0Yw/qvRj5UEa4EVXCNqClTQECOA+MTvFh6ORQSAY26bjID2VgSc28Ymebbo1KZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707666176; c=relaxed/simple;
	bh=lhbXjww9UyAKMdiEKIwf186NCMys5erRb0M4pfLaPfM=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 MIME-Version:Content-Type; b=fZGH1rP0r/IlK71rhCgqycn+G/Fpxf4gtpJEDA2iJbitT4wUD3vl0XFNZl8S/5MKedoK+RZotq9jW9mcLdSxCjKcKePl2x/iO5YY6zu3zKETRGIOuMJe1UuysDkIvobvRuxYvxWMkkzMtKcr8KP9Cw7Gjwpoq5v8KNz6knETQ1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev; spf=pass smtp.mailfrom=oltmanns.dev; dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b=dtbevJw2; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oltmanns.dev
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4TXsL23Rdhz9scZ;
	Sun, 11 Feb 2024 16:42:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
	s=MBO0001; t=1707666170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=98aDbHgBbGqJamJlcPsF9M6fGfi3Twm9F/GrRpw8fzI=;
	b=dtbevJw2RvdVTy1+oh5ExI/QO4OF403FR6JiNYzrqWdLydcjnRivDO15lGVH9EtidDlKzl
	oyXvxHTUS2c4XApjWIuMjMOgBxMKmmmDtrkPpSXmfDot5xPTE1TtEO9iGJfByr0YJa8sT0
	FTifdEFNutdUrivRSWb3OFHI/17FqDhzk8iAgTgM/Kq6cQZWiECx2tOPlxJq0xauL8o6/f
	in9z6b7cL4yVjxXoSxoumh0x9U8qViyV1w2GC0AukoHC0EtFBYyXrGKje/BEMpqVxg6wo2
	FoCa5h/xYhFO2TyLCITT9NvnUlOQIuuEBgy3nnNQvBoFXkqUm0Wmo8t4NOo4XQ==
References: <20240205-pinephone-pll-fixes-v2-0-96a46a2d8c9b@oltmanns.dev>
 <20240205-pinephone-pll-fixes-v2-5-96a46a2d8c9b@oltmanns.dev>
 <poua4bzyciiwt65sqjf2whqfdumvoe4h3bkjpf64px2vwgumrf@sai73byg2iju>
From: Frank Oltmanns <frank@oltmanns.dev>
To: Maxime Ripard <mripard@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Guido
 =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>, Purism Kernel Team
 <kernel@puri.sm>, Ondrej
 Jirman <megi@xff.cz>, Neil Armstrong <neil.armstrong@linaro.org>, Jessica
 Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter
 <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 5/6] drm/panel: st7703: Drive XBD599 panel at higher
 clock rate
In-reply-to: <poua4bzyciiwt65sqjf2whqfdumvoe4h3bkjpf64px2vwgumrf@sai73byg2iju>
Date: Sun, 11 Feb 2024 16:42:43 +0100
Message-ID: <87sf1zxb0s.fsf@oltmanns.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 4TXsL23Rdhz9scZ


On 2024-02-08 at 20:05:08 +0100, Maxime Ripard <mripard@kernel.org> wrote:
> [[PGP Signed Part:Undecided]]
> Hi Frank,
>
> On Mon, Feb 05, 2024 at 04:22:28PM +0100, Frank Oltmanns wrote:
>> This panel is used in the pinephone that runs on a Allwinner A64 SOC.
>> The SOC requires pll-mipi to run at more than 500 MHz.
>>
>> This is the relevant clock tree:
>>  pll-mipi
>>     tcon0
>>        tcon-data-clock
>>
>> tcon-data-clock has to run at 1/4 the DSI per-lane bit rate. The XBD599
>> has 24 bpp and 4 lanes. Therefore, the resulting requested
>> tcon-data-clock rate is:
>>     crtc_clock * 1000 * (24 / 4) / 4
>>
>> tcon-data-clock runs at tcon0 / 4 (fixed divisor), so it requests a
>> parent rate of
>>     4 * (crtc_clock * 1000 * (24 / 4) / 4)
>>
>> Since tcon0 is a ccu_mux, the rate of tcon0 equals the rate of pll-mipi.
>>
>> pll-mipi's constraint to run at 500MHz or higher forces us to have a
>> crtc_clock >= 83333 kHz if we want a 60 Hz vertical refresh rate.
>>
>> Change [hv]sync_(start|end) so that we reach a clock rate of 83502 kHz
>> so that it is high enough to align with pll-pipi limits.
>>
>> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
>
> That commit log is great, but it's kind of off-topic. It's a panel
> driver, it can be used on any MIPI-DSI controller, the only relevant
> information there should be the panel timings required in the datasheet.
>
> The PLL setup is something for the MIPI-DSI driver to adjust, not for
> the panel to care for.
>

I absolutely agree. It even was the reason for my submission of a
sunxi-ng patch series last year that was accepted, to make pll-mipi more
flexible. :)

The only remaining option I currently see for adjusting the sunxi-ng
driver to further accomodate the panel, is trying to use a higher
divisor than 4 for calculating tcon-data-clock from tcon0. I remember
reading a discussion about this, but as far as I remember that proposal
was rejected (by you, IIRC).

While I appreciate other suggestion as well, I'll look into options for
using a different divisor than 4.

Best regards,
  Frank

>
> Maxime
>
> [[End of PGP Signed Part]]

