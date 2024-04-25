Return-Path: <linux-kernel+bounces-159152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A76DA8B2A02
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2925B2434E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83580152E19;
	Thu, 25 Apr 2024 20:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YWT8Eqgs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043A215350B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 20:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714077800; cv=none; b=D+ywxrZQt3SDa7IOmrwfyKoi0674t6zDu0bUiA7RXj6neRQ0ONpNqJm4ak/WQKu1s4CriZt+BrUz4D0HUv4HVSDwSug14ujEK+CC8ZqriDsAcHz5VVuCmmee0qtT+imwel702uZhn6t4hXXNl72gGuWmmdC3pPD0wnkAb6id2PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714077800; c=relaxed/simple;
	bh=d0u/UYGgMZ/ylELnjcLMSgPP4IOO4RgVD9oggVdGeLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZK51dGx4JTAQyHi/kt+Udl1LdG8c5q5AigoMNM2x7HS0/XuvhxxJbOolK0FILKsgh5HwBiyfOPeIayi4pvN9BZhikqikxYsQDkzv+dkqCpIjj1ZxohaVU1KTCCtGfdkxelzH1N971gry2J97CAVzWVwId0VBJZB81NCD5mHa7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YWT8Eqgs; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714077798; x=1745613798;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d0u/UYGgMZ/ylELnjcLMSgPP4IOO4RgVD9oggVdGeLc=;
  b=YWT8EqgsOWG2oWuZZILt4P6p4pIaBwh3M/btX8ubKiT2Aa9dCKrDpaz/
   GtpwxkIeth56vbYBaNRmTfgq490rGFLwT8O8RkmRPan6Gmf3CrGUTdZ3j
   St/30OZR/8Ln6AtsMux700QbEeOCjg1hoNOENwmm0kXvx4zbDBQkZbbFt
   LJX8K2u9BNpZJ1BQ9aQ+gHNt0j2MlJhZbjizNznQGe+eX9HX56c0i6+oN
   psFHZvxbqDrYirZIj5sEByU7Rasz4YvUoXyOHOXI1YdM6ohbrzAohuPCe
   yT0l48Qb6hEhF0V1SA2VkpI51WEuat3LX5QSJeXGFDbW2CfheCEilYOa/
   A==;
X-CSE-ConnectionGUID: O4JxuYCSTs2f/c4L8mIfyg==
X-CSE-MsgGUID: gIX+jKLiTSyGe2b15CP2rw==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="20348684"
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="20348684"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 13:43:17 -0700
X-CSE-ConnectionGUID: DXqldONVSqq/tvcxrO524A==
X-CSE-MsgGUID: XdEYLh6/TH+Kh4LcrDf7eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="30009186"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 25 Apr 2024 13:43:15 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s05w1-0002qq-0N;
	Thu, 25 Apr 2024 20:43:13 +0000
Date: Fri, 26 Apr 2024 04:42:51 +0800
From: kernel test robot <lkp@intel.com>
To: Gavin Shan <gshan@redhat.com>, virtualization@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	mst@redhat.com, jasowang@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH 3/4] vhost: Improve vhost_get_avail_head()
Message-ID: <202404260448.g7F06v7M-lkp@intel.com>
References: <20240423032407.262329-4-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423032407.262329-4-gshan@redhat.com>

Hi Gavin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mst-vhost/linux-next]
[also build test WARNING on linus/master v6.9-rc5 next-20240424]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gavin-Shan/vhost-Drop-variable-last_avail_idx-in-vhost_get_vq_desc/20240423-112803
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
patch link:    https://lore.kernel.org/r/20240423032407.262329-4-gshan%40redhat.com
patch subject: [PATCH 3/4] vhost: Improve vhost_get_avail_head()
config: i386-randconfig-141-20240426 (https://download.01.org/0day-ci/archive/20240426/202404260448.g7F06v7M-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404260448.g7F06v7M-lkp@intel.com/

smatch warnings:
drivers/vhost/vhost.c:2614 vhost_get_vq_desc() warn: unsigned 'head' is never less than zero.
drivers/vhost/vhost.c:2614 vhost_get_vq_desc() warn: error code type promoted to positive: 'head'

vim +/head +2614 drivers/vhost/vhost.c

  2581	
  2582	/* This looks in the virtqueue and for the first available buffer, and converts
  2583	 * it to an iovec for convenient access.  Since descriptors consist of some
  2584	 * number of output then some number of input descriptors, it's actually two
  2585	 * iovecs, but we pack them into one and note how many of each there were.
  2586	 *
  2587	 * This function returns the descriptor number found, or vq->num (which is
  2588	 * never a valid descriptor number) if none was found.  A negative code is
  2589	 * returned on error. */
  2590	int vhost_get_vq_desc(struct vhost_virtqueue *vq,
  2591			      struct iovec iov[], unsigned int iov_size,
  2592			      unsigned int *out_num, unsigned int *in_num,
  2593			      struct vhost_log *log, unsigned int *log_num)
  2594	{
  2595		struct vring_desc desc;
  2596		unsigned int i, head, found = 0;
  2597		int ret, access;
  2598	
  2599		if (vq->avail_idx == vq->last_avail_idx) {
  2600			ret = vhost_get_avail_idx(vq);
  2601			if (unlikely(ret))
  2602				return ret;
  2603	
  2604			/* If there's nothing new since last we looked, return
  2605			 * invalid.
  2606			 */
  2607			if (vq->avail_idx == vq->last_avail_idx)
  2608				return vq->num;
  2609		}
  2610	
  2611		/* Grab the next descriptor number they're advertising, and increment
  2612		 * the index we've seen. */
  2613		head = vhost_get_avail_head(vq);
> 2614		if (unlikely(head < 0))
  2615			return head;
  2616	
  2617		/* When we start there are none of either input nor output. */
  2618		*out_num = *in_num = 0;
  2619		if (unlikely(log))
  2620			*log_num = 0;
  2621	
  2622		i = head;
  2623		do {
  2624			unsigned iov_count = *in_num + *out_num;
  2625			if (unlikely(i >= vq->num)) {
  2626				vq_err(vq, "Desc index is %u > %u, head = %u",
  2627				       i, vq->num, head);
  2628				return -EINVAL;
  2629			}
  2630			if (unlikely(++found > vq->num)) {
  2631				vq_err(vq, "Loop detected: last one at %u "
  2632				       "vq size %u head %u\n",
  2633				       i, vq->num, head);
  2634				return -EINVAL;
  2635			}
  2636			ret = vhost_get_desc(vq, &desc, i);
  2637			if (unlikely(ret)) {
  2638				vq_err(vq, "Failed to get descriptor: idx %d addr %p\n",
  2639				       i, vq->desc + i);
  2640				return -EFAULT;
  2641			}
  2642			if (desc.flags & cpu_to_vhost16(vq, VRING_DESC_F_INDIRECT)) {
  2643				ret = get_indirect(vq, iov, iov_size,
  2644						   out_num, in_num,
  2645						   log, log_num, &desc);
  2646				if (unlikely(ret < 0)) {
  2647					if (ret != -EAGAIN)
  2648						vq_err(vq, "Failure detected "
  2649							"in indirect descriptor at idx %d\n", i);
  2650					return ret;
  2651				}
  2652				continue;
  2653			}
  2654	
  2655			if (desc.flags & cpu_to_vhost16(vq, VRING_DESC_F_WRITE))
  2656				access = VHOST_ACCESS_WO;
  2657			else
  2658				access = VHOST_ACCESS_RO;
  2659			ret = translate_desc(vq, vhost64_to_cpu(vq, desc.addr),
  2660					     vhost32_to_cpu(vq, desc.len), iov + iov_count,
  2661					     iov_size - iov_count, access);
  2662			if (unlikely(ret < 0)) {
  2663				if (ret != -EAGAIN)
  2664					vq_err(vq, "Translation failure %d descriptor idx %d\n",
  2665						ret, i);
  2666				return ret;
  2667			}
  2668			if (access == VHOST_ACCESS_WO) {
  2669				/* If this is an input descriptor,
  2670				 * increment that count. */
  2671				*in_num += ret;
  2672				if (unlikely(log && ret)) {
  2673					log[*log_num].addr = vhost64_to_cpu(vq, desc.addr);
  2674					log[*log_num].len = vhost32_to_cpu(vq, desc.len);
  2675					++*log_num;
  2676				}
  2677			} else {
  2678				/* If it's an output descriptor, they're all supposed
  2679				 * to come before any input descriptors. */
  2680				if (unlikely(*in_num)) {
  2681					vq_err(vq, "Descriptor has out after in: "
  2682					       "idx %d\n", i);
  2683					return -EINVAL;
  2684				}
  2685				*out_num += ret;
  2686			}
  2687		} while ((i = next_desc(vq, &desc)) != -1);
  2688	
  2689		/* On success, increment avail index. */
  2690		vq->last_avail_idx++;
  2691	
  2692		/* Assume notifications from guest are disabled at this point,
  2693		 * if they aren't we would need to update avail_event index. */
  2694		BUG_ON(!(vq->used_flags & VRING_USED_F_NO_NOTIFY));
  2695		return head;
  2696	}
  2697	EXPORT_SYMBOL_GPL(vhost_get_vq_desc);
  2698	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

