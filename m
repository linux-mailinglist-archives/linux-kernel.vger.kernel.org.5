Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F907BEFD8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 02:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379235AbjJJAmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 20:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379194AbjJJAmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 20:42:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB0399
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 17:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696898529; x=1728434529;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xbTeq6oartpAp98wc9nskAZ+4fewvxTX2qr7rQTiNR4=;
  b=kbgh+RXh6s/85+MjG3KiSGXEq2TojZfC98U4QnMUEfRNu2kUtAio/iIo
   xdx2T0Vm/+rc4jxc76IWUfAJF2vazK+8gt7Ihaw7Xusm92i6sXYVGP8NJ
   USJzvzYUdmhllfVSkbWl00WMdxwo8bmA/08+lImpks/wiZj73xwO6EgQo
   HMEHKM98Z4QBwKvc6+vrABycw+aUIqyYua2OSx/ENILz0ClSg+ziMU6Fo
   6+Kjeh+Mqhnw+WHbeqYYr2Kker9CFWP1Zdq2U6OIiVTU4XVwfg8QUcuSW
   U1EtM5RLbieVIo/grcTJByaFe0XDADIIqS2RDtogu07lZzI2dVltDFQ4a
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="384139905"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="384139905"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 17:42:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="1000446374"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="1000446374"
Received: from lkp-server02.sh.intel.com (HELO 4ed589823ba4) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 09 Oct 2023 17:42:06 -0700
Received: from kbuild by 4ed589823ba4 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qq0p2-0000se-0t;
        Tue, 10 Oct 2023 00:42:04 +0000
Date:   Tue, 10 Oct 2023 08:41:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: kernel/trace/ftrace.c:5675: warning: Function parameter or member
 'ops' not described in 'ftrace_set_filter_ips'
Message-ID: <202310100857.YpF7BNZH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   94f6f0550c625fab1f373bb86a6669b45e9748b3
commit: 4f554e955614f19425cee86de4669351741a6280 ftrace: Add ftrace_set_filter_ips function
date:   1 year, 7 months ago
config: i386-debian-10.3 (https://download.01.org/0day-ci/archive/20231010/202310100857.YpF7BNZH-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231010/202310100857.YpF7BNZH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310100857.YpF7BNZH-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/trace/ftrace.c:5553: warning: Function parameter or member 'addr' not described in 'unregister_ftrace_direct_multi'
   kernel/trace/ftrace.c:5656: warning: Function parameter or member 'ops' not described in 'ftrace_set_filter_ip'
   kernel/trace/ftrace.c:5656: warning: Function parameter or member 'ip' not described in 'ftrace_set_filter_ip'
   kernel/trace/ftrace.c:5656: warning: Function parameter or member 'remove' not described in 'ftrace_set_filter_ip'
   kernel/trace/ftrace.c:5656: warning: Function parameter or member 'reset' not described in 'ftrace_set_filter_ip'
>> kernel/trace/ftrace.c:5675: warning: Function parameter or member 'ops' not described in 'ftrace_set_filter_ips'
>> kernel/trace/ftrace.c:5675: warning: Function parameter or member 'ips' not described in 'ftrace_set_filter_ips'
>> kernel/trace/ftrace.c:5675: warning: Function parameter or member 'cnt' not described in 'ftrace_set_filter_ips'
>> kernel/trace/ftrace.c:5675: warning: Function parameter or member 'remove' not described in 'ftrace_set_filter_ips'
>> kernel/trace/ftrace.c:5675: warning: Function parameter or member 'reset' not described in 'ftrace_set_filter_ips'
   kernel/trace/ftrace.c:5689: warning: Function parameter or member 'ops' not described in 'ftrace_ops_set_global_filter'
   kernel/trace/ftrace.c:5717: warning: Function parameter or member 'ops' not described in 'ftrace_set_filter'
   kernel/trace/ftrace.c:5717: warning: Function parameter or member 'buf' not described in 'ftrace_set_filter'
   kernel/trace/ftrace.c:5717: warning: Function parameter or member 'len' not described in 'ftrace_set_filter'
   kernel/trace/ftrace.c:5717: warning: Function parameter or member 'reset' not described in 'ftrace_set_filter'
   kernel/trace/ftrace.c:5736: warning: Function parameter or member 'ops' not described in 'ftrace_set_notrace'
   kernel/trace/ftrace.c:5736: warning: Function parameter or member 'buf' not described in 'ftrace_set_notrace'
   kernel/trace/ftrace.c:5736: warning: Function parameter or member 'len' not described in 'ftrace_set_notrace'
   kernel/trace/ftrace.c:5736: warning: Function parameter or member 'reset' not described in 'ftrace_set_notrace'
   kernel/trace/ftrace.c:5751: warning: Function parameter or member 'buf' not described in 'ftrace_set_global_filter'
   kernel/trace/ftrace.c:5751: warning: Function parameter or member 'len' not described in 'ftrace_set_global_filter'
   kernel/trace/ftrace.c:5751: warning: Function parameter or member 'reset' not described in 'ftrace_set_global_filter'
   kernel/trace/ftrace.c:5767: warning: Function parameter or member 'buf' not described in 'ftrace_set_global_notrace'
   kernel/trace/ftrace.c:5767: warning: Function parameter or member 'len' not described in 'ftrace_set_global_notrace'
   kernel/trace/ftrace.c:5767: warning: Function parameter or member 'reset' not described in 'ftrace_set_global_notrace'
   kernel/trace/ftrace.c:7843: warning: Function parameter or member 'ops' not described in 'register_ftrace_function'
   kernel/trace/ftrace.c:7865: warning: Function parameter or member 'ops' not described in 'unregister_ftrace_function'


vim +5675 kernel/trace/ftrace.c

  5661	
  5662	/**
  5663	 * ftrace_set_filter_ips - set functions to filter on in ftrace by addresses
  5664	 * @ops - the ops to set the filter with
  5665	 * @ips - the array of addresses to add to or remove from the filter.
  5666	 * @cnt - the number of addresses in @ips
  5667	 * @remove - non zero to remove ips from the filter
  5668	 * @reset - non zero to reset all filters before applying this filter.
  5669	 *
  5670	 * Filters denote which functions should be enabled when tracing is enabled
  5671	 * If @ips array or any ip specified within is NULL , it fails to update filter.
  5672	 */
  5673	int ftrace_set_filter_ips(struct ftrace_ops *ops, unsigned long *ips,
  5674				  unsigned int cnt, int remove, int reset)
> 5675	{
  5676		ftrace_ops_init(ops);
  5677		return ftrace_set_addr(ops, ips, cnt, remove, reset, 1);
  5678	}
  5679	EXPORT_SYMBOL_GPL(ftrace_set_filter_ips);
  5680	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
