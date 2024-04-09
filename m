Return-Path: <linux-kernel+bounces-137705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9B989E636
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE4EA1C223A0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A04158DD0;
	Tue,  9 Apr 2024 23:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TN5/Mc3P"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0900C158DC4;
	Tue,  9 Apr 2024 23:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712706102; cv=none; b=qgf04Re2vEEb/HRTOKGW8FKxBbd5AjEULQXK2rW8Fw1ajm+FEarcnl45LXY0NdIUCX3ulYnrbBqpfGJJseS0KKGBZk1UCYHHng1J9j6/S+ZS8rrC3E/ZC8UIQr9KfTEzM18lInwsd8wZf4EUY4FZPNzYRIQTncOPJCMCwKKh/Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712706102; c=relaxed/simple;
	bh=p+mYvSZ5jqONe0GguEhDFJy9lDuHfUm34Zjqnta0fOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C9SbSLqzz8J9q+0DebmpvUM0w3zzEU5/ZEV+B2jWITO8jwDDDV7cuiERV0GhTuYh1lViALGN/HK1o5cr1NjkmhuaBAoaf8XcA6RG7Wv2dBokaGGHR5xbQ2bcHBUn6AFDHvwawCSBUkcRlOxvksEX6Yjc7+4CJULIv26ebX5+5S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TN5/Mc3P; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712706100; x=1744242100;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=p+mYvSZ5jqONe0GguEhDFJy9lDuHfUm34Zjqnta0fOI=;
  b=TN5/Mc3PYc1xEf9kCVpPh/Zkv3HV/d58iXv2SchH1uzn0JKcxHOQXA40
   PiaevUHyQZvmZCtF/KHC5Tcy/uEsLeqWtpGzsvC9inN5MJ9r3KrFRNoZu
   fB4btTX+6gW9QylthK+md/Cv4S69heVPiv64ANNr1Nw3QxH0eejxEeDMf
   oiaQefOpCyaxoqXDYqT2W0OCP4C0aaX357TPIYT+QSTmqV4P5I4t7k+Wy
   KWmFi0JNt1m1WZPMlU6AV726jsq3PJov9SFjvpcIgUDmuT39j/8aSwv2E
   366hjyyDOw/zwnhRD6vn4iDNhvyYjafg4TNbJeJvkG6HXNdlwvkZXV/aE
   Q==;
X-CSE-ConnectionGUID: +EBV4Z/bSkudJ3yfzXW2RQ==
X-CSE-MsgGUID: avjHO8xKTeq2ccdALrXnuA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="33455057"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="33455057"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 16:41:39 -0700
X-CSE-ConnectionGUID: Vjcf5HX0ScC4EHPnMC4v+g==
X-CSE-MsgGUID: Jf/eG5BzQ82g+XUisCpLoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20261560"
Received: from sj-4150-psse-sw-opae-dev3.sj.intel.com ([10.233.115.74])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 16:41:39 -0700
From: Peter Colberg <peter.colberg@intel.com>
To: Wu Hao <hao.wu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>,
	Peter Colberg <peter.colberg@intel.com>
Subject: [RFC PATCH v2 0/9] fpga: dfl: fix kernel warning on port release/assign for SRIOV
Date: Tue,  9 Apr 2024 19:39:33 -0400
Message-ID: <20240409233942.828440-1-peter.colberg@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DFL ports are registered as platform devices in PF mode. The port device
should be removed from the host when the user wants to configure the
port as a VF and pass through to a virtual machine. The FME device
ioctls DFL_FPGA_FME_PORT_RELEASE/ASSIGN are designed for this purpose.

In the previous implementation, the port platform device is not completely
destroyed on port release: it is removed from the system by
platform_device_del(), but the platform device instance is retained.
When the port assign ioctl is called, the platform device is added back by
platform_device_add(), which conflicts with this comment of device_add():
"Do not call this routine more than once for any device structure", and
will cause a kernel warning at runtime.

This patch tries to completely unregister the port platform device on
release and registers a new one on assign. But the main work is to remove
the dependency on struct dfl_feature_platform_data for many internal DFL
APIs. This structure holds many DFL enumeration infos for feature devices.
Many DFL APIs are expected to work with these info even when the port
platform device is unregistered. But with the change the platform_data will
be freed in this case. So this patch introduces a new structure
dfl_feature_dev_data for these APIs, which acts similarly to the previous
dfl_feature_platform_data. The dfl_feature_platform_data then only needs a
pointer to dfl_feature_dev_data to make the feature device driver work.

The single monolithic v1 patch is split into multiple, smaller patches
at the request of the maintainer. The first patch adds temporary macros
that alias dfl_feature_dev_data ("fdata") to dfl_feature_platform_data
("pdata") and associated functions from the "fdata" to the corresponding
"pdata" variants. Subsequent patches separate out most of the symbol
name changes required by this patch series, one patch per file. The last
patch of the series removes the macros and applies the actual change.

Link: https://lore.kernel.org/all/DM6PR11MB3819F9CCD0A6126B55BCB47685FB9@DM6PR11MB3819.namprd11.prod.outlook.com/T/#t

This series applies after the following non-RFC patches:
- fpga: dfl: remove unused function is_dfl_feature_present
- [v2] fpga: dfl: remove unused member pdata from struct dfl_{afu,fme}

Changes since v1:
- Split monolithic patch into series at request of maintainer.
- Substitute binfo->type for removed function feature_dev_id_type() in
  parse_feature_irqs().
- Return ERR_PTR(-ENOMEM) on !feature->params in
  binfo_create_feature_dev_data().
- Reorder cdev as first member of struct dfl_feature_platform_data
  such that container_of() to obtain pdata evaluates to a no-op.
- Change afu_ioctl_*() to receive dfl_feature_dev_data instead of
  dfl_feature_platform_data.
- Change fme_hdr_ioctl_*() to receive dfl_feature_dev_data instead of
  dfl_feature_platform_data.
- Replace local variable pdata with fdata in afu_mmap().
- Remove unused local variable pdata in afu_dev_{init,destroy}().
- Remove unused local variable pdata in fme_dev_{init,destroy}().
- Reorder local variables in afu_dma_unpin_pages() to reverse Christmas
  tree order.
- Align kernel-doc function name for __dfl_fpga_cdev_find_port_data().
- Substitute @fdata for @pdata in kernel-doc comments for
  dfl_fme_create_mgr() and dfl_fme_destroy_mgr().

Peter Colberg (8):
  fpga: dfl: alias dfl_feature_dev_data to dfl_feature_platform_data
  fpga: dfl: migrate AFU DMA region management driver to
    dfl_feature_dev_data
  fpga: dfl: migrate AFU MMIO region management driver to
    dfl_feature_dev_data
  fpga: dfl: migrate FPGA Management Engine driver to
    dfl_feature_dev_data
  fpga: dfl: migrate FME partial reconfiguration driver to
    dfl_feature_dev_data
  fpga: dfl: migrate Accelerated Function Unit driver to
    dfl_feature_dev_data
  fpga: dfl: migrate DFL support header to dfl_feature_dev_data
  fpga: dfl: migrate dfl_get_feature_by_id() to dfl_feature_dev_data

Xu Yilun (1):
  fpga: dfl: fix kernel warning on port release/assign for SRIOV

 drivers/fpga/dfl-afu-dma-region.c | 119 ++++----
 drivers/fpga/dfl-afu-error.c      |  59 ++--
 drivers/fpga/dfl-afu-main.c       | 281 +++++++++----------
 drivers/fpga/dfl-afu-region.c     |  51 ++--
 drivers/fpga/dfl-afu.h            |  26 +-
 drivers/fpga/dfl-fme-br.c         |  24 +-
 drivers/fpga/dfl-fme-error.c      |  98 +++----
 drivers/fpga/dfl-fme-main.c       |  86 +++---
 drivers/fpga/dfl-fme-pr.c         |  88 +++---
 drivers/fpga/dfl.c                | 433 +++++++++++++++---------------
 drivers/fpga/dfl.h                | 139 ++++++----
 11 files changed, 722 insertions(+), 682 deletions(-)

-- 
2.44.0


