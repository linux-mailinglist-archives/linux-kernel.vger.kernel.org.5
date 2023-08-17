Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D716477EF30
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 04:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347692AbjHQCth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 22:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347688AbjHQCtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 22:49:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC07326AA
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 19:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692240552; x=1723776552;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wTX+p+umyHhi1qed7dXceQx9nKp3lKNrLWrY5JrYcwQ=;
  b=Q5/64RTzC+BVRh/MSmi6ikq/CKuoIAbIalVIq0YhQE0Y1s4FMq1pfAaA
   1qYnWhRO/7xeL8sLNEAJbmWSn7NfESziItamwVo9KQ0zW/YJgnne7xc9Z
   B3d7+WBn6I25vpvri5R22f1P6cjBOQbUEcZDxvuDSgOgDatodOxRqevik
   UTTVO2i9mLN1WrR1/PjinPRZGiCzPFrRtPRISMz8qkKN/0XXxtVMy8TsY
   8qy422KJ6Xr9tHfuR4vCSU60QvU7Ds30K/XfoG+BzLhSumbOy4BE7qku2
   GNMwXcHKwoM22keP2yTrUz7nDwWrIzQS6D1bRTt2+AQfUIdtFyS6Xq65x
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="375461677"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="375461677"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 19:49:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="980966946"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="980966946"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 16 Aug 2023 19:49:10 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWT4Q-0000kZ-0o;
        Thu, 17 Aug 2023 02:49:10 +0000
Date:   Thu, 17 Aug 2023 10:48:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Subject: kernel/bpf/helpers.c:1882:7: warning: no previous declaration for
 'bpf_cast_to_kern_ctx'
Message-ID: <202308171055.NJBXQriP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4853c74bd7ab7fdb83f319bd9ace8a08c031e9b6
commit: fd264ca020948a743e4c36731dfdecc4a812153c bpf: Add a kfunc to type cast from bpf uapi ctx to kernel ctx
date:   9 months ago
config: x86_64-randconfig-x012-20230816 (https://download.01.org/0day-ci/archive/20230817/202308171055.NJBXQriP-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce: (https://download.01.org/0day-ci/archive/20230817/202308171055.NJBXQriP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308171055.NJBXQriP-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/bpf/helpers.c:1757:7: warning: no previous declaration for 'bpf_obj_new_impl' [-Wmissing-declarations]
    void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
          ^~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1771:6: warning: no previous declaration for 'bpf_obj_drop_impl' [-Wmissing-declarations]
    void bpf_obj_drop_impl(void *p__alloc, void *meta__ign)
         ^~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1792:6: warning: no previous declaration for 'bpf_list_push_front' [-Wmissing-declarations]
    void bpf_list_push_front(struct bpf_list_head *head, struct bpf_list_node *node)
         ^~~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1797:6: warning: no previous declaration for 'bpf_list_push_back' [-Wmissing-declarations]
    void bpf_list_push_back(struct bpf_list_head *head, struct bpf_list_node *node)
         ^~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1815:23: warning: no previous declaration for 'bpf_list_pop_front' [-Wmissing-declarations]
    struct bpf_list_node *bpf_list_pop_front(struct bpf_list_head *head)
                          ^~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1820:23: warning: no previous declaration for 'bpf_list_pop_back' [-Wmissing-declarations]
    struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head)
                          ^~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1831:21: warning: no previous declaration for 'bpf_task_acquire' [-Wmissing-declarations]
    struct task_struct *bpf_task_acquire(struct task_struct *p)
                        ^~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1843:21: warning: no previous declaration for 'bpf_task_kptr_get' [-Wmissing-declarations]
    struct task_struct *bpf_task_kptr_get(struct task_struct **pp)
                        ^~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1874:6: warning: no previous declaration for 'bpf_task_release' [-Wmissing-declarations]
    void bpf_task_release(struct task_struct *p)
         ^~~~~~~~~~~~~~~~
>> kernel/bpf/helpers.c:1882:7: warning: no previous declaration for 'bpf_cast_to_kern_ctx' [-Wmissing-declarations]
    void *bpf_cast_to_kern_ctx(void *obj)
          ^~~~~~~~~~~~~~~~~~~~


vim +/bpf_cast_to_kern_ctx +1882 kernel/bpf/helpers.c

  1881	
> 1882	void *bpf_cast_to_kern_ctx(void *obj)
  1883	{
  1884		return obj;
  1885	}
  1886	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
