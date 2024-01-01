Return-Path: <linux-kernel+bounces-13829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E42FA821314
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 06:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29BFCB21A48
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 05:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C4A1C01;
	Mon,  1 Jan 2024 05:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BTtvGBak"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EBD17E4
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jan 2024 05:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704086176; x=1735622176;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5+zVgn9dufbZYDaLYHyP25DJEL8o12XfMzx1qaIzwNw=;
  b=BTtvGBakzhZFl3t/SUajMrsZVKvBkconT653vgQPjCjuV2Om/zSXI50b
   fBtOrmbdLoRCgckkB4UgUYpT13/CiwOyUnUX5p87m5+q1WPiOOU/602xq
   4MiNWSunIg+rWFs9ZS3lh2qbwlcTrl3Jgj2cWMTZfOLIULrCv7QHo42mb
   BTNAIKSw2IZ5K+/Oo7H2440clpLqzhgont/BoNIw0kpuL/Xla/WETZFTL
   b9Fz/B0BYY56YzXr1vFGjZR5hwgQJXHNaPHmtumGaPjKLNS160GEHU44U
   rZ4PaRp3nbv+QotIkuVEYqorG4CLoGM7FjDl/NxDjkwIhlEu8iDYuyaZ0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="461085617"
X-IronPort-AV: E=Sophos;i="6.04,321,1695711600"; 
   d="scan'208";a="461085617"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2023 21:16:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="772502373"
X-IronPort-AV: E=Sophos;i="6.04,321,1695711600"; 
   d="scan'208";a="772502373"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 31 Dec 2023 21:16:14 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rKAep-000K0k-33;
	Mon, 01 Jan 2024 05:16:11 +0000
Date: Mon, 1 Jan 2024 13:16:01 +0800
From: kernel test robot <lkp@intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Larry Finger <Larry.Finger@lwfinger.net>
Subject: drivers/virt/vboxguest/vboxguest_linux.c:166: warning: Function
 parameter or member 'input' not described in 'vbg_input_open'
Message-ID: <202401011343.2ZXFAiyt-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   610a9b8f49fbcf1100716370d3b5f6f884a2835a
commit: 0ba002bc4393dcfae031fc707b11c094b46a5048 virt: Add vboxguest driver for Virtual Box Guest integration
date:   6 years ago
config: i386-debian-10.3 (https://download.01.org/0day-ci/archive/20240101/202401011343.2ZXFAiyt-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240101/202401011343.2ZXFAiyt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401011343.2ZXFAiyt-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/virt/vboxguest/vboxguest_linux.c: In function 'vbg_pci_probe':
   drivers/virt/vboxguest/vboxguest_linux.c:295:25: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     295 |                         (void *)mmio, (int)mmio_len);
         |                         ^
   drivers/virt/vboxguest/vboxguest_linux.c:367:18: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     367 |                  (void *)mmio, (int)mmio_len);
         |                  ^
   In file included from drivers/virt/vboxguest/vboxguest_linux.c:11:
   drivers/virt/vboxguest/vboxguest_linux.c: At top level:
   include/linux/module.h:137:14: warning: 'cleanup_module' specifies less restrictive attribute than its target 'vbg_pci_driver_exit': 'cold' [-Wmissing-attributes]
     137 |         void cleanup_module(void) __attribute__((alias(#exitfn)));
         |              ^~~~~~~~~~~~~~
   include/linux/device.h:1518:1: note: in expansion of macro 'module_exit'
    1518 | module_exit(__driver##_exit);
         | ^~~~~~~~~~~
   include/linux/pci.h:1275:9: note: in expansion of macro 'module_driver'
    1275 |         module_driver(__pci_driver, pci_register_driver, \
         |         ^~~~~~~~~~~~~
   drivers/virt/vboxguest/vboxguest_linux.c:462:1: note: in expansion of macro 'module_pci_driver'
     462 | module_pci_driver(vbg_pci_driver);
         | ^~~~~~~~~~~~~~~~~
   In file included from include/linux/input.h:22,
                    from drivers/virt/vboxguest/vboxguest_linux.c:8:
   drivers/virt/vboxguest/vboxguest_linux.c:462:19: note: 'cleanup_module' target declared here
     462 | module_pci_driver(vbg_pci_driver);
         |                   ^~~~~~~~~~~~~~
   include/linux/device.h:1514:20: note: in definition of macro 'module_driver'
    1514 | static void __exit __driver##_exit(void) \
         |                    ^~~~~~~~
   drivers/virt/vboxguest/vboxguest_linux.c:462:1: note: in expansion of macro 'module_pci_driver'
     462 | module_pci_driver(vbg_pci_driver);
         | ^~~~~~~~~~~~~~~~~
   include/linux/module.h:131:13: warning: 'init_module' specifies less restrictive attribute than its target 'vbg_pci_driver_init': 'cold' [-Wmissing-attributes]
     131 |         int init_module(void) __attribute__((alias(#initfn)));
         |             ^~~~~~~~~~~
   include/linux/device.h:1513:1: note: in expansion of macro 'module_init'
    1513 | module_init(__driver##_init); \
         | ^~~~~~~~~~~
   include/linux/pci.h:1275:9: note: in expansion of macro 'module_driver'
    1275 |         module_driver(__pci_driver, pci_register_driver, \
         |         ^~~~~~~~~~~~~
   drivers/virt/vboxguest/vboxguest_linux.c:462:1: note: in expansion of macro 'module_pci_driver'
     462 | module_pci_driver(vbg_pci_driver);
         | ^~~~~~~~~~~~~~~~~
   drivers/virt/vboxguest/vboxguest_linux.c:462:19: note: 'init_module' target declared here
     462 | module_pci_driver(vbg_pci_driver);
         |                   ^~~~~~~~~~~~~~
   include/linux/device.h:1509:19: note: in definition of macro 'module_driver'
    1509 | static int __init __driver##_init(void) \
         |                   ^~~~~~~~
   drivers/virt/vboxguest/vboxguest_linux.c:462:1: note: in expansion of macro 'module_pci_driver'
     462 | module_pci_driver(vbg_pci_driver);
         | ^~~~~~~~~~~~~~~~~
>> drivers/virt/vboxguest/vboxguest_linux.c:166: warning: Function parameter or member 'input' not described in 'vbg_input_open'
>> drivers/virt/vboxguest/vboxguest_linux.c:184: warning: Function parameter or member 'input' not described in 'vbg_input_close'
>> drivers/virt/vboxguest/vboxguest_linux.c:196: warning: Function parameter or member 'gdev' not described in 'vbg_create_input_device'
>> drivers/virt/vboxguest/vboxguest_linux.c:248: warning: Function parameter or member 'pci' not described in 'vbg_pci_probe'
>> drivers/virt/vboxguest/vboxguest_linux.c:248: warning: Function parameter or member 'id' not described in 'vbg_pci_probe'
--
>> drivers/virt/vboxguest/vboxguest_core.c:341: warning: Function parameter or member 'work' not described in 'vbg_balloon_work'
>> drivers/virt/vboxguest/vboxguest_core.c:405: warning: Function parameter or member 't' not described in 'vbg_heartbeat_timer'
--
>> drivers/virt/vboxguest/vboxguest_utils.c:418: warning: Function parameter or member 'gdev' not described in 'hgcm_cancel_call'
>> drivers/virt/vboxguest/vboxguest_utils.c:418: warning: Function parameter or member 'call' not described in 'hgcm_cancel_call'


vim +166 drivers/virt/vboxguest/vboxguest_linux.c

   159	
   160	/**
   161	 * Called when the input device is first opened.
   162	 *
   163	 * Sets up absolute mouse reporting.
   164	 */
   165	static int vbg_input_open(struct input_dev *input)
 > 166	{
   167		struct vbg_dev *gdev = input_get_drvdata(input);
   168		u32 feat = VMMDEV_MOUSE_GUEST_CAN_ABSOLUTE | VMMDEV_MOUSE_NEW_PROTOCOL;
   169		int ret;
   170	
   171		ret = vbg_core_set_mouse_status(gdev, feat);
   172		if (ret)
   173			return ret;
   174	
   175		return 0;
   176	}
   177	
   178	/**
   179	 * Called if all open handles to the input device are closed.
   180	 *
   181	 * Disables absolute reporting.
   182	 */
   183	static void vbg_input_close(struct input_dev *input)
 > 184	{
   185		struct vbg_dev *gdev = input_get_drvdata(input);
   186	
   187		vbg_core_set_mouse_status(gdev, 0);
   188	}
   189	
   190	/**
   191	 * Creates the kernel input device.
   192	 *
   193	 * Return: 0 on success, negated errno on failure.
   194	 */
   195	static int vbg_create_input_device(struct vbg_dev *gdev)
 > 196	{
   197		struct input_dev *input;
   198	
   199		input = devm_input_allocate_device(gdev->dev);
   200		if (!input)
   201			return -ENOMEM;
   202	
   203		input->id.bustype = BUS_PCI;
   204		input->id.vendor = VBOX_VENDORID;
   205		input->id.product = VMMDEV_DEVICEID;
   206		input->open = vbg_input_open;
   207		input->close = vbg_input_close;
   208		input->dev.parent = gdev->dev;
   209		input->name = "VirtualBox mouse integration";
   210	
   211		input_set_abs_params(input, ABS_X, VMMDEV_MOUSE_RANGE_MIN,
   212				     VMMDEV_MOUSE_RANGE_MAX, 0, 0);
   213		input_set_abs_params(input, ABS_Y, VMMDEV_MOUSE_RANGE_MIN,
   214				     VMMDEV_MOUSE_RANGE_MAX, 0, 0);
   215		input_set_capability(input, EV_KEY, BTN_MOUSE);
   216		input_set_drvdata(input, gdev);
   217	
   218		gdev->input = input;
   219	
   220		return input_register_device(gdev->input);
   221	}
   222	
   223	static ssize_t host_version_show(struct device *dev,
   224					 struct device_attribute *attr, char *buf)
   225	{
   226		struct vbg_dev *gdev = dev_get_drvdata(dev);
   227	
   228		return sprintf(buf, "%s\n", gdev->host_version);
   229	}
   230	
   231	static ssize_t host_features_show(struct device *dev,
   232					 struct device_attribute *attr, char *buf)
   233	{
   234		struct vbg_dev *gdev = dev_get_drvdata(dev);
   235	
   236		return sprintf(buf, "%#x\n", gdev->host_features);
   237	}
   238	
   239	static DEVICE_ATTR_RO(host_version);
   240	static DEVICE_ATTR_RO(host_features);
   241	
   242	/**
   243	 * Does the PCI detection and init of the device.
   244	 *
   245	 * Return: 0 on success, negated errno on failure.
   246	 */
   247	static int vbg_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
 > 248	{
   249		struct device *dev = &pci->dev;
   250		resource_size_t io, io_len, mmio, mmio_len;
   251		struct vmmdev_memory *vmmdev;
   252		struct vbg_dev *gdev;
   253		int ret;
   254	
   255		gdev = devm_kzalloc(dev, sizeof(*gdev), GFP_KERNEL);
   256		if (!gdev)
   257			return -ENOMEM;
   258	
   259		ret = pci_enable_device(pci);
   260		if (ret != 0) {
   261			vbg_err("vboxguest: Error enabling device: %d\n", ret);
   262			return ret;
   263		}
   264	
   265		ret = -ENODEV;
   266	
   267		io = pci_resource_start(pci, 0);
   268		io_len = pci_resource_len(pci, 0);
   269		if (!io || !io_len) {
   270			vbg_err("vboxguest: Error IO-port resource (0) is missing\n");
   271			goto err_disable_pcidev;
   272		}
   273		if (devm_request_region(dev, io, io_len, DEVICE_NAME) == NULL) {
   274			vbg_err("vboxguest: Error could not claim IO resource\n");
   275			ret = -EBUSY;
   276			goto err_disable_pcidev;
   277		}
   278	
   279		mmio = pci_resource_start(pci, 1);
   280		mmio_len = pci_resource_len(pci, 1);
   281		if (!mmio || !mmio_len) {
   282			vbg_err("vboxguest: Error MMIO resource (1) is missing\n");
   283			goto err_disable_pcidev;
   284		}
   285	
   286		if (devm_request_mem_region(dev, mmio, mmio_len, DEVICE_NAME) == NULL) {
   287			vbg_err("vboxguest: Error could not claim MMIO resource\n");
   288			ret = -EBUSY;
   289			goto err_disable_pcidev;
   290		}
   291	
   292		vmmdev = devm_ioremap(dev, mmio, mmio_len);
   293		if (!vmmdev) {
   294			vbg_err("vboxguest: Error ioremap failed; MMIO addr=%p size=%d\n",
   295				(void *)mmio, (int)mmio_len);
   296			goto err_disable_pcidev;
   297		}
   298	
   299		/* Validate MMIO region version and size. */
   300		if (vmmdev->version != VMMDEV_MEMORY_VERSION ||
   301		    vmmdev->size < 32 || vmmdev->size > mmio_len) {
   302			vbg_err("vboxguest: Bogus VMMDev memory; version=%08x (expected %08x) size=%d (expected <= %d)\n",
   303				vmmdev->version, VMMDEV_MEMORY_VERSION,
   304				vmmdev->size, (int)mmio_len);
   305			goto err_disable_pcidev;
   306		}
   307	
   308		gdev->io_port = io;
   309		gdev->mmio = vmmdev;
   310		gdev->dev = dev;
   311		gdev->misc_device.minor = MISC_DYNAMIC_MINOR;
   312		gdev->misc_device.name = DEVICE_NAME;
   313		gdev->misc_device.fops = &vbg_misc_device_fops;
   314		gdev->misc_device_user.minor = MISC_DYNAMIC_MINOR;
   315		gdev->misc_device_user.name = DEVICE_NAME_USER;
   316		gdev->misc_device_user.fops = &vbg_misc_device_user_fops;
   317	
   318		ret = vbg_core_init(gdev, VMMDEV_EVENT_MOUSE_POSITION_CHANGED);
   319		if (ret)
   320			goto err_disable_pcidev;
   321	
   322		ret = vbg_create_input_device(gdev);
   323		if (ret) {
   324			vbg_err("vboxguest: Error creating input device: %d\n", ret);
   325			goto err_vbg_core_exit;
   326		}
   327	
   328		ret = devm_request_irq(dev, pci->irq, vbg_core_isr, IRQF_SHARED,
   329				       DEVICE_NAME, gdev);
   330		if (ret) {
   331			vbg_err("vboxguest: Error requesting irq: %d\n", ret);
   332			goto err_vbg_core_exit;
   333		}
   334	
   335		ret = misc_register(&gdev->misc_device);
   336		if (ret) {
   337			vbg_err("vboxguest: Error misc_register %s failed: %d\n",
   338				DEVICE_NAME, ret);
   339			goto err_vbg_core_exit;
   340		}
   341	
   342		ret = misc_register(&gdev->misc_device_user);
   343		if (ret) {
   344			vbg_err("vboxguest: Error misc_register %s failed: %d\n",
   345				DEVICE_NAME_USER, ret);
   346			goto err_unregister_misc_device;
   347		}
   348	
   349		mutex_lock(&vbg_gdev_mutex);
   350		if (!vbg_gdev)
   351			vbg_gdev = gdev;
   352		else
   353			ret = -EBUSY;
   354		mutex_unlock(&vbg_gdev_mutex);
   355	
   356		if (ret) {
   357			vbg_err("vboxguest: Error more then 1 vbox guest pci device\n");
   358			goto err_unregister_misc_device_user;
   359		}
   360	
   361		pci_set_drvdata(pci, gdev);
   362		device_create_file(dev, &dev_attr_host_version);
   363		device_create_file(dev, &dev_attr_host_features);
   364	
   365		vbg_info("vboxguest: misc device minor %d, IRQ %d, I/O port %x, MMIO at %p (size %d)\n",
   366			 gdev->misc_device.minor, pci->irq, gdev->io_port,
   367			 (void *)mmio, (int)mmio_len);
   368	
   369		return 0;
   370	
   371	err_unregister_misc_device_user:
   372		misc_deregister(&gdev->misc_device_user);
   373	err_unregister_misc_device:
   374		misc_deregister(&gdev->misc_device);
   375	err_vbg_core_exit:
   376		vbg_core_exit(gdev);
   377	err_disable_pcidev:
   378		pci_disable_device(pci);
   379	
   380		return ret;
   381	}
   382	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

