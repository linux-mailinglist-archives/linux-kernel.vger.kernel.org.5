Return-Path: <linux-kernel+bounces-36248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF1D839DE0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86D0E28E39E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC03D137C;
	Wed, 24 Jan 2024 00:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZGZYkYlw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAB310E3;
	Wed, 24 Jan 2024 00:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706057977; cv=none; b=rOUWdQZk/MhZTOmk6G3E+DI8V/7AREUC4UinikbmhN86CFo3pwxc2ECapLiHLa+YlRNPr8ijjOyOBcekIQSH2+w1L1l0T4bkh3dy5X3Ar/kZcol4jkdVHBmxIlVKcaIe3pYyQWhTHn19S8EGEJtUdwtYzzjz55Mri/KaVV9xq2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706057977; c=relaxed/simple;
	bh=DvauO6ycaIw3mAD1xvoregXuj3b2mxdZaXL8A1ZszOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C630b8I0FrG9VigIHb/7kiq4prlRxs9QfyA/+OnguxjN5SYpgrdxNIjzJkFk/v8vTZtunkxPzqtuyCHbNFmUO/gUah3tJiYC94J6tEVBBEGG0Tl/Xc7uFETTVbk0Ul/X2X9hjUn45xKU8DRMCEja68m+a/IJ0ISyq00AQ/rw67Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZGZYkYlw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527C9C433F1;
	Wed, 24 Jan 2024 00:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706057976;
	bh=DvauO6ycaIw3mAD1xvoregXuj3b2mxdZaXL8A1ZszOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZGZYkYlww5n/wqdtykDcoiab3c8Chc3oAvIM/NzP6wNqNA4YZ4Uc8ajo3yOjF/Lj3
	 R2wbj0NOj5ylnHM1/IMOqvC5kpzJq0M5gt3jXYuuG6DzVf8W5ASvYjSOnCLYixjcSt
	 Hdsr7SlqlN0/aMCz/xZaeWU175y/+vDNycxPeMho=
Date: Tue, 23 Jan 2024 16:59:35 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Elizabeth Figura <zfigura@codeweavers.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, wine-devel@winehq.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Wolfram Sang <wsa@kernel.org>,
	Arkadiusz Hiler <ahiler@codeweavers.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 0/9] NT synchronization primitive driver
Message-ID: <2024012319-aptly-calculate-0f88@gregkh>
References: <20240124004028.16826-1-zfigura@codeweavers.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124004028.16826-1-zfigura@codeweavers.com>

On Tue, Jan 23, 2024 at 06:40:19PM -0600, Elizabeth Figura wrote:
> == Patches ==
> 
> This is the first part of a 32-patch series. The series comprises 17 patches
> which contain the actual implementation, 13 which provide self-tests, 1 to
> update the MAINTAINERS file, and 1 to add API documentation.

32 patches?  I only see 9 here, why not submit them all?

> The intended semantics of the patches are broadly intended to match those of the
> corresponding Windows functions. Since I do not expect familiarity with Windows
> syscalls, however, and especially not with some of the more subtle or
> unspecified behaviour that they provide, the documentation patch included in the
> series also describes the intended behaviour in detail, and can be used as a
> specification for the rest of the series.
> 
> The entire series can be retrieved or browsed here:
> 
>     https://repo.or.cz/linux/zf.git/shortlog/refs/heads/ntsync4

No one is going to dig elsewhere for kernel changes, sorry.  Please
submit them in email for review, that's the only way we can look at them
and comment.

thanks,

greg k-h

