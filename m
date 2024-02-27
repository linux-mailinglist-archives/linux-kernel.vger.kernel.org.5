Return-Path: <linux-kernel+bounces-82505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E17886857B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E7C71C22FA4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317EB4689;
	Tue, 27 Feb 2024 01:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W3B52p5r"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A09E4A0A;
	Tue, 27 Feb 2024 01:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708995846; cv=none; b=L4TM3dT+5YsWQfZrGzEsSpVv8xqvqU4DXkxduaRfauYTBIvLNkpCEVIVkSvOezM85RhlFhjHkt925fKgllYFn/P5ezJpI0tEFrDTLm2IdVZqzJXzGjCOEGPpwALHyIQs4omW8OFN/CPhhz1PYIJjFKNR8AY/hUb3Rq32BSuWIvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708995846; c=relaxed/simple;
	bh=4BTA21RCMV1i4P9pEyAxk3Awr2viSqjmI/Pdmb6nk6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cvM5y2Lpwq/Vq3Mc4U5MYeZAaNKM4XMHd1fxZ3oysS39yxC7kOSjK4QZkwQ50hUgG5LNmo3JRbqv8Tv9uBVsvSBCz6WeVkxm0DlQNTe1zzwnyg3Cxl2zMNImZhrimGvtc/tvHikJJJcAxBi1H5BzlR79XBfdSR1GTa6i0r1txUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W3B52p5r; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=RVftSLZVJrorIFus3RabCSPKATUQtwl5EIiqBrEipvw=; b=W3B52p5rkWx27A4Lch5cd/W3XE
	CQzIIB0ZeiYi3nNcKYxtf7lSJz75VbIih+2o2567cQH38ClJ82qNVUhPaiqInGBX3FSogPuWcHDoz
	yTCc70jLDRXyxHPghUARld7Eampuhrruh5ZlEsZkO9KJ+DDYYXHsND0hN6vl992YJdvzOS+NZhcQr
	e2HFkWFyZGf2hgGB+MTcBy9K14+qB0zxLQKn34kmdnSedR0jXmjTT66z+9B1In8Ky0pCorJxYDy2C
	McNS5v/m+hqQigS5j2uQNlyCdr30L16vVbAJwbEIkpzTnaHGctBOi4qFdcXSfiR7pjJOt9vkE8aHY
	Bnxcn6qw==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1relt6-00000003CmL-1pZM;
	Tue, 27 Feb 2024 01:04:04 +0000
Message-ID: <ca59236d-4f5c-4605-b443-8f62d71da643@infradead.org>
Date: Mon, 26 Feb 2024 17:04:04 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Feb 26 (drivers/gpu/drm/xe)
Content-Language: en-US
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org
References: <20240226175509.37fa57da@canb.auug.org.au>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240226175509.37fa57da@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/25/24 22:55, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20240223:
> 

on powerpc32 or i386:

./drivers/gpu/drm/xe/xe_ggtt.c: In function 'xe_ggtt_set_pte':
./drivers/gpu/drm/xe/xe_ggtt.c:78:9: error: implicit declaration of function 'writeq'; did you mean 'writel'? [-Werror=implicit-function-declaration]
   78 |         writeq(pte, &ggtt->gsm[addr >> XE_PTE_SHIFT]);
      |         ^~~~~~
      |         writel


-- 
#Randy

