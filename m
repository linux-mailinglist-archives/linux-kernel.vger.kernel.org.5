Return-Path: <linux-kernel+bounces-161395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF9B8B4B7B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 13:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC0F91C209B3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 11:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E91C56B7E;
	Sun, 28 Apr 2024 11:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZnvwSWOz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CE55675F
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 11:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714303108; cv=none; b=QPOkSiXU/DSu/pnrPpBK3y6nX7NioSgF0l5AVLpkzanVRuy96oPR0InirzoV874BiOyeCfgPgjoF6styZqaUfRJWmvwI6CNsCl08SulqGemqg11C1G65CI2U8Hgu8fk6+zwv1CfdHnsg7FQivN0zbOvTHXDSvYllK2eJQDX+zIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714303108; c=relaxed/simple;
	bh=X+K7Nc0LpDXODYQLd0Q0S5QHO4kmEjSwRjjYMBuCV84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJFSLhuXm3T0MLSmDYnHNTomhKbz/P+Eqw3nEZIxl3p9mtUXcSq+8ib5PC8dUFAswb64GmlvoKBd7dYnkghJk7bN5esHg8zopQCiJ5sEnbeb9yjPhqY9JzJE9onBWy9Z6yz+5tdhVJwFlFHgf4Lw9OwlgxEC2FS/QmhNmJCzcMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZnvwSWOz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68BDC113CC;
	Sun, 28 Apr 2024 11:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714303108;
	bh=X+K7Nc0LpDXODYQLd0Q0S5QHO4kmEjSwRjjYMBuCV84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZnvwSWOzdF5VIPrGSJXqL17l++bdKJo5Gytb2RgzRKFD0TjcJfXPEJwaQ9xBVHyAC
	 QbEkmTIMjKoOZIZUA2NKKoD0IqRBAHeP9G0UYw4h/dIM9aEX9HWm8AlTEMphYH7Srp
	 93iq0wNILoj6UJaEkfnKGmJe5k5bwcs9k7dgk+AQ=
Date: Sun, 28 Apr 2024 13:18:24 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Sending patches as eml message attachment?
Message-ID: <2024042844-disfigure-dose-e194@gregkh>
References: <Zi4bMx2FKuviJi0M@archie.me>
 <2024042828-occupier-confused-e046@gregkh>
 <221f6cfe-07c9-4fc0-a908-84276b8e4088@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <221f6cfe-07c9-4fc0-a908-84276b8e4088@gmail.com>

On Sun, Apr 28, 2024 at 06:10:16PM +0700, Bagas Sanjaya wrote:
> On 4/28/24 16:56, Greg Kroah-Hartman wrote:
> > On Sun, Apr 28, 2024 at 04:47:31PM +0700, Bagas Sanjaya wrote:
> >> Hi Greg,
> >>
> >> Sometimes I'm tempted to send patches as .eml attachments (just like in
> >> error messages sent by mail servers to me). Is patch submission by
> >> aforementioned way accepted?
> > 
> > No.
> > 
> >> If not, why?
> > 
> > Why would they be?
> > 
> > Attachments don't usually work as you can not reply to them and comment
> > on the contents, right?  Try it yourself and see.
> > 
> 
> OK.
> 
> I experimented this by sending dummy patches to myself, as attachment.
> I replied to the patch using mutt and thunderbird. In mutt, the patch
> contents was quoted, whereas in the latter, it was missing. Hence,
> email clients are inconsistent on handling patch attachments.

That is true, which is why we say "do not attach patches".  It's as if
people assume we are new at this whole thing...

greg k-h

