Return-Path: <linux-kernel+bounces-147802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2058A79DE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F324283446
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0041877;
	Wed, 17 Apr 2024 00:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f3wo3DsG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A6F812;
	Wed, 17 Apr 2024 00:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713313944; cv=none; b=ugnNOLcfpQLCr9L72eAX8kzBTQqMPpyWN7Dk5d2JhErVVtBspZsN4vQdFt8wEXNlJugcECekf5bjUdSNqcuwInWMJ4XGRkEZDSzwfl6VCQgfiNXyjF2gRxg3NOMIkIL1dBpIBIdrHeI7rhiAU+uEkAyCZ5q0t/KvpKNLIU2wpTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713313944; c=relaxed/simple;
	bh=E78q9qxu6fgEi0Hu9VQBbhkJUlwzErCAfnhnu3DfPDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdnS5SgPe1aVhF8AvpyyrscyVlLuCoH66AWy5gvmS9AiwwHVWDhJg5W2kH0JUf4z0yukhUyF6FArsnFBdTB2vehYV7KNY5D3YpfregHp2sPga3V340RZy6d+8eYdbjizB+payxFFJ4StQWsfPAVZX+UQqAsjS6dTOBVpEw9h/0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f3wo3DsG; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713313942; x=1744849942;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E78q9qxu6fgEi0Hu9VQBbhkJUlwzErCAfnhnu3DfPDI=;
  b=f3wo3DsGjlVuWO8cALNtKxbpGb4kNXw06aoTrwbFvkcH/1XJfgnbLCs5
   R9i9g527k6vCzbCGafLcQYzll8RQucjO6YdI2k8dAPcYui7Hv3BeDmfFM
   0NE/65lr2p2mVwmdlBtDgUs4F9at+Iu4+aXSmoJ9TxsLUVdKOGXVPc67W
   9fYb3jYk3CIfJ0ydgbJI8RFPh4A6EMxkqMNCUKXzwBdxn2rOlnyWkIrtT
   4e/vICBrmGVLnN5etVj+W7qbW6pYt210tE/4OpDriXiNJtLP0sjzUjEgT
   iFfrj5FMg/ac/9mfHavZg03L4UzSNgtpF599d/Wi1mqiTI+tuoO3uDkQA
   g==;
X-CSE-ConnectionGUID: F9KqvMBxQfyUSxv3Uo4IGQ==
X-CSE-MsgGUID: vd3GX53wTSq4q7KYNddJ3g==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8667815"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="8667815"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 17:32:21 -0700
X-CSE-ConnectionGUID: WeG2B2aUQ0CPFsmkwxr/JQ==
X-CSE-MsgGUID: SD+Q6YlrQGuyEHKcbvUixw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="23032746"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 16 Apr 2024 17:32:19 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rwtDk-0005tW-1Z;
	Wed, 17 Apr 2024 00:32:16 +0000
Date: Wed, 17 Apr 2024 08:31:31 +0800
From: kernel test robot <lkp@intel.com>
To: Geetha sowjanya <gakula@marvell.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, kuba@kernel.org, davem@davemloft.net,
	pabeni@redhat.com, edumazet@google.com, sgoutham@marvell.com,
	gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH 3/9] octeontx2-pf: Create representor netdev
Message-ID: <202404170853.i93jboPB-lkp@intel.com>
References: <20240416050616.6056-4-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416050616.6056-4-gakula@marvell.com>

Hi Geetha,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Geetha-sowjanya/octeontx2-pf-Refactoring-RVU-driver/20240416-131052
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240416050616.6056-4-gakula%40marvell.com
patch subject: [net-next PATCH 3/9] octeontx2-pf: Create representor netdev
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20240417/202404170853.i93jboPB-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240417/202404170853.i93jboPB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404170853.i93jboPB-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/marvell/octeontx2/nic/rep.c: In function 'rvu_rep_create':
>> drivers/net/ethernet/marvell/octeontx2/nic/rep.c:163:66: warning: '%d' directive output may be truncated writing between 1 and 4 bytes into a region of size between 1 and 11 [-Wformat-truncation=]
     163 |                 snprintf(ndev->name, sizeof(ndev->name), "r%dp%dv%d", rep_id,
         |                                                                  ^~
   drivers/net/ethernet/marvell/octeontx2/nic/rep.c:163:58: note: directive argument in the range [0, 1023]
     163 |                 snprintf(ndev->name, sizeof(ndev->name), "r%dp%dv%d", rep_id,
         |                                                          ^~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/nic/rep.c:163:17: note: 'snprintf' output between 7 and 20 bytes into a destination of size 16
     163 |                 snprintf(ndev->name, sizeof(ndev->name), "r%dp%dv%d", rep_id,
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     164 |                          rvu_get_pf(pcifunc), (pcifunc & RVU_PFVF_FUNC_MASK));
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +163 drivers/net/ethernet/marvell/octeontx2/nic/rep.c

   131	
   132	int rvu_rep_create(struct otx2_nic *priv)
   133	{
   134		int rep_cnt = priv->rep_cnt;
   135		struct net_device *ndev;
   136		struct rep_dev *rep;
   137		int rep_id, err;
   138		u16 pcifunc;
   139	
   140		priv->reps = devm_kcalloc(priv->dev, rep_cnt, sizeof(struct rep_dev), GFP_KERNEL);
   141		if (!priv->reps)
   142			return -ENOMEM;
   143	
   144		for (rep_id = 0; rep_id < rep_cnt; rep_id++) {
   145			ndev = alloc_etherdev(sizeof(*rep));
   146			if (!ndev) {
   147				dev_err(priv->dev, "PFVF representor:%d creation failed\n", rep_id);
   148				err = -ENOMEM;
   149				goto exit;
   150			}
   151	
   152			rep = netdev_priv(ndev);
   153			priv->reps[rep_id] = rep;
   154			rep->mdev = priv;
   155			rep->netdev = ndev;
   156			rep->rep_id = rep_id;
   157	
   158			ndev->min_mtu = OTX2_MIN_MTU;
   159			ndev->max_mtu = priv->hw.max_mtu;
   160			pcifunc = priv->rep_pf_map[rep_id];
   161			rep->pcifunc = pcifunc;
   162	
 > 163			snprintf(ndev->name, sizeof(ndev->name), "r%dp%dv%d", rep_id,
   164				 rvu_get_pf(pcifunc), (pcifunc & RVU_PFVF_FUNC_MASK));
   165	
   166			eth_hw_addr_random(ndev);
   167			if (register_netdev(ndev)) {
   168				dev_err(priv->dev, "PFVF reprentator registration failed\n");
   169				free_netdev(ndev);
   170				ndev->netdev_ops = NULL;
   171				goto exit;
   172			}
   173		}
   174		err = rvu_rep_napi_init(priv);
   175		if (err)
   176			goto exit;
   177	
   178		return 0;
   179	exit:
   180		rvu_rep_free_netdev(priv);
   181		return err;
   182	}
   183	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

