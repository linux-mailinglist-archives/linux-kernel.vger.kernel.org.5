Return-Path: <linux-kernel+bounces-163775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 478DB8B6FBA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBBAF1F24E59
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E12012C46A;
	Tue, 30 Apr 2024 10:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KkrtKEQM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094CD12B176;
	Tue, 30 Apr 2024 10:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714473160; cv=none; b=DxDkvhs9aPSc1A1mosNr1H0iDvxZX1Bc4cUMLnaSWp7BvFv9CzfgDODnlpAawuSpmFq4u1r72K/E6w9/n35sXzpe1HYZrHi4evjjkvmf5fL4MwL8O6Bfz+P5iv+YDge7Kds5rVSGXHET+fIW8+ienrGCjHjzGMIyIffhZ5FIuTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714473160; c=relaxed/simple;
	bh=TOsha8tZbWHodSCSOeDar0KTCBzSwyaa+6PzT/MvwQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxr6SfAu+mfa3l/ROVDa//27C+T1AzxYBoPvh6bp4pxqSwy75g3CWVFn9J/8a4QvSyRMhPC8VxIY2GZLycvyRo1lIZkxtxH0wrL7pr4mJnti4zyyfomsSfJk3vccUgjtS96iaSycZng4kiv0CMBKtOmKAgvHnHNAxtsw8SZ8WKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KkrtKEQM; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714473159; x=1746009159;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TOsha8tZbWHodSCSOeDar0KTCBzSwyaa+6PzT/MvwQE=;
  b=KkrtKEQM7aw9WChLEVUlqEk8OM4xe67hy1kHVFmDuNcvDWMh4PqsCFUd
   gPH/3oVgw5YE27ph0Y6iHQwIcHnJXE15zLU4q5AOxXskaWZpeFGu98FKs
   IrGpZe2b2Ha2AKsUDlQvczn/V49f/ITOrRH2546j6IIu42KVmMnuJD9nM
   bQQvnv0Xt0UVTN94cuEMJefBKw427oHWwP3wqf1bqF+3qQ1rc0erN9VgZ
   IeWkdp2+O5h4Qz25fBxzYIoPaAXU+ZxBTU4Kbzulwo4rE32Db26dhElfi
   b6Lt77PANMv5u+OwYdy+zUJ2m1DnKDvHxGbvinOfN9ruv8Hr8Bd2HKn1R
   w==;
X-CSE-ConnectionGUID: c4QrvQc3S2uMoFTUBwsMeA==
X-CSE-MsgGUID: 1r9pW8hsT1KY8T2PJVWFpA==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="13954780"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="13954780"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 03:32:39 -0700
X-CSE-ConnectionGUID: awcwGRgfS4qieBRaGoUYIQ==
X-CSE-MsgGUID: /22euhvsR3qjzsVbZojErg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="27031455"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 30 Apr 2024 03:32:34 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s1kml-00082F-2h;
	Tue, 30 Apr 2024 10:32:31 +0000
Date: Tue, 30 Apr 2024 18:31:40 +0800
From: kernel test robot <lkp@intel.com>
To: Jingbao Qiu <qiujingbao.dlmu@gmail.com>, broonie@kernel.org,
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, unicorn_wang@outlook.com,
	inochiama@outlook.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: oe-kbuild-all@lists.linux.dev, dlan@gentoo.org,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Subject: Re: [PATCH v1 2/2] spi: add support for sophgo spi-nor controller
Message-ID: <202404301801.fGGuCYoT-lkp@intel.com>
References: <20240427075426.662671-3-qiujingbao.dlmu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427075426.662671-3-qiujingbao.dlmu@gmail.com>

Hi Jingbao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 4cece764965020c22cff7665b18a012006359095]

url:    https://github.com/intel-lab-lkp/linux/commits/Jingbao-Qiu/dt-bindings-mtd-add-sophgo-spi-nor-controller/20240427-155533
base:   4cece764965020c22cff7665b18a012006359095
patch link:    https://lore.kernel.org/r/20240427075426.662671-3-qiujingbao.dlmu%40gmail.com
patch subject: [PATCH v1 2/2] spi: add support for sophgo spi-nor controller
config: powerpc-randconfig-r111-20240430 (https://download.01.org/0day-ci/archive/20240430/202404301801.fGGuCYoT-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20240430/202404301801.fGGuCYoT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404301801.fGGuCYoT-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/spi/spi-sophgo-cv1800.c:259:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr @@     got restricted __be32 [usertype] @@
   drivers/spi/spi-sophgo-cv1800.c:259:22: sparse:     expected unsigned int [usertype] addr
   drivers/spi/spi-sophgo-cv1800.c:259:22: sparse:     got restricted __be32 [usertype]

vim +259 drivers/spi/spi-sophgo-cv1800.c

   244	
   245	static int sophgo_nor_port_trans(struct sophgo_nor *spif,
   246					 const struct spi_mem_op *op)
   247	{
   248		const uint8_t *dout = NULL;
   249		uint8_t *din = NULL;
   250		uint32_t addr;
   251	
   252		sophgo_nor_config_port(spif, 1);
   253	
   254		if (op->cmd.nbytes)
   255			sophgo_nor_xfer(spif, (uint8_t *)&op->cmd.opcode, NULL,
   256					op->cmd.nbytes, op->cmd.buswidth);
   257	
   258		if (op->addr.nbytes) {
 > 259			addr = cpu_to_be32(op->addr.val);
   260			sophgo_nor_xfer(spif, (uint8_t *)&addr, NULL, op->addr.nbytes,
   261					op->addr.buswidth);
   262		}
   263	
   264		if (op->data.dir == SPI_MEM_DATA_IN)
   265			din = op->data.buf.in;
   266		else if (op->data.dir == SPI_MEM_DATA_OUT)
   267			dout = op->data.buf.out;
   268	
   269		sophgo_nor_xfer(spif, dout, din, op->data.nbytes, op->data.buswidth);
   270	
   271		sophgo_nor_config_port(spif, 0);
   272	
   273		return 0;
   274	}
   275	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

