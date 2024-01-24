Return-Path: <linux-kernel+bounces-36978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3377583A9BE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2DDF2820EF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C65634E8;
	Wed, 24 Jan 2024 12:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n9pDCVXd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E6B63132;
	Wed, 24 Jan 2024 12:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706099373; cv=none; b=j5ZW+yX0Mk5ZOA92Xo04CD0nik0z2hv1fGvhjUecxcTQsU6uiVlbh3eVgeT2mNfwDXAlbBEOwBlnZEdQ8YhtmmCPrdXi0DNaOVB3jKQ/US2yEsSGgqnXaKaLEixW2Lyy5GKPdXkVb3C+l9uhYW/GwZTcajvgD43YMWwDTyTQzWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706099373; c=relaxed/simple;
	bh=IzOfGdfJXN3HNbPaRtSQvSMPHR7T4ik2CCl3pxrUFgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7E8T70kEtXoDtyUNXhbAFRUI7YTXu8DeZlwLrMt9X/M8on80kCo/a22uHix5zSzPVAlqwUWgCvLGRWFE0EV6tan+jyUa53j25qmgJxhPNCaa3hWRaqJ8BvuqkY+bhAYrN5C5koDVUlyEJWGx9Yfz7oHUJVoasa3E23BVctOJpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n9pDCVXd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041A9C433C7;
	Wed, 24 Jan 2024 12:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706099372;
	bh=IzOfGdfJXN3HNbPaRtSQvSMPHR7T4ik2CCl3pxrUFgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n9pDCVXdgkLKPjjOruZNmL62cpZqpCYGHjAyVcFd9F1IsweGSkHZf+xMNRQ/WhUlp
	 IhLULUDAXn1gmONmW/vrlboDuatOYfM3hU/zaw3vqs6rD8U0/B8tp/P6QRPYl/0D8l
	 XHan51XoSkwy16nlQ3fvFtzmW9bcZ0JDpGrrq/hY=
Date: Wed, 24 Jan 2024 04:29:30 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Elizabeth Figura <zfigura@codeweavers.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, wine-devel@winehq.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Wolfram Sang <wsa@kernel.org>,
	Arkadiusz Hiler <ahiler@codeweavers.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 0/9] NT synchronization primitive driver
Message-ID: <2024012401-garter-empower-14bf@gregkh>
References: <20240124004028.16826-1-zfigura@codeweavers.com>
 <2024012319-aptly-calculate-0f88@gregkh>
 <12365105.O9o76ZdvQC@camazotz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12365105.O9o76ZdvQC@camazotz>

On Tue, Jan 23, 2024 at 07:37:01PM -0600, Elizabeth Figura wrote:
> On Tuesday, 23 January 2024 18:59:35 CST Greg Kroah-Hartman wrote:
> > On Tue, Jan 23, 2024 at 06:40:19PM -0600, Elizabeth Figura wrote:
> > > == Patches ==
> > > 
> > > This is the first part of a 32-patch series. The series comprises 17 patches
> > > which contain the actual implementation, 13 which provide self-tests, 1 to
> > > update the MAINTAINERS file, and 1 to add API documentation.
> > 
> > 32 patches?  I only see 9 here, why not submit them all?
> 
> Because Documentation/process/submitting-patches.rst makes a point of asking people not to submit large patch series (and it matches the expectation of other projects I've worked with—that patches would be submitted and reviewed a few at a time). I suppose I've misunderstood that advice, though.

32 patches isn't all that "large", we can handle that easily :)

100+ patches is large, I guess it all depends, so I can understand the
confusion.  You need to send us enough for us to be able to understand
and review the code, this was a bit short for that.

> I'll resend with the entire series. Sorry for the noise.

Ptches are NOT noise, we want to see them!

thanks,

greg k-h

