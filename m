Return-Path: <linux-kernel+bounces-1563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4318181501E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22EB6B20B16
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693513FE4C;
	Fri, 15 Dec 2023 19:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZRGkG7m0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CFB1E504
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 19:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702668201; x=1734204201;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=f1JvlbDQQyZxPSGsSiDpSrXxcx3anOhWm4jBfNRKGq8=;
  b=ZRGkG7m0UDUYyVP6CPR2i2yqmNontRi5SxuyHO67scYc7KxtduBEV6qj
   PaYf9uYanS9hFmRfxBNtlNdr84tAFRUp2GDKsAeQvoyZdLy0rs4o862yp
   0rIT8omOxel8GXDKT49nmm+dm+aqsMxTMak2iDLR47PG3CsI44ytRqDle
   tWrxIgvKm2hQIAAD+628l0NZZR4+/xL40luFqUsSuUalhSh/7w1YPelhv
   aAxnoQEo3U088ogrUe4TQh+fuYZoLSJdJGCtuLm5XpDuvrbjWhZsdfiAD
   RT2qmN+ak3Yn4t+d66HTXHbn/wg0HZuMy/bM7Z2ShXmSxu9fw706CqZj2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="395057795"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="395057795"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 11:23:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="778371222"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="778371222"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 15 Dec 2023 11:23:18 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEDmG-0000f8-2p;
	Fri, 15 Dec 2023 19:23:16 +0000
Date: Sat, 16 Dec 2023 03:22:39 +0800
From: kernel test robot <lkp@intel.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: scripts/kernel-doc: drivers/scsi/mpi3mr/mpi3mr_transport.c:1029:
 warning: Function parameter or struct member 'port_id' not described in
 'mpi3mr_get_hba_port_by_id'
Message-ID: <202312160357.JROyEjx5-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Shin'ichiro,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3f7168591ebf7bbdb91797d02b1afaf00a4289b1
commit: f0a43ba6c66cc0688e2748d986a1459fdd3442ef scsi: mpi3mr: Refer CONFIG_SCSI_MPI3MR in Makefile
date:   1 year ago
config: arc-randconfig-002-20231215 (https://download.01.org/0day-ci/archive/20231216/202312160357.JROyEjx5-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231216/202312160357.JROyEjx5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312160357.JROyEjx5-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> scripts/kernel-doc: drivers/scsi/mpi3mr/mpi3mr_transport.c:1029: warning: Function parameter or struct member 'port_id' not described in 'mpi3mr_get_hba_port_by_id'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

