Return-Path: <linux-kernel+bounces-137968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4FD89EA85
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CFB81F249C6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5BC29CFA;
	Wed, 10 Apr 2024 06:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="k0v2iylN"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250DE20DDB;
	Wed, 10 Apr 2024 06:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712729636; cv=none; b=PfSDTUX/nApAjMU3bLnx3gnuYdTOrGSoKZaF8o9CW1Q0UP5iApZiKifA64QTj+UOW+gNKLlpKrkQ3zLlVXEpYi3hYvLjHpIP+5AXWf7N5IbDfumb5Z8fYibnfOr00XEjp1MWWPqTQQnJmq+d03LozoLjqJnYy7wxvVI1O7W1FY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712729636; c=relaxed/simple;
	bh=w8BQn8R5ezAr2HjT1k+QNveNzTEVZOOD0xc+VGKZ60s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMs24mQxkIye+WU1ggFFjSpXXpC4+FvjCPYb6gjMzsylcKnGllxQEkO7O7JhpfJjE2PuVECv9M9/ui4JKPxvwl2iCpYuu1D7cGjcIwDfAvXL83R4rtTxPDamR2JXvTaNCWHCbhictrJJeIss8GELr4oe02drtCTDrxqRiAlb4oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=k0v2iylN; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 3F96660406;
	Wed, 10 Apr 2024 06:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1712729634;
	bh=w8BQn8R5ezAr2HjT1k+QNveNzTEVZOOD0xc+VGKZ60s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k0v2iylN7QMgoGhyo65weD98r3bd1g2P2iXuzB74aERgFSs0+Ky51w1cPqKXmxdqA
	 yqcejT3KUdogfneWjW4LIC7fC3WnorzM/kpOyhiS2Ri+SXskJF/dcsjEvxSw+tV3Bh
	 IM9gjZ5BZPy33O8XSllCPKTGe0p0F8Qd9OD1LOxhBZz53ijxBToFfoTQNJ9Uytevyz
	 DKZc52PyR45qLVekpv9UNR8YHh472/XHxLH3ujkNRO7H6yI5vjk93L7j6mqd8LL+LN
	 tF7U/C9Scsk/Ig+oLaxMg5wYDYXDexKZFtWN3MyS8MQ+sh6IKbuZVnDd1ZlP8V8qNo
	 DoXolcRXNEu5A==
Date: Wed, 10 Apr 2024 09:13:27 +0300
From: Tony Lindgren <tony@atomide.com>
To: Nishanth Menon <nm@ti.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	=?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH 1/2] arm64: dts: ti: k3-am62p5-sk: minor
 whitespace cleanup
Message-ID: <20240410061327.GB5156@atomide.com>
References: <20240208105146.128645-1-krzysztof.kozlowski@linaro.org>
 <171269138685.642844.11136653326464585397.b4-ty@ti.com>
 <63fc911e-8906-43d0-a4bf-80ceac83d178@linaro.org>
 <20240410003952.wnxayyiyqxkgj7we@supplier>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410003952.wnxayyiyqxkgj7we@supplier>

* Nishanth Menon <nm@ti.com> [240410 00:39]:
> On 22:04-20240409, Krzysztof Kozlowski wrote:
> > On 09/04/2024 21:36, Nishanth Menon wrote:
> > > Hi Krzysztof Kozlowski,
> > > 
> > > On Thu, 08 Feb 2024 11:51:45 +0100, Krzysztof Kozlowski wrote:
> > >> The DTS code coding style expects exactly one space before '{'
> > >> character.
> > >>
> > >>
> > > As discussed offline, I am picking this patch up.
> > > 
> > > I have applied the following to branch ti-k3-dts-next on [1].
> > > Thank you!
> > > 
> > > [1/2] arm64: dts: ti: k3-am62p5-sk: minor whitespace cleanup
> > >       commit: 45ab8daed512258c07fd14536a3633440dabfe84
> > 
> > What about the omap one (second in the series)? Shall I take it?
> 
> I had poked Tony about it (he is the maintainer for OMAP). Tony: could
> you comment?

Krzysztof, please go ahead apply it, it's not confilicting with anything
I have. I just acked the patch.

Regards,

Tony

