Return-Path: <linux-kernel+bounces-120708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D11888DBC8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F09F2959B2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB12D52F7B;
	Wed, 27 Mar 2024 11:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IgzwqvZU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A3654BC7;
	Wed, 27 Mar 2024 11:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711537292; cv=none; b=Fih/sPEiV63JhTy2HEYwJb8FQtwBREOMbzFTLxTRdEEZIw67ucKSMSlWoUGR6ocdcRdiLib9BaKSq8OWkrqEqYUPNFjntRO0dDgQNBXt2e6XPqGYpj3itajEj36jlUnSKsGACTGQpuZGhbtuQ/cXqPk/d0d0OmyBcOIcF0ixjM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711537292; c=relaxed/simple;
	bh=FeuyH0m9/+zRJP3gPnzf/OHLdiZaQwQgOVM2wU/3j08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVcm3HHXQxe8gDJXGyDIyDl5I6OAHQmRBUwG52SXgJHPYQbMfsF58OAgyUUzsM47ClBjHMEyGKQ2QtTzjgRrlKboUTUtns81P45bFoyuIc7KKDg8HUGUOrLwiz3dcgb2LXhbECDehgYYvzj4ok2QWuKT+Ia3fM1jSPC/aFkbBJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IgzwqvZU; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711537291; x=1743073291;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FeuyH0m9/+zRJP3gPnzf/OHLdiZaQwQgOVM2wU/3j08=;
  b=IgzwqvZUk09aJmPVMtbQ6+YJEjQzZdFlqUlzpddBtQTD29cDR2Ikh5B4
   IA/PUl/HT4l44XUpzUiH+5oLTnphIUpaOEQ7r3ShsY34T3YghNHeX4iZ/
   MIvevHQfYxH91jACbqUV53n3VdFBofT5/jcd0tAdE7xxuVlD2LjUBlFpS
   xAhgilv2rSQMr31nhzGzWksHaKymSr7OlOfifnz/uA8YsdPUQzz6qkKNl
   FGicgQaFyGhP9VpPcUslWDZYe6F5mVzrFDrQZLb0LF1RQZg8U8dNkYOhW
   fHpnAbVml9fo9cwAK8nsYuieozqZo0NnmUqpZYZUBg+nnbjTtg53xWOWR
   g==;
X-CSE-ConnectionGUID: BXSJ2w1jQhqp/fsgkKmcWA==
X-CSE-MsgGUID: Xu3m23YvRw2tXgNGSZBgVQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="17359807"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="17359807"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 04:01:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="937074418"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="937074418"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 27 Mar 2024 04:01:27 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 27 Mar 2024 13:01:26 +0200
Date: Wed, 27 Mar 2024 13:01:26 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Pavan Holla <pholla@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: Re: [PATCH] usb: typec: ucsi: Wait 20ms before retrying reset
Message-ID: <ZgP8hqNXuMdkp7A5@kuha.fi.intel.com>
References: <20240325-ucsi-reset-delay-v1-1-d9e183e0f1e6@chromium.org>
 <2024032624-subtitle-crisped-f4f1@gregkh>
 <CAB2FV=4Z1W1HSba50KaB3rR4=Ussb5RWPwUArr0_=3pFwxpAhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB2FV=4Z1W1HSba50KaB3rR4=Ussb5RWPwUArr0_=3pFwxpAhA@mail.gmail.com>

Hi,

Normally the driver does not retry the reset, so maybe you should just
say "wait 20ms before reading the CCI after reset", or something like
that.

The idea here is to give the PPM time to actually update that field
before reading it, right?

On Tue, Mar 26, 2024 at 04:34:44PM -0700, Pavan Holla wrote:
> On Tue, Mar 26, 2024 at 1:29 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Mar 25, 2024 at 09:19:43PM +0000, Pavan Holla wrote:
> > > The PPM might take time to process reset. Allow 20ms for the reset to
> > > complete before issuing another reset.
> > What commit id does this fix?  Does it need to go to older kernels?
> 
> This does not fix any commit. However, the time taken by a CCI read is
> insufficient for a ChromeOS EC and PDC to perform a reset.

Perhaps you could put that to the commit message.

> > > There is a 20ms delay for a reset retry to complete. However, the first
> > > reset attempt is expected to complete immediately after an async write
> > > of the reset command. This patch adds 20ms between the async write and
> > > the CCI read that expects the reset to be complete. The additional delay
> > > also allows the PPM to settle after the first reset, which seems to be
> > > the intention behind the original 20ms delay ( kernel v4.14 has a comment
> > > regarding the same )
> >
> > Why was the comment removed in newer kernels?
> 
> The comment was removed when the old UCSI API was removed in
> 2ede55468ca8cc236da66579359c2c406d4c1cba
> 
> > Where does the magic 20ms number come from?  What about systems that do
> > not need that time delay, did things just slow down for them?
> 
> I am not sure how 20ms was decided upon. However, UCSI v1.2 has
> MIN_TIME_TO_RESPOND_WITH_BUSY=10ms. So, we need to provide at least
> 10ms for the PPM to respond with CCI busy. Indeed, this patch slows down other
> implementations by 20ms. UCSIv3 also defines a 200ms timeout for PPM_RESET.

It does not slow down other implementations. The delay has always been
there before the RESET_COMPLETE bit is actually checked.

The change here makes sense to me. Just rewrite the commit message.

thanks,

-- 
heikki

