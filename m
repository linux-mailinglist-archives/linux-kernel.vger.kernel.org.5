Return-Path: <linux-kernel+bounces-125698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69280892ACF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 12:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A8781C210A3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 11:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE34381B1;
	Sat, 30 Mar 2024 11:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FWMHsTVH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B112CCA3;
	Sat, 30 Mar 2024 11:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711797997; cv=none; b=PUBkQ27gGc2aGk8Zzd3czdf0V6Z7eAsneCCXKL3c3xemURSreGB1z+kRWaEYxMkLNq/RDCYz5Y0gK4vvrVvwGU5UN0wgK8qaojpgw4sonwlfGF6yflQ3lvneb1Njhweri6Libj2ZWbcKn55V7rAMlqG8NFAIa99oeZ7wD+1PJI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711797997; c=relaxed/simple;
	bh=Uuar7vsbKm5w+9KCxDbjk3gAMAqKDjuJHWplhv29qXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xkj5phfoeaSkUIc2YPi6siLuKQ7Zm1cs7iQpbpxaVGGajB9AxX7GBiFQhagItppygAS7OAE6on/CIcjCIiAL1hRECmLnMXwrVg69qh67CwNzukMMTN0SOCbMNWJ8FetHILIDreU0GWwQ9f0qYhMrp/HGsVHrT8n85EJcWji8JYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FWMHsTVH; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711797996; x=1743333996;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Uuar7vsbKm5w+9KCxDbjk3gAMAqKDjuJHWplhv29qXw=;
  b=FWMHsTVHj63smiHTVTzR3ag8bTxbgbACbWXXQg+pVoiwu4xZUQBIs18/
   V0xFpFNmYIZB1C1aPNrpIr57WB84tZRhoBT4HrI1HbnTMIMak1xGFG2Lq
   z0hmJ/6TlFxzIL2y6KEhAZJDMqG3sShdkXpZFjYrKsh0YrDdYuGkHYVcW
   yrTu0rOCXjjJ7zKnRNbdnTV41JBgOoVg5gKDIMdNacYkw6IQ+nQviQVnL
   1r0QYzI3XWS7gEQRkiwbLB4uv20QJeumYoOE/fsMGhJkfU72t0c8zqm2U
   QnYqQqQ77Vqa0yxOVDUNZPK5Rn3Cx63k6Msl0X0ZMxL0fvnNVoNXwk2ok
   w==;
X-CSE-ConnectionGUID: oB1hdDnZTa2vMWmYDbu7Yw==
X-CSE-MsgGUID: M5g1nIT4TUWXDXNFjMqthA==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="29456970"
X-IronPort-AV: E=Sophos;i="6.07,166,1708416000"; 
   d="scan'208";a="29456970"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2024 04:26:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,166,1708416000"; 
   d="scan'208";a="48409144"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 30 Mar 2024 04:26:28 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rqWqw-0004CM-1b;
	Sat, 30 Mar 2024 11:26:26 +0000
Date: Sat, 30 Mar 2024 19:26:00 +0800
From: kernel test robot <lkp@intel.com>
To: Fan Wu <wufan@linux.microsoft.com>, corbet@lwn.net, zohar@linux.ibm.com,
	jmorris@namei.org, serge@hallyn.com, tytso@mit.edu,
	ebiggers@kernel.org, axboe@kernel.dk, agk@redhat.com,
	snitzer@kernel.org, eparis@redhat.com, paul@paul-moore.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, fsverity@lists.linux.dev,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	audit@vger.kernel.org, linux-kernel@vger.kernel.org,
	Deven Bowers <deven.desai@linux.microsoft.com>,
	Fan Wu <wufan@linux.microsoft.com>
Subject: Re: [PATCH v16 11/20] block|security: add LSM blob to block_device
Message-ID: <202403301936.l8vO4jha-lkp@intel.com>
References: <1711657047-10526-12-git-send-email-wufan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1711657047-10526-12-git-send-email-wufan@linux.microsoft.com>

Hi Fan,

kernel test robot noticed the following build errors:

[auto build test ERROR on device-mapper-dm/for-next]
[also build test ERROR on axboe-block/for-next lwn/docs-next linus/master v6.9-rc1 next-20240328]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Fan-Wu/security-add-ipe-lsm/20240329-042339
base:   https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git for-next
patch link:    https://lore.kernel.org/r/1711657047-10526-12-git-send-email-wufan%40linux.microsoft.com
patch subject: [PATCH v16 11/20] block|security: add LSM blob to block_device
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20240330/202403301936.l8vO4jha-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240330/202403301936.l8vO4jha-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403301936.l8vO4jha-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/nfs/blocklayout/blocklayout.c:41:
   In file included from fs/nfs/blocklayout/../pnfs.h:34:
   In file included from include/linux/nfs_fs.h:32:
   In file included from include/linux/sunrpc/clnt.h:29:
   In file included from include/net/ipv6.h:12:
   In file included from include/linux/ipv6.h:101:
   In file included from include/linux/tcp.h:19:
   In file included from include/net/sock.h:46:
   In file included from include/linux/netdevice.h:45:
   In file included from include/uapi/linux/neighbour.h:6:
   In file included from include/linux/netlink.h:9:
   In file included from include/net/scm.h:9:
>> include/linux/security.h:1506:36: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
    1506 |                                              enum lsm_integrity_type, type,
         |                                                                       ^
         |                                                                       int
   include/linux/security.h:1506:34: warning: omitting the parameter name in a function definition is a C2x extension [-Wc2x-extensions]
    1506 |                                              enum lsm_integrity_type, type,
         |                                                                     ^
   fs/nfs/blocklayout/blocklayout.c:384:9: warning: variable 'count' set but not used [-Wunused-but-set-variable]
     384 |         size_t count = header->args.count;
         |                ^
   2 warnings and 1 error generated.
--
   In file included from fs/nfs/blocklayout/dev.c:8:
   In file included from include/linux/nfs_fs.h:32:
   In file included from include/linux/sunrpc/clnt.h:29:
   In file included from include/net/ipv6.h:12:
   In file included from include/linux/ipv6.h:101:
   In file included from include/linux/tcp.h:19:
   In file included from include/net/sock.h:46:
   In file included from include/linux/netdevice.h:45:
   In file included from include/uapi/linux/neighbour.h:6:
   In file included from include/linux/netlink.h:9:
   In file included from include/net/scm.h:9:
>> include/linux/security.h:1506:36: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
    1506 |                                              enum lsm_integrity_type, type,
         |                                                                       ^
         |                                                                       int
   include/linux/security.h:1506:34: warning: omitting the parameter name in a function definition is a C2x extension [-Wc2x-extensions]
    1506 |                                              enum lsm_integrity_type, type,
         |                                                                     ^
   1 warning and 1 error generated.


vim +/int +1506 include/linux/security.h

  1504	
  1505	static inline int security_bdev_setintegrity(struct block_device *bdev,
> 1506						     enum lsm_integrity_type, type,
  1507						     const void *value, size_t size)
  1508	{
  1509		return 0;
  1510	}
  1511	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

