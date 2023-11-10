Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88BA7E7E42
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344205AbjKJRmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235065AbjKJRlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:41:49 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9612C3D54A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 08:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699633456; x=1731169456;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dg22Wq3PqysywqT7YbQ1IvZqL9cc+ziTxMpUngpdOiQ=;
  b=QBOCvGvcOXZGozsdah439uXZymhHhfJjl7nvjLONL74BJ1jHKMSzUWJ4
   9L74+n5HOCZNcCb8hnwT27EabExFFrs/MiZy4QvtDw05QBMxLAJB7lK5W
   09zE15il9v67cPORyBDmgmnUu2Qy4DwKxLbCmUsO85zZTKqpjEOexfHZl
   PP+G8plAcA/ZW53EZpShbRaGsU3SKFS5URiDUFqRcC/+HH8jZXlVK8MH2
   JAv+x7RpTjhgI7J0O2upE0Br+Cx+pxpn1iolGvIq1fywT/iu0HnwTr3Mh
   MXIW+4Z347/E9/3Lf2xw5NabG3sH/rN3y3pNHyEdoCW3+UBMeYb3nWxFm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="393076374"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="393076374"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 08:24:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="757241504"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="757241504"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 10 Nov 2023 08:24:14 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1UIm-0009iw-0B;
        Fri, 10 Nov 2023 16:24:12 +0000
Date:   Sat, 11 Nov 2023 00:23:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: drivers/usb/gadget/function/f_fs.c:2857:32: sparse: sparse:
 incorrect type in assignment (different base types)
Message-ID: <202311110051.7Jgrawd1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   89cdf9d556016a54ff6ddd62324aa5ec790c05cc
commit: bdcc03cef0fd8abc6eaeec6ac47e54ae8f8c625f usb: gadget: f_fs: preserve wMaxPacketSize across usb_ep_autoconfig() call
date:   4 years, 9 months ago
config: i386-randconfig-062-20230912 (https://download.01.org/0day-ci/archive/20231111/202311110051.7Jgrawd1-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231111/202311110051.7Jgrawd1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311110051.7Jgrawd1-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/usb/gadget/function/f_fs.c:2857:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] wMaxPacketSize @@     got restricted __le16 [usertype] wMaxPacketSize @@
   drivers/usb/gadget/function/f_fs.c:2857:32: sparse:     expected unsigned short [usertype] wMaxPacketSize
   drivers/usb/gadget/function/f_fs.c:2857:32: sparse:     got restricted __le16 [usertype] wMaxPacketSize
>> drivers/usb/gadget/function/f_fs.c:2882:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] wMaxPacketSize @@     got unsigned short [usertype] wMaxPacketSize @@
   drivers/usb/gadget/function/f_fs.c:2882:36: sparse:     expected restricted __le16 [usertype] wMaxPacketSize
   drivers/usb/gadget/function/f_fs.c:2882:36: sparse:     got unsigned short [usertype] wMaxPacketSize

vim +2857 drivers/usb/gadget/function/f_fs.c

  2788	
  2789	static int __ffs_func_bind_do_descs(enum ffs_entity_type type, u8 *valuep,
  2790					    struct usb_descriptor_header *desc,
  2791					    void *priv)
  2792	{
  2793		struct usb_endpoint_descriptor *ds = (void *)desc;
  2794		struct ffs_function *func = priv;
  2795		struct ffs_ep *ffs_ep;
  2796		unsigned ep_desc_id;
  2797		int idx;
  2798		static const char *speed_names[] = { "full", "high", "super" };
  2799	
  2800		if (type != FFS_DESCRIPTOR)
  2801			return 0;
  2802	
  2803		/*
  2804		 * If ss_descriptors is not NULL, we are reading super speed
  2805		 * descriptors; if hs_descriptors is not NULL, we are reading high
  2806		 * speed descriptors; otherwise, we are reading full speed
  2807		 * descriptors.
  2808		 */
  2809		if (func->function.ss_descriptors) {
  2810			ep_desc_id = 2;
  2811			func->function.ss_descriptors[(long)valuep] = desc;
  2812		} else if (func->function.hs_descriptors) {
  2813			ep_desc_id = 1;
  2814			func->function.hs_descriptors[(long)valuep] = desc;
  2815		} else {
  2816			ep_desc_id = 0;
  2817			func->function.fs_descriptors[(long)valuep]    = desc;
  2818		}
  2819	
  2820		if (!desc || desc->bDescriptorType != USB_DT_ENDPOINT)
  2821			return 0;
  2822	
  2823		idx = ffs_ep_addr2idx(func->ffs, ds->bEndpointAddress) - 1;
  2824		if (idx < 0)
  2825			return idx;
  2826	
  2827		ffs_ep = func->eps + idx;
  2828	
  2829		if (unlikely(ffs_ep->descs[ep_desc_id])) {
  2830			pr_err("two %sspeed descriptors for EP %d\n",
  2831				  speed_names[ep_desc_id],
  2832				  ds->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK);
  2833			return -EINVAL;
  2834		}
  2835		ffs_ep->descs[ep_desc_id] = ds;
  2836	
  2837		ffs_dump_mem(": Original  ep desc", ds, ds->bLength);
  2838		if (ffs_ep->ep) {
  2839			ds->bEndpointAddress = ffs_ep->descs[0]->bEndpointAddress;
  2840			if (!ds->wMaxPacketSize)
  2841				ds->wMaxPacketSize = ffs_ep->descs[0]->wMaxPacketSize;
  2842		} else {
  2843			struct usb_request *req;
  2844			struct usb_ep *ep;
  2845			u8 bEndpointAddress;
  2846			u16 wMaxPacketSize;
  2847	
  2848			/*
  2849			 * We back up bEndpointAddress because autoconfig overwrites
  2850			 * it with physical endpoint address.
  2851			 */
  2852			bEndpointAddress = ds->bEndpointAddress;
  2853			/*
  2854			 * We back up wMaxPacketSize because autoconfig treats
  2855			 * endpoint descriptors as if they were full speed.
  2856			 */
> 2857			wMaxPacketSize = ds->wMaxPacketSize;
  2858			pr_vdebug("autoconfig\n");
  2859			ep = usb_ep_autoconfig(func->gadget, ds);
  2860			if (unlikely(!ep))
  2861				return -ENOTSUPP;
  2862			ep->driver_data = func->eps + idx;
  2863	
  2864			req = usb_ep_alloc_request(ep, GFP_KERNEL);
  2865			if (unlikely(!req))
  2866				return -ENOMEM;
  2867	
  2868			ffs_ep->ep  = ep;
  2869			ffs_ep->req = req;
  2870			func->eps_revmap[ds->bEndpointAddress &
  2871					 USB_ENDPOINT_NUMBER_MASK] = idx + 1;
  2872			/*
  2873			 * If we use virtual address mapping, we restore
  2874			 * original bEndpointAddress value.
  2875			 */
  2876			if (func->ffs->user_flags & FUNCTIONFS_VIRTUAL_ADDR)
  2877				ds->bEndpointAddress = bEndpointAddress;
  2878			/*
  2879			 * Restore wMaxPacketSize which was potentially
  2880			 * overwritten by autoconfig.
  2881			 */
> 2882			ds->wMaxPacketSize = wMaxPacketSize;
  2883		}
  2884		ffs_dump_mem(": Rewritten ep desc", ds, ds->bLength);
  2885	
  2886		return 0;
  2887	}
  2888	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
