Return-Path: <linux-kernel+bounces-164780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA6C8B82C8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 00:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44D96281C90
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 22:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2F01BF6F4;
	Tue, 30 Apr 2024 22:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="blsYEsVs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6591B2C853
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 22:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714517465; cv=none; b=BDBepemm95FSKhp/fIu/nDe2KvoNwjZTFIR6Zl9Lt/vPnO5wtCw+7JfQtjoY6Xf6KZOehUk7hAxiNla7t/Jz13DrRrWha7UoR4tPE5W7OnM/SzIeWA+XtlciBTRo6WeQ4Y7hgwb/9vg+Opqn6/ShRNJlTL9jXpQjA3Hf/jBBG0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714517465; c=relaxed/simple;
	bh=WI6e855Kc92SAi9gqKtnj+EkJ3KnHR+2fh4AgnRu2iY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHgasdatG6v4keGFl/d8hbCPUqsE8gFj8maJJxm284+lvMMm6c/RpZ16Ne6tyr+3ASCoEHe645pAebR7UP5K0LnRYLbSK5FwqSEqA6/PsWyuRVrdGV+vEFFJTTNBHL6LsullFmOOIdqyGQxSAojoHBUWhQeSvZGadYcC2zH+BPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=blsYEsVs; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714517463; x=1746053463;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WI6e855Kc92SAi9gqKtnj+EkJ3KnHR+2fh4AgnRu2iY=;
  b=blsYEsVss/UtVfk4IJSpqnIIF4PqVTQTxf6b9u3uV63DFdSGuGvApzL2
   yEWQsjeSkJJ98GEAu9YvSFUvI0mW37bMbM1WsACpZ7w7YUKT3V7pzYW4e
   Y/fGu/LNtjwUNI3YpQzqmJ6NvsVlxCJ7tGdDoH9SwAYIHCCJgWQy8X6bP
   d3js5BJf9qe3yhbkmeAUsRPxlqbvzokMkEgv40U6QmK1MfdTyaCs3rXZY
   UClUp4NFKpqM63EaIvQpWVagjbRj5W1ca4H+jmIctvMgNYTEJIlLJc6H4
   tyTpuUfcgmvFP74D3TbWcWOq47n1AepYofFymWcV711OcqbYTZgS+9QHt
   Q==;
X-CSE-ConnectionGUID: 2gD99mi8SSWz4OLB75V51Q==
X-CSE-MsgGUID: eujphjAxSPKZxyNiUEcS0A==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10790883"
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="10790883"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 15:51:02 -0700
X-CSE-ConnectionGUID: FZkSokSlRC6f+NGqNm3JLw==
X-CSE-MsgGUID: qu5447TjTguXRIksIdWSjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="64102738"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 30 Apr 2024 15:50:59 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s1wJM-0008fJ-0R;
	Tue, 30 Apr 2024 22:50:56 +0000
Date: Wed, 1 May 2024 06:50:26 +0800
From: kernel test robot <lkp@intel.com>
To: Weishi Li <liweishi@kylinos.cn>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, airlied@redhat.com,
	daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
	gurchetansingh@chromium.org, kraxel@redhat.com,
	linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, olvaffe@gmail.com, tzimmermann@suse.de,
	virtualization@lists.linux.dev
Subject: Re: [PATCH] [PATCH RESEND] drm/virtio: fix memory leak of vbuf
Message-ID: <202405010653.utlwekew-lkp@intel.com>
References: <20240429030541.56702-1-liweishi@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429030541.56702-1-liweishi@kylinos.cn>

Hi Weishi,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on drm/drm-next drm-exynos/exynos-drm-next drm-intel/for-linux-next drm-intel/for-linux-next-fixes drm-tip/drm-tip linus/master v6.9-rc6 next-20240430]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Weishi-Li/drm-virtio-fix-memory-leak-of-vbuf/20240430-132447
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20240429030541.56702-1-liweishi%40kylinos.cn
patch subject: [PATCH] [PATCH RESEND] drm/virtio: fix memory leak of vbuf
config: hexagon-randconfig-001-20240501 (https://download.01.org/0day-ci/archive/20240501/202405010653.utlwekew-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240501/202405010653.utlwekew-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405010653.utlwekew-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/virtio/virtgpu_vq.c:29:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from drivers/gpu/drm/virtio/virtgpu_vq.c:29:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/gpu/drm/virtio/virtgpu_vq.c:29:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   drivers/gpu/drm/virtio/virtgpu_vq.c:474:2: error: expected expression
           else if (ret < 0) {
           ^
>> drivers/gpu/drm/virtio/virtgpu_vq.c:503:1: error: function definition is not allowed here
   {
   ^
   drivers/gpu/drm/virtio/virtgpu_vq.c:523:1: error: function definition is not allowed here
   {
   ^
   drivers/gpu/drm/virtio/virtgpu_vq.c:534:1: error: function definition is not allowed here
   {
   ^
   drivers/gpu/drm/virtio/virtgpu_vq.c:556:1: error: function definition is not allowed here
   {
   ^
   drivers/gpu/drm/virtio/virtgpu_vq.c:580:1: error: function definition is not allowed here
   {
   ^
   drivers/gpu/drm/virtio/virtgpu_vq.c:604:1: error: function definition is not allowed here
   {
   ^
   drivers/gpu/drm/virtio/virtgpu_vq.c:635:1: error: function definition is not allowed here
   {
   ^
   drivers/gpu/drm/virtio/virtgpu_vq.c:654:1: error: function definition is not allowed here
   {
   ^
   drivers/gpu/drm/virtio/virtgpu_vq.c:683:1: error: function definition is not allowed here
   {
   ^
   drivers/gpu/drm/virtio/virtgpu_vq.c:704:1: error: function definition is not allowed here
   {
   ^
   drivers/gpu/drm/virtio/virtgpu_vq.c:729:1: error: function definition is not allowed here
   {
   ^
   drivers/gpu/drm/virtio/virtgpu_vq.c:741:1: error: function definition is not allowed here
   {
   ^
   drivers/gpu/drm/virtio/virtgpu_vq.c:767:1: error: function definition is not allowed here
   {
   ^
   drivers/gpu/drm/virtio/virtgpu_vq.c:790:1: error: function definition is not allowed here
   {
   ^
   drivers/gpu/drm/virtio/virtgpu_vq.c:815:1: error: function definition is not allowed here
   {
   ^
   drivers/gpu/drm/virtio/virtgpu_vq.c:889:1: error: function definition is not allowed here
   {
   ^
   drivers/gpu/drm/virtio/virtgpu_vq.c:919:1: error: function definition is not allowed here
   {
   ^
   drivers/gpu/drm/virtio/virtgpu_vq.c:936:1: error: function definition is not allowed here
   {
   ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   6 warnings and 20 errors generated.


vim +503 drivers/gpu/drm/virtio/virtgpu_vq.c

dc5698e80cf724 Dave Airlie      2013-09-09  492  
dc5698e80cf724 Dave Airlie      2013-09-09  493  /* just create gem objects for userspace and long lived objects,
5d883850dc23a5 Rodrigo Siqueira 2018-02-22  494   * just use dma_alloced pages for the queue objects?
5d883850dc23a5 Rodrigo Siqueira 2018-02-22  495   */
dc5698e80cf724 Dave Airlie      2013-09-09  496  
dc5698e80cf724 Dave Airlie      2013-09-09  497  /* create a basic resource */
dc5698e80cf724 Dave Airlie      2013-09-09  498  void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
23c897d72ca806 Gerd Hoffmann    2018-10-19  499  				    struct virtio_gpu_object *bo,
530b28426a94b8 Gerd Hoffmann    2019-03-18  500  				    struct virtio_gpu_object_params *params,
e2324300f427ff Gerd Hoffmann    2019-08-29  501  				    struct virtio_gpu_object_array *objs,
530b28426a94b8 Gerd Hoffmann    2019-03-18  502  				    struct virtio_gpu_fence *fence)
dc5698e80cf724 Dave Airlie      2013-09-09 @503  {
dc5698e80cf724 Dave Airlie      2013-09-09  504  	struct virtio_gpu_resource_create_2d *cmd_p;
dc5698e80cf724 Dave Airlie      2013-09-09  505  	struct virtio_gpu_vbuffer *vbuf;
dc5698e80cf724 Dave Airlie      2013-09-09  506  
dc5698e80cf724 Dave Airlie      2013-09-09  507  	cmd_p = virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
dc5698e80cf724 Dave Airlie      2013-09-09  508  	memset(cmd_p, 0, sizeof(*cmd_p));
e2324300f427ff Gerd Hoffmann    2019-08-29  509  	vbuf->objs = objs;
dc5698e80cf724 Dave Airlie      2013-09-09  510  
dc5698e80cf724 Dave Airlie      2013-09-09  511  	cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_RESOURCE_CREATE_2D);
724cfdfd667a28 Gerd Hoffmann    2018-10-19  512  	cmd_p->resource_id = cpu_to_le32(bo->hw_res_handle);
f9659329f222a6 Gerd Hoffmann    2019-03-18  513  	cmd_p->format = cpu_to_le32(params->format);
f9659329f222a6 Gerd Hoffmann    2019-03-18  514  	cmd_p->width = cpu_to_le32(params->width);
f9659329f222a6 Gerd Hoffmann    2019-03-18  515  	cmd_p->height = cpu_to_le32(params->height);
dc5698e80cf724 Dave Airlie      2013-09-09  516  
e19d341174b679 Chia-I Wu        2020-02-05  517  	virtio_gpu_queue_fenced_ctrl_buffer(vgdev, vbuf, fence);
23c897d72ca806 Gerd Hoffmann    2018-10-19  518  	bo->created = true;
dc5698e80cf724 Dave Airlie      2013-09-09  519  }
dc5698e80cf724 Dave Airlie      2013-09-09  520  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

