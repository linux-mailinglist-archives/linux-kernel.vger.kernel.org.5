Return-Path: <linux-kernel+bounces-72114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A49485AF39
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAF98284426
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF32F5676E;
	Mon, 19 Feb 2024 22:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BPE/szWQ"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E25756448;
	Mon, 19 Feb 2024 22:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708382937; cv=none; b=mESTibCeW02cd+7MStNnwg5SG4M4JfZXaBmUaJWC+uqQsEVhrXrGrwCX3SqkwZNgNkzI5aGZmKe8j6HKloijeQQZxTMKNFpFLmCLAiLEKH+Of+/OMcvcPMWevusEgYiDDeXEajZhQNPKLSIVUyO47hfBvN4xEnGqqutwHwt+F7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708382937; c=relaxed/simple;
	bh=0w5jmNzl/gGFv1ezFwPFu0ikRf9eVgG9k/x7XF0/Egw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vGBALJ4xRSEsBNM0EmdktxHwT13Wsf4ZkSetwuAVOYWh3M4ZXEr5o4xoUd351jBv2r5ncSV7AbGIoKPrQpt5pAgKUrgtMXBTSsfdA0xvFv8uvvASUuMEggmlqT2nkeOfIBNc4H3JlVeTwbPgL8uv4v9Si8v5IH+H4Nrcu/zbfAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BPE/szWQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=+MJURT5S+wqNxp9LJvSNiRIglZr8fX4xJXFsyOD/qtc=; b=BPE/szWQFADdqu53osUVMwyAJF
	XFdccnmVIajc4w5TT959MWzfU+nQWugNgOp+foB5cn/2hSgIuPDaVwQBmwpcbdsVgZ2D6MgM5UtJE
	kCoxIijgSOttcGnjelutQ8fUigB8imYikWKv78znUFOxKSNrinSZErf8pFPGKCwkkTB0LkRFETf6y
	BDOLp+7kehsdo+YvUMBhGpZA2lRAFSBNzXNjqXnn14RFZwbcw6rjKChLqcysJ5OylblkHWdb6xpHv
	SAv2wE/MYglzVbynyiSIW04CxkT2SHLTTMKyCqNZJwZkUNtr8KONA3ATGejMNZavYfVVv8u8XBR2u
	q7W3bMwg==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcCRS-0000000CUMa-3P9Y;
	Mon, 19 Feb 2024 22:48:54 +0000
Message-ID: <439d34e7-3bf9-4710-ae0d-6c2b94917c60@infradead.org>
Date: Mon, 19 Feb 2024 14:48:51 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Fixes tag needs some work in the spi tree
Content-Language: en-US
To: Stephen Rothwell <sfr@canb.auug.org.au>, Mark Brown <broonie@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20240220084419.599716ce@canb.auug.org.au>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240220084419.599716ce@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/19/24 13:44, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   afd2a4ae296d ("spi: spi-summary.rst: fix underline length")
> 
> Fixes tag
> 
>   Fixes: hash ("spi: Update the "master/slave" terminology in documentation")
> 
> has these problem(s):
> 
>   - No SHA1 recognised
> 
> Maybe you meant
> 
> Fixes: 99769a52464d ("spi: Update the "master/slave" terminology in documentation")
> 

oh dear. Yes, I did.

Mark, what do I need to do here?

Thanks and sorry for the trouble.

-- 
#Randy

