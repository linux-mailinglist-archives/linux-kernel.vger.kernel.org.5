Return-Path: <linux-kernel+bounces-140291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DA88A1251
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D17BB1C21849
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C630146D47;
	Thu, 11 Apr 2024 10:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiIxGAsq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54F9146A70
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 10:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712832970; cv=none; b=irS9cDkT/2ciGIlnnyOHxs5t23c9EesNpmw0KHVsX9fphG7sVl/ZrIpEyXg7pqqprusE8mbpXpAFMOs5sLVv3V4G28iki0qeEKOIfEg57y6+er0pTUOrsNs3rxrOFzhEwBAXVPGefsKn8udUrHq4rQwJALps+tGHWcfTku6wgm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712832970; c=relaxed/simple;
	bh=1OtbrOxLVvaVQ7yBCqWo4EV6mpg+GvWT44z8ZTojnuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dN+j1SkrOtvDBesVXJTG9tAr7Jy07YnHJxXWcB4vujbDqN5HcTlxShJ0PnGaSF0uPd92qpakCCo8GT9Xh9VtpNXaWEl7zI47hGvf6PCQUUVyicedhPEdemex3R9MX19kva8jZ58qGyd+CyRNqR61Fvz+fTr0F9AT95MqjfGIzpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiIxGAsq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE9DC433F1;
	Thu, 11 Apr 2024 10:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712832970;
	bh=1OtbrOxLVvaVQ7yBCqWo4EV6mpg+GvWT44z8ZTojnuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZiIxGAsqnUbHwSgidgbQlc22Yrc2G9WBsP1Q1A8326OjDWEfqEKwsk2Y980lCfJuk
	 6FIzcRtnT2NrjoHK/Kb0Eopew1TbouNET6qX4Raz6yXt4J+6kBRDxU58s9AlMk8vGr
	 rT/jZYL7D27p65cxsIKtKEzX5mYUs8/9wA3o3ow6eagp2o/w41MnEhYa+1Ecvvv/BP
	 szuPnINDV3tyv4HICBTatWmB8gsX3clNvLEN2cidOYN5v5jDMFU9tR8+306ySUxMfo
	 AkNRB+pS2OCem0H/5RYMSbbqjIPXyiSO6LUP/N6SXakNhsw1WtecoZNUuBnMLAa67K
	 FhYjUU76fT3tw==
Date: Thu, 11 Apr 2024 11:56:07 +0100
From: Lee Jones <lee@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/6] mfd: kempld: A few cleanups
Message-ID: <20240411105607.GE1980182@google.com>
References: <20240223195113.880121-1-andriy.shevchenko@linux.intel.com>
 <Zgwk1tr7x4HnnlD9@smile.fi.intel.com>
 <20240411092928.GB1980182@google.com>
 <Zhe5YPsvEp1rzsTp@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zhe5YPsvEp1rzsTp@smile.fi.intel.com>

On Thu, 11 Apr 2024, Andy Shevchenko wrote:

> On Thu, Apr 11, 2024 at 10:29:28AM +0100, Lee Jones wrote:
> > On Tue, 02 Apr 2024, Andy Shevchenko wrote:
> > > On Fri, Feb 23, 2024 at 09:49:49PM +0200, Andy Shevchenko wrote:
> > > > Just a set of ad-hoc cleanups. No functional change intended.
> > > 
> > > Any comments?
> > > 
> > > (I assume the 6+ weeks in the mailing list is enough for all kind of CIs
> > >  to complain. But they hadn't AFAICS.)
> > 
> > Not sure why these were dropped from my queue.
> > 
> > Likely another Mutt "feature".
> 
> Hmm... Using mutt as well, but probably not in advanced way.

I use:

  I               flag-message               toggle a message's 'important' flag

.. to mark messages as requiring review.

Sometimes Mutt drops them for seemingly no reason.  It's also not
uncommon for me to fetch new mail or open Mutt to find 300 unread mails
which I've already parsed.  When that happens, all of the mails that
I've previously flagged have also been (not so) helpfully unflagged!

It's just something that I've grown accustomed to.

-- 
Lee Jones [李琼斯]

