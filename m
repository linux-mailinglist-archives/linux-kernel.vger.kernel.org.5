Return-Path: <linux-kernel+bounces-48343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFB5845AAE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C6531C21BAE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DD25F489;
	Thu,  1 Feb 2024 14:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AMTa4S3R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D18A5D499
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 14:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706799386; cv=none; b=kRm77fB8PGyjwIjU5IUKYqqwuIGXACYhZVdqvgGR6i0k6+4T62xczjaNH7DqRtT50JuJb4dDuDG1qUqGRyPKEyrC7Ao+ESSEr+eEN17sWESkuNFLs/psiVoR9STx6goSmuS4oFpSmVWh0nT/ZoLnKZuQfwXKvps2urywIRGE/go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706799386; c=relaxed/simple;
	bh=p99XZQDSIF4J5KL8P8p6PnOx6ioMQ12GswsvQJ4B65I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJ5eXKgQh10vyPgiaUYh6ZQKzJRYq9uRhW3/IPkT4MAJwYLjybyK4d38y4jLTcWebIwChLFWSVVbfw4Z494MKFMo1MgNXVMLfEZPMf99mFPXi+b64CI1su39DRudi77B4DZIQHCAROD3ZE8qIFL2CzEY7zCVCtlc974BaDHbIKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AMTa4S3R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B51C433F1;
	Thu,  1 Feb 2024 14:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706799386;
	bh=p99XZQDSIF4J5KL8P8p6PnOx6ioMQ12GswsvQJ4B65I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AMTa4S3RnwgGsx1mp/r7TQh4PlnxN5s3g8fYtcGLxAid5zSuAbFd+Z7KMYFAeju0L
	 td9wX/2PmPUP+kMls+w/dKY7Coy/vPN4OpKu9RvuBfDJoZqdAFOr8SUBwjmReKJ3PI
	 PG5LjvXLrIV2jW6TgD1WDWJYtzryZ8p0BGOocsbE=
Date: Thu, 1 Feb 2024 06:56:25 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH 2/6] soundwire: sysfs: move sdw_slave_dev_attr_group into
 the existing list of groups
Message-ID: <2024020137-rebel-perkiness-7248@gregkh>
References: <2024013025-spoiling-exact-ad20@gregkh>
 <2024013029-afternoon-suitably-cb59@gregkh>
 <65b9d883538fa_5a9dd2946a@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <e2756783-b279-71c2-f844-4c3a4128bad9@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2756783-b279-71c2-f844-4c3a4128bad9@linux.intel.com>

On Wed, Jan 31, 2024 at 08:12:10AM +0100, Pierre-Louis Bossart wrote:
> 
> > Makes sense. I won't say "looks good" as this file has "slave" all over
> > the place, but I checked and it entered the kernel just before the
> > CodingStyle changed.
> 
> SoundWire 1.2.1 introduced the terms "Manager" and "Peripheral", I had a
> patchset to rename everything maybe two years ago already but it's been
> difficult to add without getting in the way of development and backports.

Don't worry about backports for stable, we can handle that.  Development
for fixes or changes should NEVER worry about stable kernels, worst
case, we can just take all of the same changes into them, no problem.

> Maybe a gradual replacement makes more sense, not sure how to go about this.

Just rename it all.

thanks,

greg k-h

