Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C2C7CED21
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 03:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjJSBEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 21:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjJSBEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 21:04:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AFAB8;
        Wed, 18 Oct 2023 18:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697677480; x=1729213480;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6D17xD20qVz7TuhP7QTPURn0gJ9gWhdd39tmiAP+AJk=;
  b=gjRT/NHgNs+dFccT1BLuyoYBzLoq1eG85AMlRTnyWYi8juWrGXTYn/6R
   4lwDv7yY+bb9C5vYTAqr66LzDkkkNR9NviUQc0CfJ9L33TIIEzfZIeFxW
   GC6R1Qmq29G5SWH8WeGL/RFYgVBNPKCJ1n6OUFTa6zG85f8vnYrwK1+wN
   OGXBECAuPXohvxvYAy40LVUKJmSj2HdsNPwxKEbx7xjjZRvXJoEFShQuB
   bhXI46BYt5xEBUdk7aImOfjfRrDILcmWi6ibzsqhPxpVJqnsHjC/G9ZUI
   fkPc8BWY5zV1Dt2pWZB3mR2H5d7MaLo3CN2y+RjaGjgPqTl89cK3MmFWb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="417257820"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="417257820"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 18:04:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="791818880"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="791818880"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 18 Oct 2023 18:04:38 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qtHSl-0001MW-1w;
        Thu, 19 Oct 2023 01:04:35 +0000
Date:   Thu, 19 Oct 2023 09:03:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com, rajvi.jingar@linux.intel.com
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH V4 03/17] platform/x86/intel/vsec: Use cleanup.h
Message-ID: <202310190857.Vc2mlWmN-lkp@intel.com>
References: <20231018231624.1044633-4-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018231624.1044633-4-david.e.box@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 3f720b21ec5af466e50e99dc517af267b67d248c]

url:    https://github.com/intel-lab-lkp/linux/commits/David-E-Box/platform-x86-intel-vsec-Move-structures-to-header/20231019-071914
base:   3f720b21ec5af466e50e99dc517af267b67d248c
patch link:    https://lore.kernel.org/r/20231018231624.1044633-4-david.e.box%40linux.intel.com
patch subject: [PATCH V4 03/17] platform/x86/intel/vsec: Use cleanup.h
reproduce: (https://download.01.org/0day-ci/archive/20231019/202310190857.Vc2mlWmN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310190857.Vc2mlWmN-lkp@intel.com/

# many are suggestions rather than must-fix

ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#32: FILE: drivers/platform/x86/intel/vsec.c:151:
+	struct intel_vsec_device __free(kfree) *intel_vsec_dev = NULL;
 	                                       ^

ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#33: FILE: drivers/platform/x86/intel/vsec.c:152:
+	struct resource __free(kfree) *res = NULL;
 	                              ^

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
