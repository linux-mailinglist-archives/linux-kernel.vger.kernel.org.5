Return-Path: <linux-kernel+bounces-18945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEA4826584
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 19:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C10541F21791
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 18:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2822313FE4;
	Sun,  7 Jan 2024 18:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j7t0JyM2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD3013FEE
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 18:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704650856; x=1736186856;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=i1cVuD05ZlPCc678jkGdTzMK5Yj8UKJ9kh9lajhyInM=;
  b=j7t0JyM2M7071fhNBXoJhfPP0uuCQsx/Y5jBXc02S44uOkUS/01Us6kG
   NGVmprJyVFPMuO9XtZMAfiNS80Aefq9Uv8UGuVbUfgpeOCkByTZNNrMCh
   sRBdGFbaiqCvjMlxvP7cAkF46EcdKGn8+wG0vQKIsX3x36QowGhRBaLZC
   CzHkaRqGwlB0QEA2v1//hA2YWihyvLI8PEvBn8bp4zs76fA/YSO7TrkYn
   8BV7ShH9YosM0OGBPQFqUwQhfkZ2CJnC06ExyiQIG4NMnf7oJTZbUY7Q2
   +A9N7lRjuX8PL9tMTHqA0ZfX4bUPT0Hre51knzca56gbMWPMEefYbA8IK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="397469048"
X-IronPort-AV: E=Sophos;i="6.04,339,1695711600"; 
   d="scan'208";a="397469048"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2024 10:07:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="954434474"
X-IronPort-AV: E=Sophos;i="6.04,339,1695711600"; 
   d="scan'208";a="954434474"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 07 Jan 2024 10:07:34 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMXYa-00040V-19;
	Sun, 07 Jan 2024 18:07:32 +0000
Date: Mon, 8 Jan 2024 02:07:12 +0800
From: kernel test robot <lkp@intel.com>
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>
Subject: pcap-dbus.o:undefined reference to `dbus_message_demarshal'
Message-ID: <202401080102.yhHBSIT3-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Vincent,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   52b1853b080a082ec3749c3a9577f6c71b1d4a90
commit: 10f4c9b9a33b7df000f74fa0d896351fb1a61e6a x86/asm: Fix build of UML with KASAN
date:   4 months ago
config: um-randconfig-r063-20240107 (https://download.01.org/0day-ci/archive/20240108/202401080102.yhHBSIT3-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240108/202401080102.yhHBSIT3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401080102.yhHBSIT3-lkp@intel.com/

All errors (new ones prefixed by >>):

   /usr/bin/ld: arch/um/drivers/pcap.o: in function `dbus_write':
>> pcap-dbus.o:(.text+0x244df): undefined reference to `dbus_message_demarshal'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x244f5): undefined reference to `dbus_connection_send'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x244fe): undefined reference to `dbus_connection_flush'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x24506): undefined reference to `dbus_message_unref'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x24554): undefined reference to `dbus_error_free'
   /usr/bin/ld: arch/um/drivers/pcap.o: in function `dbus_read':
>> pcap-dbus.o:(.text+0x245a0): undefined reference to `dbus_connection_pop_message'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x245c2): undefined reference to `dbus_connection_pop_message'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x245d8): undefined reference to `dbus_connection_read_write'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x24642): undefined reference to `dbus_message_is_signal'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x2465e): undefined reference to `dbus_message_marshal'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x246c6): undefined reference to `dbus_free'
   /usr/bin/ld: arch/um/drivers/pcap.o: in function `dbus_cleanup':
>> pcap-dbus.o:(.text+0x2472c): undefined reference to `dbus_connection_unref'
   /usr/bin/ld: arch/um/drivers/pcap.o: in function `dbus_activate':
>> pcap-dbus.o:(.text+0x247d6): undefined reference to `dbus_connection_open'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x247ee): undefined reference to `dbus_bus_register'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x248dc): undefined reference to `dbus_bus_add_match'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x248e4): undefined reference to `dbus_error_is_set'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x2492b): undefined reference to `dbus_bus_get'
   /usr/bin/ld: pcap-dbus.o:(.text+0x2495c): undefined reference to `dbus_error_free'
   /usr/bin/ld: pcap-dbus.o:(.text+0x2496d): undefined reference to `dbus_bus_add_match'
   /usr/bin/ld: pcap-dbus.o:(.text+0x24975): undefined reference to `dbus_error_is_set'
   /usr/bin/ld: pcap-dbus.o:(.text+0x249ae): undefined reference to `dbus_error_free'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x249ba): undefined reference to `dbus_connection_unref'
   /usr/bin/ld: pcap-dbus.o:(.text+0x249e6): undefined reference to `dbus_bus_get'
   /usr/bin/ld: pcap-dbus.o:(.text+0x24a22): undefined reference to `dbus_error_free'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x24a35): undefined reference to `dbus_connection_set_max_received_size'
   /usr/bin/ld: pcap-dbus.o:(.text+0x24a46): undefined reference to `dbus_connection_unref'
   /usr/bin/ld: pcap-dbus.o:(.text+0x24abc): undefined reference to `dbus_error_free'
   /usr/bin/ld: pcap-dbus.o:(.text+0x24afa): undefined reference to `dbus_error_free'
   collect2: error: ld returned 1 exit status

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

