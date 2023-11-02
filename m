Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CCF7DEBBA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 05:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348437AbjKBEPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 00:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348417AbjKBEPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 00:15:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FECA6
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 21:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698898531; x=1730434531;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YWSSMCsulCRLdzOjDrEsEiAA9R2C1SvVYwlBRHY11MY=;
  b=KhCmC0AfKMwX+aiwg5znT1snzAi+UtNG55NZu9odiNZAZ0d3TJ5PaAXA
   Ym97gtjxpWlP4Nw9BugAloBIFwYR7oMVUlWU45Er/QNxFymDzBcwALZBd
   Sl4q7R5ogSZeVD1ynDjU0QoMsBO5//aRaroW1fxSGh3D1eUQCbhIKl/vw
   OKQZcOWAa8o5fq4iZj+sz58d3AebCYHlY3zFyjaCyZ6l+XzvKspDVMdPq
   aVtemsjNDArXPeYFah8zZBKVDoPh19V64aRZzRyVk4NstuKVrryFlSsvi
   f+pLw2OauTpFR7dOO2e9jvGkOPpTFC4y8Ahe9f1hbq7fyzSlV6opqAnON
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="385811200"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="385811200"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 21:15:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="1092590988"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="1092590988"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 01 Nov 2023 21:15:29 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qyP79-00016K-1C;
        Thu, 02 Nov 2023 04:15:27 +0000
Date:   Thu, 2 Nov 2023 12:14:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daan De Meyer <daan.j.demeyer@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: net/core/filter.c:11773:17: warning: no previous declaration for
 'bpf_sock_addr_set_sun_path'
Message-ID: <202311021257.nD9pHYSn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daan,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   babe393974de0351c0e6cca50f5f84edaf8d7fa1
commit: 53e380d21441909b12b6e0782b77187ae4b971c4 bpf: Add bpf_sock_addr_set_sun_path() to allow writing unix sockaddr from bpf
date:   3 weeks ago
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20231102/202311021257.nD9pHYSn-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231102/202311021257.nD9pHYSn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311021257.nD9pHYSn-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/core/filter.c:11747:17: warning: no previous declaration for 'bpf_dynptr_from_skb' [-Wmissing-declarations]
    __bpf_kfunc int bpf_dynptr_from_skb(struct sk_buff *skb, u64 flags,
                    ^~~~~~~~~~~~~~~~~~~
   net/core/filter.c:11760:17: warning: no previous declaration for 'bpf_dynptr_from_xdp' [-Wmissing-declarations]
    __bpf_kfunc int bpf_dynptr_from_xdp(struct xdp_buff *xdp, u64 flags,
                    ^~~~~~~~~~~~~~~~~~~
>> net/core/filter.c:11773:17: warning: no previous declaration for 'bpf_sock_addr_set_sun_path' [-Wmissing-declarations]
    __bpf_kfunc int bpf_sock_addr_set_sun_path(struct bpf_sock_addr_kern *sa_kern,
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   net/core/filter.c:11877:17: warning: no previous declaration for 'bpf_sock_destroy' [-Wmissing-declarations]
    __bpf_kfunc int bpf_sock_destroy(struct sock_common *sock)
                    ^~~~~~~~~~~~~~~~


vim +/bpf_sock_addr_set_sun_path +11773 net/core/filter.c

 11772	
 11773	__bpf_kfunc int bpf_sock_addr_set_sun_path(struct bpf_sock_addr_kern *sa_kern,
 11774						   const u8 *sun_path, u32 sun_path__sz)
 11775	{
 11776		struct sockaddr_un *un;
 11777	
 11778		if (sa_kern->sk->sk_family != AF_UNIX)
 11779			return -EINVAL;
 11780	
 11781		/* We do not allow changing the address to unnamed or larger than the
 11782		 * maximum allowed address size for a unix sockaddr.
 11783		 */
 11784		if (sun_path__sz == 0 || sun_path__sz > UNIX_PATH_MAX)
 11785			return -EINVAL;
 11786	
 11787		un = (struct sockaddr_un *)sa_kern->uaddr;
 11788		memcpy(un->sun_path, sun_path, sun_path__sz);
 11789		sa_kern->uaddrlen = offsetof(struct sockaddr_un, sun_path) + sun_path__sz;
 11790	
 11791		return 0;
 11792	}
 11793	__diag_pop();
 11794	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
