Return-Path: <linux-kernel+bounces-27324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 309C182EDCF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A615C285582
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F5F1BC4D;
	Tue, 16 Jan 2024 11:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YOLevhJi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC581BC2A;
	Tue, 16 Jan 2024 11:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705404911; x=1736940911;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pDRoozCoSvSnaG9Is1Yrkh4GD9ZgaI1XvL1QIBhfKro=;
  b=YOLevhJitTaxPW23hPpZ/cRYlWdnzRv2Mi6SQdDFpNyNQq5Ihz/n32FI
   pNr1iSuwUpW/pf1UXse8jREeABjwbBq5NVmIAYHdrCdK6eGDmzFsDpWGc
   DNi36F9N+0TW8W/9r5wzyuWZtE5qQ1rv1ADqRDQPScWpiXVwPXtxHR/iH
   g5VFIgJKUrssGji8M2NPE+noNZK30e3SX131BX4BiVSuehjSOAFJ+BGxr
   S66OT6WGdXVlRqFz3IVvyhA9+m48XYiTv1zZmK/D63EgZLyJizXdpyNTO
   QSm9kihzjs4vxqlwkvpUgPZhXFNGg8+H76lxKdjKc7x9YRBXfzxQpFk7x
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="13337831"
X-IronPort-AV: E=Sophos;i="6.05,199,1701158400"; 
   d="scan'208";a="13337831"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 03:35:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="760151374"
X-IronPort-AV: E=Sophos;i="6.05,199,1701158400"; 
   d="scan'208";a="760151374"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 16 Jan 2024 03:35:03 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rPhif-0000dH-0f;
	Tue, 16 Jan 2024 11:35:01 +0000
Date: Tue, 16 Jan 2024 19:34:07 +0800
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
Message-ID: <202401161905.KuRUhKW4-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.7 next-20240112]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mao-Jinlong/coresight-core-Add-device-name-support/20240116-004557
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240115164252.26510-2-quic_jinlmao%40quicinc.com
patch subject: [PATCH v2 1/2] coresight: core: Add device name support
config: arm-randconfig-r081-20240116 (https://download.01.org/0day-ci/archive/20240116/202401161905.KuRUhKW4-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project 9bde5becb44ea071f5e1fa1f5d4071dc8788b18c)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240116/202401161905.KuRUhKW4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401161905.KuRUhKW4-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/hwtracing/coresight/coresight-core.c:1775:7: error: assigning to 'char *' from 'const char *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
    1775 |         name = coresight_get_device_name(dev);
         |              ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


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

