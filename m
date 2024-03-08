Return-Path: <linux-kernel+bounces-96896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C22C8762B4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 851641C21398
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CDF55C01;
	Fri,  8 Mar 2024 11:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NYEEnRP4"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310702263A;
	Fri,  8 Mar 2024 11:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709896006; cv=none; b=S9vBjSTw3tt7VoMxXt+gzpW+5FjgQPDsgWIDR80c+ut+jU2Atc2bJYjR/3uyl2W9hKP7WsZFj1VQLFDVa4HHGZxh7+trjgTszwdr7RMOTY/twh9z66XOF+nv4cZ/NPpVpMax6l0wj4bgpzhLDQLygX6LEy07r895bEdxyYNWckg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709896006; c=relaxed/simple;
	bh=+r0sFlglxilGxfgPsCjx0wujxdaFgwxOaU0Nw8l+Gzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUtKYn6xcdD/8glAiOj/mT9aRjVVVLTyiENguXk23GSIjvbUFFq+mo/s4xxMnJwRw+Yn/tt0omcXcTaliqgVqBkXkXcq83PdfUs1l3n7gopqnht54ccyVD4bWcz8Hp/Y19bvfnXBhvHFVaktSz3AWkEpJ47ar2yFcfm50ytBqMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NYEEnRP4; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0ABD31BF206;
	Fri,  8 Mar 2024 11:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709896002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Qw6Ut14GxMOVcxSyr6oHQhiQFQ+lkJyhyWsKUTrcvc=;
	b=NYEEnRP4SpUqkQYB3am+XxAn558jt7SSeH4PT3fs4EmVsco550GmQ4otEA1WjsCm8HGsxp
	wOs9JWfcbfsSoQXRFYxGJHqSc8jhTKR5m5C+YHnychjURmfJodjgFwgCCjI3TqFyVgRYqP
	weR3kQ2zfpa3ZdZC9nlsBCpGuLUacoip/OZdYXb9K2eh6ampQDJpeloedUmIsvgsniKKOs
	eeAiyVEckmCnaM8uxNpm46/y4C5R8dchxz3vjoMgF/PmRc+S/12ewkSW/tWt7ejFMfdnZ0
	8oCyHnExiZcD5OT7rniA5hTcxKg46+NPFPcx94Wu5y7T/5qVeryCc1TADRgyNw==
Date: Fri, 8 Mar 2024 12:06:40 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
	Michal Simek <michal.simek@amd.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"open list:REAL TIME CLOCK (RTC) SUBSYSTEM" <linux-rtc@vger.kernel.org>
Subject: Re: [PATCH v3] dt-bindings: rtc: zynqmp: Add support for
 Versal/Versal NET SoCs
Message-ID: <170989597160.2150728.2241720169557341707.b4-ty@bootlin.com>
References: <5ecd775e6083f86aa744c4e9dfb7f6a13082c78a.1709804617.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ecd775e6083f86aa744c4e9dfb7f6a13082c78a.1709804617.git.michal.simek@amd.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On Thu, 07 Mar 2024 10:43:46 +0100, Michal Simek wrote:
> Add support for Versal and Versal NET SoCs. Both of them should use the
> same IP core but differences can be in integration part that's why create
> separate compatible strings.
> 
> Also describe optional power-domains property. It is optional because power
> domain doesn't need to be onwed by non secure firmware hence no access to
> control it via any driver.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: rtc: zynqmp: Add support for Versal/Versal NET SoCs
      https://git.kernel.org/abelloni/c/f0109900462d

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

