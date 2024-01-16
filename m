Return-Path: <linux-kernel+bounces-27240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB7582EC99
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F08A3284B9A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C86E13AC8;
	Tue, 16 Jan 2024 10:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oAo+U6ks"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0298C134C0;
	Tue, 16 Jan 2024 10:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705399801; x=1736935801;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LcspFKOnWW08Dve9A5/fi9ZB2V7B9o4EjqhBO4t07k8=;
  b=oAo+U6ksGoz30Xw74gGWeGQNoQRCBqk6Y1z3aim/aGCSAS9BIBV5Ohti
   fKUxUTn3qd4WZrTjrRPNG7kQCKZd5tDZI66EQIAPQQRqdEOLDsERWlqNZ
   CB1fTQ/8TpJpBOQXkV3h9bzb2gm3d7OH7PUleCKfgDHemr02FdkR0ztYI
   Q/mYNTsebC4BCGyaEkYGfkGFCOa3DNbntpeOwTaD9UTTPdmt4Abv4P68c
   g/MGAqvyVbBbezeZpOo1wuIvk89kgBbas53NKD/xQ3B1Ue9t7ryQ9Ujgi
   VuXcTQFKkV9pL1PhVP6mAXvtT4Woxy+yNlle/R2hK2hsfRx3Wqaa5p9Y2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="430980916"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="430980916"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 02:10:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="26081915"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 16 Jan 2024 02:09:56 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rPgOH-0000QQ-18;
	Tue, 16 Jan 2024 10:09:53 +0000
Date: Tue, 16 Jan 2024 18:09:42 +0800
From: kernel test robot <lkp@intel.com>
To: Mao Jinlong <quic_jinlmao@quicinc.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, Mao Jinlong <quic_jinlmao@quicinc.com>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] coresight: core: Add device name support
Message-ID: <202401161751.IuhpKb75-lkp@intel.com>
References: <20240115164252.26510-2-quic_jinlmao@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115164252.26510-2-quic_jinlmao@quicinc.com>

Hi Mao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.7 next-20240112]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mao-Jinlong/coresight-core-Add-device-name-support/20240116-004557
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240115164252.26510-2-quic_jinlmao%40quicinc.com
patch subject: [PATCH v2 1/2] coresight: core: Add device name support
config: arm-randconfig-r112-20240116 (https://download.01.org/0day-ci/archive/20240116/202401161751.IuhpKb75-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240116/202401161751.IuhpKb75-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401161751.IuhpKb75-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/hwtracing/coresight/coresight-core.c:1775:14: sparse: sparse: incorrect type in assignment (different modifiers) @@     expected char *name @@     got char const * @@
   drivers/hwtracing/coresight/coresight-core.c:1775:14: sparse:     expected char *name
   drivers/hwtracing/coresight/coresight-core.c:1775:14: sparse:     got char const *

vim +1775 drivers/hwtracing/coresight/coresight-core.c

  1758	
  1759	/*
  1760	 * coresight_alloc_device_name - Get an index for a given device in the
  1761	 * device index list specific to a driver. An index is allocated for a
  1762	 * device and is tracked with the fwnode_handle to prevent allocating
  1763	 * duplicate indices for the same device (e.g, if we defer probing of
  1764	 * a device due to dependencies), in case the index is requested again.
  1765	 */
  1766	char *coresight_alloc_device_name(struct coresight_dev_list *dict,
  1767					  struct device *dev)
  1768	{
  1769		int idx;
  1770		char *name = NULL;
  1771		struct fwnode_handle **list;
  1772	
  1773		mutex_lock(&coresight_mutex);
  1774	
> 1775		name = coresight_get_device_name(dev);
  1776		if (!name) {
  1777			idx = coresight_search_device_idx(dict, dev_fwnode(dev));
  1778			if (idx < 0) {
  1779				/* Make space for the new entry */
  1780				idx = dict->nr_idx;
  1781				list = krealloc_array(dict->fwnode_list,
  1782						      idx + 1, sizeof(*dict->fwnode_list),
  1783						      GFP_KERNEL);
  1784				if (ZERO_OR_NULL_PTR(list)) {
  1785					idx = -ENOMEM;
  1786					goto done;
  1787				}
  1788	
  1789				list[idx] = dev_fwnode(dev);
  1790				dict->fwnode_list = list;
  1791				dict->nr_idx = idx + 1;
  1792			}
  1793	
  1794			name = devm_kasprintf(dev, GFP_KERNEL, "%s%d", dict->pfx, idx);
  1795		}
  1796	done:
  1797		mutex_unlock(&coresight_mutex);
  1798		return name;
  1799	}
  1800	EXPORT_SYMBOL_GPL(coresight_alloc_device_name);
  1801	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

