Return-Path: <linux-kernel+bounces-136673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D28F989D6F2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B4A61C21F80
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA6C81ABF;
	Tue,  9 Apr 2024 10:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="B4iPBcOV"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E836FE35;
	Tue,  9 Apr 2024 10:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712658431; cv=none; b=VLDYfALFonhQKfd98aqvQ+O9iJAN0yNqWxiD/AmRpwxPLMkqvuJoqK/hBbFH1eLebfdU9PUvWVExjvr9U9RsgXJwnBkpby4CGuWxO7mvFPvHR0vH4bVFUiyZhZzmxRDGZ9zL697MskkJiGd1ZtmsCqdB/MTAU7cnsCLUOl3vhdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712658431; c=relaxed/simple;
	bh=WmagiJuSAVjdMNloWBpK+TLWohCiwSPpkN8213t8NFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSgvFmgvSQr7K6wuJNqG4SmhRWJkbhdR2uQ6HrNWtyc7ri0lV5mY8yVXdEFwXFHmKXUj9CloRSBKKU9haZ7gIE+XzRCb/qPFOyMeVTsSRb12MDTWw/g0mtLkxPS2eD3ynhVNAvToBWfdV6Qh1hEtwU5p53VtFArm+AoMuUWqzJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=B4iPBcOV; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 12DC6240008;
	Tue,  9 Apr 2024 10:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712658421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IgLT556EQ1sZdDx/D7AZFOXHnmen1aI83W1NiohbSlY=;
	b=B4iPBcOVkx3mfxd+rg95RkbF9UEK4k+DdgW7xqj7tT7F/2vpHwnjQmDQ01ZtZ2oPa6qb4o
	09hXRQXlI1bqDHQc7MN0KzWmcS8dC3mmiBR3PcE1J4p1rg96l1Z2iHM1zoIv581lXIUG8K
	NfCKCTjkTH2u2kWQgbzhk5E9pvoWfSAHVii0/ZMTyKKOcRkJR7qjWrv6ImsjDKaWJStKgs
	ZSueTSYdbsYsNielAvIp9rUoLonaww1JS5vne6O47pRkr+IIEkMbjlzieJrNosCxKvivb1
	YyKnTxhiVH2u+bOnBIuKc3KzzumhN9k6vojpT6uYw0Vz5TWnPch2JjL1wVrwzg==
Date: Tue, 9 Apr 2024 12:26:58 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Vladimir Zapolskiy <vz@mleia.com>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 0/9] rtc: convert multiple bindings into dtschema
Message-ID: <20240409102658d86fb2bd@mail.local>
References: <20240408-rtc_dtschema-v1-0-c447542fc362@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408-rtc_dtschema-v1-0-c447542fc362@gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 08/04/2024 17:53:00+0200, Javier Carrasco wrote:
> This series converts the following bindings into dtschema, moving them
> to trivial-rtc whenever possible:
> 
> - orion-rtc: trival-rtc, referenced in arm arch.
> - google,goldfish-rtc: trivial-rtc, referenced in mips arch.
> - lpc32xx-rtc: trival-rtc, referenced in arm arch.
> - maxim,ds1742: trivial-rtc, not referenced in arch, cheap conversion.
> - rtc-aspeed: 3 devices to trivial-rtc, all referenced in arm arch.
> - pxa-rtc: add missing properties and convert. Referenced in arm arch.
> - st,spear600-rtc: trivial-rtc, referenced in arm arch.
> - stmp3xxx-rtc: convert, referenced in arm arch.
> - via,vt8500-rtc: trivial-rtc, referenced in arm arch.

Probably all the moves to trivial-rtc can be squashed.

> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
> Javier Carrasco (9):
>       dt-bindings: rtc: orion-rtc: move to trivial-rtc
>       dt-bindings: rtc: google,goldfish-rtc: move to trivial-rtc
>       dt-bindings: rtc: lpc32xx-rtc: move to trivial-rtc
>       dt-bindings: rtc: maxim,ds1742: move to trivial-rtc
>       dt-bindings: rtc: rtc-aspeed: move to trivial-rtc
>       dt-bindings: rtc: pxa-rtc: convert to dtschema
>       dt-bindings: rtc: spear-rtc: move to trivial-rtc
>       dt-bindings: rtc: stmp3xxx-rtc: convert to dtschema
>       dt-bindings: rtc: via,vt8500-rtc: move to trivial-rtc
> 
>  .../devicetree/bindings/rtc/fsl,stmp3xxx-rtc.yaml  | 45 ++++++++++++++++++++++
>  .../bindings/rtc/google,goldfish-rtc.txt           | 17 --------
>  .../devicetree/bindings/rtc/lpc32xx-rtc.txt        | 15 --------
>  .../devicetree/bindings/rtc/marvell,pxa-rtc.yaml   | 40 +++++++++++++++++++
>  .../devicetree/bindings/rtc/maxim,ds1742.txt       | 12 ------
>  .../devicetree/bindings/rtc/orion-rtc.txt          | 18 ---------
>  Documentation/devicetree/bindings/rtc/pxa-rtc.txt  | 14 -------
>  .../devicetree/bindings/rtc/rtc-aspeed.txt         | 22 -----------
>  .../devicetree/bindings/rtc/spear-rtc.txt          | 15 --------
>  .../devicetree/bindings/rtc/stmp3xxx-rtc.txt       | 21 ----------
>  .../devicetree/bindings/rtc/trivial-rtc.yaml       | 18 +++++++++
>  .../devicetree/bindings/rtc/via,vt8500-rtc.txt     | 15 --------
>  12 files changed, 103 insertions(+), 149 deletions(-)
> ---
> base-commit: fec50db7033ea478773b159e0e2efb135270e3b7
> change-id: 20240406-rtc_dtschema-302824d1ec20
> 
> Best regards,
> -- 
> Javier Carrasco <javier.carrasco.cruz@gmail.com>
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

