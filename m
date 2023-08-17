Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6861877F03D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 07:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348112AbjHQFgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 01:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348110AbjHQFgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 01:36:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D50E48
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 22:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692250564; x=1723786564;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xyDvXu50Nwflcy6OBgzU9fv/e5QmHeAJoWXPBRuKuqE=;
  b=IuvEyFVLqR91GnDIDJ07DXH268wOOiQsLvOzKk+FAumiyJ5ZHqR5u0x/
   +5mvbBLjwiNJgXTnrx6pR7Fg5pGGx8lDnqapj1sG/Reh3bEtMr+oeNj+w
   zQFE1KTPmVUKBFCuBFdUXIEq3srQTMZ316eih/jGsDAzfZsZotfXjglLW
   ECz9FF4knmHUByjskWAqSZBtiwtMBtn+GWwE9XtjZQxoBVnUQidnn5EKC
   6Rj1diu0zIDnIES0VbIaoJrFpoGiExVha7NNy6X3HaQ/JbWRECmp/DvMc
   SdViaUC9K2RqYfFTg4QtfgIOpAfkGlJKvYp4I6ed0KkycXDULtxA/cRNB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="376453560"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="376453560"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 22:36:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="878076802"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 16 Aug 2023 22:36:06 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWVft-0000pF-2v;
        Thu, 17 Aug 2023 05:36:01 +0000
Date:   Thu, 17 Aug 2023 13:35:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Subject: kernel/bpf/helpers.c:1887:7: warning: no previous declaration for
 'bpf_rdonly_cast'
Message-ID: <202308171347.v9awguFg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4853c74bd7ab7fdb83f319bd9ace8a08c031e9b6
commit: a35b9af4ec2c7f69286ef861fd2074a577e354cb bpf: Add a kfunc for generic type cast
date:   9 months ago
config: x86_64-randconfig-x012-20230816 (https://download.01.org/0day-ci/archive/20230817/202308171347.v9awguFg-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce: (https://download.01.org/0day-ci/archive/20230817/202308171347.v9awguFg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308171347.v9awguFg-lkp@intel.com/

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
   kernel/bpf/helpers.c:1882:7: warning: no previous declaration for 'bpf_cast_to_kern_ctx' [-Wmissing-declarations]
    void *bpf_cast_to_kern_ctx(void *obj)
          ^~~~~~~~~~~~~~~~~~~~
>> kernel/bpf/helpers.c:1887:7: warning: no previous declaration for 'bpf_rdonly_cast' [-Wmissing-declarations]
    void *bpf_rdonly_cast(void *obj__ign, u32 btf_id__k)
          ^~~~~~~~~~~~~~~


vim +/bpf_rdonly_cast +1887 kernel/bpf/helpers.c

  1886	
> 1887	void *bpf_rdonly_cast(void *obj__ign, u32 btf_id__k)
  1888	{
  1889		return obj__ign;
  1890	}
  1891	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
