Return-Path: <linux-kernel+bounces-148128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5255F8A7E16
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3C9CB255D0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A1F7E799;
	Wed, 17 Apr 2024 08:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eyhUP7D/"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6199A200D2;
	Wed, 17 Apr 2024 08:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713342110; cv=none; b=bOk0b3EHtEY7rZWNFI4AjxxqRY9dqdpyfZogItYkd8Let/lSSAYrFEPnjpgp50v0ru23RmPKiquBKQMCwe0Tu5oGwf5CK/sKq3WBBbPGmLB2nAOQgtHj62dbAaCZhtuzBm61T2skEeQ7zlkag90H2q51KjZ16fsm7TaGzQOfSIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713342110; c=relaxed/simple;
	bh=CPggfGXwfpYl2LtMCk0W03Y0VcfNgWkf80LldNabsH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dx+xaR1pq28yHFWTrY6d+60mnfwHflcTxC74cTbI0YRcnZUPkajS2stApOEsEq/mDY2rJJJvMf6K+y0OqzY4dX8d3MoNJCVDHlvbDSvYBPyLzfH+rc4VT8feSlO5a9L1T1CTnHqXSntteC4KahvvhrFzX59WypRGKsxErRT1ACA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eyhUP7D/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 10DF220FD4AC; Wed, 17 Apr 2024 01:21:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 10DF220FD4AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1713342109;
	bh=ml3zwjbhdXgIfoUW8gx0aMxv4GKw5XoRcB9hMN/WDuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eyhUP7D/9u3vQ1XfE4uno2+u01BUlHETLcI7zZN4hEVGHY+upG/Qi3ziUUDyNisWh
	 8eClWwyGeUQ1NYJllVH9O0f4lyYc1WMO6G9nkR2EPtwKmL09N9dcoGducXt0YCCg01
	 irKj2u5TczGbdA2Fi6zf5GDoihfglCi1OLvPyrcE=
Date: Wed, 17 Apr 2024 01:21:49 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, ssengar@microsoft.com
Subject: Re: [PATCH] tools: hv: suppress the invalid warning for packed
 member alignment
Message-ID: <20240417082149.GA9867@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1713340848-6901-1-git-send-email-ssengar@linux.microsoft.com>
 <2024041708-juror-briskly-9c86@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024041708-juror-briskly-9c86@gregkh>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Apr 17, 2024 at 10:17:21AM +0200, Greg KH wrote:
> On Wed, Apr 17, 2024 at 01:00:48AM -0700, Saurabh Sengar wrote:
> > Packed struct vmbus_bufring is 4096 byte aligned and the reporting
> > warning is for the first member of that struct which shouldn't add
> > any offset to create alignment issue.
> > 
> > Suppress the warning by adding -Wno-address-of-packed-member flag to
> > gcc.
> > 
> > Reported-by: kernel test robot <yujie.liu@intel.com>
> > Closes: https://lore.kernel.org/all/202404121913.GhtSoKbW-lkp@intel.com/
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> 
> What commit id does this fix?

Fixes: 45bab4d74651 ("tools: hv: Add vmbus_bufring")

- Saurabh

