Return-Path: <linux-kernel+bounces-19026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 435388266E7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 01:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E64912819B5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 00:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8567F5;
	Mon,  8 Jan 2024 00:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fDPkcBOI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9F028FC;
	Mon,  8 Jan 2024 00:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7EC6FE0003;
	Mon,  8 Jan 2024 00:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704673887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q6jfq0a0t9tEPEzM0nx6mY+1Am1h3MhgVwaXE4LjAWk=;
	b=fDPkcBOIP/UwQwZ8XrNOh0So5ZnC8wOYcs2bo37l5gWLdwxN2K48dGnlKDInuCqL1PCA5x
	TeG+iLZf62bHJyWL3yudUjO2k8Ae1vmUgKl4tuotWzUxZLdozLvffpjBT4clA/X3Cud7xt
	VQnydSVfWfItvUs2nKLj5ytWE3Apn8ygv8Gv9kf5YrUIWqY1Qxy9e2YbbYWwJD7j32Orsj
	12Di0sTUkuz8Z3Uz9C0IfQSfzamBVh9wHKYGGKcuQKZ6qcOrX5OuHvDaSNUhMksel0jCgD
	Znw3cGNMo22J4MkJ08Mmbhb7ek4D72ZPx9rvDblxt7in8wdIu458M3v5DTMoJQ==
Date: Mon, 8 Jan 2024 01:31:27 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: a.zummo@towertech.it, Stefan Eichenberger <eichest@gmail.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: rv8803: Add power management support
Message-ID: <170467384896.599798.7611393961491011541.b4-ty@bootlin.com>
References: <20231122181611.164792-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122181611.164792-1-eichest@gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com


On Wed, 22 Nov 2023 19:16:11 +0100, Stefan Eichenberger wrote:
> Add power management support to the driver. This allows a SoC to wake
> from suspend using the nINT provided by the RTC. Only register it as a
> wakeup device if the interrupt is provided and handled.
> 
> 

Applied, thanks!

[1/1] rtc: rv8803: Add power management support
      commit: 2f80de657f83a1f6495e557096847f4626d57164

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

