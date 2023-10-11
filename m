Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70167C4EE9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 11:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjJKJ3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 05:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjJKJ3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 05:29:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CD391;
        Wed, 11 Oct 2023 02:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697016538; x=1728552538;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZpC0uCRDOByLh94gi2iX/h5gJtZPBcvba+Hl6b4tHOk=;
  b=LWVdQJYofk4Z0UI4JkWRiZbhT7p5bifxD57zSuAqyBDltgUyAT/HCRB/
   tNgLoeZb8V7UEU6E2Pk9JxZhmkSiLvoUyhPVWSyAtJ5/g6acZHRBrPm8p
   rQFMY0wjVw5YdwDyOsT2GU5xbCYeyyiZAdTeXjayjtxAfMYUEtGDY0e8M
   V/jWuOUDmE6chgX+75+hm1i0fjp2yLqibtjAEOvWnzGfpiPX082RRkrd5
   qDqbCABa6/B0ZYhPJYhHq77Uym+LVVk+NCdDB/It76SNNQ9jcRHBAnrlf
   ZHufT028/GB9HtlYBlDfH9tBD5muUKrdJGiUR8ybcpKCK7ZBm5wFXkkzr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="387463709"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="387463709"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 02:28:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="788936139"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="788936139"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 11 Oct 2023 02:28:52 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qqVVv-00024D-1z;
        Wed, 11 Oct 2023 09:28:25 +0000
Date:   Wed, 11 Oct 2023 17:27:17 +0800
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
Message-ID: <202310111736.4mh6Cf5C-lkp@intel.com>
References: <20231009141908.1767241-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009141908.1767241-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20231009]
[cannot apply to linus/master v6.6-rc5 v6.6-rc4 v6.6-rc3 v6.6-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Arnd-Bergmann/ieee802154-avoid-deprecated-ndo_do_ioctl-callback/20231009-222305
base:   next-20231009
patch link:    https://lore.kernel.org/r/20231009141908.1767241-1-arnd%40kernel.org
patch subject: [PATCH 01/10] appletalk: remove localtalk and ppp support
config: x86_64-randconfig-002-20231011 (https://download.01.org/0day-ci/archive/20231011/202310111736.4mh6Cf5C-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231011/202310111736.4mh6Cf5C-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310111736.4mh6Cf5C-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/appletalk/ipddp.c: In function 'ipddp_create':
   drivers/net/appletalk/ipddp.c:207:24: error: implicit declaration of function 'atrtr_get_dev'; did you mean 'to_net_dev'? [-Werror=implicit-function-declaration]
            if ((rt->dev = atrtr_get_dev(&rt->at)) == NULL) {
                           ^~~~~~~~~~~~~
                           to_net_dev
>> drivers/net/appletalk/ipddp.c:207:22: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
            if ((rt->dev = atrtr_get_dev(&rt->at)) == NULL) {
                         ^
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
