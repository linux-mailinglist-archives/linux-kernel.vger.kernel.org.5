Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9238C7F2AEE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbjKUKqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjKUKqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:46:19 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA8DA2;
        Tue, 21 Nov 2023 02:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700563576; x=1732099576;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PBhDtUKwPikfG8y2V5EOoH+DV4F1XcXhwlk7+zHLYQo=;
  b=jjW5KeC1gzgZhQhLWpWNWKEm0n2GtdTdc/PvOJNUpT1BxRyeXDfjaKrz
   ZuWOIbPVbEEAbN9gCMC10SQnY+G+pV2M/C9LamyrYU9+myDV8koK8X5tf
   KJk6PUy6WTPrGeMD5GrwTNzAS8qLwOgrNpUYkEv6w9o92SHfh6imuSxfi
   OX/Ha8N/+Kvz6kTbJW0IMsY8CGuvRrHPsxOMNSAjPtuuNAt9gIh2zoFLo
   ObYe0T4IKIAE9Kfm73J9DdkxQZ7Or+/y42GR0+vL4MrleLqAACAT5iVNv
   ilIjEsx7qGyEspSglEUsXzesgJHPlIRe1ypAzcbleeNSD0PO98qWUkRN9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="371988248"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="371988248"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 02:46:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="1098020667"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="1098020667"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 21 Nov 2023 02:46:09 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5OGG-0007hh-0s;
        Tue, 21 Nov 2023 10:45:52 +0000
Date:   Tue, 21 Nov 2023 18:44:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Philipp Stanner <pstanner@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Eric Auger <eric.auger@redhat.com>,
        Kent Overstreet <kmo@daterainc.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        NeilBrown <neilb@suse.de>, John Sanpe <sanpeqf@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        David Gow <davidgow@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>,
        Jason Baron <jbaron@akamai.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Danilo Krummrich <dakr@redhat.com>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/4] lib: move pci_iomap.c to drivers/pci/
Message-ID: <202311211833.tfTYR1cP-lkp@intel.com>
References: <20231120215945.52027-3-pstanner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120215945.52027-3-pstanner@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.7-rc2 next-20231121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Philipp-Stanner/lib-move-pci_iomap-c-to-drivers-pci/20231121-060258
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20231120215945.52027-3-pstanner%40redhat.com
patch subject: [PATCH 1/4] lib: move pci_iomap.c to drivers/pci/
config: arm64-kismet-CONFIG_GENERIC_PCI_IOMAP-CONFIG_ARM64-0-0 (https://download.01.org/0day-ci/archive/20231121/202311211833.tfTYR1cP-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20231121/202311211833.tfTYR1cP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311211833.tfTYR1cP-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for GENERIC_PCI_IOMAP when selected by ARM64
   
   WARNING: unmet direct dependencies detected for GENERIC_PCI_IOMAP
     Depends on [n]: PCI [=n]
     Selected by [y]:
     - ARM64 [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
