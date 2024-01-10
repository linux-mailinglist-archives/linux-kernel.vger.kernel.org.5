Return-Path: <linux-kernel+bounces-21771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59926829413
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 08:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11B13287F6B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 07:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F72C39FE4;
	Wed, 10 Jan 2024 07:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dLAYZxRC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB3C39FC7
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 07:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704870828; x=1736406828;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NsN9wWwDQykPsPTX7UdOiEMGNy+84IBEJgsSgPx+YLI=;
  b=dLAYZxRCDRiSzOQegugAp9EHUOny+Mal2YKtqMQ8u9yqikjdMk3zRGo1
   YvmfRhEf/0xV1kKUK1zrUqx+JRya2ZbK+J0MNJXnZoEepj/et1Rvc75/7
   G5KbJ+9Pu3g/mmMpf6VQYbnGmqobc4piV2QDNhN59HlVHvApayrfqzaue
   isdWRVuxgymFiwzfr+K/IhEQoUNT/S058I5wz6HIgBWviUBbRxwVQC+XM
   y71LFS2unSnj9a4f84C4ePVIoAZdGf5Xt2Pz9vAL1Ce7snSxO06edrGmC
   w/hA6XEzKfyeCD6X3dPhO4ZY8Y5IsXn3eeLpoA4ivySbUABSqTesujD1j
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5791555"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="5791555"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 23:13:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="758272377"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="758272377"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 09 Jan 2024 23:13:46 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rNSmW-0006iz-0k;
	Wed, 10 Jan 2024 07:13:44 +0000
Date: Wed, 10 Jan 2024 15:06:52 +0800
From: kernel test robot <lkp@intel.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: fs/bcachefs/sb-members.c:422:30: sparse: sparse: incorrect type in
 assignment (different base types)
Message-ID: <202401101519.MjA7RH59-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ab27740f76654ed58dd32ac0ba0031c18a6dea3b
commit: 94119eeb02d114aa1f78dcfaabdca50b9b626790 bcachefs: Add IO error counts to bch_member
date:   10 weeks ago
config: i386-randconfig-061-20240106 (https://download.01.org/0day-ci/archive/20240110/202401101519.MjA7RH59-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240110/202401101519.MjA7RH59-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401101519.MjA7RH59-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   fs/bcachefs/sb-members.c: note: in included file:
   fs/bcachefs/bcachefs.h:958:9: sparse: sparse: array of flexible structures
>> fs/bcachefs/sb-members.c:422:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le64 [usertype] errors_reset_time @@     got signed long long @@
   fs/bcachefs/sb-members.c:422:30: sparse:     expected restricted __le64 [usertype] errors_reset_time
   fs/bcachefs/sb-members.c:422:30: sparse:     got signed long long

vim +422 fs/bcachefs/sb-members.c

   412	
   413	void bch2_dev_errors_reset(struct bch_dev *ca)
   414	{
   415		struct bch_fs *c = ca->fs;
   416		struct bch_member *m;
   417	
   418		mutex_lock(&c->sb_lock);
   419		m = bch2_members_v2_get_mut(c->disk_sb.sb, ca->dev_idx);
   420		for (unsigned i = 0; i < ARRAY_SIZE(m->errors_at_reset); i++)
   421			m->errors_at_reset[i] = cpu_to_le64(atomic64_read(&ca->errors[i]));
 > 422		m->errors_reset_time = ktime_get_real_seconds();

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

