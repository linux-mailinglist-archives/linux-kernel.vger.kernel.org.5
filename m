Return-Path: <linux-kernel+bounces-59276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EEB84F46B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 12:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63E212816C9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D18928DD7;
	Fri,  9 Feb 2024 11:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="ol0wnsHx"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEED2D79D;
	Fri,  9 Feb 2024 11:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707477515; cv=none; b=i8FgUW7P3t5IamWi38KIL512aB5yVVWourMibDNwOXzWaJvs0DnLrHqKWATg8kll0IR7WD40Q3vQ/l0f4UlvAWjwohxYIlOnTN3h7r8WpbfDuMVQCdri1edu9LcNFzoK6yKtJxvDLmDVMNQMeQ69vzg6Jk4YU/su42MnOskEZNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707477515; c=relaxed/simple;
	bh=0yEKW0rm6SR9B4agFV/bN/drIxo98Pq+AKmM5QuTc/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qkdc4UzneYEPPYO8PnM/3bWWHtybarUT9TzIhFFhZlLDgWwiUOzcttLpWXjuiuNLlKDuvg8oGpIaAZQuSpZGADB0FfWjBbZk6iH0lJKYdqPYfQyNyNuBwLDI8kjk3L+/Kko40bacTbI9f4AkER766WMlOBsb94s+Um9IkNr6yaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=ol0wnsHx; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 7676922AD1;
	Fri,  9 Feb 2024 12:18:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1707477502;
	bh=8E0rw2dmwO1kasJctTwr0gBrKYcerfbQMAP6ZEap66g=; h=From:To:Subject;
	b=ol0wnsHxvu6RjsHBqnd/Mmtbk5feg75qmdwn74N/4UZy49kzqpbh35nXY+4VsPUaW
	 wvRx36EUXN7DKDw+hR1iRqTIsADaXSuboSpyY4iWyu3GwFg6ySiLP2u6Q/3YDdYUcN
	 d1QlewDrm4NL9/m5VkmdTaMJZkMx53vptRyjk69d7BCwbvEAjAYvLk91eROFzYdE0j
	 ccgl5wiVf9hkIYR+3X20TYiR5tieSfCOq5QzMEA01MRms57jLCj2XyR33oXzWvpJuv
	 7YRf5cyba0nZDpSE/Rx9lynYBugs6PJx2tZRd8N03FBDJdk4gDC/879AA5LJnSMtWl
	 5PWZjw1nHswQQ==
Date: Fri, 9 Feb 2024 12:18:17 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: ti: verdin-am62: add support for Verdin
 USB1 interface
Message-ID: <20240209111817.GA6769@francesco-nb>
References: <20240209110500.22193-1-andrejs.cainikovs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209110500.22193-1-andrejs.cainikovs@gmail.com>

On Fri, Feb 09, 2024 at 12:05:00PM +0100, Andrejs Cainikovs wrote:
> From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
> 
> Add support for Verdin USB1 interface, implements role switch
> functionality using "gpio-usb-b-connector", VBUS is also now
> controlled with "regulator-fixed" using a standard GPIO.
> 
> Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>


