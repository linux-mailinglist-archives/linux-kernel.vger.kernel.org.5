Return-Path: <linux-kernel+bounces-46457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD988843FE9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6834A28D8D8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB317AE7D;
	Wed, 31 Jan 2024 13:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STuuWiXg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F9A79DD0
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 13:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706706260; cv=none; b=pPN1oPDf+yMET5DtsmUwuSFNWunItLTS8dEIZl5LZ0eWrUY0Qj97k2eytgbeV8gaS5u0CIiLN7SG3jbVNZKUlZ/yhSlMpgCzboA8L5l+E+nnKBRDNj3MwzXFpGDrJGOnnpgMdnmGgTfnWQBm+7u9S/CQ0q+yV2w3tAq3Y7RJO2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706706260; c=relaxed/simple;
	bh=Bhwmz/F21q1kBgFydqSZjzH43cF3Nb4bvQpSB4Ggiro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=he+T4pNwJT2tcueh1Udf4yS5vNGUU5NxEuQXaSCqABUARjTTY7nb2sd+j8ZgV3JvvCLXWh7KIvmVix9KXCIhsdfOFmqsJl3Ue+/V6el9m68HuWGEROuaK6UaV5+FCqBPQPlc8MOCF8k4FaXxvPOiStq/tBFXmG6SbLYrg2Qzixc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STuuWiXg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D858AC433C7;
	Wed, 31 Jan 2024 13:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706706260;
	bh=Bhwmz/F21q1kBgFydqSZjzH43cF3Nb4bvQpSB4Ggiro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=STuuWiXgFm0uKtFdbRCBs+QU3MEpoDCLVg2onooJaU5lUhwSQybtFHgqe0UZL3/Ru
	 qJ5lvtKnK84snuTKY+NqdwmJVQahSkVjeqnKeuNudX0Y5RfPbuZg1AhAMddXEUSi+J
	 khxQlZmkDEQQIULsANidjoL9MBOK0+rDXqdW2+zqh7vwib4NVWmjKEZUjDPLAS+U9e
	 +H6oZb5omK9mRe+gp/llSquQ3+h90Z1N7p+CA2hDmE5qJbb7N69S+zZDwQo/bLbwAx
	 8x5xaRC1b9l71P8ohg4jP3V78uOVtzAvQHxED5/0fRVu2QZVbQgVIt4bvJRiYQk/KZ
	 KX2XBZ+3fcU3Q==
Date: Wed, 31 Jan 2024 18:34:15 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH 0/7] Soundwire: clean up sysfs group creation
Message-ID: <ZbpFTyW9UCZdCs_v@matsya>
References: <2024013025-spoiling-exact-ad20@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024013025-spoiling-exact-ad20@gregkh>

On 30-01-24, 10:46, Greg Kroah-Hartman wrote:
> Note, this is a redone version of a very old series I wrote back in
> 2022:
> 	https://lore.kernel.org/r/20220824135951.3604059-1-gregkh@linuxfoundation.org
> but everyone has forgotten about it now, and I've reworked it, so I'm
> considering it a "new" version, and not v2.
> 
> Here's a series that adds the functionality to the driver core to hide
> entire attribute groups, in a much saner way than we have attempted in
> the past (i.e. dynamically figuring it out.)  Many thanks to Dan for
> this patch.  I'll also be taking this into my driver-core branch and
> creating a stable tag for anyone else to pull from to get it into their
> trees, as I think it will want to be in many for this development cycle.
> 
> After the driver core change, there's cleanups to the soundwire core for
> how the attribute groups are created, to remove the "manual" creation of
> them, and allow the driver core to create them correctly, as needed,
> when needed, which makes things much smaller for the soundwire code to
> manage.

The series lgtm, having the core handle these would be good. I will wait
couple of days for people to test this and give a t-b and apply.
I hope it is okay if patch1 goes thru sdw tree?

BR
-- 
~Vinod

