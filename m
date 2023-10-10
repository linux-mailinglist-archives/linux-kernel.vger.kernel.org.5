Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1E37BF73B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjJJJYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjJJJXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:23:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9939310A;
        Tue, 10 Oct 2023 02:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696929756; x=1728465756;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pe28AkaWQOFbPDoeW0f0UL3u+esQjxzrmxDbQGIXd+k=;
  b=bijAnBjhFSfwl40qC5elRccbOLCwGz8zb+82bedu8RzMV9OWNm3beuOv
   4mhCT0zlMURcj15KvsiWkuRv67LGReq/pX0JOiqhKX/SD3zKIKaE5kXsB
   DJK3G867QD4AIjyFTwHo2HJgA2BsIiPWGpt2blCobg8tFd7tbfpvztsGK
   75JycjMS81ufYliB2peDgz5KGH4hbrHRznXiVmi3FjdOE3Ays1iEZsHoW
   D9U/sMpEkICSBQ4rvOmk2H6gaPJv2qdtrXzJ9Jzg42MoD/uXSaZO5uNj2
   oqdk3PLyuZmuaDWjZ+tgwQNtXVloYd11H5F2CfTMXjF3OB1TAXp+DymWh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="369414287"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="369414287"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 02:22:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="788512822"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="788512822"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 10 Oct 2023 02:22:32 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qq8wg-0000EE-0A;
        Tue, 10 Oct 2023 09:22:30 +0000
Date:   Tue, 10 Oct 2023 17:21:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wpan@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Doug Brown <doug@schmorgal.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 01/10] appletalk: remove localtalk and ppp support
Message-ID: <202310101724.iRnAoP3r-lkp@intel.com>
References: <20231009141908.1767241-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009141908.1767241-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20231009]
[cannot apply to linus/master v6.6-rc5 v6.6-rc4 v6.6-rc3 v6.6-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Arnd-Bergmann/ieee802154-avoid-deprecated-ndo_do_ioctl-callback/20231009-222305
base:   next-20231009
patch link:    https://lore.kernel.org/r/20231009141908.1767241-1-arnd%40kernel.org
patch subject: [PATCH 01/10] appletalk: remove localtalk and ppp support
config: nios2-randconfig-001-20231010 (https://download.01.org/0day-ci/archive/20231010/202310101724.iRnAoP3r-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231010/202310101724.iRnAoP3r-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310101724.iRnAoP3r-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/net/appletalk/ipddp.c: In function 'ipddp_create':
>> drivers/net/appletalk/ipddp.c:207:24: error: implicit declaration of function 'atrtr_get_dev'; did you mean 'to_net_dev'? [-Werror=implicit-function-declaration]
     207 |         if ((rt->dev = atrtr_get_dev(&rt->at)) == NULL) {
         |                        ^~~~~~~~~~~~~
         |                        to_net_dev
>> drivers/net/appletalk/ipddp.c:207:22: warning: assignment to 'struct net_device *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     207 |         if ((rt->dev = atrtr_get_dev(&rt->at)) == NULL) {
         |                      ^
   cc1: some warnings being treated as errors


vim +207 drivers/net/appletalk/ipddp.c

^1da177e4c3f41 Linus Torvalds   2005-04-16  192  
^1da177e4c3f41 Linus Torvalds   2005-04-16  193  /*
^1da177e4c3f41 Linus Torvalds   2005-04-16  194   * Create a routing entry. We first verify that the
^1da177e4c3f41 Linus Torvalds   2005-04-16  195   * record does not already exist. If it does we return -EEXIST
^1da177e4c3f41 Linus Torvalds   2005-04-16  196   */
^1da177e4c3f41 Linus Torvalds   2005-04-16  197  static int ipddp_create(struct ipddp_route *new_rt)
^1da177e4c3f41 Linus Torvalds   2005-04-16  198  {
ce7e40c432ba84 Vlad Tsyrklevich 2017-01-09  199          struct ipddp_route *rt = kzalloc(sizeof(*rt), GFP_KERNEL);
^1da177e4c3f41 Linus Torvalds   2005-04-16  200  
^1da177e4c3f41 Linus Torvalds   2005-04-16  201          if (rt == NULL)
^1da177e4c3f41 Linus Torvalds   2005-04-16  202                  return -ENOMEM;
^1da177e4c3f41 Linus Torvalds   2005-04-16  203  
^1da177e4c3f41 Linus Torvalds   2005-04-16  204          rt->ip = new_rt->ip;
^1da177e4c3f41 Linus Torvalds   2005-04-16  205          rt->at = new_rt->at;
^1da177e4c3f41 Linus Torvalds   2005-04-16  206          rt->next = NULL;
^1da177e4c3f41 Linus Torvalds   2005-04-16 @207          if ((rt->dev = atrtr_get_dev(&rt->at)) == NULL) {
^1da177e4c3f41 Linus Torvalds   2005-04-16  208  		kfree(rt);
^1da177e4c3f41 Linus Torvalds   2005-04-16  209                  return -ENETUNREACH;
^1da177e4c3f41 Linus Torvalds   2005-04-16  210          }
^1da177e4c3f41 Linus Torvalds   2005-04-16  211  
5615968a708451 David S. Miller  2009-05-27  212  	spin_lock_bh(&ipddp_route_lock);
5615968a708451 David S. Miller  2009-05-27  213  	if (__ipddp_find_route(rt)) {
5615968a708451 David S. Miller  2009-05-27  214  		spin_unlock_bh(&ipddp_route_lock);
^1da177e4c3f41 Linus Torvalds   2005-04-16  215  		kfree(rt);
^1da177e4c3f41 Linus Torvalds   2005-04-16  216  		return -EEXIST;
^1da177e4c3f41 Linus Torvalds   2005-04-16  217  	}
^1da177e4c3f41 Linus Torvalds   2005-04-16  218  
^1da177e4c3f41 Linus Torvalds   2005-04-16  219          rt->next = ipddp_route_list;
^1da177e4c3f41 Linus Torvalds   2005-04-16  220          ipddp_route_list = rt;
^1da177e4c3f41 Linus Torvalds   2005-04-16  221  
5615968a708451 David S. Miller  2009-05-27  222  	spin_unlock_bh(&ipddp_route_lock);
5615968a708451 David S. Miller  2009-05-27  223  
^1da177e4c3f41 Linus Torvalds   2005-04-16  224          return 0;
^1da177e4c3f41 Linus Torvalds   2005-04-16  225  }
^1da177e4c3f41 Linus Torvalds   2005-04-16  226  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
