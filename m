Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3B87F3FB5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 09:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbjKVIJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 03:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjKVIJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 03:09:02 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B96AA4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 00:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700640539; x=1732176539;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Olh97AEw3cHh3CcGD8iy2jgIvgYXVQ7jajDoWvg/CKc=;
  b=NkIUkVm5q6a36UadmvxoFySDktCN0pMwAkuiqhDxFZPUrqsQqCXaPdz3
   eXOOAeFXDKuBmjuPXUH9zjDVpjmtWRaf4w9C6D9GImUPFr0TDQoB60FiH
   ihV7Xv3Mt6IpiGoavrFoWGcimuG4UT9VOZavZ33Hh4X1nnQO8xwv/K7j9
   eIQEIsN2/tmDyzfTFHAqcoaofXP3cGyca9wPwnAXao/0rf7fIELpcL0VU
   wcKtguV7/gXezE+kU1Y3tdY66TgU6L5DQLgf2pK+hsCKngmHFOcCStq7U
   zmFDSNNMNbuKCzNApWQNBWYGnpqhytQgxC/7fa4NNmwA4OH0MJ8po3lr4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="10670223"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="10670223"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 00:08:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="743319818"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="743319818"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 22 Nov 2023 00:08:56 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5iI1-0000Fa-2Z;
        Wed, 22 Nov 2023 08:08:53 +0000
Date:   Wed, 22 Nov 2023 16:08:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     syzbot <syzbot+c52569baf0c843f35495@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] Tried to correct
Message-ID: <202311221446.bQ7tsWmE-lkp@intel.com>
References: <000000000000c0be0d060aae7c5b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000c0be0d060aae7c5b@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi syzbot,

kernel test robot noticed the following build warnings:

[auto build test WARNING on hid/for-next]
[also build test WARNING on linus/master v6.7-rc2 next-20231122]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/syzbot/Tried-to-correct/20231122-032130
base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
patch link:    https://lore.kernel.org/r/000000000000c0be0d060aae7c5b%40google.com
patch subject: [PATCH] Tried to correct
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20231122/202311221446.bQ7tsWmE-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231122/202311221446.bQ7tsWmE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311221446.bQ7tsWmE-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hid/usbhid/hid-core.c:1026:3: warning: misleading indentation; statement is not part of the previous 'for' [-Wmisleading-indentation]
                   if (hdesc->desc[n].bDescriptorType == HID_DT_REPORT)
                   ^
   drivers/hid/usbhid/hid-core.c:1023:2: note: previous statement is here
           for (n = 0; n < num_descriptors; n++)
           ^
   1 warning generated.


vim +/for +1026 drivers/hid/usbhid/hid-core.c

^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds     2005-04-16   978  
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby         2008-05-16   979  static int usbhid_parse(struct hid_device *hid)
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby         2008-05-16   980  {
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby         2008-05-16   981  	struct usb_interface *intf = to_usb_interface(hid->dev.parent);
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds     2005-04-16   982  	struct usb_host_interface *interface = intf->cur_altsetting;
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds     2005-04-16   983  	struct usb_device *dev = interface_to_usbdev (intf);
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds     2005-04-16   984  	struct hid_descriptor *hdesc;
2eb5dc30eb87aa drivers/hid/usbhid/hid-core.c Paul Walmsley      2007-04-19   985  	u32 quirks = 0;
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby         2008-05-16   986  	unsigned int rsize = 0;
c5b7c7c395a34f drivers/usb/input/hid-core.c  Dmitry Torokhov    2005-09-15   987  	char *rdesc;
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby         2008-05-16   988  	int ret, n;
f043bfc98c193c drivers/hid/usbhid/hid-core.c Jaejoong Kim       2017-09-28   989  	int num_descriptors;
f043bfc98c193c drivers/hid/usbhid/hid-core.c Jaejoong Kim       2017-09-28   990  	size_t offset = offsetof(struct hid_descriptor, desc);
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds     2005-04-16   991  
d5d3e202753cc0 drivers/hid/usbhid/hid-core.c Benjamin Tissoires 2017-11-20   992  	quirks = hid_lookup_quirk(hid);
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds     2005-04-16   993  
6f4303fb2ec680 drivers/hid/usbhid/hid-core.c Jiri Kosina        2009-01-29   994  	if (quirks & HID_QUIRK_IGNORE)
6f4303fb2ec680 drivers/hid/usbhid/hid-core.c Jiri Kosina        2009-01-29   995  		return -ENODEV;
6f4303fb2ec680 drivers/hid/usbhid/hid-core.c Jiri Kosina        2009-01-29   996  
0f28b55db54300 drivers/usb/input/hid-core.c  Alan Stern         2006-05-15   997  	/* Many keyboards and mice don't like to be polled for reports,
0f28b55db54300 drivers/usb/input/hid-core.c  Alan Stern         2006-05-15   998  	 * so we will always set the HID_QUIRK_NOGET flag for them. */
0f28b55db54300 drivers/usb/input/hid-core.c  Alan Stern         2006-05-15   999  	if (interface->desc.bInterfaceSubClass == USB_INTERFACE_SUBCLASS_BOOT) {
0f28b55db54300 drivers/usb/input/hid-core.c  Alan Stern         2006-05-15  1000  		if (interface->desc.bInterfaceProtocol == USB_INTERFACE_PROTOCOL_KEYBOARD ||
0f28b55db54300 drivers/usb/input/hid-core.c  Alan Stern         2006-05-15  1001  			interface->desc.bInterfaceProtocol == USB_INTERFACE_PROTOCOL_MOUSE)
0f28b55db54300 drivers/usb/input/hid-core.c  Alan Stern         2006-05-15  1002  				quirks |= HID_QUIRK_NOGET;
0f28b55db54300 drivers/usb/input/hid-core.c  Alan Stern         2006-05-15  1003  	}
0f28b55db54300 drivers/usb/input/hid-core.c  Alan Stern         2006-05-15  1004  
c5b7c7c395a34f drivers/usb/input/hid-core.c  Dmitry Torokhov    2005-09-15  1005  	if (usb_get_extra_descriptor(interface, HID_DT_HID, &hdesc) &&
c5b7c7c395a34f drivers/usb/input/hid-core.c  Dmitry Torokhov    2005-09-15  1006  	    (!interface->desc.bNumEndpoints ||
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds     2005-04-16  1007  	     usb_get_extra_descriptor(&interface->endpoint[0], HID_DT_HID, &hdesc))) {
58037eb961f859 drivers/hid/usbhid/hid-core.c Jiri Kosina        2007-05-30  1008  		dbg_hid("class descriptor not present\n");
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby         2008-05-16  1009  		return -ENODEV;
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds     2005-04-16  1010  	}
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds     2005-04-16  1011  
f043bfc98c193c drivers/hid/usbhid/hid-core.c Jaejoong Kim       2017-09-28  1012  	if (hdesc->bLength < sizeof(struct hid_descriptor)) {
f043bfc98c193c drivers/hid/usbhid/hid-core.c Jaejoong Kim       2017-09-28  1013  		dbg_hid("hid descriptor is too short\n");
f043bfc98c193c drivers/hid/usbhid/hid-core.c Jaejoong Kim       2017-09-28  1014  		return -EINVAL;
f043bfc98c193c drivers/hid/usbhid/hid-core.c Jaejoong Kim       2017-09-28  1015  	}
f043bfc98c193c drivers/hid/usbhid/hid-core.c Jaejoong Kim       2017-09-28  1016  
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby         2008-05-16  1017  	hid->version = le16_to_cpu(hdesc->bcdHID);
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby         2008-05-16  1018  	hid->country = hdesc->bCountryCode;
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby         2008-05-16  1019  
f043bfc98c193c drivers/hid/usbhid/hid-core.c Jaejoong Kim       2017-09-28  1020  	num_descriptors = min_t(int, hdesc->bNumDescriptors,
f043bfc98c193c drivers/hid/usbhid/hid-core.c Jaejoong Kim       2017-09-28  1021  	       (hdesc->bLength - offset) / sizeof(struct hid_class_descriptor));
f043bfc98c193c drivers/hid/usbhid/hid-core.c Jaejoong Kim       2017-09-28  1022  
f043bfc98c193c drivers/hid/usbhid/hid-core.c Jaejoong Kim       2017-09-28  1023  	for (n = 0; n < num_descriptors; n++)
6d33ae790f1855 drivers/hid/usbhid/hid-core.c syzbot             2023-11-21  1024  		if (n >= ARRAY_SIZE(hdesc->desc))
6d33ae790f1855 drivers/hid/usbhid/hid-core.c syzbot             2023-11-21  1025  			break;
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds     2005-04-16 @1026  		if (hdesc->desc[n].bDescriptorType == HID_DT_REPORT)
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds     2005-04-16  1027  			rsize = le16_to_cpu(hdesc->desc[n].wDescriptorLength);
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds     2005-04-16  1028  
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds     2005-04-16  1029  	if (!rsize || rsize > HID_MAX_DESCRIPTOR_SIZE) {
58037eb961f859 drivers/hid/usbhid/hid-core.c Jiri Kosina        2007-05-30  1030  		dbg_hid("weird size of report descriptor (%u)\n", rsize);
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby         2008-05-16  1031  		return -EINVAL;
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds     2005-04-16  1032  	}
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds     2005-04-16  1033  
52150c78270db5 drivers/hid/usbhid/hid-core.c Joe Perches        2017-03-01  1034  	rdesc = kmalloc(rsize, GFP_KERNEL);
52150c78270db5 drivers/hid/usbhid/hid-core.c Joe Perches        2017-03-01  1035  	if (!rdesc)
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby         2008-05-16  1036  		return -ENOMEM;
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds     2005-04-16  1037  
854561b019285a drivers/usb/input/hid-core.c  Vojtech Pavlik     2005-05-29  1038  	hid_set_idle(dev, interface->desc.bInterfaceNumber, 0, 0);
854561b019285a drivers/usb/input/hid-core.c  Vojtech Pavlik     2005-05-29  1039  
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby         2008-05-16  1040  	ret = hid_get_class_descriptor(dev, interface->desc.bInterfaceNumber,
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby         2008-05-16  1041  			HID_DT_REPORT, rdesc, rsize);
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby         2008-05-16  1042  	if (ret < 0) {
58037eb961f859 drivers/hid/usbhid/hid-core.c Jiri Kosina        2007-05-30  1043  		dbg_hid("reading report descriptor failed\n");
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds     2005-04-16  1044  		kfree(rdesc);
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby         2008-05-16  1045  		goto err;
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds     2005-04-16  1046  	}
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds     2005-04-16  1047  
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby         2008-05-16  1048  	ret = hid_parse_report(hid, rdesc, rsize);
85cdaf524b7dda drivers/hid/usbhid/hid-core.c Jiri Slaby         2008-05-16  1049  	kfree(rdesc);
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby         2008-05-16  1050  	if (ret) {
58037eb961f859 drivers/hid/usbhid/hid-core.c Jiri Kosina        2007-05-30  1051  		dbg_hid("parsing report descriptor failed\n");
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby         2008-05-16  1052  		goto err;
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds     2005-04-16  1053  	}
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds     2005-04-16  1054  
f5208997087e6e drivers/hid/usbhid/hid-core.c Zoltan Karcagi     2009-05-06  1055  	hid->quirks |= quirks;
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds     2005-04-16  1056  
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby         2008-05-16  1057  	return 0;
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby         2008-05-16  1058  err:
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby         2008-05-16  1059  	return ret;
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby         2008-05-16  1060  }
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby         2008-05-16  1061  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
