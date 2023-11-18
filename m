Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CB67EFFEF
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 14:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjKRNmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 08:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjKRNmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 08:42:45 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6248F131;
        Sat, 18 Nov 2023 05:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700314962; x=1731850962;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gSMTqvq+4yiOQm6kYsedLkv+Vn7EFGQOlrwRuuC1Mmk=;
  b=Io8iMvs6qrEgVaOvV6yqFrPfWJ1Qx/v4L/zCw8WEkK7SF9uwD7KZcK9P
   Wosd258HHc+Tr270YMntrjjRjlHuGOC6hDzBkESRwVjtt8UxUGsUYyjLT
   OLFbuqtwGzW0Q7NlqsVBJnZHij+Ho8HkeDYK4s7OQDge4LAvftoNW8iqW
   6e/Hofxp4AN5ewS9HHlujgqdw1F1RW/ORMYqRxnILEeborKQusNRMr4ax
   aAylOgvkqwpQj1VdZWftpJiE/+LLMbh+3hSNe05GFZnf1TxatCzJP9RY3
   MSymU2Lm3Fqg5986W46JzbJQVwu8QppU3MKO4HIQIsj+9mPEqN527ERE9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="388579890"
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="388579890"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2023 05:42:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="909670491"
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="909670491"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 18 Nov 2023 05:42:38 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4Lal-0003wp-39;
        Sat, 18 Nov 2023 13:42:35 +0000
Date:   Sat, 18 Nov 2023 21:42:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matthew Maurer <mmaurer@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org,
        rust-for-linux@vger.kernel.org, Laura Abbott <laura@labbott.name>,
        Matthew Maurer <mmaurer@google.com>
Subject: Re: [PATCH v2 3/5] modpost: Extended modversion support
Message-ID: <202311182118.zJqkg301-lkp@intel.com>
References: <20231118025748.2778044-4-mmaurer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231118025748.2778044-4-mmaurer@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

kernel test robot noticed the following build errors:

[auto build test ERROR on mcgrof/modules-next]
[also build test ERROR on powerpc/next powerpc/fixes masahiroy-kbuild/for-next masahiroy-kbuild/fixes linus/master v6.7-rc1 next-20231117]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Maurer/export_report-Rehabilitate-script/20231118-110040
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git modules-next
patch link:    https://lore.kernel.org/r/20231118025748.2778044-4-mmaurer%40google.com
patch subject: [PATCH v2 3/5] modpost: Extended modversion support
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20231118/202311182118.zJqkg301-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231118/202311182118.zJqkg301-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311182118.zJqkg301-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/powerpc/kernel/module_64.c:25:10: fatal error: string.h: No such file or directory
      25 | #include <string.h>
         |          ^~~~~~~~~~
   compilation terminated.


vim +25 arch/powerpc/kernel/module_64.c

     8	
     9	#include <linux/module.h>
    10	#include <linux/elf.h>
    11	#include <linux/moduleloader.h>
    12	#include <linux/err.h>
    13	#include <linux/vmalloc.h>
    14	#include <linux/ftrace.h>
    15	#include <linux/bug.h>
    16	#include <linux/uaccess.h>
    17	#include <linux/kernel.h>
    18	#include <asm/module.h>
    19	#include <asm/firmware.h>
    20	#include <asm/code-patching.h>
    21	#include <linux/sort.h>
    22	#include <asm/setup.h>
    23	#include <asm/sections.h>
    24	#include <asm/inst.h>
  > 25	#include <string.h>
    26	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
