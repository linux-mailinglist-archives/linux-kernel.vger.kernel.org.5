Return-Path: <linux-kernel+bounces-149028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDDF8A8ABD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 772E1B23ADC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8317B172BD7;
	Wed, 17 Apr 2024 18:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKAUBtKX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA70171085;
	Wed, 17 Apr 2024 18:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713377131; cv=none; b=j3fXK1twyebw9d7jyWahS2+ljIBRa4skFVvOJTmeXA028N0DtjqG+3TVhLQFZEyGtUAmqyKbCCsJHd5P9/NBxq67SMm/b/4nHu+xgZSSTNxHivDtmlEIp66LcHm/oMAvkcbuKYTTaPx4BMitur9teQh+e7Qir19uQ0WxQ1X/nbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713377131; c=relaxed/simple;
	bh=wWg0evY70j7O2ptDiIFqWXBFa8YgVMN0uY+QB1WSV3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZU7owY4H1FiM2eM1KI20mc2OU45RlS2g0c72pNnMVbDvvSU0YqX4JOApzKRnh7vipc2DsGyyex4JQuaaesnLHC2ZF1tuPg7D0ciQF1JWveVI3J/PEWh7bRp0gSc+o6NaTu4g6l3b8D0xGKBARvWIBU9ygQq2SoxRfN3wcCTci8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKAUBtKX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19319C072AA;
	Wed, 17 Apr 2024 18:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713377131;
	bh=wWg0evY70j7O2ptDiIFqWXBFa8YgVMN0uY+QB1WSV3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DKAUBtKXRILetMDDwlvRHJlMqgoFwzizrz2MSgdnkBQlA5ZVvXfo1ZOpir29lTQ0E
	 cu+FtsLF7QiSnBQqCCVYSq/mdzPzJcY6kQwe2QnrXmOiom/F1h54f3CxMRaJmn5hGS
	 dOb7I8XpPqhaNXSxK2g//5WSE/tQ1vfNDmiajSoHo4v+rguXwux7r8oTi11QJsmA9t
	 NlOG9Hyx+7XvWbZBrWVnUTtKJlvEmvynw/nBkyhF3mwznaPhpU4g9NJkOLhhG09Ing
	 Pi+9VaNqJZdcvDm4ldUjvgKr5lj9E0Z+Bse9fQ/U/zzX9rRRoBRrGNrOHTg4ppww1N
	 0S3JI7ASdoeCg==
Date: Wed, 17 Apr 2024 13:05:29 -0500
From: Rob Herring <robh@kernel.org>
To: Seven Lee <wtli@nuvoton.com>
Cc: alsa-devel@alsa-project.org, robh+dt@kernel.org,
	u.kleine-koenig@pengutronix.de, KCHSU0@nuvoton.com,
	broonie@kernel.org, dardar923@gmail.com, edson.drosdeck@gmail.com,
	CTLIN0@nuvoton.com, perex@perex.cz, lgirdwood@gmail.com,
	YHCHuang@nuvoton.com, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org, supercraig0719@gmail.com,
	scott6986@gmail.com, devicetree@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org, tiwai@suse.com,
	linux-sound@vger.kernel.org, SJLIN0@nuvoton.com
Subject: Re: [PATCH v2 1/3] ASoC: dt-bindings: nau8821: Add delay control for
 ADC
Message-ID: <171337709700.2869242.15474131281609320459.robh@kernel.org>
References: <20240415070649.3496487-1-wtli@nuvoton.com>
 <20240415070649.3496487-2-wtli@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415070649.3496487-2-wtli@nuvoton.com>


On Mon, 15 Apr 2024 15:06:47 +0800, Seven Lee wrote:
> Change the original fixed delay to the assignment from the property. It
> will make it more flexible to different platforms to avoid pop noise at
> the beginning of recording.
> 
> Signed-off-by: Seven Lee <wtli@nuvoton.com>
> ---
>  .../devicetree/bindings/sound/nuvoton,nau8821.yaml         | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


