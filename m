Return-Path: <linux-kernel+bounces-30911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FEC8325D2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 128241F231D8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914A01E497;
	Fri, 19 Jan 2024 08:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="WpC6uKKT"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0161E862
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 08:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705653453; cv=none; b=aO2FT2tSg1yXNFrta0Ib591U9FL5M/Ngmnvpj9mhBQ8SgZzLP7A3dfzCDPsLTsWXnVpUHKEbcONrRHqzX8SUuFAjahSSWbmriTjg4ZZUiYIfA5VMNKHb3YpSomUWD2USSCsAJrSCljl011wCHwsjRFCafPPLAou7v7RW++fe+mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705653453; c=relaxed/simple;
	bh=lK4MYTGk+LLGnKIrNyR4BUyPuK/kpvJ3iBXwKgmLHE0=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=aPCvWose2Yf8shT7OWHsoL65uHFvoKgr+fV2dUlThiY3wFlrk5gviBEjlQOXuMgCJUShntgNt45+GKPLKNprM/vDMKTY2WsYKStaEieQrVdMKwyS3SIHvKFVB6OVELTE9WoaiTby3AJLO+vNlFr9+xDxYzfCnNsUGsiSd18RahQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=WpC6uKKT; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qHwLxG3XXvDj6i3V51GtruF33I9dNC9PJdW5RW/t6Z8=;
  b=WpC6uKKTyXoGTFhRvfQLpMAH9zznrgiAsDK6vINhIvltGvsILLaqRIxk
   XrE3DIlVOETqzIgB7j3tfXZSZVH5xNvGp+IBe3Emcd/JxBoEVgPczf+Af
   WjzNoOltBIZ3VdtkYy6fbwo/Z9T34HTvObPutm3EVuQ9toEEn1+TxevET
   k=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.05,204,1701126000"; 
   d="scan'208";a="77245273"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 09:37:27 +0100
Date: Fri, 19 Jan 2024 09:37:26 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Tom Zanussi <tom.zanussi@linux.intel.com>, 
    Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org
cc: oe-kbuild-all@lists.linux.dev
Subject: drivers/crypto/intel/keembay/ocs-aes.c:1476:49-50: WARNING opportunity
 for min() (fwd)
Message-ID: <15aa10f2-189-7cbb-1c58-799ce8f2d3e@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Please see the last line of the code extract.

---------- Forwarded message ----------
Date: Fri, 19 Jan 2024 10:52:40 +0800
From: kernel test robot <lkp@intel.com>
To: oe-kbuild@lists.linux.dev
Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
Subject: drivers/crypto/intel/keembay/ocs-aes.c:1476:49-50: WARNING opportunity
    for min()

BCC: lkp@intel.com
CC: oe-kbuild-all@lists.linux.dev
CC: linux-kernel@vger.kernel.org
TO: Tom Zanussi <tom.zanussi@linux.intel.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0f289bdd4102fc870c8b97652c57d41952040d70
commit: fbf31dd599875cb132d764cf4d05d7985e332c05 crypto: keembay - Move driver to drivers/crypto/intel/keembay
date:   10 months ago
:::::: branch date: 85 minutes ago
:::::: commit date: 10 months ago
config: hexagon-randconfig-r061-20240117 (https://download.01.org/0day-ci/archive/20240119/202401191031.nqVcuyDA-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project 9bde5becb44ea071f5e1fa1f5d4071dc8788b18c)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Julia Lawall <julia.lawall@inria.fr>
| Closes: https://lore.kernel.org/r/202401191031.nqVcuyDA-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/crypto/intel/keembay/ocs-aes.c:1476:49-50: WARNING opportunity for min()

vim +1476 drivers/crypto/intel/keembay/ocs-aes.c

88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1400
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1401  /**
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1402   * ocs_create_linked_list_from_sg() - Create OCS DMA linked list from SG list.
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1403   * @aes_dev:	  The OCS AES device the list will be created for.
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1404   * @sg:		  The SG list OCS DMA linked list will be created from. When
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1405   *		  passed to this function, @sg must have been already mapped
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1406   *		  with dma_map_sg().
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1407   * @sg_dma_count: The number of DMA-mapped entries in @sg. This must be the
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1408   *		  value returned by dma_map_sg() when @sg was mapped.
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1409   * @dll_desc:	  The OCS DMA dma_list to use to store information about the
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1410   *		  created linked list.
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1411   * @data_size:	  The size of the data (from the SG list) to be mapped into the
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1412   *		  OCS DMA linked list.
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1413   * @data_offset:  The offset (within the SG list) of the data to be mapped.
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1414   *
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1415   * Return:	0 on success, negative error code otherwise.
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1416   */
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1417  int ocs_create_linked_list_from_sg(const struct ocs_aes_dev *aes_dev,
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1418  				   struct scatterlist *sg,
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1419  				   int sg_dma_count,
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1420  				   struct ocs_dll_desc *dll_desc,
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1421  				   size_t data_size, size_t data_offset)
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1422  {
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1423  	struct ocs_dma_linked_list *ll = NULL;
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1424  	struct scatterlist *sg_tmp;
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1425  	unsigned int tmp;
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1426  	int dma_nents;
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1427  	int i;
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1428
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1429  	if (!dll_desc || !sg || !aes_dev)
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1430  		return -EINVAL;
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1431
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1432  	/* Default values for when no ddl_desc is created. */
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1433  	dll_desc->vaddr = NULL;
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1434  	dll_desc->dma_addr = DMA_MAPPING_ERROR;
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1435  	dll_desc->size = 0;
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1436
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1437  	if (data_size == 0)
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1438  		return 0;
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1439
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1440  	/* Loop over sg_list until we reach entry at specified offset. */
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1441  	while (data_offset >= sg_dma_len(sg)) {
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1442  		data_offset -= sg_dma_len(sg);
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1443  		sg_dma_count--;
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1444  		sg = sg_next(sg);
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1445  		/* If we reach the end of the list, offset was invalid. */
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1446  		if (!sg || sg_dma_count == 0)
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1447  			return -EINVAL;
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1448  	}
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1449
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1450  	/* Compute number of DMA-mapped SG entries to add into OCS DMA list. */
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1451  	dma_nents = 0;
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1452  	tmp = 0;
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1453  	sg_tmp = sg;
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1454  	while (tmp < data_offset + data_size) {
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1455  		/* If we reach the end of the list, data_size was invalid. */
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1456  		if (!sg_tmp)
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1457  			return -EINVAL;
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1458  		tmp += sg_dma_len(sg_tmp);
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1459  		dma_nents++;
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1460  		sg_tmp = sg_next(sg_tmp);
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1461  	}
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1462  	if (dma_nents > sg_dma_count)
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1463  		return -EINVAL;
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1464
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1465  	/* Allocate the DMA list, one entry for each SG entry. */
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1466  	dll_desc->size = sizeof(struct ocs_dma_linked_list) * dma_nents;
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1467  	dll_desc->vaddr = dma_alloc_coherent(aes_dev->dev, dll_desc->size,
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1468  					     &dll_desc->dma_addr, GFP_KERNEL);
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1469  	if (!dll_desc->vaddr)
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1470  		return -ENOMEM;
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1471
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1472  	/* Populate DMA linked list entries. */
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1473  	ll = dll_desc->vaddr;
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1474  	for (i = 0; i < dma_nents; i++, sg = sg_next(sg)) {
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26  1475  		ll[i].src_addr = sg_dma_address(sg) + data_offset;
88574332451380 drivers/crypto/keembay/ocs-aes.c Mike Healy 2020-11-26 @1476  		ll[i].src_len = (sg_dma_len(sg) - data_offset) < data_size ?

:::::: The code at line 1476 was first introduced by commit
:::::: 88574332451380f4b51f6ca88ab9810e714bfb9b crypto: keembay - Add support for Keem Bay OCS AES/SM4

:::::: TO: Mike Healy <mikex.healy@intel.com>
:::::: CC: Herbert Xu <herbert@gondor.apana.org.au>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

