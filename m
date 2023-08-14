Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B5277C404
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 01:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbjHNXlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 19:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbjHNXk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 19:40:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BD310C1;
        Mon, 14 Aug 2023 16:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692056455; x=1723592455;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CW9pS7IeCoSStEZyotzjqSdXT/EjAzc16K4X+QYgMFM=;
  b=llSFuWd9zPJbkzmYiMqmqJ9rCWKToAUBBQ7+BQMYgdJ/yPyo8iMRd8kA
   Ej82as2WZPufrs97Oto+jdvLZLYISVkk24UDT/mDjZNB2+3xwTi9dSROJ
   XvMIIMPx/SSMcn/aZ0zexwfrxMp41pR+QPrNT8zl/7RR4U0ROJU+ZhCpc
   AxkLavRnpauuTpv3AC9zTXxY8q89sMTAHugOplrzL3F1dkeM1mBJMpM0O
   Kkcsm9jDm2/FXpgyhioEXXONG0pwIaJAxS5dYvWFttiNRZ3TKeUIyHvNj
   jzwSUQOu1K/IwnGYzicUxlozZso4IN3ZmmNyOix6hHe/0mL9qZs78GvxS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="372156742"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="372156742"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 16:40:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="803617185"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="803617185"
Received: from lkp-server02.sh.intel.com (HELO b5fb8d9e1ffc) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 14 Aug 2023 16:40:51 -0700
Received: from kbuild by b5fb8d9e1ffc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qVhB5-0000VP-0B;
        Mon, 14 Aug 2023 23:40:51 +0000
Date:   Tue, 15 Aug 2023 07:40:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leo Yan <leo.yan@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH v5] Documentation: userspace-api: Document perf ring
 buffer mechanism
Message-ID: <202308150745.gAbeux0W-lkp@intel.com>
References: <20230814121907.100340-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814121907.100340-1-leo.yan@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on lwn/docs-next]
[also build test WARNING on linus/master v6.5-rc6 next-20230809]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Leo-Yan/Documentation-userspace-api-Document-perf-ring-buffer-mechanism/20230814-202144
base:   git://git.lwn.net/linux.git docs-next
patch link:    https://lore.kernel.org/r/20230814121907.100340-1-leo.yan%40linaro.org
patch subject: [PATCH v5] Documentation: userspace-api: Document perf ring buffer mechanism
reproduce: (https://download.01.org/0day-ci/archive/20230815/202308150745.gAbeux0W-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308150745.gAbeux0W-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Documentation/userspace-api/perf_ring_buffer.rst: WARNING: document isn't included in any toctree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
