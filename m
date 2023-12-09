Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9207980B387
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 11:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjLIJ7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 04:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLIJ7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 04:59:04 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1257A10C9
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 01:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702115950; x=1733651950;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=4FK9R1VtgyPNkjyxxodYQfSSTxjspsK0p/etRR2j5g0=;
  b=MZU70+7KBkdLge2QVijgrQefW6uE4tU5pOr5HHrF+ebJcSA2iNpWve5D
   piIBVOTGyBNEzD8mdCixQPRlNDxJdYl+8hrEY+YEdr46D1oeG4CSFEev6
   bxntGkpBhpglOHcGhekeDHtxqzFFT8IaFKWHTPQs6xom+80KqUzD/W/yf
   B6LMx3zVJU1HRqqiYb/3ytwtHKEIlJXeI9L2aJzWrnrY+6IrJwKHacOAv
   4ECK9ZqycXykWFem14PZbYIQIlEmkBHO467VyxZWtq8OyyG61DvZIYicw
   ZLlcGWWxpa6kZGqE6Wg0XmA0VHb6DeZioe3LuMYzbo6pFoK6dT+na5maw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="1628809"
X-IronPort-AV: E=Sophos;i="6.04,263,1695711600"; 
   d="scan'208";a="1628809"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2023 01:59:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="916225204"
X-IronPort-AV: E=Sophos;i="6.04,263,1695711600"; 
   d="scan'208";a="916225204"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 09 Dec 2023 01:59:08 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rBu6y-000FAN-0k;
        Sat, 09 Dec 2023 09:59:04 +0000
Date:   Sat, 9 Dec 2023 17:58:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: fs/hfsplus/wrapper.c:49: warning: Function parameter or member 'opf'
 not described in 'hfsplus_submit_bio'
Message-ID: <202312091714.E7w1bZbg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f2e8a57ee9036c7d5443382b6c3c09b51a92ec7e
commit: c85f99929ea66c357199b6a3fe958745e1190f5a fs/hfsplus: Use the enum req_op and blk_opf_t types
date:   1 year, 5 months ago
config: x86_64-buildonly-randconfig-004-20231010 (https://download.01.org/0day-ci/archive/20231209/202312091714.E7w1bZbg-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231209/202312091714.E7w1bZbg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312091714.E7w1bZbg-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/hfsplus/wrapper.c:49: warning: Function parameter or member 'opf' not described in 'hfsplus_submit_bio'
>> fs/hfsplus/wrapper.c:49: warning: Excess function parameter 'op' description in 'hfsplus_submit_bio'
>> fs/hfsplus/wrapper.c:49: warning: Excess function parameter 'op_flags' description in 'hfsplus_submit_bio'


vim +49 fs/hfsplus/wrapper.c

^1da177e4c3f41 Linus Torvalds    2005-04-16  26  
915ab236d3c491 Fabian Frederick  2014-06-06  27  /**
915ab236d3c491 Fabian Frederick  2014-06-06  28   * hfsplus_submit_bio - Perform block I/O
6596528e391ad9 Seth Forshee      2011-07-18  29   * @sb: super block of volume for I/O
6596528e391ad9 Seth Forshee      2011-07-18  30   * @sector: block to read or write, for blocks of HFSPLUS_SECTOR_SIZE bytes
6596528e391ad9 Seth Forshee      2011-07-18  31   * @buf: buffer for I/O
6596528e391ad9 Seth Forshee      2011-07-18  32   * @data: output pointer for location of requested data
67ed25961c428a Mike Christie     2016-06-05  33   * @op: direction of I/O
67ed25961c428a Mike Christie     2016-06-05  34   * @op_flags: request op flags
6596528e391ad9 Seth Forshee      2011-07-18  35   *
6596528e391ad9 Seth Forshee      2011-07-18  36   * The unit of I/O is hfsplus_min_io_size(sb), which may be bigger than
6596528e391ad9 Seth Forshee      2011-07-18  37   * HFSPLUS_SECTOR_SIZE, and @buf must be sized accordingly. On reads
6596528e391ad9 Seth Forshee      2011-07-18  38   * @data will return a pointer to the start of the requested sector,
6596528e391ad9 Seth Forshee      2011-07-18  39   * which may not be the same location as @buf.
6596528e391ad9 Seth Forshee      2011-07-18  40   *
6596528e391ad9 Seth Forshee      2011-07-18  41   * If @sector is not aligned to the bdev logical block size it will
6596528e391ad9 Seth Forshee      2011-07-18  42   * be rounded down. For writes this means that @buf should contain data
6596528e391ad9 Seth Forshee      2011-07-18  43   * that starts at the rounded-down address. As long as the data was
6596528e391ad9 Seth Forshee      2011-07-18  44   * read using hfsplus_submit_bio() and the same buffer is used things
6596528e391ad9 Seth Forshee      2011-07-18  45   * will work correctly.
6596528e391ad9 Seth Forshee      2011-07-18  46   */
6596528e391ad9 Seth Forshee      2011-07-18  47  int hfsplus_submit_bio(struct super_block *sb, sector_t sector,
c85f99929ea66c Bart Van Assche   2022-07-14  48  		       void *buf, void **data, blk_opf_t opf)
52399b171dfaea Christoph Hellwig 2010-11-23 @49  {
c85f99929ea66c Bart Van Assche   2022-07-14  50  	const enum req_op op = opf & REQ_OP_MASK;
52399b171dfaea Christoph Hellwig 2010-11-23  51  	struct bio *bio;
50176ddefa4a94 Seth Forshee      2011-05-31  52  	int ret = 0;
a6dc8c04218eb7 Janne Kalliomäki  2012-06-17  53  	u64 io_size;
6596528e391ad9 Seth Forshee      2011-07-18  54  	loff_t start;
6596528e391ad9 Seth Forshee      2011-07-18  55  	int offset;
6596528e391ad9 Seth Forshee      2011-07-18  56  
6596528e391ad9 Seth Forshee      2011-07-18  57  	/*
6596528e391ad9 Seth Forshee      2011-07-18  58  	 * Align sector to hardware sector size and find offset. We
6596528e391ad9 Seth Forshee      2011-07-18  59  	 * assume that io_size is a power of two, which _should_
6596528e391ad9 Seth Forshee      2011-07-18  60  	 * be true.
6596528e391ad9 Seth Forshee      2011-07-18  61  	 */
6596528e391ad9 Seth Forshee      2011-07-18  62  	io_size = hfsplus_min_io_size(sb);
6596528e391ad9 Seth Forshee      2011-07-18  63  	start = (loff_t)sector << HFSPLUS_SECTOR_SHIFT;
6596528e391ad9 Seth Forshee      2011-07-18  64  	offset = start & (io_size - 1);
6596528e391ad9 Seth Forshee      2011-07-18  65  	sector &= ~((io_size >> HFSPLUS_SECTOR_SHIFT) - 1);
52399b171dfaea Christoph Hellwig 2010-11-23  66  
c85f99929ea66c Bart Van Assche   2022-07-14  67  	bio = bio_alloc(sb->s_bdev, 1, opf, GFP_NOIO);
4f024f3797c43c Kent Overstreet   2013-10-11  68  	bio->bi_iter.bi_sector = sector;
52399b171dfaea Christoph Hellwig 2010-11-23  69  
c85f99929ea66c Bart Van Assche   2022-07-14  70  	if (op != REQ_OP_WRITE && data)
6596528e391ad9 Seth Forshee      2011-07-18  71  		*data = (u8 *)buf + offset;
6596528e391ad9 Seth Forshee      2011-07-18  72  
6596528e391ad9 Seth Forshee      2011-07-18  73  	while (io_size > 0) {
6596528e391ad9 Seth Forshee      2011-07-18  74  		unsigned int page_offset = offset_in_page(buf);
6596528e391ad9 Seth Forshee      2011-07-18  75  		unsigned int len = min_t(unsigned int, PAGE_SIZE - page_offset,
6596528e391ad9 Seth Forshee      2011-07-18  76  					 io_size);
6596528e391ad9 Seth Forshee      2011-07-18  77  
6596528e391ad9 Seth Forshee      2011-07-18  78  		ret = bio_add_page(bio, virt_to_page(buf), len, page_offset);
6596528e391ad9 Seth Forshee      2011-07-18  79  		if (ret != len) {
6596528e391ad9 Seth Forshee      2011-07-18  80  			ret = -EIO;
6596528e391ad9 Seth Forshee      2011-07-18  81  			goto out;
6596528e391ad9 Seth Forshee      2011-07-18  82  		}
6596528e391ad9 Seth Forshee      2011-07-18  83  		io_size -= len;
6596528e391ad9 Seth Forshee      2011-07-18  84  		buf = (u8 *)buf + len;
6596528e391ad9 Seth Forshee      2011-07-18  85  	}
52399b171dfaea Christoph Hellwig 2010-11-23  86  
4e49ea4a3d2763 Mike Christie     2016-06-05  87  	ret = submit_bio_wait(bio);
6596528e391ad9 Seth Forshee      2011-07-18  88  out:
50176ddefa4a94 Seth Forshee      2011-05-31  89  	bio_put(bio);
6596528e391ad9 Seth Forshee      2011-07-18  90  	return ret < 0 ? ret : 0;
52399b171dfaea Christoph Hellwig 2010-11-23  91  }
52399b171dfaea Christoph Hellwig 2010-11-23  92  

:::::: The code at line 49 was first introduced by commit
:::::: 52399b171dfaea02b6944cd6feba49b624147126 hfsplus: use raw bio access for the volume headers

:::::: TO: Christoph Hellwig <hch@tuxera.com>
:::::: CC: Christoph Hellwig <hch@lst.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
