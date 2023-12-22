Return-Path: <linux-kernel+bounces-9195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A09481C22D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 01:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1EA5B23F33
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 00:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EEC39F;
	Fri, 22 Dec 2023 00:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nXy13/Kf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22C1A41
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 00:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703203353; x=1734739353;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eqD1S979rhMgSjRKaw74BG3LVkXQfOS64LyFkMXx9+w=;
  b=nXy13/Kft229yEaRBwVX46+H3TK8jlP2TecJDNHJ8OmzluptvMetSF6i
   NPr9hj05HfjFlNFdIPn7UO5dYaJVaQTxHoSh8YdkVngSyhmQrwAY8cChy
   hkGVZTlK5bCIUERwr5c4WFxBy3VD7SnBCMVJEkctY5MERTlvUJhEaeTDg
   leTczDDdFfE53uv0ErFo4cAWO2p3xQmqjLw52WBGdwtRWs9KrQZOSdXTD
   VzPudyiQFlBH8pVT+RcSjlDVTHxaPmHs+t2gsYshDDW0Dqu13Fw6RcHdK
   7sogPBG9/xup9IkN6vcuqeIbB5JmD2FFW7q2n6aETTuCSZ4mqhqoaVonR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="3298541"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="3298541"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 16:02:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="895280533"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="895280533"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 21 Dec 2023 16:02:30 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rGSzb-0008tR-1j;
	Fri, 22 Dec 2023 00:02:27 +0000
Date: Fri, 22 Dec 2023 08:01:57 +0800
From: kernel test robot <lkp@intel.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>
Subject: WARN: resolve_btfids: unresolved symbol vfs_truncate
Message-ID: <202312220719.pwcoWicn-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9a6b294ab496650e9f270123730df37030911b55
commit: 7b99f75942da332e3f4f865e55a10fec95a30d4f bpf: Add --skip_encoding_btf_inconsistent_proto, --btf_gen_optimized to pahole flags for v1.25
date:   7 months ago
config: arm-randconfig-r005-20230402 (https://download.01.org/0day-ci/archive/20231222/202312220719.pwcoWicn-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231222/202312220719.pwcoWicn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312220719.pwcoWicn-lkp@intel.com/

All warnings (new ones prefixed by >>):

   WARN: resolve_btfids: unresolved symbol prog_test_ref_kfunc
   WARN: resolve_btfids: unresolved symbol cgroup
>> WARN: resolve_btfids: unresolved symbol vfs_truncate
   WARN: resolve_btfids: unresolved symbol bpf_obj_new_impl
>> WARN: resolve_btfids: unresolved symbol bpf_lookup_user_key
   WARN: resolve_btfids: unresolved symbol bpf_dynptr_from_xdp
   WARN: resolve_btfids: unresolved symbol bpf_dynptr_from_skb

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

