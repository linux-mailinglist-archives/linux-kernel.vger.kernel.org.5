Return-Path: <linux-kernel+bounces-61337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5E485113B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DE991C222EB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2091122F0C;
	Mon, 12 Feb 2024 10:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T8nE9Ohy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4595920DCF
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707734482; cv=none; b=coprjqJR/QjuM1F6Ddd3xJgHXGaF0bfsQKfWD031Mm9qxkkcxSu8x4PYg1MjdQF8G8uuFhvJykbbVNr46emguvgnnaV66vGmIOmdvvq/vG328iBwqU6p/5PqeFq10F7dpzxnWP6ugNIhGdlf9zLhSCuxP65rGpuaIee2iYQ5w8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707734482; c=relaxed/simple;
	bh=COzgZIdVTzpQkoTJd5fKW1JsU3KKcKHwzae3qudrIzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OU7LuRUYQAp6RoGLJQ+23WT60VpXmjCLklD2vYtYT3iu0nLCKzQjZ/TpvuNwV4RGRtBRvAtHIhQSL4G03kk6rJ1u6awPSYXA9jGOPqfJLo3w1ZS/fP36/0htosKbHCIxtnWBJswI4XLS6aeyrMCFkjJBHlxBGxJZjeqo+19Pcgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T8nE9Ohy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FDB3C433F1;
	Mon, 12 Feb 2024 10:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707734481;
	bh=COzgZIdVTzpQkoTJd5fKW1JsU3KKcKHwzae3qudrIzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T8nE9Ohy3nIgqrI76nu5E6WcpXBNmTg6GmHrWS8z1cghzATgA4VqwREOk0ZYjuwXA
	 Nihd9RFhKol0ggK81o8kALD4CTGlZ034EE6wzQUt80iHJKszo1lqT5906QtBYKSNFZ
	 qv9ib6fKn+Yg6dwTk4IeiWA0kmmxtr7nj35aKUFA=
Date: Mon, 12 Feb 2024 11:41:18 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Wentong Wu <wentong.wu@intel.com>
Subject: Re: [PATCH 3/3] mei: vsc: Assign pinfo fields in variable declaration
Message-ID: <2024021240-encode-disjoin-c8c2@gregkh>
References: <20240212094618.344921-1-sakari.ailus@linux.intel.com>
 <20240212094618.344921-4-sakari.ailus@linux.intel.com>
 <2024021210-freeway-unblessed-d966@gregkh>
 <d14e8a0c-f510-4c98-9bb6-1728eceb61aa@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d14e8a0c-f510-4c98-9bb6-1728eceb61aa@app.fastmail.com>

On Mon, Feb 12, 2024 at 11:14:29AM +0100, Arnd Bergmann wrote:
> On Mon, Feb 12, 2024, at 11:02, Greg Kroah-Hartman wrote:
> > On Mon, Feb 12, 2024 at 11:46:18AM +0200, Sakari Ailus wrote:
> >> Assign all possible fields of pinfo in variable declaration, instead of
> >> just zeroing it there.
> >> 
> >> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> >> ---
> >>  drivers/misc/mei/vsc-tp.c | 16 ++++++++--------
> >>  1 file changed, 8 insertions(+), 8 deletions(-)
> >> 
> >> diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
> >> index 200af14490d7..1eda2860f63b 100644
> >> --- a/drivers/misc/mei/vsc-tp.c
> >> +++ b/drivers/misc/mei/vsc-tp.c
> >> @@ -447,11 +447,16 @@ static int vsc_tp_match_any(struct acpi_device *adev, void *data)
> >>  
> >>  static int vsc_tp_probe(struct spi_device *spi)
> >>  {
> >> -	struct platform_device_info pinfo = { 0 };
> >> +	struct vsc_tp *tp;
> >> +	struct platform_device_info pinfo = {
> >> +		.name = "intel_vsc",
> >> +		.data = &tp,
> >> +		.size_data = sizeof(tp),
> >> +		.id = PLATFORM_DEVID_NONE,
> >> +	};
> >
> > But now you have potential stack data in the structure for the fields
> > that you aren't assigning here, right?  Is that acceptable, or will it
> > leak somewhere?
> >
> > This is why we generally do not do this type of style.  So unless you
> > are fixing an issue here, please don't do it.
> 
> If you have any initializer, all named fields in the structure
> are zeroed. The only bits of the structure that may contain
> stack data are for padding between fields, but that doesn't
> actually change here from the previous version.

I thought we had looked into that before and it would 0 out everything
if you just had the {0} initializer, including holes?  Or was it not, or
did it depend on the compiler/version?
Sorry, I never remember and so just recommend a memset which should be
the same overall.

> The old version you have here just skips the named fields
> and otherwise would end up lookingn like
> 
> struct platform_device_info pinfo = {
>       .parent = 0,
> };
> 
> which is still a partial initializer and has the added
> problem of relying on a literal '0' as a NULL pointer.
> In modern compilers, one can write this as
> struct platform_device_info pinfo = {}, but Sakari's
> version looks best to me.

Ok, as long as there's no stale stack data, I'm ok with it.

thanks,

greg k-h

