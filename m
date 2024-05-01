Return-Path: <linux-kernel+bounces-165022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3468B86A7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 10:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47FCB28421B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 08:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A704DA16;
	Wed,  1 May 2024 08:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TU09MldD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466B128DC7
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 08:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714550566; cv=none; b=E103WQYDHbn4aSMQPROOgDSewl8rp99Yi+NZdIcvveBjXKLCtAht9v+b5DisamxKiAxLRNs7cFjljDTM8/VHesJ0W1/3hGhkWHkFj1m34G/uLK+PP84N6oWTwm/qqTh1ESBD+/1Rhq7YYBbNUvNI38jbrDEg7OYtb2nkZK6X0+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714550566; c=relaxed/simple;
	bh=ggvAk0xwkd/46EZe6QNux+iIXFC7QqHWcKz452uflbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJg5g4gbYquECcgNb+sLcpOr2KCelB6yeh2CKi2Yj/IkY5kraZdJSV5dThpmNX0Ryx1ZiiDHXWN/D0vORyvI1NmUPub4RJbpqo7Oq3T2hmYs+qmStOQYmklK1tWUHjkwR1RU+VuJ7Hcdpri8Dp3Rj5sRkfYGEwlOMmOpo4sENSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TU09MldD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650D3C113CC;
	Wed,  1 May 2024 08:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714550565;
	bh=ggvAk0xwkd/46EZe6QNux+iIXFC7QqHWcKz452uflbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TU09MldDZIfaLJXSEUNGwypVNl1NWvJcUq4/t4Yr7oRY/tIWfNmg87r7uelLSjiZw
	 fQlmFSQHccBZ8Gr0wqnTngyIG28SCxl9Gokn5/pRso/FDu3qNmFuSgS7Rl7wy3zUvp
	 bj59/fQs6Ss3Tsuz20DB9W2DOeDi8e4o0iCAMF4A=
Date: Wed, 1 May 2024 10:02:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vamsi Krishna Attunuru <vattunuru@marvell.com>
Cc: "arnd@arndb.de" <arnd@arndb.de>, Jerin Jacob <jerinj@marvell.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH v6 1/1] misc: mrvl-cn10k-dpi: add Octeon
 CN10K DPI administrative driver
Message-ID: <2024050101-handgrip-shabby-1675@gregkh>
References: <MW4PR18MB5244E39EEBC3689CBF086050A6152@MW4PR18MB5244.namprd18.prod.outlook.com>
 <20240429055027.2162310-1-vattunuru@marvell.com>
 <2024042950-refurbish-duckbill-77b4@gregkh>
 <MW4PR18MB5244A08DC9D2CF3FAF14314FA6192@MW4PR18MB5244.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW4PR18MB5244A08DC9D2CF3FAF14314FA6192@MW4PR18MB5244.namprd18.prod.outlook.com>

On Wed, May 01, 2024 at 07:46:55AM +0000, Vamsi Krishna Attunuru wrote:
> > > --- /dev/null
> > > +++ b/include/uapi/misc/mrvl_cn10k_dpi.h
> > > @@ -0,0 +1,37 @@
> > > +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> > 
> > Why is this file "GPL-2.0+" but your driver is "GPL-2.0"?  Is that what your
> > lawyers want to have happen (sorry, I have to ask.)
> 
> No specific reason, I think I need to use " GPL-2.0-or-later" instead of
> "GPL-2.0+", will fix it.

No, that's not the problem here at all, either of those are the same.
The problem is that it does not match with the C file.  Please work with
your legal department to choose what license you want for the files and
be consistent.

thanks,

greg k-h

