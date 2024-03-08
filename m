Return-Path: <linux-kernel+bounces-96898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 759F88762BA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ADF81F25FFE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF46B55E5F;
	Fri,  8 Mar 2024 11:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UQkr6lrk"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE4E55794;
	Fri,  8 Mar 2024 11:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709896019; cv=none; b=YXYWT86X/2UwHCGbJ7got9JBi3nZ4NHsF6TxEPS02TUbCB67bQ9TtOUGwXGOr1Lh2fTdu4fZ2Hn1cFvT6MzT6VKzCWqIwRY9/PpZ46GfAfxUAo8S43AVIKnBZQ+BAsolyBgOsr6r2uN8ztj5eXabDel0MAQ2JHKNzpvopdZpGU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709896019; c=relaxed/simple;
	bh=pc96kTjeHyJOxzJAi5zGl8BN9tRRP9Rz2uvIYxGZGKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+omBaSImzTRnjpOkZQ/YxVBrRSEYzKb/OPnSE4kHUl9j1mxWTY48IgZSrfSanIbl85AH2VOr58lFPXBqHpVHhvIUppk7CLjMFWgaU3xIouVLxtkVXMDYkPa30/iiSsAi2xDwsMvtQIDaLuO4m6L31UeDLDDC1icv/Fac8s1qyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UQkr6lrk; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F2171240004;
	Fri,  8 Mar 2024 11:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709896014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RHOOcTFio23d7bm8Wr7cdw51uo9YXpicRkSrd+GIRrc=;
	b=UQkr6lrko6Gm8/773ZrwzIlSqPd2WV2F4OMyqgCd1LBqwi1UgVNwbEFvp1ho+SwfIELAPj
	u9xSY/Uaej8yNKpfkQiqyWG2cjz6PgnIqrWM98VD167XSazSUSI1UrV3aDEZqIwZQRj+PK
	Jki7jc+w+kGcOdhc/vXpPQx0o5kbFa8cumucBfZGN/mCbEFyjNFpXcE7v+p4ZoNXso4ThK
	Th4ehp2DAOgXHddMTSiAgR4e7yMD3eb8pqkp/1G9turKImS/6bNNVvhQ3r8IAGDPw20qWD
	LTg514C9RoyhPAGNViJpo5jZkRhpwS4YEGPUXOqAHT//52OK55DZRrEQH5Exgw==
Date: Fri, 8 Mar 2024 12:06:53 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>, John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	"Ricardo B. Marliere" <ricardo@marliere.net>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] rtc: class: make rtc_class constant
Message-ID: <170989597159.2150728.7175155089515338956.b4-ty@bootlin.com>
References: <20240305-class_cleanup-abelloni-v1-1-944c026137c8@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305-class_cleanup-abelloni-v1-1-944c026137c8@marliere.net>
X-GND-Sasl: alexandre.belloni@bootlin.com

On Tue, 05 Mar 2024 15:22:28 -0300, Ricardo B. Marliere wrote:
> Since commit 43a7206b0963 ("driver core: class: make class_register() take
> a const *"), the driver core allows for struct class to be in read-only
> memory, so move the rtc_class structure to be declared at build time
> placing it into read-only memory, instead of having to be dynamically
> allocated at boot time.
> 
> 
> [...]

Applied, thanks!

[1/1] rtc: class: make rtc_class constant
      https://git.kernel.org/abelloni/c/6b6ca096115e

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

