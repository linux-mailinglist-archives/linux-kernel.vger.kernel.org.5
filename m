Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE2C7F3716
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 21:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjKUUFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 15:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjKUUFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 15:05:21 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFE11A2;
        Tue, 21 Nov 2023 12:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700597117; x=1732133117;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UCGmiu1nxzeNn+cEKPR0gIi35/992X5/vdcGhHlBNsM=;
  b=kQLDQnTYg/OEBUl5BOXwzL6Ucey77hOaP5ke717dgAS1mCBDwm6ZMFf/
   i+kGRxJSN+kr/BHKuzyZb/SduE9ri57oZ7c/tqxh7yOl5NGDJKmeEa/bI
   yPOD6+oa5r6Bs/9fx/sFol0NHDGDFrxenh0EUejMtgFY2XlxU5t2Tp+w9
   /YDYFS9JxW09o/OospAR6KU+vinTC0WEClYE6x/XOQoOkT09vs/AqtqJf
   VWuJPmgVlYppiazlX4CAuKj+s58vWvyWe9Dnt18ZKfLXT5lnFGLrY8QVs
   iBm2H5PQwGuXGaDZk/HdJ3QvMXZWhyenZbAcIQDthx/XlU9SHLEOvgzBk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="5046569"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="5046569"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 12:05:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="801660239"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="801660239"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 21 Nov 2023 12:05:12 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5Wzd-0008Cu-2v;
        Tue, 21 Nov 2023 20:05:09 +0000
Date:   Wed, 22 Nov 2023 04:04:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux XFS <linux-xfs@vger.kernel.org>,
        Linux Kernel Workflows <workflows@vger.kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, Jonathan Corbet <corbet@lwn.net>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Allison Henderson <allison.henderson@oracle.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Charles Han <hanchunchao@inspur.com>
Subject: Re: [PATCH] Documentation: xfs: consolidate XFS docs into its own
 subdirectory
Message-ID: <202311220333.acL7LwXY-lkp@intel.com>
References: <20231121095658.28254-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121095658.28254-1-bagasdotme@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bagas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 98b1cc82c4affc16f5598d4fa14b1858671b2263]

url:    https://github.com/intel-lab-lkp/linux/commits/Bagas-Sanjaya/Documentation-xfs-consolidate-XFS-docs-into-its-own-subdirectory/20231121-180057
base:   98b1cc82c4affc16f5598d4fa14b1858671b2263
patch link:    https://lore.kernel.org/r/20231121095658.28254-1-bagasdotme%40gmail.com
patch subject: [PATCH] Documentation: xfs: consolidate XFS docs into its own subdirectory
reproduce: (https://download.01.org/0day-ci/archive/20231122/202311220333.acL7LwXY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311220333.acL7LwXY-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: Documentation/filesystems/xfs/xfs-online-fsck-design.rst references a file that doesn't exist: Documentation/filesystems/xfs-self-describing-metadata.rst
>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/filesystems/xfs-maintainer-entry-profile.rst
>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/filesystems/xfs-*
>> MAINTAINERS:53207: WARNING: unknown document: ../filesystems/xfs-maintainer-entry-profile

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
