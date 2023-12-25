Return-Path: <linux-kernel+bounces-11175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E192B81E286
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 23:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC7261C20F43
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 22:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF11353E23;
	Mon, 25 Dec 2023 22:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ge+EffV8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5841C53E1B
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 22:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703541609; x=1735077609;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6A37SPQsKBR8sXkLpS4CIQ0WASgpAcGhXQoLaNCDFro=;
  b=Ge+EffV8vgjK/bELIieEh46Nxp5nLSH3Sjv1tDfJEKvoMUHHsWMkzF6B
   dPLgQ8DrjQqo+Md58r9iDgAQz/NBDsk5+p6zJfcm87lThDmP0mflLJj6s
   K47vU9EqzgvKBkpngn7JAMOkusHbxe4Gi7c3FL4Hyr/j1A1CqzgajFy5v
   5a2XaWrfM5uogEXAArBpr+zoZcZAVhbSx2zyCtbLQsnfmgCtviMHMaVEI
   9MfriQvGy2jBz1psNV9dKTRjpkCbxU7Yb4KEaTgItknQpVFVl/uJ2D/mE
   zaMynrFHcd5ZYz+mljnGjvUuKe5fpRtnCsPde4bG8nqf3Npjp/DK7ajBT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="482481452"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="482481452"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 14:00:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="19501050"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 25 Dec 2023 14:00:05 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHszS-000Di1-1n;
	Mon, 25 Dec 2023 22:00:02 +0000
Date: Tue, 26 Dec 2023 05:59:15 +0800
From: kernel test robot <lkp@intel.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: arch/x86/kernel/uprobes.c:758: warning: Function parameter or member
 'auprobe' not described in 'arch_uprobe_analyze_insn'
Message-ID: <202312260514.MC64urpm-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   861deac3b092f37b2c5e6871732f3e11486f7082
commit: 3a025e1d1c2ea42fa497c9c6b21c284e0f69e28b Add optional check for bad kernel-doc comments
date:   6 years ago
config: i386-defconfig (https://download.01.org/0day-ci/archive/20231226/202312260514.MC64urpm-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231226/202312260514.MC64urpm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312260514.MC64urpm-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/x86/kernel/uprobes.c: In function 'branch_setup_xol_ops':
   arch/x86/kernel/uprobes.c:726:8: warning: this statement may fall through [-Wimplicit-fallthrough=]
      opc1 = OPCODE2(insn) - 0x10;
      ~~~~~^~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/uprobes.c:727:2: note: here
     default:
     ^~~~~~~
>> arch/x86/kernel/uprobes.c:758: warning: Function parameter or member 'auprobe' not described in 'arch_uprobe_analyze_insn'
>> arch/x86/kernel/uprobes.c:758: warning: Excess function parameter 'arch_uprobe' description in 'arch_uprobe_analyze_insn'
--
>> arch/x86/pci/i386.c:372: warning: Function parameter or member 'pcibios_assign_resources' not described in 'fs_initcall'
--
>> arch/x86/power/cpu.c:76: warning: Function parameter or member 'ctxt' not described in '__save_processor_state'
>> arch/x86/power/cpu.c:198: warning: Function parameter or member 'ctxt' not described in '__restore_processor_state'
--
>> crypto/asymmetric_keys/asymmetric_type.c:160: warning: Function parameter or member 'kid1' not described in 'asymmetric_key_id_same'
>> crypto/asymmetric_keys/asymmetric_type.c:160: warning: Function parameter or member 'kid2' not described in 'asymmetric_key_id_same'
>> crypto/asymmetric_keys/asymmetric_type.c:176: warning: Function parameter or member 'kid1' not described in 'asymmetric_key_id_partial'
>> crypto/asymmetric_keys/asymmetric_type.c:176: warning: Function parameter or member 'kid2' not described in 'asymmetric_key_id_partial'
--
>> crypto/asymmetric_keys/pkcs7_trust.c:29: warning: Function parameter or member 'pkcs7' not described in 'pkcs7_validate_trust_one'
>> crypto/asymmetric_keys/pkcs7_trust.c:29: warning: Function parameter or member 'sinfo' not described in 'pkcs7_validate_trust_one'
>> crypto/asymmetric_keys/pkcs7_trust.c:29: warning: Function parameter or member 'trust_keyring' not described in 'pkcs7_validate_trust_one'
--
   drivers/acpi/osl.c: In function 'acpi_os_vprintf':
   drivers/acpi/osl.c:160:2: warning: function 'acpi_os_vprintf' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     vsprintf(buffer, fmt, args);
     ^~~~~~~~
>> drivers/acpi/osl.c:315: warning: cannot understand function prototype: 'void __iomem *__ref acpi_os_map_iomem(acpi_physical_address phys, acpi_size size) '
--
>> drivers/acpi/utils.c:474: warning: Function parameter or member 'handle' not described in 'acpi_handle_path'
>> drivers/acpi/utils.c:496: warning: Function parameter or member 'level' not described in 'acpi_handle_printk'
>> drivers/acpi/utils.c:496: warning: Function parameter or member 'handle' not described in 'acpi_handle_printk'
>> drivers/acpi/utils.c:496: warning: Function parameter or member 'fmt' not described in 'acpi_handle_printk'
>> drivers/acpi/utils.c:525: warning: Function parameter or member 'descriptor' not described in '__acpi_handle_debug'
>> drivers/acpi/utils.c:525: warning: Function parameter or member 'handle' not described in '__acpi_handle_debug'
>> drivers/acpi/utils.c:525: warning: Function parameter or member 'fmt' not described in '__acpi_handle_debug'
--
>> drivers/acpi/nvs.c:95: warning: Function parameter or member 'start' not described in 'suspend_nvs_register'
>> drivers/acpi/nvs.c:95: warning: Function parameter or member 'size' not described in 'suspend_nvs_register'
--
>> drivers/acpi/device_sysfs.c:285: warning: Function parameter or member 'dev' not described in 'acpi_device_uevent_modalias'
>> drivers/acpi/device_sysfs.c:285: warning: Function parameter or member 'env' not described in 'acpi_device_uevent_modalias'
>> drivers/acpi/device_sysfs.c:330: warning: Function parameter or member 'dev' not described in 'acpi_device_modalias'
>> drivers/acpi/device_sysfs.c:330: warning: Function parameter or member 'buf' not described in 'acpi_device_modalias'
>> drivers/acpi/device_sysfs.c:330: warning: Function parameter or member 'size' not described in 'acpi_device_modalias'
--
>> drivers/acpi/pci_root.c:85: warning: Function parameter or member 'handle' not described in 'acpi_is_root_bridge'
--
>> drivers/acpi/acpi_apd.c:47: warning: Function parameter or member 'properties' not described in 'apd_device_desc'
>> drivers/acpi/acpi_apd.c:133: warning: Function parameter or member 'adev' not described in 'acpi_apd_create_device'
>> drivers/acpi/acpi_apd.c:133: warning: Function parameter or member 'id' not described in 'acpi_apd_create_device'
..


vim +758 arch/x86/kernel/uprobes.c

7ba6db2d688bdf Oleg Nesterov              2014-04-05  749  
2b144498350860 Srikar Dronamraju          2012-02-09  750  /**
0326f5a94ddea3 Srikar Dronamraju          2012-03-13  751   * arch_uprobe_analyze_insn - instruction analysis including validity and fixups.
2b144498350860 Srikar Dronamraju          2012-02-09  752   * @mm: the probed address space.
3ff54efdfaace9 Srikar Dronamraju          2012-02-22  753   * @arch_uprobe: the probepoint information.
7eb9ba5ed312ec Ananth N Mavinakayanahalli 2012-06-08  754   * @addr: virtual address at which to install the probepoint
2b144498350860 Srikar Dronamraju          2012-02-09  755   * Return 0 on success or a -ve number on error.
2b144498350860 Srikar Dronamraju          2012-02-09  756   */
7eb9ba5ed312ec Ananth N Mavinakayanahalli 2012-06-08  757  int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long addr)
2b144498350860 Srikar Dronamraju          2012-02-09 @758  {
2b144498350860 Srikar Dronamraju          2012-02-09  759  	struct insn insn;
83cd591485e558 Oleg Nesterov              2014-04-25  760  	u8 fix_ip_or_call = UPROBE_FIX_IP;
ddb69f276c4af8 Oleg Nesterov              2014-03-31  761  	int ret;
2b144498350860 Srikar Dronamraju          2012-02-09  762  
2ae1f49ae1978f Oleg Nesterov              2014-04-19  763  	ret = uprobe_init_insn(auprobe, &insn, is_64bit_mm(mm));
ddb69f276c4af8 Oleg Nesterov              2014-03-31  764  	if (ret)
2b144498350860 Srikar Dronamraju          2012-02-09  765  		return ret;
7b2d81d48a2d8e Ingo Molnar                2012-02-17  766  
7ba6db2d688bdf Oleg Nesterov              2014-04-05  767  	ret = branch_setup_xol_ops(auprobe, &insn);
7ba6db2d688bdf Oleg Nesterov              2014-04-05  768  	if (ret != -ENOSYS)
7ba6db2d688bdf Oleg Nesterov              2014-04-05  769  		return ret;
7ba6db2d688bdf Oleg Nesterov              2014-04-05  770  
ddb69f276c4af8 Oleg Nesterov              2014-03-31  771  	/*
97aa5cddbe9e01 Oleg Nesterov              2014-04-22  772  	 * Figure out which fixups default_post_xol_op() will need to perform,
5cdb76d6f0b657 Oleg Nesterov              2014-06-01  773  	 * and annotate defparam->fixups accordingly.
ddb69f276c4af8 Oleg Nesterov              2014-03-31  774  	 */
ddb69f276c4af8 Oleg Nesterov              2014-03-31  775  	switch (OPCODE1(&insn)) {
ddb69f276c4af8 Oleg Nesterov              2014-03-31  776  	case 0x9d:		/* popf */
5cdb76d6f0b657 Oleg Nesterov              2014-06-01  777  		auprobe->defparam.fixups |= UPROBE_FIX_SETF;
ddb69f276c4af8 Oleg Nesterov              2014-03-31  778  		break;
ddb69f276c4af8 Oleg Nesterov              2014-03-31  779  	case 0xc3:		/* ret or lret -- ip is correct */
ddb69f276c4af8 Oleg Nesterov              2014-03-31  780  	case 0xcb:
ddb69f276c4af8 Oleg Nesterov              2014-03-31  781  	case 0xc2:
ddb69f276c4af8 Oleg Nesterov              2014-03-31  782  	case 0xca:
83cd591485e558 Oleg Nesterov              2014-04-25  783  	case 0xea:		/* jmp absolute -- ip is correct */
83cd591485e558 Oleg Nesterov              2014-04-25  784  		fix_ip_or_call = 0;
ddb69f276c4af8 Oleg Nesterov              2014-03-31  785  		break;
ddb69f276c4af8 Oleg Nesterov              2014-03-31  786  	case 0x9a:		/* call absolute - Fix return addr, not ip */
83cd591485e558 Oleg Nesterov              2014-04-25  787  		fix_ip_or_call = UPROBE_FIX_CALL;
ddb69f276c4af8 Oleg Nesterov              2014-03-31  788  		break;
ddb69f276c4af8 Oleg Nesterov              2014-03-31  789  	case 0xff:
ddb69f276c4af8 Oleg Nesterov              2014-03-31  790  		switch (MODRM_REG(&insn)) {
ddb69f276c4af8 Oleg Nesterov              2014-03-31  791  		case 2: case 3:			/* call or lcall, indirect */
83cd591485e558 Oleg Nesterov              2014-04-25  792  			fix_ip_or_call = UPROBE_FIX_CALL;
83cd591485e558 Oleg Nesterov              2014-04-25  793  			break;
ddb69f276c4af8 Oleg Nesterov              2014-03-31  794  		case 4: case 5:			/* jmp or ljmp, indirect */
83cd591485e558 Oleg Nesterov              2014-04-25  795  			fix_ip_or_call = 0;
83cd591485e558 Oleg Nesterov              2014-04-25  796  			break;
ddb69f276c4af8 Oleg Nesterov              2014-03-31  797  		}
e55848a4f8ee52 Oleg Nesterov              2014-03-31  798  		/* fall through */
ddb69f276c4af8 Oleg Nesterov              2014-03-31  799  	default:
1475ee7fadafc6 Oleg Nesterov              2014-04-27  800  		riprel_analyze(auprobe, &insn);
ddb69f276c4af8 Oleg Nesterov              2014-03-31  801  	}
ddb69f276c4af8 Oleg Nesterov              2014-03-31  802  
5cdb76d6f0b657 Oleg Nesterov              2014-06-01  803  	auprobe->defparam.ilen = insn.length;
5cdb76d6f0b657 Oleg Nesterov              2014-06-01  804  	auprobe->defparam.fixups |= fix_ip_or_call;
7b2d81d48a2d8e Ingo Molnar                2012-02-17  805  
8ad8e9d3fd64f1 Oleg Nesterov              2014-03-31  806  	auprobe->ops = &default_xol_ops;
2b144498350860 Srikar Dronamraju          2012-02-09  807  	return 0;
2b144498350860 Srikar Dronamraju          2012-02-09  808  }
0326f5a94ddea3 Srikar Dronamraju          2012-03-13  809  

:::::: The code at line 758 was first introduced by commit
:::::: 2b144498350860b6ee9dc57ff27a93ad488de5dc uprobes, mm, x86: Add the ability to install and remove uprobes breakpoints

:::::: TO: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
:::::: CC: Ingo Molnar <mingo@elte.hu>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

