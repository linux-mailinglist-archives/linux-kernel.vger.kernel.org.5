Return-Path: <linux-kernel+bounces-34226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A238375DD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 149A61F270A4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E174879F;
	Mon, 22 Jan 2024 22:09:46 +0000 (UTC)
Received: from luna.linkmauve.fr (luna.linkmauve.fr [82.65.109.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0FB482D6;
	Mon, 22 Jan 2024 22:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.65.109.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705961386; cv=none; b=Kj57YqFZz8wDjmNUlBDAWTflDzHTmyD125GKKXAjPOGrHPKHOj6ojGjBoFTIbeCvgWDkQnV+spHDTcv8VRghoy8jAoJJu6VMCQsksD9XT+KuHg/bOhg3irqpm7Z6tmCypusB5gd5bdoBTGdrG4gzNnMv+x90xN8oSaMYAVQwG48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705961386; c=relaxed/simple;
	bh=5faoDdeLz1HN6ttexbDso49fYiSVmTNRkffSq1+/WG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jh0z74oznogJoMbs+EXEL3r6m+vZES60H9VwTmYnb/9hYs7MSQWb+SbVseFxhoTjZKaX2L1U5VqCu+J9Tlsz8u/sY+wXtQKQxQ/0vWhVavPl9Y1nWEGqbGzVhERIBsVZFe3dPh1EnA2i8OjdP3+LNHTbu4htgw/ZEzyynTY7QEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass smtp.mailfrom=linkmauve.fr; arc=none smtp.client-ip=82.65.109.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linkmauve.fr
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
	id C026DDDAEC3; Mon, 22 Jan 2024 23:09:41 +0100 (CET)
Date: Mon, 22 Jan 2024 23:09:41 +0100
From: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	=?utf-8?B?VGFtw6FzIFN6xbFjcw==?= <szucst@iit.uni-miskolc.hu>,
	Christopher Obbard <chris.obbard@collabora.com>,
	Shreeya Patel <shreeya.patel@collabora.com>,
	John Clark <inindev@gmail.com>, Dragan Simic <dsimic@manjaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Andy Yan <andy.yan@rock-chips.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
	Alexey Charkov <alchark@gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: Add the rk3588 thermal zones
Message-ID: <Za7npejeTD4i9y2h@desktop>
References: <20240122203502.3311520-1-linkmauve@linkmauve.fr>
 <20240122203502.3311520-2-linkmauve@linkmauve.fr>
 <c2963862-9d22-438a-8357-eccf14fead7d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c2963862-9d22-438a-8357-eccf14fead7d@linaro.org>
Jabber-ID: linkmauve@linkmauve.fr

On Mon, Jan 22, 2024 at 09:52:10PM +0100, Daniel Lezcano wrote:
> 
> Hi Emmanuel,

Hi Daniel,

> 
> please sync up with Alexey Charkov (added in Cc) who is doing a similar
> configuration [1] which was reviewed.

Oh, I wasn’t aware of this work, it seems there is nothing this series
add over Alexey’s so I will drop it.

Is there a document tracking your upstreaming work?  I was planning on
sending a series enabling the VEPU121 hardware encoders next, but if
you’re also working on it I can drop it too (although I don’t see any
series from a quick search).  I’ve now subscribed to the linux-rockchip
mailing list so I shouldn’t miss any new series.

> 
> Thanks
>   -- Daniel
> 
> [1] https://lore.kernel.org/all/CABjd4YyL1ZwNOJrWPwZtc7=e4h18a9tQOnuKP6soy=iTHv-WEA@mail.gmail.com/
> 
> On 22/01/2024 21:34, Emmanuel Gil Peyrot wrote:
[…]
> 
> -- 
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 

Thanks,

-- 
Link Mauve

