Return-Path: <linux-kernel+bounces-147824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F148A7A25
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 03:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA5C2283B88
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A441FC8;
	Wed, 17 Apr 2024 01:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A9CXU70o"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903A11851;
	Wed, 17 Apr 2024 01:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713317126; cv=none; b=Vs5F4nlVZknL0AxNiKFBmYu24CD152M/AIaYXdwFm7L7elMWbEWDj1Xqp2HieitOcAWGAW3mQkakaCwFY2VUSPn9MQbsszKEiAzollY6iTQxWUHEMd85D7PJ7BL7CXe2DGQLUARo2j7DlcuQHjAkQuN8aL/uOWnKgJPFAzqfidg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713317126; c=relaxed/simple;
	bh=SifNgk6MOylzLGjpF5LbD3QpijD39SXzUerpdQvNNWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nc8+6V6kNfUHHkbBIaw3Uuc3MAv1HpVqvvV97PbtECEEYW4VzBeDnRevPXLebUFPcOnRW15+Wes5ZG2sb+6bbAqnYfDKROLe5TQztXMwcf+HKBlmzM72yd87RA14mLRp0wZv8ZXzHpgQW7i5MMbDf4JvzUauWmsKj7pQz+++49I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A9CXU70o; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713317124; x=1744853124;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SifNgk6MOylzLGjpF5LbD3QpijD39SXzUerpdQvNNWg=;
  b=A9CXU70ooITcC/8KDa67Ro9marnEAUvMACuddm8akoCisXsdbeM4Rp6T
   yxh76chY/QXZpLVopZy8gzVcHJNEYn8TJlKfoS+Baz3N9+LOZvlt1F4gH
   NEl7U0UuMSFl9xjoKuMOGha+zenxRXfFvqQWFghqUwkB18IIxUKo+bEbB
   bVRZy4NH7lkQb4rFdATtG3//k0JudajK63FhK4qoAif+9ysBPsHHeZUNp
   FAa4wExLiasQAK6lsaitP3CMNKw7TeVceauOwCGwfvbaD96tz5f6lrtEU
   wgk0uQno9XXk3Dy/r9pKXXMPDWUHWItFF/I39PAtIMACvPECK/4ificTO
   A==;
X-CSE-ConnectionGUID: fA0mu7HMRc+VkSkjAq6e6Q==
X-CSE-MsgGUID: ZIkZV0uNTi+PJ+rmkGhKQg==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8911582"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="8911582"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 18:25:23 -0700
X-CSE-ConnectionGUID: DQUm0QaISiegqb6Fxi0eqg==
X-CSE-MsgGUID: OFj1QP6gTmODO7bZAwKFlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22855228"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 16 Apr 2024 18:25:21 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rwu33-0005vs-30;
	Wed, 17 Apr 2024 01:25:17 +0000
Date: Wed, 17 Apr 2024 09:24:29 +0800
From: kernel test robot <lkp@intel.com>
To: Geetha sowjanya <gakula@marvell.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com
Subject: Re: [net-next PATCH 3/9] octeontx2-pf: Create representor netdev
Message-ID: <202404170922.RBiIclFT-lkp@intel.com>
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
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240417/202404170922.RBiIclFT-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240417/202404170922.RBiIclFT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404170922.RBiIclFT-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/marvell/octeontx2/nic/rep.c:167:7: warning: variable 'err' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     167 |                 if (register_netdev(ndev)) {
         |                     ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/nic/rep.c:181:9: note: uninitialized use occurs here
     181 |         return err;
         |                ^~~
   drivers/net/ethernet/marvell/octeontx2/nic/rep.c:167:3: note: remove the 'if' if its condition is always false
     167 |                 if (register_netdev(ndev)) {
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
     168 |                         dev_err(priv->dev, "PFVF reprentator registration failed\n");
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     169 |                         free_netdev(ndev);
         |                         ~~~~~~~~~~~~~~~~~~
     170 |                         ndev->netdev_ops = NULL;
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~
     171 |                         goto exit;
         |                         ~~~~~~~~~~
     172 |                 }
         |                 ~
   drivers/net/ethernet/marvell/octeontx2/nic/rep.c:137:17: note: initialize the variable 'err' to silence this warning
     137 |         int rep_id, err;
         |                        ^
         |                         = 0
   1 warning generated.


vim +167 drivers/net/ethernet/marvell/octeontx2/nic/rep.c

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
   163			snprintf(ndev->name, sizeof(ndev->name), "r%dp%dv%d", rep_id,
   164				 rvu_get_pf(pcifunc), (pcifunc & RVU_PFVF_FUNC_MASK));
   165	
   166			eth_hw_addr_random(ndev);
 > 167			if (register_netdev(ndev)) {
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

