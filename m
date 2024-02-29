Return-Path: <linux-kernel+bounces-87582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0156686D626
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F454B222BC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2078716FF59;
	Thu, 29 Feb 2024 21:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mQ1XDIc0"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060F316FF21;
	Thu, 29 Feb 2024 21:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709242026; cv=none; b=a3jyIJ8Yzp2IRIAd0P0Cp5PA3bAGNz5GyipZJdFyDdC7wMrzGl82YPJBbdw++ZqjxDA8Bxt4R7s4RT2RRNU/ULiLHW0frAos18YQtc6twblAn8d16R1xNzdHiMNvfTiRehdGIofXS9oiap+PdXl+T21o2RPgVtg6mry0CHTZ7eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709242026; c=relaxed/simple;
	bh=mblvUOQ7TqSTXupgS1wYol+Cwc1GOHntbxz2wgg057o=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=puvd8fu++7vjl29gvIOxLPPvgDpCr/4HRsnsBBxlOFeC6ZqhJeBr2SZpPy6CWzzj9JiA7BJVloKxdMOLEUQDd4ZHIt7xJhhJmIBHX5YXmSDchrPqLVehcVAITrmu8WOMBuM7r9jzPAEhycPthhFGVXcIlYPfQknKZffW+10TZzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mQ1XDIc0; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A3F0560005;
	Thu, 29 Feb 2024 21:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709242022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=91a9iOCe0C2brpFvtJay073OL0BwTlq7iXQAv8uj7GU=;
	b=mQ1XDIc0BXJfwzuAOAFJvi0pZ6HSdDJW6hzqvTVvhM0wEOUXe5CdYbRo5NZel09ZnoI2kT
	lBVQNziVg1Tj6NIbLFPwX1rUvjpAjbJ3X7QFTwodRX2A2zUfHLsgNVgi4jpRLLcjmShhWr
	gnJeboq38lMwyrnQXsqe+wah+cKpIvkI2UdCv2AiyEthRcf3w0SLiMZ6UtB7A+PeYtjYs2
	QMOfBTZ8zBFDI7v+nUe82L72f9FjfhfUpx9hjOA95TRdNSdKPAcjx9RXiH4S5jqlCf38HT
	1mOuz1Rq3IzvxPexD+Py8LwCmDHk+7pmHLE7Wa5aznVASevEwdD+QNJooIHN+Q==
Date: Thu, 29 Feb 2024 22:27:00 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Varshini Rajendran <varshini.rajendran@microchip.com>
Subject: Re: (subset) [PATCH v4 11/39] dt-bindings: rtt: at91rm9260: add
 sam9x7 compatible
Message-ID: <170924199301.1874122.10917718116731060869.b4-ty@bootlin.com>
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
 <20240223172552.672094-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223172552.672094-1-varshini.rajendran@microchip.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On Fri, 23 Feb 2024 22:55:52 +0530, Varshini Rajendran wrote:
> Add compatible for SAM9X7 RTT.
> 
> 

Applied, thanks!

[11/39] dt-bindings: rtt: at91rm9260: add sam9x7 compatible
        https://git.kernel.org/abelloni/c/16816e6a3693

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

