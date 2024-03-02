Return-Path: <linux-kernel+bounces-89525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4047B86F18F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 18:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAB1D280D76
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 17:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5462B9D4;
	Sat,  2 Mar 2024 17:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1IOPYinR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5904523778;
	Sat,  2 Mar 2024 17:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709399034; cv=none; b=YsznOH+CMn7VYnq4/AgU20qU4p0DKR2ZJ+4pbID5BSk8E6XgIc8VGwbXehFF69XsyWb8q0x4BegmO4AJGFwPgbBbgpNcaO9lz21UABWrZgeWTCpIIwgxrBYLNiQkPBUwae6UpSJMC7BC2yBHpsY5WiAQqaBZHjkTUU+Rd+7BHak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709399034; c=relaxed/simple;
	bh=VX+JGb4hle75BU74tkq04eaqi7qIetBOEuRFyvUaLiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0G0oIxQAlTulcY12DqMAd+aMHg4KYB9hSHp8YcUr2lTaQYJImOd4aKcuMB86++/pxiyU2pQj+I4xV3oV6MdLadaPAYH/rxQ/gGVSmlCOMKd23668/qlju2oh1q0URACNnqNaDmaOYVpPknRJwCnID07mjth4M0RepADrHmvYiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1IOPYinR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D336C433C7;
	Sat,  2 Mar 2024 17:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709399033;
	bh=VX+JGb4hle75BU74tkq04eaqi7qIetBOEuRFyvUaLiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1IOPYinRvSnlbUOACH6O+lciiYRobaW7o70IhdZNW0Ao/3O1Ezf9VmJZjd974gs3f
	 8TSx0hJ/iUW2HzrRr/gQihP1v3lAU22wKwFpnLjiJzPKegYw77cpgnCd7dGgIDznsx
	 I1xFrBuptI0Zk+IgeTXjyWF7LKXLSFB62KzDMXdA=
Date: Sat, 2 Mar 2024 18:03:51 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chris Clayton <chris2553@googlemail.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
	jslaby@suse.cz
Subject: Re: Linux 6.6.19
Message-ID: <2024030235-opium-drainage-4c0c@gregkh>
References: <2024030158-wildlife-elbow-9701@gregkh>
 <97323f16-c718-4ea9-bbe9-3bef6f1969d7@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97323f16-c718-4ea9-bbe9-3bef6f1969d7@googlemail.com>

On Fri, Mar 01, 2024 at 08:12:07PM +0000, Chris Clayton wrote:
> Hi
> 
> On 01/03/2024 13:15, Greg Kroah-Hartman wrote:
> > I'm announcing the release of the 6.6.19 kernel.
> > 
> > All users of the 6.6 kernel series must upgrade.
> > 
> > The updated 6.6.y git tree can be found at:
> >     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
> > and can be browsed at the normal kernel.org git web browser:
> >     https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> linux-6.6.19 fails to build when CONFIG_NTFS3_LZX_XPRESS is not defined. The same build failure occured in 6.8
> development and is fixed by c8e314624a1666ed2eec28549713021a8ec801e9

Thanks for the report, will go do a new release with this fix in it.

greg k-h

