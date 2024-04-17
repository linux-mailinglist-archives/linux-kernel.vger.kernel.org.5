Return-Path: <linux-kernel+bounces-148903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 397B78A88C5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA2B8281200
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CDF14885F;
	Wed, 17 Apr 2024 16:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L08k37ot"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BE11487ED;
	Wed, 17 Apr 2024 16:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713371011; cv=none; b=W3MG5OXeqoWCJ0hsN24KZS+2XMJVHod0sntnOlA5I5CxmgcW7POkbUplXfoGDYrH8OloUGbuRNhK1gX396mOQX4uIjcle0GMtmpjE9msnZ4v3zPx+6yQGJOiEZbBRPkGlofTNpE03PDJp8dUwg2ejt+u5qb4j6RGUVNT8TG+Xqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713371011; c=relaxed/simple;
	bh=lbuClAYYrtJAE6xC4mB7mjUV5gy229Hdrkrt3vGfQlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zv23m4ouM/W9w1//04aDi+QhvnKCwwJZFz4XPLQgMZq5dapr54MCczuIGHbKL1cYYhDwhfSUO6KDHIoMeI/qZ4hZrwx8rnPGTCAKAa6axxKuBUUORDKPnT3rxw3Oui2R8hQMWTXWozkgsHQy/V4gnU0hBRiEmcHqLe+kiMQ+xIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L08k37ot; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713371008; x=1744907008;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lbuClAYYrtJAE6xC4mB7mjUV5gy229Hdrkrt3vGfQlo=;
  b=L08k37othrGIWLpCnrbGbAeRfZn+qfgbXNBSoN7w6Pd6+xyt/iC+lCUz
   mdKvAe2DnUs2ZXDahnVm+USpHf3Oy20kmMbZ7YhjqvsWzO7uERqgYgdfu
   J3imSFcJlOov+v+Pn1VxXxy56d0wyS6Z7dPT279RT2qdw2CUhIuVQPxMx
   gsmRMeeEpbpuz7EWbmPOdqJhrdD/ak0hKeI6Y9f7GgH39cQjSRdXSej1f
   WMCw5axtR0KH7CRWXzWakXxDHtLW2QadoIY3X3OXO7mkjH/fwrNNRqKg0
   68G8JRhDSR7MbFjGB/lbbrufT5oa1r/Y12owcC7w1h/PKM7NKiDJLD3v2
   Q==;
X-CSE-ConnectionGUID: 2bqjOPm9Txetm1qWXG+iYg==
X-CSE-MsgGUID: oDvJErY6RIyhTHnI7k0Y5w==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19478797"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="19478797"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 09:23:27 -0700
X-CSE-ConnectionGUID: vCeP4MbvQUiPJnIA0l6MmA==
X-CSE-MsgGUID: s650Uxt7QJqQIO/nYkrFqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="23099263"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 17 Apr 2024 09:23:24 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rx83u-0006m4-1G;
	Wed, 17 Apr 2024 16:23:10 +0000
Date: Thu, 18 Apr 2024 00:22:55 +0800
From: kernel test robot <lkp@intel.com>
To: Geetha sowjanya <gakula@marvell.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, kuba@kernel.org, davem@davemloft.net,
	pabeni@redhat.com, edumazet@google.com, sgoutham@marvell.com,
	gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH 2/9] octeontx2-pf: RVU representor driver
Message-ID: <202404180051.sgxiT7pZ-lkp@intel.com>
References: <20240416050616.6056-3-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416050616.6056-3-gakula@marvell.com>

Hi Geetha,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Geetha-sowjanya/octeontx2-pf-Refactoring-RVU-driver/20240416-131052
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240416050616.6056-3-gakula%40marvell.com
patch subject: [net-next PATCH 2/9] octeontx2-pf: RVU representor driver
config: loongarch-randconfig-r064-20240417 (https://download.01.org/0day-ci/archive/20240418/202404180051.sgxiT7pZ-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240418/202404180051.sgxiT7pZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404180051.sgxiT7pZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c: In function 'otx2_tx_napi_handler':
>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c:470:28: error: 'struct otx2_nic' has no member named 'reps'
     470 |                 ndev = pfvf->reps[qidx]->netdev;
         |                            ^~


vim +470 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c

   449	
   450	static int otx2_tx_napi_handler(struct otx2_nic *pfvf,
   451					struct otx2_cq_queue *cq, int budget)
   452	{
   453		int tx_pkts = 0, tx_bytes = 0, qidx;
   454		struct otx2_snd_queue *sq;
   455		struct nix_cqe_tx_s *cqe;
   456		struct net_device *ndev;
   457		int processed_cqe = 0;
   458	
   459		if (cq->pend_cqe >= budget)
   460			goto process_cqe;
   461	
   462		if (otx2_nix_cq_op_status(pfvf, cq) || !cq->pend_cqe)
   463			return 0;
   464	
   465	process_cqe:
   466		qidx = cq->cq_idx - pfvf->hw.rx_queues;
   467		sq = &pfvf->qset.sq[qidx];
   468	
   469		if (pfvf->flags & OTX2_FLAG_REP_MODE_ENABLED)
 > 470			ndev = pfvf->reps[qidx]->netdev;
   471		else
   472			ndev = pfvf->netdev;
   473	
   474		while (likely(processed_cqe < budget) && cq->pend_cqe) {
   475			cqe = (struct nix_cqe_tx_s *)otx2_get_next_cqe(cq);
   476			if (unlikely(!cqe)) {
   477				if (!processed_cqe)
   478					return 0;
   479				break;
   480			}
   481	
   482			qidx = cq->cq_idx - pfvf->hw.rx_queues;
   483	
   484			if (cq->cq_type == CQ_XDP)
   485				otx2_xdp_snd_pkt_handler(pfvf, sq, cqe);
   486			else
   487				otx2_snd_pkt_handler(pfvf, ndev, cq, &pfvf->qset.sq[qidx],
   488						     cqe, budget, &tx_pkts, &tx_bytes);
   489	
   490			cqe->hdr.cqe_type = NIX_XQE_TYPE_INVALID;
   491			processed_cqe++;
   492			cq->pend_cqe--;
   493	
   494			sq->cons_head++;
   495			sq->cons_head &= (sq->sqe_cnt - 1);
   496		}
   497	
   498		/* Free CQEs to HW */
   499		otx2_write64(pfvf, NIX_LF_CQ_OP_DOOR,
   500			     ((u64)cq->cq_idx << 32) | processed_cqe);
   501	
   502		if (likely(tx_pkts)) {
   503			struct netdev_queue *txq;
   504	
   505			qidx = cq->cq_idx - pfvf->hw.rx_queues;
   506	
   507			if (qidx >= pfvf->hw.tx_queues)
   508				qidx -= pfvf->hw.xdp_queues;
   509	
   510			if (pfvf->flags & OTX2_FLAG_REP_MODE_ENABLED)
   511				qidx = 0;
   512			txq = netdev_get_tx_queue(pfvf->netdev, qidx);
   513			netdev_tx_completed_queue(txq, tx_pkts, tx_bytes);
   514			/* Check if queue was stopped earlier due to ring full */
   515			smp_mb();
   516			if (netif_tx_queue_stopped(txq) &&
   517			    netif_carrier_ok(ndev))
   518				netif_tx_wake_queue(txq);
   519		}
   520		return 0;
   521	}
   522	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

