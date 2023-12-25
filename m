Return-Path: <linux-kernel+bounces-10849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F6A81DD58
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 01:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D662D1C21165
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 00:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5E11841;
	Mon, 25 Dec 2023 00:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lp2kF2RC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4217F15A8
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 00:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703463819; x=1734999819;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YJh+wDeictl+xtWW+8VJ+rNO8BXxEMpGjARlTTa1wMI=;
  b=lp2kF2RCwQ75zlyo4WAvsW4qGLh1zB7aUaGu8DITmRqowST74uAbRpom
   qAlfWEAGjCH6VNITpYszszUigv1lJTNn+Kazl6BSAlQuIVMkp6ruEU7Xu
   EHE8/By7OHNaOBl37PIhwjYvByeKbgcITXzkkQmhaOodAhwzgI7i5/KR1
   Fz8Z1cnRO5hf2DdIlHbyGezDSqdR8GXharpDQsCHj3TFBZExOMrdqS8ry
   q/ZJeAZ58v3pHMoUuYSjb4uYhbuTXNr2VoxSKzd2/vPcvP0xHMZkFDyf7
   lIe0iq47gpgnZ2jz9FSNCbD2jy9ONYxXKJ4WfdsTGea52VBqpuT35LzzF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="376398398"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="376398398"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 16:23:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="950863770"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="950863770"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 24 Dec 2023 16:23:32 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHYjt-000ClZ-05;
	Mon, 25 Dec 2023 00:23:06 +0000
Date: Mon, 25 Dec 2023 08:19:56 +0800
From: kernel test robot <lkp@intel.com>
To: Julia Zhang <julia.zhang@amd.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>, David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
	virtualization@lists.linux-foundation.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	Daniel Stone <daniels@collabora.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Marek =?utf-8?B?T2zFocOhaw==?= <marek.olsak@amd.com>,
	Chen Jiqian <Jiqian.Chen@amd.com>, Huang Rui <ray.huang@amd.com>,
	Honglei Huang <honglei1.huang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Julia Zhang <julia.zhang@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 1/1] drm/virtio: Implement RESOURCE_GET_LAYOUT ioctl
Message-ID: <202312250806.sVSnK275-lkp@intel.com>
References: <20231221100016.4022353-2-julia.zhang@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221100016.4022353-2-julia.zhang@amd.com>

Hi Julia,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.7-rc6]
[also build test WARNING on linus/master]
[cannot apply to drm-misc/drm-misc-next drm/drm-next next-20231222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Julia-Zhang/drm-virtio-Implement-RESOURCE_GET_LAYOUT-ioctl/20231222-182142
base:   v6.7-rc6
patch link:    https://lore.kernel.org/r/20231221100016.4022353-2-julia.zhang%40amd.com
patch subject: [PATCH 1/1] drm/virtio: Implement RESOURCE_GET_LAYOUT ioctl
config: i386-randconfig-004-20231225 (https://download.01.org/0day-ci/archive/20231225/202312250806.sVSnK275-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231225/202312250806.sVSnK275-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312250806.sVSnK275-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/virtio/virtgpu_ioctl.c:712:1: warning: unused label 'valid' [-Wunused-label]
   valid:
   ^~~~~~
   1 warning generated.


vim +/valid +712 drivers/gpu/drm/virtio/virtgpu_ioctl.c

   673	
   674	static int virtio_gpu_resource_query_layout_ioctl(struct drm_device *dev,
   675							  void *data,
   676							  struct drm_file *file)
   677	{
   678		struct drm_virtgpu_resource_query_layout *args = data;
   679		struct virtio_gpu_device *vgdev = dev->dev_private;
   680		struct drm_gem_object *obj = NULL;
   681		struct virtio_gpu_object *bo = NULL;
   682		struct virtio_gpu_query_info bo_info = {0};
   683		int ret = 0;
   684		int i;
   685	
   686		if (!vgdev->has_resource_query_layout) {
   687			DRM_ERROR("failing: no RQL on host\n");
   688			return -EINVAL;
   689		}
   690	
   691		if (args->handle > 0) {
   692			obj = drm_gem_object_lookup(file, args->handle);
   693			if (obj == NULL) {
   694				DRM_ERROR("invalid handle 0x%x\n", args->handle);
   695				return -ENOENT;
   696			}
   697			bo = gem_to_virtio_gpu_obj(obj);
   698		}
   699	
   700		ret = virtio_gpu_cmd_get_resource_layout(vgdev, &bo_info, args->width,
   701							 args->height, args->format,
   702							 args->bind, bo ? bo->hw_res_handle : 0);
   703		if (ret)
   704			goto out;
   705	
   706		ret = wait_event_timeout(vgdev->resp_wq,
   707					 atomic_read(&bo_info.is_valid),
   708					 5 * HZ);
   709		if (!ret)
   710			goto out;
   711	
 > 712	valid:
   713		smp_rmb();
   714		WARN_ON(atomic_read(&bo_info.is_valid));
   715		args->num_planes = bo_info.num_planes;
   716		args->modifier = bo_info.modifier;
   717		for (i = 0; i < args->num_planes; i++) {
   718			args->planes[i].offset = bo_info.planes[i].offset;
   719			args->planes[i].stride = bo_info.planes[i].stride;
   720		}
   721		for (; i < VIRTIO_GPU_MAX_RESOURCE_PLANES; i++) {
   722			args->planes[i].offset = 0;
   723			args->planes[i].stride = 0;
   724		}
   725		ret = 0;
   726	
   727	out:
   728		if (obj)
   729			drm_gem_object_put(obj);
   730		return ret;
   731	}
   732	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

