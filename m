Return-Path: <linux-kernel+bounces-139743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 173C68A0723
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FBD628854B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 04:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5100C13C3F4;
	Thu, 11 Apr 2024 04:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="a6VipMQr"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF596634EA;
	Thu, 11 Apr 2024 04:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712809818; cv=none; b=OUdSS6qa5O045N3NcmhoZ6N8duOqtUMdx1UILag8bHajO2vZ6LqTh7fABYZ2o/Nk2eOvv8fQrdY7Jyoz2Ubh9QbUzqnUK0SIhvZSdr1/vs4eiCuH8zJNsmaavi1crMApzE1KrEMeEBSKgKmkIiZnCLwbuXiKVgoxUZCYNFyPHp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712809818; c=relaxed/simple;
	bh=RkAGIvTWS+1fvKuGMoJyj1I6+dviqXOdFPWeeg2UCgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9yV1IfGJBlHQzZBSpH70fwaOjRxxfpfbVXWau5GqlTnYIfUrbZ8W3xVjpmNUaKWYzDtmwmdV5C2bex3bHoIq8c+gNaUPgj9gj4Gps7Gmic+KR3gvEfeyhP1+DogXVUVcalm/M5x9zqkpMBoqo/p26SPp1B9KJBM7VNpt6lMMCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=a6VipMQr; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id DC9926084E;
	Thu, 11 Apr 2024 04:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1712809815;
	bh=RkAGIvTWS+1fvKuGMoJyj1I6+dviqXOdFPWeeg2UCgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a6VipMQr+BtNyD5EknoHybxpvlEiutDcseeKlQhSVrrB8MXtWvVyQC+qrgpPe7rWA
	 fZwb51Rj8Lm0l43IykstajzrznGvyj9PRTwpM92Nb1tvZqIErzscE9UObfzIrLZcr1
	 zhUEAWaoIq7NMl9symAmVQ0S1OO17vMIlYmSIxFVlEa2polahBPJm+pth/Re6Hn7/d
	 xh0qJ6ZYCNiKud6efk58HYAvUp7mwE4ZmzE7V1FVv8w3hiFUIXQR5kyq5Lo88AsLIc
	 4QCBwTevqapI88/UPvDVVYeixP5u8rvYKIl6QkUC3WShU7lkKoe0SomfnIQjyHQA0+
	 AdAcA2yReKPlw==
Date: Thu, 11 Apr 2024 07:30:04 +0300
From: Tony Lindgren <tony@atomide.com>
To: Dhruva Gole <d-gole@ti.com>
Cc: linux-omap@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] bus: ti-sysc: Move check for no-reset-on-init
Message-ID: <20240411043004.GC5156@atomide.com>
References: <20240410064010.57142-1-tony@atomide.com>
 <20240410064010.57142-2-tony@atomide.com>
 <20240410180318.ddpbdlnlss7bqweg@dhruva>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410180318.ddpbdlnlss7bqweg@dhruva>

* Dhruva Gole <d-gole@ti.com> [240410 18:03]:
> On Apr 10, 2024 at 09:40:05 +0300, Tony Lindgren wrote:
> > We are wrongly checking SYSC_QUIRK_NO_RESET_ON_INIT flag in sysc_reset(),
> > it can be called also after init from sysc_reinit_module(). Let's fix the
> > issue by moving the check to the init code.
> 
> I am not able to understand exactly the potential bug here, what was the
> issue exactly?

With this flag, reset should be skipped on init, for example for an SDRAM
controller during booting or to preserve a boot logo etc. However, if a
reset is requested later on after init, we must ignore this flag.

> What I am able to infer is this is more of an improvement than fixing a
> bug? Maybe I am missing some context, can you help me understand the
> potential bug here?

We are now also calling sysc_reset() during runtime, so in theory some
device would not reset during usage as requested. I don't think we have
such cases in reality though. So yeah this is more cleanup rather than a
fix AFAIK.

> > Fixes: 6a52bc2b81fa ("bus: ti-sysc: Add quirk handling for reset on re-init")
> 
> Fixes tag, you might want to CC stable@vger.kernel.org?

Let's just leave out the fixes tag as there are no known bugs caused
by this.

Regards,

Tony

