Return-Path: <linux-kernel+bounces-2558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB7F815ED0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 12:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EC9BB225B6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 11:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867B932C75;
	Sun, 17 Dec 2023 11:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mm2DBawt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDAD32C63;
	Sun, 17 Dec 2023 11:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702813811; x=1734349811;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9IDAZ6s+VCoUbUYOgwDqe6kkFvmADMWSOYAij07BnEs=;
  b=Mm2DBawtn0sbZ7q1MAX1yqHrtIDlnkThxl8HqJByxR3X3qwiv/wJL6aB
   HMVPZUYwVHIQQXPLbsrjSrYeR6VcK/4lecr3rvVNtvPINdi/hCEerAyKQ
   zDeX+PmH2WIGDu+2Ox4J0wlsDwPu0C2NmRYg2vOrlju99Ort7GEYSE4To
   zOSNXAhpWzqTOPQHMVBZGidM1hvSQGCb5fkJa8rxVuhqzRmy7cnj8oZW0
   OwarEMEBNSUfPgmCOPRWxcqAk1W1XnojmKCNbwvI+RlME2mlwx0c6RGLp
   8lp25bUMZxIlViJLPaqnA71hgMGP6IGAAr7ZU1no0wCncYRIhaxg5+FCz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="375562901"
X-IronPort-AV: E=Sophos;i="6.04,283,1695711600"; 
   d="scan'208";a="375562901"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 03:50:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="724977812"
X-IronPort-AV: E=Sophos;i="6.04,283,1695711600"; 
   d="scan'208";a="724977812"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 17 Dec 2023 03:50:07 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEpen-0002zS-0R;
	Sun, 17 Dec 2023 11:50:05 +0000
Date: Sun, 17 Dec 2023 19:49:54 +0800
From: kernel test robot <lkp@intel.com>
To: Abdel Alkuor <alkuor@gmail.com>, Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: Add AMS AS6200 temperature sensor
Message-ID: <202312171951.3y47awo9-lkp@intel.com>
References: <63e352150ed51eefce90ca4058af5459730174b2.1702744180.git.alkuor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63e352150ed51eefce90ca4058af5459730174b2.1702744180.git.alkuor@gmail.com>

Hi Abdel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on groeck-staging/hwmon-next]
[also build test WARNING on robh/for-next linus/master v6.7-rc5 next-20231215]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Abdel-Alkuor/hwmon-Add-AMS-AS6200-temperature-sensor/20231217-004310
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/63e352150ed51eefce90ca4058af5459730174b2.1702744180.git.alkuor%40gmail.com
patch subject: [PATCH 2/2] hwmon: Add AMS AS6200 temperature sensor
reproduce: (https://download.01.org/0day-ci/archive/20231217/202312171951.3y47awo9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312171951.3y47awo9-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Documentation/hwmon/as6200.rst: WARNING: document isn't included in any toctree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

