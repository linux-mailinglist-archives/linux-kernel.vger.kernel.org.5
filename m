Return-Path: <linux-kernel+bounces-18774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1258262DA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 04:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E8A31C210CD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 03:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C35A11198;
	Sun,  7 Jan 2024 03:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PpYJXdO7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE36A111A1
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 03:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704599450; x=1736135450;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CDpQKEX2O/HHiaxF90XErz6gT7xsK4ImkREDxdtY9YE=;
  b=PpYJXdO7KS/A8QjEfIKfFqMdIsTbPrTfkEoLjnz91ahDVcywIpe4ZDVe
   ypTjB0RROrtQZvn7Z4JG/gSJNp7/AOqIyY2EV74uFyB9e7ltsZfbKJwhF
   4/fhKJ1KeNVVX5V3z/ub8c7qhUAIlRKy0ewQ0jfL0Ve9HSq8TryUdiQRn
   M7DOAOG3WcHp2Tv80rQzmYItjkJLgXGBHT1IPySiqHP6f1N+YqyD1LpMf
   cGDqnqh0ZCoKk6muaT5Y4o8PjiQgneSXvvkVZU86LKnDVr540cdpzvB3t
   bFlsJP1+xiNTqtKEi+iIS6WJkYv30ZoP2pq4ENFtdP/O+VEAxnm0wWU9T
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="388153135"
X-IronPort-AV: E=Sophos;i="6.04,338,1695711600"; 
   d="scan'208";a="388153135"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 19:50:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="871561638"
X-IronPort-AV: E=Sophos;i="6.04,338,1695711600"; 
   d="scan'208";a="871561638"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Jan 2024 19:50:48 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMKBS-0003Ll-07;
	Sun, 07 Jan 2024 03:50:46 +0000
Date: Sun, 7 Jan 2024 11:50:21 +0800
From: kernel test robot <lkp@intel.com>
To: Marc Zyngier <maz@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/arm64/kvm/vgic/vgic-its.c:2071: warning: Excess function
 parameter 'its' description in 'int'
Message-ID: <202401071101.7C316Nvo-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Marc,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   52b1853b080a082ec3749c3a9577f6c71b1d4a90
commit: 9ed24f4b712b855dcf7be3025b75b051cb73a2b7 KVM: arm64: Move virt/kvm/arm to arch/arm64
date:   3 years, 8 months ago
config: arm64-randconfig-r016-20230905 (https://download.01.org/0day-ci/archive/20240107/202401071101.7C316Nvo-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240107/202401071101.7C316Nvo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401071101.7C316Nvo-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/arm64/kvm/vgic/vgic-its.c:174: warning: Function parameter or member 'save_tables' not described in 'vgic_its_abi'
   arch/arm64/kvm/vgic/vgic-its.c:2071: warning: Function parameter or member 'entry_fn_t' not described in 'int'
>> arch/arm64/kvm/vgic/vgic-its.c:2071: warning: Excess function parameter 'its' description in 'int'
>> arch/arm64/kvm/vgic/vgic-its.c:2071: warning: Excess function parameter 'id' description in 'int'
>> arch/arm64/kvm/vgic/vgic-its.c:2071: warning: Excess function parameter 'entry' description in 'int'
>> arch/arm64/kvm/vgic/vgic-its.c:2071: warning: Excess function parameter 'opaque' description in 'int'
   arch/arm64/kvm/vgic/vgic-its.c:2090: warning: Function parameter or member 'opaque' not described in 'scan_its_table'
   arch/arm64/kvm/vgic/vgic-its.c:2125: warning: Function parameter or member 'its' not described in 'vgic_its_save_ite'
   arch/arm64/kvm/vgic/vgic-its.c:2125: warning: Function parameter or member 'dev' not described in 'vgic_its_save_ite'
   arch/arm64/kvm/vgic/vgic-its.c:2125: warning: Function parameter or member 'ite' not described in 'vgic_its_save_ite'
   arch/arm64/kvm/vgic/vgic-its.c:2125: warning: Function parameter or member 'gpa' not described in 'vgic_its_save_ite'
   arch/arm64/kvm/vgic/vgic-its.c:2125: warning: Function parameter or member 'ite_esz' not described in 'vgic_its_save_ite'
   arch/arm64/kvm/vgic/vgic-its.c:2146: warning: Function parameter or member 'its' not described in 'vgic_its_restore_ite'
   arch/arm64/kvm/vgic/vgic-its.c:2270: warning: Function parameter or member 'dte_esz' not described in 'vgic_its_save_dte'
   arch/arm64/kvm/vgic/vgic-its.c:2353: warning: Function parameter or member 'its' not described in 'vgic_its_save_device_tables'
   arch/arm64/kvm/vgic/vgic-its.c:2423: warning: Function parameter or member 'its' not described in 'vgic_its_restore_device_tables'
   arch/arm64/kvm/vgic/vgic-its.c:2503: warning: Function parameter or member 'its' not described in 'vgic_its_save_collection_table'
   arch/arm64/kvm/vgic/vgic-its.c:2544: warning: Function parameter or member 'its' not described in 'vgic_its_restore_collection_table'
   arch/arm64/kvm/vgic/vgic-its.c:2578: warning: Function parameter or member 'its' not described in 'vgic_its_save_tables_v0'
   arch/arm64/kvm/vgic/vgic-its.c:2594: warning: Function parameter or member 'its' not described in 'vgic_its_restore_tables_v0'


vim +2071 arch/arm64/kvm/vgic/vgic-its.c

920a7a8fa92ae0 virt/kvm/arm/vgic/vgic-its.c Eric Auger 2017-02-08  2059  
920a7a8fa92ae0 virt/kvm/arm/vgic/vgic-its.c Eric Auger 2017-02-08  2060  /**
920a7a8fa92ae0 virt/kvm/arm/vgic/vgic-its.c Eric Auger 2017-02-08  2061   * entry_fn_t - Callback called on a table entry restore path
920a7a8fa92ae0 virt/kvm/arm/vgic/vgic-its.c Eric Auger 2017-02-08  2062   * @its: its handle
920a7a8fa92ae0 virt/kvm/arm/vgic/vgic-its.c Eric Auger 2017-02-08  2063   * @id: id of the entry
920a7a8fa92ae0 virt/kvm/arm/vgic/vgic-its.c Eric Auger 2017-02-08  2064   * @entry: pointer to the entry
920a7a8fa92ae0 virt/kvm/arm/vgic/vgic-its.c Eric Auger 2017-02-08  2065   * @opaque: pointer to an opaque data
920a7a8fa92ae0 virt/kvm/arm/vgic/vgic-its.c Eric Auger 2017-02-08  2066   *
920a7a8fa92ae0 virt/kvm/arm/vgic/vgic-its.c Eric Auger 2017-02-08  2067   * Return: < 0 on error, 0 if last element was identified, id offset to next
920a7a8fa92ae0 virt/kvm/arm/vgic/vgic-its.c Eric Auger 2017-02-08  2068   * element otherwise
920a7a8fa92ae0 virt/kvm/arm/vgic/vgic-its.c Eric Auger 2017-02-08  2069   */
920a7a8fa92ae0 virt/kvm/arm/vgic/vgic-its.c Eric Auger 2017-02-08  2070  typedef int (*entry_fn_t)(struct vgic_its *its, u32 id, void *entry,
920a7a8fa92ae0 virt/kvm/arm/vgic/vgic-its.c Eric Auger 2017-02-08 @2071  			  void *opaque);
920a7a8fa92ae0 virt/kvm/arm/vgic/vgic-its.c Eric Auger 2017-02-08  2072  

:::::: The code at line 2071 was first introduced by commit
:::::: 920a7a8fa92ae0ec73c4f6d6f15c01f86017f20d KVM: arm64: vgic-its: Add infrastructure for table lookup

:::::: TO: Eric Auger <eric.auger@redhat.com>
:::::: CC: Christoffer Dall <cdall@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

