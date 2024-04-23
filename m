Return-Path: <linux-kernel+bounces-155433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E896B8AEA64
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A2DB1F2363C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415B813BC20;
	Tue, 23 Apr 2024 15:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZT+9JKG2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6019213BADD;
	Tue, 23 Apr 2024 15:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713885227; cv=none; b=mRbA9r88e2xQPqwW6yMoBXBQ8Pad8g1h66eavp5LTKVPBS771dWxugTos73seLYszbQ4R8Ca5zsS4iHhEEBGZNdQnx9Pk90hEm6sOCqzyyNZWFCA9kdqgJ3ETCvqBSMsjpZcdKTdy7iVM6QCOQun4ZJq4fF/8T6Ix7nBjDOzDQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713885227; c=relaxed/simple;
	bh=RJ4ooxxQshso5u8umOVzklJnomOaOetIWXrHfhND/pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihrRQkbNgxtkAsxAAPBQfwBdWJ+AWoPpSM8U9n/Vhfa9hTwIp5sIFFWvRw6T88P0PIM3yUptI1u7WjNKQDAPsHFX7yM3DRGmMgwjoVEiGe142X5oo7TPXfWbpVEmi/cmYv9RBnOcbl3otKDJxC9RINH0UwgqbsuCcEgFwZPRTMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZT+9JKG2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF20C116B1;
	Tue, 23 Apr 2024 15:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713885226;
	bh=RJ4ooxxQshso5u8umOVzklJnomOaOetIWXrHfhND/pE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZT+9JKG2F+e3PRY/IMhM4veegw94Uo32VvswK4aOm9OH6/f+GFt32ky8EYBw7QpQE
	 FqqS5gkq2QJJSxWdC45C0LkCkjg7pQ9yiGWug73McnZaZ2L+Er3R7W/PwMtuGEJgHV
	 13fSNzHKBBpZ/kOfRdAivn44UedZ4mcgXLdigHvQ=
Date: Tue, 23 Apr 2024 08:13:37 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v1 2/2] Documentation: process: Recommend to put Cc: tags
 after cutter '---' line
Message-ID: <2024042347-ellipse-overeater-9aff@gregkh>
References: <20240423132024.2368662-1-andriy.shevchenko@linux.intel.com>
 <20240423132024.2368662-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423132024.2368662-3-andriy.shevchenko@linux.intel.com>

On Tue, Apr 23, 2024 at 04:19:38PM +0300, Andy Shevchenko wrote:
> The recommendation is based on the following rationale:
> 
> - it makes the commit messages much cleaner and easy to read, especially
>   on the screens of the mobile devices;

Reading commits on a mobile device is not what kernel development is
optimized for, sorry.

> - it reduces resources (memory, time, energy) to retrieve all these
>   headers, which are barely needed by a mere user, as for automation
>   they will be still available via mail archives, such as
>   https://lore.kernel.org, assuming the Link: or Message-ID tag is
>   provided.
> 
> Let's be environment friendly and save the planet!
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  Documentation/process/5.Posting.rst          | 4 ++++
>  Documentation/process/submitting-patches.rst | 5 +++++
>  2 files changed, 9 insertions(+)

This breaks my existing workflow, sorry.  I can't track cc: below the
--- line because obviously, git cuts that off.  So I put them above
where git send-email can see them, AND where git can handle them when I
rebase/revise/etc.

Also, as Jon points out, the "environmental" argument seems very odd,
it's not like bits cost more to send around (they keep getting cheaper
in power and money), and processing power is pretty constant for servers
handling email, so I don't understand the power consumption argument.
Without some sort of data to back that up, I'd be loath to repeat it.

thanks,

greg k-h

