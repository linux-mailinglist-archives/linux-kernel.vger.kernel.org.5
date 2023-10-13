Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A0F7C88F4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 17:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjJMPn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 11:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbjJMPny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 11:43:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B27B7;
        Fri, 13 Oct 2023 08:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697211832; x=1728747832;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=29s3G1E9QTs2ByafqFzcoETkhW2Zmk6RFxqLUJpfMg4=;
  b=nSXee22DwG/hXZS82mu2mR2s8jD5nVzDLGztMHa2GzkciKIglmh/arQh
   DAdVqHowsUq5zd2kELZe2yvLQMk2xMV0VCUxvG/MJFMWdfDofqODmxzvh
   mT/acw52XYjYh7gpF6GCoiIY2mP0Xw0S1sWqWp54Dqrx6w8bLh5hIrB3W
   poMXMP8iZsFtS7AR5VjwCYrfEO+kYoRGSs1H4IQPYbXnuW5L1lrXdqgux
   M+0Vi44CXsY51PDbNxV/+xTwQtEbDgNI5GVAOgpvpNWNwISTqrTT44xXk
   uo2Hq5qB7qju8hjGMyanEenMsomL8dsYDg0DegguCUswfH2bA/pwOGp+L
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="370274666"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="370274666"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 08:43:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="928461808"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="928461808"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 13 Oct 2023 08:43:44 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qrKKE-00052P-0v;
        Fri, 13 Oct 2023 15:43:42 +0000
Date:   Fri, 13 Oct 2023 23:43:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Graf <graf@amazon.com>, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-crypto@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Olivia Mackall <olivia@selenic.com>,
        Petre Eftime <petre.eftime@gmail.com>,
        Erdem Meydanlli <meydanli@amazon.nl>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Kyunghwan Kwon <k@mononn.com>
Subject: Re: [PATCH v4 2/2] misc: Add Nitro Secure Module driver
Message-ID: <202310132329.UIMS3J8a-lkp@intel.com>
References: <20231009212053.2007-3-graf@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009212053.2007-3-graf@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

kernel test robot noticed the following build errors:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on char-misc/char-misc-next char-misc/char-misc-linus soc/for-next linus/master v6.6-rc5 next-20231012]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Graf/Import-CBOR-library/20231010-052529
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20231009212053.2007-3-graf%40amazon.com
patch subject: [PATCH v4 2/2] misc: Add Nitro Secure Module driver
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20231013/202310132329.UIMS3J8a-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231013/202310132329.UIMS3J8a-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310132329.UIMS3J8a-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/asm-generic/ioctl.h:5,
                    from arch/powerpc/include/uapi/asm/ioctl.h:12,
                    from include/uapi/linux/ioctl.h:5,
                    from include/uapi/linux/random.h:12,
                    from include/linux/random.h:10,
                    from include/linux/nodemask.h:97,
                    from include/linux/list_lru.h:12,
                    from include/linux/fs.h:13,
                    from drivers/misc/nsm.c:23:
>> include/uapi/asm-generic/ioctl.h:70:9: error: initializer element is not constant
      70 |         (((dir)  << _IOC_DIRSHIFT) | \
         |         ^
   include/uapi/asm-generic/ioctl.h:88:33: note: in expansion of macro '_IOC'
      88 | #define _IOWR(type,nr,size)     _IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))
         |                                 ^~~~
   include/uapi/linux/nsm.h:172:33: note: in expansion of macro '_IOWR'
     172 | #define NSM_IOCTL_ATTESTATION   _IOWR(NSM_MAGIC, 0x6, union nsm_attestation)
         |                                 ^~~~~
   drivers/misc/nsm.c:1209:11: note: in expansion of macro 'NSM_IOCTL_ATTESTATION'
    1209 |         { NSM_IOCTL_ATTESTATION, _fill_req_attestation, _parse_resp_attestation },
         |           ^~~~~~~~~~~~~~~~~~~~~
   include/uapi/asm-generic/ioctl.h:70:9: note: (near initialization for 'nsm_ioctls[6].cmd')
      70 |         (((dir)  << _IOC_DIRSHIFT) | \
         |         ^
   include/uapi/asm-generic/ioctl.h:88:33: note: in expansion of macro '_IOC'
      88 | #define _IOWR(type,nr,size)     _IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))
         |                                 ^~~~
   include/uapi/linux/nsm.h:172:33: note: in expansion of macro '_IOWR'
     172 | #define NSM_IOCTL_ATTESTATION   _IOWR(NSM_MAGIC, 0x6, union nsm_attestation)
         |                                 ^~~~~
   drivers/misc/nsm.c:1209:11: note: in expansion of macro 'NSM_IOCTL_ATTESTATION'
    1209 |         { NSM_IOCTL_ATTESTATION, _fill_req_attestation, _parse_resp_attestation },
         |           ^~~~~~~~~~~~~~~~~~~~~
>> include/uapi/asm-generic/ioctl.h:70:9: error: initializer element is not constant
      70 |         (((dir)  << _IOC_DIRSHIFT) | \
         |         ^
   include/uapi/asm-generic/ioctl.h:88:33: note: in expansion of macro '_IOC'
      88 | #define _IOWR(type,nr,size)     _IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))
         |                                 ^~~~
   include/uapi/linux/nsm.h:186:33: note: in expansion of macro '_IOWR'
     186 | #define NSM_IOCTL_RANDOM        _IOWR(NSM_MAGIC, 0x7, union nsm_get_random)
         |                                 ^~~~~
   drivers/misc/nsm.c:1210:11: note: in expansion of macro 'NSM_IOCTL_RANDOM'
    1210 |         { NSM_IOCTL_RANDOM, _fill_req_get_random, _parse_resp_get_random },
         |           ^~~~~~~~~~~~~~~~
   include/uapi/asm-generic/ioctl.h:70:9: note: (near initialization for 'nsm_ioctls[7].cmd')
      70 |         (((dir)  << _IOC_DIRSHIFT) | \
         |         ^
   include/uapi/asm-generic/ioctl.h:88:33: note: in expansion of macro '_IOC'
      88 | #define _IOWR(type,nr,size)     _IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))
         |                                 ^~~~
   include/uapi/linux/nsm.h:186:33: note: in expansion of macro '_IOWR'
     186 | #define NSM_IOCTL_RANDOM        _IOWR(NSM_MAGIC, 0x7, union nsm_get_random)
         |                                 ^~~~~
   drivers/misc/nsm.c:1210:11: note: in expansion of macro 'NSM_IOCTL_RANDOM'
    1210 |         { NSM_IOCTL_RANDOM, _fill_req_get_random, _parse_resp_get_random },
         |           ^~~~~~~~~~~~~~~~


vim +70 include/uapi/asm-generic/ioctl.h

8a1ab3155c2ac7 David Howells 2012-10-04  68  
8a1ab3155c2ac7 David Howells 2012-10-04  69  #define _IOC(dir,type,nr,size) \
8a1ab3155c2ac7 David Howells 2012-10-04 @70  	(((dir)  << _IOC_DIRSHIFT) | \
8a1ab3155c2ac7 David Howells 2012-10-04  71  	 ((type) << _IOC_TYPESHIFT) | \
8a1ab3155c2ac7 David Howells 2012-10-04  72  	 ((nr)   << _IOC_NRSHIFT) | \
8a1ab3155c2ac7 David Howells 2012-10-04  73  	 ((size) << _IOC_SIZESHIFT))
8a1ab3155c2ac7 David Howells 2012-10-04  74  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
