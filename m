Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E0B76151B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 13:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbjGYLZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 07:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234595AbjGYLZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 07:25:38 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4643D97
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 04:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690284337; x=1721820337;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zsKBvguu7F4LbLpeKE+gYQWsz/ltteBcqE7Bu11CArI=;
  b=GQ57IkJnXoa7A6hTqx+rzBgGdJH4xAMCh9WUzPW19jJG2HDuwUAAtXvB
   +vGk7m+L1xIysi+Rso11qdB+ikRTltZNFsIjwTFhHexuiHLDNB9n/AZ/u
   tPehBgVAkCq5fgEyelgotIYPggGwDxAnFeqnPIP7Z+qMFSftpqlnvhqTf
   NgtPPGavbnIuRMGU9aVp0wxiC0zDkQZOQZQg5OHamlaDUPwq2ytUY5VEK
   RMhMzp4JO5VhkOYr0x2MAOf/DKwXbXWDgd/MsgqMc2mTTifl0lCSCewPF
   /zZ9pkwJ5HtLOpl4Y77A4J3nzORTPugyOV42vPgr29Yh4gadU0EfCD9I6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="433943376"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="433943376"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 04:25:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="761174818"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="761174818"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 25 Jul 2023 04:25:34 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOGAX-000AZg-2N;
        Tue, 25 Jul 2023 11:25:33 +0000
Date:   Tue, 25 Jul 2023 19:24:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rohan McLure <rmclure@linux.ibm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: include/linux/seq_file.h:263:9: warning: 'strncpy' output may be
 truncated copying 4 bytes from a string of length 4
Message-ID: <202307251906.lXcLGKvG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rohan,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0b5547c51827e053cc754db47d3ec3e6c2c451d2
commit: 95567f46b4d20c047750a5e3029461afcdc67697 powerpc/{32,book3e}: kcsan: Extend KCSAN Support
date:   7 weeks ago
config: powerpc-randconfig-r015-20230725 (https://download.01.org/0day-ci/archive/20230725/202307251906.lXcLGKvG-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230725/202307251906.lXcLGKvG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307251906.lXcLGKvG-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/seq_file_net.h:5,
                    from include/net/net_namespace.h:193,
                    from include/linux/inet.h:42,
                    from fs/ocfs2/super.c:21:
   fs/ocfs2/super.c: In function 'ocfs2_show_options':
>> include/linux/seq_file.h:263:9: warning: 'strncpy' output may be truncated copying 4 bytes from a string of length 4 [-Wstringop-truncation]
     263 |         strncpy(val_buf, value, length);                \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/ocfs2/super.c:1518:17: note: in expansion of macro 'seq_show_option_n'
    1518 |                 seq_show_option_n(s, "cluster_stack", osb->osb_cluster_stack,
         |                 ^~~~~~~~~~~~~~~~~


vim +/strncpy +263 include/linux/seq_file.h

a068acf2ee7769 Kees Cook 2015-09-04  249  
a068acf2ee7769 Kees Cook 2015-09-04  250  /**
a068acf2ee7769 Kees Cook 2015-09-04  251   * seq_show_option_n - display mount options with appropriate escapes
a068acf2ee7769 Kees Cook 2015-09-04  252   *		       where @value must be a specific length.
a068acf2ee7769 Kees Cook 2015-09-04  253   * @m: the seq_file handle
a068acf2ee7769 Kees Cook 2015-09-04  254   * @name: the mount option name
a068acf2ee7769 Kees Cook 2015-09-04  255   * @value: the mount option name's value, cannot be NULL
a068acf2ee7769 Kees Cook 2015-09-04  256   * @length: the length of @value to display
a068acf2ee7769 Kees Cook 2015-09-04  257   *
a068acf2ee7769 Kees Cook 2015-09-04  258   * This is a macro since this uses "length" to define the size of the
a068acf2ee7769 Kees Cook 2015-09-04  259   * stack buffer.
a068acf2ee7769 Kees Cook 2015-09-04  260   */
a068acf2ee7769 Kees Cook 2015-09-04  261  #define seq_show_option_n(m, name, value, length) {	\
a068acf2ee7769 Kees Cook 2015-09-04  262  	char val_buf[length + 1];			\
a068acf2ee7769 Kees Cook 2015-09-04 @263  	strncpy(val_buf, value, length);		\
a068acf2ee7769 Kees Cook 2015-09-04  264  	val_buf[length] = '\0';				\
a068acf2ee7769 Kees Cook 2015-09-04  265  	seq_show_option(m, name, val_buf);		\
a068acf2ee7769 Kees Cook 2015-09-04  266  }
a068acf2ee7769 Kees Cook 2015-09-04  267  

:::::: The code at line 263 was first introduced by commit
:::::: a068acf2ee77693e0bf39d6e07139ba704f461c3 fs: create and use seq_show_option for escaping

:::::: TO: Kees Cook <keescook@chromium.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
