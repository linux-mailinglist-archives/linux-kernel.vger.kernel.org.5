Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FC280B852
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 02:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjLJBaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 20:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjLJBaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 20:30:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF637FA
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 17:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702171816; x=1733707816;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dHzOJnuKLtbRvSjv+RsGTxTzE/LvnC0K/e8rxuyqOhs=;
  b=nAbdfPykf2owFqRZSQFrIkmsmGmn6Cdw+S90yW0C7ILePdSVfI5b7wbJ
   xlnYPcTEwhUuGK3LCn/GJHFIIs4SQvb8lzGMCdPfSbMiZxEtP2MEUGCJ9
   mM71t1QYRsDNywQDJQmqDe2AjWibyXc8nKaqZA09D0cJfbnaBuihDKUkx
   sHOTGFnFN3r0PUpH00lBtGT8HbHK54QS5yarbopccK7rXMzKIMn+mL7It
   OvZLD/eDfxbHTKa3FF5dZIZIlczB8KyZKyRokt5KNe1/PXvTkhnMsKI9O
   dx8pn4IPRObtL7wngmuIEv2JQQYHxWZDU1tf5SEiKq0ns1G7KaOEhJgbT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="398393340"
X-IronPort-AV: E=Sophos;i="6.04,264,1695711600"; 
   d="scan'208";a="398393340"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2023 17:30:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="806804465"
X-IronPort-AV: E=Sophos;i="6.04,264,1695711600"; 
   d="scan'208";a="806804465"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 09 Dec 2023 17:30:14 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rC8e4-000GEz-14;
        Sun, 10 Dec 2023 01:30:12 +0000
Date:   Sun, 10 Dec 2023 09:30:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: net/ceph/crush/mapper.c:440: warning: No description found for
 parameter 'work'
Message-ID: <202312100923.SaslEo9a-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   21b73ffcc62ab772bc06e3e90bd87eff5e9e8ed4
commit: 66a0e2d579dbec5c676cfe446234ffebb267c564 crush: remove mutable part of CRUSH map
date:   7 years ago
config: i386-buildonly-randconfig-004-20231120 (https://download.01.org/0day-ci/archive/20231210/202312100923.SaslEo9a-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231210/202312100923.SaslEo9a-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312100923.SaslEo9a-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/ceph/crush/mapper.c:440: warning: No description found for parameter 'work'
   net/ceph/crush/mapper.c:440: warning: No description found for parameter 'weight'
   net/ceph/crush/mapper.c:440: warning: No description found for parameter 'weight_max'
   net/ceph/crush/mapper.c:626: warning: No description found for parameter 'map'
   net/ceph/crush/mapper.c:626: warning: No description found for parameter 'work'
   net/ceph/crush/mapper.c:626: warning: No description found for parameter 'bucket'
   net/ceph/crush/mapper.c:626: warning: No description found for parameter 'weight'
   net/ceph/crush/mapper.c:626: warning: No description found for parameter 'weight_max'
   net/ceph/crush/mapper.c:626: warning: No description found for parameter 'x'
   net/ceph/crush/mapper.c:626: warning: No description found for parameter 'left'
   net/ceph/crush/mapper.c:626: warning: No description found for parameter 'numrep'
   net/ceph/crush/mapper.c:626: warning: No description found for parameter 'type'
   net/ceph/crush/mapper.c:626: warning: No description found for parameter 'out'
   net/ceph/crush/mapper.c:626: warning: No description found for parameter 'outpos'
   net/ceph/crush/mapper.c:626: warning: No description found for parameter 'tries'
   net/ceph/crush/mapper.c:626: warning: No description found for parameter 'recurse_tries'
   net/ceph/crush/mapper.c:626: warning: No description found for parameter 'recurse_to_leaf'
   net/ceph/crush/mapper.c:626: warning: No description found for parameter 'out2'
   net/ceph/crush/mapper.c:626: warning: No description found for parameter 'parent_r'


vim +/work +440 net/ceph/crush/mapper.c

5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  403  
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  404  /**
9fe07182827d99 net/ceph/crush/mapper.c Ilya Dryomov 2013-12-24  405   * crush_choose_firstn - choose numrep distinct items of given type
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  406   * @map: the crush_map
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  407   * @bucket: the bucket we are choose an item from
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  408   * @x: crush input value
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  409   * @numrep: the number of items to choose
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  410   * @type: the type of item to choose
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  411   * @out: pointer to output vector
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  412   * @outpos: our position in that vector
45002267e8d269 net/ceph/crush/mapper.c Ilya Dryomov 2015-04-14  413   * @out_size: size of the out vector
0e32d7126cdf30 net/ceph/crush/mapper.c Ilya Dryomov 2013-12-24  414   * @tries: number of attempts to make
0e32d7126cdf30 net/ceph/crush/mapper.c Ilya Dryomov 2013-12-24  415   * @recurse_tries: number of attempts to have recursive chooseleaf make
48a163dbb517eb net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  416   * @local_retries: localized retries
48a163dbb517eb net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  417   * @local_fallback_retries: localized fallback retries
0e32d7126cdf30 net/ceph/crush/mapper.c Ilya Dryomov 2013-12-24  418   * @recurse_to_leaf: true if we want one device under each item of given type (chooseleaf instead of choose)
dc6ae6d8e7726b net/ceph/crush/mapper.c Ilya Dryomov 2016-01-31  419   * @stable: stable mode starts rep=0 in the recursive call for all replicas
e2b149cc4ba007 net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  420   * @vary_r: pass r to recursive calls
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  421   * @out2: second output vector for leaf items (if @recurse_to_leaf)
e2b149cc4ba007 net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  422   * @parent_r: r value passed from the parent
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  423   */
9fe07182827d99 net/ceph/crush/mapper.c Ilya Dryomov 2013-12-24  424  static int crush_choose_firstn(const struct crush_map *map,
66a0e2d579dbec net/ceph/crush/mapper.c Ilya Dryomov 2017-01-31  425  			       struct crush_work *work,
66a0e2d579dbec net/ceph/crush/mapper.c Ilya Dryomov 2017-01-31  426  			       const struct crush_bucket *bucket,
b3b33b0e43323a net/ceph/crush/mapper.c Ilya Dryomov 2013-12-24  427  			       const __u32 *weight, int weight_max,
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  428  			       int x, int numrep, int type,
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  429  			       int *out, int outpos,
45002267e8d269 net/ceph/crush/mapper.c Ilya Dryomov 2015-04-14  430  			       int out_size,
2d8be0bc8bc2dc net/ceph/crush/mapper.c Ilya Dryomov 2013-12-24  431  			       unsigned int tries,
2d8be0bc8bc2dc net/ceph/crush/mapper.c Ilya Dryomov 2013-12-24  432  			       unsigned int recurse_tries,
48a163dbb517eb net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  433  			       unsigned int local_retries,
48a163dbb517eb net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  434  			       unsigned int local_fallback_retries,
9fe07182827d99 net/ceph/crush/mapper.c Ilya Dryomov 2013-12-24  435  			       int recurse_to_leaf,
e2b149cc4ba007 net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  436  			       unsigned int vary_r,
dc6ae6d8e7726b net/ceph/crush/mapper.c Ilya Dryomov 2016-01-31  437  			       unsigned int stable,
e2b149cc4ba007 net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  438  			       int *out2,
e2b149cc4ba007 net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  439  			       int parent_r)
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06 @440  {
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  441  	int rep;
8b12d47b80c7a3 net/ceph/crush/mapper.c Sage Weil    2012-05-07  442  	unsigned int ftotal, flocal;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  443  	int retry_descent, retry_bucket, skip_rep;
66a0e2d579dbec net/ceph/crush/mapper.c Ilya Dryomov 2017-01-31  444  	const struct crush_bucket *in = bucket;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  445  	int r;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  446  	int i;
b28813a61d6ffe fs/ceph/crush/mapper.c  Sage Weil    2009-10-07  447  	int item = 0;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  448  	int itemtype;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  449  	int collide, reject;
45002267e8d269 net/ceph/crush/mapper.c Ilya Dryomov 2015-04-14  450  	int count = out_size;
a1a31e734241ae fs/ceph/crush/mapper.c  Sage Weil    2010-06-24  451  
dc6ae6d8e7726b net/ceph/crush/mapper.c Ilya Dryomov 2016-01-31  452  	dprintk("CHOOSE%s bucket %d x %d outpos %d numrep %d tries %d recurse_tries %d local_retries %d local_fallback_retries %d parent_r %d stable %d\n",
e2b149cc4ba007 net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  453  		recurse_to_leaf ? "_LEAF" : "",
e2b149cc4ba007 net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  454  		bucket->id, x, outpos, numrep,
e2b149cc4ba007 net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  455  		tries, recurse_tries, local_retries, local_fallback_retries,
dc6ae6d8e7726b net/ceph/crush/mapper.c Ilya Dryomov 2016-01-31  456  		parent_r, stable);
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  457  
dc6ae6d8e7726b net/ceph/crush/mapper.c Ilya Dryomov 2016-01-31  458  	for (rep = stable ? 0 : outpos; rep < numrep && count > 0 ; rep++) {
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  459  		/* keep trying until we get a non-out, non-colliding item */
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  460  		ftotal = 0;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  461  		skip_rep = 0;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  462  		do {
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  463  			retry_descent = 0;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  464  			in = bucket;               /* initial bucket */
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  465  
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  466  			/* choose through intervening buckets */
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  467  			flocal = 0;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  468  			do {
b28813a61d6ffe fs/ceph/crush/mapper.c  Sage Weil    2009-10-07  469  				collide = 0;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  470  				retry_bucket = 0;
e2b149cc4ba007 net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  471  				r = rep + parent_r;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  472  				/* r' = r + f_total */
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  473  				r += ftotal;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  474  
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  475  				/* bucket choose */
b28813a61d6ffe fs/ceph/crush/mapper.c  Sage Weil    2009-10-07  476  				if (in->size == 0) {
b28813a61d6ffe fs/ceph/crush/mapper.c  Sage Weil    2009-10-07  477  					reject = 1;
b28813a61d6ffe fs/ceph/crush/mapper.c  Sage Weil    2009-10-07  478  					goto reject;
b28813a61d6ffe fs/ceph/crush/mapper.c  Sage Weil    2009-10-07  479  				}
48a163dbb517eb net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  480  				if (local_fallback_retries > 0 &&
546f04ef716dd4 net/ceph/crush/mapper.c Sage Weil    2012-07-30  481  				    flocal >= (in->size>>1) &&
48a163dbb517eb net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  482  				    flocal > local_fallback_retries)
66a0e2d579dbec net/ceph/crush/mapper.c Ilya Dryomov 2017-01-31  483  					item = bucket_perm_choose(
66a0e2d579dbec net/ceph/crush/mapper.c Ilya Dryomov 2017-01-31  484  						in, work->work[-1-in->id],
66a0e2d579dbec net/ceph/crush/mapper.c Ilya Dryomov 2017-01-31  485  						x, r);
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  486  				else
66a0e2d579dbec net/ceph/crush/mapper.c Ilya Dryomov 2017-01-31  487  					item = crush_bucket_choose(
66a0e2d579dbec net/ceph/crush/mapper.c Ilya Dryomov 2017-01-31  488  						in, work->work[-1-in->id],
66a0e2d579dbec net/ceph/crush/mapper.c Ilya Dryomov 2017-01-31  489  						x, r);
a1f4895be8bf1b net/ceph/crush/mapper.c Sage Weil    2012-05-07  490  				if (item >= map->max_devices) {
a1f4895be8bf1b net/ceph/crush/mapper.c Sage Weil    2012-05-07  491  					dprintk("   bad item %d\n", item);
a1f4895be8bf1b net/ceph/crush/mapper.c Sage Weil    2012-05-07  492  					skip_rep = 1;
a1f4895be8bf1b net/ceph/crush/mapper.c Sage Weil    2012-05-07  493  					break;
a1f4895be8bf1b net/ceph/crush/mapper.c Sage Weil    2012-05-07  494  				}
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  495  
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  496  				/* desired type? */
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  497  				if (item < 0)
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  498  					itemtype = map->buckets[-1-item]->type;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  499  				else
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  500  					itemtype = 0;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  501  				dprintk("  item %d type %d\n", item, itemtype);
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  502  
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  503  				/* keep going? */
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  504  				if (itemtype != type) {
a1f4895be8bf1b net/ceph/crush/mapper.c Sage Weil    2012-05-07  505  					if (item >= 0 ||
a1f4895be8bf1b net/ceph/crush/mapper.c Sage Weil    2012-05-07  506  					    (-1-item) >= map->max_buckets) {
a1f4895be8bf1b net/ceph/crush/mapper.c Sage Weil    2012-05-07  507  						dprintk("   bad item type %d\n", type);
a1f4895be8bf1b net/ceph/crush/mapper.c Sage Weil    2012-05-07  508  						skip_rep = 1;
a1f4895be8bf1b net/ceph/crush/mapper.c Sage Weil    2012-05-07  509  						break;
a1f4895be8bf1b net/ceph/crush/mapper.c Sage Weil    2012-05-07  510  					}
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  511  					in = map->buckets[-1-item];
55bda7aacd13f5 fs/ceph/crush/mapper.c  Sage Weil    2010-06-24  512  					retry_bucket = 1;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  513  					continue;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  514  				}
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  515  
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  516  				/* collision? */
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  517  				for (i = 0; i < outpos; i++) {
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  518  					if (out[i] == item) {
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  519  						collide = 1;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  520  						break;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  521  					}
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  522  				}
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  523  
a1a31e734241ae fs/ceph/crush/mapper.c  Sage Weil    2010-06-24  524  				reject = 0;
7d7c1f6136bac0 net/ceph/crush/mapper.c Sage Weil    2013-01-15  525  				if (!collide && recurse_to_leaf) {
a1a31e734241ae fs/ceph/crush/mapper.c  Sage Weil    2010-06-24  526  					if (item < 0) {
e2b149cc4ba007 net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  527  						int sub_r;
e2b149cc4ba007 net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  528  						if (vary_r)
e2b149cc4ba007 net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  529  							sub_r = r >> (vary_r-1);
e2b149cc4ba007 net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  530  						else
e2b149cc4ba007 net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  531  							sub_r = 0;
66a0e2d579dbec net/ceph/crush/mapper.c Ilya Dryomov 2017-01-31  532  						if (crush_choose_firstn(
66a0e2d579dbec net/ceph/crush/mapper.c Ilya Dryomov 2017-01-31  533  							    map,
66a0e2d579dbec net/ceph/crush/mapper.c Ilya Dryomov 2017-01-31  534  							    work,
a1a31e734241ae fs/ceph/crush/mapper.c  Sage Weil    2010-06-24  535  							    map->buckets[-1-item],
b3b33b0e43323a net/ceph/crush/mapper.c Ilya Dryomov 2013-12-24  536  							    weight, weight_max,
dc6ae6d8e7726b net/ceph/crush/mapper.c Ilya Dryomov 2016-01-31  537  							    x, stable ? 1 : outpos+1, 0,
45002267e8d269 net/ceph/crush/mapper.c Ilya Dryomov 2015-04-14  538  							    out2, outpos, count,
2d8be0bc8bc2dc net/ceph/crush/mapper.c Ilya Dryomov 2013-12-24  539  							    recurse_tries, 0,
48a163dbb517eb net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  540  							    local_retries,
48a163dbb517eb net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  541  							    local_fallback_retries,
9fe07182827d99 net/ceph/crush/mapper.c Ilya Dryomov 2013-12-24  542  							    0,
e2b149cc4ba007 net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  543  							    vary_r,
dc6ae6d8e7726b net/ceph/crush/mapper.c Ilya Dryomov 2016-01-31  544  							    stable,
e2b149cc4ba007 net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  545  							    NULL,
e2b149cc4ba007 net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  546  							    sub_r) <= outpos)
a1a31e734241ae fs/ceph/crush/mapper.c  Sage Weil    2010-06-24  547  							/* didn't get leaf */
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  548  							reject = 1;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  549  					} else {
a1a31e734241ae fs/ceph/crush/mapper.c  Sage Weil    2010-06-24  550  						/* we already have a leaf! */
a1a31e734241ae fs/ceph/crush/mapper.c  Sage Weil    2010-06-24  551  						out2[outpos] = item;
a1a31e734241ae fs/ceph/crush/mapper.c  Sage Weil    2010-06-24  552  					}
a1a31e734241ae fs/ceph/crush/mapper.c  Sage Weil    2010-06-24  553  				}
a1a31e734241ae fs/ceph/crush/mapper.c  Sage Weil    2010-06-24  554  
a1a31e734241ae fs/ceph/crush/mapper.c  Sage Weil    2010-06-24  555  				if (!reject) {
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  556  					/* out? */
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  557  					if (itemtype == 0)
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  558  						reject = is_out(map, weight,
b3b33b0e43323a net/ceph/crush/mapper.c Ilya Dryomov 2013-12-24  559  								weight_max,
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  560  								item, x);
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  561  					else
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  562  						reject = 0;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  563  				}
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  564  
b28813a61d6ffe fs/ceph/crush/mapper.c  Sage Weil    2009-10-07  565  reject:
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  566  				if (reject || collide) {
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  567  					ftotal++;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  568  					flocal++;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  569  
48a163dbb517eb net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  570  					if (collide && flocal <= local_retries)
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  571  						/* retry locally a few times */
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  572  						retry_bucket = 1;
48a163dbb517eb net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  573  					else if (local_fallback_retries > 0 &&
48a163dbb517eb net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  574  						 flocal <= in->size + local_fallback_retries)
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  575  						/* exhaustive bucket search */
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  576  						retry_bucket = 1;
48a163dbb517eb net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  577  					else if (ftotal < tries)
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  578  						/* then retry descent */
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  579  						retry_descent = 1;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  580  					else
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  581  						/* else give up */
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  582  						skip_rep = 1;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  583  					dprintk("  reject %d  collide %d  "
8b12d47b80c7a3 net/ceph/crush/mapper.c Sage Weil    2012-05-07  584  						"ftotal %u  flocal %u\n",
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  585  						reject, collide, ftotal,
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  586  						flocal);
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  587  				}
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  588  			} while (retry_bucket);
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  589  		} while (retry_descent);
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  590  
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  591  		if (skip_rep) {
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  592  			dprintk("skip rep\n");
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  593  			continue;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  594  		}
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  595  
a1a31e734241ae fs/ceph/crush/mapper.c  Sage Weil    2010-06-24  596  		dprintk("CHOOSE got %d\n", item);
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  597  		out[outpos] = item;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  598  		outpos++;
45002267e8d269 net/ceph/crush/mapper.c Ilya Dryomov 2015-04-14  599  		count--;
b459be739f97e2 net/ceph/crush/mapper.c Ilya Dryomov 2015-06-12  600  #ifndef __KERNEL__
b459be739f97e2 net/ceph/crush/mapper.c Ilya Dryomov 2015-06-12  601  		if (map->choose_tries && ftotal <= map->choose_total_tries)
b459be739f97e2 net/ceph/crush/mapper.c Ilya Dryomov 2015-06-12  602  			map->choose_tries[ftotal]++;
b459be739f97e2 net/ceph/crush/mapper.c Ilya Dryomov 2015-06-12  603  #endif
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  604  	}
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  605  
a1a31e734241ae fs/ceph/crush/mapper.c  Sage Weil    2010-06-24  606  	dprintk("CHOOSE returns %d\n", outpos);
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  607  	return outpos;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  608  }
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  609  

:::::: The code at line 440 was first introduced by commit
:::::: 5ecc0a0f8128b1876e8614638deaed49cc8b174c ceph: CRUSH mapping algorithm

:::::: TO: Sage Weil <sage@newdream.net>
:::::: CC: Sage Weil <sage@newdream.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
