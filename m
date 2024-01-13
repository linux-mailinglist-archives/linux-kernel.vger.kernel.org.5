Return-Path: <linux-kernel+bounces-25361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 535DB82CE42
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 20:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFCCB283F96
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 19:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1A66AB9;
	Sat, 13 Jan 2024 19:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="de4QuNMr"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615B363A9;
	Sat, 13 Jan 2024 19:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705173440; x=1736709440;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l/RpQNj4gP732f2vHKYAlKSTUzjcPoYeEZirHy/RBPw=;
  b=de4QuNMrVdp7LiFl3xnsx7VH54E5hymuG/uptzDe6rHv9oWNzSXkWoei
   IWMltDP5P6/21ZIM1cc531s1kwM/qMIhIL/digKIScvQcLwmtpNsAayJU
   b9lYYv1LtftKjalzPsFiASrYG95qqH574GTDbKNVwJyv/Gz2YHfKNwB/f
   ovGGOvl+h4xveLnxHcDAd4L3l57ugwfpIDvQBCgkz5k9/32lOmhk7pLpE
   K2LoBHZAcaF5ShtsqIyXXLL3MacATmLqb8ggAmZ48Ore867+LUz43K3oZ
   Y6E5SbcLH8iFDVS3OA8Y3oK0eravvxlxPdo8lP623ObW6ry9XCFvQ5d+V
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10952"; a="430573453"
X-IronPort-AV: E=Sophos;i="6.04,192,1695711600"; 
   d="scan'208";a="430573453"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2024 11:17:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10952"; a="776334957"
X-IronPort-AV: E=Sophos;i="6.04,192,1695711600"; 
   d="scan'208";a="776334957"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 13 Jan 2024 11:17:15 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rOjVJ-000Aq4-0Q;
	Sat, 13 Jan 2024 19:17:13 +0000
Date: Sun, 14 Jan 2024 03:16:52 +0800
From: kernel test robot <lkp@intel.com>
To: Catalin Popescu <catalin.popescu@leica-geosystems.com>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, afd@ti.com,
	andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Catalin Popescu <catalin.popescu@leica-geosystems.com>
Subject: Re: [PATCH 2/3] dt-bindings: net: dp83826: add ti,cfg-dac-plus
 binding
Message-ID: <202401140357.ZT1pEydN-lkp@intel.com>
References: <20240111161927.3689084-2-catalin.popescu@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111161927.3689084-2-catalin.popescu@leica-geosystems.com>

Hi Catalin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on net-next/main net/main linus/master v6.7 next-20240112]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Catalin-Popescu/dt-bindings-net-dp83826-add-ti-cfg-dac-plus-binding/20240112-002701
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240111161927.3689084-2-catalin.popescu%40leica-geosystems.com
patch subject: [PATCH 2/3] dt-bindings: net: dp83826: add ti,cfg-dac-plus binding
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240114/202401140357.ZT1pEydN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401140357.ZT1pEydN-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   Documentation/devicetree/bindings/net/ti,dp83822.yaml: ti,cfg-dac-minus: missing type definition
>> Documentation/devicetree/bindings/net/ti,dp83822.yaml: ti,cfg-dac-plus: missing type definition
   Documentation/devicetree/bindings/net/snps,dwmac.yaml: mac-mode: missing type definition

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

