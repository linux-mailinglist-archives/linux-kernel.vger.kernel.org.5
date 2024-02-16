Return-Path: <linux-kernel+bounces-67951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65671857383
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 02:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C48A7281EE0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E233EDDC4;
	Fri, 16 Feb 2024 01:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGbnbfb3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7C2F9DA;
	Fri, 16 Feb 2024 01:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708047638; cv=none; b=rvMYbeZh30Tp3augB54g2Hx9qQoB/NCvmu3wEGVzRhL9onjs1Zl8Yrjal7SOMKRguS/rRIE/p1flPowloF2jjTg7+9w0NvTax2wIc+wxVn+PRnNhQBPeK9s21fiQXlhbtJs2sBHoUTmAcszBOfzjZ/FS2zz5ULVHDRr5iweD5Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708047638; c=relaxed/simple;
	bh=KHdlvUaHaDZaHCD4P4fvcHX8hb7Xkbd/GjEnKKFwBXk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iILvBy6jDfpBiZSeUGZ2/pWE6PdfwNorhrASMyXXaDp9D2YkMgKkFHQ0eZXkQK9jY+HmPNvv5yhUl0glAcv0WQGnBgWi8M4Hvtj84w9XG3E7srfOwlfOHUCcPLyjAtS8ybTZ1AHh20POcMRmQKcPRPLJ+ZMWgzCNcyCwmDVRgyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGbnbfb3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA71C433F1;
	Fri, 16 Feb 2024 01:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708047637;
	bh=KHdlvUaHaDZaHCD4P4fvcHX8hb7Xkbd/GjEnKKFwBXk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aGbnbfb35z3yv+Qi/s8NVgVpAWQgFJ3huflDP5lPv+eyXCw24T8OQvHtZFCD5tqp8
	 SjXP7K/HUjo02Qy+9KQMX2q6hVCOf/TBsZjXygNsdZa9dC4VBEhCsu7Q9POmhsk7Xg
	 RJUuwBJ7gbeC16myH0pVhB46T31NAHeSp5nU2uRlmLVdkfq7D5Q285JyKHyMABPhLo
	 2qMSrHeUD3KWJ7HW7d1f2PgZLx+1eK1u99wXHHu9dm0nTgvexHRVDlqLS3ifk661x8
	 342CH8htKf+pU07kGKPgUI7LJkT58ZxwdQivl4ZKEZ1WRLcTVU2uuz5MW02Ca6CEfW
	 YvWDdS8XYWdwg==
Date: Thu, 15 Feb 2024 17:40:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>, Christoph Hellwig
 <hch@infradead.org>, Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Leon
 Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Leonid Bloch
 <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>, Saeed Mahameed
 <saeedm@nvidia.com>, David Ahern <dsahern@kernel.org>, Aron Silverton
 <aron.silverton@oracle.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240215174034.34817c31@kernel.org>
In-Reply-To: <20240214183755.GH1088888@nvidia.com>
References: <20240207072435.14182-1-saeed@kernel.org>
	<Zcx53N8lQjkpEu94@infradead.org>
	<ZczntnbWpxUFLxjp@C02YVCJELVCG.dhcp.broadcom.net>
	<20240214175735.GG1088888@nvidia.com>
	<20240214101126.0c3681ee@kernel.org>
	<20240214183755.GH1088888@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Feb 2024 14:37:55 -0400 Jason Gunthorpe wrote:
> On Wed, Feb 14, 2024 at 10:11:26AM -0800, Jakub Kicinski wrote:
> > On Wed, 14 Feb 2024 13:57:35 -0400 Jason Gunthorpe wrote:  
> > > There is a clear split in my mind between:
> > >  - inspection debugging
> > >  - invasive mutating debugging
> > >  - configuration  
> > 
> > Yes there's a clear split, and how are you going to enforce it on 
> > an opaque interface? Put an "evil" bit in the common header?  
> 
> The interface is opaque through a subsystem, it doesn't mean it is
> completely opaque to every driver layer in the kernel. There is still a
> HW specific kernel driver that delivers the FW command to the actual
> HW.
> 
> In the mlx5 model the kernel driver stamps the command with "uid"
> which is effectively a security scope label. This cannot be avoided by
> userspace and is fundamental to why mlx5ctl is secure in a lockdown
> kernel.
> 
> For example mlx5's FW interface has the concept of security scopes. We
> have several defined today:
>  - Kernel
>  - Userspace rdma
>  - Userspace rdma with CAP_NET_RAW
>  - Userspace rdma with CAP_SYS_RAWIO
> 
> So we trivally add three more for the scopes I listed above. The
> mlx5ctl driver as posted already introduced a new scope, for example.
> 
> Userspace will ask the kernel for an appropriate security scope after
> opening the char-device. If userspace asks for invasive then you get a
> taint. Issuing an invasive command without a kernel applied invasive
> security label will be rejected by the FW.
> 
> We trust the kernel to apply the security label for the origin of the
> command. We trust the the device FW to implement security scopes,
> because these are RDMA devices and all of RDMA and all of SRIOV
> virtualization are totally broken if the device FW cannot be trusted
> to maintain security separation between scopes.

You have changed the argument.

The problem Andy was raising is that users having access to low level
configuration will make it impossible for distro's support to tell
device configuration. There won't be any trace of activity at the OS
level.

To which you replied that you can differentiate between debugging and
configuration on an opaque interface, _in the kernel_.

Which I disagree with, obviously.

And now you're saying that you can maintain security if you trust 
the firmware to enforce some rules.

I'm not talking about security here, the evil bit is just an example
of an unsound design.

