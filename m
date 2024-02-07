Return-Path: <linux-kernel+bounces-56203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4873F84C74A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4C6E1F231B7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AA522338;
	Wed,  7 Feb 2024 09:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7iap582"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F3D22307;
	Wed,  7 Feb 2024 09:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707298082; cv=none; b=SK6BbS6BJiyZB//giVG9PHxlhpHo3mQUHi0y29CW8RToDxGP5R0XIOqyzfclMZ++7McSKnmQlQpXrJbAPYHrW1hs2VEN2DA4OgHzK/VkkvLsd0cQXykE0+S2Zg6l0aFgs4ajStLTi2i2V+HQFqenO53EHnd2jolumtGtMZlx4N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707298082; c=relaxed/simple;
	bh=JJ9eA7LhKbHPZoURFpSO3g1gw2/bO/Jr11wVI8p95HA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqDL9AM7Hq9xt3zC3pN7yNgWJSKECzO+vvI4mW7AMMVXJjmD5ZoVr1cGz3bfc9fuPOoueaY4PJsm6dN+nPVGNGIoEH/G/bFtwia8DJ4CmpQhtzfZLahD+6G22zL/COJwuqJVoeiS2CsTJOhzEg5oa0J/M8t9hrnkf6QgLcFbtcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7iap582; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93CF4C433C7;
	Wed,  7 Feb 2024 09:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707298081;
	bh=JJ9eA7LhKbHPZoURFpSO3g1gw2/bO/Jr11wVI8p95HA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S7iap582BMDKyNa4ZhUnKnK0ROnqnb37DBTwZ9yZEgV6HW0P1WH8wtIg3BTnD4tpw
	 fVbaLjXIhzOVOF2VEMWF1k3IeeTDUIQjC44CBJ6oosvCwsjZvWQ3nB8Jth0/wu+ItE
	 JJdA+ZpQmwDdF4trWFcw+OLkImRIc8cLikUqt7Sz5nL14rJkkavxFHeFNzA52qnbqY
	 H4L3kPaHS5B2IxD9fc/XMKzLx8PKaYb03OHB8+xe70gvw64LOKV/8KzKoG9VtuFMuY
	 cJEo92XAFLDceUCjFZlrKYtYIEtoDim8OQwBn7m7o3e4nrqStGU05GNSQ4o5aMMXWD
	 xZzfTyVw/gDRQ==
Date: Wed, 7 Feb 2024 10:27:57 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the block tree with the vfs-brauner
 tree
Message-ID: <20240207-garen-gedanken-48c03f835362@brauner>
References: <20240206124852.6183d0f7@canb.auug.org.au>
 <332c106c-21af-4691-8b3f-ffbdf30fecf0@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <332c106c-21af-4691-8b3f-ffbdf30fecf0@kernel.dk>

On Tue, Feb 06, 2024 at 09:37:33AM -0700, Jens Axboe wrote:
> On 2/5/24 6:48 PM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Today's linux-next merge of the block tree got a conflict in:
> > 
> >   block/blk.h
> > 
> > between commits:
> > 
> >   19db932fd2b0 ("bdev: make bdev_{release, open_by_dev}() private to block layer")
> >   09f8289e1b74 ("bdev: make struct bdev_handle private to the block layer")
> >   d75140abba91 ("bdev: remove bdev pointer from struct bdev_handle")
> > 
> > from the vfs-brauner tree and commits:
> > 
> >   c4e47bbb00da ("block: move cgroup time handling code into blk.h")
> >   08420cf70cfb ("block: add blk_time_get_ns() and blk_time_get() helpers")
> >   da4c8c3d0975 ("block: cache current nsec time in struct blk_plug")
> >   06b23f92af87 ("block: update cached timestamp post schedule/preemption")
> > 
> > from the block tree.
> > 
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> 
> That's a lot of conflicts. Christian, we really should separate some of
> these so we can have the shared bits in a shared branch.

Yes, happy to do that. Let's quickly sync later today when you're up?

