Return-Path: <linux-kernel+bounces-167514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EF48BAAA5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5281C1C223C1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769531514E3;
	Fri,  3 May 2024 10:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OlmoVPGq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269A81514C3;
	Fri,  3 May 2024 10:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714731570; cv=none; b=dc5JhQJR88PqjhwrSGcFsY5v7gnZYMsmOC1Ri0D290sG2Dnvgehpei7YLqLPL70i0FZJ4FjLGXJNgm20oVOYXLJwu1R8uGzUmB79KigRWiCqpn81rAHNldWl/kNT4viV/oKqOujAJeGD9bQ52VyJqw+oOiOlalCf/RfFU3YLrbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714731570; c=relaxed/simple;
	bh=RJodMdiCqV1H+srp+wmAlmr2N64s2/ekyL+2Gqy5MIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mH/4Im4/FPJyliIdhvImwCse5en7zNcPpuZCDaZcscMfx+puiWNMTfVA0mqnKyAqGUEK/vp0PXN4ozwgzjMh/2nr6XD3TNjsLeKeRM3nZGNaY3MjcG4pOc2c4AaYvbBmYSDqzVXsVzbHVJNkE1fzhKVP0xm1dKJXo9rJZzZtdBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OlmoVPGq; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714731568; x=1746267568;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RJodMdiCqV1H+srp+wmAlmr2N64s2/ekyL+2Gqy5MIU=;
  b=OlmoVPGqUA8VvM7RfgC2Qzf2fMsoNbpPDh9qOAcXElX1CdKr7PCe8Ma8
   fUWp2u4bAFrM1MNvSjEgLzmLmwaHIw7IKtIkiG5/blSXuRzMHB+R0Edsu
   dY2P/AUdNenBPrrGUYEkljphNfKMYBEsxxVutXLVog5ybfy12EZtqcLIS
   L+IxsV27R7ZSeHPbeZuxZO9jFfOBLrTYYfHSk+pq0d02wGNZRJ/57OEYq
   WoRY+wSAmPRI9o5jhIEvSwLXO0CPvNy94biW3dmn7hnRly1ML7wsc3v4q
   wVUhkdCJjJN25WaVuoSmqkRt/6MSVC9WQ0Yfd1HbHQkpBSBTAsT2cySs+
   g==;
X-CSE-ConnectionGUID: NBX/hSvfSQmfrmef126DlA==
X-CSE-MsgGUID: vA7lmEB1TXKgEuw3CZSsyw==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="10386666"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="10386666"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 03:19:27 -0700
X-CSE-ConnectionGUID: ZRiV3XMeRaSj1B/GfchsVQ==
X-CSE-MsgGUID: 6HRYxUCUSEiCS8vx5FnX4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="32215817"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 03 May 2024 03:19:27 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s2q0i-000BZy-0P;
	Fri, 03 May 2024 10:19:24 +0000
Date: Fri, 3 May 2024 18:19:14 +0800
From: kernel test robot <lkp@intel.com>
To: Naresh Solanki <naresh.solanki@9elements.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: oe-kbuild-all@lists.linux.dev,
	Naresh Solanki <naresh.solanki@9elements.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] hwmon (max6639): Use regmap
Message-ID: <202405031504.sA1rmWDu-lkp@intel.com>
References: <20240502183604.1216576-1-naresh.solanki@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502183604.1216576-1-naresh.solanki@9elements.com>

Hi Naresh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 1d4d6733594d407e54153b8e031ba6356ceba81e]

url:    https://github.com/intel-lab-lkp/linux/commits/Naresh-Solanki/hwmon-max6639-Use-regmap/20240503-024046
base:   1d4d6733594d407e54153b8e031ba6356ceba81e
patch link:    https://lore.kernel.org/r/20240502183604.1216576-1-naresh.solanki%409elements.com
patch subject: [PATCH v3] hwmon (max6639): Use regmap
config: i386-buildonly-randconfig-003-20240503 (https://download.01.org/0day-ci/archive/20240503/202405031504.sA1rmWDu-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240503/202405031504.sA1rmWDu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405031504.sA1rmWDu-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/hwmon/max6639.c: In function 'max6639_suspend':
>> drivers/hwmon/max6639.c:540:13: warning: unused variable 'ret' [-Wunused-variable]
     540 |         int ret;
         |             ^~~


vim +/ret +540 drivers/hwmon/max6639.c

   536	
   537	static int max6639_suspend(struct device *dev)
   538	{
   539		struct max6639_data *data = dev_get_drvdata(dev);
 > 540		int ret;
   541	
   542		if (data->reg)
   543			regulator_disable(data->reg);
   544	
   545		return regmap_write_bits(data->regmap, MAX6639_REG_GCONFIG, MAX6639_GCONFIG_STANDBY,
   546					 MAX6639_GCONFIG_STANDBY);
   547	}
   548	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

