Return-Path: <linux-kernel+bounces-164745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5B08B81F4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 23:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30C1A285711
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7991D1BED72;
	Tue, 30 Apr 2024 21:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TldT/FbN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDA050287
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 21:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714512903; cv=none; b=nqUxRQdoLh9mjbos9Wosmtlfioad1CuW8lARq0BFrnh8ieBy0Yl+53E7Md0JT26Rq/mkPeVQjgAhvtQoFAd/yO6aTaaKR2OnuObLTU3qekzKf3G0Cb5ztCxJ3P2rMaZU2S8GfPdNlxdCRpKtmI6O2abL1gHeGwYbz9el0ZFeSOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714512903; c=relaxed/simple;
	bh=tTccR7b+fg7YW2r965Vb1yvRMrgT+rQm3TA8SN9Sdu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjhcliNKDZtfQPYm1fkQ7u33a4M5yxwM/63F32IZPiK89IaY7JEeqHFVSPPmrg61h1w4BofTwob+r1qM+58h9Ad5UmwVaRd0nXkjWs0eUOKFk7G5ZJBv9T6HViaTVZfUOrxaDfCRqCjK4+914PWVs5YAeT2hwbfy8cMqHcI2r1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TldT/FbN; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714512901; x=1746048901;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tTccR7b+fg7YW2r965Vb1yvRMrgT+rQm3TA8SN9Sdu0=;
  b=TldT/FbNfqLUpu3nvi0F0XurIBwYfDbRniHBSOqRFaO0L4c6Y0+w8n26
   tfGcZYpBpsJUKJhgFBgLm7/69YYcvjWV5yRGVkez6fgj27eJRWIuqrjQJ
   UfkfU2dsk/zb5BLEKgYyhZasgIjjicpgM+c2YZB2O12o3I5N/XUvFEGs8
   y4iPEJUJapgOtDnVeNG1zsm6QvK2nYuV0XXHmlI1id9tYj4gp0eLnoHx9
   rE7Zz2w0cNjHaiU8QdNhpmgGCnJo/5kgE6c5n4lO/9jcFqk/P2zUNsuBJ
   PxdS7pOpMhNXdO3J8aFs+qqMuzL8Typu/wSwaM07gQzw+KdXpvcaabIcR
   A==;
X-CSE-ConnectionGUID: f4YGGGTURwCTsFZaWvX8Tw==
X-CSE-MsgGUID: CmbhCI8gTyOBgTQnwUw6Ew==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="14070079"
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="14070079"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 14:35:00 -0700
X-CSE-ConnectionGUID: m6voHUtJQrWPhP8kSdz+Gg==
X-CSE-MsgGUID: I/a3pbHETjiyyNx1OkI/4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="31423229"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 30 Apr 2024 14:34:57 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s1v7m-0008cj-1Z;
	Tue, 30 Apr 2024 21:34:54 +0000
Date: Wed, 1 May 2024 05:34:23 +0800
From: kernel test robot <lkp@intel.com>
To: Weishi Li <liweishi@kylinos.cn>
Cc: oe-kbuild-all@lists.linux.dev, airlied@redhat.com, daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org, gurchetansingh@chromium.org,
	kraxel@redhat.com, linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	olvaffe@gmail.com, tzimmermann@suse.de,
	virtualization@lists.linux.dev
Subject: Re: [PATCH] [PATCH RESEND] drm/virtio: fix memory leak of vbuf
Message-ID: <202405010502.1BWe3b2S-lkp@intel.com>
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
[also build test ERROR on drm/drm-next drm-exynos/exynos-drm-next drm-intel/for-linux-next-fixes drm-tip/drm-tip linus/master v6.9-rc6 next-20240430]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Weishi-Li/drm-virtio-fix-memory-leak-of-vbuf/20240430-132447
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20240429030541.56702-1-liweishi%40kylinos.cn
patch subject: [PATCH] [PATCH RESEND] drm/virtio: fix memory leak of vbuf
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20240501/202405010502.1BWe3b2S-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240501/202405010502.1BWe3b2S-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405010502.1BWe3b2S-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/virtio/virtgpu_vq.c: In function 'virtio_gpu_queue_cursor':
>> drivers/gpu/drm/virtio/virtgpu_vq.c:474:9: error: expected '}' before 'else'
     474 |         else if (ret < 0) {
         |         ^~~~


vim +474 drivers/gpu/drm/virtio/virtgpu_vq.c

   448	
   449	static void virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
   450					    struct virtio_gpu_vbuffer *vbuf)
   451	{
   452		struct virtqueue *vq = vgdev->cursorq.vq;
   453		struct scatterlist *sgs[1], ccmd;
   454		int idx, ret, outcnt;
   455		bool notify;
   456	
   457		if (!drm_dev_enter(vgdev->ddev, &idx)) {
   458			free_vbuf(vgdev, vbuf);
   459			return;
   460		}
   461	
   462		sg_init_one(&ccmd, vbuf->buf, vbuf->size);
   463		sgs[0] = &ccmd;
   464		outcnt = 1;
   465	
   466		spin_lock(&vgdev->cursorq.qlock);
   467	retry:
   468		ret = virtqueue_add_sgs(vq, sgs, outcnt, 0, vbuf, GFP_ATOMIC);
   469		if (ret == -ENOSPC) {
   470			spin_unlock(&vgdev->cursorq.qlock);
   471			wait_event(vgdev->cursorq.ack_queue, vq->num_free >= outcnt);
   472			spin_lock(&vgdev->cursorq.qlock);
   473			goto retry;
 > 474		else if (ret < 0) {
   475			free_vbuf(vgdev, vbuf);
   476		} else {
   477			vbuf->seqno = ++vgdev->cursorq.seqno;
   478			trace_virtio_gpu_cmd_queue(vq,
   479				virtio_gpu_vbuf_ctrl_hdr(vbuf),
   480				vbuf->seqno);
   481	
   482			notify = virtqueue_kick_prepare(vq);
   483		}
   484	
   485		spin_unlock(&vgdev->cursorq.qlock);
   486	
   487		if (notify)
   488			virtqueue_notify(vq);
   489	
   490		drm_dev_exit(idx);
   491	}
   492	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

