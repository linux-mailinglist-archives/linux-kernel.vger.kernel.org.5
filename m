Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09F87CA2AC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbjJPIwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjJPIwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:52:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4AFF1;
        Mon, 16 Oct 2023 01:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697446366; x=1728982366;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FDZL4OD787gS/ZZ371kxlpEGWk0Gv1OER30HjD5OdsE=;
  b=EbXsN1rj0RhvksjgxCj/G9TrrB+6b4OMfIHaMi2U/6l2ADBr8nkeN8Fh
   70XVdCB7f46fgx/PpXc5cY8DI311OX5zdcfCGnz0BUPYDBUeuTDxaXA+b
   hNK7/de9xPlCKJPw+mBJr17OIhOf1axTna1AULuRxe9AnG1oKrV+AGRDN
   q2i7XD41DpckJjSfyYkDa1PhYxCLG0rtecieWqfsIBlhpyypmh28hvsuU
   /w83IxwH7AMPi1PpbwX2b824IOcrE76A3jg7T/VT0TtWy08GuH+a5Ix/w
   ioLM5iEF1mQ4jVRk5W4m0hgRhuxIXCJA1mMoOZ+8zKo11OCk6A7kYUnk9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="451960061"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="451960061"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 01:52:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="872013091"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="872013091"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 16 Oct 2023 01:52:42 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qsJL3-0008Fd-0b;
        Mon, 16 Oct 2023 08:52:37 +0000
Date:   Mon, 16 Oct 2023 16:51:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     xiaolinkui <xiaolinkui@126.com>, pablo@netfilter.org,
        kadlec@netfilter.org, fw@strlen.de, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        justinstitt@google.com, kuniyu@amazon.com
Cc:     oe-kbuild-all@lists.linux.dev, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: Re: [PATCH] netfilter: ipset: wait for xt_recseq on all cpus
Message-ID: <202310161625.GDDBP8SZ-lkp@intel.com>
References: <20231005115022.12902-1-xiaolinkui@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005115022.12902-1-xiaolinkui@126.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi xiaolinkui,

kernel test robot noticed the following build errors:

[auto build test ERROR on netfilter-nf/main]
[also build test ERROR on nf-next/master horms-ipvs/master linus/master v6.6-rc6 next-20231016]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/xiaolinkui/netfilter-ipset-wait-for-xt_recseq-on-all-cpus/20231005-234042
base:   git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git main
patch link:    https://lore.kernel.org/r/20231005115022.12902-1-xiaolinkui%40126.com
patch subject: [PATCH] netfilter: ipset: wait for xt_recseq on all cpus
config: x86_64-buildonly-randconfig-006-20231016 (https://download.01.org/0day-ci/archive/20231016/202310161625.GDDBP8SZ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231016/202310161625.GDDBP8SZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310161625.GDDBP8SZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: vmlinux.o: in function `wait_xt_recseq':
>> ip_set_core.c:(.text+0x1c561ac): undefined reference to `xt_recseq'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
