Return-Path: <linux-kernel+bounces-71961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2152285AD15
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0B1928346B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05357535D5;
	Mon, 19 Feb 2024 20:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XlVXn4l/"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242B553370
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 20:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708374238; cv=none; b=rf9/InuSqNCqmxMg5u2+XFLpahxxSMQJFjXVjeD2XivxaRUB0TTA8sY9rgtnncFokUb78cf5Bn75KYu1p1nJqFmj/2XrdKMeL1tnamufFj+o9JpHMeb/viTR5UOu8AAnvM4FeRwwz3Tv/loEvZF8u7qrOc2WC/K9b0ox1l13f4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708374238; c=relaxed/simple;
	bh=bW1B7xqKWaflET/uYDSt2U76ZdSUEcx7OIVHcRn39qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGkH/C+t/g/BkU3R1nd+koywtuKyfio9UAXxFkBvOBvYnl24Peyw5rfFAK/GjmtWq0phPERAR1br3E4QWQ8gz66jHkOIuyufaGXFYWMKgW1d5avPzHojn2PmH2+/bl9jbfQdMc3BdsZ1LFcSdmKZ2bAupTFxLMw9iwn0Lw08hmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XlVXn4l/; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4A8B11C0005;
	Mon, 19 Feb 2024 20:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708374234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ENwTirO4C1/iRzyEhoHRKBL7ZzGNHVOtywGsyH0UrIA=;
	b=XlVXn4l/X4q8IHBmOu1XGQ9lVaMpOyIYlWmIOpEQT0m3wUU15omjmsHqZ62IkPPWy8AXBs
	ceVJM9GQ6B7StPLaBzaNQ7wr/PKKmC1LMxFalwD1PSug6zFiFg5X9YCaZsOAWfIsyuy3uF
	FUV5oDSCnC07JtUT+WPIX2+XJghhiYLVOIdV564py37m0O0Gxan37f6uon5dSO8iT+5kLB
	2cDdRu9ZA5uL2UNoo67zowCJ7tK7FAPnNfL6ahW5tW6c9eiNz3xX/r4Q8fPcL71RA8tDf0
	YO6HV67lQcopiHV3sS6n3zgDGmiXH33ueQEJDMgftRd3KXhXX7h65gEF4P+uhw==
Date: Mon, 19 Feb 2024 21:23:53 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] i3c: Make i3c_bus_type const
Message-ID: <170837422443.1277872.13909189733337460411.b4-ty@bootlin.com>
References: <20240213-bus_cleanup-i3c-v1-1-403aea18f05a@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213-bus_cleanup-i3c-v1-1-403aea18f05a@marliere.net>
X-GND-Sasl: alexandre.belloni@bootlin.com

On Tue, 13 Feb 2024 11:37:31 -0300, Ricardo B. Marliere wrote:
> Since commit d492cc2573a0 ("driver core: device.h: make struct
> bus_type a const *"), the driver core can properly handle constant
> struct bus_type, move the i3c_bus_type variable to be a constant
> structure as well, placing it into read-only memory which can not be
> modified at runtime.
> 
> 
> [...]

Applied, thanks!

[1/1] i3c: Make i3c_bus_type const
      https://git.kernel.org/abelloni/c/8f06fb458539

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

