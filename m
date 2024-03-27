Return-Path: <linux-kernel+bounces-121321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E2B88E5ED
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF0061F2D167
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67796137759;
	Wed, 27 Mar 2024 12:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnnxwCQM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00D013776E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 12:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711543866; cv=none; b=FvaKhF6fQRRiYyd7sItjIpyi2LLWSBZ9GE3HK6F+2p1B+COOP2CjXLIlk6svx7oDs4s3ywIhOVplUlvz29/xzrC9X/ETYgAL6EfeVUv2igugyimtHhylh1tyjGep2OqaSYclLkx3gv45PGyyEKFiDX0kxzCAzwOworbPUbGfZnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711543866; c=relaxed/simple;
	bh=PJI3yotieIXJ09NShbI7HjyU5QvebwSEl7+j6u6cYxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMFIoUi0z/zXW/eX3inK3kFm+69UDZXlhl5u2VHdmG6Cw9kyoSufNk0rCiSXJI0CbNNF5NuiplHUm3PF8jcBig+P8+WIpV4veA+OV1exafysrzzmjLovv0hNMvNAE+MDBiR1eZEk04jGTp7WfIxJR9YBU5W/rK9uro5nYOFsnbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnnxwCQM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C136DC433C7;
	Wed, 27 Mar 2024 12:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711543866;
	bh=PJI3yotieIXJ09NShbI7HjyU5QvebwSEl7+j6u6cYxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZnnxwCQM9WZlqK7t9UoomyEa9q8AnftIYTNv8fiHa+8/T4aM3cXvM2vd6BkUk5zVV
	 Sr99YbyU61VTxJp9JVqpViEytsuR3AX5zbf9J32KfcwXtQJvdphEb0q0wUaVckTqcf
	 nZAnkHQJPaDDzq5nYT0togqvNS0TMjbLpo9LQWOJMV/+hm0HE/9+wuXdZD96sTjKfq
	 ICp1Wf3Fp4fvIsH9E+hsnnIyG/feNzSKoEplNfSao8YTnrVi6Y6jWuGbGpLQTt2AAC
	 iQGeIz2Ph3AdDTBaNvubV3Bmti0htwXRQHKr5JxCj2v42ZDThlN9GhVKdkK01clW6M
	 7bhQ02ASe9cVg==
Date: Wed, 27 Mar 2024 18:21:02 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH 0/7] Soundwire: clean up sysfs group creation
Message-ID: <ZgQWNjZ9EfhU5A9X@matsya>
References: <2024013025-spoiling-exact-ad20@gregkh>
 <ZbpFTyW9UCZdCs_v@matsya>
 <2024032742-armless-cage-7c6c@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024032742-armless-cage-7c6c@gregkh>

On 27-03-24, 09:13, Greg Kroah-Hartman wrote:
> On Wed, Jan 31, 2024 at 06:34:15PM +0530, Vinod Koul wrote:
> > On 30-01-24, 10:46, Greg Kroah-Hartman wrote:
> > > Note, this is a redone version of a very old series I wrote back in
> > > 2022:
> > > 	https://lore.kernel.org/r/20220824135951.3604059-1-gregkh@linuxfoundation.org
> > > but everyone has forgotten about it now, and I've reworked it, so I'm
> > > considering it a "new" version, and not v2.
> > > 
> > > Here's a series that adds the functionality to the driver core to hide
> > > entire attribute groups, in a much saner way than we have attempted in
> > > the past (i.e. dynamically figuring it out.)  Many thanks to Dan for
> > > this patch.  I'll also be taking this into my driver-core branch and
> > > creating a stable tag for anyone else to pull from to get it into their
> > > trees, as I think it will want to be in many for this development cycle.
> > > 
> > > After the driver core change, there's cleanups to the soundwire core for
> > > how the attribute groups are created, to remove the "manual" creation of
> > > them, and allow the driver core to create them correctly, as needed,
> > > when needed, which makes things much smaller for the soundwire code to
> > > manage.
> > 
> > The series lgtm, having the core handle these would be good. I will wait
> > couple of days for people to test this and give a t-b and apply.
> > I hope it is okay if patch1 goes thru sdw tree?
> 
> patch 1 is now in Linus's tree, so the remaining ones can go through the
> your tree now if you want.  Or I can resend them if needed, just let me
> know.

Great, I was about to ask about this. If there is no conflicts I can
pick this series (looking at folks for giving me a t-b)

-- 
~Vinod

