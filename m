Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BD67F56DB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 04:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbjKWDML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 22:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbjKWDMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 22:12:08 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAD01A4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 19:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700709134; x=1732245134;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OiDMxB3bQEgdsJp2N79bUFKzqYIBqm0iM3z12IyUeOU=;
  b=mBRXiimFqo6uGb8pNxF4oLHJNv5RaMGrgZHuSjueVOXBsyfAwAFATpGE
   mdz8tZQnXa0m7a6iWDx88oOs44LsLRnelgX6acgbdCFKOx9W0ZDqTgOm7
   aLboAspSecNUMq+w66pyNUfG27+Q9QxhLax30mOSERfTpjId1qK8Udinf
   HDEfvRIJunslnIYbm0K3klCYIxVwoQDfWz8/Jh6ZW8MdUuGGiN1XBlPp8
   6/+meffFkN6nzJj7XeK98XEmeGF7gih83tsfh0VaZiLjTsVo9pi7qJDA9
   fIZC5NNrbIY6DLWP9vNKlGUa3GfI3tn8B1dREOcJFTMPahhkxUFY2OEwo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="13744888"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="13744888"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 19:12:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="8712753"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 22 Nov 2023 19:12:12 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r608Q-0001A9-0g;
        Thu, 23 Nov 2023 03:12:10 +0000
Date:   Thu, 23 Nov 2023 11:11:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: net/ceph/crush/mapper.c:466: warning: No description found for
 parameter 'choose_args'
Message-ID: <202311230726.PROfM0Z7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9b6de136b5f0158c60844f85286a593cb70fb364
commit: 069f3222ca96acfe8c59937e98c401bda5475b48 crush: implement weight and id overrides for straw2
date:   6 years ago
config: i386-buildonly-randconfig-004-20231120 (https://download.01.org/0day-ci/archive/20231123/202311230726.PROfM0Z7-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231123/202311230726.PROfM0Z7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311230726.PROfM0Z7-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/ceph/crush/mapper.c:466: warning: No description found for parameter 'work'
   net/ceph/crush/mapper.c:466: warning: No description found for parameter 'weight'
   net/ceph/crush/mapper.c:466: warning: No description found for parameter 'weight_max'
>> net/ceph/crush/mapper.c:466: warning: No description found for parameter 'choose_args'
   net/ceph/crush/mapper.c:655: warning: No description found for parameter 'map'
   net/ceph/crush/mapper.c:655: warning: No description found for parameter 'work'
   net/ceph/crush/mapper.c:655: warning: No description found for parameter 'bucket'
   net/ceph/crush/mapper.c:655: warning: No description found for parameter 'weight'
   net/ceph/crush/mapper.c:655: warning: No description found for parameter 'weight_max'
   net/ceph/crush/mapper.c:655: warning: No description found for parameter 'x'
   net/ceph/crush/mapper.c:655: warning: No description found for parameter 'left'
   net/ceph/crush/mapper.c:655: warning: No description found for parameter 'numrep'
   net/ceph/crush/mapper.c:655: warning: No description found for parameter 'type'
   net/ceph/crush/mapper.c:655: warning: No description found for parameter 'out'
   net/ceph/crush/mapper.c:655: warning: No description found for parameter 'outpos'
   net/ceph/crush/mapper.c:655: warning: No description found for parameter 'tries'
   net/ceph/crush/mapper.c:655: warning: No description found for parameter 'recurse_tries'
   net/ceph/crush/mapper.c:655: warning: No description found for parameter 'recurse_to_leaf'
   net/ceph/crush/mapper.c:655: warning: No description found for parameter 'out2'
   net/ceph/crush/mapper.c:655: warning: No description found for parameter 'parent_r'
   net/ceph/crush/mapper.c:655: warning: No description found for parameter 'choose_args'


vim +/choose_args +466 net/ceph/crush/mapper.c

5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  428  
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  429  /**
9fe07182827d99 net/ceph/crush/mapper.c Ilya Dryomov 2013-12-24  430   * crush_choose_firstn - choose numrep distinct items of given type
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  431   * @map: the crush_map
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  432   * @bucket: the bucket we are choose an item from
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  433   * @x: crush input value
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  434   * @numrep: the number of items to choose
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  435   * @type: the type of item to choose
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  436   * @out: pointer to output vector
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  437   * @outpos: our position in that vector
45002267e8d269 net/ceph/crush/mapper.c Ilya Dryomov 2015-04-14  438   * @out_size: size of the out vector
0e32d7126cdf30 net/ceph/crush/mapper.c Ilya Dryomov 2013-12-24  439   * @tries: number of attempts to make
0e32d7126cdf30 net/ceph/crush/mapper.c Ilya Dryomov 2013-12-24  440   * @recurse_tries: number of attempts to have recursive chooseleaf make
48a163dbb517eb net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  441   * @local_retries: localized retries
48a163dbb517eb net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  442   * @local_fallback_retries: localized fallback retries
0e32d7126cdf30 net/ceph/crush/mapper.c Ilya Dryomov 2013-12-24  443   * @recurse_to_leaf: true if we want one device under each item of given type (chooseleaf instead of choose)
dc6ae6d8e7726b net/ceph/crush/mapper.c Ilya Dryomov 2016-01-31  444   * @stable: stable mode starts rep=0 in the recursive call for all replicas
e2b149cc4ba007 net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  445   * @vary_r: pass r to recursive calls
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  446   * @out2: second output vector for leaf items (if @recurse_to_leaf)
e2b149cc4ba007 net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  447   * @parent_r: r value passed from the parent
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  448   */
9fe07182827d99 net/ceph/crush/mapper.c Ilya Dryomov 2013-12-24  449  static int crush_choose_firstn(const struct crush_map *map,
66a0e2d579dbec net/ceph/crush/mapper.c Ilya Dryomov 2017-01-31  450  			       struct crush_work *work,
66a0e2d579dbec net/ceph/crush/mapper.c Ilya Dryomov 2017-01-31  451  			       const struct crush_bucket *bucket,
b3b33b0e43323a net/ceph/crush/mapper.c Ilya Dryomov 2013-12-24  452  			       const __u32 *weight, int weight_max,
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  453  			       int x, int numrep, int type,
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  454  			       int *out, int outpos,
45002267e8d269 net/ceph/crush/mapper.c Ilya Dryomov 2015-04-14  455  			       int out_size,
2d8be0bc8bc2dc net/ceph/crush/mapper.c Ilya Dryomov 2013-12-24  456  			       unsigned int tries,
2d8be0bc8bc2dc net/ceph/crush/mapper.c Ilya Dryomov 2013-12-24  457  			       unsigned int recurse_tries,
48a163dbb517eb net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  458  			       unsigned int local_retries,
48a163dbb517eb net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  459  			       unsigned int local_fallback_retries,
9fe07182827d99 net/ceph/crush/mapper.c Ilya Dryomov 2013-12-24  460  			       int recurse_to_leaf,
e2b149cc4ba007 net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  461  			       unsigned int vary_r,
dc6ae6d8e7726b net/ceph/crush/mapper.c Ilya Dryomov 2016-01-31  462  			       unsigned int stable,
e2b149cc4ba007 net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  463  			       int *out2,
069f3222ca96ac net/ceph/crush/mapper.c Ilya Dryomov 2017-06-22  464  			       int parent_r,
069f3222ca96ac net/ceph/crush/mapper.c Ilya Dryomov 2017-06-22  465  			       const struct crush_choose_arg *choose_args)
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06 @466  {
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  467  	int rep;
8b12d47b80c7a3 net/ceph/crush/mapper.c Sage Weil    2012-05-07  468  	unsigned int ftotal, flocal;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  469  	int retry_descent, retry_bucket, skip_rep;
66a0e2d579dbec net/ceph/crush/mapper.c Ilya Dryomov 2017-01-31  470  	const struct crush_bucket *in = bucket;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  471  	int r;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  472  	int i;
b28813a61d6ffe fs/ceph/crush/mapper.c  Sage Weil    2009-10-07  473  	int item = 0;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  474  	int itemtype;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  475  	int collide, reject;
45002267e8d269 net/ceph/crush/mapper.c Ilya Dryomov 2015-04-14  476  	int count = out_size;
a1a31e734241ae fs/ceph/crush/mapper.c  Sage Weil    2010-06-24  477  
dc6ae6d8e7726b net/ceph/crush/mapper.c Ilya Dryomov 2016-01-31  478  	dprintk("CHOOSE%s bucket %d x %d outpos %d numrep %d tries %d recurse_tries %d local_retries %d local_fallback_retries %d parent_r %d stable %d\n",
e2b149cc4ba007 net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  479  		recurse_to_leaf ? "_LEAF" : "",
e2b149cc4ba007 net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  480  		bucket->id, x, outpos, numrep,
e2b149cc4ba007 net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  481  		tries, recurse_tries, local_retries, local_fallback_retries,
dc6ae6d8e7726b net/ceph/crush/mapper.c Ilya Dryomov 2016-01-31  482  		parent_r, stable);
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  483  
dc6ae6d8e7726b net/ceph/crush/mapper.c Ilya Dryomov 2016-01-31  484  	for (rep = stable ? 0 : outpos; rep < numrep && count > 0 ; rep++) {
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  485  		/* keep trying until we get a non-out, non-colliding item */
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  486  		ftotal = 0;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  487  		skip_rep = 0;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  488  		do {
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  489  			retry_descent = 0;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  490  			in = bucket;               /* initial bucket */
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  491  
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  492  			/* choose through intervening buckets */
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  493  			flocal = 0;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  494  			do {
b28813a61d6ffe fs/ceph/crush/mapper.c  Sage Weil    2009-10-07  495  				collide = 0;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  496  				retry_bucket = 0;
e2b149cc4ba007 net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  497  				r = rep + parent_r;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  498  				/* r' = r + f_total */
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  499  				r += ftotal;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  500  
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  501  				/* bucket choose */
b28813a61d6ffe fs/ceph/crush/mapper.c  Sage Weil    2009-10-07  502  				if (in->size == 0) {
b28813a61d6ffe fs/ceph/crush/mapper.c  Sage Weil    2009-10-07  503  					reject = 1;
b28813a61d6ffe fs/ceph/crush/mapper.c  Sage Weil    2009-10-07  504  					goto reject;
b28813a61d6ffe fs/ceph/crush/mapper.c  Sage Weil    2009-10-07  505  				}
48a163dbb517eb net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  506  				if (local_fallback_retries > 0 &&
546f04ef716dd4 net/ceph/crush/mapper.c Sage Weil    2012-07-30  507  				    flocal >= (in->size>>1) &&
48a163dbb517eb net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  508  				    flocal > local_fallback_retries)
66a0e2d579dbec net/ceph/crush/mapper.c Ilya Dryomov 2017-01-31  509  					item = bucket_perm_choose(
66a0e2d579dbec net/ceph/crush/mapper.c Ilya Dryomov 2017-01-31  510  						in, work->work[-1-in->id],
66a0e2d579dbec net/ceph/crush/mapper.c Ilya Dryomov 2017-01-31  511  						x, r);
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  512  				else
66a0e2d579dbec net/ceph/crush/mapper.c Ilya Dryomov 2017-01-31  513  					item = crush_bucket_choose(
66a0e2d579dbec net/ceph/crush/mapper.c Ilya Dryomov 2017-01-31  514  						in, work->work[-1-in->id],
069f3222ca96ac net/ceph/crush/mapper.c Ilya Dryomov 2017-06-22  515  						x, r,
069f3222ca96ac net/ceph/crush/mapper.c Ilya Dryomov 2017-06-22  516  						(choose_args ?
069f3222ca96ac net/ceph/crush/mapper.c Ilya Dryomov 2017-06-22  517  						 &choose_args[-1-in->id] : 0),
069f3222ca96ac net/ceph/crush/mapper.c Ilya Dryomov 2017-06-22  518  						outpos);
a1f4895be8bf1b net/ceph/crush/mapper.c Sage Weil    2012-05-07  519  				if (item >= map->max_devices) {
a1f4895be8bf1b net/ceph/crush/mapper.c Sage Weil    2012-05-07  520  					dprintk("   bad item %d\n", item);
a1f4895be8bf1b net/ceph/crush/mapper.c Sage Weil    2012-05-07  521  					skip_rep = 1;
a1f4895be8bf1b net/ceph/crush/mapper.c Sage Weil    2012-05-07  522  					break;
a1f4895be8bf1b net/ceph/crush/mapper.c Sage Weil    2012-05-07  523  				}
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  524  
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  525  				/* desired type? */
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  526  				if (item < 0)
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  527  					itemtype = map->buckets[-1-item]->type;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  528  				else
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  529  					itemtype = 0;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  530  				dprintk("  item %d type %d\n", item, itemtype);
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  531  
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  532  				/* keep going? */
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  533  				if (itemtype != type) {
a1f4895be8bf1b net/ceph/crush/mapper.c Sage Weil    2012-05-07  534  					if (item >= 0 ||
a1f4895be8bf1b net/ceph/crush/mapper.c Sage Weil    2012-05-07  535  					    (-1-item) >= map->max_buckets) {
a1f4895be8bf1b net/ceph/crush/mapper.c Sage Weil    2012-05-07  536  						dprintk("   bad item type %d\n", type);
a1f4895be8bf1b net/ceph/crush/mapper.c Sage Weil    2012-05-07  537  						skip_rep = 1;
a1f4895be8bf1b net/ceph/crush/mapper.c Sage Weil    2012-05-07  538  						break;
a1f4895be8bf1b net/ceph/crush/mapper.c Sage Weil    2012-05-07  539  					}
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  540  					in = map->buckets[-1-item];
55bda7aacd13f5 fs/ceph/crush/mapper.c  Sage Weil    2010-06-24  541  					retry_bucket = 1;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  542  					continue;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  543  				}
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  544  
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  545  				/* collision? */
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  546  				for (i = 0; i < outpos; i++) {
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  547  					if (out[i] == item) {
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  548  						collide = 1;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  549  						break;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  550  					}
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  551  				}
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  552  
a1a31e734241ae fs/ceph/crush/mapper.c  Sage Weil    2010-06-24  553  				reject = 0;
7d7c1f6136bac0 net/ceph/crush/mapper.c Sage Weil    2013-01-15  554  				if (!collide && recurse_to_leaf) {
a1a31e734241ae fs/ceph/crush/mapper.c  Sage Weil    2010-06-24  555  					if (item < 0) {
e2b149cc4ba007 net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  556  						int sub_r;
e2b149cc4ba007 net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  557  						if (vary_r)
e2b149cc4ba007 net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  558  							sub_r = r >> (vary_r-1);
e2b149cc4ba007 net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  559  						else
e2b149cc4ba007 net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  560  							sub_r = 0;
66a0e2d579dbec net/ceph/crush/mapper.c Ilya Dryomov 2017-01-31  561  						if (crush_choose_firstn(
66a0e2d579dbec net/ceph/crush/mapper.c Ilya Dryomov 2017-01-31  562  							    map,
66a0e2d579dbec net/ceph/crush/mapper.c Ilya Dryomov 2017-01-31  563  							    work,
a1a31e734241ae fs/ceph/crush/mapper.c  Sage Weil    2010-06-24  564  							    map->buckets[-1-item],
b3b33b0e43323a net/ceph/crush/mapper.c Ilya Dryomov 2013-12-24  565  							    weight, weight_max,
dc6ae6d8e7726b net/ceph/crush/mapper.c Ilya Dryomov 2016-01-31  566  							    x, stable ? 1 : outpos+1, 0,
45002267e8d269 net/ceph/crush/mapper.c Ilya Dryomov 2015-04-14  567  							    out2, outpos, count,
2d8be0bc8bc2dc net/ceph/crush/mapper.c Ilya Dryomov 2013-12-24  568  							    recurse_tries, 0,
48a163dbb517eb net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  569  							    local_retries,
48a163dbb517eb net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  570  							    local_fallback_retries,
9fe07182827d99 net/ceph/crush/mapper.c Ilya Dryomov 2013-12-24  571  							    0,
e2b149cc4ba007 net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  572  							    vary_r,
dc6ae6d8e7726b net/ceph/crush/mapper.c Ilya Dryomov 2016-01-31  573  							    stable,
e2b149cc4ba007 net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  574  							    NULL,
069f3222ca96ac net/ceph/crush/mapper.c Ilya Dryomov 2017-06-22  575  							    sub_r,
069f3222ca96ac net/ceph/crush/mapper.c Ilya Dryomov 2017-06-22  576  							    choose_args) <= outpos)
a1a31e734241ae fs/ceph/crush/mapper.c  Sage Weil    2010-06-24  577  							/* didn't get leaf */
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  578  							reject = 1;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  579  					} else {
a1a31e734241ae fs/ceph/crush/mapper.c  Sage Weil    2010-06-24  580  						/* we already have a leaf! */
a1a31e734241ae fs/ceph/crush/mapper.c  Sage Weil    2010-06-24  581  						out2[outpos] = item;
a1a31e734241ae fs/ceph/crush/mapper.c  Sage Weil    2010-06-24  582  					}
a1a31e734241ae fs/ceph/crush/mapper.c  Sage Weil    2010-06-24  583  				}
a1a31e734241ae fs/ceph/crush/mapper.c  Sage Weil    2010-06-24  584  
98ba6af728de99 net/ceph/crush/mapper.c Ilya Dryomov 2017-02-16  585  				if (!reject && !collide) {
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  586  					/* out? */
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  587  					if (itemtype == 0)
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  588  						reject = is_out(map, weight,
b3b33b0e43323a net/ceph/crush/mapper.c Ilya Dryomov 2013-12-24  589  								weight_max,
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  590  								item, x);
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  591  				}
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  592  
b28813a61d6ffe fs/ceph/crush/mapper.c  Sage Weil    2009-10-07  593  reject:
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  594  				if (reject || collide) {
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  595  					ftotal++;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  596  					flocal++;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  597  
48a163dbb517eb net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  598  					if (collide && flocal <= local_retries)
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  599  						/* retry locally a few times */
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  600  						retry_bucket = 1;
48a163dbb517eb net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  601  					else if (local_fallback_retries > 0 &&
48a163dbb517eb net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  602  						 flocal <= in->size + local_fallback_retries)
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  603  						/* exhaustive bucket search */
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  604  						retry_bucket = 1;
48a163dbb517eb net/ceph/crush/mapper.c Ilya Dryomov 2014-03-19  605  					else if (ftotal < tries)
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  606  						/* then retry descent */
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  607  						retry_descent = 1;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  608  					else
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  609  						/* else give up */
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  610  						skip_rep = 1;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  611  					dprintk("  reject %d  collide %d  "
8b12d47b80c7a3 net/ceph/crush/mapper.c Sage Weil    2012-05-07  612  						"ftotal %u  flocal %u\n",
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  613  						reject, collide, ftotal,
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  614  						flocal);
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  615  				}
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  616  			} while (retry_bucket);
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  617  		} while (retry_descent);
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  618  
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  619  		if (skip_rep) {
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  620  			dprintk("skip rep\n");
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  621  			continue;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  622  		}
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  623  
a1a31e734241ae fs/ceph/crush/mapper.c  Sage Weil    2010-06-24  624  		dprintk("CHOOSE got %d\n", item);
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  625  		out[outpos] = item;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  626  		outpos++;
45002267e8d269 net/ceph/crush/mapper.c Ilya Dryomov 2015-04-14  627  		count--;
b459be739f97e2 net/ceph/crush/mapper.c Ilya Dryomov 2015-06-12  628  #ifndef __KERNEL__
b459be739f97e2 net/ceph/crush/mapper.c Ilya Dryomov 2015-06-12  629  		if (map->choose_tries && ftotal <= map->choose_total_tries)
b459be739f97e2 net/ceph/crush/mapper.c Ilya Dryomov 2015-06-12  630  			map->choose_tries[ftotal]++;
b459be739f97e2 net/ceph/crush/mapper.c Ilya Dryomov 2015-06-12  631  #endif
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  632  	}
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  633  
a1a31e734241ae fs/ceph/crush/mapper.c  Sage Weil    2010-06-24  634  	dprintk("CHOOSE returns %d\n", outpos);
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  635  	return outpos;
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  636  }
5ecc0a0f8128b1 fs/ceph/crush/mapper.c  Sage Weil    2009-10-06  637  

:::::: The code at line 466 was first introduced by commit
:::::: 5ecc0a0f8128b1876e8614638deaed49cc8b174c ceph: CRUSH mapping algorithm

:::::: TO: Sage Weil <sage@newdream.net>
:::::: CC: Sage Weil <sage@newdream.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
