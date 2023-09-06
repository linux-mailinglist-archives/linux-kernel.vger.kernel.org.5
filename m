Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F24793326
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 03:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239807AbjIFBGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 21:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjIFBGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 21:06:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D60CEE
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 18:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693962379; x=1725498379;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8bss4pbHqG1CAlYmwdVWUjsywuELsy7Bk4uND0wb1M8=;
  b=CHuBRBwRDpU67zeeVIv7OAnICx1FKB2uphE+n9qDPsSFpPxQrjtlWCeJ
   f85lt0Yxp+m/mIH7jr/u3dH3JFVRbnhRNPHNjBBamdvjf1pYrYIMVZ2wZ
   f/c+UTyc3eGwcIQuyVbL42VKiyV4GvmMphqG5kq7IuUOt5fOMyED17JPr
   R/ZV2CazitnvA7YX67p+CSTerDfM0lhcZ5MnInIGIr6BsRm57JzECytmn
   gUH040Lf2SnLPU9j2rDm1Gxb8bQC//nTuLPkCemObL0vwrxn5YIFummkh
   ys3rTeYgz3cO2Mc9zAXmlpJcX4xGJ/qWOFIEC3gXxVt3O/wj1LyiYPS4d
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="379656474"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="379656474"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 18:06:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="1072180441"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="1072180441"
Received: from lkp-server02.sh.intel.com (HELO e0b2ea88afd5) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 05 Sep 2023 18:06:07 -0700
Received: from kbuild by e0b2ea88afd5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qdgzd-0002I3-2E;
        Wed, 06 Sep 2023 01:06:05 +0000
Date:   Wed, 6 Sep 2023 09:05:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: ../lib/gcc/xtensa-linux/13.2.0/plugin/include/c-family/c-common.h:173:10:
 fatal error: cp/cp-trait.def: No such file or directory
Message-ID: <202309060858.Zfd1IFhN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   65d6e954e37872fd9afb5ef3fc0481bb3c2f20f4
commit: 7dc0eb0b6d9f3e2b6a560a04f86ef065a4531a9f xtensa: enable plugin support
date:   1 year, 6 months ago
config: xtensa-allyesconfig (https://download.01.org/0day-ci/archive/20230906/202309060858.Zfd1IFhN-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230906/202309060858.Zfd1IFhN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309060858.Zfd1IFhN-lkp@intel.com/

All errors (new ones prefixed by >>):

   scripts/sign-file.c: In function 'display_openssl_errors':
   scripts/sign-file.c:89:9: warning: 'ERR_get_error_line' is deprecated: Since OpenSSL 3.0 [-Wdeprecated-declarations]
      89 |         while ((e = ERR_get_error_line(&file, &line))) {
         |         ^~~~~
   In file included from scripts/sign-file.c:29:
   /usr/include/openssl/err.h:423:15: note: declared here
     423 | unsigned long ERR_get_error_line(const char **file, int *line);
         |               ^~~~~~~~~~~~~~~~~~
   scripts/sign-file.c: In function 'drain_openssl_errors':
   scripts/sign-file.c:102:9: warning: 'ERR_get_error_line' is deprecated: Since OpenSSL 3.0 [-Wdeprecated-declarations]
     102 |         while (ERR_get_error_line(&file, &line)) {}
         |         ^~~~~
   /usr/include/openssl/err.h:423:15: note: declared here
     423 | unsigned long ERR_get_error_line(const char **file, int *line);
         |               ^~~~~~~~~~~~~~~~~~
   scripts/sign-file.c: In function 'read_private_key':
   scripts/sign-file.c:142:17: warning: 'ENGINE_load_builtin_engines' is deprecated: Since OpenSSL 3.0 [-Wdeprecated-declarations]
     142 |                 ENGINE_load_builtin_engines();
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from scripts/sign-file.c:30:
   /usr/include/openssl/engine.h:358:28: note: declared here
     358 | OSSL_DEPRECATEDIN_3_0 void ENGINE_load_builtin_engines(void);
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   scripts/sign-file.c:144:17: warning: 'ENGINE_by_id' is deprecated: Since OpenSSL 3.0 [-Wdeprecated-declarations]
     144 |                 e = ENGINE_by_id("pkcs11");
         |                 ^
   /usr/include/openssl/engine.h:336:31: note: declared here
     336 | OSSL_DEPRECATEDIN_3_0 ENGINE *ENGINE_by_id(const char *id);
         |                               ^~~~~~~~~~~~
   scripts/sign-file.c:146:17: warning: 'ENGINE_init' is deprecated: Since OpenSSL 3.0 [-Wdeprecated-declarations]
     146 |                 if (ENGINE_init(e))
         |                 ^~
   /usr/include/openssl/engine.h:620:27: note: declared here
     620 | OSSL_DEPRECATEDIN_3_0 int ENGINE_init(ENGINE *e);
         |                           ^~~~~~~~~~~
   scripts/sign-file.c:151:25: warning: 'ENGINE_ctrl_cmd_string' is deprecated: Since OpenSSL 3.0 [-Wdeprecated-declarations]
     151 |                         ERR(!ENGINE_ctrl_cmd_string(e, "PIN", key_pass, 0),
         |                         ^~~
   /usr/include/openssl/engine.h:479:5: note: declared here
     479 | int ENGINE_ctrl_cmd_string(ENGINE *e, const char *cmd_name, const char *arg,
         |     ^~~~~~~~~~~~~~~~~~~~~~
   scripts/sign-file.c:153:17: warning: 'ENGINE_load_private_key' is deprecated: Since OpenSSL 3.0 [-Wdeprecated-declarations]
     153 |                 private_key = ENGINE_load_private_key(e, private_key_name,
         |                 ^~~~~~~~~~~
   /usr/include/openssl/engine.h:638:11: note: declared here
     638 | EVP_PKEY *ENGINE_load_private_key(ENGINE *e, const char *key_id,
         |           ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from scripts/gcc-plugins/gcc-common.h:54,
                    from scripts/gcc-plugins/latent_entropy_plugin.c:78:
>> ../lib/gcc/xtensa-linux/13.2.0/plugin/include/c-family/c-common.h:173:10: fatal error: cp/cp-trait.def: No such file or directory
     173 | #include "cp/cp-trait.def"
         |          ^~~~~~~~~~~~~~~~~
   compilation terminated.
   make[3]: *** [scripts/gcc-plugins/Makefile:48: scripts/gcc-plugins/latent_entropy_plugin.so] Error 1
   In file included from scripts/gcc-plugins/gcc-common.h:54,
                    from scripts/gcc-plugins/randomize_layout_plugin.c:19:
>> ../lib/gcc/xtensa-linux/13.2.0/plugin/include/c-family/c-common.h:173:10: fatal error: cp/cp-trait.def: No such file or directory
     173 | #include "cp/cp-trait.def"
         |          ^~~~~~~~~~~~~~~~~
   compilation terminated.
   make[3]: *** [scripts/gcc-plugins/Makefile:48: scripts/gcc-plugins/randomize_layout_plugin.so] Error 1
   make[3]: Target '__build' not remade because of errors.
   make[2]: *** [scripts/Makefile.build:550: scripts/gcc-plugins] Error 2
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1175: scripts] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
