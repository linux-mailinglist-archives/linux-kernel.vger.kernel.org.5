Return-Path: <linux-kernel+bounces-98881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9DA87809C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C74A1F21866
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E653D549;
	Mon, 11 Mar 2024 13:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="2TI3C4KE"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5113D3B8;
	Mon, 11 Mar 2024 13:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710163692; cv=none; b=n1sryEJI2g1WbTwoFE5Vlw6uRXKu3J6RhW9qmS7PrFZN9f+bFOzaQ3pVHDFQ8LyreCKYr/yNB/NZRt534hov0D3ESNz/5NGHwASDA3K5aIbWwbLyn3ol8vkr1oHuYkQWIgYQKj44REaQKzkaImywsv5HDuPig4AoiM6bx1z5fyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710163692; c=relaxed/simple;
	bh=GQQ1bl/o8G29EUhq7LWesXSsxkHYPUoSZvjAF8nhAq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DNW2f3NDt+JszhS1zNUN7XaH4o76NVsmTPIYRzPqJSTQkM0Ry2H+emrI7vQODHhy/j7QzOw9PpPeAra72rmwvZG5COLZU34a6mAXqo7rR74THNwF+VLdzYnTD51szVA/jZwDo1WG6GO91EU3zFzLfPhDOdQrUk2XVnaUewJyXCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=2TI3C4KE; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710163688;
	bh=GQQ1bl/o8G29EUhq7LWesXSsxkHYPUoSZvjAF8nhAq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2TI3C4KEK3UF4vgPRMr8V43ERNDiKd8ZFL9KrX/KoSdIcvHwZQeKTOJ14ybiQMVvn
	 jDN9oMK9SYhPL9hfZ3b2vXkufkgQFrjFYUR/K2EQWVHQ9YJeD3oMB2W90VWBmRMUc1
	 UE3a4U3oN7FTFhFoaSSOvuP0b5Sxi7YQ/TBs0qjk862Z6Ol+Yw75UVCGZYQRKahYBl
	 ec7tXv8sQ9w6m3pq0+NHEKOBTUTsyBaPzPD2WuCj8FOpvOqPraFms9MQ0pUPkl1v/U
	 Ph7bFjBGgxVzpr7VQiT8vKobL5yokuFMMD/UNtaZ7e3WM0IN6RdZL+EL8T4XDSQMSx
	 nQP9LfStRJaMw==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7EC7D3780016;
	Mon, 11 Mar 2024 13:28:07 +0000 (UTC)
Date: Mon, 11 Mar 2024 09:28:05 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Chris Bainbridge <chris.bainbridge@gmail.com>
Cc: Thorsten Leemhuis <linux@leemhuis.info>, regressions@lists.linux.dev,
	trivial@kernel.org,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix typo in reporting-regressions.rst
Message-ID: <939d580a-9646-4e58-aadc-1eb40f17e0b5@notapiano>
References: <ZeoDMtLGIHvbavW2@debian.local>
 <cd766a41-4dfa-4f57-8af2-163023acbead@leemhuis.info>
 <Ze2PT8oamTSm23ny@debian.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ze2PT8oamTSm23ny@debian.local>

On Sun, Mar 10, 2024 at 10:45:35AM +0000, Chris Bainbridge wrote:
> On Sun, Mar 10, 2024 at 08:57:55AM +0100, Thorsten Leemhuis wrote:
> > Which leads to the question: how much do you care that you patch makes
> > it in? If you would like to have a fresh commit in the kernel (which is
> > totally valid thing to want!) we definitely could improve your
> > submission and then adjust Nícolas changes on top of it -- but if you
> > don't care at all we could just directly take Nícolas patch.
> 
> I don't care - just take the other patch. But please fix the multiple
> incorrect spellings of colon ('collon') first.

Oh wow, I looked it up before writing and was confident that was the right
spelling... Thanks for pointing it out, will fix in v2 after Thorsten gives any
other feedback he might have.

Thanks,
Nícolas

