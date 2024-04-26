Return-Path: <linux-kernel+bounces-159841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 579B48B3509
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8972B1C21955
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF2F142E93;
	Fri, 26 Apr 2024 10:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UbFhsB/I"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8612313D53C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714126428; cv=none; b=lNu35fZcpysHTCn+N0hrbkLaMw1XXvGJBBoaXjM9KAyY3Z33rdZuy4wrxte+otGJrpJwSOEmBfxT1Ap6ZF517bsRz2RnFJqy0iaGDhs6ULlCjLNxP2aBr5BEPlpTbjeHUQbD4dMM8t5/nKy66bMft9Qkt31xd+iXIcmmPdSykNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714126428; c=relaxed/simple;
	bh=Ofm+LsuIBids+0dBhnDJ4MxonCHSamVU17HIAWPGfQk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qtCM9Gf+jOYsMI8XiEWOAwh866DCHG8pLVq9dzse5xEA7KYUi6UlfzmDlOBel5IGLeuuinfI8D6Vz13giEXbLfxAj6vl0s8nFZ8fpBYcuimh3Q+IHNZKaP5cOYNyfoRt2Hg/WJ5NdJqDwmui52YIfNQ3acRfXdy7DLxrYbrX/o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UbFhsB/I; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714126426; x=1745662426;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ofm+LsuIBids+0dBhnDJ4MxonCHSamVU17HIAWPGfQk=;
  b=UbFhsB/IpPTtyN600WO9G0GOlVsuwMaVnt2lbCqm6MhPnT8O06VxxvVw
   P8WQ3iKJVkQTV4cgBrLKv8k7TxnLcikqWuVYoTWbloPZ0G99awa1BAO6s
   kUHAlPLKbRDH2pwUIHVcX9NWUU/A4Pwk9ClNt4St392x5WhikOPqsUfhO
   jpQBplKVZHlLWXlzp4JZ+1BF4A/x9qkLtUvAKWQtn6bRS/XDle12zslfH
   Iwu3JYp4/Nt5vr2qspbWUZbfihih008wp43OsPWkWmeIMX5nbrsUhhQ0u
   rqynlavB/+6rR6T0h60JX8b2OGv4lyWfLuoxKn9PO7OCv0WoaNePmEZEV
   Q==;
X-CSE-ConnectionGUID: fmq5GwMNTa2eBLs4/C1/dQ==
X-CSE-MsgGUID: /o3tcnunQvitljdZFGLSNQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="13689839"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="13689839"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 03:13:46 -0700
X-CSE-ConnectionGUID: 3XUNaR/9QEicC78ow1FtnA==
X-CSE-MsgGUID: tV6BYjUqQOO18VA5TFQojQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="56544157"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 26 Apr 2024 03:13:44 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s0IaM-0003aK-1P;
	Fri, 26 Apr 2024 10:13:42 +0000
Date: Fri, 26 Apr 2024 18:13:14 +0800
From: kernel test robot <lkp@intel.com>
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>
Subject: pcap-dbus.o:undefined reference to `dbus_message_demarshal'
Message-ID: <202404261846.Z4FJcMbf-lkp@intel.com>
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
head:   c942a0cd3603e34dd2d7237e064d9318cb7f9654
commit: 10f4c9b9a33b7df000f74fa0d896351fb1a61e6a x86/asm: Fix build of UML with KASAN
date:   7 months ago
config: um-randconfig-001-20240426 (https://download.01.org/0day-ci/archive/20240426/202404261846.Z4FJcMbf-lkp@intel.com/config)
compiler: gcc-8 (Ubuntu 8.4.0-3ubuntu2) 8.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240426/202404261846.Z4FJcMbf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404261846.Z4FJcMbf-lkp@intel.com/

All errors (new ones prefixed by >>):

   /usr/bin/ld: arch/um/drivers/pcap.o: in function `dbus_write':
>> pcap-dbus.o:(.text+0x2488f): undefined reference to `dbus_message_demarshal'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x248a5): undefined reference to `dbus_connection_send'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x248ae): undefined reference to `dbus_connection_flush'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x248b6): undefined reference to `dbus_message_unref'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x24904): undefined reference to `dbus_error_free'
   /usr/bin/ld: arch/um/drivers/pcap.o: in function `dbus_read':
>> pcap-dbus.o:(.text+0x24950): undefined reference to `dbus_connection_pop_message'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x24972): undefined reference to `dbus_connection_pop_message'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x24988): undefined reference to `dbus_connection_read_write'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x249f2): undefined reference to `dbus_message_is_signal'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x24a0e): undefined reference to `dbus_message_marshal'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x24a76): undefined reference to `dbus_free'
   /usr/bin/ld: arch/um/drivers/pcap.o: in function `dbus_cleanup':
>> pcap-dbus.o:(.text+0x24adc): undefined reference to `dbus_connection_unref'
   /usr/bin/ld: arch/um/drivers/pcap.o: in function `dbus_activate':
>> pcap-dbus.o:(.text+0x24b86): undefined reference to `dbus_connection_open'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x24b9e): undefined reference to `dbus_bus_register'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x24c8c): undefined reference to `dbus_bus_add_match'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x24c94): undefined reference to `dbus_error_is_set'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x24cdb): undefined reference to `dbus_bus_get'
   /usr/bin/ld: pcap-dbus.o:(.text+0x24d0c): undefined reference to `dbus_error_free'
   /usr/bin/ld: pcap-dbus.o:(.text+0x24d1d): undefined reference to `dbus_bus_add_match'
   /usr/bin/ld: pcap-dbus.o:(.text+0x24d25): undefined reference to `dbus_error_is_set'
   /usr/bin/ld: pcap-dbus.o:(.text+0x24d5e): undefined reference to `dbus_error_free'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x24d6a): undefined reference to `dbus_connection_unref'
   /usr/bin/ld: pcap-dbus.o:(.text+0x24d96): undefined reference to `dbus_bus_get'
   /usr/bin/ld: pcap-dbus.o:(.text+0x24dd2): undefined reference to `dbus_error_free'
>> /usr/bin/ld: pcap-dbus.o:(.text+0x24de5): undefined reference to `dbus_connection_set_max_received_size'
   /usr/bin/ld: pcap-dbus.o:(.text+0x24df6): undefined reference to `dbus_connection_unref'
   /usr/bin/ld: pcap-dbus.o:(.text+0x24e6c): undefined reference to `dbus_error_free'
   /usr/bin/ld: pcap-dbus.o:(.text+0x24eaa): undefined reference to `dbus_error_free'
   collect2: error: ld returned 1 exit status

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

