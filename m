Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186E57EFFF1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 14:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjKRNnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 08:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjKRNnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 08:43:45 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F0A192;
        Sat, 18 Nov 2023 05:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700315022; x=1731851022;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9MWXGlWBn8UuC12s5U/dQnooTb1ww7S8zFPKpErj42I=;
  b=d8uQvZyz2N9DON0fFFaoH1VgyzD25BxxwQYaLGi1KYk0k1we2WpBWgU2
   VxbOOpOlUV0h/Get+PjxQ+x6DSBON12slj2xSZulH6EA1v/dAjmu4JvAf
   2FpRPR9q6TROGmOO1r3e5j+DKPcjM2NemBEub58MCWi35zm9PGqtBrzeQ
   PBo66jj36Sb21wWdDHIO3yfDdyS4gYvZO+BsreNkDWCzROssIuZPB8D6C
   rlq+Mhstb9sOcQm16jKH/WNlfw99Es6Djuef8sDwpesp2KuVQ/QpUAmj8
   uv2jhuTbkZYVctK344LTTyBN36rdS30JVSU2dvboWKNhlaHvjCbuplAC7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="371604274"
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="371604274"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2023 05:43:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="759414052"
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="759414052"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 18 Nov 2023 05:43:39 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4Lbk-0003wx-1L;
        Sat, 18 Nov 2023 13:43:36 +0000
Date:   Sat, 18 Nov 2023 21:43:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Prashanth K <quic_prashk@quicinc.com>, stable@vger.kernel.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Mathias Nyman <mathias.nyman@intel.com>,
        Tejas Joglekar <joglekar@synopsys.com>,
        linux-kernel@vger.kernel.org, linux-usbyy@vger.kernel.org,
        Prashanth K <quic_prashk@quicinc.com>
Subject: Re: [PATCH 1/2] usb: dwc3: core: Add support for
 xhci-sg-trb-cache-size-quirk
Message-ID: <202311182124.Rhvs60sb-lkp@intel.com>
References: <20231118055455.249088-2-quic_prashk@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231118055455.249088-2-quic_prashk@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashanth,

kernel test robot noticed the following build errors:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on usb/usb-next usb/usb-linus linus/master v6.7-rc1 next-20231117]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Prashanth-K/usb-dwc3-core-Add-support-for-xhci-sg-trb-cache-size-quirk/20231118-135837
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20231118055455.249088-2-quic_prashk%40quicinc.com
patch subject: [PATCH 1/2] usb: dwc3: core: Add support for xhci-sg-trb-cache-size-quirk
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20231118/202311182124.Rhvs60sb-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231118/202311182124.Rhvs60sb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311182124.Rhvs60sb-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/usb/dwc3/host.c: In function 'dwc3_host_init':
>> drivers/usb/dwc3/host.c:66:16: error: variable 'dwc3_xhci_plat_priv' has initializer but incomplete type
      66 |         struct xhci_plat_priv   dwc3_xhci_plat_priv = {0};
         |                ^~~~~~~~~~~~~~
   drivers/usb/dwc3/host.c:66:56: warning: excess elements in struct initializer
      66 |         struct xhci_plat_priv   dwc3_xhci_plat_priv = {0};
         |                                                        ^
   drivers/usb/dwc3/host.c:66:56: note: (near initialization for 'dwc3_xhci_plat_priv')
>> drivers/usb/dwc3/host.c:66:33: error: storage size of 'dwc3_xhci_plat_priv' isn't known
      66 |         struct xhci_plat_priv   dwc3_xhci_plat_priv = {0};
         |                                 ^~~~~~~~~~~~~~~~~~~
>> drivers/usb/dwc3/host.c:92:47: error: 'XHCI_SG_TRB_CACHE_SIZE_QUIRK' undeclared (first use in this function)
      92 |                 dwc3_xhci_plat_priv.quirks |= XHCI_SG_TRB_CACHE_SIZE_QUIRK;
         |                                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/usb/dwc3/host.c:92:47: note: each undeclared identifier is reported only once for each function it appears in
   drivers/usb/dwc3/host.c:66:33: warning: unused variable 'dwc3_xhci_plat_priv' [-Wunused-variable]
      66 |         struct xhci_plat_priv   dwc3_xhci_plat_priv = {0};
         |                                 ^~~~~~~~~~~~~~~~~~~


vim +/dwc3_xhci_plat_priv +66 drivers/usb/dwc3/host.c

    61	
    62	int dwc3_host_init(struct dwc3 *dwc)
    63	{
    64		struct property_entry	props[4];
    65		struct platform_device	*xhci;
  > 66		struct xhci_plat_priv   dwc3_xhci_plat_priv = {0};
    67		int			ret, irq;
    68		int			prop_idx = 0;
    69	
    70		irq = dwc3_host_get_irq(dwc);
    71		if (irq < 0)
    72			return irq;
    73	
    74		xhci = platform_device_alloc("xhci-hcd", PLATFORM_DEVID_AUTO);
    75		if (!xhci) {
    76			dev_err(dwc->dev, "couldn't allocate xHCI device\n");
    77			return -ENOMEM;
    78		}
    79	
    80		xhci->dev.parent	= dwc->dev;
    81	
    82		dwc->xhci = xhci;
    83	
    84		ret = platform_device_add_resources(xhci, dwc->xhci_resources,
    85							DWC3_XHCI_RESOURCES_NUM);
    86		if (ret) {
    87			dev_err(dwc->dev, "couldn't add resources to xHCI device\n");
    88			goto err;
    89		}
    90	
    91		if (dwc->xhci_sg_trb_cache_size_quirk)
  > 92			dwc3_xhci_plat_priv.quirks |= XHCI_SG_TRB_CACHE_SIZE_QUIRK;
    93	
    94		ret = platform_device_add_data(xhci, &dwc3_xhci_plat_priv,
    95						sizeof(dwc3_xhci_plat_priv));
    96		if (ret)
    97			goto err;
    98	
    99		memset(props, 0, sizeof(struct property_entry) * ARRAY_SIZE(props));
   100	
   101		if (dwc->usb3_lpm_capable)
   102			props[prop_idx++] = PROPERTY_ENTRY_BOOL("usb3-lpm-capable");
   103	
   104		if (dwc->usb2_lpm_disable)
   105			props[prop_idx++] = PROPERTY_ENTRY_BOOL("usb2-lpm-disable");
   106	
   107		/**
   108		 * WORKAROUND: dwc3 revisions <=3.00a have a limitation
   109		 * where Port Disable command doesn't work.
   110		 *
   111		 * The suggested workaround is that we avoid Port Disable
   112		 * completely.
   113		 *
   114		 * This following flag tells XHCI to do just that.
   115		 */
   116		if (DWC3_VER_IS_WITHIN(DWC3, ANY, 300A))
   117			props[prop_idx++] = PROPERTY_ENTRY_BOOL("quirk-broken-port-ped");
   118	
   119		if (prop_idx) {
   120			ret = device_create_managed_software_node(&xhci->dev, props, NULL);
   121			if (ret) {
   122				dev_err(dwc->dev, "failed to add properties to xHCI\n");
   123				goto err;
   124			}
   125		}
   126	
   127		ret = platform_device_add(xhci);
   128		if (ret) {
   129			dev_err(dwc->dev, "failed to register xHCI device\n");
   130			goto err;
   131		}
   132	
   133		return 0;
   134	err:
   135		platform_device_put(xhci);
   136		return ret;
   137	}
   138	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
