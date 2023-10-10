Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B777BF97E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjJJLSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjJJLSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:18:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2979E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 04:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696936679; x=1728472679;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ym95X1Tjg2BaJQbZsvDu1zdQj0jihFatQU5SUoVgJXE=;
  b=WYv8fxWHJZlQu4704C3kWBM3Jut3GPFIX0cRd9xHRbkSUh3i13qVjSo9
   hXwOpcbnff6UyARUJEGgPccmDa0Py5/+HzEDfp4rHS4z07z216YwflmDI
   lwxRkssJezN4eyTQJg1Y4Izsh3U3ZfliP+UZV7TgGIXT2iInWxjB/cuXE
   uh/kQ9cYd8o0DhS5fZGpIxQjfvyso3lKYLfuNxNHa3H1Qz4wLBzBJK57N
   widzFQIj0t9jCvvsdDk2Qungj0vQyEBwImGFRHFeKBH48ZUZbyl/AadhK
   r4InZTrDhVn1VOpTVQs/YuceApsAb8t/4naQVQ0mTBxwW4gpTnpcLXk8E
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="363716109"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="363716109"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 04:17:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="1084736245"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="1084736245"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 10 Oct 2023 04:17:58 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qqAkL-0000JR-0G;
        Tue, 10 Oct 2023 11:17:53 +0000
Date:   Tue, 10 Oct 2023 19:16:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Olaf Hering <olaf@aepfle.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: fs/afs/dir.c:50:1: error: no return statement in function returning
 non-void
Message-ID: <202310101901.Q5SauZ72-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   94f6f0550c625fab1f373bb86a6669b45e9748b3
commit: 172aad81a882443eefe1bd860c4eddc81b14dd5b kbuild: enforce -Werror=return-type
date:   3 years ago
config: s390-randconfig-r033-20230512 (https://download.01.org/0day-ci/archive/20231010/202310101901.Q5SauZ72-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231010/202310101901.Q5SauZ72-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310101901.Q5SauZ72-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/afs/dir.c: In function 'afs_dir_set_page_dirty':
>> fs/afs/dir.c:50:1: error: no return statement in function returning non-void [-Werror=return-type]
      50 | }
         | ^
   cc1: some warnings being treated as errors


vim +50 fs/afs/dir.c

^1da177e4c3f415 Linus Torvalds 2005-04-16  19  
260a980317dac80 David Howells  2007-04-26  20  static struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
00cd8dd3bf95f2c Al Viro        2012-06-10  21  				 unsigned int flags);
^1da177e4c3f415 Linus Torvalds 2005-04-16  22  static int afs_dir_open(struct inode *inode, struct file *file);
1bbae9f81860995 Al Viro        2013-05-22  23  static int afs_readdir(struct file *file, struct dir_context *ctx);
0b728e1911cbe6e Al Viro        2012-06-10  24  static int afs_d_revalidate(struct dentry *dentry, unsigned int flags);
fe15ce446beb3a3 Nick Piggin    2011-01-07  25  static int afs_d_delete(const struct dentry *dentry);
79ddbfa500b37a9 David Howells  2019-04-25  26  static void afs_d_iput(struct dentry *dentry, struct inode *inode);
5cf9dd55a0ec264 David Howells  2018-04-09  27  static int afs_lookup_one_filldir(struct dir_context *ctx, const char *name, int nlen,
5cf9dd55a0ec264 David Howells  2018-04-09  28  				  loff_t fpos, u64 ino, unsigned dtype);
ac7576f4b1da8c9 Miklos Szeredi 2014-10-30  29  static int afs_lookup_filldir(struct dir_context *ctx, const char *name, int nlen,
afefdbb28a0a2af David Howells  2006-10-03  30  			      loff_t fpos, u64 ino, unsigned dtype);
4acdaf27ebe2034 Al Viro        2011-07-26  31  static int afs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
ebfc3b49a7ac259 Al Viro        2012-06-10  32  		      bool excl);
18bb1db3e7607e4 Al Viro        2011-07-26  33  static int afs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode);
260a980317dac80 David Howells  2007-04-26  34  static int afs_rmdir(struct inode *dir, struct dentry *dentry);
260a980317dac80 David Howells  2007-04-26  35  static int afs_unlink(struct inode *dir, struct dentry *dentry);
260a980317dac80 David Howells  2007-04-26  36  static int afs_link(struct dentry *from, struct inode *dir,
260a980317dac80 David Howells  2007-04-26  37  		    struct dentry *dentry);
260a980317dac80 David Howells  2007-04-26  38  static int afs_symlink(struct inode *dir, struct dentry *dentry,
260a980317dac80 David Howells  2007-04-26  39  		       const char *content);
260a980317dac80 David Howells  2007-04-26  40  static int afs_rename(struct inode *old_dir, struct dentry *old_dentry,
1cd66c93ba8cdb8 Miklos Szeredi 2016-09-27  41  		      struct inode *new_dir, struct dentry *new_dentry,
1cd66c93ba8cdb8 Miklos Szeredi 2016-09-27  42  		      unsigned int flags);
f3ddee8dc4e2cff David Howells  2018-04-06  43  static int afs_dir_releasepage(struct page *page, gfp_t gfp_flags);
f3ddee8dc4e2cff David Howells  2018-04-06  44  static void afs_dir_invalidatepage(struct page *page, unsigned int offset,
f3ddee8dc4e2cff David Howells  2018-04-06  45  				   unsigned int length);
f3ddee8dc4e2cff David Howells  2018-04-06  46  
f3ddee8dc4e2cff David Howells  2018-04-06  47  static int afs_dir_set_page_dirty(struct page *page)
f3ddee8dc4e2cff David Howells  2018-04-06  48  {
f3ddee8dc4e2cff David Howells  2018-04-06  49  	BUG(); /* This should never happen. */
f3ddee8dc4e2cff David Howells  2018-04-06 @50  }
^1da177e4c3f415 Linus Torvalds 2005-04-16  51  

:::::: The code at line 50 was first introduced by commit
:::::: f3ddee8dc4e2cff37936afbeed2fdaa95b7fb7c6 afs: Fix directory handling

:::::: TO: David Howells <dhowells@redhat.com>
:::::: CC: David Howells <dhowells@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
