Return-Path: <linux-kernel+bounces-47646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 600578450B1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 937B61C22795
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EF63C6AB;
	Thu,  1 Feb 2024 05:30:06 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820543C488;
	Thu,  1 Feb 2024 05:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706765406; cv=none; b=iatc4OPxsBPbFBZ86kmyU5HVaCkidkf42g5nfzAEMzgUCdm5qMxwLaMma01dbr58i14X/5vnvyNgV8dPa2vWvryeykAK+V50UDeAmilrtsDi4wloTBWgUUV7iLsKp5Jh1JDuMprsQkuRroWuNmAZXyl7EpMaHZN8lI0Eaj3NfYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706765406; c=relaxed/simple;
	bh=cL7V16KDRr+v738/d3BfxIUMHAUKQk+rjHt61+n8cQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNzJkhkm9mGGTb6LLVk77Vkcz7Gvqy8dRp5oyBScgiIIegix5TMtwluE8E/hd7AW3Od+WfsAyN1FkFpd8qK7Vq9GEBqqwq9o0FCV1YYi+aRcVtxHxGGtUOwpbLoTaDmMBcaiWSihO5XuH5+5qiLuSoljnx8DwXmtjZjKlhTxHu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 025BF68AFE; Thu,  1 Feb 2024 06:29:58 +0100 (CET)
Date: Thu, 1 Feb 2024 06:29:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andrew Kanner <andrew.kanner@gmail.com>
Cc: mcgrof@kernel.org, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@lst.de, mchehab@kernel.org
Subject: Re: [PATCH v1] module.h: define __symbol_get_gpl() as a regular
 __symbol_get()
Message-ID: <20240201052958.GA14943@lst.de>
References: <20240131190251.4668-1-andrew.kanner@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131190251.4668-1-andrew.kanner@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 31, 2024 at 10:02:52PM +0300, Andrew Kanner wrote:
> Prototype for __symbol_get_gpl() was introduced in the initial git
> commit 1da177e4c3f4 ("Linux-2.6.12-rc2"), but was not used after that.
> 
> In commit 9011e49d54dc ("modules: only allow symbol_get of
> EXPORT_SYMBOL_GPL modules") Christoph Hellwig switched __symbol_get()
> to process GPL symbols only, most likely this is what
> __symbol_get_gpl() was designed to do.
> 
> We might either define __symbol_get_gpl() as __symbol_get() or remove
> it completely as suggested by Mauro Carvalho Chehab.

Just remove it, there is no need to keep unused funtionality around.

Btw, where did the discussion start?  I hope you're not trying to
add new symbol_get users?


