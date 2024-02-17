Return-Path: <linux-kernel+bounces-69963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 023CF8590E2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 17:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B01192824EE
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C497CF32;
	Sat, 17 Feb 2024 16:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TqgxPfcd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F247CF1C;
	Sat, 17 Feb 2024 16:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708187206; cv=none; b=ZdMl9U40gWkppKAnDkFr3QqxpsaS235D7hzUeA6OXmYrO/YxXZRS6bNwRQGDfk4nsl80xMnVMwFBhCjopCscTt3YakxcV48zWhKd3KxXZl9LoogbmgepzZEf7krOlUqlAtwD3EmVLOvZtp1TA5M5rID8zrzxhJBheqD+1UdqXbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708187206; c=relaxed/simple;
	bh=iS8H0yTvebWdhZ1BBZEakoVXIEZsAyQ1kkx5KnIl1ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CAVeht/ZnIDbjS8p8XpbrqcA6KgNtYUUwKRtA0r0XXbDK86SFZenmFX5OzveFCXMuaRwHwivFQuMbUyaBTNbVJzXiF8JpTPaqGYEgp4SbMFW/u6GuUwpKZUrgaA6GfZakLh557TYaZf8Rco68al5p5yZsXG4k/j7eZUYt5rb5yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TqgxPfcd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B0DC433F1;
	Sat, 17 Feb 2024 16:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708187205;
	bh=iS8H0yTvebWdhZ1BBZEakoVXIEZsAyQ1kkx5KnIl1ic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TqgxPfcdmRCzmxmcDBdE9L9SLxSgnJNZeH9FuC+LesnsaOYWyR2UJE0SbdjYtWsbB
	 P10bwQESrXCNBbpldxQ+Ztta8l+WKE3+bmadD5Y1xQmbb1/lKe00CAgQchYDMQ3rZ6
	 SSsom9jHgmhkJTG3DIMEsMjhWtQIzyQV9TOLIVDw=
Date: Sat, 17 Feb 2024 17:26:42 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ettore Forgiarini <ettorenigma@gmail.com>
Cc: richardcochran@gmail.com, ozlinux@hotmail.com,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: octeon: octeon-stubs: fixed a type coding style
 issue
Message-ID: <2024021730-familiar-elongated-8bcc@gregkh>
References: <20240203155702.835279-1-ettorenigma@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203155702.835279-1-ettorenigma@gmail.com>

On Sat, Feb 03, 2024 at 04:57:02PM +0100, Ettore Forgiarini wrote:
> Change all the uint*_t to the preferred u* types
> 
> Signed-off-by: Ettore Forgiarini <ettorenigma@gmail.com>
> ---
>  drivers/staging/octeon/octeon-stubs.h | 1746 ++++++++++++-------------
>  1 file changed, 873 insertions(+), 873 deletions(-)


Why just for this one file?

How was this tested?

thanks,

greg k-h

