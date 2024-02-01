Return-Path: <linux-kernel+bounces-48299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69ED08459D0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C82B0B26830
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0745D49B;
	Thu,  1 Feb 2024 14:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="a55N6gHX"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067FF5337E;
	Thu,  1 Feb 2024 14:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706796973; cv=none; b=DEd1A6ydtAdFtqbrZKvzCA0/Rq439+2PXBIYVhNsjHqyUihrYulyg6R+q+f5x6KVxVAvs9g72QhkXIE49vvmBihbUbzY9c96H0B6dFN2waDEPCd8Ty/I0WahNGN4fcm/PprIirbfESpOJVsBlZrleuutMrCMjTeH4d/05Z8YmXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706796973; c=relaxed/simple;
	bh=COW4TixgCHmoWbYb6ZMc3lV+lQapifvdBll4Z4yxb8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGzdHlvQnbY9IR5L4bstkiKoaRkOY7noepzFx9HfQxBl7FFd6yIEMtYgVdeCnlJ5T9LHI14cYs2a+aw3A59t9GziSYyEOPWC0TpX1hh5LeMvgDdfXOjLdE7+5C1LGHJpNhWF/4uSU9Hrkz/TQERna+X6dmUA9uiovGHQG6NFcb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=a55N6gHX; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A5AFB40E01B0;
	Thu,  1 Feb 2024 14:16:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0TrGAcQI3Xuq; Thu,  1 Feb 2024 14:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706796963; bh=SPv10L/MGaHhB1H9sFZLgmVexA6qV9vljgR/Vr3xiDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a55N6gHXjamiqkNWVLUYdCEVvi7klLEctKuGIMd260pApO3EYbRb2hFX2d1k/dGzK
	 gtYQaz6hfBmEhVBoUfpV+xNBWZKnl9WnyB4vNS22AOQwf9CeG8cxRGUHVcMN2nZ+7P
	 +fVcQc1qRf65v4XQpyJhTN9Rasu/Zw6ZLqAxj2cf6ytiFxRTpPnnAwF4pP+uyzLadX
	 mlwwct7pG4FBsuiChZ23s1F3dmLhXrNFCynvJJ7tgF7p1UK5KzSzI4YnFpOGZ0r4K7
	 M+Qew+vWDChw8c9zZei4Y6tpUe5iyhhXrU3sj2mQUSKmEuG0bweGMJFx4tfuqNzlIg
	 +vKQaaZqQmvSNhFONaBU7RTQA3tkf8CjX/D12D7LLygzLWKYQNPoNhWUrVZnBvXhOQ
	 N05poUHjGyn6aylpBBadfIbY52kavj47luqp6xT7zhUw3rExr+6aXc9iLpBIdKKQ4V
	 eUWcA3sxBUg4C+kfB6A3IdVNdviKeHh64Cys7etuiMhIPhphLBSoc3R7pE+0sHnFye
	 memaYqyViB6GdAzMReFPDd9ufZEx23ig69wHfxOP/bewJzZiVccKv4aAnQEFABuc3A
	 fMdoYtEFMiXtN6b181m9atN8mJeHHHTjhOF1H8y1gLXdMZ57uXn93Mdb5dOFJpSpSb
	 9agUjQe8TNzywkM6WMcy/xic=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E19DF40E01A2;
	Thu,  1 Feb 2024 14:15:53 +0000 (UTC)
Date: Thu, 1 Feb 2024 15:15:52 +0100
From: Borislav Petkov <bp@alien8.de>
To: Xin Li <xin@zytor.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>, Xin Li <xin3.li@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the tip tree
Message-ID: <20240201141552.GEZbunmFCS_MwZ6sTT@fat_crate.local>
References: <20240201111453.0ee3beff@canb.auug.org.au>
 <402d250c-e9b2-4c19-befd-d12b2e2582cd@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <402d250c-e9b2-4c19-befd-d12b2e2582cd@zytor.com>

On Thu, Feb 01, 2024 at 12:59:54AM -0800, Xin Li wrote:
> The following patch gets rid of the warning.
>
> Boris, should I send a format patch?

This is how kernel development is usually done. People send formal
patches and maintainers apply them.

:-)

Make sure you explain why you're fixing it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

