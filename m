Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6019B7B419E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 17:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbjI3PbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 11:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbjI3PbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 11:31:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB79BE;
        Sat, 30 Sep 2023 08:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696087869; x=1727623869;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=RAtMpypnsWT2vx45TMUTuDf6gaWWE9XuH2lm3ppYvGQ=;
  b=WeBpGdYpYq0RtQfI1b9eoG+fCR5bGDqyH/4uvHsLlsG1vmrGsirVmoGq
   ozKdKBDBCDn6f8ivoDwEvgFUr88ycu9u0EXDyjs2EFMxiKs1lSPg31VB6
   febaENDNLxPpm4fe1ojPGPlGQ/h4QhjsHqsfEM1kySbNi2FfFPe7uY9v+
   3/y4vZg2VBWY8yMjNRe+8uiVCX+B7QXCDCmaEnVmRtsnD/mSoPL18L4US
   k2a6OzZ0rlw9kMwOyO7KCO2+L/hkogdJtZ7jmNOQ5saVyK4XAZb8SANnc
   x4iyRW/M6K9u5C/iOZbOFRMMrxfaHgB+u0bst7OiQkDrR+GIK82aB1iQQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="379734993"
X-IronPort-AV: E=Sophos;i="6.03,190,1694761200"; 
   d="scan'208";a="379734993"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2023 08:31:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="923848527"
X-IronPort-AV: E=Sophos;i="6.03,190,1694761200"; 
   d="scan'208";a="923848527"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 30 Sep 2023 08:31:05 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qmbvr-0004Ez-0U;
        Sat, 30 Sep 2023 15:31:03 +0000
Date:   Sat, 30 Sep 2023 23:30:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Abhinav <singhabhinav9051571833@gmail.com>,
        gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        benjamin.tissoires@redhat.com, mathias.nyman@linux.intel.com,
        hdegoede@redhat.com, hadess@hadess.net
Cc:     oe-kbuild-all@lists.linux.dev, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        Abhinav <singhabhinav9051571833@gmail.com>
Subject: Re: [PATCH] fixed documentation warning about duplicate symbol
Message-ID: <202309302312.Sk9H9aNZ-lkp@intel.com>
References: <20230930123449.1170359-1-singhabhinav9051571833@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230930123449.1170359-1-singhabhinav9051571833@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhinav,

kernel test robot noticed the following build errors:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on usb/usb-next usb/usb-linus johan-usb-serial/usb-next johan-usb-serial/usb-linus hid/for-next linus/master v6.6-rc3 next-20230929]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Abhinav/fixed-documentation-warning-about-duplicate-symbol/20230930-203554
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20230930123449.1170359-1-singhabhinav9051571833%40gmail.com
patch subject: [PATCH] fixed documentation warning about duplicate symbol
config: sh-defconfig (https://download.01.org/0day-ci/archive/20230930/202309302312.Sk9H9aNZ-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230930/202309302312.Sk9H9aNZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309302312.Sk9H9aNZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/hid/usbhid/hid-core.c: In function 'usbhid_probe':
>> drivers/hid/usbhid/hid-core.c:1409:13: error: implicit declaration of function 'usb_string' [-Werror=implicit-function-declaration]
    1409 |         if (usb_string(dev, dev->descriptor.iSerialNumber, hid->uniq, 64) <= 0)
         |             ^~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/usb_string +1409 drivers/hid/usbhid/hid-core.c

8c3e24065e3d37 drivers/hid/usbhid/hid-core.c Thomas Weißschuh 2022-12-22  1341  
c4c259bcc27c42 drivers/hid/usbhid/hid-core.c Jiri Kosina      2009-09-15  1342  static int usbhid_probe(struct usb_interface *intf, const struct usb_device_id *id)
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds   2005-04-16  1343  {
131d3a7a009d56 drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-11-14  1344  	struct usb_host_interface *interface = intf->cur_altsetting;
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-05-16  1345  	struct usb_device *dev = interface_to_usbdev(intf);
3d5afd324a4bf9 drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-10-27  1346  	struct usbhid_device *usbhid;
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds   2005-04-16  1347  	struct hid_device *hid;
131d3a7a009d56 drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-11-14  1348  	unsigned int n, has_in = 0;
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-05-16  1349  	size_t len;
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-05-16  1350  	int ret;
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds   2005-04-16  1351  
58037eb961f859 drivers/hid/usbhid/hid-core.c Jiri Kosina      2007-05-30  1352  	dbg_hid("HID probe called for ifnum %d\n",
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds   2005-04-16  1353  			intf->altsetting->desc.bInterfaceNumber);
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds   2005-04-16  1354  
131d3a7a009d56 drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-11-14  1355  	for (n = 0; n < interface->desc.bNumEndpoints; n++)
131d3a7a009d56 drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-11-14  1356  		if (usb_endpoint_is_int_in(&interface->endpoint[n].desc))
131d3a7a009d56 drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-11-14  1357  			has_in++;
131d3a7a009d56 drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-11-14  1358  	if (!has_in) {
4291ee305e9bb0 drivers/hid/usbhid/hid-core.c Joe Perches      2010-12-09  1359  		hid_err(intf, "couldn't find an input interrupt endpoint\n");
131d3a7a009d56 drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-11-14  1360  		return -ENODEV;
131d3a7a009d56 drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-11-14  1361  	}
131d3a7a009d56 drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-11-14  1362  
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-05-16  1363  	hid = hid_allocate_device();
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-05-16  1364  	if (IS_ERR(hid))
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-05-16  1365  		return PTR_ERR(hid);
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds   2005-04-16  1366  
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds   2005-04-16  1367  	usb_set_intfdata(intf, hid);
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-05-16  1368  	hid->ll_driver = &usb_hid_driver;
76483cf4d0efbc drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-09-18  1369  	hid->ff_init = hid_pidff_init;
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-05-16  1370  #ifdef CONFIG_USB_HIDDEV
93c10132a7ac16 drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-06-27  1371  	hid->hiddev_connect = hiddev_connect;
c4c259bcc27c42 drivers/hid/usbhid/hid-core.c Jiri Kosina      2009-09-15  1372  	hid->hiddev_disconnect = hiddev_disconnect;
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-05-16  1373  	hid->hiddev_hid_event = hiddev_hid_event;
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-05-16  1374  	hid->hiddev_report_event = hiddev_report_event;
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-05-16  1375  #endif
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-05-16  1376  	hid->dev.parent = &intf->dev;
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-05-16  1377  	hid->bus = BUS_USB;
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-05-16  1378  	hid->vendor = le16_to_cpu(dev->descriptor.idVendor);
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-05-16  1379  	hid->product = le16_to_cpu(dev->descriptor.idProduct);
d5158e020c4593 drivers/hid/usbhid/hid-core.c Niels Skou Olsen 2017-10-04  1380  	hid->version = le16_to_cpu(dev->descriptor.bcdDevice);
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-05-16  1381  	hid->name[0] = 0;
a73a63701f8f23 drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-10-22  1382  	if (intf->cur_altsetting->desc.bInterfaceProtocol ==
a73a63701f8f23 drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-10-22  1383  			USB_INTERFACE_PROTOCOL_MOUSE)
a73a63701f8f23 drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-10-22  1384  		hid->type = HID_TYPE_USBMOUSE;
6dc1418e131441 drivers/hid/usbhid/hid-core.c Tomoki Sekiyama  2011-05-23  1385  	else if (intf->cur_altsetting->desc.bInterfaceProtocol == 0)
6dc1418e131441 drivers/hid/usbhid/hid-core.c Tomoki Sekiyama  2011-05-23  1386  		hid->type = HID_TYPE_USBNONE;
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds   2005-04-16  1387  
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-05-16  1388  	if (dev->manufacturer)
eeeec27d682047 drivers/hid/usbhid/hid-core.c Wolfram Sang     2022-08-18  1389  		strscpy(hid->name, dev->manufacturer, sizeof(hid->name));
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds   2005-04-16  1390  
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-05-16  1391  	if (dev->product) {
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-05-16  1392  		if (dev->manufacturer)
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-05-16  1393  			strlcat(hid->name, " ", sizeof(hid->name));
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-05-16  1394  		strlcat(hid->name, dev->product, sizeof(hid->name));
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds   2005-04-16  1395  	}
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds   2005-04-16  1396  
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-05-16  1397  	if (!strlen(hid->name))
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-05-16  1398  		snprintf(hid->name, sizeof(hid->name), "HID %04x:%04x",
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-05-16  1399  			 le16_to_cpu(dev->descriptor.idVendor),
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-05-16  1400  			 le16_to_cpu(dev->descriptor.idProduct));
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds   2005-04-16  1401  
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-05-16  1402  	usb_make_path(dev, hid->phys, sizeof(hid->phys));
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-05-16  1403  	strlcat(hid->phys, "/input", sizeof(hid->phys));
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-05-16  1404  	len = strlen(hid->phys);
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-05-16  1405  	if (len < sizeof(hid->phys) - 1)
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-05-16  1406  		snprintf(hid->phys + len, sizeof(hid->phys) - len,
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-05-16  1407  			 "%d", intf->altsetting[0].desc.bInterfaceNumber);
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-05-16  1408  
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-05-16 @1409  	if (usb_string(dev, dev->descriptor.iSerialNumber, hid->uniq, 64) <= 0)
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-05-16  1410  		hid->uniq[0] = 0;
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds   2005-04-16  1411  
3d5afd324a4bf9 drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-10-27  1412  	usbhid = kzalloc(sizeof(*usbhid), GFP_KERNEL);
3d5afd324a4bf9 drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-10-27  1413  	if (usbhid == NULL) {
3d5afd324a4bf9 drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-10-27  1414  		ret = -ENOMEM;
3d5afd324a4bf9 drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-10-27  1415  		goto err;
3d5afd324a4bf9 drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-10-27  1416  	}
3d5afd324a4bf9 drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-10-27  1417  
3d5afd324a4bf9 drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-10-27  1418  	hid->driver_data = usbhid;
3d5afd324a4bf9 drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-10-27  1419  	usbhid->hid = hid;
57ab12e418ec4f drivers/hid/usbhid/hid-core.c Jiri Kosina      2010-02-17  1420  	usbhid->intf = intf;
57ab12e418ec4f drivers/hid/usbhid/hid-core.c Jiri Kosina      2010-02-17  1421  	usbhid->ifnum = interface->desc.bInterfaceNumber;
3d5afd324a4bf9 drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-10-27  1422  
fde4e2f73208b8 drivers/hid/usbhid/hid-core.c Alan Stern       2010-05-07  1423  	init_waitqueue_head(&usbhid->wait);
fde4e2f73208b8 drivers/hid/usbhid/hid-core.c Alan Stern       2010-05-07  1424  	INIT_WORK(&usbhid->reset_work, hid_reset);
0ee32774aed648 drivers/hid/usbhid/hid-core.c Kees Cook        2017-10-04  1425  	timer_setup(&usbhid->io_retry, hid_retry_timeout, 0);
fde4e2f73208b8 drivers/hid/usbhid/hid-core.c Alan Stern       2010-05-07  1426  	spin_lock_init(&usbhid->lock);
0ed08faded1da0 drivers/hid/usbhid/hid-core.c Alan Stern       2020-04-22  1427  	mutex_init(&usbhid->mutex);
fde4e2f73208b8 drivers/hid/usbhid/hid-core.c Alan Stern       2010-05-07  1428  
85cdaf524b7dda drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-05-16  1429  	ret = hid_add_device(hid);
85cdaf524b7dda drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-05-16  1430  	if (ret) {
d458a9dfc4de24 drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-05-16  1431  		if (ret != -ENODEV)
4291ee305e9bb0 drivers/hid/usbhid/hid-core.c Joe Perches      2010-12-09  1432  			hid_err(intf, "can't add hid device: %d\n", ret);
3d5afd324a4bf9 drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-10-27  1433  		goto err_free;
85cdaf524b7dda drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-05-16  1434  	}
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-05-16  1435  
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-05-16  1436  	return 0;
3d5afd324a4bf9 drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-10-27  1437  err_free:
3d5afd324a4bf9 drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-10-27  1438  	kfree(usbhid);
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-05-16  1439  err:
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-05-16  1440  	hid_destroy_device(hid);
85cdaf524b7dda drivers/hid/usbhid/hid-core.c Jiri Slaby       2008-05-16  1441  	return ret;
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds   2005-04-16  1442  }
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds   2005-04-16  1443  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
