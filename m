Return-Path: <linux-kernel+bounces-29480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 372BE830F19
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67E2B1C21EF7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5677D286B1;
	Wed, 17 Jan 2024 22:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hy13pLgU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E05225578;
	Wed, 17 Jan 2024 22:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705529579; cv=none; b=XHBYxfa3ctpyqsnJAFe7zlq2ZmF0FO3qtDnImCBE/scMcJ7f2/XCmGWD7JubUzYRPzOyW2UmBLMMAM/vTw4vCzqYc2hDVmVf/NHLFGp2xI8Pqy6w6SbvR9U1sKVXGbnjhzZgRaosL1dBNKzAPJmllIGtu3B6VHOCcqjay1ycfGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705529579; c=relaxed/simple;
	bh=8ZWxxi+E/NaAerdbYPGUdfNwkBPBn68aCAqzPkx21BI=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To; b=ftn/e4Pr9tOGc511odpEINn3MTCFACRjPgnuiP7tOTVU5lRDggYLRw5U+Onz47W+DDWxowYNDgbAxB2Om0nX4PKPUBxJbvIQGo9eh3Y4mjRvrzA77AARHu8Plvc3AMUfs+znLf6f8xps1M2deW1DkDxM1nteInBlYogS6g/qg9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hy13pLgU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366C2C433F1;
	Wed, 17 Jan 2024 22:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705529579;
	bh=8ZWxxi+E/NaAerdbYPGUdfNwkBPBn68aCAqzPkx21BI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hy13pLgUCZM9Cr9Mlhi2+r087lFjuBzxKcwWKCE33sdWkqqLlMbZPu0x58lWa3ifS
	 5sDSXoRLV48G5GqUPuiZ0fmuYWSkfTzXOQB06gLf77s3eXqrMoRgCtcCTfYlpRQ8Kn
	 2a6DzCbW3u7awNfEEnMqo9fTiPAoY7nQZB4fH+c+89OlNZlYY5+XqEfo0k5EZRPn2L
	 dlkW/4Z5XU59ZWYYEs4nmEDbCYyKh0bS/UX/8NVkEqyotdLUkYjo326UjqhlL8YiMU
	 uQ2xFbWNPgyOoD1QoB/zColCTH5h6zP/aNjtFkQEfhrhAaFDcyoztUnIV7AynG9GIF
	 2judcQFmWvL5Q==
Date: Wed, 17 Jan 2024 16:12:57 -0600
From: Rob Herring <robh@kernel.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: devicetree@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	linux-leds@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Lee Jones <lee@kernel.org>, openwrt-devel@lists.openwrt.org
Subject: Re: [PATCH] dt-bindings: leds: add FUNCTION defines for per-band
 WLANs
Message-ID: <170552957658.3342080.9497026905150979511.robh@kernel.org>
References: <20240117151736.27440-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240117151736.27440-1-zajec5@gmail.com>


On Wed, 17 Jan 2024 16:17:36 +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Most wireless routers and access points can operate in multiple bands
> simultaneously. Vendors often equip their devices with per-band LEDs.
> 
> Add defines for those very common functions to allow cleaner & clearer
> bindings.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  include/dt-bindings/leds/common.h | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


