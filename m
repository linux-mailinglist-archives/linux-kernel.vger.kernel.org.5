Return-Path: <linux-kernel+bounces-116532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A25F88A070
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7419A2C2911
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E328062B;
	Mon, 25 Mar 2024 07:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6Q4uah3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2DD1C6AE2;
	Mon, 25 Mar 2024 05:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711342917; cv=none; b=kavPRYOE3mYR8+9Zjha6ZwIkF7hFYOLz2V8kGvjAukTadeUKXRsiXMUqXGj1z2wZ0lXL0gWNudVQEh5MQ2MuzDL6Xyaa001oGxpUBKE1rSVheaCwjo1YJ8J4OTQ8jMzxcYY/dGrjOQopwioMRrrnHpbF9r6zcygmziXR8KrdyJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711342917; c=relaxed/simple;
	bh=FOoNFEssanoBU0gNpEbbD8hfw+we7FOTsxh0gEzSM0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BfqAZPe0xwNVvyMP76fT3fsnVVi13hgBeAW5uiNZaJLD0zaXat/OKPfXxVvX93NGiyHxtjQvOQtN2NKBe/FuYdwzuibwQ6wcxgEjmwPRVwUXvFA+XNwpsk8R5G8F24fL5UUogZoRleqvUOrzaiMTYNxe6nP2bw6uaMqzwVg+uj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6Q4uah3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903F5C433F1;
	Mon, 25 Mar 2024 05:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711342916;
	bh=FOoNFEssanoBU0gNpEbbD8hfw+we7FOTsxh0gEzSM0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y6Q4uah3FAUzGYAjj0/rcmr9IYF07yUP4Psj9++ZeWGKq/wGH9ADhuw1gHFAjNUSh
	 BA4raFfj/ogLV9K8NFboHHxsx+vf/J7ax/aehgFBDQijCzDpZxG06Im1ASS6qcTMqT
	 junSSWJ/8WPCUC/1uLArM4iuqCMXjG9jHUY/uPx3YHaCu7EL9BXcuA4FIdo7+KhC9x
	 6ABAmbjGQfB7XfMVj9xN5ZwB4tG43sNVMTb2LT577egQLapYE1/r5kn2YYcc7JdeHt
	 sx6ipU/pu2dee4klk0bOmtl6ogGNa3xTgVR47ReIm33BBYxmGsfoFJQsN4+JqqYUOZ
	 +F6kQUlIRRyiA==
Date: Sun, 24 Mar 2024 22:01:55 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: xfs <linux-xfs@vger.kernel.org>
Cc: kernel test robot <lkp@intel.com>, Dave Chinner <dchinner@redhat.com>,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Chandan Babu R <chandanbabu@kernel.org>
Subject: Re: fs/xfs/libxfs/xfs_dir2.c:336:15-22: WARNING opportunity for
 kmemdup
Message-ID: <20240325050155.GC6414@frogsfrogsfrogs>
References: <202403232305.aLpp8AlJ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202403232305.aLpp8AlJ-lkp@intel.com>

On Sat, Mar 23, 2024 at 11:08:59PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   bfa8f18691ed2e978e4dd51190569c434f93e268
> commit: f078d4ea827607867d42fb3b2ef907caf86ce49d xfs: convert kmem_alloc() to kmalloc()
> date:   6 weeks ago
> config: x86_64-randconfig-103-20240323 (https://download.01.org/0day-ci/archive/20240323/202403232305.aLpp8AlJ-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202403232305.aLpp8AlJ-lkp@intel.com/
> 
> cocci warnings: (new ones prefixed by >>)
> >> fs/xfs/libxfs/xfs_dir2.c:336:15-22: WARNING opportunity for kmemdup

It occurred to me that this message isn't about a stray kmemdup that
could cause a WARN() message to get logged or anything like that; it's a
notice that we could collapse lines 336 and 340 into:

	args->value = kmemdup(name, len, GFP_NOFS | __GFP_RETRY_MAYFAIL);

Anyone want to tackle that?

There's a second one you could tackle too:
https://lore.kernel.org/oe-kbuild-all/202403210204.LPPBJMhf-lkp@intel.com/T/#u

--D

> vim +336 fs/xfs/libxfs/xfs_dir2.c
> 
>    319	
>    320	/*
>    321	 * If doing a CI lookup and case-insensitive match, dup actual name into
>    322	 * args.value. Return EEXIST for success (ie. name found) or an error.
>    323	 */
>    324	int
>    325	xfs_dir_cilookup_result(
>    326		struct xfs_da_args *args,
>    327		const unsigned char *name,
>    328		int		len)
>    329	{
>    330		if (args->cmpresult == XFS_CMP_DIFFERENT)
>    331			return -ENOENT;
>    332		if (args->cmpresult != XFS_CMP_CASE ||
>    333						!(args->op_flags & XFS_DA_OP_CILOOKUP))
>    334			return -EEXIST;
>    335	
>  > 336		args->value = kmalloc(len, GFP_NOFS | __GFP_RETRY_MAYFAIL);
>    337		if (!args->value)
>    338			return -ENOMEM;
>    339	
>    340		memcpy(args->value, name, len);
>    341		args->valuelen = len;
>    342		return -EEXIST;
>    343	}
>    344	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

