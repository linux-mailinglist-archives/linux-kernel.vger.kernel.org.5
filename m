Return-Path: <linux-kernel+bounces-122834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A455988FE28
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5797B1F267DB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C9E7E59F;
	Thu, 28 Mar 2024 11:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="ck0f47f5"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913D87D3E7;
	Thu, 28 Mar 2024 11:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711625658; cv=none; b=DKvlYi/OK5N8CUd3u5iBQeUrBwBWeMPXWpno1YhD1kfXjY76v11l5LgdpwulVVPG1BTIiH8mIPBxNqAa3cUYzCnAX0lEJZBE7cDqkXZNCb0pQWmnneeTCpQHmRn23XKlo+l+w0R2pZZn4lPR2yXnoT70Yer7yzQ32jnOBUPCPiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711625658; c=relaxed/simple;
	bh=5CqHt25VW0U4ZGPc2PV7GyvKCS4oOTQkxFMXwMnfOK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8w8Mqmi+jHmjotm6cVARC7l83Pd6bO3oFLkZJc7imf1H6QaOHg/rq9uYpQdiBWbfTf5FN1hemRKBNIrW+IpHwQsX6IhV0KJLVC2bBlO6bSY0VRWtzSLx633UOo9FnNeISu3TkkKIOQYI6fZYpZF/NpH/e7WYiaOhoZNJ4RJUcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=ck0f47f5; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id BAA4C6054A;
	Thu, 28 Mar 2024 11:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1711625655;
	bh=5CqHt25VW0U4ZGPc2PV7GyvKCS4oOTQkxFMXwMnfOK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ck0f47f5427+jSqJTGjbyfPlI4XFEHyLWStneaEOmRrg/l5IzirPbCIbUO3c0tXps
	 2aNXHyYWj1GZugqLCMweWU4eKWdVPd4k+VtFX+GjDFJ+6dLX/9/5+6RIaK7ScfG+K9
	 F3F0nEQAN9HyiKUr3/6Spyi/BvhwNRoLGiZL/ApUoEh43usLb8QczgbvNPwhQpJ4G6
	 BkAOf/pPEHQj81YW4jbc9TIgcHzSTlzjcZ3WVSC/4FvtEmBdeeGX8JOKqi8p2yw6Cr
	 HMEUmvvi8gkj7Iip1ri0P1m+3bONNQmymipDpN5vpsUAuN2XmDJpvrp5PPRiKwRCm8
	 sVF7Q5YzKEEBA==
Date: Thu, 28 Mar 2024 13:34:05 +0200
From: Tony Lindgren <tony@atomide.com>
To: Dhruva Gole <d-gole@ti.com>
Cc: linux-omap@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] bus: ti-sysc: Drop legacy quirk handling for
 smartreflex
Message-ID: <20240328113405.GH5132@atomide.com>
References: <20240327081508.36747-1-tony@atomide.com>
 <20240327081508.36747-5-tony@atomide.com>
 <20240328112351.e7klcl7zjz6uov2j@dhruva>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328112351.e7klcl7zjz6uov2j@dhruva>

* Dhruva Gole <d-gole@ti.com> [240328 11:23]:
> Hi,
> 
> On Mar 27, 2024 at 10:15:07 +0200, Tony Lindgren wrote:
> > With the smartreflex driver no longer relying on the use of
> > pm_runtime_irq_safe(), we can finally drop the related legacy quirk
> > handling.
> 
> Just for some more context can you describe from which commit of
> smartreflex driver did this happen?

That happened earlier with commit ed4520d6a10b ("soc: ti: Remove
pm_runtime_irq_safe() usage for smartreflex").

Regards,

Tony

