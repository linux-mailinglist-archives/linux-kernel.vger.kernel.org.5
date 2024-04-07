Return-Path: <linux-kernel+bounces-134638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C589789B3FC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 22:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B3691F214CF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 20:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E76446D3;
	Sun,  7 Apr 2024 20:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RptNAz0m"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318643BBF2
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 20:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712521351; cv=none; b=qe/lD5AhTbx6HepSH1Nge8ixW9XAahFY0gXBBbHwZrlSiWpg40V98JqJ42qze6NHzuvC/E5WM3fAlyEi8tvTSuMrE3j1PTUffXjlGBjf4HC0WzFzRnXxCRfFfUTICd0c0S7ZlBMsvertO5KBVGoXnj3T+nVEjax1/mn9BZAR2FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712521351; c=relaxed/simple;
	bh=QlgrfuurpFnr7seUgnGwsNNjSIf3pHfY6thV9QvJpDE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=W6RPRcCGkXQjPkySwwZaw27sI6J+Wog/mbUyaw2DYgCVOID+J6x7Iq7DGhuiMP+fOxaX5Pl7R0hCV9Eiq7kYq40LAmEt7gkqvZEZ3yNQESDBT856qJycKG+cAt1i8O3O0pAh9vatlVbFGHoQ9kzcSIR0R13ZpmjH6EQ7DHeoMhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RptNAz0m; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712521349; x=1744057349;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QlgrfuurpFnr7seUgnGwsNNjSIf3pHfY6thV9QvJpDE=;
  b=RptNAz0mrUPxlo1ucUnAmPu2HtdFzpSBDXmyGAOvBVmafO7dEOZGfzg0
   C3EpQ3JEvKxHWi0Xlf/FnAG7w67SB2Q3JfXnazLvxAdoT/8Qg0tLi6Lr5
   6nrxoZr4sK4TSwZSf68n26xhJCp4OrEaGsOTvA+nZjyGcb9qyAY/YEA6m
   EVFW6UdZIchO+J+fJcLV+g0DTt9KdMFqooVzKL6uffEM9Xeu2FfhnSKzD
   zrIKO9sqF7KCtD/JCuh4CkAJZxGvQUR0rYNRdAi69tXM5qKUNQh5oCnB8
   LUI3ZnDPbI2N0sxNPy1r4naHE31+pxUxViApBgbw+KcoFzZMdXgnM9i4P
   Q==;
X-CSE-ConnectionGUID: 0eXw4Y87RZSwrqO5lcJEjA==
X-CSE-MsgGUID: 6Q8UMp/TQwOE36iLRW2Plg==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="19160681"
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="19160681"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 13:22:28 -0700
X-CSE-ConnectionGUID: 8y6kNaACTYiwvVhW2oImrQ==
X-CSE-MsgGUID: UflRiwuTQhSHok7K62AmRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="50891416"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 07 Apr 2024 13:22:26 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rtZ20-0004ae-0I;
	Sun, 07 Apr 2024 20:22:24 +0000
Date: Mon, 8 Apr 2024 04:21:40 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Joerg Roedel <jroedel@suse.de>, Yi Liu <yi.l.liu@intel.com>,
	Kevin Tian <kevin.tian@intel.com>
Subject: WARNING: modpost: vmlinux: section mismatch in reference:
 iso_connect_bis+0xd8 (section: .text) -> lpj_setup (section: .init.text)
Message-ID: <202404080414.ouxhGhJg-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9fe30842a90be9b57a3bd1a37c9aed92918cc6d0
commit: c404f55c26fc23c70a9f2262f3f36a69fc46289b iommu: Validate the PASID in iommu_attach_device_pasid()
date:   11 days ago
config: riscv-randconfig-r003-20230418 (https://download.01.org/0day-ci/archive/20240408/202404080414.ouxhGhJg-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240408/202404080414.ouxhGhJg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404080414.ouxhGhJg-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_getsockopt+0x422 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_getsockopt+0x438 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_getsockopt+0x456 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_getsockopt+0x488 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_getsockopt+0x4a4 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_getsockopt+0x4ac (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: check_ucast_qos+0x3a (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: check_ucast_qos+0x5c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: check_ucast_qos+0x7a (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: check_ucast_qos+0x98 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: check_ucast_qos+0xb4 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: check_ucast_qos+0xc4 (section: .text) -> initrd_load (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: check_ucast_qos+0xda (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: check_ucast_qos+0xe8 (section: .text) -> initrd_load (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: check_ucast_qos+0xf2 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: check_bcast_qos+0x50 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: check_bcast_qos+0x6c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: check_bcast_qos+0x7c (section: .text) -> initrd_load (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: check_bcast_qos+0x92 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: check_bcast_qos+0xa2 (section: .text) -> initrd_load (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: check_bcast_qos+0xb8 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: check_bcast_qos+0xd4 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: check_bcast_qos+0xf2 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: check_bcast_qos+0x114 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: check_bcast_qos+0x13e (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: check_bcast_qos+0x15c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: check_bcast_qos+0x17a (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: check_bcast_qos+0x1a8 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_create+0x46 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_create+0x52 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_create+0x56 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_create+0x64 (section: .text) -> init_linuxrc (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_create+0x6c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_create+0x90 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_create+0x94 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_conn_add.part.0+0x5c (section: .text) -> init_linuxrc (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_conn_add.part.0+0x60 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_conn_add.part.0+0x66 (section: .text) -> init_linuxrc (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_conn_add.part.0+0x6a (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_conn_add.part.0+0x7c (section: .text) -> init_linuxrc (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_conn_add.part.0+0x8c (section: .text) -> init_linuxrc (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_conn_add.part.0+0xac (section: .text) -> kernel_do_mounts_initrd_sysctls_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_conn_add.part.0+0xb0 (section: .text) -> kernel_do_mounts_initrd_sysctls_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_conn_add.part.0+0xb4 (section: .text) -> kernel_do_mounts_initrd_sysctls_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_conn_add.part.0+0xb8 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_conn_add.part.0+0xc2 (section: .text) -> kernel_do_mounts_initrd_sysctls_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_conn_add.part.0+0xc6 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_setsockopt+0x3e (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_setsockopt+0x42 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_setsockopt+0x76 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_setsockopt+0x9e (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_setsockopt+0xa2 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_setsockopt+0xa8 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_setsockopt+0xae (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_setsockopt+0xd0 (section: .text) -> init_linuxrc (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_setsockopt+0x102 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_setsockopt+0x11e (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_setsockopt+0x140 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_setsockopt+0x162 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_setsockopt+0x1a2 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_setsockopt+0x1c4 (section: .text) -> init_linuxrc (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_setsockopt+0x210 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_setsockopt+0x244 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_setsockopt+0x266 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_setsockopt+0x2aa (section: .text) -> dir_add (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_setsockopt+0x2be (section: .text) -> init_linuxrc (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_setsockopt+0x2f2 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_setsockopt+0x352 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_setsockopt+0x396 (section: .text) -> init_linuxrc (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_setsockopt+0x3c6 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_setsockopt+0x42c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_accept+0x78 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_accept+0xce (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_accept+0xfc (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_accept+0x144 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_accept+0x15c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_accept+0x172 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_accept+0x1a4 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_accept+0x1c2 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_accept+0x204 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_accept+0x252 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_accept+0x280 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_accept+0x286 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_accept+0x2aa (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_accept+0x2c8 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_sendmsg+0x66 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_sendmsg+0x84 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_sendmsg+0xb2 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_sendmsg+0xf4 (section: .text) -> no_initrd (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_sendmsg+0x154 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_sendmsg+0x15a (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_sendmsg+0x1aa (section: .text) -> no_initrd (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_sendmsg+0x24e (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_sendmsg+0x2aa (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_sendmsg+0x33c (section: .text) -> xbc_node_get_subkey (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_sendmsg+0x3b4 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_sendmsg+0x3e4 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_connect_bis+0x78 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_connect_bis+0x94 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_connect_bis+0xa6 (section: .text) -> no_initrd (section: .init.text)
>> WARNING: modpost: vmlinux: section mismatch in reference: iso_connect_bis+0xd8 (section: .text) -> lpj_setup (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_connect_bis+0x206 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_connect_bis+0x2d4 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_connect_bis+0x2d8 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_connect_bis+0x30c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_connect_bis+0x36a (section: .text) -> init_linuxrc (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_connect_bis+0x39e (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_connect_bis+0x3a8 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_connect_bis+0x3ac (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_connect_bis+0x3d0 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_connect_bis+0x3de (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_connect_bis+0x3e2 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_connect_bis+0x440 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_connect_bis+0x4d6 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_chan_del+0xf6 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_chan_del+0xfa (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_conn_del+0x166 (section: .text) -> early_initrd (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_conn_del+0x296 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_conn_del+0x29c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_conn_del+0x2a8 (section: .text) -> early_initrd (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_disconn_cfm+0x6a (section: .text) -> early_initrdmem (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_disconn+0x234 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_disconn+0x238 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_disconn+0x388 (section: .text) -> early_initrd (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __iso_sock_close+0x24 (section: .text) -> do_copy (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __iso_sock_close+0x28 (section: .text) -> do_copy (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __iso_sock_close+0xa6 (section: .text) -> create_dev.constprop.0.isra.0 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __iso_sock_close+0xba (section: .text) -> early_initrdmem (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __iso_sock_close+0xc4 (section: .text) -> early_initrdmem (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __iso_sock_close+0x148 (section: .text) -> create_dev.constprop.0.isra.0 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __iso_sock_close+0x188 (section: .text) -> early_initrd (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_release+0x62 (section: .text) -> create_dev.constprop.0.isra.0 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_release+0x76 (section: .text) -> early_initrdmem (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_release+0xd4 (section: .text) -> early_initrdmem (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_shutdown+0xde (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_shutdown+0xe2 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_shutdown+0x132 (section: .text) -> create_dev.constprop.0.isra.0 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_listen_bis+0x1e0 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_listen_bis+0x2d6 (section: .text) -> no_initrd (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_listen_bis+0x2f8 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_listen_bis+0x2fc (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_listen_bis+0x34c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_listen_bis+0x350 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_listen_bis+0x390 (section: .text) -> init_linuxrc (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_listen_bis+0x420 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_listen_bis+0x424 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_listen_bis+0x458 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_listen_bis+0x45c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_listen+0x1ba (section: .text) -> handle_initrd (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_connect_cis+0x1fc (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_connect_cis+0x306 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_connect_cis+0x30a (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_connect_cis+0x36e (section: .text) -> init_linuxrc (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_connect_cis+0x3ac (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_connect_cis+0x3b0 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_connect_cis+0x424 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_connect_cis+0x428 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_recvmsg+0x6e (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_recvmsg+0x72 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_recvmsg+0x19a (section: .text) -> create_dev.constprop.0.isra.0 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_connect+0x10a (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_connect+0x158 (section: .text) -> kernel_do_mounts_initrd_sysctls_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_sock_connect+0x224 (section: .text) -> create_dev.constprop.0.isra.0 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_conn_ready+0x10a (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_conn_ready+0x112 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_conn_ready+0x11a (section: .text) -> early_initrd (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_conn_ready+0x14c (section: .text) -> init_linuxrc (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_conn_ready+0x182 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_conn_ready+0x2bc (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_conn_ready+0x374 (section: .text) -> error (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_conn_ready+0x4fe (section: .text) -> early_initrd (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_conn_ready+0x5d2 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_conn_ready+0x614 (section: .text) -> populate_rootfs (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_conn_ready+0x624 (section: .text) -> dir_add (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_conn_ready+0x638 (section: .text) -> populate_rootfs (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_conn_ready+0x64e (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_conn_ready+0x654 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_conn_ready+0x65c (section: .text) -> early_initrd (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_conn_ready+0x674 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_conn_ready+0x6a8 (section: .text) -> populate_rootfs (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_conn_ready+0x6ee (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_conn_ready+0x6f4 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_conn_ready+0x6fe (section: .text) -> early_initrd (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_conn_ready+0x738 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_conn_ready+0x73e (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_conn_ready+0x748 (section: .text) -> early_initrd (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_connect_cfm+0xba (section: .text) -> early_initrdmem (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_connect_cfm+0x134 (section: .text) -> do_populate_rootfs (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_connect_cfm+0x140 (section: .text) -> lpj_setup (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_connect_cfm+0x14c (section: .text) -> initrd_load (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_connect_cfm+0x190 (section: .text) -> early_initrdmem (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_connect_cfm+0x1ba (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_connect_cfm+0x1ce (section: .text) -> init_linuxrc (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_connect_ind+0x4c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_connect_ind+0x56 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_connect_ind+0x5c (section: .text) -> early_initrd (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_connect_ind+0x66 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_connect_ind+0x82 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_connect_ind+0xba (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_connect_ind+0xf2 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iso_connect_ind+0x10a (section: .text) -> (unknown) (section: .init.text)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

