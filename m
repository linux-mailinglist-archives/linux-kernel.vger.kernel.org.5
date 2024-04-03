Return-Path: <linux-kernel+bounces-130702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C0B897BCD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 892EAB21FEC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB19156969;
	Wed,  3 Apr 2024 22:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NtClwrMG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29649156253;
	Wed,  3 Apr 2024 22:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712185041; cv=none; b=Yx7XjCJZmC4VNrDMJdCpGErSan41x7ps0SMg7IdbxKMQ+D+J1yjww0cfeD85gV5BhxZoPf6eg7qIO67w+kFZ7N0FBE48AiQsA9kXnSwC2Fs63pPBurDigpCyeO9N8hoWfK/xOJII8ft7iRtpj95ZMBC7o4mtbCpMs2a38lkvJDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712185041; c=relaxed/simple;
	bh=O/P2O6YziHmPPFlfI6G/WG3f8fkCLygIYypjUyaWwPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5xtp6vqn4cqi6EC5ArA55dulFai/InxFUBUKhZPMJvRQh/F/RCavbhEAnGyqwNJu6cciLqa4eASsRuHSpzEQUvgoBA/5ed+E53+8MIrHubZ9gGkxic2oVnPY/0JbLDtedCHDg40kwwx/AIrY3Cp6edzmZ82V5+C/m0Xki78sc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NtClwrMG; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712185040; x=1743721040;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O/P2O6YziHmPPFlfI6G/WG3f8fkCLygIYypjUyaWwPA=;
  b=NtClwrMGHwFaAD6YftAaXdxZ4vNZnvsjfpFJPkhU0cx+FGpu8pHjh5OE
   BCfJiV0iKAGyvJEBg7fhHnCR9ULhZbejHjh6c4Rf/wrJMwHQ4HpE2TvR3
   DbjZFi5LYZ+hUTvXS0vqYp3ZIGcEDNgqPSbSbAQ5/TCegogvUXFTCQhtf
   gF7dv7SqKcivUFLVWbVUZXmEyTMEieTqp2DoKp1Dmpn71czx+wplmYTmB
   pU+K1r+5E7JuMItDgyOtzN0i/9qHh045YF50MDrvlbelzHvYkqNmZd3Z0
   SfOW/qszyu91LDgsI+87LXa8ES7W2vLvtaJuNVEKMhMifCkWaVr5UdLr9
   Q==;
X-CSE-ConnectionGUID: Q6R6LgkFReyZYGCVlvrXdQ==
X-CSE-MsgGUID: YlgqDtgFT+2NIfKnTBjdSw==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="24905434"
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="24905434"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 15:57:20 -0700
X-CSE-ConnectionGUID: HyCgqXkGQTGeoP+8seRqnA==
X-CSE-MsgGUID: JYfbs+3jQ2iIWqB7Q2vKIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="49537008"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 03 Apr 2024 15:57:16 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rs9Xd-0000Kq-23;
	Wed, 03 Apr 2024 22:57:13 +0000
Date: Thu, 4 Apr 2024 06:57:12 +0800
From: kernel test robot <lkp@intel.com>
To: Chenghai Huang <huangchenghai2@huawei.com>, herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, fanghao11@huawei.com,
	liulongfang@huawei.com, shenyang39@huawei.com,
	songzhiqi1@huawei.com, qianweili@huawei.com,
	liushangbin@hisilicon.com, linwenkai6@hisilicon.com,
	taoqi10@huawei.com, wangzhou1@hisilicon.com,
	huangchenghai2@huawei.com
Subject: Re: [PATCH 8/9] crypto: hisilicon/debugfs - Resolve the problem of
 applying for redundant space in sq dump
Message-ID: <202404040616.cF0Pvb9M-lkp@intel.com>
References: <20240403100102.2735306-9-huangchenghai2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403100102.2735306-9-huangchenghai2@huawei.com>

Hi Chenghai,

kernel test robot noticed the following build warnings:

[auto build test WARNING on herbert-cryptodev-2.6/master]
[also build test WARNING on herbert-crypto-2.6/master linus/master v6.9-rc2 next-20240403]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chenghai-Huang/crypto-hisilicon-sec-Add-the-condition-for-configuring-the-sriov-function/20240403-180924
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
patch link:    https://lore.kernel.org/r/20240403100102.2735306-9-huangchenghai2%40huawei.com
patch subject: [PATCH 8/9] crypto: hisilicon/debugfs - Resolve the problem of applying for redundant space in sq dump
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20240404/202404040616.cF0Pvb9M-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240404/202404040616.cF0Pvb9M-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404040616.cF0Pvb9M-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/crypto/hisilicon/debugfs.c: In function 'qm_sq_dump':
>> drivers/crypto/hisilicon/debugfs.c:314:21: warning: unused variable 'sqe_curr' [-Wunused-variable]
     314 |         void *sqe, *sqe_curr;
         |                     ^~~~~~~~


vim +/sqe_curr +314 drivers/crypto/hisilicon/debugfs.c

94476b2b6d60bc Kai Ye         2022-11-12  310  
9c75609842f091 Kai Ye         2022-11-12  311  static int qm_sq_dump(struct hisi_qm *qm, char *s, char *name)
94476b2b6d60bc Kai Ye         2022-11-12  312  {
94476b2b6d60bc Kai Ye         2022-11-12  313  	u16 sq_depth = qm->qp_array->cq_depth;
94476b2b6d60bc Kai Ye         2022-11-12 @314  	void *sqe, *sqe_curr;
94476b2b6d60bc Kai Ye         2022-11-12  315  	struct hisi_qp *qp;
94476b2b6d60bc Kai Ye         2022-11-12  316  	u32 qp_id, sqe_id;
94476b2b6d60bc Kai Ye         2022-11-12  317  	int ret;
94476b2b6d60bc Kai Ye         2022-11-12  318  
94476b2b6d60bc Kai Ye         2022-11-12  319  	ret = q_dump_param_parse(qm, s, &sqe_id, &qp_id, sq_depth);
94476b2b6d60bc Kai Ye         2022-11-12  320  	if (ret)
94476b2b6d60bc Kai Ye         2022-11-12  321  		return ret;
94476b2b6d60bc Kai Ye         2022-11-12  322  
e0bbea3a20f7a0 Chenghai Huang 2024-04-03  323  	sqe = kzalloc(qm->sqe_size, GFP_KERNEL);
94476b2b6d60bc Kai Ye         2022-11-12  324  	if (!sqe)
94476b2b6d60bc Kai Ye         2022-11-12  325  		return -ENOMEM;
94476b2b6d60bc Kai Ye         2022-11-12  326  
94476b2b6d60bc Kai Ye         2022-11-12  327  	qp = &qm->qp_array[qp_id];
e0bbea3a20f7a0 Chenghai Huang 2024-04-03  328  	memcpy(sqe, qp->sqe + sqe_id * qm->sqe_size, qm->sqe_size);
e0bbea3a20f7a0 Chenghai Huang 2024-04-03  329  	memset(sqe + qm->debug.sqe_mask_offset, QM_SQE_ADDR_MASK,
94476b2b6d60bc Kai Ye         2022-11-12  330  	       qm->debug.sqe_mask_len);
94476b2b6d60bc Kai Ye         2022-11-12  331  
e0bbea3a20f7a0 Chenghai Huang 2024-04-03  332  	dump_show(qm, sqe, qm->sqe_size, name);
94476b2b6d60bc Kai Ye         2022-11-12  333  
94476b2b6d60bc Kai Ye         2022-11-12  334  	kfree(sqe);
94476b2b6d60bc Kai Ye         2022-11-12  335  
94476b2b6d60bc Kai Ye         2022-11-12  336  	return 0;
94476b2b6d60bc Kai Ye         2022-11-12  337  }
94476b2b6d60bc Kai Ye         2022-11-12  338  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

