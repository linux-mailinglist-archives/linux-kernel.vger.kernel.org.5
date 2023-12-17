Return-Path: <linux-kernel+bounces-2573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 320FA815EF5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 13:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63EAC1C20F42
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 12:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE3132C80;
	Sun, 17 Dec 2023 12:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WIBrGm1b"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FC5328B5;
	Sun, 17 Dec 2023 12:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702815733; x=1734351733;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3VPDevcHr+8gDV3iqHESEh3dFF+a8DIUxapocq9Arvo=;
  b=WIBrGm1bA6Oy9GXG+wlnewa2UASCCC//i/Bz0Z+bHcXWImY+KWI1so5N
   tOE6X9j6a3FUFBrnQLhP2nAXniiyEAv2EFUWTDImmNLjq7y5zgrEUL6sa
   IzT0309KWJb//LsDWpKZgbUwTCib/dqSC3IXhP9NUpqLP2B88XA7nGBaI
   vkf2/8kOMf2cERDPpDWe9/zUfIFlcTB/0Ypcifw4UqYn+ZVPePUXD7vMT
   jVoP5RCbEg82vZCqt23tyAp8jI03oorMRtOqOWdHg+hfUP2kx3LOqpJ1o
   Jctx/J8NqGQaPV0rQoYPUKgDFh7NtuozI26qwYMtsfeiqptD6bhoJ3Eee
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="2239079"
X-IronPort-AV: E=Sophos;i="6.04,283,1695711600"; 
   d="scan'208";a="2239079"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 04:22:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="768539606"
X-IronPort-AV: E=Sophos;i="6.04,283,1695711600"; 
   d="scan'208";a="768539606"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 17 Dec 2023 04:22:08 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEq9m-00031t-1a;
	Sun, 17 Dec 2023 12:22:06 +0000
Date: Sun, 17 Dec 2023 20:21:48 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Golle <daniel@makrotopia.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v5 1/7] dt-bindings: mtd: add basic bindings for UBI
Message-ID: <202312172000.EiNsnuy9-lkp@intel.com>
References: <a9c12b8cc183b103af421a4a350ae6ef1ec173c8.1702770711.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9c12b8cc183b103af421a4a350ae6ef1ec173c8.1702770711.git.daniel@makrotopia.org>

Hi Daniel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mtd/mtd/next]
[also build test WARNING on mtd/mtd/fixes robh/for-next linus/master v6.7-rc5 next-20231215]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Golle/dt-bindings-mtd-add-basic-bindings-for-UBI/20231217-081328
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next
patch link:    https://lore.kernel.org/r/a9c12b8cc183b103af421a4a350ae6ef1ec173c8.1702770711.git.daniel%40makrotopia.org
patch subject: [PATCH v5 1/7] dt-bindings: mtd: add basic bindings for UBI
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231217/202312172000.EiNsnuy9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312172000.EiNsnuy9-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml:18:11: [error] string value is redundantly quoted with any quotes (quoted-strings)
   Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml:23:11: [error] string value is redundantly quoted with any quotes (quoted-strings)
>> Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml:29:5: [warning] wrong indentation: expected 6 but found 4 (indentation)
   Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml:32:5: [warning] wrong indentation: expected 6 but found 4 (indentation)

vim +18 Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml

     8	
     9	description: |
    10	  This binding describes a single UBI volume. Volumes can be matches either
    11	  by their ID or their name, or both.
    12	
    13	maintainers:
    14	  - Daniel Golle <daniel@makrotopia.org>
    15	
    16	properties:
    17	  volid:
  > 18	    $ref: "/schemas/types.yaml#/definitions/uint32"
    19	    description:
    20	      Match UBI volume ID
    21	
    22	  volname:
    23	    $ref: "/schemas/types.yaml#/definitions/string"
    24	    description:
    25	      Match UBI volume ID
    26	
    27	anyOf:
    28	  - required:
  > 29	    - volid
    30	
    31	  - required:
    32	    - volname
    33	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

