Return-Path: <linux-kernel+bounces-147760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F428A794E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 524E51F223E9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6063B13AA2D;
	Tue, 16 Apr 2024 23:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CkAuQl5G"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD16313A869;
	Tue, 16 Apr 2024 23:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713311032; cv=none; b=DdKc9gb/zPtvS2C/UG01s0yXiDN2II515/0HFJkOAih4hvq7e93Y+up8YtGUviL2pKPEEhph+DzcY9vWUXg9rgI++cxe0ecMmARnBcHQbs0s15FW50c+o2QW4BOivqkzBMvJM36r6BPbDkoNI4RN2sg/Udrs2Y1uV6/rsdbPuJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713311032; c=relaxed/simple;
	bh=YEGQ8CgrUzK0nrt4Ie8QLISTZQV93JSwBQbWnBMJILI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C12si8hQOMgs9q4bpQc7kkJwFnotYlpY/pLfBIF+uB576VM1NLNNpjKJNEnbwJrSPTGN4yIKZpBiZ64bt/j6J//8mlURG5WTmbwkdK6KnKnihkSExTqC1cf7/HMDVmDTbSl8xuDlxSjAW2f8gWsyHuP8X16Q76G5tcyC1iqz4I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CkAuQl5G; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 876A61BF203;
	Tue, 16 Apr 2024 23:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713311029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CNDZdf/uKaX+WgPhUphRKuqSwi/q4yBAoxXLi2+EWYs=;
	b=CkAuQl5GbM1DukqBkJHugmme5K2t5dVxJU+RlFEP9U5jtQO1+svXT44hB1PbfU4oHhqROu
	iVmles8c4/AZAaCxiQvZq7Xl+jhCu+TCIOrwywxf6XRsipB3d0+OumsStdeURaRodS7eua
	SpaEPCsPHz9s8rIBZb3J5bQtjxwuJrj5wgHTq7u31FfTErOmYdIpBupaToi9bjIg5afbu7
	WVnXfEDJ/oKsa8cOfJL/lCqpcxnHK1aeNrIdSQUl75kq0+8NaFl5lHsgY743uWGHhqGX8H
	SrYPGFTOL4OPL/PvozJKxyQ3YOXmkxpn7DASTtTNqBeA7vxQUfECY3N5P31RZQ==
Date: Wed, 17 Apr 2024 01:43:45 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] rtc: mcp795: drop unneeded MODULE_ALIAS
Message-ID: <171331101619.12461.12401501300609641415.b4-ty@bootlin.com>
References: <20240414154910.126991-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240414154910.126991-1-krzk@kernel.org>
X-GND-Sasl: alexandre.belloni@bootlin.com

On Sun, 14 Apr 2024 17:49:10 +0200, Krzysztof Kozlowski wrote:
> The ID table already has respective entry and MODULE_DEVICE_TABLE and
> creates proper alias for SPI driver.  Having another MODULE_ALIAS causes
> the alias to be duplicated.
> 
> 

Applied, thanks!

[1/1] rtc: mcp795: drop unneeded MODULE_ALIAS
      https://git.kernel.org/abelloni/c/393e3d290f61

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

