Return-Path: <linux-kernel+bounces-96565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 341BB875E3E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE41C1F24D82
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 07:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFE34EB41;
	Fri,  8 Mar 2024 07:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="qoFWA+1H"
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B0D36125;
	Fri,  8 Mar 2024 07:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709881584; cv=none; b=GTbZm0rj+SZWoNQXaxCc22kw+wYr+RoxPhFqbnv4BGDB4KcWWvGM10Kzid7zK8hvz4rtEzx/zf+y8JeHwX1U7lRSn3kMb4bY+pSyy8zCWMiTG4Cqp8cryTodq/orc/FP1YCOi9BcXh5Cw1HRKbBk9bsu7/juoKuOeZS7XRrkFcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709881584; c=relaxed/simple;
	bh=tp1vcelglTamYAbD/dUICI38SgIAnEhonNlGt++MjpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H5aAC+KOUmt7wtGv57i5iFH5ehHHcpY5TfnK+kyE3RWnLJdYl86ipjFsxeOB+DpYIsEEQByY+rFSJ8IXSLGK6rjivyarlhttRY/Q3Q2Rb2EYoV04ohzHzEFoSl0rP2+hA25C49W9pnbPFruSon8//BbhWSqUoN10hE2DH+UdQwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=qoFWA+1H; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4Trcdz6G7Kz67xf;
	Fri,  8 Mar 2024 08:06:15 +0100 (CET)
Received: from [10.10.15.20] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4Trcdn35q9z67xv;
	Fri,  8 Mar 2024 08:06:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1709881575;
	bh=tc5+Y8aKBDk8x+b6Zio3l2GymSNXUOEtVEUc/9zX6cE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=qoFWA+1HR+G6ZpXVE5w724e0sQb39QXZzKhNG3rxj2AvSabjDBqKUe41g6UkiKKO2
	 InNiL3v1CJewG4w2fpm8A2a8ciCfCNBV+iUi8Bt1UyWxigzS5aIqOdPH5liYPbLXcb
	 oFHRHLqxPbsBgNFL1wj5yvi8vTsXTf2yOikwBIj0=
Message-ID: <8398f430-14be-4447-9c17-9f6ac0af024a@gaisler.com>
Date: Fri, 8 Mar 2024 08:06:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] sparc32: Fix section mismatch in leon_pci_grpci
Content-Language: en-US
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: sam@ravnborg.org, sparclinux@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-parport@lists.infradead.org, "David S. Miller" <davem@davemloft.net>,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 Arvind Yadav <arvind.yadav.cs@gmail.com>
References: <20240224-sam-fix-sparc32-all-builds-v2-0-1f186603c5c4@ravnborg.org>
 <20240224-sam-fix-sparc32-all-builds-v2-7-1f186603c5c4@ravnborg.org>
 <b62d0ae6-c2cb-4f2c-b792-2dba52a44e35@gaisler.com>
 <c5654b69-209e-4406-ac70-9a4547adfc36@gaisler.com>
 <alpine.DEB.2.21.2403072015010.29359@angie.orcam.me.uk>
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <alpine.DEB.2.21.2403072015010.29359@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-03-07 21:16, Maciej W. Rozycki wrote:
> On Thu, 7 Mar 2024, Andreas Larsson wrote:
> 
>> I'll pick up the whole series apart for the ZONE_DMA removal, so there
>> is no other need for a v3. I can add the Fixes lines to this one, if it
>> is ok with you Sam, or take it as is.
> 
>  Can I have the spelling of my name fixed though (which was supposed to be 
> included with v3)?
> 
>   Maciej

Based on the outcome of the testing and discussions that followed I will
not pick up the "sparc32: Do not select ZONE_DMA" patch from

https://lore.kernel.org/sparclinux/20240224-sam-fix-sparc32-all-builds-v2-4-1f186603c5c4@ravnborg.org/

which was the one that got your name misspelled, unless I missed some
other occurrence.

Cheers,
Andreas

