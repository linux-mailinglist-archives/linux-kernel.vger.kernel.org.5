Return-Path: <linux-kernel+bounces-6116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4998194CC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B23A1F23F18
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149CD3FB04;
	Tue, 19 Dec 2023 23:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W2PSlAFk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAC840BE0
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 23:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703030073; x=1734566073;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ppAkVblBhKGJyNnFXrHbhrJDTi8QtHJMAJrEo8cnHCg=;
  b=W2PSlAFkOOmitpL2+x1s9aG707J3F5Hcvocj4qgYduU1kA8S0tjNCoii
   yb8A77o9QmDo5ymYbqS5PtLx66ambj4NDMNHhuLYUEi76j0E5s9CTJrvd
   3ye6K6JiZWHJZIuVl55HCMicxY0Th3qEVTj3+dtHh6o/pNsIZ+w8Qmx2a
   A/uTA3P98X8Fj6x+fLXUVEK75MrCZywLUEbDfTy8OGlT9docy8TKQxfLB
   Wxd2AOk3LACFvrUpFg1MvPCszVvUbw+DZqPg9fdMqjzAOhPUdc/frQe2I
   qz+HHGWn7tE4rr56uJI4RsN9h+Gc/yLtSimgyoo48q9FGN150DKeSGg66
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="392907330"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="392907330"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 15:54:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="805061834"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="805061834"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 19 Dec 2023 15:54:30 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rFjuu-000661-0M;
	Tue, 19 Dec 2023 23:54:28 +0000
Date: Wed, 20 Dec 2023 07:54:12 +0800
From: kernel test robot <lkp@intel.com>
To: Chuanhong Guo <gch981213@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: drivers/spi/spi-mtk-snfi.c:1168: warning: Function parameter or
 member 'op' not described in 'mtk_snand_is_page_ops'
Message-ID: <202312200721.rhknT3zL-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Chuanhong,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   55cb5f43689d7a9ea5bf35ef050f12334f197347
commit: 764f1b7481645b2b4488eda26c4da7f331697e6b spi: add driver for MTK SPI NAND Flash Interface
date:   1 year, 8 months ago
config: i386-buildonly-randconfig-005-20231101 (https://download.01.org/0day-ci/archive/20231220/202312200721.rhknT3zL-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231220/202312200721.rhknT3zL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312200721.rhknT3zL-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/spi/spi-mtk-snfi.c:1168: warning: Function parameter or member 'op' not described in 'mtk_snand_is_page_ops'


vim +1168 drivers/spi/spi-mtk-snfi.c

  1154	
  1155	/**
  1156	 * mtk_snand_is_page_ops() - check if the op is a controller supported page op.
  1157	 * @op spi-mem op to check
  1158	 *
  1159	 * Check whether op can be executed with read_from_cache or program_load
  1160	 * mode in the controller.
  1161	 * This controller can execute typical Read From Cache and Program Load
  1162	 * instructions found on SPI-NAND with 2-byte address.
  1163	 * DTR and cmd buswidth & nbytes should be checked before calling this.
  1164	 *
  1165	 * Return: true if the op matches the instruction template
  1166	 */
  1167	static bool mtk_snand_is_page_ops(const struct spi_mem_op *op)
> 1168	{
  1169		if (op->addr.nbytes != 2)
  1170			return false;
  1171	
  1172		if (op->addr.buswidth != 1 && op->addr.buswidth != 2 &&
  1173		    op->addr.buswidth != 4)
  1174			return false;
  1175	
  1176		// match read from page instructions
  1177		if (op->data.dir == SPI_MEM_DATA_IN) {
  1178			// check dummy cycle first
  1179			if (op->dummy.nbytes * BITS_PER_BYTE / op->dummy.buswidth >
  1180			    DATA_READ_MAX_DUMMY)
  1181				return false;
  1182			// quad io / quad out
  1183			if ((op->addr.buswidth == 4 || op->addr.buswidth == 1) &&
  1184			    op->data.buswidth == 4)
  1185				return true;
  1186	
  1187			// dual io / dual out
  1188			if ((op->addr.buswidth == 2 || op->addr.buswidth == 1) &&
  1189			    op->data.buswidth == 2)
  1190				return true;
  1191	
  1192			// standard spi
  1193			if (op->addr.buswidth == 1 && op->data.buswidth == 1)
  1194				return true;
  1195		} else if (op->data.dir == SPI_MEM_DATA_OUT) {
  1196			// check dummy cycle first
  1197			if (op->dummy.nbytes)
  1198				return false;
  1199			// program load quad out
  1200			if (op->addr.buswidth == 1 && op->data.buswidth == 4)
  1201				return true;
  1202			// standard spi
  1203			if (op->addr.buswidth == 1 && op->data.buswidth == 1)
  1204				return true;
  1205		}
  1206		return false;
  1207	}
  1208	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

