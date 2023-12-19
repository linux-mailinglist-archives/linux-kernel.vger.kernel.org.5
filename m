Return-Path: <linux-kernel+bounces-5395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8191818A33
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97D2C28CC73
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3331C29D;
	Tue, 19 Dec 2023 14:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kxKyryyK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886F21C68A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 14:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702996735; x=1734532735;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wMPIkHALWhrTAxhwy+6v4FKmK24k0lzLDqtnejSmCiY=;
  b=kxKyryyKm0rvbIPeSwi4DSoZBLngNeY0UFTrdNAYQ4zPduqjqnokToAY
   NYjVqSOFgN2B5OgoNTmFC092hN/T+rFh+FBKRiVe5SMhk3j3xi2TxVIMm
   FUmjwELYtigAnZhdPwlpIeIooDlMrMz2UMqK2h1JEx+maZyku0cs6AY9F
   H0R9Thr9vCUgthrboq6rVh/pnD49JYphU1J6aOeyYEjoeshRJtQ8b5CmB
   iBQqiw6Vg/uWk8qFzpeJWQ4obEcnK71M0RVP0DLi53Yp1E7/Z/KsSXhxi
   NPDPIre+T8NtRIUSPkJA1QJ9S2TrMCxhsOEjaZiuVVtFv+WSj6+/2ExUV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="380650299"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="380650299"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 06:38:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="17898076"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 19 Dec 2023 06:38:54 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rFbFD-0005T0-24;
	Tue, 19 Dec 2023 14:38:51 +0000
Date: Tue, 19 Dec 2023 22:38:28 +0800
From: kernel test robot <lkp@intel.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: fs/bcachefs/dirent.c:106:5-8: Unneeded variable: "ret". Return "  0"
 on line 144
Message-ID: <202312192216.GSjjPurf-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2cf4f94d8e8646803f8fb0facf134b0cd7fb691a
commit: b65db750e2bb9252321fd54c284edd73c1595a09 bcachefs: Enumerate fsck errors
date:   7 weeks ago
config: x86_64-randconfig-102-20231219 (https://download.01.org/0day-ci/archive/20231219/202312192216.GSjjPurf-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312192216.GSjjPurf-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> fs/bcachefs/dirent.c:106:5-8: Unneeded variable: "ret". Return "  0" on line 144

vim +106 fs/bcachefs/dirent.c

    99	
   100	int bch2_dirent_invalid(struct bch_fs *c, struct bkey_s_c k,
   101				enum bkey_invalid_flags flags,
   102				struct printbuf *err)
   103	{
   104		struct bkey_s_c_dirent d = bkey_s_c_to_dirent(k);
   105		struct qstr d_name = bch2_dirent_get_name(d);
 > 106		int ret = 0;
   107	
   108		bkey_fsck_err_on(!d_name.len, c, err,
   109				 dirent_empty_name,
   110				 "empty name");
   111	
   112		bkey_fsck_err_on(bkey_val_u64s(k.k) > dirent_val_u64s(d_name.len), c, err,
   113				 dirent_val_too_big,
   114				 "value too big (%zu > %u)",
   115				 bkey_val_u64s(k.k), dirent_val_u64s(d_name.len));
   116	
   117		/*
   118		 * Check new keys don't exceed the max length
   119		 * (older keys may be larger.)
   120		 */
   121		bkey_fsck_err_on((flags & BKEY_INVALID_COMMIT) && d_name.len > BCH_NAME_MAX, c, err,
   122				 dirent_name_too_long,
   123				 "dirent name too big (%u > %u)",
   124				 d_name.len, BCH_NAME_MAX);
   125	
   126		bkey_fsck_err_on(d_name.len != strnlen(d_name.name, d_name.len), c, err,
   127				 dirent_name_embedded_nul,
   128				 "dirent has stray data after name's NUL");
   129	
   130		bkey_fsck_err_on((d_name.len == 1 && !memcmp(d_name.name, ".", 1)) ||
   131				 (d_name.len == 2 && !memcmp(d_name.name, "..", 2)), c, err,
   132				 dirent_name_dot_or_dotdot,
   133				 "invalid name");
   134	
   135		bkey_fsck_err_on(memchr(d_name.name, '/', d_name.len), c, err,
   136				 dirent_name_has_slash,
   137				 "name with /");
   138	
   139		bkey_fsck_err_on(d.v->d_type != DT_SUBVOL &&
   140				 le64_to_cpu(d.v->d_inum) == d.k->p.inode, c, err,
   141				 dirent_to_itself,
   142				 "dirent points to own directory");
   143	fsck_err:
 > 144		return ret;
   145	}
   146	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

