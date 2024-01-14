Return-Path: <linux-kernel+bounces-25512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5856F82D16D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 17:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCF62282016
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 16:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803615231;
	Sun, 14 Jan 2024 16:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z5b4rzNr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5B6610E
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 16:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705249488; x=1736785488;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ROWexol+WS5p+mOTcrp8OuW26IGNBh3Hyov3GzfzHUI=;
  b=Z5b4rzNr993QvH9HDhfhFMe8Rp/hnfRRjYYqkeMlKhA/ek65YxkYrLqL
   8KIUzV043lVS/HdnL6/OVr/pJnwg2WuJHgrQz67MD4HGpA9wW0pOXTMkF
   bTYIc2J9619MNRMNiIWRdVxKTGWtXfbZYFbdAAPFyd8A+uNVOcHK+l6kA
   cTF2pxzN04lp5N8nP1W3qPCE4Y3KbfiNR3UwzsVOqq+eoUJHRDuaz/AAf
   JLLVGh1ylyOccifgqIYHAuoM58xEJQBhu8ieUJckF4izL+LKBb0wkjjmU
   arlsH4Y+Y/YK0mbtTuwz4LoJgNurPKED5Rv+V00tQFiDHKxgFstgTv3Kq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="6833209"
X-IronPort-AV: E=Sophos;i="6.04,194,1695711600"; 
   d="scan'208";a="6833209"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 08:24:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,194,1695711600"; 
   d="scan'208";a="31907844"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 14 Jan 2024 08:24:46 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rP3Hv-000BeO-0d;
	Sun, 14 Jan 2024 16:24:43 +0000
Date: Mon, 15 Jan 2024 00:24:38 +0800
From: kernel test robot <lkp@intel.com>
To: Wei Hu <weh@microsoft.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: drivers/video/fbdev/hyperv_fb.c:1053:43: sparse: sparse: incorrect
 type in assignment (different address spaces)
Message-ID: <202401150046.UFiSKQvo-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   052d534373b7ed33712a63d5e17b2b6cdbce84fd
commit: 3a6fb6c4255c3893ab61e2bd4e9ae01ca6bbcd94 video: hyperv: hyperv_fb: Use physical memory for fb on HyperV Gen 1 VMs.
date:   4 years ago
config: i386-randconfig-061-20240106 (https://download.01.org/0day-ci/archive/20240115/202401150046.UFiSKQvo-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240115/202401150046.UFiSKQvo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401150046.UFiSKQvo-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/video/fbdev/hyperv_fb.c:1053:43: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __iomem *screen_base @@     got unsigned char *mmio_vp @@
   drivers/video/fbdev/hyperv_fb.c:1053:43: sparse:     expected char [noderef] __iomem *screen_base
   drivers/video/fbdev/hyperv_fb.c:1053:43: sparse:     got unsigned char *mmio_vp
   drivers/video/fbdev/hyperv_fb.c:1107:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/hyperv_fb.c:1111:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __iomem *screen_base @@     got unsigned char *dio_vp @@
   drivers/video/fbdev/hyperv_fb.c:1111:27: sparse:     expected char [noderef] __iomem *screen_base
   drivers/video/fbdev/hyperv_fb.c:1111:27: sparse:     got unsigned char *dio_vp

vim +1053 drivers/video/fbdev/hyperv_fb.c

  1011	
  1012	
  1013	/* Get framebuffer memory from Hyper-V video pci space */
  1014	static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
  1015	{
  1016		struct hvfb_par *par = info->par;
  1017		struct pci_dev *pdev  = NULL;
  1018		void __iomem *fb_virt;
  1019		int gen2vm = efi_enabled(EFI_BOOT);
  1020		resource_size_t pot_start, pot_end;
  1021		phys_addr_t paddr;
  1022		int ret;
  1023	
  1024		info->apertures = alloc_apertures(1);
  1025		if (!info->apertures)
  1026			return -ENOMEM;
  1027	
  1028		if (!gen2vm) {
  1029			pdev = pci_get_device(PCI_VENDOR_ID_MICROSOFT,
  1030				PCI_DEVICE_ID_HYPERV_VIDEO, NULL);
  1031			if (!pdev) {
  1032				pr_err("Unable to find PCI Hyper-V video\n");
  1033				kfree(info->apertures);
  1034				return -ENODEV;
  1035			}
  1036	
  1037			info->apertures->ranges[0].base = pci_resource_start(pdev, 0);
  1038			info->apertures->ranges[0].size = pci_resource_len(pdev, 0);
  1039	
  1040			/*
  1041			 * For Gen 1 VM, we can directly use the contiguous memory
  1042			 * from VM. If we succeed, deferred IO happens directly
  1043			 * on this allocated framebuffer memory, avoiding extra
  1044			 * memory copy.
  1045			 */
  1046			paddr = hvfb_get_phymem(hdev, screen_fb_size);
  1047			if (paddr != (phys_addr_t) -1) {
  1048				par->mmio_pp = paddr;
  1049				par->mmio_vp = par->dio_vp = __va(paddr);
  1050	
  1051				info->fix.smem_start = paddr;
  1052				info->fix.smem_len = screen_fb_size;
> 1053				info->screen_base = par->mmio_vp;
  1054				info->screen_size = screen_fb_size;
  1055	
  1056				par->need_docopy = false;
  1057				goto getmem_done;
  1058			}
  1059			pr_info("Unable to allocate enough contiguous physical memory on Gen 1 VM. Using MMIO instead.\n");
  1060		} else {
  1061			info->apertures->ranges[0].base = screen_info.lfb_base;
  1062			info->apertures->ranges[0].size = screen_info.lfb_size;
  1063		}
  1064	
  1065		/*
  1066		 * Cannot use the contiguous physical memory.
  1067		 * Allocate mmio space for framebuffer.
  1068		 */
  1069		dio_fb_size =
  1070			screen_width * screen_height * screen_depth / 8;
  1071	
  1072		if (gen2vm) {
  1073			pot_start = 0;
  1074			pot_end = -1;
  1075		} else {
  1076			if (!(pci_resource_flags(pdev, 0) & IORESOURCE_MEM) ||
  1077			    pci_resource_len(pdev, 0) < screen_fb_size) {
  1078				pr_err("Resource not available or (0x%lx < 0x%lx)\n",
  1079				       (unsigned long) pci_resource_len(pdev, 0),
  1080				       (unsigned long) screen_fb_size);
  1081				goto err1;
  1082			}
  1083	
  1084			pot_end = pci_resource_end(pdev, 0);
  1085			pot_start = pot_end - screen_fb_size + 1;
  1086		}
  1087	
  1088		ret = vmbus_allocate_mmio(&par->mem, hdev, pot_start, pot_end,
  1089					  screen_fb_size, 0x100000, true);
  1090		if (ret != 0) {
  1091			pr_err("Unable to allocate framebuffer memory\n");
  1092			goto err1;
  1093		}
  1094	
  1095		fb_virt = ioremap(par->mem->start, screen_fb_size);
  1096		if (!fb_virt)
  1097			goto err2;
  1098	
  1099		/* Allocate memory for deferred IO */
  1100		par->dio_vp = vzalloc(round_up(dio_fb_size, PAGE_SIZE));
  1101		if (par->dio_vp == NULL)
  1102			goto err3;
  1103	
  1104		/* Physical address of FB device */
  1105		par->mmio_pp = par->mem->start;
  1106		/* Virtual address of FB device */
  1107		par->mmio_vp = (unsigned char *) fb_virt;
  1108	
  1109		info->fix.smem_start = par->mem->start;
  1110		info->fix.smem_len = dio_fb_size;
  1111		info->screen_base = par->dio_vp;
  1112		info->screen_size = dio_fb_size;
  1113	
  1114	getmem_done:
  1115		remove_conflicting_framebuffers(info->apertures,
  1116						KBUILD_MODNAME, false);
  1117		if (!gen2vm)
  1118			pci_dev_put(pdev);
  1119		kfree(info->apertures);
  1120	
  1121		return 0;
  1122	
  1123	err3:
  1124		iounmap(fb_virt);
  1125	err2:
  1126		vmbus_free_mmio(par->mem->start, screen_fb_size);
  1127		par->mem = NULL;
  1128	err1:
  1129		if (!gen2vm)
  1130			pci_dev_put(pdev);
  1131		kfree(info->apertures);
  1132	
  1133		return -ENOMEM;
  1134	}
  1135	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

