Return-Path: <linux-kernel+bounces-79916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A12098628A1
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 01:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40F4E1F214CA
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 00:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDE71C01;
	Sun, 25 Feb 2024 00:57:48 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BEE10E4;
	Sun, 25 Feb 2024 00:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708822668; cv=none; b=SxfBUTFNd9u9teRd2r9oIUPNiBvK8FFpJFmmsMuuxuW1PEvEIZmSFVF/IqD73nuGjDw32jXnuXwo4lCwuo/u3bdN99fbk4em1GXJhDT7DToZlTiNqrhkVP2Y6evD0cM28VkHHhh1I9EvEhfoCbeso9LNwYKMd2ysEEkiesKSJzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708822668; c=relaxed/simple;
	bh=ioMTznDwM8Bf83NeluICXPdCkl4fF07yGYnYlYsOynU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jDAlyiH1+lZsCfVeX5BFkUb5RRs3JHnA4gnwHCSig8opPn/CqT7KYepkfJibT+gvmYoJIwoEb969+AjRUzj2t2Zzz/xSt7fSrTwq6xkMr/fF1cBBeKU/ii15vKAJGwRFizZS2hXFp9u37q4qeaWspRVjxUC6ZJhI5b9JQKqp3nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 9A11892009C; Sun, 25 Feb 2024 01:57:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 92FD092009B;
	Sun, 25 Feb 2024 00:57:42 +0000 (GMT)
Date: Sun, 25 Feb 2024 00:57:42 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Sam Ravnborg <sam@ravnborg.org>
cc: sparclinux@vger.kernel.org, Andreas Larsson <andreas@gaisler.com>, 
    Randy Dunlap <rdunlap@infradead.org>, 
    Miquel Raynal <miquel.raynal@bootlin.com>, 
    linux-parport@lists.infradead.org, "David S. Miller" <davem@davemloft.net>, 
    Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] sparc32: Do not select ZONE_DMA
In-Reply-To: <20240224-sam-fix-sparc32-all-builds-v2-4-1f186603c5c4@ravnborg.org>
Message-ID: <alpine.DEB.2.21.2402250054030.36563@angie.orcam.me.uk>
References: <20240224-sam-fix-sparc32-all-builds-v2-0-1f186603c5c4@ravnborg.org> <20240224-sam-fix-sparc32-all-builds-v2-4-1f186603c5c4@ravnborg.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 24 Feb 2024, Sam Ravnborg via B4 Relay wrote:

> sparc32 has no limited DMA zone so there is no need to select ZONE_DMA.
> 
> Based on analysis from Marciej:

 Can you please use the correct spelling of my name in change descriptions 
(and preferably everywhere)?  Thank you.

  Maciej

