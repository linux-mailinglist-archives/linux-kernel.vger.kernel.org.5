Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243807F56F2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 04:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344441AbjKWDRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 22:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjKWDRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 22:17:10 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8668B1A4;
        Wed, 22 Nov 2023 19:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700709437; x=1732245437;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sJmQATWnZ/tTsmLmfHO3rRYbs5KYOsxU4c9+MxGZwzM=;
  b=BAhtPQeCyP98sGSZt4BlUeLYD9rbiDEMF/tCvLWrBI2a4gJpAlkQtN7n
   FZ77pt6uCnFD6b+ijhO3PJPIgYeFN9wW+iueW+Il669MWYphFIkwZmYU4
   JlDR9fW0JdLsxxbxk9j/JFCtOpmikIrAarWmdz4yowRKpb+co2FmoWC1L
   iDkSPac0gMoEWlz1Zy44U5tFZyqQ85lqc8RipFGQJRNCJjJtS3Cod/xEb
   5oJ89J+07hzNA8xRDIEhUDIpkTuQ2Ti0if/eg6zbDSU2qM4H2MwC1Xv4T
   D0/3M4iop+JLvDrzwM0htTa83Ku4AmZma/E7UXJgksHIC3/MQo3O1zUCu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="5380203"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="5380203"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 19:17:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="767083296"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="767083296"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 22 Nov 2023 19:17:14 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r60DI-0001B4-1I;
        Thu, 23 Nov 2023 03:17:12 +0000
Date:   Thu, 23 Nov 2023 11:16:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ben Dooks <ben.dooks@codethink.co.uk>, bpf@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH] bpf: add __printf() to for printf fmt strings
Message-ID: <202311231030.yBuPn92M-lkp@intel.com>
References: <20231122133656.290475-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122133656.290475-1-ben.dooks@codethink.co.uk>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]
[also build test WARNING on bpf/master linus/master v6.7-rc2 next-20231122]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ben-Dooks/bpf-add-__printf-to-for-printf-fmt-strings/20231122-231149
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20231122133656.290475-1-ben.dooks%40codethink.co.uk
patch subject: [PATCH] bpf: add __printf() to for printf fmt strings
config: x86_64-randconfig-161-20231123 (https://download.01.org/0day-ci/archive/20231123/202311231030.yBuPn92M-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231123/202311231030.yBuPn92M-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311231030.yBuPn92M-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/bpf/btf.c: In function 'btf_type_seq_show_flags':
>> kernel/bpf/btf.c:7100:14: warning: assignment left-hand side might be a candidate for a format attribute [-Wsuggest-attribute=format]
    7100 |  sseq.showfn = btf_seq_show;
         |              ^
   kernel/bpf/btf.c: In function 'btf_type_snprintf_show':
   kernel/bpf/btf.c:7151:24: warning: assignment left-hand side might be a candidate for a format attribute [-Wsuggest-attribute=format]
    7151 |  ssnprintf.show.showfn = btf_snprintf_show;
         |                        ^


vim +7100 kernel/bpf/btf.c

31d0bc81637d8d Alan Maguire 2020-09-28  7093  
eb411377aed9e2 Alan Maguire 2020-09-28  7094  int btf_type_seq_show_flags(const struct btf *btf, u32 type_id,
31d0bc81637d8d Alan Maguire 2020-09-28  7095  			    void *obj, struct seq_file *m, u64 flags)
31d0bc81637d8d Alan Maguire 2020-09-28  7096  {
31d0bc81637d8d Alan Maguire 2020-09-28  7097  	struct btf_show sseq;
31d0bc81637d8d Alan Maguire 2020-09-28  7098  
31d0bc81637d8d Alan Maguire 2020-09-28  7099  	sseq.target = m;
31d0bc81637d8d Alan Maguire 2020-09-28 @7100  	sseq.showfn = btf_seq_show;
31d0bc81637d8d Alan Maguire 2020-09-28  7101  	sseq.flags = flags;
31d0bc81637d8d Alan Maguire 2020-09-28  7102  
31d0bc81637d8d Alan Maguire 2020-09-28  7103  	btf_type_show(btf, type_id, obj, &sseq);
31d0bc81637d8d Alan Maguire 2020-09-28  7104  
31d0bc81637d8d Alan Maguire 2020-09-28  7105  	return sseq.state.status;
31d0bc81637d8d Alan Maguire 2020-09-28  7106  }
31d0bc81637d8d Alan Maguire 2020-09-28  7107  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
