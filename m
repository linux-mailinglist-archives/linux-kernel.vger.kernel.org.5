Return-Path: <linux-kernel+bounces-12820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829A581FA73
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 19:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BB66283A50
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 18:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1015CF9E9;
	Thu, 28 Dec 2023 18:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="Jhe4BN41"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9665AF9D1
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 18:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=w6vDrnBJEMQiq5BbxSTVBT83/BhcKTZXKED9szAy8zI=;
  b=Jhe4BN41kIo6dtj//nfUdxVAYT6wv7qODb1crWZbBZ40lmNj4bPhrk/U
   xG/g2GERKKpNLx+D7rOO9KgW9g3qPx4JzdTPYXp3cEQzD/qh60qO7XMz7
   NzMGIub8zqCFct2PcxTfqflHiUml3TLu/qC7pU3uNfKZ6xWH0Ea+a7F6W
   c=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.04,312,1695679200"; 
   d="scan'208";a="144239018"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 19:04:53 +0100
Date: Thu, 28 Dec 2023 19:04:52 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Ben Skeggs <bskeggs@redhat.com>, Lyude Paul <lyude@redhat.com>
cc: linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: drivers/gpu/drm/nouveau/nvkm/engine/gr/gv100.c:153:33-34: WARNING
 opportunity for max() (fwd)
Message-ID: <527193cf-3497-8e6c-6b15-d156d1ff894f@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



---------- Forwarded message ----------
Date: Thu, 28 Dec 2023 19:36:08 +0800
From: kernel test robot <lkp@intel.com>
To: oe-kbuild@lists.linux.dev
Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
Subject: drivers/gpu/drm/nouveau/nvkm/engine/gr/gv100.c:153:33-34: WARNING
    opportunity for max()

BCC: lkp@intel.com
CC: oe-kbuild-all@lists.linux.dev
CC: linux-kernel@vger.kernel.org
TO: Ben Skeggs <bskeggs@redhat.com>
CC: Lyude Paul <lyude@redhat.com>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f5837722ffecbbedf1b1dbab072a063565f0dad1
commit: 3ffa6f329b610029b44ebd7bc2320a92468a0e42 drm/nouveau/gr/gv100-: port smid mapping code from nvgpu
date:   1 year, 2 months ago
:::::: branch date: 11 hours ago
:::::: commit date: 1 year, 2 months ago
config: loongarch-randconfig-r062-20231222 (https://download.01.org/0day-ci/archive/20231228/202312281922.kNIoRppR-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Julia Lawall <julia.lawall@inria.fr>
| Closes: https://lore.kernel.org/r/202312281922.kNIoRppR-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/nouveau/nvkm/engine/gr/gv100.c:153:33-34: WARNING opportunity for max()

vim +153 drivers/gpu/drm/nouveau/nvkm/engine/gr/gv100.c

3ffa6f329b6100 Ben Skeggs 2022-06-01  104
3ffa6f329b6100 Ben Skeggs 2022-06-01  105  static int
3ffa6f329b6100 Ben Skeggs 2022-06-01  106  gv100_gr_scg_estimate_perf(struct gf100_gr *gr, unsigned long *gpc_tpc_mask,
3ffa6f329b6100 Ben Skeggs 2022-06-01  107  			   u32 disable_gpc, u32 disable_tpc, int *perf)
3ffa6f329b6100 Ben Skeggs 2022-06-01  108  {
3ffa6f329b6100 Ben Skeggs 2022-06-01  109  	const u32 scale_factor = 512UL;		/* Use fx23.9 */
3ffa6f329b6100 Ben Skeggs 2022-06-01  110  	const u32 pix_scale = 1024*1024UL;	/* Pix perf in [29:20] */
3ffa6f329b6100 Ben Skeggs 2022-06-01  111  	const u32 world_scale = 1024UL;		/* World performance in [19:10] */
3ffa6f329b6100 Ben Skeggs 2022-06-01  112  	const u32 tpc_scale = 1;		/* TPC balancing in [9:0] */
3ffa6f329b6100 Ben Skeggs 2022-06-01  113  	u32 scg_num_pes = 0;
3ffa6f329b6100 Ben Skeggs 2022-06-01  114  	u32 min_scg_gpc_pix_perf = scale_factor; /* Init perf as maximum */
3ffa6f329b6100 Ben Skeggs 2022-06-01  115  	u32 average_tpcs = 0; /* Average of # of TPCs per GPC */
3ffa6f329b6100 Ben Skeggs 2022-06-01  116  	u32 deviation; /* absolute diff between TPC# and average_tpcs, averaged across GPCs */
3ffa6f329b6100 Ben Skeggs 2022-06-01  117  	u32 norm_tpc_deviation;	/* deviation/max_tpc_per_gpc */
3ffa6f329b6100 Ben Skeggs 2022-06-01  118  	u32 tpc_balance;
3ffa6f329b6100 Ben Skeggs 2022-06-01  119  	u32 scg_gpc_pix_perf;
3ffa6f329b6100 Ben Skeggs 2022-06-01  120  	u32 scg_world_perf;
3ffa6f329b6100 Ben Skeggs 2022-06-01  121  	u32 gpc;
3ffa6f329b6100 Ben Skeggs 2022-06-01  122  	u32 pes;
3ffa6f329b6100 Ben Skeggs 2022-06-01  123  	int diff;
3ffa6f329b6100 Ben Skeggs 2022-06-01  124  	bool tpc_removed_gpc = false;
3ffa6f329b6100 Ben Skeggs 2022-06-01  125  	bool tpc_removed_pes = false;
3ffa6f329b6100 Ben Skeggs 2022-06-01  126  	u32 max_tpc_gpc = 0;
3ffa6f329b6100 Ben Skeggs 2022-06-01  127  	u32 num_tpc_mask;
3ffa6f329b6100 Ben Skeggs 2022-06-01  128  	u32 *num_tpc_gpc;
3ffa6f329b6100 Ben Skeggs 2022-06-01  129  	int ret = -EINVAL;
3ffa6f329b6100 Ben Skeggs 2022-06-01  130
3ffa6f329b6100 Ben Skeggs 2022-06-01  131  	if (!(num_tpc_gpc = kcalloc(gr->gpc_nr, sizeof(*num_tpc_gpc), GFP_KERNEL)))
3ffa6f329b6100 Ben Skeggs 2022-06-01  132  		return -ENOMEM;
3ffa6f329b6100 Ben Skeggs 2022-06-01  133
3ffa6f329b6100 Ben Skeggs 2022-06-01  134  	/* Calculate pix-perf-reduction-rate per GPC and find bottleneck TPC */
3ffa6f329b6100 Ben Skeggs 2022-06-01  135  	for (gpc = 0; gpc < gr->gpc_nr; gpc++) {
3ffa6f329b6100 Ben Skeggs 2022-06-01  136  		num_tpc_mask = gpc_tpc_mask[gpc];
3ffa6f329b6100 Ben Skeggs 2022-06-01  137
3ffa6f329b6100 Ben Skeggs 2022-06-01  138  		if ((gpc == disable_gpc) && num_tpc_mask & BIT(disable_tpc)) {
3ffa6f329b6100 Ben Skeggs 2022-06-01  139  			/* Safety check if a TPC is removed twice */
3ffa6f329b6100 Ben Skeggs 2022-06-01  140  			if (WARN_ON(tpc_removed_gpc))
3ffa6f329b6100 Ben Skeggs 2022-06-01  141  				goto done;
3ffa6f329b6100 Ben Skeggs 2022-06-01  142
3ffa6f329b6100 Ben Skeggs 2022-06-01  143  			/* Remove logical TPC from set */
3ffa6f329b6100 Ben Skeggs 2022-06-01  144  			num_tpc_mask &= ~BIT(disable_tpc);
3ffa6f329b6100 Ben Skeggs 2022-06-01  145  			tpc_removed_gpc = true;
3ffa6f329b6100 Ben Skeggs 2022-06-01  146  		}
3ffa6f329b6100 Ben Skeggs 2022-06-01  147
3ffa6f329b6100 Ben Skeggs 2022-06-01  148  		/* track balancing of tpcs across gpcs */
3ffa6f329b6100 Ben Skeggs 2022-06-01  149  		num_tpc_gpc[gpc] = hweight32(num_tpc_mask);
3ffa6f329b6100 Ben Skeggs 2022-06-01  150  		average_tpcs += num_tpc_gpc[gpc];
3ffa6f329b6100 Ben Skeggs 2022-06-01  151
3ffa6f329b6100 Ben Skeggs 2022-06-01  152  		/* save the maximum numer of gpcs */
3ffa6f329b6100 Ben Skeggs 2022-06-01 @153  		max_tpc_gpc = num_tpc_gpc[gpc] > max_tpc_gpc ? num_tpc_gpc[gpc] : max_tpc_gpc;
3ffa6f329b6100 Ben Skeggs 2022-06-01  154
3ffa6f329b6100 Ben Skeggs 2022-06-01  155  		/*
3ffa6f329b6100 Ben Skeggs 2022-06-01  156  		 * Calculate ratio between TPC count and post-FS and post-SCG
3ffa6f329b6100 Ben Skeggs 2022-06-01  157  		 *
3ffa6f329b6100 Ben Skeggs 2022-06-01  158  		 * ratio represents relative throughput of the GPC
3ffa6f329b6100 Ben Skeggs 2022-06-01  159  		 */
3ffa6f329b6100 Ben Skeggs 2022-06-01  160  		scg_gpc_pix_perf = scale_factor * num_tpc_gpc[gpc] / gr->tpc_nr[gpc];
3ffa6f329b6100 Ben Skeggs 2022-06-01  161  		if (min_scg_gpc_pix_perf > scg_gpc_pix_perf)
3ffa6f329b6100 Ben Skeggs 2022-06-01  162  			min_scg_gpc_pix_perf = scg_gpc_pix_perf;
3ffa6f329b6100 Ben Skeggs 2022-06-01  163
3ffa6f329b6100 Ben Skeggs 2022-06-01  164  		/* Calculate # of surviving PES */
3ffa6f329b6100 Ben Skeggs 2022-06-01  165  		for (pes = 0; pes < gr->ppc_nr[gpc]; pes++) {
3ffa6f329b6100 Ben Skeggs 2022-06-01  166  			/* Count the number of TPC on the set */
3ffa6f329b6100 Ben Skeggs 2022-06-01  167  			num_tpc_mask = gr->ppc_tpc_mask[gpc][pes] & gpc_tpc_mask[gpc];
3ffa6f329b6100 Ben Skeggs 2022-06-01  168
3ffa6f329b6100 Ben Skeggs 2022-06-01  169  			if ((gpc == disable_gpc) && (num_tpc_mask & BIT(disable_tpc))) {
3ffa6f329b6100 Ben Skeggs 2022-06-01  170  				if (WARN_ON(tpc_removed_pes))
3ffa6f329b6100 Ben Skeggs 2022-06-01  171  					goto done;
3ffa6f329b6100 Ben Skeggs 2022-06-01  172
3ffa6f329b6100 Ben Skeggs 2022-06-01  173  				num_tpc_mask &= ~BIT(disable_tpc);
3ffa6f329b6100 Ben Skeggs 2022-06-01  174  				tpc_removed_pes = true;
3ffa6f329b6100 Ben Skeggs 2022-06-01  175  			}
3ffa6f329b6100 Ben Skeggs 2022-06-01  176
3ffa6f329b6100 Ben Skeggs 2022-06-01  177  			if (hweight32(num_tpc_mask))
3ffa6f329b6100 Ben Skeggs 2022-06-01  178  				scg_num_pes++;
3ffa6f329b6100 Ben Skeggs 2022-06-01  179  		}
3ffa6f329b6100 Ben Skeggs 2022-06-01  180  	}
3ffa6f329b6100 Ben Skeggs 2022-06-01  181
3ffa6f329b6100 Ben Skeggs 2022-06-01  182  	if (WARN_ON(!tpc_removed_gpc || !tpc_removed_pes))
3ffa6f329b6100 Ben Skeggs 2022-06-01  183  		goto done;
3ffa6f329b6100 Ben Skeggs 2022-06-01  184
3ffa6f329b6100 Ben Skeggs 2022-06-01  185  	if (max_tpc_gpc == 0) {
3ffa6f329b6100 Ben Skeggs 2022-06-01  186  		*perf = 0;
3ffa6f329b6100 Ben Skeggs 2022-06-01  187  		goto done_ok;
3ffa6f329b6100 Ben Skeggs 2022-06-01  188  	}
3ffa6f329b6100 Ben Skeggs 2022-06-01  189
3ffa6f329b6100 Ben Skeggs 2022-06-01  190  	/* Now calculate perf */
3ffa6f329b6100 Ben Skeggs 2022-06-01  191  	scg_world_perf = (scale_factor * scg_num_pes) / gr->ppc_total;
3ffa6f329b6100 Ben Skeggs 2022-06-01  192  	deviation = 0;
3ffa6f329b6100 Ben Skeggs 2022-06-01  193  	average_tpcs = scale_factor * average_tpcs / gr->gpc_nr;
3ffa6f329b6100 Ben Skeggs 2022-06-01  194  	for (gpc = 0; gpc < gr->gpc_nr; gpc++) {
3ffa6f329b6100 Ben Skeggs 2022-06-01  195  		diff = average_tpcs - scale_factor * num_tpc_gpc[gpc];
3ffa6f329b6100 Ben Skeggs 2022-06-01  196  		if (diff < 0)
3ffa6f329b6100 Ben Skeggs 2022-06-01  197  			diff = -diff;
3ffa6f329b6100 Ben Skeggs 2022-06-01  198
3ffa6f329b6100 Ben Skeggs 2022-06-01  199  		deviation += diff;
3ffa6f329b6100 Ben Skeggs 2022-06-01  200  	}
3ffa6f329b6100 Ben Skeggs 2022-06-01  201
3ffa6f329b6100 Ben Skeggs 2022-06-01  202  	deviation /= gr->gpc_nr;
3ffa6f329b6100 Ben Skeggs 2022-06-01  203
3ffa6f329b6100 Ben Skeggs 2022-06-01  204  	norm_tpc_deviation = deviation / max_tpc_gpc;
3ffa6f329b6100 Ben Skeggs 2022-06-01  205
3ffa6f329b6100 Ben Skeggs 2022-06-01  206  	tpc_balance = scale_factor - norm_tpc_deviation;
3ffa6f329b6100 Ben Skeggs 2022-06-01  207
3ffa6f329b6100 Ben Skeggs 2022-06-01  208  	if ((tpc_balance > scale_factor)          ||
3ffa6f329b6100 Ben Skeggs 2022-06-01  209  	    (scg_world_perf > scale_factor)       ||
3ffa6f329b6100 Ben Skeggs 2022-06-01  210  	    (min_scg_gpc_pix_perf > scale_factor) ||
3ffa6f329b6100 Ben Skeggs 2022-06-01  211  	    (norm_tpc_deviation > scale_factor)) {
3ffa6f329b6100 Ben Skeggs 2022-06-01  212  		WARN_ON(1);
3ffa6f329b6100 Ben Skeggs 2022-06-01  213  		goto done;
3ffa6f329b6100 Ben Skeggs 2022-06-01  214  	}
3ffa6f329b6100 Ben Skeggs 2022-06-01  215
3ffa6f329b6100 Ben Skeggs 2022-06-01  216  	*perf = (pix_scale * min_scg_gpc_pix_perf) +
3ffa6f329b6100 Ben Skeggs 2022-06-01  217  		(world_scale * scg_world_perf) +
3ffa6f329b6100 Ben Skeggs 2022-06-01  218  		(tpc_scale * tpc_balance);
3ffa6f329b6100 Ben Skeggs 2022-06-01  219  done_ok:
3ffa6f329b6100 Ben Skeggs 2022-06-01  220  	ret = 0;
3ffa6f329b6100 Ben Skeggs 2022-06-01  221  done:
3ffa6f329b6100 Ben Skeggs 2022-06-01  222  	kfree(num_tpc_gpc);
3ffa6f329b6100 Ben Skeggs 2022-06-01  223  	return ret;
3ffa6f329b6100 Ben Skeggs 2022-06-01  224  }
3ffa6f329b6100 Ben Skeggs 2022-06-01  225

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

