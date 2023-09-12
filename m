Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8551679D9D5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 21:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237736AbjILT6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 15:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjILT6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 15:58:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE981AE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 12:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694548719; x=1726084719;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9aolbvVGXe/o5wJcSDgi7kIHANgfNpY59ibfl3KF8d8=;
  b=kzQYqZAzgKsz5rQHoXzLBVxoLqPa+SBSI0PEQolxma4Fxyg1VMZS2RnJ
   OtL6LBjL7rwwrOorfDk0Oq+ZsgkwQ9JVayUHGtBWmElkm+GSnyYitrsYp
   C3zObizxfot7Lzg+arQBckS/CHwM7Nq2j4J8iBJCC+oJWhZh09RvrAgl5
   RaiKD+oPF3wR62aOWNBlovZBFauuQg0Ag5OG6SbaHR6WAzQ2gXsBgn0Dm
   OsOwGAgU/Mvi0F9sSxUb3IROEzs8gtS28kWnc6E10VtfhhjsoUZbLWbQG
   tJMeiwnNTcFSJma5h17r1uj4FR+83kVTC+3GxDk+hC2SF/dbnKWXjRV/I
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="382287533"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="382287533"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 12:54:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="693604621"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="693604621"
Received: from lkp-server02.sh.intel.com (HELO 47e905db7d2b) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 12 Sep 2023 12:54:22 -0700
Received: from kbuild by 47e905db7d2b with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qg9Sj-0000D1-1x;
        Tue, 12 Sep 2023 19:54:18 +0000
Date:   Wed, 13 Sep 2023 03:53:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ma Ke <make_ruc2021@163.com>, perex@perex.cz, tiwai@suse.com,
        cujomalainey@chromium.org, maciej.szmigiero@oracle.com,
        clecigne@google.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: control: do not access controls without possession
 of r_w lock
Message-ID: <202309130328.UdCL3yzt-lkp@intel.com>
References: <20230912084530.3307329-1-make_ruc2021@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912084530.3307329-1-make_ruc2021@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ma,

kernel test robot noticed the following build errors:

[auto build test ERROR on tiwai-sound/for-next]
[also build test ERROR on tiwai-sound/for-linus linus/master v6.6-rc1 next-20230912]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ma-Ke/ALSA-control-do-not-access-controls-without-possession-of-r_w-lock/20230912-164832
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
patch link:    https://lore.kernel.org/r/20230912084530.3307329-1-make_ruc2021%40163.com
patch subject: [PATCH] ALSA: control: do not access controls without possession of r_w lock
config: arm-randconfig-r032-20230913 (https://download.01.org/0day-ci/archive/20230913/202309130328.UdCL3yzt-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230913/202309130328.UdCL3yzt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309130328.UdCL3yzt-lkp@intel.com/

All errors (new ones prefixed by >>):

>> sound/core/control.c:593:2: error: use of undeclared identifier 'count'
     593 |         count = kcontrol->count;
         |         ^
   sound/core/control.c:594:22: error: use of undeclared identifier 'count'
     594 |         for (idx = 0; idx < count; idx++)
         |                             ^
   2 errors generated.


vim +/count +593 sound/core/control.c

   576	
   577	static int __snd_ctl_remove(struct snd_card *card,
   578				    struct snd_kcontrol *kcontrol,
   579				    bool remove_hash)
   580	{
   581		unsigned int idx;
   582	
   583		lockdep_assert_held_write(&card->controls_rwsem);
   584	
   585		if (snd_BUG_ON(!card || !kcontrol))
   586			return -EINVAL;
   587		list_del(&kcontrol->list);
   588	
   589		if (remove_hash)
   590			remove_hash_entries(card, kcontrol);
   591	
   592		card->controls_count -= kcontrol->count;
 > 593		count = kcontrol->count;
   594		for (idx = 0; idx < count; idx++)
   595			snd_ctl_notify_one(card, SNDRV_CTL_EVENT_MASK_REMOVE, kcontrol, idx);
   596		snd_ctl_free_one(kcontrol);
   597		return 0;
   598	}
   599	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
