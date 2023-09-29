Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08027B2AB7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 05:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbjI2DuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 23:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjI2DuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 23:50:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE15D19C;
        Thu, 28 Sep 2023 20:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695959413; x=1727495413;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w/kAqvgsgUzhv5vKUtln/Wpub4WfuqcCvxk+jrVXcCI=;
  b=FRdgfwOy62bDuJ7W42qmYP2KjrwZEBn+NxBCdEaZNf/VPUK0+oHBic+S
   YDWtNbCB12TMMB5B46OpaN4ZDP0cgnC43Ct07fmopUUcoaOuJLd2USgCX
   xVSWr7Maap2qjX5JYVKzRiHM3sBPEu+OrFP/ZkvhiBHYAvXaWFulQ9m2a
   oTj57ee9aewbbwihvIWNAiDmNofebesSPn1X8mXz87J7CmGeDm0+jxBpf
   5XcjLA6HRZ79EsS+psRT7KiV/gaeqvwZgNVmu5VgVVrR+Lgx9zdH8I1vb
   sM45F9qKBwwn/Yp9hV8EfY7YHEGD6TQRw+Q0M+IHYV+gX7BkLrr9deHtX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="382129615"
X-IronPort-AV: E=Sophos;i="6.03,186,1694761200"; 
   d="scan'208";a="382129615"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 20:50:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="840153422"
X-IronPort-AV: E=Sophos;i="6.03,186,1694761200"; 
   d="scan'208";a="840153422"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Sep 2023 20:50:09 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qm4Vy-0002RT-2r;
        Fri, 29 Sep 2023 03:50:06 +0000
Date:   Fri, 29 Sep 2023 11:49:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Graf <graf@amazon.com>, linux-crypto@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Olivia Mackall <olivia@selenic.com>,
        Petre Eftime <petre.eftime@gmail.com>,
        Erdem Meydanlli <meydanli@amazon.nl>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 2/2] hwrng: Add support for Nitro Secure Module
Message-ID: <202309291132.Cr0muwNb-lkp@intel.com>
References: <20230928224645.19768-3-graf@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928224645.19768-3-graf@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

kernel test robot noticed the following build warnings:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on char-misc/char-misc-next char-misc/char-misc-linus herbert-cryptodev-2.6/master soc/for-next linus/master v6.6-rc3 next-20230928]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Graf/misc-Add-Nitro-Secure-Module-driver/20230929-064844
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20230928224645.19768-3-graf%40amazon.com
patch subject: [PATCH 2/2] hwrng: Add support for Nitro Secure Module
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230929/202309291132.Cr0muwNb-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230929/202309291132.Cr0muwNb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309291132.Cr0muwNb-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/char/hw_random/nsm-rng.c:275:38: warning: 'nsm_id_table' defined but not used [-Wunused-const-variable=]
     275 | static const struct virtio_device_id nsm_id_table[] = {
         |                                      ^~~~~~~~~~~~


vim +/nsm_id_table +275 drivers/char/hw_random/nsm-rng.c

   274	
 > 275	static const struct virtio_device_id nsm_id_table[] = {
   276		{ VIRTIO_ID_NITRO_SEC_MOD, VIRTIO_DEV_ANY_ID },
   277		{ 0 },
   278	};
   279	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
