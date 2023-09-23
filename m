Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2EA7ABF79
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 12:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjIWKCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 06:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjIWKCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 06:02:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2877199
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 03:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695463323; x=1726999323;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=O3KlciKjFuKLxjrt+FQDkuuPocqYL9/PoZy0VontCSI=;
  b=f0ATKVXsgqXwp15nFm13cySu/sRn3qvN5f+va9DqCQ22+hgC5/vtkhWq
   PS53vpLVCiFRddqclejkw3zMxCSMIBe58T4F7T2lqOXToqGOeR+ymF2ZL
   +qMkxBrqj32RPWsCLZ5+4TFAW06SjE/XMzirA1bfTzFGWulTUJD1dwNTA
   3JDvMx7daUYH30FX33rtOTNfQ4+rrMFyuID49YOtbOYuyZZQRQcvkehDZ
   hO+wHT4fCA/Q9PqVjgbT9KbJJj47S5Gb7eRuXRlefysM5ER75rcpjSF/7
   pR4kEtxKV62POZUIeJTsS3o3Hcl9sXDddpTu+SCi5XiYQIkBbMQm5EkR+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="447491740"
X-IronPort-AV: E=Sophos;i="6.03,171,1694761200"; 
   d="scan'208";a="447491740"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2023 03:02:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="813372952"
X-IronPort-AV: E=Sophos;i="6.03,171,1694761200"; 
   d="scan'208";a="813372952"
Received: from lkp-server02.sh.intel.com (HELO 493f6c7fed5d) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 23 Sep 2023 03:02:01 -0700
Received: from kbuild by 493f6c7fed5d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qjzSZ-00028B-2s;
        Sat, 23 Sep 2023 10:01:59 +0000
Date:   Sat, 23 Sep 2023 18:01:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Geliang Tang <geliang.tang@suse.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: net/socket.c:1676:21: error: no previous declaration for
 'update_socket_protocol'
Message-ID: <202309231748.AETjbleh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d90b0276af8f25a0b8ae081a30d1b2a61263393b
commit: 0dd061a6a115f25132989cbd591a25afb2dee086 bpf: Add update_socket_protocol hook
date:   5 weeks ago
config: x86_64-sof-customedconfig-avs-defconfig (https://download.01.org/0day-ci/archive/20230923/202309231748.AETjbleh-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230923/202309231748.AETjbleh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309231748.AETjbleh-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/socket.c:1676:21: error: no previous declaration for 'update_socket_protocol' [-Werror=missing-declarations]
    __weak noinline int update_socket_protocol(int family, int type, int protocol)
                        ^~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/update_socket_protocol +1676 net/socket.c

  1659	
  1660	/*	A hook for bpf progs to attach to and update socket protocol.
  1661	 *
  1662	 *	A static noinline declaration here could cause the compiler to
  1663	 *	optimize away the function. A global noinline declaration will
  1664	 *	keep the definition, but may optimize away the callsite.
  1665	 *	Therefore, __weak is needed to ensure that the call is still
  1666	 *	emitted, by telling the compiler that we don't know what the
  1667	 *	function might eventually be.
  1668	 *
  1669	 *	__diag_* below are needed to dismiss the missing prototype warning.
  1670	 */
  1671	
  1672	__diag_push();
  1673	__diag_ignore_all("-Wmissing-prototypes",
  1674			  "A fmod_ret entry point for BPF programs");
  1675	
> 1676	__weak noinline int update_socket_protocol(int family, int type, int protocol)
  1677	{
  1678		return protocol;
  1679	}
  1680	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
