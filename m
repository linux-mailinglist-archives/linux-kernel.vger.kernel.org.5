Return-Path: <linux-kernel+bounces-51972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE32849226
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 02:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 469D11C2153A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 01:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4D4B665;
	Mon,  5 Feb 2024 01:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pGKKnJ4X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8488AB64A;
	Mon,  5 Feb 2024 01:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707096235; cv=none; b=BRjJvvAF8//bK9FIR6OuJSmZHwe1WpJ4A6ybMihE40pNsdx7MnwV4tjNg4lwEZr7dhFScuYmBx3C+nrzbKXsO0LxLZhM+zpXwJWLOd+CTGYvw3M4HI9WO6Amiw1yjCmmygkqDLqFH5bWGrtXGy87Wt2kW6iY7Nxd3eWMXA4AlME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707096235; c=relaxed/simple;
	bh=RZ4VyLmCUapNcpo9a9foJKfmkQOXsPppx0XZzWWJ/Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ag/e3TD4otwqrSS6TMWN6fD0NInKc9FpyGRgqE169fkIoSej3cpTqvyZY4rhwUL8/HX5jj32gwMTmGSLArfr1COK/Eilh4IQTTtBswSb/z53oJabiV6h77fzksdLmYtRZd28o60mMODnBnqgImvAlSL6lo9xeG43X0vAPaihcu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pGKKnJ4X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A7BC433C7;
	Mon,  5 Feb 2024 01:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707096235;
	bh=RZ4VyLmCUapNcpo9a9foJKfmkQOXsPppx0XZzWWJ/Z4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pGKKnJ4XG1VQYrLVIdYbyW8n9+ypLK20BJTjGV+uZi8HrH92vpSaruPkF+AP96PUa
	 wq5y1JLbyP6smfNm0N/RzYZWe3wdW06f9GUa2b3E0YZREVeujxu5Q9HKPMe5k3wD08
	 DcQtNj2hAbmkHnWUAuoPLIfLDedhdmrqIWJIxXDg=
Date: Sun, 4 Feb 2024 17:23:54 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Ettore Forgiarini <ettorenigma@gmail.com>
Cc: richardcochran@gmail.com, ozlinux@hotmail.com,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Staging: octeon: octeon-stubs: remove all typedef
Message-ID: <2024020433-flyover-humorless-5a3c@gregkh>
References: <20240204153603.1373700-1-ettorenigma@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204153603.1373700-1-ettorenigma@gmail.com>

On Sun, Feb 04, 2024 at 04:36:03PM +0100, Ettore Forgiarini wrote:
> Removed all typedef so the code conform with code style
> 
> Signed-off-by: Ettore Forgiarini <ettorenigma@gmail.com>
> ---
>  drivers/staging/octeon/octeon-stubs.h | 48 +++++++++++++--------------
>  1 file changed, 24 insertions(+), 24 deletions(-)

Also, most importantly, this breaks the build, ALWAYS test build your
patches at the very least.

thanks,

greg k-h

