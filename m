Return-Path: <linux-kernel+bounces-38559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E3383C18F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57AD81C23467
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DE436B10;
	Thu, 25 Jan 2024 12:02:01 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FE12376C;
	Thu, 25 Jan 2024 12:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184120; cv=none; b=ZArO2ndRr9C8gft390/xyhqpJBvciSk4+UlHZvQu1lSezCzJ3Iw+EZCR0CU6ryOTiokUvHjLMtgtQ7wmUoCoeeTtPHi7yP2k4Q3rlJQtxAa+9B6oB/r5fiYhoJynyRfW0Ix78shdXSXAl9J7xuZytlY70Y0FN+Db4petlmmJPyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184120; c=relaxed/simple;
	bh=ZJyQ49dn19YCAQfeqrxyNGDQUbbqLM5Tz68rRHu/H50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMIa6TKZBccKt7WQv5AqnGcFWrYApOe0VswNLcDnVRVphnHC92R7wv8vWeLzE4+OWunzm47Q9l9WWr0eTJkfYkWPON7DE7mKGBBLhS7s9A4URYhXbNJ+exisOtZIw6ihtwzrpIPxZmgq9n1DUBJG+zkmXbsxIoajUEeaZqYrDBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D066C433C7;
	Thu, 25 Jan 2024 12:01:59 +0000 (UTC)
Date: Thu, 25 Jan 2024 12:01:56 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Waiman Long <longman@redhat.com>, linux-mm@kvack.org
Subject: Re: [linus:master] [kmemleak]  39042079a0:
 kernel-selftests.kvm.memslot_perf_test.fail
Message-ID: <ZbJNtFO_N4pVuEUK@arm.com>
References: <202401251429.d3dea02b-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202401251429.d3dea02b-oliver.sang@intel.com>

On Thu, Jan 25, 2024 at 03:34:37PM +0800, kernel test robot wrote:
> kernel test robot noticed "kernel-selftests.kvm.memslot_perf_test.fail" on:
> 
> commit: 39042079a0c241d09fa6fc3bb67c2ddf60011d0f ("kmemleak: avoid RCU stalls when freeing metadata for per-CPU pointers")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
[...]
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240125/202401251429.d3dea02b-oliver.sang@intel.com
[...]
> # Testing RW performance with 1 runs, 5 seconds each
> #
> not ok 71 selftests: kvm: memslot_perf_test # TIMEOUT 120 seconds

I'm not sure how this relates to kmemleak, especially the commit above.
It might as well be that the above kmemleak commit increases the system
load and you trip over the timeout above. Is it still reproducible with
a larger timeout (unfortunately I don't have the hardware to try to
reproduce the problem)?

I can see a lockdep warning in the dmesg but that doesn't look related
to kmemleak.

-- 
Catalin

