Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271F87DFD33
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 00:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377569AbjKBXLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 19:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjKBXLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 19:11:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEE4133;
        Thu,  2 Nov 2023 16:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698966663; x=1730502663;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t2dJVdoJc7fyWxD/M51aRldCu7biUnkgqQJ2sLnr7E4=;
  b=geAlUZ81sC56p7Ui5sSDpAm+AwC8TSR95sNFOkK9gb/WS510X2gFM0Vh
   Oqs/PgPLuzHv8yFVqDvra4eFVhntYKPb2jDKAvM7mUeX0LTkzFwhFW3EQ
   V6BCHURdaJ/jK+r9diiNBT7BiCRRp2KC6HzCDYqUpYFPJ4HklCkoZU9So
   U3VpjktNtQH/HqjQwDwcgvPBVIse0KAQkawS0A4+lJT/748n98/kLgY4m
   7DYtykZB8fEaP83vQ1N3tWbqV2pMw3Q2jWLJdJit5kxIDtWSvRi0VcMRA
   0imisFaZwzuruNkioNLRe1QS6jQWMkEG0xHJ3fDAo09Nm3WxBPIQ8NeCc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="373881135"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="373881135"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 16:11:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="905151514"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="905151514"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 02 Nov 2023 16:11:00 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qygq1-0001zE-21;
        Thu, 02 Nov 2023 23:10:57 +0000
Date:   Fri, 3 Nov 2023 07:10:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Justin Stitt <justinstitt@google.com>,
        Hannes Reinecke <hare@suse.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH] scsi: libfc: replace deprecated strncpy with memcpy
Message-ID: <202311030603.XIHsNBru-lkp@intel.com>
References: <20231030-strncpy-drivers-scsi-libfc-fc_encode-h-v1-1-c08c2be6befa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030-strncpy-drivers-scsi-libfc-fc_encode-h-v1-1-c08c2be6befa@google.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin,

kernel test robot noticed the following build errors:

[auto build test ERROR on ffc253263a1375a65fa6c9f62a893e9767fbebfa]

url:    https://github.com/intel-lab-lkp/linux/commits/Justin-Stitt/scsi-libfc-replace-deprecated-strncpy-with-memcpy/20231031-063815
base:   ffc253263a1375a65fa6c9f62a893e9767fbebfa
patch link:    https://lore.kernel.org/r/20231030-strncpy-drivers-scsi-libfc-fc_encode-h-v1-1-c08c2be6befa%40google.com
patch subject: [PATCH] scsi: libfc: replace deprecated strncpy with memcpy
config: i386-randconfig-141-20231102 (https://download.01.org/0day-ci/archive/20231103/202311030603.XIHsNBru-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231103/202311030603.XIHsNBru-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311030603.XIHsNBru-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:32:0:
>> ./usr/include/scsi/fc/fc_ns.h:148:17: error: expected ':', ',', ';', '}' or '__attribute__' before '__nonstring'
     char fp_name[] __nonstring;
                    ^~~~~~~~~~~
   ./usr/include/scsi/fc/fc_ns.h:174:18: error: expected ':', ',', ';', '}' or '__attribute__' before '__nonstring'
     char  fr_name[] __nonstring;
                     ^~~~~~~~~~~
   ./usr/include/scsi/fc/fc_ns.h:183:18: error: expected ':', ',', ';', '}' or '__attribute__' before '__nonstring'
     char  fr_name[] __nonstring;
                     ^~~~~~~~~~~

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
