Return-Path: <linux-kernel+bounces-107213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2786087F953
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 594691C21A92
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D365A548F6;
	Tue, 19 Mar 2024 08:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="g/x+FVBm"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A70354657;
	Tue, 19 Mar 2024 08:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710836236; cv=none; b=a/MNqi+bMrpgz/VKh7ZD29JqbiKDJQap3AXhQJV1Jd06aCJGiRUXUTI/Gfmx1xsFq/isGibmBW8mPXJ2BO7jyYn3sq5zXp5Lwm/85ESant1gN2c9IFnFFlAYHxW/rPHjIIFGjQps20j7G5QWiJNN++Cb2ELn9wDLrz+/9KWJj/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710836236; c=relaxed/simple;
	bh=uzonqETjBL7wvsx1e0qgd7nuZrbRUOV/H6cEp0IzqiI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=hiFwzu/ypM0ZwzPoz3E4EWy3noZwijUs9aGjKLrDGacC3Qi0jtq/GhwyB1rrzRTrezlhXY+SsJkJwoMq5/9HE/lZR/z9sAjJCbPJDws7w3hohmcdQ0/S1KTEwP0bnYyoZq2Z8elXJzsuxwEtaYVMmZzGLuhy3UuteuOmbWAu+1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=g/x+FVBm; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1710836202; x=1711441002; i=markus.elfring@web.de;
	bh=uzonqETjBL7wvsx1e0qgd7nuZrbRUOV/H6cEp0IzqiI=;
	h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:
	 In-Reply-To;
	b=g/x+FVBmnu61tRamL12tuhNDgx9SMWTYiZfQkebr6p5v+WBg2maOW+/qaWRrTBWN
	 VB+0loBcCKFAwCqSbczc04X5EwwCxQtAiLuBUpRvxCs7EvSZh7ZAV0GCjh6Iq2muU
	 VQGW4RlC/wcDbhP1jNgFf6F4cLBlC6I4oB+GMS1eTmumBWxawOpWhY76p/X3H+p9m
	 6kXQAsJPix8kmeK0/Rk+wqDHYn3fuwQdyvG4rkHbfrCc9u6g2aAb2xK0Jgsdkg8Gb
	 3pMfRU1b/5vUujSZBIeyzhbBS3lFbf/yZHA+3mWqagbq361zWpCaX7rwsS9oLwfhA
	 vTZ2vRMylGwzZ9SCrQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N62uQ-1qgPOE11Sq-016FmE; Tue, 19
 Mar 2024 09:16:42 +0100
Message-ID: <96d3951d-b349-41b8-aabb-a192ad48998f@web.de>
Date: Tue, 19 Mar 2024 09:16:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ayush Singh <ayushdevel1325@gmail.com>,
 Vaishnav M A <vaishnav@beagleboard.org>, devicetree@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, lorforlinux@beagleboard.org,
 greybus-dev@lists.linaro.org
Cc: LKML <linux-kernel@vger.kernel.org>, Alex Elder <elder@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Conor Dooley <conor+dt@kernel.org>,
 Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jason Kridner <jkridner@beagleboard.org>, Johan Hovold <johan@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Mark Brown <broonie@kernel.org>, Nishanth Menon <nm@ti.com>,
 Rob Herring <robh@kernel.org>, Robert Nelson
 <robertcnelson@beagleboard.org>, Tero Kristo <kristo@kernel.org>,
 Vaishnav M A <vaishnav.a@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
References: <20240317193714.403132-3-ayushdevel1325@gmail.com>
Subject: Re: [PATCH v4 2/5] spi: Make of_find_spi_controller_by_node()
 available
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240317193714.403132-3-ayushdevel1325@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:0IHwukSICsCvj6kPOCM3vt8fzMgYs/nIP5+26Xk+rQXIsUzZooI
 yGP3OV6ldYmxeHm2sAIVkY+9nJvFtrdDZN/XkROgbABzLnr54XgLc6V8sVdES6oSJd7NXAG
 8v0SQgMz+JZkWW1zSywvHayFEufEtYWVzKC/6RuQo8lZpX1h4nZq5bNqOBKaPR4xuGUcQVc
 JH1Xw2XHEk8zmSykpitlg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3RBMOAKdwIU=;MKcjDM5zaXWSHwJ3rfDeQAu0vxs
 QaiauQyp0eKMC+n3+IcKn7LreYpPleAmDqehCAaTqKdQtF5ksxCfKRDkQVDHxmS9U2xwZ9j+A
 VYk8ByHVzuv/CLjL3engeFaYfJUrr298Ji2ZwzOPLLnMlF4Y7evl8uGs0whg4l3hBABcNvPe/
 +u9CvF+oXof3XNRe1JzHrqVr17f29WqX8mUUDQb9Ob1DohNT6gLh5IYZhD+Y9Eif/iVomVD20
 GJ3kGUE8RNvWkVoii18Kqb0uKG1dErlheEMQTf+vpnkLcRB3KuXkYBltR6jbW0cAgNhO7mpSk
 X3m0OIdd8YBS4rAe1yb0q3Et4Thg0iZjU7M3LcAljSRCH4b+SGcZxrszCTyIR4PnZRVpBufHr
 SIrDDqYXPBPrI3Lw2kMKrNMr1Ly0Qf52563Wcy3f7RR0W7OmmS39HltOkccDs4qUDPCyalKiL
 6bBsH3B0kM2SI9oh2OfV92BJMo/cnjFsyY24Zu7eyTpmWYEDil4AjhvYcbW1mVCj2GO3nVevE
 Hi2YWkTvGx15hFAIQ3qckXQBj7r8WRqbpvVKR0td/Dqt80qld30zgr7uzh9cX9z6RUvNyU/qF
 qseg/13A2ZkKbkZW6T2XBKOWHg9OcR1aqcree7uYzxRHkMp69TRYhR6ngsjGpCYOjuiBO2pel
 wP4M8pKXhiX+54UzC+0nNZYoLxOr5o1ssvqZHWSfLZZvnlDiWmfUUIdArn7NCR9JcDiDAGQXH
 ql26ZbKO1o54jNSDGE2uuW0l96zPaXNae118jdOHJarYXbFAzp56boBW7AoFnY/sGn18RyOII
 xY1YLTBy9m92bOsur+wqNP5RgdfshRr8ctYLqdM0d+ALA=

> This externalizes and exports the symbol
> of_find_spi_controller_by_node() from the SPI core akin to how
> of_find_i2c_adapter_by_node() is already available. As we will
> need this also for non-dynamic OF setups, we move it under a
> CONFIG_OF check.

Would a change description be more desirable with a corresponding imperative wording?

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.8#n94

Regards,
Markus

