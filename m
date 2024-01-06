Return-Path: <linux-kernel+bounces-18629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C5E82603A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 16:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AEDB1F2289A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 15:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C1F8475;
	Sat,  6 Jan 2024 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="giw/9+TW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEBD79E2
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 15:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704555790; x=1736091790;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1ZHWlJjK6ZtDqDZYv83Gmkh+c9zux01ejrclOxDt3cA=;
  b=giw/9+TW6Up1zkoh8eb4nTCmN4mwKpVoAeGCCLNnZKlKTC7HK9IE4vjG
   OSBQbo4rDUkSYs7mFNzjhPForyGfq8S0vZRPrl7LTKcF0EqCwHvQmyz5E
   mynZuTNT+cKKsjGUL0sAJHjkBdLw/frPpPPhXxKhr3GzadPv5DxhdGTMO
   FIYooErrcclgYsJmvHtyPo+Rr2Dlhv3KuczkgvZfAMyYhUWH5NKYC+Ef5
   zD30E63CeibnAnCXpCfcqGMyk/75+d31D1K9OxcOWwqAQvEe6AUVUv9lN
   RxVxHXku6dei9VPeePXhW+kv0i5WaIfXV5hge6q3cr0c31khCeOqKuajy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="400421741"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="400421741"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 07:43:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="22760862"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 06 Jan 2024 07:43:09 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rM8pF-0002dg-3B;
	Sat, 06 Jan 2024 15:43:05 +0000
Date: Sat, 6 Jan 2024 23:42:52 +0800
From: kernel test robot <lkp@intel.com>
To: Ben Skeggs <bskeggs@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Gourav Samaiya <gsamaiya@nvidia.com>
Subject: drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c:221:21: warning:
 variable 'loc' set but not used
Message-ID: <202401062351.g53JVBxp-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ben,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   95c8a35f1c017327eab3b6a2ff5c04255737c856
commit: 4b569ded09fdadb0c14f797c8dae4e8bc4bbad9f drm/nouveau/acr/ga102: initial support
date:   1 year, 2 months ago
config: i386-buildonly-randconfig-001-20240106 (https://download.01.org/0day-ci/archive/20240106/202401062351.g53JVBxp-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240106/202401062351.g53JVBxp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401062351.g53JVBxp-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c: In function 'nvkm_acr_lsfw_load_sig_image_desc_v2':
>> drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c:221:21: warning: variable 'loc' set but not used [-Wunused-but-set-variable]
     221 |                 u32 loc, sig, cnt, *meta;
         |                     ^~~


vim +/loc +221 drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c

   179	
   180	int
   181	nvkm_acr_lsfw_load_sig_image_desc_v2(struct nvkm_subdev *subdev,
   182					     struct nvkm_falcon *falcon,
   183					     enum nvkm_acr_lsf_id id,
   184					     const char *path, int ver,
   185					     const struct nvkm_acr_lsf_func *func)
   186	{
   187		const struct firmware *fw;
   188		struct nvkm_acr_lsfw *lsfw;
   189		const struct nvfw_ls_desc_v2 *desc;
   190		int ret = 0;
   191	
   192		lsfw = nvkm_acr_lsfw_load_sig_image_desc_(subdev, falcon, id, path, ver, func, &fw);
   193		if (IS_ERR(lsfw))
   194			return PTR_ERR(lsfw);
   195	
   196		desc = nvfw_ls_desc_v2(subdev, fw->data);
   197	
   198		lsfw->secure_bootloader = desc->secure_bootloader;
   199		lsfw->bootloader_size = ALIGN(desc->bootloader_size, 256);
   200		lsfw->bootloader_imem_offset = desc->bootloader_imem_offset;
   201	
   202		lsfw->app_size = ALIGN(desc->app_size, 256);
   203		lsfw->app_start_offset = desc->app_start_offset;
   204		lsfw->app_imem_entry = desc->app_imem_entry;
   205		lsfw->app_resident_code_offset = desc->app_resident_code_offset;
   206		lsfw->app_resident_code_size = desc->app_resident_code_size;
   207		lsfw->app_resident_data_offset = desc->app_resident_data_offset;
   208		lsfw->app_resident_data_size = desc->app_resident_data_size;
   209		lsfw->app_imem_offset = desc->app_imem_offset;
   210		lsfw->app_dmem_offset = desc->app_dmem_offset;
   211	
   212		lsfw->ucode_size = ALIGN(lsfw->app_resident_data_offset, 256) + lsfw->bootloader_size;
   213		lsfw->data_size = lsfw->app_size + lsfw->bootloader_size - lsfw->ucode_size;
   214	
   215		nvkm_firmware_put(fw);
   216	
   217		if (lsfw->secure_bootloader) {
   218			const struct firmware *hsbl;
   219			const struct nvfw_ls_hsbl_bin_hdr *hdr;
   220			const struct nvfw_ls_hsbl_hdr *hshdr;
 > 221			u32 loc, sig, cnt, *meta;
   222	
   223			ret = nvkm_firmware_load_name(subdev, path, "hs_bl_sig", ver, &hsbl);
   224			if (ret)
   225				return ret;
   226	
   227			hdr = nvfw_ls_hsbl_bin_hdr(subdev, hsbl->data);
   228			hshdr = nvfw_ls_hsbl_hdr(subdev, hsbl->data + hdr->header_offset);
   229			meta = (u32 *)(hsbl->data + hshdr->meta_data_offset);
   230			loc = *(u32 *)(hsbl->data + hshdr->patch_loc);
   231			sig = *(u32 *)(hsbl->data + hshdr->patch_sig);
   232			cnt = *(u32 *)(hsbl->data + hshdr->num_sig);
   233	
   234			lsfw->fuse_ver = meta[0];
   235			lsfw->engine_id = meta[1];
   236			lsfw->ucode_id = meta[2];
   237			lsfw->sig_size = hshdr->sig_prod_size / cnt;
   238			lsfw->sig_nr = cnt;
   239			lsfw->sigs = kmemdup(hsbl->data + hshdr->sig_prod_offset + sig,
   240					     lsfw->sig_nr * lsfw->sig_size, GFP_KERNEL);
   241			nvkm_firmware_put(hsbl);
   242			if (!lsfw->sigs)
   243				ret = -ENOMEM;
   244		}
   245	
   246		return ret;
   247	}
   248	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

