Return-Path: <linux-kernel+bounces-161354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6B98B4B13
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 11:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4630F281749
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 09:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE1E55E6C;
	Sun, 28 Apr 2024 09:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X0xb2tK9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAE91E89D
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 09:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714298191; cv=none; b=MdTCA/qGALtAPVx9I0OqSIB1BSMkSk/OdOfKFxSHIjrL4YT2Tic0CpveS46hwRG16NXE6lu7YSCFI0JLw8p5SBFKv6mt9ABo6Jrr74Hbmem6EZl+Bp+Zz0zV/zPKOkbtD2p63z1cb3kZrw0v378Pq2ARY9l5pOICjCd6itQ5T0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714298191; c=relaxed/simple;
	bh=ayPR8qlr6xi8wFMzeC9PzYsYWt4OcIfPxa7FWPfKwSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1uH2llLeQ98O5tyinsC2p6Rwd6xvXdEkTohARyLfHLJMe5HsSMlO7RevxGse0tjlYvEDuh8cYjnZYlr+hQX+MFZsYs6RrqBmJBFvjWCuKYJEgoVDsZEdRq1ju4iYbXmh4pRNfVfygB88Vql8Cd4wxUEfs9xnrZ0n2GoDfcb3ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X0xb2tK9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C8BC113CC;
	Sun, 28 Apr 2024 09:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714298190;
	bh=ayPR8qlr6xi8wFMzeC9PzYsYWt4OcIfPxa7FWPfKwSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X0xb2tK9NgPcJkbfrC+k5sdcCjcsbRRlNJMC1AO9A6WQmay1IskTGWqhUJJQ0/z52
	 7AxTy/4I89h1diG4LK+hRx5XpCUSJ36CQHmbyLTBuTcDY4i8Ye+MbqsRMehijZwsIf
	 pduUkaq3OznBwBj6C2ZWHgrimlImFISRsiz8ffU4=
Date: Sun, 28 Apr 2024 11:56:27 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Sending patches as eml message attachment?
Message-ID: <2024042828-occupier-confused-e046@gregkh>
References: <Zi4bMx2FKuviJi0M@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zi4bMx2FKuviJi0M@archie.me>

On Sun, Apr 28, 2024 at 04:47:31PM +0700, Bagas Sanjaya wrote:
> Hi Greg,
> 
> Sometimes I'm tempted to send patches as .eml attachments (just like in
> error messages sent by mail servers to me). Is patch submission by
> aforementioned way accepted?

No.

> If not, why?

Why would they be?

Attachments don't usually work as you can not reply to them and comment
on the contents, right?  Try it yourself and see.

Also, .eml is an odd standard, what's wrong with text?

thanks,

greg k-h

