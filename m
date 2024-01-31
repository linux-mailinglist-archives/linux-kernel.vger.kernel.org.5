Return-Path: <linux-kernel+bounces-47002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE2C8447C9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 284FB1F237FF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CED36AF9;
	Wed, 31 Jan 2024 19:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lB2qbcdc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855E22134F;
	Wed, 31 Jan 2024 19:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706728074; cv=none; b=dNA2JtKB8jR3OuBtYsACTOaHZY/2mGvmZE4C+fLTJs04Ui48m4UdYw4Y0b3GgHFp/2mFyLQzAZwoT52yObLU0e365AUUmH7I06XxNX3gC7FLhfEhOTgvhgllpHXc8yDkXJyH65gm/WllFDyykH4kFuEYidNxirnrvR0eogbrBIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706728074; c=relaxed/simple;
	bh=I5iZ2/I8gzIg+8tRfuEXRpjnuxIQ5+cTB3h6UO2d6VQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btOWits9msV0dpIg4NPTeqCEfYE9jn1uasyQdQNwZKPrTL7oAnNQvZkjGeZ1+Rtks/rNUnSWceEoxR8UNJ6Spbqu82Aczw7rLL/ZaT8HYBqgByYK36dK6EGuTmxYC+Fe1Lgy7Wlue4y4AdbjBZulGElKwRu2zPPImrs6NEXv5ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lB2qbcdc; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706728073; x=1738264073;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I5iZ2/I8gzIg+8tRfuEXRpjnuxIQ5+cTB3h6UO2d6VQ=;
  b=lB2qbcdcfIHgqNPNoGW/8PFsUyijQxAGHX4o7lOvSvYXyLLebLptdeij
   2hF2qGfJFnDKrI5P0pwmodqVyRPeCexLiyZALrfkZTS5BBkKIup9xkz0y
   vU5acM46/0HvmYJC5pWDefBjbQ56HGQFh5swmzDtesvijco4z2+uOJjrL
   Cd05lYAP0ufV0JGz4AcWhTnRRWFoAty+ib9GkXp8Ro8EQrCe3qfj1tr1w
   GGZyfg/DWvRdYkfzRmkoDt9D18Tnaarq1r1nGlvD/Il5EarwEDeAGlMXU
   bDcpFfFuBPm6vxgOY1WAo2eSO9btkmt48zRil9ys59s9d77SzvNs6JBQ/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="17081541"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="17081541"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 11:07:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="878873430"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="878873430"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Jan 2024 11:07:48 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rVFw1-0001vE-35;
	Wed, 31 Jan 2024 19:07:45 +0000
Date: Thu, 1 Feb 2024 03:06:55 +0800
From: kernel test robot <lkp@intel.com>
To: Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	zohar@linux.ibm.com, roberto.sassu@huawei.com, amir73il@gmail.com,
	miklos@szeredi.hu, Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH 1/5] security: allow finer granularity in permitting
 copy-up of security xattrs
Message-ID: <202402010225.BXp3LrvU-lkp@intel.com>
References: <20240130214620.3155380-2-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130214620.3155380-2-stefanb@linux.ibm.com>

Hi Stefan,

kernel test robot noticed the following build errors:

[auto build test ERROR on zohar-integrity/next-integrity]
[also build test ERROR on pcmoore-selinux/next linus/master v6.8-rc2 next-20240131]
[cannot apply to mszeredi-vfs/overlayfs-next mszeredi-vfs/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stefan-Berger/security-allow-finer-granularity-in-permitting-copy-up-of-security-xattrs/20240131-054854
base:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity
patch link:    https://lore.kernel.org/r/20240130214620.3155380-2-stefanb%40linux.ibm.com
patch subject: [PATCH 1/5] security: allow finer granularity in permitting copy-up of security xattrs
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20240201/202402010225.BXp3LrvU-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240201/202402010225.BXp3LrvU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402010225.BXp3LrvU-lkp@intel.com/

All errors (new ones prefixed by >>):

   security/security.c: In function 'security_inode_copy_up_xattr':
>> security/security.c:2627:40: error: passing argument 1 of 'evm_inode_copy_up_xattr' from incompatible pointer type [-Werror=incompatible-pointer-types]
    2627 |         return evm_inode_copy_up_xattr(src, name);
         |                                        ^~~
         |                                        |
         |                                        struct dentry *
   In file included from security/security.c:24:
   include/linux/evm.h:121:56: note: expected 'const char *' but argument is of type 'struct dentry *'
     121 | static inline int  evm_inode_copy_up_xattr(const char *name)
         |                                            ~~~~~~~~~~~~^~~~
>> security/security.c:2627:16: error: too many arguments to function 'evm_inode_copy_up_xattr'
    2627 |         return evm_inode_copy_up_xattr(src, name);
         |                ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from security/security.c:24:
   include/linux/evm.h:121:20: note: declared here
     121 | static inline int  evm_inode_copy_up_xattr(const char *name)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/evm_inode_copy_up_xattr +2627 security/security.c

  2596	
  2597	/**
  2598	 * security_inode_copy_up_xattr() - Filter xattrs in an overlayfs copy-up op
  2599	 * @src: union dentry of copy-up file
  2600	 * @name: xattr name
  2601	 *
  2602	 * Filter the xattrs being copied up when a unioned file is copied up from a
  2603	 * lower layer to the union/overlay layer.   The caller is responsible for
  2604	 * reading and writing the xattrs, this hook is merely a filter.
  2605	 *
  2606	 * Return: Returns 0 to accept the xattr, 1 to discard the xattr, -EOPNOTSUPP
  2607	 *         if the security module does not know about attribute, or a negative
  2608	 *         error code to abort the copy up.
  2609	 */
  2610	int security_inode_copy_up_xattr(struct dentry *src, const char *name)
  2611	{
  2612		struct security_hook_list *hp;
  2613		int rc;
  2614	
  2615		/*
  2616		 * The implementation can return 0 (accept the xattr), 1 (discard the
  2617		 * xattr), -EOPNOTSUPP if it does not know anything about the xattr or
  2618		 * any other error code in case of an error.
  2619		 */
  2620		hlist_for_each_entry(hp,
  2621				     &security_hook_heads.inode_copy_up_xattr, list) {
  2622			rc = hp->hook.inode_copy_up_xattr(src, name);
  2623			if (rc != LSM_RET_DEFAULT(inode_copy_up_xattr))
  2624				return rc;
  2625		}
  2626	
> 2627		return evm_inode_copy_up_xattr(src, name);
  2628	}
  2629	EXPORT_SYMBOL(security_inode_copy_up_xattr);
  2630	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

