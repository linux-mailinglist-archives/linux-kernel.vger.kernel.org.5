Return-Path: <linux-kernel+bounces-25918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B211182D832
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 12:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE2A61C2193A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89772C1B8;
	Mon, 15 Jan 2024 11:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hx2+ECDi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0043928DD1;
	Mon, 15 Jan 2024 11:16:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F34C433C7;
	Mon, 15 Jan 2024 11:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705317414;
	bh=9amLBHHFLhVWl2s3Mc2Mg4JhgTx4Ad8TONAJmlCwYuQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hx2+ECDiMx9gn2LUr4al7jYhuGPaUX9YtifNjsbFxTTlpAx05aBaTouOFslgf3ham
	 W10FIcw1tFCvxVWaco5Xfe+izCOrCrQYz7hMPYBjtYbqwmNdTpn/jOYu1UDKz4m0a/
	 oHRyTSwA+UIfwyfG35Ktj6gTB8L5c7yj+ik5uK/TTJ1nZRsA0gsEohPZmX929jw7Qu
	 c3OTt59lvF1TIW6xW8jHhCDRa3dqGzeAgiAvp3PB/qQPdwYYj9gfS7kZT55A4qbJit
	 YGOQR4LIiHZlSvOCFBUlBaV2V5oa/BnFpydRtqSEY4N5QKXCZhF7b3gyr5gQzXWmdM
	 xy0TnIBbfJ2AA==
Message-ID: <70949e97-2ae5-427b-8730-dd333829ec88@kernel.org>
Date: Mon, 15 Jan 2024 13:16:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-am625-beagleplay: Use the builtin mdio
 bus
To: Sjoerd Simons <sjoerd@collabora.com>, linux-arm-kernel@lists.infradead.org
Cc: kernel@collabora.com, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
 Tero Kristo <kristo@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240112124505.2054212-1-sjoerd@collabora.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240112124505.2054212-1-sjoerd@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/01/2024 14:44, Sjoerd Simons wrote:
> The beagleplay dts was using a bit-bang gpio mdio bus as a work-around
> for errata i2329. However since commit d04807b80691 ("net: ethernet: ti:
> davinci_mdio: Add workaround for errata i2329") the mdio driver itself
> already takes care of this errata for effected silicon, which landed
> well before the beagleplay dts. So i suspect the reason for the
> workaround in upstream was simply due to copying the vendor dts.
> 
> Switch the dts to the ti,cpsw-mdio instead so it described the actual
> hardware and is consistent with other AM625 based boards
> 
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

