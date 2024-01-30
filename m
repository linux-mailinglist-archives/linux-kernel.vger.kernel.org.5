Return-Path: <linux-kernel+bounces-45500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 766F7843196
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28C121F25871
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7A97995A;
	Tue, 30 Jan 2024 23:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ukjz5tBU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EE079950;
	Tue, 30 Jan 2024 23:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706658689; cv=none; b=h70VwI1Jt8G7+tiQia1cDVbUY45nK2O9bYumxxLD117kNS1EtT5HQwItk9omV6wHw63JltkdIAt/IKjek+8JQJMG7H0hPIL8xewpUALNT5BsrZ+gGecRNQ9X5Meabk46edqcjaqDQl57M6gNR//dwelzIqMGcCTFaZXN/tPQG2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706658689; c=relaxed/simple;
	bh=ts7jazSRVV1P9ItQ7C42uy4otKEV6Cy0/Ol4l93+dN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6hAD2OxarbEi7mK+JooaXJHdGmVdk1k/e9OnOqdAFoTeM090figcLkWhbToaYlHLfWx+WkTL5pEWHwQOcUQyW0Fsn6p1+unIYWChMwTZZ2pBldg6o1/e/NojWDVDQYRMQVigK7mGVMPuO+EorKbqlJwlFX3GJI7W9HPQkfT67w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ukjz5tBU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB432C433C7;
	Tue, 30 Jan 2024 23:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706658688;
	bh=ts7jazSRVV1P9ItQ7C42uy4otKEV6Cy0/Ol4l93+dN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ukjz5tBUx7OK9rS9h6WvoALrVRg2Li3DNZBYpSyjRTHurjPue9uWo18dXT9FdtSSy
	 ZY6hiWKwu+Fkb12/+Abm0S22rikbnncsUI0WdBNp3iqNvDJAKsU/94h6VscKONFVJO
	 h1RX7IlFVl4y6qJWbgH4SdxZE7D8IC5KGWClOSM8=
Date: Tue, 30 Jan 2024 15:51:25 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>, kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	chrome-platform@lists.linux.dev,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] firmware: coreboot: Generate aliases for coreboot
 modules
Message-ID: <2024013059-poison-equation-81d1@gregkh>
References: <20240112131857.900734-1-nfraprado@collabora.com>
 <20240112131857.900734-3-nfraprado@collabora.com>
 <ZaQVScQ2AYquG-Zr@smile.fi.intel.com>
 <ZbA4VthTMPT7BSRo@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZbA4VthTMPT7BSRo@google.com>

On Tue, Jan 23, 2024 at 02:06:14PM -0800, Brian Norris wrote:
> On Sun, Jan 14, 2024 at 07:09:29PM +0200, Andy Shevchenko wrote:
> > On Fri, Jan 12, 2024 at 10:18:31AM -0300, Nícolas F. R. A. Prado wrote:
> > > Generate aliases for coreboot modules to allow automatic module probing.
> > 
> > ...
> > 
> > > (no changes since v1)
> > 
> > Same Q as per v1.
> 
> I don't have v1 in my inbox, and this wasn't addressed in v3 either. But
> copy/pasted off the archives:
> 
> "Don't you want to have a driver data or so associated with this?"
> 
> These drivers are super simple, and I doubt they will end up with
> multiple tags per driver, so it seems unlikely we'd ever need it.
> Additionally, struct coreboot_device already includes the tag
> information, so anything that could be included in driver data could be
> parsed out by the driver at probe time, if absolutely needed.

But why limit yourself to 32bits now?  Why not make it 64?  It is going
to be sent to userspace, so you have to be very careful about it.

thanks,

greg k-h

