Return-Path: <linux-kernel+bounces-141760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 888EE8A230F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F4A01F2285B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 00:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B806E33F7;
	Fri, 12 Apr 2024 00:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XwOxDorn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EB61C27
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 00:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712883363; cv=none; b=W4d7WCojE7yBH8neG93V+QNF2l/kjeqWNkYQ89xeGQjxb7fKXlTzlfZM0tIcUS+QIj2/tGKYCr9RKIpG5tzsFp5vG6dm/hWAZu8rTFyIkse1eOZ9BaTDiiyfOxZQY/IMxzMeWzAcrLf7aOpvmCxqyIqeorQlk/oXLjlpO7J/UnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712883363; c=relaxed/simple;
	bh=334ZMqmxBl7YValr6ZbdcFWUiv4uVAddV9WAEQg2Gl4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=uIH8mR+JmvfXTgBD69T1/9fbwkx+jIpF1z7RFOEn4YhZAScRKEzlAa+WQv0pCufLidpdDvTNFXfGEuYzf0KzFVfN7ZvJuQ1zEGQUrY4wEjr6XqxQE97cJUoNaD+zcQbLrYzQbDq0tHav+eKL7V8sw9PQdN1RQhzDeueb57qFLOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XwOxDorn; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712883361; x=1744419361;
  h=date:from:to:cc:subject:message-id;
  bh=334ZMqmxBl7YValr6ZbdcFWUiv4uVAddV9WAEQg2Gl4=;
  b=XwOxDornDIRpSUITvtW5rqOHCr52KL+XlrM5/b/w3mdSYbJeDh3iCtVr
   uvI5M+Q8OUiLieT1fc4d66reLiT5gAPWkqXIEvR/QXnY01E35/oc4bqpB
   iNmDgLRHluUnSRrn542EYNestvHx+1JAwlI9JeJ930LYpCVfClFn5jsWi
   XasYyeAU0028SyEdRmtrrkddp9kWhOdxiHlA7FqdpH4ev080dIGWnj2HV
   kw7lRD7Jxe7d2DkOg2cdty/stKxQb0WqIsc3oEGP+Kae6OlGaDenABRO3
   h/tWVM+cGStwSWGvlqm88RqhXDXLAMPgTS/h3ja4tLt3HTA8WHz/SmQY9
   w==;
X-CSE-ConnectionGUID: 8RkiZLjiTq6A0x+Tcn7KKQ==
X-CSE-MsgGUID: eF2I9IWkRDWsACalpthFaw==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="8550877"
X-IronPort-AV: E=Sophos;i="6.07,194,1708416000"; 
   d="scan'208";a="8550877"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 17:56:01 -0700
X-CSE-ConnectionGUID: 1FkWqbZBRfe60FQQe/pHCQ==
X-CSE-MsgGUID: I4fEe1rpRYazuLC5kGICHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,194,1708416000"; 
   d="scan'208";a="21139014"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 11 Apr 2024 17:55:59 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rv5Cv-00098r-0Y;
	Fri, 12 Apr 2024 00:55:57 +0000
Date: Fri, 12 Apr 2024 08:55:23 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 898e4996e76053bfa0f578629ec6b35baff4224b
Message-ID: <202404120821.AST8WXrh-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 898e4996e76053bfa0f578629ec6b35baff4224b  x86/cpu/amd: Make the NODEID_MSR union actually work

elapsed time: 723m

configs tested: 26
configs skipped: 148

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240411   clang
i386         buildonly-randconfig-002-20240411   clang
i386         buildonly-randconfig-003-20240411   clang
i386         buildonly-randconfig-004-20240411   clang
i386         buildonly-randconfig-005-20240411   clang
i386         buildonly-randconfig-006-20240411   clang
i386                                defconfig   clang
i386                  randconfig-001-20240411   gcc  
i386                  randconfig-002-20240411   gcc  
i386                  randconfig-003-20240411   clang
i386                  randconfig-004-20240411   clang
i386                  randconfig-005-20240411   gcc  
i386                  randconfig-006-20240411   clang
i386                  randconfig-011-20240411   clang
i386                  randconfig-012-20240411   gcc  
i386                  randconfig-013-20240411   gcc  
i386                  randconfig-014-20240411   gcc  
i386                  randconfig-015-20240411   clang
i386                  randconfig-016-20240411   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

