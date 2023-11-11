Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E4B7E8B8F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 17:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjKKQTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 11:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjKKQTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 11:19:00 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D8A3A8D
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 08:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699719536; x=1731255536;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XYWbg6fZzOxfy3S5rtUnAAJ5CE2+wVd528m2ccKIWAE=;
  b=FTSXxGDjqgR3uec5A0qxdDuhV2UjHcgQ/dbfQCHIsM15LJHv3nm1lYyI
   JWfqFlj0k+0tOe5a44BdTdh2K1Pcca9bzSNx7A9dqaz4Vuwr4FWwFcKZ0
   vFzQC+S832Y1WezC1s1IhDAJwkylXF0iyEvTl/UdwaoDCJs9pLeQAvS1M
   c7OfJmRD/IkOnp8rDlit5r74cJmOU1Lc7nBJ1lppPou7XlU6+DRe8F9/N
   nKUrC1XD01BdnVm9TQtOErWl3vwDuVJ2RzzQLryhdOzi287iJV/aZw5hW
   sWoFni6vlXHRzDfYtAXvvXEGoi0ltH5BOzr3g31GmYmnTfHZXMuPblC/7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="456781840"
X-IronPort-AV: E=Sophos;i="6.03,295,1694761200"; 
   d="scan'208";a="456781840"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2023 08:18:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="907678118"
X-IronPort-AV: E=Sophos;i="6.03,295,1694761200"; 
   d="scan'208";a="907678118"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 11 Nov 2023 08:18:52 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1qh8-000AZq-1K;
        Sat, 11 Nov 2023 16:18:50 +0000
Date:   Sun, 12 Nov 2023 00:17:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Coly Li <colyli@suse.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: drivers/md/bcache/super.c:108:24: sparse: sparse: cast from
 restricted __le16
Message-ID: <202311120039.OLhMyC7g-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3ca112b71f35dd5d99fc4571a56b5fc6f0c15814
commit: 7c02b0055f774ed9afb6e1c7724f33bf148ffdc0 bcache: explicity type cast in bset_bkey_last()
date:   3 years, 9 months ago
config: i386-randconfig-062-20230914 (https://download.01.org/0day-ci/archive/20231112/202311120039.OLhMyC7g-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231112/202311120039.OLhMyC7g-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311120039.OLhMyC7g-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/md/bcache/super.c:108:24: sparse: sparse: cast from restricted __le16
   drivers/md/bcache/super.c:108:14: sparse: sparse: restricted __le64 degrades to integer
   drivers/md/bcache/super.c:235:21: sparse: sparse: cast from restricted __le16
   drivers/md/bcache/super.c:235:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le64 [usertype] csum @@     got unsigned long long @@
   drivers/md/bcache/super.c:235:19: sparse:     expected restricted __le64 [usertype] csum
   drivers/md/bcache/super.c:235:19: sparse:     got unsigned long long
   drivers/md/bcache/super.c: note: in included file (through drivers/md/bcache/bcache.h):
   include/uapi/linux/bcache.h:346:38: sparse: sparse: array of flexible structures
   drivers/md/bcache/super.c:572:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] prio @@     got restricted __le16 [usertype] @@
   drivers/md/bcache/super.c:572:33: sparse:     expected unsigned short [usertype] prio
   drivers/md/bcache/super.c:572:33: sparse:     got restricted __le16 [usertype]
   drivers/md/bcache/super.c:640:27: sparse: sparse: cast to restricted __le16
   drivers/md/bcache/super.c:742:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] invalidated @@     got restricted __le32 [usertype] @@
   drivers/md/bcache/super.c:742:32: sparse:     expected unsigned int [usertype] invalidated
   drivers/md/bcache/super.c:742:32: sparse:     got restricted __le32 [usertype]
   drivers/md/bcache/super.c:1102:26: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] rtime @@     got restricted __le32 [usertype] @@
   drivers/md/bcache/super.c:1102:26: sparse:     expected unsigned int [usertype] rtime
   drivers/md/bcache/super.c:1102:26: sparse:     got restricted __le32 [usertype]
   drivers/md/bcache/super.c:1146:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] invalidated @@     got restricted __le32 [usertype] @@
   drivers/md/bcache/super.c:1146:32: sparse:     expected unsigned int [usertype] invalidated
   drivers/md/bcache/super.c:1146:32: sparse:     got restricted __le32 [usertype]
   drivers/md/bcache/super.c:1496:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] last_reg @@     got restricted __le32 [usertype] @@
   drivers/md/bcache/super.c:1496:36: sparse:     expected unsigned int [usertype] last_reg
   drivers/md/bcache/super.c:1496:36: sparse:     got restricted __le32 [usertype]
   drivers/md/bcache/super.c: note: in included file (through drivers/md/bcache/bcache.h):
   drivers/md/bcache/bset.h:231:36: sparse: sparse: array of flexible structures

vim +108 drivers/md/bcache/super.c

cafe563591446c Kent Overstreet   2013-03-23   60  
cafe563591446c Kent Overstreet   2013-03-23   61  static const char *read_super(struct cache_sb *sb, struct block_device *bdev,
cfa0c56db9c087 Christoph Hellwig 2020-01-24   62  			      struct cache_sb_disk **res)
cafe563591446c Kent Overstreet   2013-03-23   63  {
cafe563591446c Kent Overstreet   2013-03-23   64  	const char *err;
a702a692cd7559 Christoph Hellwig 2020-01-24   65  	struct cache_sb_disk *s;
6321bef028de43 Christoph Hellwig 2020-01-24   66  	struct page *page;
6f10f7d1b02b1b Coly Li           2018-08-11   67  	unsigned int i;
cafe563591446c Kent Overstreet   2013-03-23   68  
6321bef028de43 Christoph Hellwig 2020-01-24   69  	page = read_cache_page_gfp(bdev->bd_inode->i_mapping,
6321bef028de43 Christoph Hellwig 2020-01-24   70  				   SB_OFFSET >> PAGE_SHIFT, GFP_KERNEL);
6321bef028de43 Christoph Hellwig 2020-01-24   71  	if (IS_ERR(page))
cafe563591446c Kent Overstreet   2013-03-23   72  		return "IO error";
6321bef028de43 Christoph Hellwig 2020-01-24   73  	s = page_address(page) + offset_in_page(SB_OFFSET);
cafe563591446c Kent Overstreet   2013-03-23   74  
cafe563591446c Kent Overstreet   2013-03-23   75  	sb->offset		= le64_to_cpu(s->offset);
cafe563591446c Kent Overstreet   2013-03-23   76  	sb->version		= le64_to_cpu(s->version);
cafe563591446c Kent Overstreet   2013-03-23   77  
cafe563591446c Kent Overstreet   2013-03-23   78  	memcpy(sb->magic,	s->magic, 16);
cafe563591446c Kent Overstreet   2013-03-23   79  	memcpy(sb->uuid,	s->uuid, 16);
cafe563591446c Kent Overstreet   2013-03-23   80  	memcpy(sb->set_uuid,	s->set_uuid, 16);
cafe563591446c Kent Overstreet   2013-03-23   81  	memcpy(sb->label,	s->label, SB_LABEL_SIZE);
cafe563591446c Kent Overstreet   2013-03-23   82  
cafe563591446c Kent Overstreet   2013-03-23   83  	sb->flags		= le64_to_cpu(s->flags);
cafe563591446c Kent Overstreet   2013-03-23   84  	sb->seq			= le64_to_cpu(s->seq);
cafe563591446c Kent Overstreet   2013-03-23   85  	sb->last_mount		= le32_to_cpu(s->last_mount);
cafe563591446c Kent Overstreet   2013-03-23   86  	sb->first_bucket	= le16_to_cpu(s->first_bucket);
cafe563591446c Kent Overstreet   2013-03-23   87  	sb->keys		= le16_to_cpu(s->keys);
cafe563591446c Kent Overstreet   2013-03-23   88  
cafe563591446c Kent Overstreet   2013-03-23   89  	for (i = 0; i < SB_JOURNAL_BUCKETS; i++)
cafe563591446c Kent Overstreet   2013-03-23   90  		sb->d[i] = le64_to_cpu(s->d[i]);
cafe563591446c Kent Overstreet   2013-03-23   91  
cafe563591446c Kent Overstreet   2013-03-23   92  	pr_debug("read sb version %llu, flags %llu, seq %llu, journal size %u",
cafe563591446c Kent Overstreet   2013-03-23   93  		 sb->version, sb->flags, sb->seq, sb->keys);
cafe563591446c Kent Overstreet   2013-03-23   94  
aaf8dbeab58657 Coly Li           2019-11-13   95  	err = "Not a bcache superblock (bad offset)";
cafe563591446c Kent Overstreet   2013-03-23   96  	if (sb->offset != SB_SECTOR)
cafe563591446c Kent Overstreet   2013-03-23   97  		goto err;
cafe563591446c Kent Overstreet   2013-03-23   98  
aaf8dbeab58657 Coly Li           2019-11-13   99  	err = "Not a bcache superblock (bad magic)";
cafe563591446c Kent Overstreet   2013-03-23  100  	if (memcmp(sb->magic, bcache_magic, 16))
cafe563591446c Kent Overstreet   2013-03-23  101  		goto err;
cafe563591446c Kent Overstreet   2013-03-23  102  
cafe563591446c Kent Overstreet   2013-03-23  103  	err = "Too many journal buckets";
cafe563591446c Kent Overstreet   2013-03-23  104  	if (sb->keys > SB_JOURNAL_BUCKETS)
cafe563591446c Kent Overstreet   2013-03-23  105  		goto err;
cafe563591446c Kent Overstreet   2013-03-23  106  
cafe563591446c Kent Overstreet   2013-03-23  107  	err = "Bad checksum";
cafe563591446c Kent Overstreet   2013-03-23 @108  	if (s->csum != csum_set(s))
cafe563591446c Kent Overstreet   2013-03-23  109  		goto err;
cafe563591446c Kent Overstreet   2013-03-23  110  
cafe563591446c Kent Overstreet   2013-03-23  111  	err = "Bad UUID";
169ef1cf6171d3 Kent Overstreet   2013-03-28  112  	if (bch_is_zero(sb->uuid, 16))
cafe563591446c Kent Overstreet   2013-03-23  113  		goto err;
cafe563591446c Kent Overstreet   2013-03-23  114  
8abb2a5dbadab9 Kent Overstreet   2013-04-23  115  	sb->block_size	= le16_to_cpu(s->block_size);
8abb2a5dbadab9 Kent Overstreet   2013-04-23  116  
8abb2a5dbadab9 Kent Overstreet   2013-04-23  117  	err = "Superblock block size smaller than device block size";
8abb2a5dbadab9 Kent Overstreet   2013-04-23  118  	if (sb->block_size << 9 < bdev_logical_block_size(bdev))
8abb2a5dbadab9 Kent Overstreet   2013-04-23  119  		goto err;
8abb2a5dbadab9 Kent Overstreet   2013-04-23  120  
2903381fce7100 Kent Overstreet   2013-04-11  121  	switch (sb->version) {
2903381fce7100 Kent Overstreet   2013-04-11  122  	case BCACHE_SB_VERSION_BDEV:
2903381fce7100 Kent Overstreet   2013-04-11  123  		sb->data_offset	= BDEV_DATA_START_DEFAULT;
2903381fce7100 Kent Overstreet   2013-04-11  124  		break;
2903381fce7100 Kent Overstreet   2013-04-11  125  	case BCACHE_SB_VERSION_BDEV_WITH_OFFSET:
2903381fce7100 Kent Overstreet   2013-04-11  126  		sb->data_offset	= le64_to_cpu(s->data_offset);
cafe563591446c Kent Overstreet   2013-03-23  127  
2903381fce7100 Kent Overstreet   2013-04-11  128  		err = "Bad data offset";
2903381fce7100 Kent Overstreet   2013-04-11  129  		if (sb->data_offset < BDEV_DATA_START_DEFAULT)
cafe563591446c Kent Overstreet   2013-03-23  130  			goto err;
cafe563591446c Kent Overstreet   2013-03-23  131  
2903381fce7100 Kent Overstreet   2013-04-11  132  		break;
2903381fce7100 Kent Overstreet   2013-04-11  133  	case BCACHE_SB_VERSION_CDEV:
2903381fce7100 Kent Overstreet   2013-04-11  134  	case BCACHE_SB_VERSION_CDEV_WITH_UUID:
2903381fce7100 Kent Overstreet   2013-04-11  135  		sb->nbuckets	= le64_to_cpu(s->nbuckets);
2903381fce7100 Kent Overstreet   2013-04-11  136  		sb->bucket_size	= le16_to_cpu(s->bucket_size);
2903381fce7100 Kent Overstreet   2013-04-11  137  
2903381fce7100 Kent Overstreet   2013-04-11  138  		sb->nr_in_set	= le16_to_cpu(s->nr_in_set);
2903381fce7100 Kent Overstreet   2013-04-11  139  		sb->nr_this_dev	= le16_to_cpu(s->nr_this_dev);
2903381fce7100 Kent Overstreet   2013-04-11  140  
cafe563591446c Kent Overstreet   2013-03-23  141  		err = "Too many buckets";
cafe563591446c Kent Overstreet   2013-03-23  142  		if (sb->nbuckets > LONG_MAX)
cafe563591446c Kent Overstreet   2013-03-23  143  			goto err;
cafe563591446c Kent Overstreet   2013-03-23  144  
cafe563591446c Kent Overstreet   2013-03-23  145  		err = "Not enough buckets";
cafe563591446c Kent Overstreet   2013-03-23  146  		if (sb->nbuckets < 1 << 7)
cafe563591446c Kent Overstreet   2013-03-23  147  			goto err;
cafe563591446c Kent Overstreet   2013-03-23  148  
2903381fce7100 Kent Overstreet   2013-04-11  149  		err = "Bad block/bucket size";
2903381fce7100 Kent Overstreet   2013-04-11  150  		if (!is_power_of_2(sb->block_size) ||
2903381fce7100 Kent Overstreet   2013-04-11  151  		    sb->block_size > PAGE_SECTORS ||
2903381fce7100 Kent Overstreet   2013-04-11  152  		    !is_power_of_2(sb->bucket_size) ||
2903381fce7100 Kent Overstreet   2013-04-11  153  		    sb->bucket_size < PAGE_SECTORS)
2903381fce7100 Kent Overstreet   2013-04-11  154  			goto err;
2903381fce7100 Kent Overstreet   2013-04-11  155  
cafe563591446c Kent Overstreet   2013-03-23  156  		err = "Invalid superblock: device too small";
b0d30981c05f32 Coly Li           2018-08-11  157  		if (get_capacity(bdev->bd_disk) <
b0d30981c05f32 Coly Li           2018-08-11  158  		    sb->bucket_size * sb->nbuckets)
cafe563591446c Kent Overstreet   2013-03-23  159  			goto err;
cafe563591446c Kent Overstreet   2013-03-23  160  
cafe563591446c Kent Overstreet   2013-03-23  161  		err = "Bad UUID";
169ef1cf6171d3 Kent Overstreet   2013-03-28  162  		if (bch_is_zero(sb->set_uuid, 16))
cafe563591446c Kent Overstreet   2013-03-23  163  			goto err;
cafe563591446c Kent Overstreet   2013-03-23  164  
cafe563591446c Kent Overstreet   2013-03-23  165  		err = "Bad cache device number in set";
cafe563591446c Kent Overstreet   2013-03-23  166  		if (!sb->nr_in_set ||
cafe563591446c Kent Overstreet   2013-03-23  167  		    sb->nr_in_set <= sb->nr_this_dev ||
cafe563591446c Kent Overstreet   2013-03-23  168  		    sb->nr_in_set > MAX_CACHES_PER_SET)
cafe563591446c Kent Overstreet   2013-03-23  169  			goto err;
cafe563591446c Kent Overstreet   2013-03-23  170  
cafe563591446c Kent Overstreet   2013-03-23  171  		err = "Journal buckets not sequential";
cafe563591446c Kent Overstreet   2013-03-23  172  		for (i = 0; i < sb->keys; i++)
cafe563591446c Kent Overstreet   2013-03-23  173  			if (sb->d[i] != sb->first_bucket + i)
cafe563591446c Kent Overstreet   2013-03-23  174  				goto err;
cafe563591446c Kent Overstreet   2013-03-23  175  
cafe563591446c Kent Overstreet   2013-03-23  176  		err = "Too many journal buckets";
cafe563591446c Kent Overstreet   2013-03-23  177  		if (sb->first_bucket + sb->keys > sb->nbuckets)
cafe563591446c Kent Overstreet   2013-03-23  178  			goto err;
cafe563591446c Kent Overstreet   2013-03-23  179  
cafe563591446c Kent Overstreet   2013-03-23  180  		err = "Invalid superblock: first bucket comes before end of super";
cafe563591446c Kent Overstreet   2013-03-23  181  		if (sb->first_bucket * sb->bucket_size < 16)
cafe563591446c Kent Overstreet   2013-03-23  182  			goto err;
2903381fce7100 Kent Overstreet   2013-04-11  183  
2903381fce7100 Kent Overstreet   2013-04-11  184  		break;
2903381fce7100 Kent Overstreet   2013-04-11  185  	default:
2903381fce7100 Kent Overstreet   2013-04-11  186  		err = "Unsupported superblock version";
2903381fce7100 Kent Overstreet   2013-04-11  187  		goto err;
2903381fce7100 Kent Overstreet   2013-04-11  188  	}
2903381fce7100 Kent Overstreet   2013-04-11  189  
75cbb3f1d84042 Arnd Bergmann     2018-07-26  190  	sb->last_mount = (u32)ktime_get_real_seconds();
cfa0c56db9c087 Christoph Hellwig 2020-01-24  191  	*res = s;
6321bef028de43 Christoph Hellwig 2020-01-24  192  	return NULL;
cafe563591446c Kent Overstreet   2013-03-23  193  err:
6321bef028de43 Christoph Hellwig 2020-01-24  194  	put_page(page);
cafe563591446c Kent Overstreet   2013-03-23  195  	return err;
cafe563591446c Kent Overstreet   2013-03-23  196  }
cafe563591446c Kent Overstreet   2013-03-23  197  

:::::: The code at line 108 was first introduced by commit
:::::: cafe563591446cf80bfbc2fe3bc72a2e36cf1060 bcache: A block layer cache

:::::: TO: Kent Overstreet <koverstreet@google.com>
:::::: CC: Kent Overstreet <koverstreet@google.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
