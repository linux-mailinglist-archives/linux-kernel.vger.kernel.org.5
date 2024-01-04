Return-Path: <linux-kernel+bounces-16489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD513823F41
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61E8C1F24D40
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF23820B16;
	Thu,  4 Jan 2024 10:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="liBk1tKp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7719320B0B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 10:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704362945; x=1735898945;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Zn6rtUsrgv/u0hTeMjA7uLbZBR3xs2/mqpVUxoEuTZk=;
  b=liBk1tKpT40J1vXJpA8A+HSOR1xlg+5lF3GS6QXIkDIIBfD2f2fPjNJv
   vcwVRVdqwGkqivuZQslZR5ETe6Ywv/jokDp1AN+QR6yoUfWmyjVmYwiqz
   qFGVwmyw0XZ7s/2iCRw0NKmXGwfyPBEO1H3D2lp5sNNrMNbLC7t9CbYFb
   +7+oeW9EQFwa/Tbu2PAS/uNlqAzSAk7nyGFR2IawmaLbeh2qxUZPFdPPI
   ozMfjKW2ugQnepf3GGYhIGR1R9NXOW6t6UgraVProDhwX8qmFtpi/RA6m
   DwSlhYFnRxoD9pLlfLwWtTMKtrnjuTVaLgNVoazGIAAsW9y9mSJ0AT670
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="399974973"
X-IronPort-AV: E=Sophos;i="6.04,330,1695711600"; 
   d="scan'208";a="399974973"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 02:09:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="1111680265"
X-IronPort-AV: E=Sophos;i="6.04,330,1695711600"; 
   d="scan'208";a="1111680265"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 04 Jan 2024 02:09:03 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rLKer-000N9J-0T;
	Thu, 04 Jan 2024 10:09:01 +0000
Date: Thu, 4 Jan 2024 18:08:03 +0800
From: kernel test robot <lkp@intel.com>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: kernel/power/suspend.c:92:54: sparse: sparse: incorrect type in
 argument 2 (different base types)
Message-ID: <202401041805.DwQmRjKN-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Huacai,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ac865f00af293d081356bec56eea90815094a60e
commit: 366bb35a8e48198cefcd3484ac6b2374d1347873 LoongArch: Add suspend (ACPI S3) support
date:   1 year, 1 month ago
config: loongarch-randconfig-r054-20230824 (https://download.01.org/0day-ci/archive/20240104/202401041805.DwQmRjKN-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20240104/202401041805.DwQmRjKN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401041805.DwQmRjKN-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/power/suspend.c:92:54: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int val @@     got restricted suspend_state_t [usertype] @@
   kernel/power/suspend.c:92:54: sparse:     expected int val
   kernel/power/suspend.c:92:54: sparse:     got restricted suspend_state_t [usertype]
   kernel/power/suspend.c:117:54: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int val @@     got restricted suspend_state_t [usertype] @@
   kernel/power/suspend.c:117:54: sparse:     expected int val
   kernel/power/suspend.c:117:54: sparse:     got restricted suspend_state_t [usertype]
>> kernel/power/suspend.c:178:19: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:178:47: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:179:19: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:179:51: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:184:26: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:184:65: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:191:42: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:191:51: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:192:38: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:193:51: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:191:72: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:215:34: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:215:73: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:216:27: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:216:59: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:221:34: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:221:69: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:222:21: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:222:42: sparse: sparse: restricted suspend_state_t degrades to integer
>> kernel/power/suspend.c:445:33: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int val @@     got restricted suspend_state_t [usertype] state @@
   kernel/power/suspend.c:445:33: sparse:     expected int val
   kernel/power/suspend.c:445:33: sparse:     got restricted suspend_state_t [usertype] state
   kernel/power/suspend.c:448:33: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int val @@     got restricted suspend_state_t [usertype] state @@
   kernel/power/suspend.c:448:33: sparse:     expected int val
   kernel/power/suspend.c:448:33: sparse:     got restricted suspend_state_t [usertype] state
   kernel/power/suspend.c:518:53: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int val @@     got restricted suspend_state_t [usertype] state @@
   kernel/power/suspend.c:518:53: sparse:     expected int val
   kernel/power/suspend.c:518:53: sparse:     got restricted suspend_state_t [usertype] state
   kernel/power/suspend.c:520:53: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int val @@     got restricted suspend_state_t [usertype] state @@
   kernel/power/suspend.c:520:53: sparse:     expected int val
   kernel/power/suspend.c:520:53: sparse:     got restricted suspend_state_t [usertype] state
   kernel/power/suspend.c:557:52: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int val @@     got restricted suspend_state_t [usertype] state @@
   kernel/power/suspend.c:557:52: sparse:     expected int val
   kernel/power/suspend.c:557:52: sparse:     got restricted suspend_state_t [usertype] state
   kernel/power/suspend.c:580:9: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:580:9: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:589:52: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int val @@     got restricted suspend_state_t [usertype] state @@
   kernel/power/suspend.c:589:52: sparse:     expected int val
   kernel/power/suspend.c:589:52: sparse:     got restricted suspend_state_t [usertype] state
   kernel/power/suspend.c:590:9: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:590:9: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:615:13: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:615:22: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:615:39: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:615:48: sparse: sparse: restricted suspend_state_t degrades to integer
   kernel/power/suspend.c:618:9: sparse: sparse: restricted suspend_state_t degrades to integer
--
   drivers/message/fusion/mptbase.c:3369:33: sparse:     got restricted __le16 [usertype]
   drivers/message/fusion/mptbase.c:3375:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [addressable] [assigned] [usertype] HostMfaHighAddr @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptbase.c:3375:42: sparse:     expected unsigned int [addressable] [assigned] [usertype] HostMfaHighAddr
   drivers/message/fusion/mptbase.c:3375:42: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptbase.c:3376:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [addressable] [assigned] [usertype] SenseBufferHighAddr @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptbase.c:3376:46: sparse:     expected unsigned int [addressable] [assigned] [usertype] SenseBufferHighAddr
   drivers/message/fusion/mptbase.c:3376:46: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptbase.c:3379:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [addressable] [assigned] [usertype] HostMfaHighAddr @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptbase.c:3379:42: sparse:     expected unsigned int [addressable] [assigned] [usertype] HostMfaHighAddr
   drivers/message/fusion/mptbase.c:3379:42: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptbase.c:3380:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [addressable] [assigned] [usertype] SenseBufferHighAddr @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptbase.c:3380:46: sparse:     expected unsigned int [addressable] [assigned] [usertype] SenseBufferHighAddr
   drivers/message/fusion/mptbase.c:3380:46: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptbase.c:3611:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] ImageSize @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptbase.c:3611:27: sparse:     expected unsigned int [usertype] ImageSize
   drivers/message/fusion/mptbase.c:3611:27: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptbase.c:3635:26: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptbase.c:3639:21: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptbase.c:4874:38: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptbase.c:4879:46: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptbase.c:4884:9: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptbase.c:4895:25: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptbase.c:5329:44: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptbase.c:5426:54: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptbase.c:5427:59: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptbase.c:5512:47: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptbase.c:5539:38: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptbase.c:5546:40: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptbase.c:5550:49: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptbase.c:6189:23: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptbase.c:6191:31: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptbase.c:6197:58: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] CoalescingTimeout @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptbase.c:6197:58: sparse:     expected unsigned int [usertype] CoalescingTimeout
   drivers/message/fusion/mptbase.c:6197:58: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptbase.c:6298:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [addressable] [assigned] [usertype] MsgContext @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptbase.c:6298:24: sparse:     expected unsigned int [addressable] [assigned] [usertype] MsgContext
   drivers/message/fusion/mptbase.c:6298:24: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptbase.c:1315:21: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptbase.c:7709:17: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptbase.c:7710:21: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptbase.c:7712:27: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptbase.c:7758:61: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptbase.c:528:19: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptbase.c:538:20: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptbase.c:540:37: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptbase.c:915:55: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] req_idx @@     got restricted __le16 [usertype] @@
   drivers/message/fusion/mptbase.c:915:55: sparse:     expected unsigned short [usertype] req_idx
   drivers/message/fusion/mptbase.c:915:55: sparse:     got restricted __le16 [usertype]
   drivers/message/fusion/mptbase.c:965:47: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] req_idx @@     got restricted __le16 [usertype] @@
   drivers/message/fusion/mptbase.c:965:47: sparse:     expected unsigned short [usertype] req_idx
   drivers/message/fusion/mptbase.c:965:47: sparse:     got restricted __le16 [usertype]
   drivers/message/fusion/mptbase.c:1000:47: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] req_idx @@     got restricted __le16 [usertype] @@
   drivers/message/fusion/mptbase.c:1000:47: sparse:     expected unsigned short [usertype] req_idx
   drivers/message/fusion/mptbase.c:1000:47: sparse:     got restricted __le16 [usertype]
   drivers/message/fusion/mptbase.c:1027:13: sparse: sparse: restricted __le32 degrades to integer
   drivers/message/fusion/mptbase.c:1030:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] arg1 @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptbase.c:1030:34: sparse:     expected unsigned int [usertype] arg1
   drivers/message/fusion/mptbase.c:1030:34: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptbase.c:1053:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] FlagsLength @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptbase.c:1053:27: sparse:     expected unsigned int [usertype] FlagsLength
   drivers/message/fusion/mptbase.c:1053:27: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptbase.c:1054:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] Address @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptbase.c:1054:23: sparse:     expected unsigned int [usertype] Address
   drivers/message/fusion/mptbase.c:1054:23: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptbase.c:1070:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] Low @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptbase.c:1070:27: sparse:     expected unsigned int [usertype] Low
   drivers/message/fusion/mptbase.c:1070:27: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptbase.c:1072:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] High @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptbase.c:1072:28: sparse:     expected unsigned int [usertype] High
   drivers/message/fusion/mptbase.c:1072:28: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptbase.c:1074:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] FlagsLength @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptbase.c:1074:27: sparse:     expected unsigned int [usertype] FlagsLength
   drivers/message/fusion/mptbase.c:1074:27: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptbase.c:1093:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] Low @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptbase.c:1093:27: sparse:     expected unsigned int [usertype] Low
   drivers/message/fusion/mptbase.c:1093:27: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptbase.c:1111:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] High @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptbase.c:1111:28: sparse:     expected unsigned int [usertype] High
   drivers/message/fusion/mptbase.c:1111:28: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptbase.c:1112:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] FlagsLength @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptbase.c:1112:27: sparse:     expected unsigned int [usertype] FlagsLength
   drivers/message/fusion/mptbase.c:1112:27: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptbase.c:1130:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] Length @@     got restricted __le16 [usertype] @@
   drivers/message/fusion/mptbase.c:1130:24: sparse:     expected unsigned short [usertype] Length
   drivers/message/fusion/mptbase.c:1130:24: sparse:     got restricted __le16 [usertype]
   drivers/message/fusion/mptbase.c:1133:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] Address @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptbase.c:1133:25: sparse:     expected unsigned int [usertype] Address
   drivers/message/fusion/mptbase.c:1133:25: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptbase.c:1151:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] Length @@     got restricted __le16 [usertype] @@
   drivers/message/fusion/mptbase.c:1151:24: sparse:     expected unsigned short [usertype] Length
   drivers/message/fusion/mptbase.c:1151:24: sparse:     got restricted __le16 [usertype]
   drivers/message/fusion/mptbase.c:1157:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] Low @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptbase.c:1157:29: sparse:     expected unsigned int [usertype] Low
   drivers/message/fusion/mptbase.c:1157:29: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptbase.c:1159:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] High @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptbase.c:1159:30: sparse:     expected unsigned int [usertype] High
   drivers/message/fusion/mptbase.c:1159:30: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptbase.c:1199:55: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] req_idx @@     got restricted __le16 [usertype] @@
   drivers/message/fusion/mptbase.c:1199:55: sparse:     expected unsigned short [usertype] req_idx
   drivers/message/fusion/mptbase.c:1199:55: sparse:     got restricted __le16 [usertype]
>> drivers/message/fusion/mptbase.c:2146:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] device_state @@     got restricted pci_power_t @@
   drivers/message/fusion/mptbase.c:2146:22: sparse:     expected unsigned int [usertype] device_state
   drivers/message/fusion/mptbase.c:2146:22: sparse:     got restricted pci_power_t
>> drivers/message/fusion/mptbase.c:2171:35: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted pci_power_t [usertype] state @@     got unsigned int [usertype] device_state @@
   drivers/message/fusion/mptbase.c:2171:35: sparse:     expected restricted pci_power_t [usertype] state
   drivers/message/fusion/mptbase.c:2171:35: sparse:     got unsigned int [usertype] device_state
>> drivers/message/fusion/mptbase.c:2184:32: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] device_state @@     got restricted pci_power_t [usertype] current_state @@
   drivers/message/fusion/mptbase.c:2184:32: sparse:     expected unsigned int [usertype] device_state
   drivers/message/fusion/mptbase.c:2184:32: sparse:     got restricted pci_power_t [usertype] current_state
   drivers/message/fusion/mptbase.c:5131:13: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptbase.c:5162:19: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptbase.c:5786:29: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptbase.c:5930:44: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptbase.c:5932:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le64 [addressable] [usertype] sas_address @@     got unsigned long long [usertype] @@
   drivers/message/fusion/mptbase.c:5932:29: sparse:     expected restricted __le64 [addressable] [usertype] sas_address
   drivers/message/fusion/mptbase.c:5932:29: sparse:     got unsigned long long [usertype]
   drivers/message/fusion/mptbase.c:5936:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le64 [addressable] [usertype] sas_address @@     got unsigned long long [usertype] @@
   drivers/message/fusion/mptbase.c:5936:29: sparse:     expected restricted __le64 [addressable] [usertype] sas_address
   drivers/message/fusion/mptbase.c:5936:29: sparse:     got unsigned long long [usertype]
   drivers/message/fusion/mptbase.c:6429:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] ExtPageLength @@     got restricted __le16 [usertype] @@
   drivers/message/fusion/mptbase.c:6429:37: sparse:     expected unsigned short [usertype] ExtPageLength
   drivers/message/fusion/mptbase.c:6429:37: sparse:     got restricted __le16 [usertype]
   drivers/message/fusion/mptbase.c:6439:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] PageAddress @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptbase.c:6439:27: sparse:     expected unsigned int [usertype] PageAddress
   drivers/message/fusion/mptbase.c:6439:27: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptbase.c:6499:15: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptbase.c:6503:29: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptbase.c:6519:9: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptbase.c:7248:17: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptbase.c:7249:19: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptbase.c:7678:27: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptbase.c:7679:17: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptbase.c:8160:16: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptbase.c: note: in included file (through arch/loongarch/include/asm/io.h, include/linux/io.h, include/linux/irq.h, ...):
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32

vim +92 kernel/power/suspend.c

7e73c5ae6e7991 Zhang Rui                 2013-02-06   89  
f02f4f9d826590 Rafael J. Wysocki         2017-08-10   90  static void s2idle_enter(void)
7e73c5ae6e7991 Zhang Rui                 2013-02-06   91  {
690cbb90a709c1 Rafael J. Wysocki         2017-08-10  @92  	trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_TO_IDLE, true);
33e4f80ee69b51 Rafael J. Wysocki         2017-06-12   93  
62fc00a6611a00 Sebastian Andrzej Siewior 2018-05-25   94  	raw_spin_lock_irq(&s2idle_lock);
3810631332465d Rafael J. Wysocki         2015-02-12   95  	if (pm_wakeup_pending())
3810631332465d Rafael J. Wysocki         2015-02-12   96  		goto out;
3810631332465d Rafael J. Wysocki         2015-02-12   97  
f02f4f9d826590 Rafael J. Wysocki         2017-08-10   98  	s2idle_state = S2IDLE_STATE_ENTER;
62fc00a6611a00 Sebastian Andrzej Siewior 2018-05-25   99  	raw_spin_unlock_irq(&s2idle_lock);
3810631332465d Rafael J. Wysocki         2015-02-12  100  
d2c8cce647f302 Sebastian Andrzej Siewior 2021-08-03  101  	cpus_read_lock();
3810631332465d Rafael J. Wysocki         2015-02-12  102  
3810631332465d Rafael J. Wysocki         2015-02-12  103  	/* Push all the CPUs into the idle loop. */
3810631332465d Rafael J. Wysocki         2015-02-12  104  	wake_up_all_idle_cpus();
3810631332465d Rafael J. Wysocki         2015-02-12  105  	/* Make the current CPU wait so it can enter the idle loop too. */
b3dae109fa89d6 Peter Zijlstra            2018-06-12  106  	swait_event_exclusive(s2idle_wait_head,
f02f4f9d826590 Rafael J. Wysocki         2017-08-10  107  		    s2idle_state == S2IDLE_STATE_WAKE);
3810631332465d Rafael J. Wysocki         2015-02-12  108  
d2c8cce647f302 Sebastian Andrzej Siewior 2021-08-03  109  	cpus_read_unlock();
3810631332465d Rafael J. Wysocki         2015-02-12  110  
62fc00a6611a00 Sebastian Andrzej Siewior 2018-05-25  111  	raw_spin_lock_irq(&s2idle_lock);
3810631332465d Rafael J. Wysocki         2015-02-12  112  
3810631332465d Rafael J. Wysocki         2015-02-12  113   out:
f02f4f9d826590 Rafael J. Wysocki         2017-08-10  114  	s2idle_state = S2IDLE_STATE_NONE;
62fc00a6611a00 Sebastian Andrzej Siewior 2018-05-25  115  	raw_spin_unlock_irq(&s2idle_lock);
33e4f80ee69b51 Rafael J. Wysocki         2017-06-12  116  
690cbb90a709c1 Rafael J. Wysocki         2017-08-10  117  	trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_TO_IDLE, false);
33e4f80ee69b51 Rafael J. Wysocki         2017-06-12  118  }
33e4f80ee69b51 Rafael J. Wysocki         2017-06-12  119  
33e4f80ee69b51 Rafael J. Wysocki         2017-06-12  120  static void s2idle_loop(void)
33e4f80ee69b51 Rafael J. Wysocki         2017-06-12  121  {
56b991849009f5 Rafael J. Wysocki         2019-07-15  122  	pm_pr_dbg("suspend-to-idle\n");
9a3ebe3523cc82 Rafael J. Wysocki         2017-07-21  123  
8e6bcd9f7eac47 Rafael J. Wysocki         2017-07-21  124  	/*
56b991849009f5 Rafael J. Wysocki         2019-07-15  125  	 * Suspend-to-idle equals:
8e6bcd9f7eac47 Rafael J. Wysocki         2017-07-21  126  	 * frozen processes + suspended devices + idle processors.
56b991849009f5 Rafael J. Wysocki         2019-07-15  127  	 * Thus s2idle_enter() should be called right after all devices have
56b991849009f5 Rafael J. Wysocki         2019-07-15  128  	 * been suspended.
87cbde8d9081b9 Rafael J. Wysocki         2017-09-28  129  	 *
56b991849009f5 Rafael J. Wysocki         2019-07-15  130  	 * Wakeups during the noirq suspend of devices may be spurious, so try
56b991849009f5 Rafael J. Wysocki         2019-07-15  131  	 * to avoid them upfront.
8e6bcd9f7eac47 Rafael J. Wysocki         2017-07-21  132  	 */
56b991849009f5 Rafael J. Wysocki         2019-07-15  133  	for (;;) {
e3728b50cd9be7 Rafael J. Wysocki         2020-02-11  134  		if (s2idle_ops && s2idle_ops->wake) {
e3728b50cd9be7 Rafael J. Wysocki         2020-02-11  135  			if (s2idle_ops->wake())
33e4f80ee69b51 Rafael J. Wysocki         2017-06-12  136  				break;
e3728b50cd9be7 Rafael J. Wysocki         2020-02-11  137  		} else if (pm_wakeup_pending()) {
e3728b50cd9be7 Rafael J. Wysocki         2020-02-11  138  			break;
e3728b50cd9be7 Rafael J. Wysocki         2020-02-11  139  		}
33e4f80ee69b51 Rafael J. Wysocki         2017-06-12  140  
811d59fdf56a17 Mario Limonciello         2022-08-29  141  		if (s2idle_ops && s2idle_ops->check)
811d59fdf56a17 Mario Limonciello         2022-08-29  142  			s2idle_ops->check();
811d59fdf56a17 Mario Limonciello         2022-08-29  143  
56b991849009f5 Rafael J. Wysocki         2019-07-15  144  		s2idle_enter();
8e6bcd9f7eac47 Rafael J. Wysocki         2017-07-21  145  	}
33e4f80ee69b51 Rafael J. Wysocki         2017-06-12  146  
8d8b2441db9647 Rafael J. Wysocki         2017-07-19  147  	pm_pr_dbg("resume from suspend-to-idle\n");
7e73c5ae6e7991 Zhang Rui                 2013-02-06  148  }
7e73c5ae6e7991 Zhang Rui                 2013-02-06  149  
f02f4f9d826590 Rafael J. Wysocki         2017-08-10  150  void s2idle_wake(void)
7e73c5ae6e7991 Zhang Rui                 2013-02-06  151  {
3810631332465d Rafael J. Wysocki         2015-02-12  152  	unsigned long flags;
3810631332465d Rafael J. Wysocki         2015-02-12  153  
62fc00a6611a00 Sebastian Andrzej Siewior 2018-05-25  154  	raw_spin_lock_irqsave(&s2idle_lock, flags);
f02f4f9d826590 Rafael J. Wysocki         2017-08-10  155  	if (s2idle_state > S2IDLE_STATE_NONE) {
f02f4f9d826590 Rafael J. Wysocki         2017-08-10  156  		s2idle_state = S2IDLE_STATE_WAKE;
b3dae109fa89d6 Peter Zijlstra            2018-06-12  157  		swake_up_one(&s2idle_wait_head);
7e73c5ae6e7991 Zhang Rui                 2013-02-06  158  	}
62fc00a6611a00 Sebastian Andrzej Siewior 2018-05-25  159  	raw_spin_unlock_irqrestore(&s2idle_lock, flags);
3810631332465d Rafael J. Wysocki         2015-02-12  160  }
f02f4f9d826590 Rafael J. Wysocki         2017-08-10  161  EXPORT_SYMBOL_GPL(s2idle_wake);
7e73c5ae6e7991 Zhang Rui                 2013-02-06  162  
43e8317b0bba1d Rafael J. Wysocki         2014-05-26  163  static bool valid_state(suspend_state_t state)
43e8317b0bba1d Rafael J. Wysocki         2014-05-26  164  {
43e8317b0bba1d Rafael J. Wysocki         2014-05-26  165  	/*
9f6abfcd67aae5 Rafael J. Wysocki         2021-10-22  166  	 * The PM_SUSPEND_STANDBY and PM_SUSPEND_MEM states require low-level
9f6abfcd67aae5 Rafael J. Wysocki         2021-10-22  167  	 * support and need to be valid to the low-level implementation.
9f6abfcd67aae5 Rafael J. Wysocki         2021-10-22  168  	 *
9f6abfcd67aae5 Rafael J. Wysocki         2021-10-22  169  	 * No ->valid() or ->enter() callback implies that none are valid.
43e8317b0bba1d Rafael J. Wysocki         2014-05-26  170  	 */
9f6abfcd67aae5 Rafael J. Wysocki         2021-10-22  171  	return suspend_ops && suspend_ops->valid && suspend_ops->valid(state) &&
9f6abfcd67aae5 Rafael J. Wysocki         2021-10-22  172  		suspend_ops->enter;
43e8317b0bba1d Rafael J. Wysocki         2014-05-26  173  }
43e8317b0bba1d Rafael J. Wysocki         2014-05-26  174  
fa7fd6fa38e36d Sudeep Holla              2016-08-19  175  void __init pm_states_init(void)
fa7fd6fa38e36d Sudeep Holla              2016-08-19  176  {
c1bfc598181bf0 Rafael J. Wysocki         2021-10-19  177  	/* "mem" and "freeze" are always present in /sys/power/state. */
c1bfc598181bf0 Rafael J. Wysocki         2021-10-19 @178  	pm_states[PM_SUSPEND_MEM] = pm_labels[PM_SUSPEND_MEM];
690cbb90a709c1 Rafael J. Wysocki         2017-08-10  179  	pm_states[PM_SUSPEND_TO_IDLE] = pm_labels[PM_SUSPEND_TO_IDLE];
fa7fd6fa38e36d Sudeep Holla              2016-08-19  180  	/*
406e79385f3223 Rafael J. Wysocki         2016-11-21  181  	 * Suspend-to-idle should be supported even without any suspend_ops,
406e79385f3223 Rafael J. Wysocki         2016-11-21  182  	 * initialize mem_sleep_states[] accordingly here.
fa7fd6fa38e36d Sudeep Holla              2016-08-19  183  	 */
690cbb90a709c1 Rafael J. Wysocki         2017-08-10  184  	mem_sleep_states[PM_SUSPEND_TO_IDLE] = mem_sleep_labels[PM_SUSPEND_TO_IDLE];
fa7fd6fa38e36d Sudeep Holla              2016-08-19  185  }
fa7fd6fa38e36d Sudeep Holla              2016-08-19  186  

:::::: The code at line 92 was first introduced by commit
:::::: 690cbb90a709c1b9389c6cb8e1978e77553ce0fb PM / s2idle: Rename PM_SUSPEND_FREEZE to PM_SUSPEND_TO_IDLE

:::::: TO: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

