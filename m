Return-Path: <linux-kernel+bounces-51183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6F8848774
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 17:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81F7C1F21EDA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2205FB87;
	Sat,  3 Feb 2024 16:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GnYoc98t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7A65F843;
	Sat,  3 Feb 2024 16:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706977698; cv=none; b=t3pfhCsJ4VayQRrnRr0r9SchiepPtJ9bq4ZuWSVLchUje2ZzXqPUq/6VH2elHfoMVkO9Ais8lzpEx8XyPwwfucd6r2AVGuhB2ImweqBj3hUZpTqLuhdElyxvnM/9LvFs23/xYk7JN6z6npTvkp+RmkXwpylYqXrFhX5ZP8dyA2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706977698; c=relaxed/simple;
	bh=+oE1G5thxWzBHxLq7xMlVsgqwPRV5cxH8lm4fKPOwBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/FY0pDxBlk0BGpf5sqmzdsf7YxHoYgwhDCRXGZIO0QcHmfs9X7VzeIhpzOygQCZEnuNwE9JGdCTb98/PTihBivE4QCb00qxdWXdYyucpfKXkaVE0sHPuFMlHhFobbE4OMPO86qR4AWjmsgEouZFzGo6cyvAPb5NGOFbsAPCvao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GnYoc98t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54685C433F1;
	Sat,  3 Feb 2024 16:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706977697;
	bh=+oE1G5thxWzBHxLq7xMlVsgqwPRV5cxH8lm4fKPOwBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GnYoc98tvelTd3C4j0lOUjDApm1maDXTwyMhQCLHvKBTn6RAJ4ESt1vfXUxDwpD1t
	 gsbj5L92SSrYDkq0srtGzC3G1OvfpjRcTgatHezjm7yJM86bmFoNRFh4vLrQ45r+ll
	 hJ9mHaErGCr0E58eDJmNrBDPISwPTuh5c6o0s6BE=
Date: Sat, 3 Feb 2024 08:28:16 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ronald Warsow <rwarsow@gmx.de>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.7 000/353] 6.7.4-rc1 review
Message-ID: <2024020344-unadvised-animator-a373@gregkh>
References: <295b099e-3b60-416f-a28c-6d58bb5564bb@gmx.de>
 <2024020343-handiness-nanometer-ae7d@gregkh>
 <6b40877e-7ecf-4690-89f0-50e0db2e90f5@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b40877e-7ecf-4690-89f0-50e0db2e90f5@gmx.de>

On Sat, Feb 03, 2024 at 05:23:02PM +0100, Ronald Warsow wrote:
> On 03.02.24 15:46, Greg Kroah-Hartman wrote:
> > On Sat, Feb 03, 2024 at 02:39:41PM +0100, Ronald Warsow wrote:
> > > Hi Greg
> > > 
> ...>
> > I guess just not tested successfully :(
> > 
> 
> well, team work is essential, one could blame someone else
> :-)
> 
> 
> > I'll look into all of these errors in a bit..
> > 
> 
> got a serial console log.
> 
> Please scroll down and/or search for
> "[    4.390912] Workqueue: usb_hub_wq hub_event"

Ok, we found a xhci driver patch that shouldn't have been in there, let
me push out some -rc2 releases now to hopefully resolve this issue.

thanks for letting me know.

greg k-h

