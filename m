Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C302777BA92
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjHNNsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjHNNrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:47:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B0210C0;
        Mon, 14 Aug 2023 06:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692020857; x=1723556857;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ePs0UmKu1hjztHu9C+rXU1GIS085e6zZzqafi/eRvjY=;
  b=I3u3u8rF2XOgkDQG8Axf2J5d2IC3lHlexRkpxD5ffnXw6wYRY/ygU/Xw
   VtqA/YiMvPROdgbTGWdWXkPxFcYtYDZYXruvfV3Md1TfjjFi3JWD1WNGh
   vArX93SFOsfnAuct8M67NeW/E3FSHseL+FbpJS0exqLGybSzS8UuijtPo
   1sA00OXmFH/80Z8IfamqnkuC3ZqhJnVN8EC7+1wKm+8PkNl59or2sHRD0
   ww0c34tKD0tRtuMUxlXWDm9gSeXj/vcQJYS06aGvWHZJNoYHUEqpjn4dv
   5TFOFRO9oB/NNvn9Jxh6dL+NBOVcuFqKp2Q+2Ir5ZxKg1ZUaU6qmm/xG+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="372035493"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="372035493"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 06:47:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="847663850"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="847663850"
Received: from lkp-server02.sh.intel.com (HELO b5fb8d9e1ffc) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 14 Aug 2023 06:47:34 -0700
Received: from kbuild by b5fb8d9e1ffc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qVXuv-0000AZ-1r;
        Mon, 14 Aug 2023 13:47:33 +0000
Date:   Mon, 14 Aug 2023 21:47:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     linux@treblig.org, smfrench@gmail.com, dave.kleikamp@oracle.com,
        tom@talpey.com, pc@manguebit.com
Cc:     oe-kbuild-all@lists.linux.dev, linkinjeon@kernel.org,
        linux-cifs@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, krisman@collabora.com,
        "Dr. David Alan Gilbert" <linux@treblig.org>
Subject: Re: [PATCH v4 3/4] fs/smb/client: Use common code in client
Message-ID: <202308142118.G4M0uxEm-lkp@intel.com>
References: <20230813005344.112955-4-linux@treblig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813005344.112955-4-linux@treblig.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on cifs/for-next]
[also build test WARNING on kleikamp-shaggy/jfs-next linus/master v6.5-rc6 next-20230809]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/linux-treblig-org/fs-smb-Remove-unicode-lower-tables/20230813-085613
base:   git://git.samba.org/sfrench/cifs-2.6.git for-next
patch link:    https://lore.kernel.org/r/20230813005344.112955-4-linux%40treblig.org
patch subject: [PATCH v4 3/4] fs/smb/client: Use common code in client
config: i386-randconfig-i062-20230814 (https://download.01.org/0day-ci/archive/20230814/202308142118.G4M0uxEm-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230814/202308142118.G4M0uxEm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308142118.G4M0uxEm-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/smb/client/smb2pdu.c:2573:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] *ucs1 @@     got restricted __le16 [usertype] * @@
   fs/smb/client/smb2pdu.c:2573:27: sparse:     expected unsigned short [usertype] *ucs1
   fs/smb/client/smb2pdu.c:2573:27: sparse:     got restricted __le16 [usertype] *
>> fs/smb/client/smb2pdu.c:2573:38: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned short const [usertype] *ucs2 @@     got restricted __le16 const * @@
   fs/smb/client/smb2pdu.c:2573:38: sparse:     expected unsigned short const [usertype] *ucs2
   fs/smb/client/smb2pdu.c:2573:38: sparse:     got restricted __le16 const *
   fs/smb/client/smb2pdu.c:2574:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] *ucs1 @@     got restricted __le16 [usertype] * @@
   fs/smb/client/smb2pdu.c:2574:27: sparse:     expected unsigned short [usertype] *ucs1
   fs/smb/client/smb2pdu.c:2574:27: sparse:     got restricted __le16 [usertype] *
>> fs/smb/client/smb2pdu.c:2574:38: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned short const [usertype] *ucs2 @@     got restricted __le16 const [usertype] *path @@
   fs/smb/client/smb2pdu.c:2574:38: sparse:     expected unsigned short const [usertype] *ucs2
   fs/smb/client/smb2pdu.c:2574:38: sparse:     got restricted __le16 const [usertype] *path

vim +2573 fs/smb/client/smb2pdu.c

ff2a09e9196e2f fs/cifs/smb2pdu.c Steve French      2019-07-06  2535  
f0712928be1a66 fs/cifs/smb2pdu.c Aurelien Aptel    2017-02-22  2536  static int
f0712928be1a66 fs/cifs/smb2pdu.c Aurelien Aptel    2017-02-22  2537  alloc_path_with_tree_prefix(__le16 **out_path, int *out_size, int *out_len,
f0712928be1a66 fs/cifs/smb2pdu.c Aurelien Aptel    2017-02-22  2538  			    const char *treename, const __le16 *path)
f0712928be1a66 fs/cifs/smb2pdu.c Aurelien Aptel    2017-02-22  2539  {
f0712928be1a66 fs/cifs/smb2pdu.c Aurelien Aptel    2017-02-22  2540  	int treename_len, path_len;
f0712928be1a66 fs/cifs/smb2pdu.c Aurelien Aptel    2017-02-22  2541  	struct nls_table *cp;
f0712928be1a66 fs/cifs/smb2pdu.c Aurelien Aptel    2017-02-22  2542  	const __le16 sep[] = {cpu_to_le16('\\'), cpu_to_le16(0x0000)};
f0712928be1a66 fs/cifs/smb2pdu.c Aurelien Aptel    2017-02-22  2543  
f0712928be1a66 fs/cifs/smb2pdu.c Aurelien Aptel    2017-02-22  2544  	/*
f0712928be1a66 fs/cifs/smb2pdu.c Aurelien Aptel    2017-02-22  2545  	 * skip leading "\\"
f0712928be1a66 fs/cifs/smb2pdu.c Aurelien Aptel    2017-02-22  2546  	 */
f0712928be1a66 fs/cifs/smb2pdu.c Aurelien Aptel    2017-02-22  2547  	treename_len = strlen(treename);
f0712928be1a66 fs/cifs/smb2pdu.c Aurelien Aptel    2017-02-22  2548  	if (treename_len < 2 || !(treename[0] == '\\' && treename[1] == '\\'))
f0712928be1a66 fs/cifs/smb2pdu.c Aurelien Aptel    2017-02-22  2549  		return -EINVAL;
f0712928be1a66 fs/cifs/smb2pdu.c Aurelien Aptel    2017-02-22  2550  
f0712928be1a66 fs/cifs/smb2pdu.c Aurelien Aptel    2017-02-22  2551  	treename += 2;
f0712928be1a66 fs/cifs/smb2pdu.c Aurelien Aptel    2017-02-22  2552  	treename_len -= 2;
f0712928be1a66 fs/cifs/smb2pdu.c Aurelien Aptel    2017-02-22  2553  
f0712928be1a66 fs/cifs/smb2pdu.c Aurelien Aptel    2017-02-22  2554  	path_len = UniStrnlen((wchar_t *)path, PATH_MAX);
f0712928be1a66 fs/cifs/smb2pdu.c Aurelien Aptel    2017-02-22  2555  
a1d2eb51f0a33c fs/cifs/smb2pdu.c Paulo Alcantara   2022-08-19  2556  	/* make room for one path separator only if @path isn't empty */
a1d2eb51f0a33c fs/cifs/smb2pdu.c Paulo Alcantara   2022-08-19  2557  	*out_len = treename_len + (path[0] ? 1 : 0) + path_len;
f0712928be1a66 fs/cifs/smb2pdu.c Aurelien Aptel    2017-02-22  2558  
f0712928be1a66 fs/cifs/smb2pdu.c Aurelien Aptel    2017-02-22  2559  	/*
a1d2eb51f0a33c fs/cifs/smb2pdu.c Paulo Alcantara   2022-08-19  2560  	 * final path needs to be 8-byte aligned as specified in
a1d2eb51f0a33c fs/cifs/smb2pdu.c Paulo Alcantara   2022-08-19  2561  	 * MS-SMB2 2.2.13 SMB2 CREATE Request.
f0712928be1a66 fs/cifs/smb2pdu.c Aurelien Aptel    2017-02-22  2562  	 */
d7173623bf0b15 fs/cifs/smb2pdu.c Enzo Matsumiya    2022-10-12  2563  	*out_size = round_up(*out_len * sizeof(__le16), 8);
a1d2eb51f0a33c fs/cifs/smb2pdu.c Paulo Alcantara   2022-08-19  2564  	*out_path = kzalloc(*out_size + sizeof(__le16) /* null */, GFP_KERNEL);
f0712928be1a66 fs/cifs/smb2pdu.c Aurelien Aptel    2017-02-22  2565  	if (!*out_path)
f0712928be1a66 fs/cifs/smb2pdu.c Aurelien Aptel    2017-02-22  2566  		return -ENOMEM;
f0712928be1a66 fs/cifs/smb2pdu.c Aurelien Aptel    2017-02-22  2567  
f0712928be1a66 fs/cifs/smb2pdu.c Aurelien Aptel    2017-02-22  2568  	cp = load_nls_default();
f0712928be1a66 fs/cifs/smb2pdu.c Aurelien Aptel    2017-02-22  2569  	cifs_strtoUTF16(*out_path, treename, treename_len, cp);
7eacba3b00a3c3 fs/cifs/smb2pdu.c Eugene Korenevsky 2022-01-14  2570  
7eacba3b00a3c3 fs/cifs/smb2pdu.c Eugene Korenevsky 2022-01-14  2571  	/* Do not append the separator if the path is empty */
7eacba3b00a3c3 fs/cifs/smb2pdu.c Eugene Korenevsky 2022-01-14  2572  	if (path[0] != cpu_to_le16(0x0000)) {
f0712928be1a66 fs/cifs/smb2pdu.c Aurelien Aptel    2017-02-22 @2573  		UniStrcat(*out_path, sep);
f0712928be1a66 fs/cifs/smb2pdu.c Aurelien Aptel    2017-02-22 @2574  		UniStrcat(*out_path, path);
7eacba3b00a3c3 fs/cifs/smb2pdu.c Eugene Korenevsky 2022-01-14  2575  	}
7eacba3b00a3c3 fs/cifs/smb2pdu.c Eugene Korenevsky 2022-01-14  2576  
f0712928be1a66 fs/cifs/smb2pdu.c Aurelien Aptel    2017-02-22  2577  	unload_nls(cp);
f0712928be1a66 fs/cifs/smb2pdu.c Aurelien Aptel    2017-02-22  2578  
f0712928be1a66 fs/cifs/smb2pdu.c Aurelien Aptel    2017-02-22  2579  	return 0;
f0712928be1a66 fs/cifs/smb2pdu.c Aurelien Aptel    2017-02-22  2580  }
f0712928be1a66 fs/cifs/smb2pdu.c Aurelien Aptel    2017-02-22  2581  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
