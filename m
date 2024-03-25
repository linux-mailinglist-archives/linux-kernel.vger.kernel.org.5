Return-Path: <linux-kernel+bounces-117144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0290788A7D0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 340A21C62805
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3032915624A;
	Mon, 25 Mar 2024 13:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1W1M/NM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6A6153BD4;
	Mon, 25 Mar 2024 13:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711373178; cv=none; b=RGw9dbPLnWsQ5jA8oi2eHvdRRpeVwJLEY9K2bav4JKOEbFITY2qWq1fMneHX/5xJQFCthVwg2vW2ACs+a9JWnpAzYyY85CEQrCxSRWY4UZKZphWRSiX5mcReofHoKi3pc6hcXUbbIDZDlTvzwexnO1tPbxAFTu32zpQjMukdwj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711373178; c=relaxed/simple;
	bh=CBLxHwHLIC5NGheEjOprJKxfe/60cHbllRwELJeRVm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKH2zQ4TTFRSLhTg3CgxuPJsjrDNNlBddQSmrjuzPMvxQvVc9P2NQAz/vqFqjcxTLM0zkLtSm9GNBL5t3F4CxqZNH6u+hQKK6P6bJvTQ/k/f2qkKeuS36xk56BcPVvhReDRajBdIUGsuABph5dEoxvZlfl9kH2bwJurIWafglPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1W1M/NM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A29EBC433C7;
	Mon, 25 Mar 2024 13:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711373177;
	bh=CBLxHwHLIC5NGheEjOprJKxfe/60cHbllRwELJeRVm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E1W1M/NMLmo4wStZQPWAg2tnKYTMVOcgLoKczlAprsT76iJw5cmqdW+Y5dGkAZ4mu
	 NOh01LuG+HQYfBAQoPitoM45joAKkz39kRub6z2EteTY3z9tJAZnTBMo0w8+GF4pen
	 Cjtun2+Li7IEJMdjlPGxD0h0tLnnjIYwcA8R6FIX2EYn1n0/sgdJ/iSBR4TIxF5TJu
	 wAzzyM4qs0EIVBWhhqzUE0E5MePrBMMLbn409j+NTaVADNw4GbJFxCql6rlzQ0YqfO
	 504Lk+Y7S2ndbTENWZQk0Oi3dEluTDuw9r/QIbBIbjp5xIPBDkUWtXF8GX//X+1aLS
	 hccD+OHBcBTBw==
Date: Mon, 25 Mar 2024 08:26:15 -0500
From: Rob Herring <robh@kernel.org>
To: INAGAKI Hiroshi <musashino.open@gmail.com>
Cc: lee@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	devicetree@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
	pavel@ucw.cz, conor+dt@kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: leds: add LED_FUNCTION_MOBILE for
 mobile network
Message-ID: <171137317301.3201816.3242642839812091788.robh@kernel.org>
References: <20240323074326.1428-1-musashino.open@gmail.com>
 <20240323074326.1428-2-musashino.open@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240323074326.1428-2-musashino.open@gmail.com>


On Sat, 23 Mar 2024 16:36:09 +0900, INAGAKI Hiroshi wrote:
> Add LED_FUNCTION_MOBILE for LEDs that indicate status of mobile network
> connection. This is useful to distinguish those LEDs from LEDs that
> indicates status of wired "wan" connection.
> 
> example (on stock fw):
> 
> IIJ SA-W2 has "Mobile" LEDs that indicate status (no signal, too low,
> low, good) of mobile network connection via dongle connected to USB
> port.
> 
> - no signal: (none, turned off)
> -   too low: green:mobile & red:mobile (amber, blink)
> -       low: green:mobile & red:mobile (amber, turned on)
> -      good: green:mobile (turned on)
> 
> Suggested-by: Hauke Mehrtens <hauke@hauke-m.de>
> Signed-off-by: INAGAKI Hiroshi <musashino.open@gmail.com>
> ---
> v1 -> v2
> 
>   - move _MOBILE before _MTD
>   - improve the commit description
> 
>  include/dt-bindings/leds/common.h | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


