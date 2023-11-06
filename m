Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478B47E2E8D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 22:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbjKFVCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 16:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbjKFVCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 16:02:52 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B21D51
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 13:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699304569; x=1730840569;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Y+pp7UqgqKzUq4MEege0vFksJlEzj2ir/nbeT8B2DEk=;
  b=IcucilEQJAnK6R7Ki3lObPi+e9Jy7A7gvzdn4gK1o1YdNlt6Huu6yWO6
   IRNSW/9vXzCPEaBtN+YbVDa+LdeqOvmUbhnSWCq2XRzrkPXiRLSLknELi
   7UiiRHJ8qn2DOpWPWYhSSNPSx+063x9+PpZZpxSPFgg7OEwPcEyZbb2hq
   vSJOQadxRzKtuzWeD8/JQM6HfctbP8DAN4GzN5nf680RDeimWZAJ3jCEL
   DUbDvBjcl89div3PLPKA0WG1mzYWEBibr52Se+YMPGHf0WFXhG1ztor8U
   Oj9JOAFQIJcfecI+enU3/fHhrS97hEVxuy90eSsGd/6caS3xeQBrOnDGF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="453677063"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="453677063"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 13:02:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="879569494"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="879569494"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 06 Nov 2023 13:02:46 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r06k8-0006jI-1s;
        Mon, 06 Nov 2023 21:02:44 +0000
Date:   Tue, 7 Nov 2023 05:00:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/video/sticore.c:888:14: sparse: sparse: cast to restricted
 __le32
Message-ID: <202311070440.5VIJWvGt-lkp@intel.com>
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

Hi Thomas,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d2f51b3516dade79269ff45eae2a7668ae711b25
commit: 7470849745e6cd746ae773a6e59b309867310181 video: Move HP PARISC STI core code to shared location
date:   7 months ago
config: parisc-randconfig-r131-20231106 (https://download.01.org/0day-ci/archive/20231107/202311070440.5VIJWvGt-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231107/202311070440.5VIJWvGt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311070440.5VIJWvGt-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/video/sticore.c:888:14: sparse: sparse: cast to restricted __le32
>> drivers/video/sticore.c:888:14: sparse: sparse: cast to restricted __le32
>> drivers/video/sticore.c:888:14: sparse: sparse: cast to restricted __le32
>> drivers/video/sticore.c:888:14: sparse: sparse: cast to restricted __le32
>> drivers/video/sticore.c:888:14: sparse: sparse: cast to restricted __le32
>> drivers/video/sticore.c:888:14: sparse: sparse: cast to restricted __le32
>> drivers/video/sticore.c:902:17: sparse: sparse: cast to restricted __le16
>> drivers/video/sticore.c:902:17: sparse: sparse: cast to restricted __le16
>> drivers/video/sticore.c:902:17: sparse: sparse: cast to restricted __le16
>> drivers/video/sticore.c:902:17: sparse: sparse: cast to restricted __le16
   drivers/video/sticore.c:904:29: sparse: sparse: cast to restricted __le16
   drivers/video/sticore.c:904:29: sparse: sparse: cast to restricted __le16
   drivers/video/sticore.c:904:29: sparse: sparse: cast to restricted __le16
   drivers/video/sticore.c:904:29: sparse: sparse: cast to restricted __le16
   drivers/video/sticore.c:914:28: sparse: sparse: cast to restricted __le32
   drivers/video/sticore.c:914:28: sparse: sparse: cast to restricted __le32
   drivers/video/sticore.c:914:28: sparse: sparse: cast to restricted __le32
   drivers/video/sticore.c:914:28: sparse: sparse: cast to restricted __le32
   drivers/video/sticore.c:914:28: sparse: sparse: cast to restricted __le32
   drivers/video/sticore.c:914:28: sparse: sparse: cast to restricted __le32

vim +888 drivers/video/sticore.c

^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  859  
48c68c4f1b5424 drivers/video/console/sticore.c Greg Kroah-Hartman 2012-12-21  860  static struct sti_struct *sti_try_rom_generic(unsigned long address,
48c68c4f1b5424 drivers/video/console/sticore.c Greg Kroah-Hartman 2012-12-21  861  					      unsigned long hpa,
48c68c4f1b5424 drivers/video/console/sticore.c Greg Kroah-Hartman 2012-12-21  862  					      struct pci_dev *pd)
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  863  {
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  864  	struct sti_struct *sti;
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  865  	int ok;
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  866  	u32 sig;
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  867  
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  868  	if (num_sti_roms >= MAX_STI_ROMS) {
7ff3f14ddc355b drivers/video/console/sticore.c Helge Deller       2020-10-12  869  		pr_warn("maximum number of STI ROMS reached !\n");
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  870  		return NULL;
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  871  	}
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  872  
cb6fc18e9ca615 drivers/video/console/sticore.c Helge Deller       2006-01-17  873  	sti = kzalloc(sizeof(*sti), GFP_KERNEL);
3af04d5c459485 drivers/video/console/sticore.c Markus Elfring     2018-03-28  874  	if (!sti)
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  875  		return NULL;
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  876  
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  877  	spin_lock_init(&sti->lock);
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  878  
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  879  test_rom:
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  880  	/* if we can't read the ROM, bail out early.  Not being able
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  881  	 * to read the hpa is okay, for romless sti */
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  882  	if (pdc_add_valid(address))
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  883  		goto out_err;
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  884  
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  885  	sig = gsc_readl(address);
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  886  
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  887  	/* check for a PCI ROM structure */
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16 @888  	if ((le32_to_cpu(sig)==0xaa55)) {
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  889  		unsigned int i, rm_offset;
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  890  		u32 *rm;
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  891  		i = gsc_readl(address+0x04);
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  892  		if (i != 1) {
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  893  			/* The ROM could have multiple architecture
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  894  			 * dependent images (e.g. i386, parisc,...) */
7ff3f14ddc355b drivers/video/console/sticore.c Helge Deller       2020-10-12  895  			pr_warn("PCI ROM is not a STI ROM type image (0x%8x)\n", i);
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  896  			goto out_err;
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  897  		}
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  898  
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  899  		sti->pd = pd;
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  900  
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  901  		i = gsc_readl(address+0x0c);
7ff3f14ddc355b drivers/video/console/sticore.c Helge Deller       2020-10-12 @902  		pr_debug("PCI ROM size (from header) = %d kB\n",
7ff3f14ddc355b drivers/video/console/sticore.c Helge Deller       2020-10-12  903  			le16_to_cpu(i>>16)*512/1024);
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  904  		rm_offset = le16_to_cpu(i & 0xffff);
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  905  		if (rm_offset) {
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  906  			/* read 16 bytes from the pci region mapper array */
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  907  			rm = (u32*) &sti->rm_entry;
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  908  			*rm++ = gsc_readl(address+rm_offset+0x00);
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  909  			*rm++ = gsc_readl(address+rm_offset+0x04);
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  910  			*rm++ = gsc_readl(address+rm_offset+0x08);
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  911  			*rm++ = gsc_readl(address+rm_offset+0x0c);
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  912  		}
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  913  
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  914  		address += le32_to_cpu(gsc_readl(address+8));
7ff3f14ddc355b drivers/video/console/sticore.c Helge Deller       2020-10-12  915  		pr_debug("sig %04x, PCI STI ROM at %08lx\n", sig, address);
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  916  		goto test_rom;
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  917  	}
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  918  
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  919  	ok = 0;
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  920  
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  921  	if ((sig & 0xff) == 0x01) {
7ff3f14ddc355b drivers/video/console/sticore.c Helge Deller       2020-10-12  922  		pr_debug("    byte mode ROM at %08lx, hpa at %08lx\n",
7ff3f14ddc355b drivers/video/console/sticore.c Helge Deller       2020-10-12  923  		       address, hpa);
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  924  		ok = sti_read_rom(0, sti, address);
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  925  	}
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  926  
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  927  	if ((sig & 0xffff) == 0x0303) {
7ff3f14ddc355b drivers/video/console/sticore.c Helge Deller       2020-10-12  928  		pr_debug("    word mode ROM at %08lx, hpa at %08lx\n",
7ff3f14ddc355b drivers/video/console/sticore.c Helge Deller       2020-10-12  929  		       address, hpa);
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  930  		ok = sti_read_rom(1, sti, address);
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  931  	}
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  932  
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  933  	if (!ok)
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  934  		goto out_err;
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  935  
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  936  	if (sti_init_glob_cfg(sti, address, hpa))
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  937  		goto out_err; /* not enough memory */
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  938  
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  939  	/* disable STI PCI ROM. ROM and card RAM overlap and
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  940  	 * leaving it enabled would force HPMCs
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  941  	 */
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  942  	if (sti->pd) {
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  943  		unsigned long rom_base;
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  944  		rom_base = pci_resource_start(sti->pd, PCI_ROM_RESOURCE);
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  945  		pci_write_config_dword(sti->pd, PCI_ROM_ADDRESS, rom_base & ~PCI_ROM_ADDRESS_ENABLE);
7ff3f14ddc355b drivers/video/console/sticore.c Helge Deller       2020-10-12  946  		pr_debug("STI PCI ROM disabled\n");
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  947  	}
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  948  
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  949  	if (sti_init_graph(sti))
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  950  		goto out_err;
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  951  
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  952  	sti_inq_conf(sti);
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  953  	sti_dump_globcfg(sti->glob_cfg, sti->sti_mem_request);
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  954  	sti_dump_outptr(sti);
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  955  
0219132fe7c265 drivers/video/console/sticore.c Helge Deller       2013-11-06  956  	pr_info("    graphics card name: %s\n",
0219132fe7c265 drivers/video/console/sticore.c Helge Deller       2013-11-06  957  		sti->sti_data->inq_outptr.dev_name);
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  958  
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  959  	sti_roms[num_sti_roms] = sti;
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  960  	num_sti_roms++;
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  961  
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  962  	return sti;
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  963  
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  964  out_err:
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  965  	kfree(sti);
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  966  	return NULL;
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  967  }
^1da177e4c3f41 drivers/video/console/sticore.c Linus Torvalds     2005-04-16  968  

:::::: The code at line 888 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
