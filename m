Return-Path: <linux-kernel+bounces-6362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E118197B0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 05:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DC71280054
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D70DBE6B;
	Wed, 20 Dec 2023 04:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DUq+JeVl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1521321340
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 04:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703046071; x=1734582071;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qjJHemtFHezoSW5kjd/qKBAUPyvisjYGT44wNPPEZFo=;
  b=DUq+JeVlJQJIGKDikJeeSnqytF+z1pwbNg4B+4jfXZ/XIOF39NumZwWl
   zUZsfotkuiHyFVZavGnnliw8deOq8ErrhLU9saatEGaNE+a0fGkQE/kvy
   RWTfbTd3ff3FSbGp8eiltJfc85HrSmsRWePZwrPAhzLi28RnCVQfUeXRc
   J+vttvXb4srhWS1z6VpulfpbofXNefj2t7tx4CVCnA2J2tJa2xfdPLDxG
   /xP3DgEbY5FSuYjDn+DqYmFO88rKqNWVf7+uVOBV5pma/VS31Szu0rJ7Q
   xQ3fv+pwQ0U8sjASrp7EFSoFDyYJ2r3ABl5kQpWY4VcUriLZuEMjaoG7J
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="380750663"
X-IronPort-AV: E=Sophos;i="6.04,290,1695711600"; 
   d="scan'208";a="380750663"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 20:21:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,290,1695711600"; 
   d="scan'208";a="10620459"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 19 Dec 2023 20:21:09 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rFo4w-0006M3-1U;
	Wed, 20 Dec 2023 04:21:06 +0000
Date: Wed, 20 Dec 2023 12:20:29 +0800
From: kernel test robot <lkp@intel.com>
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: sound/core/pcm_native.c:2982:13: sparse: sparse: cast from
 restricted snd_pcm_state_t
Message-ID: <202312201216.TX9GAOG6-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   55cb5f43689d7a9ea5bf35ef050f12334f197347
commit: 46b770f720bdd8a7de1c04a1cab5d4e9e21d6666 ALSA: uapi: Fix sparse warning
date:   3 years, 11 months ago
config: alpha-randconfig-r123-20231116 (https://download.01.org/0day-ci/archive/20231220/202312201216.TX9GAOG6-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231220/202312201216.TX9GAOG6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312201216.TX9GAOG6-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   sound/core/pcm_native.c:558:51: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted snd_pcm_state_t [usertype] state @@     got int state @@
   sound/core/pcm_native.c:558:51: sparse:     expected restricted snd_pcm_state_t [usertype] state
   sound/core/pcm_native.c:558:51: sparse:     got int state
   sound/core/pcm_native.c:748:38: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int state @@     got restricted snd_pcm_state_t [usertype] @@
   sound/core/pcm_native.c:748:38: sparse:     expected int state
   sound/core/pcm_native.c:748:38: sparse:     got restricted snd_pcm_state_t [usertype]
   sound/core/pcm_native.c:760:38: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int state @@     got restricted snd_pcm_state_t [usertype] @@
   sound/core/pcm_native.c:760:38: sparse:     expected int state
   sound/core/pcm_native.c:760:38: sparse:     got restricted snd_pcm_state_t [usertype]
   sound/core/pcm_native.c:814:38: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int state @@     got restricted snd_pcm_state_t [usertype] @@
   sound/core/pcm_native.c:814:38: sparse:     expected int state
   sound/core/pcm_native.c:814:38: sparse:     got restricted snd_pcm_state_t [usertype]
   sound/core/pcm_native.c:1022:34: sparse: sparse: incorrect type in initializer (different base types) @@     expected signed int [usertype] state @@     got restricted snd_pcm_state_t [addressable] [assigned] [usertype] state @@
   sound/core/pcm_native.c:1022:34: sparse:     expected signed int [usertype] state
   sound/core/pcm_native.c:1022:34: sparse:     got restricted snd_pcm_state_t [addressable] [assigned] [usertype] state
   sound/core/pcm_native.c:1033:44: sparse: sparse: incorrect type in initializer (different base types) @@     expected signed int [usertype] suspended_state @@     got restricted snd_pcm_state_t [addressable] [assigned] [usertype] suspended_state @@
   sound/core/pcm_native.c:1033:44: sparse:     expected signed int [usertype] suspended_state
   sound/core/pcm_native.c:1033:44: sparse:     got restricted snd_pcm_state_t [addressable] [assigned] [usertype] suspended_state
   sound/core/pcm_native.c:1335:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted snd_pcm_state_t [usertype] state @@     got int state @@
   sound/core/pcm_native.c:1335:32: sparse:     expected restricted snd_pcm_state_t [usertype] state
   sound/core/pcm_native.c:1335:32: sparse:     got int state
   sound/core/pcm_native.c:1359:31: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected int state @@     got restricted snd_pcm_state_t [usertype] @@
   sound/core/pcm_native.c:1359:31: sparse:     expected int state
   sound/core/pcm_native.c:1359:31: sparse:     got restricted snd_pcm_state_t [usertype]
   sound/core/pcm_native.c:1366:40: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected int state @@     got restricted snd_pcm_state_t [usertype] @@
   sound/core/pcm_native.c:1366:40: sparse:     expected int state
   sound/core/pcm_native.c:1366:40: sparse:     got restricted snd_pcm_state_t [usertype]
   sound/core/pcm_native.c:1392:28: sparse: sparse: restricted snd_pcm_state_t degrades to integer
   sound/core/pcm_native.c:1394:40: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted snd_pcm_state_t [usertype] state @@     got int state @@
   sound/core/pcm_native.c:1394:40: sparse:     expected restricted snd_pcm_state_t [usertype] state
   sound/core/pcm_native.c:1394:40: sparse:     got int state
   sound/core/pcm_native.c:1419:64: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected int state @@     got restricted snd_pcm_state_t [usertype] state @@
   sound/core/pcm_native.c:1419:64: sparse:     expected int state
   sound/core/pcm_native.c:1419:64: sparse:     got restricted snd_pcm_state_t [usertype] state
   sound/core/pcm_native.c:1435:38: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected int state @@     got restricted snd_pcm_state_t [usertype] @@
   sound/core/pcm_native.c:1435:38: sparse:     expected int state
   sound/core/pcm_native.c:1435:38: sparse:     got restricted snd_pcm_state_t [usertype]
   sound/core/pcm_native.c:1806:38: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int state @@     got restricted snd_pcm_state_t [usertype] @@
   sound/core/pcm_native.c:1806:38: sparse:     expected int state
   sound/core/pcm_native.c:1806:38: sparse:     got restricted snd_pcm_state_t [usertype]
   sound/core/pcm_native.c:1872:61: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int state @@     got restricted snd_pcm_state_t [usertype] @@
   sound/core/pcm_native.c:1872:61: sparse:     expected int state
   sound/core/pcm_native.c:1872:61: sparse:     got restricted snd_pcm_state_t [usertype]
   sound/core/pcm_native.c:1873:63: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int state @@     got restricted snd_pcm_state_t [usertype] @@
   sound/core/pcm_native.c:1873:63: sparse:     expected int state
   sound/core/pcm_native.c:1873:63: sparse:     got restricted snd_pcm_state_t [usertype]
   sound/core/pcm_native.c:1890:76: sparse: sparse: incorrect type in initializer (different base types) @@     expected int new_state @@     got restricted snd_pcm_state_t @@
   sound/core/pcm_native.c:1890:76: sparse:     expected int new_state
   sound/core/pcm_native.c:1890:76: sparse:     got restricted snd_pcm_state_t
   sound/core/pcm_native.c:2237:26: sparse: sparse: restricted snd_pcm_format_t degrades to integer
   sound/core/pcm_native.c:2241:54: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted snd_pcm_format_t [usertype] format @@     got unsigned int [assigned] k @@
   sound/core/pcm_native.c:2241:54: sparse:     expected restricted snd_pcm_format_t [usertype] format
   sound/core/pcm_native.c:2241:54: sparse:     got unsigned int [assigned] k
   sound/core/pcm_native.c:2259:26: sparse: sparse: restricted snd_pcm_format_t degrades to integer
   sound/core/pcm_native.c:2263:54: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted snd_pcm_format_t [usertype] format @@     got unsigned int [assigned] k @@
   sound/core/pcm_native.c:2263:54: sparse:     expected restricted snd_pcm_format_t [usertype] format
   sound/core/pcm_native.c:2263:54: sparse:     got unsigned int [assigned] k
   sound/core/pcm_native.c:2443:30: sparse: sparse: restricted snd_pcm_access_t degrades to integer
   sound/core/pcm_native.c:2445:30: sparse: sparse: restricted snd_pcm_access_t degrades to integer
   sound/core/pcm_native.c:2448:38: sparse: sparse: restricted snd_pcm_access_t degrades to integer
   sound/core/pcm_native.c:2450:38: sparse: sparse: restricted snd_pcm_access_t degrades to integer
   sound/core/pcm_native.c:2452:38: sparse: sparse: restricted snd_pcm_access_t degrades to integer
   sound/core/pcm_native.c:2462:86: sparse: sparse: restricted snd_pcm_subformat_t degrades to integer
>> sound/core/pcm_native.c:2982:13: sparse: sparse: cast from restricted snd_pcm_state_t
>> sound/core/pcm_native.c:2982:13: sparse: sparse: cast from restricted snd_pcm_state_t
>> sound/core/pcm_native.c:2982:13: sparse: sparse: cast from restricted snd_pcm_state_t
>> sound/core/pcm_native.c:2982:13: sparse: sparse: cast from restricted snd_pcm_state_t
   sound/core/pcm_native.c:2986:13: sparse: sparse: cast from restricted snd_pcm_state_t
   sound/core/pcm_native.c:2986:13: sparse: sparse: cast from restricted snd_pcm_state_t
   sound/core/pcm_native.c:2986:13: sparse: sparse: cast from restricted snd_pcm_state_t
   sound/core/pcm_native.c:2986:13: sparse: sparse: cast from restricted snd_pcm_state_t
   sound/core/pcm_native.c:95:1: sparse: sparse: context imbalance in 'snd_pcm_group_lock' - different lock contexts for basic block
   sound/core/pcm_native.c:96:1: sparse: sparse: context imbalance in 'snd_pcm_group_unlock' - unexpected unlock
   sound/core/pcm_native.c:97:1: sparse: sparse: context imbalance in 'snd_pcm_group_lock_irq' - different lock contexts for basic block
   sound/core/pcm_native.c:98:1: sparse: sparse: context imbalance in 'snd_pcm_group_unlock_irq' - unexpected unlock
   sound/core/pcm_native.c:161:9: sparse: sparse: context imbalance in '_snd_pcm_stream_lock_irqsave' - different lock contexts for basic block
   sound/core/pcm_native.c:178:39: sparse: sparse: context imbalance in 'snd_pcm_stream_unlock_irqrestore' - unexpected unlock
   sound/core/pcm_native.c:1157:52: sparse: sparse: context imbalance in 'snd_pcm_action_group' - unexpected unlock
   sound/core/pcm_native.c:1244:9: sparse: sparse: context imbalance in 'snd_pcm_stream_group_ref' - different lock contexts for basic block

vim +2982 sound/core/pcm_native.c

09d94175dbeac1 Arnd Bergmann 2018-04-24  2936  
09d94175dbeac1 Arnd Bergmann 2018-04-24  2937  static int snd_pcm_ioctl_sync_ptr_compat(struct snd_pcm_substream *substream,
09d94175dbeac1 Arnd Bergmann 2018-04-24  2938  					 struct snd_pcm_sync_ptr32 __user *src)
09d94175dbeac1 Arnd Bergmann 2018-04-24  2939  {
09d94175dbeac1 Arnd Bergmann 2018-04-24  2940  	struct snd_pcm_runtime *runtime = substream->runtime;
09d94175dbeac1 Arnd Bergmann 2018-04-24  2941  	volatile struct snd_pcm_mmap_status *status;
09d94175dbeac1 Arnd Bergmann 2018-04-24  2942  	volatile struct snd_pcm_mmap_control *control;
09d94175dbeac1 Arnd Bergmann 2018-04-24  2943  	u32 sflags;
09d94175dbeac1 Arnd Bergmann 2018-04-24  2944  	struct snd_pcm_mmap_control scontrol;
09d94175dbeac1 Arnd Bergmann 2018-04-24  2945  	struct snd_pcm_mmap_status sstatus;
09d94175dbeac1 Arnd Bergmann 2018-04-24  2946  	snd_pcm_uframes_t boundary;
09d94175dbeac1 Arnd Bergmann 2018-04-24  2947  	int err;
09d94175dbeac1 Arnd Bergmann 2018-04-24  2948  
09d94175dbeac1 Arnd Bergmann 2018-04-24  2949  	if (snd_BUG_ON(!runtime))
09d94175dbeac1 Arnd Bergmann 2018-04-24  2950  		return -EINVAL;
09d94175dbeac1 Arnd Bergmann 2018-04-24  2951  
09d94175dbeac1 Arnd Bergmann 2018-04-24  2952  	if (get_user(sflags, &src->flags) ||
09d94175dbeac1 Arnd Bergmann 2018-04-24  2953  	    get_user(scontrol.appl_ptr, &src->c.control.appl_ptr) ||
09d94175dbeac1 Arnd Bergmann 2018-04-24  2954  	    get_user(scontrol.avail_min, &src->c.control.avail_min))
09d94175dbeac1 Arnd Bergmann 2018-04-24  2955  		return -EFAULT;
09d94175dbeac1 Arnd Bergmann 2018-04-24  2956  	if (sflags & SNDRV_PCM_SYNC_PTR_HWSYNC) {
09d94175dbeac1 Arnd Bergmann 2018-04-24  2957  		err = snd_pcm_hwsync(substream);
09d94175dbeac1 Arnd Bergmann 2018-04-24  2958  		if (err < 0)
09d94175dbeac1 Arnd Bergmann 2018-04-24  2959  			return err;
09d94175dbeac1 Arnd Bergmann 2018-04-24  2960  	}
09d94175dbeac1 Arnd Bergmann 2018-04-24  2961  	status = runtime->status;
09d94175dbeac1 Arnd Bergmann 2018-04-24  2962  	control = runtime->control;
09d94175dbeac1 Arnd Bergmann 2018-04-24  2963  	boundary = recalculate_boundary(runtime);
09d94175dbeac1 Arnd Bergmann 2018-04-24  2964  	if (! boundary)
09d94175dbeac1 Arnd Bergmann 2018-04-24  2965  		boundary = 0x7fffffff;
09d94175dbeac1 Arnd Bergmann 2018-04-24  2966  	snd_pcm_stream_lock_irq(substream);
09d94175dbeac1 Arnd Bergmann 2018-04-24  2967  	/* FIXME: we should consider the boundary for the sync from app */
09d94175dbeac1 Arnd Bergmann 2018-04-24  2968  	if (!(sflags & SNDRV_PCM_SYNC_PTR_APPL))
09d94175dbeac1 Arnd Bergmann 2018-04-24  2969  		control->appl_ptr = scontrol.appl_ptr;
09d94175dbeac1 Arnd Bergmann 2018-04-24  2970  	else
09d94175dbeac1 Arnd Bergmann 2018-04-24  2971  		scontrol.appl_ptr = control->appl_ptr % boundary;
09d94175dbeac1 Arnd Bergmann 2018-04-24  2972  	if (!(sflags & SNDRV_PCM_SYNC_PTR_AVAIL_MIN))
09d94175dbeac1 Arnd Bergmann 2018-04-24  2973  		control->avail_min = scontrol.avail_min;
09d94175dbeac1 Arnd Bergmann 2018-04-24  2974  	else
09d94175dbeac1 Arnd Bergmann 2018-04-24  2975  		scontrol.avail_min = control->avail_min;
09d94175dbeac1 Arnd Bergmann 2018-04-24  2976  	sstatus.state = status->state;
09d94175dbeac1 Arnd Bergmann 2018-04-24  2977  	sstatus.hw_ptr = status->hw_ptr % boundary;
09d94175dbeac1 Arnd Bergmann 2018-04-24  2978  	sstatus.tstamp = status->tstamp;
09d94175dbeac1 Arnd Bergmann 2018-04-24  2979  	sstatus.suspended_state = status->suspended_state;
09d94175dbeac1 Arnd Bergmann 2018-04-24  2980  	sstatus.audio_tstamp = status->audio_tstamp;
09d94175dbeac1 Arnd Bergmann 2018-04-24  2981  	snd_pcm_stream_unlock_irq(substream);
09d94175dbeac1 Arnd Bergmann 2018-04-24 @2982  	if (put_user(sstatus.state, &src->s.status.state) ||
09d94175dbeac1 Arnd Bergmann 2018-04-24  2983  	    put_user(sstatus.hw_ptr, &src->s.status.hw_ptr) ||
80fe7430c70859 Arnd Bergmann 2018-04-24  2984  	    put_user(sstatus.tstamp.tv_sec, &src->s.status.tstamp_sec) ||
80fe7430c70859 Arnd Bergmann 2018-04-24  2985  	    put_user(sstatus.tstamp.tv_nsec, &src->s.status.tstamp_nsec) ||
09d94175dbeac1 Arnd Bergmann 2018-04-24  2986  	    put_user(sstatus.suspended_state, &src->s.status.suspended_state) ||
80fe7430c70859 Arnd Bergmann 2018-04-24  2987  	    put_user(sstatus.audio_tstamp.tv_sec, &src->s.status.audio_tstamp_sec) ||
80fe7430c70859 Arnd Bergmann 2018-04-24  2988  	    put_user(sstatus.audio_tstamp.tv_nsec, &src->s.status.audio_tstamp_nsec) ||
09d94175dbeac1 Arnd Bergmann 2018-04-24  2989  	    put_user(scontrol.appl_ptr, &src->c.control.appl_ptr) ||
09d94175dbeac1 Arnd Bergmann 2018-04-24  2990  	    put_user(scontrol.avail_min, &src->c.control.avail_min))
09d94175dbeac1 Arnd Bergmann 2018-04-24  2991  		return -EFAULT;
09d94175dbeac1 Arnd Bergmann 2018-04-24  2992  
09d94175dbeac1 Arnd Bergmann 2018-04-24  2993  	return 0;
09d94175dbeac1 Arnd Bergmann 2018-04-24  2994  }
80fe7430c70859 Arnd Bergmann 2018-04-24  2995  #define __SNDRV_PCM_IOCTL_SYNC_PTR32 _IOWR('A', 0x23, struct snd_pcm_sync_ptr32)
09d94175dbeac1 Arnd Bergmann 2018-04-24  2996  

:::::: The code at line 2982 was first introduced by commit
:::::: 09d94175dbeac12d38b1599a02c7000a5e51b4cb ALSA: move snd_pcm_ioctl_sync_ptr_compat into pcm_native.c

:::::: TO: Arnd Bergmann <arnd@arndb.de>
:::::: CC: Arnd Bergmann <arnd@arndb.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

