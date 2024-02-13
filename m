Return-Path: <linux-kernel+bounces-64457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F05853E9E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70D2C1C223FD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40910627E7;
	Tue, 13 Feb 2024 22:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ai1JWD/v"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4843626A2
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 22:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707863343; cv=none; b=lNaEfsoy5MFYN3qWsfHr4uTBtnn48gZibs2SOmLHC041pbvFWAz52uxWr9luh+sYTSIWcsI8afqIiZyoDt4Bk4gAApCbEAWDrrqtxV5xSgGbdr1kHfmao/mLvuiOGd18kAh7/NsU9SjDGjXk3FWkREYEsxRhue3QOEiZo7Mt9uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707863343; c=relaxed/simple;
	bh=ovf0VunURm1bBSOYgH3+XwjEXNfNydjf5eI0yYSvNoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SirVNf7aomOlkF7jedNGBd+GtUbOKxxPRJ50FhJt4Tc/G+oi6vZBzuWG87jznIo4cr/xbkIqZcg98aknsWWthPffkFRBNrsfK8NtXcQOwNP/KRmcFIftgv1SDSZSAfId8qr3eDBjlZtDBVh2et/Ld0wX44cv/Gj35LUgMDMcp6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ai1JWD/v; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=antHAWT2ib+9vRJPun4RKu+p5trcG0qadNFycSyfcAI=; b=ai1JWD/vLDLYF0HCtRVwdbdxdL
	Yn9dH8d0zh+quGbDIXEt+4uth/xCXguRCMCdG7ubSQCAIgJqJgv6m3uhlxp+s021GWcmV6/lpkA/w
	gT59Xl1tf7lTsOK30yCyNo85cMp5ZTv4Zc2fH8uhxuV1YaBqh0Zd5PSj7di3KOtY1TPCUxzjeatY9
	A9RVuXa9QW3um3/wY7UQTV28HrTd5JbEIJTaIw4QnTEHzTYNZjYtWsf+hxrx3rMRiqdjhQyuTSnnB
	0TLt7WQW9h2D+7m7ZrfHUvkq6eom662iE8UUXYcXynBIwvID1Kc46BQO3Uux1d/5GPafSqbgGADER
	q8+fd3rg==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ra1Gv-0000000B4Bd-1cMF;
	Tue, 13 Feb 2024 22:29:01 +0000
Message-ID: <fe9bfbd7-e81b-4f35-88bd-11dd9357eb86@infradead.org>
Date: Tue, 13 Feb 2024 14:29:00 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/usercopy: fix kernel-doc function param name
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, Sohil Mehta <sohil.mehta@intel.com>
References: <20240211062501.16428-1-rdunlap@infradead.org>
 <20240213214342.GFZcvijhGJ0b1y3wAg@fat_crate.local>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240213214342.GFZcvijhGJ0b1y3wAg@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/13/24 13:43, Borislav Petkov wrote:
> On Sat, Feb 10, 2024 at 10:25:01PM -0800, Randy Dunlap wrote:
>> Correct the function parameter name in clean_cache_range() to prevent
>> kernel-doc warnings:

> 
> What happened here? :)
> 
> Commit message and patch diff appear twice.
> 
> Once not enough huh?
> 
> :-P
> 

Wow, I have no idea. I'll fix it up.

Thanks.

-- 
#Randy

