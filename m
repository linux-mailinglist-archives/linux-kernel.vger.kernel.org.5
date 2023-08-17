Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6B477FCC8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353293AbjHQRNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353954AbjHQRNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:13:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38052136;
        Thu, 17 Aug 2023 10:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692292386; x=1723828386;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lW4Gs99clp24g1be/o8KoTm4TvBfDD4QsWs4eUiesuQ=;
  b=cpX/xCLdOdQYzn7WyniXwheY5C4Mz9RzqKnWTWP7ygZTSqmspzAPkgQs
   FgELfSvzkzUul54uYfGUzfcGAgEOocKJc+wM0SPJJVHZJwBdcoyVf9DdA
   pGXkFfTZlC7132dKI402zgXXiO7eWv9FC10yyWz9ZC1LbNdFfzLpmR7Sd
   xFH6JaJt7TsP4rjKdio3WIk8Nm7JNJSbRTDlgXuNtkTXMN6CnXC5DbYpV
   wfrgAvDoANw1ds+j2i5gdJH9Xk/lURj5nDSMBNHWhtyVOjN+sNlcTjoK5
   fLjrsRarfvIggthC5GwGrey/9gyPsMyc1XnymV/qkeFLA42uFYJcEN01v
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="370342240"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="370342240"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 10:12:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="848945531"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="848945531"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 17 Aug 2023 10:12:32 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWgXw-0001L9-05;
        Thu, 17 Aug 2023 17:12:32 +0000
Date:   Fri, 18 Aug 2023 01:11:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     johannes@gnu-linux.rocks, jikos@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        andi.shyti@kernel.org, christophe.jaillet@wanadoo.fr,
        ak@it-klinger.de, Johannes Roith <johannes@gnu-linux.rocks>
Subject: Re: [PATCH v4] hid-mcp2200: added driver for GPIOs of MCP2200
Message-ID: <202308180056.nB1KSUap-lkp@intel.com>
References: <20230817091505.213318-1-johannes@gnu-linux.rocks>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817091505.213318-1-johannes@gnu-linux.rocks>
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

[auto build test WARNING on hid/for-next]
[also build test WARNING on linus/master v6.5-rc6 next-20230817]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/johannes-gnu-linux-rocks/hid-mcp2200-added-driver-for-GPIOs-of-MCP2200/20230817-172246
base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
patch link:    https://lore.kernel.org/r/20230817091505.213318-1-johannes%40gnu-linux.rocks
patch subject: [PATCH v4] hid-mcp2200: added driver for GPIOs of MCP2200
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230818/202308180056.nB1KSUap-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230818/202308180056.nB1KSUap-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308180056.nB1KSUap-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/hid/hid-mcp2200.c: In function 'mcp2200_remove':
>> drivers/hid/hid-mcp2200.c:395:25: warning: variable 'mcp' set but not used [-Wunused-but-set-variable]
     395 |         struct mcp2200 *mcp;
         |                         ^~~


vim +/mcp +395 drivers/hid/hid-mcp2200.c

   392	
   393	static void mcp2200_remove(struct hid_device *hdev)
   394	{
 > 395		struct mcp2200 *mcp;
   396	
   397		mcp = hid_get_drvdata(hdev);
   398	}
   399	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
