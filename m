Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D2B7E8821
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 03:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344561AbjKKCPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 21:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKKCPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 21:15:20 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359EA3C0C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 18:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699668917; x=1731204917;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X5ZgYENX2ryWN2rp/ksyXUh7LLw2nbyq8iiQXJOMI0Q=;
  b=WTkKqwO/XT/COjWMb6TvAMxQReHLTOx/NzcsDrzVl10bNPLkMfjMU0YP
   FJarK+fYEXNtzzBzVKQfpTIgZiHxUbz2Bf1WJdn4h2XM8DcXWiX6lNDZl
   AZSOlZHbqTxX8oxSvf6lR7ep3PP+jIRhFOYQ0Skz72VtWvz5aOpMDY97h
   mYUxX7l8RsFgpGM8WA6Fh+gJY0cXWUJYOBGGZRkOIvMAz4+iRoGFlQHE0
   By7vyT83iuGH8JFN+bGI5unwzc6ZBX2ox6JQHLHkPeheGG3H2Llg+GbmN
   zE0iqYAu7tUe23VDGS1PZQgLHCCUstk9W0F1G+HLHEqSnVYasu2Lkr31G
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="11801997"
X-IronPort-AV: E=Sophos;i="6.03,293,1694761200"; 
   d="scan'208";a="11801997"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 18:15:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="798721003"
X-IronPort-AV: E=Sophos;i="6.03,293,1694761200"; 
   d="scan'208";a="798721003"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 10 Nov 2023 18:15:14 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1dWi-000A8w-0o;
        Sat, 11 Nov 2023 02:15:12 +0000
Date:   Sat, 11 Nov 2023 10:13:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     WoZ1zh1 <wozizhi@huawei.com>, xiang@kernel.org, chao@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, wozizhi@huawei.com,
        yangerkun@huawei.com
Subject: Re: [PATCH -next V2] erofs: code clean up for function
 erofs_read_inode()
Message-ID: <202311111038.Atx87gVV-lkp@intel.com>
References: <20231109194821.1719430-1-wozizhi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109194821.1719430-1-wozizhi@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi WoZ1zh1,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20231109]

url:    https://github.com/intel-lab-lkp/linux/commits/WoZ1zh1/erofs-code-clean-up-for-function-erofs_read_inode/20231110-033810
base:   next-20231109
patch link:    https://lore.kernel.org/r/20231109194821.1719430-1-wozizhi%40huawei.com
patch subject: [PATCH -next V2] erofs: code clean up for function erofs_read_inode()
config: i386-buildonly-randconfig-004-20231111 (https://download.01.org/0day-ci/archive/20231111/202311111038.Atx87gVV-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231111/202311111038.Atx87gVV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311111038.Atx87gVV-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/erofs/inode.c: In function 'erofs_read_inode':
>> fs/erofs/inode.c:55:3: error: a label can only be part of a statement and a declaration is not a statement
      55 |   struct erofs_inode_extended *die, *copied = NULL;
         |   ^~~~~~


vim +55 fs/erofs/inode.c

    10	
    11	static void *erofs_read_inode(struct erofs_buf *buf,
    12				      struct inode *inode, unsigned int *ofs)
    13	{
    14		struct super_block *sb = inode->i_sb;
    15		struct erofs_sb_info *sbi = EROFS_SB(sb);
    16		struct erofs_inode *vi = EROFS_I(inode);
    17		const erofs_off_t inode_loc = erofs_iloc(inode);
    18	
    19		erofs_blk_t blkaddr, nblks = 0;
    20		void *kaddr;
    21		struct erofs_inode_compact *dic;
    22		unsigned int ifmt;
    23		int err;
    24	
    25		blkaddr = erofs_blknr(sb, inode_loc);
    26		*ofs = erofs_blkoff(sb, inode_loc);
    27	
    28		kaddr = erofs_read_metabuf(buf, sb, blkaddr, EROFS_KMAP);
    29		if (IS_ERR(kaddr)) {
    30			erofs_err(sb, "failed to get inode (nid: %llu) page, err %ld",
    31				  vi->nid, PTR_ERR(kaddr));
    32			return kaddr;
    33		}
    34	
    35		dic = kaddr + *ofs;
    36		ifmt = le16_to_cpu(dic->i_format);
    37	
    38		if (ifmt & ~EROFS_I_ALL) {
    39			erofs_err(inode->i_sb, "unsupported i_format %u of nid %llu",
    40				  ifmt, vi->nid);
    41			err = -EOPNOTSUPP;
    42			goto err_out;
    43		}
    44	
    45		vi->datalayout = erofs_inode_datalayout(ifmt);
    46		if (vi->datalayout >= EROFS_INODE_DATALAYOUT_MAX) {
    47			erofs_err(inode->i_sb, "unsupported datalayout %u of nid %llu",
    48				  vi->datalayout, vi->nid);
    49			err = -EOPNOTSUPP;
    50			goto err_out;
    51		}
    52	
    53		switch (erofs_inode_version(ifmt)) {
    54		case EROFS_INODE_LAYOUT_EXTENDED:
  > 55			struct erofs_inode_extended *die, *copied = NULL;
    56	
    57			vi->inode_isize = sizeof(struct erofs_inode_extended);
    58			/* check if the extended inode acrosses block boundary */
    59			if (*ofs + vi->inode_isize <= sb->s_blocksize) {
    60				*ofs += vi->inode_isize;
    61				die = (struct erofs_inode_extended *)dic;
    62			} else {
    63				const unsigned int gotten = sb->s_blocksize - *ofs;
    64	
    65				copied = kmalloc(vi->inode_isize, GFP_NOFS);
    66				if (!copied) {
    67					err = -ENOMEM;
    68					goto err_out;
    69				}
    70				memcpy(copied, dic, gotten);
    71				kaddr = erofs_read_metabuf(buf, sb, blkaddr + 1,
    72							   EROFS_KMAP);
    73				if (IS_ERR(kaddr)) {
    74					erofs_err(sb, "failed to get inode payload block (nid: %llu), err %ld",
    75						  vi->nid, PTR_ERR(kaddr));
    76					kfree(copied);
    77					return kaddr;
    78				}
    79				*ofs = vi->inode_isize - gotten;
    80				memcpy((u8 *)copied + gotten, kaddr, *ofs);
    81				die = copied;
    82			}
    83			vi->xattr_isize = erofs_xattr_ibody_size(die->i_xattr_icount);
    84	
    85			inode->i_mode = le16_to_cpu(die->i_mode);
    86			switch (inode->i_mode & S_IFMT) {
    87			case S_IFREG:
    88			case S_IFDIR:
    89			case S_IFLNK:
    90				vi->raw_blkaddr = le32_to_cpu(die->i_u.raw_blkaddr);
    91				break;
    92			case S_IFCHR:
    93			case S_IFBLK:
    94				inode->i_rdev =
    95					new_decode_dev(le32_to_cpu(die->i_u.rdev));
    96				break;
    97			case S_IFIFO:
    98			case S_IFSOCK:
    99				inode->i_rdev = 0;
   100				break;
   101			default:
   102				kfree(copied);
   103				goto bogusimode;
   104			}
   105			i_uid_write(inode, le32_to_cpu(die->i_uid));
   106			i_gid_write(inode, le32_to_cpu(die->i_gid));
   107			set_nlink(inode, le32_to_cpu(die->i_nlink));
   108	
   109			/* extended inode has its own timestamp */
   110			inode_set_ctime(inode, le64_to_cpu(die->i_mtime),
   111					le32_to_cpu(die->i_mtime_nsec));
   112	
   113			inode->i_size = le64_to_cpu(die->i_size);
   114	
   115			/* total blocks for compressed files */
   116			if (erofs_inode_is_data_compressed(vi->datalayout))
   117				nblks = le32_to_cpu(die->i_u.compressed_blocks);
   118			else if (vi->datalayout == EROFS_INODE_CHUNK_BASED)
   119				/* fill chunked inode summary info */
   120				vi->chunkformat = le16_to_cpu(die->i_u.c.format);
   121			kfree(copied);
   122			break;
   123		case EROFS_INODE_LAYOUT_COMPACT:
   124			vi->inode_isize = sizeof(struct erofs_inode_compact);
   125			*ofs += vi->inode_isize;
   126			vi->xattr_isize = erofs_xattr_ibody_size(dic->i_xattr_icount);
   127	
   128			inode->i_mode = le16_to_cpu(dic->i_mode);
   129			switch (inode->i_mode & S_IFMT) {
   130			case S_IFREG:
   131			case S_IFDIR:
   132			case S_IFLNK:
   133				vi->raw_blkaddr = le32_to_cpu(dic->i_u.raw_blkaddr);
   134				break;
   135			case S_IFCHR:
   136			case S_IFBLK:
   137				inode->i_rdev =
   138					new_decode_dev(le32_to_cpu(dic->i_u.rdev));
   139				break;
   140			case S_IFIFO:
   141			case S_IFSOCK:
   142				inode->i_rdev = 0;
   143				break;
   144			default:
   145				goto bogusimode;
   146			}
   147			i_uid_write(inode, le16_to_cpu(dic->i_uid));
   148			i_gid_write(inode, le16_to_cpu(dic->i_gid));
   149			set_nlink(inode, le16_to_cpu(dic->i_nlink));
   150	
   151			/* use build time for compact inodes */
   152			inode_set_ctime(inode, sbi->build_time, sbi->build_time_nsec);
   153	
   154			inode->i_size = le32_to_cpu(dic->i_size);
   155			if (erofs_inode_is_data_compressed(vi->datalayout))
   156				nblks = le32_to_cpu(dic->i_u.compressed_blocks);
   157			else if (vi->datalayout == EROFS_INODE_CHUNK_BASED)
   158				vi->chunkformat = le16_to_cpu(dic->i_u.c.format);
   159			break;
   160		default:
   161			erofs_err(inode->i_sb,
   162				  "unsupported on-disk inode version %u of nid %llu",
   163				  erofs_inode_version(ifmt), vi->nid);
   164			err = -EOPNOTSUPP;
   165			goto err_out;
   166		}
   167	
   168		if (vi->datalayout == EROFS_INODE_CHUNK_BASED) {
   169			if (vi->chunkformat & ~EROFS_CHUNK_FORMAT_ALL) {
   170				erofs_err(inode->i_sb,
   171					  "unsupported chunk format %x of nid %llu",
   172					  vi->chunkformat, vi->nid);
   173				err = -EOPNOTSUPP;
   174				goto err_out;
   175			}
   176			vi->chunkbits = sb->s_blocksize_bits +
   177				(vi->chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);
   178		}
   179		inode_set_mtime_to_ts(inode,
   180				      inode_set_atime_to_ts(inode, inode_get_ctime(inode)));
   181	
   182		inode->i_flags &= ~S_DAX;
   183		if (test_opt(&sbi->opt, DAX_ALWAYS) && S_ISREG(inode->i_mode) &&
   184		    (vi->datalayout == EROFS_INODE_FLAT_PLAIN ||
   185		     vi->datalayout == EROFS_INODE_CHUNK_BASED))
   186			inode->i_flags |= S_DAX;
   187	
   188		if (!nblks)
   189			/* measure inode.i_blocks as generic filesystems */
   190			inode->i_blocks = round_up(inode->i_size, sb->s_blocksize) >> 9;
   191		else
   192			inode->i_blocks = nblks << (sb->s_blocksize_bits - 9);
   193		return kaddr;
   194	
   195	bogusimode:
   196		erofs_err(inode->i_sb, "bogus i_mode (%o) @ nid %llu",
   197			  inode->i_mode, vi->nid);
   198		err = -EFSCORRUPTED;
   199	err_out:
   200		DBG_BUGON(1);
   201		erofs_put_metabuf(buf);
   202		return ERR_PTR(err);
   203	}
   204	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
