Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9569A80228D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 11:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbjLCKjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 05:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbjLCKjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 05:39:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF06CD
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 02:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701599957; x=1733135957;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3a27ZNRlNF+Byuf5bp+hmcmAsAv8Sq20VM/7K1q5QlI=;
  b=DeTP4rIRl6RwydXNp8hur5ilDOKTuF34ltQ720P4hepH9lBiw10ynMp5
   qN5Bl0/GhX+ri9cL5VfNOu3zg7mOqXNZGTjRnNA8i43mys7qYOacvTgbF
   XtW+whchsMuOJLUlJZcEwoSwDDx0B7lggIUNlFkgra7j6fjaQz68OaQ0a
   NW4DYuQN9VAt9oAInCvkDePj11+tlGH8PvD6/xNXIa1kwKC58mz6KvPwB
   OtKwUAnEntsaOaLlQ2iUiKBn+Hlhp05wicnkZgMs4p/tTEKuBbB6iHdMZ
   5p/eM2gvlSSe0d+apZnlrEWutdnb0zpQv4jUwCSd/8ZWR5fwgWZfotbAP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="678842"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="678842"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2023 02:39:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="1017549190"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="1017549190"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 03 Dec 2023 02:39:15 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r9jsX-0006Ya-0G;
        Sun, 03 Dec 2023 10:39:13 +0000
Date:   Sun, 3 Dec 2023 18:38:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Lombard <clombard@linux.vnet.ibm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
        Manoj Kumar <manoj@linux.vnet.ibm.com>
Subject: drivers/misc/cxl/guest.c:68:33: sparse: sparse: incorrect type in
 assignment (different base types)
Message-ID: <202312031832.x2ghPHYm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   968f35f4ab1c0966ceb39af3c89f2e24afedf878
commit: 14baf4d9c739e6e69150512d2eb23c71fffcc192 cxl: Add guest-specific code
date:   8 years ago
config: powerpc64-randconfig-r113-20231107 (https://download.01.org/0day-ci/archive/20231203/202312031832.x2ghPHYm-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231203/202312031832.x2ghPHYm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312031832.x2ghPHYm-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/misc/cxl/guest.c:68:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] phys_addr @@     got restricted __be64 [usertype] @@
   drivers/misc/cxl/guest.c:68:33: sparse:     expected unsigned long long [usertype] phys_addr
   drivers/misc/cxl/guest.c:68:33: sparse:     got restricted __be64 [usertype]
>> drivers/misc/cxl/guest.c:69:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] len @@     got restricted __be64 [usertype] @@
   drivers/misc/cxl/guest.c:69:27: sparse:     expected unsigned long long [usertype] len
   drivers/misc/cxl/guest.c:69:27: sparse:     got restricted __be64 [usertype]
   drivers/misc/cxl/guest.c:71:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] len @@     got restricted __be64 [usertype] @@
   drivers/misc/cxl/guest.c:71:35: sparse:     expected unsigned long long [usertype] len
   drivers/misc/cxl/guest.c:71:35: sparse:     got restricted __be64 [usertype]
   drivers/misc/cxl/guest.c:363:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/misc/cxl/guest.c:363:33: sparse:     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr
   drivers/misc/cxl/guest.c:363:33: sparse:     got unsigned short [usertype] *
   drivers/misc/cxl/guest.c:366:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int const volatile [noderef] [usertype] <asn:2> *addr @@     got unsigned int * @@
   drivers/misc/cxl/guest.c:366:33: sparse:     expected unsigned int const volatile [noderef] [usertype] <asn:2> *addr
   drivers/misc/cxl/guest.c:366:33: sparse:     got unsigned int *
   drivers/misc/cxl/guest.c:369:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long const volatile [noderef] [usertype] <asn:2> *addr @@     got unsigned long long [usertype] * @@
   drivers/misc/cxl/guest.c:369:33: sparse:     expected unsigned long long const volatile [noderef] [usertype] <asn:2> *addr
   drivers/misc/cxl/guest.c:369:33: sparse:     got unsigned long long [usertype] *
>> drivers/misc/cxl/guest.c:439:23: sparse: sparse: invalid assignment: |=
>> drivers/misc/cxl/guest.c:439:23: sparse:    left side has type restricted __be64
>> drivers/misc/cxl/guest.c:439:23: sparse:    right side has type unsigned long long
   drivers/misc/cxl/guest.c:440:23: sparse: sparse: invalid assignment: |=
   drivers/misc/cxl/guest.c:440:23: sparse:    left side has type restricted __be64
   drivers/misc/cxl/guest.c:440:23: sparse:    right side has type unsigned long long
   drivers/misc/cxl/guest.c:442:31: sparse: sparse: invalid assignment: |=
   drivers/misc/cxl/guest.c:442:31: sparse:    left side has type restricted __be64
   drivers/misc/cxl/guest.c:442:31: sparse:    right side has type unsigned long long
   drivers/misc/cxl/guest.c:445:23: sparse: sparse: invalid assignment: |=
   drivers/misc/cxl/guest.c:445:23: sparse:    left side has type restricted __be64
   drivers/misc/cxl/guest.c:445:23: sparse:    right side has type unsigned long long
   drivers/misc/cxl/guest.c:446:23: sparse: sparse: invalid assignment: |=
   drivers/misc/cxl/guest.c:446:23: sparse:    left side has type restricted __be64
   drivers/misc/cxl/guest.c:446:23: sparse:    right side has type unsigned long long
   drivers/misc/cxl/guest.c:448:31: sparse: sparse: invalid assignment: |=
   drivers/misc/cxl/guest.c:448:31: sparse:    left side has type restricted __be64
   drivers/misc/cxl/guest.c:448:31: sparse:    right side has type unsigned long long
   drivers/misc/cxl/guest.c:451:31: sparse: sparse: invalid assignment: |=
   drivers/misc/cxl/guest.c:451:31: sparse:    left side has type restricted __be64
   drivers/misc/cxl/guest.c:451:31: sparse:    right side has type unsigned long long
>> drivers/misc/cxl/guest.c:454:31: sparse: sparse: cast from restricted __be64
   drivers/misc/cxl/guest.c:454:31: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __be64 [usertype] flags @@
   drivers/misc/cxl/guest.c:454:31: sparse:     expected unsigned long long [usertype] val
   drivers/misc/cxl/guest.c:454:31: sparse:     got restricted __be64 [usertype] flags
>> drivers/misc/cxl/guest.c:454:31: sparse: sparse: cast from restricted __be64
>> drivers/misc/cxl/guest.c:454:31: sparse: sparse: cast from restricted __be64
>> drivers/misc/cxl/guest.c:454:31: sparse: sparse: cast from restricted __be64
>> drivers/misc/cxl/guest.c:454:31: sparse: sparse: cast from restricted __be64
>> drivers/misc/cxl/guest.c:454:31: sparse: sparse: cast from restricted __be64
>> drivers/misc/cxl/guest.c:454:31: sparse: sparse: cast from restricted __be64
>> drivers/misc/cxl/guest.c:454:31: sparse: sparse: cast from restricted __be64
>> drivers/misc/cxl/guest.c:454:31: sparse: sparse: cast from restricted __be64
   drivers/misc/cxl/guest.c: In function 'afu_properties_look_ok':
   drivers/misc/cxl/guest.c:708:26: warning: comparison of unsigned expression in '< 0' is always false [-Wtype-limits]
     708 |         if (afu->crs_len < 0) {
         |                          ^

vim +68 drivers/misc/cxl/guest.c

    27	
    28	static ssize_t guest_collect_vpd(struct cxl *adapter, struct cxl_afu *afu,
    29				void *buf, size_t len)
    30	{
    31		unsigned int entries, mod;
    32		unsigned long **vpd_buf = NULL;
    33		struct sg_list *le;
    34		int rc = 0, i, tocopy;
    35		u64 out = 0;
    36	
    37		if (buf == NULL)
    38			return -EINVAL;
    39	
    40		/* number of entries in the list */
    41		entries = len / SG_BUFFER_SIZE;
    42		mod = len % SG_BUFFER_SIZE;
    43		if (mod)
    44			entries++;
    45	
    46		if (entries > SG_MAX_ENTRIES) {
    47			entries = SG_MAX_ENTRIES;
    48			len = SG_MAX_ENTRIES * SG_BUFFER_SIZE;
    49			mod = 0;
    50		}
    51	
    52		vpd_buf = kzalloc(entries * sizeof(unsigned long *), GFP_KERNEL);
    53		if (!vpd_buf)
    54			return -ENOMEM;
    55	
    56		le = (struct sg_list *)get_zeroed_page(GFP_KERNEL);
    57		if (!le) {
    58			rc = -ENOMEM;
    59			goto err1;
    60		}
    61	
    62		for (i = 0; i < entries; i++) {
    63			vpd_buf[i] = (unsigned long *)get_zeroed_page(GFP_KERNEL);
    64			if (!vpd_buf[i]) {
    65				rc = -ENOMEM;
    66				goto err2;
    67			}
  > 68			le[i].phys_addr = cpu_to_be64(virt_to_phys(vpd_buf[i]));
  > 69			le[i].len = cpu_to_be64(SG_BUFFER_SIZE);
    70			if ((i == (entries - 1)) && mod)
    71				le[i].len = cpu_to_be64(mod);
    72		}
    73	
    74		if (adapter)
    75			rc = cxl_h_collect_vpd_adapter(adapter->guest->handle,
    76						virt_to_phys(le), entries, &out);
    77		else
    78			rc = cxl_h_collect_vpd(afu->guest->handle, 0,
    79					virt_to_phys(le), entries, &out);
    80		pr_devel("length of available (entries: %i), vpd: %#llx\n",
    81			entries, out);
    82	
    83		if (!rc) {
    84			/*
    85			 * hcall returns in 'out' the size of available VPDs.
    86			 * It fills the buffer with as much data as possible.
    87			 */
    88			if (out < len)
    89				len = out;
    90			rc = len;
    91			if (out) {
    92				for (i = 0; i < entries; i++) {
    93					if (len < SG_BUFFER_SIZE)
    94						tocopy = len;
    95					else
    96						tocopy = SG_BUFFER_SIZE;
    97					memcpy(buf, vpd_buf[i], tocopy);
    98					buf += tocopy;
    99					len -= tocopy;
   100				}
   101			}
   102		}
   103	err2:
   104		for (i = 0; i < entries; i++) {
   105			if (vpd_buf[i])
   106				free_page((unsigned long) vpd_buf[i]);
   107		}
   108		free_page((unsigned long) le);
   109	err1:
   110		kfree(vpd_buf);
   111		return rc;
   112	}
   113	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
