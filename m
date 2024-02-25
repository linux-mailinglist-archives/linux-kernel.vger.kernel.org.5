Return-Path: <linux-kernel+bounces-80057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3FA862A42
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 13:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9882B28154D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 12:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A26111733;
	Sun, 25 Feb 2024 12:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAqHxAmn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6473CD528;
	Sun, 25 Feb 2024 12:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708863272; cv=none; b=FhCxRZ5CX/H58VVnF3y3LmcExjuXxdtOr4XNuh63VrSVSZoWjIF+OXR6Ugm7Kco9g4QRj/RrVStAJ+FtQIlTFsq2iS0QpJDZDqX1ysqB/AttzEJ3skjHeTosvu5A4VV+Gm0hSkslSpa2b+tmiS8fyqDeeqHv7MiV0UXLnirNNmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708863272; c=relaxed/simple;
	bh=lYRiH0WxZt/e65XgOHzmCpT7ziP+FDLeHqqPGpHDKWw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t8Eku5dP4/3sSw4m1uh0jnVJG6PeRPLgay0zq2+1OVRi2hOhI/xW8jakuWzqivNMdf9hvPfxxB+zqWNt7Vy99kC0VnOVNUTHH4aAzewX35HlEd+m/XhTmB8+fgANbdOx07H8r09XigWLQ2I4pvEhtTj8UBFZKd7hh4Z/PfL6Fxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAqHxAmn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93FF5C433C7;
	Sun, 25 Feb 2024 12:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708863271;
	bh=lYRiH0WxZt/e65XgOHzmCpT7ziP+FDLeHqqPGpHDKWw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lAqHxAmnwX+wQgFgMmo/WoutOetPW7LfjA51qEu/bIinx7PuGe4QFMBtzZ2pli1qe
	 tCy69NXBD6bc06eLQCHF6upiWLbgyzUIq7Bc/rmxt8y/OrsDt2d/1Gbfas5NeMWXjq
	 HtGzbG2er9uxpYTo8P8gzNrkj8dSRihiS35BEfYNMpCI3vK3un9emf/E9hTs2u/3Xu
	 Jv+zllXJaSr0mtf72QAbYRbfK33P2eHSfNS2on2Kog45f0U6GsxTLtQYtCvkLVGUji
	 Q2efWsaJGetOV5qclliApd73zJV/eNKvSZosBdavPMO39huBNmr5twTc3UpoVQNcrx
	 UTJhqxwGiDHFw==
Date: Sun, 25 Feb 2024 12:14:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@pengutronix.de>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, linux-iio@vger.kernel.org, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill
 Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 llvm@lists.linux.dev, Tomislav Denis <tomislav.denis@avl.com>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] iio: pressure: dlhl60d: Initialize empty DLH bytes
Message-ID: <20240225121415.273ec110@jic23-huawei>
In-Reply-To: <202402230949.E06F3297@keescook>
References: <20240223172936.it.875-kees@kernel.org>
	<ZdjaOLVd1yxNXhsp@smile.fi.intel.com>
	<202402230949.E06F3297@keescook>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Feb 2024 09:50:10 -0800
Kees Cook <keescook@chromium.org> wrote:

> On Fri, Feb 23, 2024 at 07:47:36PM +0200, Andy Shevchenko wrote:
> > On Fri, Feb 23, 2024 at 09:29:39AM -0800, Kees Cook wrote:  
> > > 3 bytes were being read but 4 were being written. Explicitly initialize
> > > the unused bytes to 0 and refactor the loop to use direct array
> > > indexing, which appears to silence a Clang false positive warning[1].  
> > 
> > ...
> >   
> > >  	for_each_set_bit(chn, indio_dev->active_scan_mask,
> > > -		indio_dev->masklength) {
> > > -		memcpy(tmp_buf + i,
> > > +			 indio_dev->masklength) {
> > > +		memcpy(&tmp_buf[i++],
> > >  			&st->rx_buf[1] + chn * DLH_NUM_DATA_BYTES,
> > >  			DLH_NUM_DATA_BYTES);
> > > -		i++;
> > >  	}  
> > 
> > Not that I'm against the changes, but they (in accordance with the commit
> > message) are irrelevant to this fix. I prefer fixes to be more focused on
> > the real issues.  
> 
> Jonathan, let me know if you'd prefer I split this patch...
> 
Andy is strictly speaking correct that the indent should be separate patch
but meh - not worth the time to split that out + the change makes the
fixed code itself easier to read. 

I added a tiny comment to say it the indent tidying up was incorporated
so the fixed code was more readable.

Applied to the fixes-togreg branch of iio.git and marked for stable.

Given timing this may well go in during the merge window rather than
before.

Jonathan


