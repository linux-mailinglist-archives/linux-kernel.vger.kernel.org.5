Return-Path: <linux-kernel+bounces-39796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1FB83D633
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 420551F24570
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B705220315;
	Fri, 26 Jan 2024 08:54:28 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A991200BE;
	Fri, 26 Jan 2024 08:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706259268; cv=none; b=AlFkosiYtO9cCf72rdtf5nsYwELL46qm7inZmv8Bpuh4bCPEd+JSerR1nnHwiIsqEDEDEBsX6PS/D/MsIJehiwTP2/i4URhnN/P+/PxPtyQihWcHaapIeF0WD5sz7yH3LEDOwWtQJY5pCZ7StrcqnUMx4TdMAXKVYPdN0cazLuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706259268; c=relaxed/simple;
	bh=m2v8yGscxTccKKQmICA2Ug+JNmQcZxXV7SctgFuruso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gz2rfgf2ze6db7R+dZ06PkU4zMGUJTZtglRFG6mzIGNh8YHGMh1hGJyZQvPhVHF5VcvhApqpv7BpDWobH3jg9k2CTvK9iSO92qBxFEUP3Ds9gMzSFildCgY7kGaMGKB3r9m9HEPyyJpo3nqzvoWjy+677q1pX/XsIPm3DDGYYMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rTHyW-006ESD-Fn; Fri, 26 Jan 2024 16:54:13 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 26 Jan 2024 16:54:25 +0800
Date: Fri, 26 Jan 2024 16:54:25 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: taoqi <taoqi10@huawei.com>
Cc: davem@davemloft.net, liulongfang@huawei.com,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH 3/4] crypto: hisilicon/sec2 - fix some cleanup issues
Message-ID: <ZbNzQQhlL6HYzqji@gondor.apana.org.au>
References: <20231229064421.16981-1-taoqi10@huawei.com>
 <20231229064421.16981-4-taoqi10@huawei.com>
 <ZbIry8M6yFUAr5oL@gondor.apana.org.au>
 <273d30b3-edba-4f4c-8138-fe83dbfd83aa@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <273d30b3-edba-4f4c-8138-fe83dbfd83aa@huawei.com>

On Fri, Jan 26, 2024 at 04:40:39PM +0800, taoqi wrote:
>
> I'm sorry. I made a mistake here. unsigned long and uintptr_t are the same
> data type in linux kernel. The type cast is invalidly repeated here. Can I
> just keep (unsigned long) one cast?

Yes that makes sense.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

