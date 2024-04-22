Return-Path: <linux-kernel+bounces-153330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E808ACCB2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FE46280D3C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709D914A4C6;
	Mon, 22 Apr 2024 12:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jfx/ls+y"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D144F213;
	Mon, 22 Apr 2024 12:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713788504; cv=none; b=E1UmFR/A43fQ6fAJCql0kFI8P3kjZ4MIvhkq0joe9IssBP2qqX6LgbYcJsgUpPP8YA0FCGi8W1h58fc6+xDFYNRDvxe/dW6pnvdUt9SSwCiOS8Q0j3qxQ6aL2lvv5gmUTgnyQH4ksGjyKm3MoB9sTax69pDCMtbudGn2NUbOi70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713788504; c=relaxed/simple;
	bh=UTkmHZeikRa1ycDagwCQkNkwCuglgm4WeonLx4GtOEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMakXbhXmR6/C6i0m33BEFadx4cABu2H6ZccsdvrFupNHCtCbtJKLmcOKNaV9NYKBWol0NV9Vg2VLD8PQOtBW6/J8TExhxWBDntbJ8wsuFEOrlFdGMe9koAziKUXrjbccQME8kbrz+TNrgw7GBK0enSKNetFVNMgIs0Pvo2/NHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jfx/ls+y; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713788503; x=1745324503;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UTkmHZeikRa1ycDagwCQkNkwCuglgm4WeonLx4GtOEw=;
  b=Jfx/ls+yJ2UQi0omg79le6KC2X9BDAKSak/DvZiyPFV0fON07NwNKj/g
   qgmV0SKNNr6LTO6mOI4teVkEE04hYedBQRJ7Nahgc1bd3zbm329NFDaYB
   Pc7GoZYpCQ4ZMa9biHSZFyMt5K4mbS3IAnKRDAjJLHszq2cDA9sk/RFZk
   VDrkuXIpiSI1luCgYd3MioDhPKeHtaWUeq/CTbvLSI6PeLcrF9FS+2LvF
   vVl39aieq4bywS2NjsXvwK4g7Vo09LvQNFiveU6rR6IKLQ4pocSVRxsq9
   CisZdPlTySxnUdJvX9iiMLX9i4YQtm1P0ddAxOOoVVFvliwCh92HdxBte
   w==;
X-CSE-ConnectionGUID: YkHlFWveSNK4dmVhYMPSlg==
X-CSE-MsgGUID: E1F9jT/GRECMjEjZfFimPw==
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="13110017"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="13110017"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 05:21:42 -0700
X-CSE-ConnectionGUID: M3MyFjZSToWhCUpBOEqfEw==
X-CSE-MsgGUID: 54UoqB0yTdG9DYu9uyRjRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="61448676"
Received: from lkp-server01.sh.intel.com (HELO 69a5ba6c3aa8) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 22 Apr 2024 05:21:39 -0700
Received: from kbuild by 69a5ba6c3aa8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rysfw-00002m-1H;
	Mon, 22 Apr 2024 12:21:36 +0000
Date: Mon, 22 Apr 2024 20:20:38 +0800
From: kernel test robot <lkp@intel.com>
To: Maxime MERE <maxime.mere@foss.st.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh@kernel.org>, linux-crypto@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] crypto: stm32/cryp - use dma when possible.
Message-ID: <202404222021.S9hjJBpb-lkp@intel.com>
References: <20240418144256.3736800-2-maxime.mere@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418144256.3736800-2-maxime.mere@foss.st.com>

Hi Maxime,

kernel test robot noticed the following build warnings:

[auto build test WARNING on atorgue-stm32/stm32-next]
[also build test WARNING on herbert-crypto-2.6/master herbert-cryptodev-2.6/master linus/master v6.9-rc5 next-20240422]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Maxime-MERE/crypto-stm32-cryp-use-dma-when-possible/20240418-224748
base:   https://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git stm32-next
patch link:    https://lore.kernel.org/r/20240418144256.3736800-2-maxime.mere%40foss.st.com
patch subject: [PATCH 1/3] crypto: stm32/cryp - use dma when possible.
config: arm-randconfig-r081-20240422 (https://download.01.org/0day-ci/archive/20240422/202404222021.S9hjJBpb-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404222021.S9hjJBpb-lkp@intel.com/

smatch warnings:
drivers/crypto/stm32/stm32-cryp.c:1496 stm32_cryp_truncate_sg() warn: unsigned 'alloc_sg_len' is never less than zero.
drivers/crypto/stm32/stm32-cryp.c:1580 stm32_cryp_cipher_prepare() warn: unsigned 'cryp->in_sg_len' is never less than zero.
drivers/crypto/stm32/stm32-cryp.c:1584 stm32_cryp_cipher_prepare() warn: unsigned 'cryp->out_sg_len' is never less than zero.

vim +/alloc_sg_len +1496 drivers/crypto/stm32/stm32-cryp.c

  1481	
  1482	static int stm32_cryp_truncate_sg(struct scatterlist **new_sg, size_t *new_sg_len,
  1483					  struct scatterlist *sg, off_t skip, size_t size)
  1484	{
  1485		struct scatterlist *cur;
  1486		size_t alloc_sg_len;
  1487	
  1488		*new_sg_len = 0;
  1489	
  1490		if (!sg || !size) {
  1491			*new_sg = NULL;
  1492			return 0;
  1493		}
  1494	
  1495		alloc_sg_len = sg_nents_for_len(sg, skip + size);
> 1496		if (alloc_sg_len < 0)
  1497			return alloc_sg_len;
  1498	
  1499		/* We allocate to much sg entry, but it is easier */
  1500		*new_sg = kmalloc_array(alloc_sg_len, sizeof(struct scatterlist), GFP_KERNEL);
  1501		if (!*new_sg)
  1502			return -ENOMEM;
  1503	
  1504		sg_init_table(*new_sg, alloc_sg_len);
  1505	
  1506		cur = *new_sg;
  1507		while (sg && size) {
  1508			unsigned int len = sg->length;
  1509			unsigned int offset = sg->offset;
  1510	
  1511			if (skip > len) {
  1512				skip -= len;
  1513				sg = sg_next(sg);
  1514				continue;
  1515			}
  1516	
  1517			if (skip) {
  1518				len -= skip;
  1519				offset += skip;
  1520				skip = 0;
  1521			}
  1522	
  1523			if (size < len)
  1524				len = size;
  1525	
  1526			if (len > 0) {
  1527				(*new_sg_len)++;
  1528				size -= len;
  1529				sg_set_page(cur, sg_page(sg), len, offset);
  1530				if (size == 0)
  1531					sg_mark_end(cur);
  1532				cur = sg_next(cur);
  1533			}
  1534	
  1535			sg = sg_next(sg);
  1536		}
  1537	
  1538		return 0;
  1539	}
  1540	
  1541	static int stm32_cryp_cipher_prepare(struct stm32_cryp *cryp, struct scatterlist *in_sg,
  1542					     struct scatterlist *out_sg)
  1543	{
  1544		size_t align_size;
  1545	
  1546		cryp->dma_mode = stm32_cryp_dma_check(cryp, in_sg, out_sg);
  1547	
  1548		scatterwalk_start(&cryp->in_walk, in_sg);
  1549		scatterwalk_start(&cryp->out_walk, out_sg);
  1550	
  1551		if (cryp->dma_mode == NO_DMA) {
  1552			cryp->flags &= ~FLG_IN_OUT_DMA;
  1553	
  1554			if (is_ctr(cryp))
  1555				memset(cryp->last_ctr, 0, sizeof(cryp->last_ctr));
  1556	
  1557		} else if (cryp->dma_mode == DMA_NEED_SG_TRUNC) {
  1558			int ret;
  1559	
  1560			cryp->flags |= FLG_IN_OUT_DMA;
  1561	
  1562			align_size = ALIGN_DOWN(cryp->payload_in, cryp->hw_blocksize);
  1563			ret = stm32_cryp_truncate_sg(&cryp->in_sg, &cryp->in_sg_len, in_sg, 0, align_size);
  1564			if (ret)
  1565				return ret;
  1566	
  1567			ret = stm32_cryp_truncate_sg(&cryp->out_sg, &cryp->out_sg_len, out_sg, 0,
  1568						     align_size);
  1569			if (ret) {
  1570				kfree(cryp->in_sg);
  1571				return ret;
  1572			}
  1573		} else {
  1574			cryp->flags |= FLG_IN_OUT_DMA;
  1575	
  1576			cryp->in_sg = in_sg;
  1577			cryp->out_sg = out_sg;
  1578	
  1579			cryp->in_sg_len = sg_nents_for_len(cryp->in_sg, cryp->payload_in);
> 1580			if (cryp->in_sg_len < 0)
  1581				return cryp->in_sg_len;
  1582	
  1583			cryp->out_sg_len = sg_nents_for_len(out_sg, cryp->payload_out);
> 1584			if (cryp->out_sg_len < 0)
  1585				return cryp->out_sg_len;
  1586		}
  1587	
  1588		return 0;
  1589	}
  1590	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

