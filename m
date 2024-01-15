Return-Path: <linux-kernel+bounces-26504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D281B82E236
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 22:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 051E51C22293
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 21:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AEA1B285;
	Mon, 15 Jan 2024 21:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SB2hnLh1"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AB81B270;
	Mon, 15 Jan 2024 21:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DA110FF803;
	Mon, 15 Jan 2024 21:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705354110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rct8yHdNHfP9b4Gqe7NZACWXejjU4EyImlY46YUEMpU=;
	b=SB2hnLh12i4NYdiFIA3ZGcnsb/J1SVCuJdt9pjg4ptxuqRpXy3DLO0E7ymIkcUOMvFmNZy
	PgTly8u/Z5bcXz90ox9UL7MbAaUWlD0q+fWre9Vh9tqNMe0v2b/hfKLodIcZ84gA6mtNZH
	qpfUO8Hu5a2prCJxW6ZSJg/ZfF3NxCq4m19Fl3UFeRgnaePgAEERFmXb+5hpLsdNnE+e7m
	pQUfws2jdI1Khb0IhrQuoD8Veerpm1COsuRXjWbZdWazotv+0BeQtjnr9xv0r4G9c/CzAc
	OFmnCoZm8b4gT5JGgg/sE8SqAZbZr1oGyL2/AFG8PErQPHXbtVmXwEUY9b0ISQ==
Date: Mon, 15 Jan 2024 22:28:28 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: ac100: remove misuses of kernel-doc
Message-ID: <170535409306.253773.7862479513182768104.b4-ty@bootlin.com>
References: <20240114231320.31437-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240114231320.31437-1-rdunlap@infradead.org>
X-GND-Sasl: alexandre.belloni@bootlin.com


On Sun, 14 Jan 2024 15:13:20 -0800, Randy Dunlap wrote:
> Prevent kernel-doc warnings by changing "/**" to common comment
> format "/*" in non-kernel-doc comments:
> 
> drivers/rtc/rtc-ac100.c:103: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * Clock controls for 3 clock output pins
> drivers/rtc/rtc-ac100.c:382: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * RTC related bits
> 
> [...]

Applied, thanks!

[1/1] rtc: ac100: remove misuses of kernel-doc
      commit: eea7615b684fc98cd0403beaaa2194e6f029c812

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

