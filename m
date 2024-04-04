Return-Path: <linux-kernel+bounces-132026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE53898EEA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18D5328BCD4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56291339BA;
	Thu,  4 Apr 2024 19:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DiO4IAai"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485F2131BDE;
	Thu,  4 Apr 2024 19:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712258534; cv=none; b=SxlkkFWfTOBhuCYrK5je1smlm/ScGxcS8hQCtpbO6MpWnbKGOfMYDRqBOFC233q3ZQ43pVRb3+NVxgZniTU1k10cx8XiMeG7eIxOqyLDUwqSwUYUF8Wfuukx8h0gfWxEGk8w86OQmT/uZ7TKf1QJQbTDS4kBPu2OrjZZWcA5owQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712258534; c=relaxed/simple;
	bh=Egp1NO+BBlQy6ZZGKntrh5fzBSDWHai2iUKm4Jo2cmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWKBq0GLmZqVHU3u5KnnXUdLsYqsSHtblpzFh9ZzAvV3bDICRBFaz/HeVaZB3YURRpOB0V5u2h5qzmDXdYFcRZLcBwacyhyQB+G279TKafQuaSCrVlcbQNakjnYoY+JpLtL0af7GcxO9Dipe7PrLZJvDNneJq5Ilb/f7xOvHJ3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DiO4IAai; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712258532; x=1743794532;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Egp1NO+BBlQy6ZZGKntrh5fzBSDWHai2iUKm4Jo2cmg=;
  b=DiO4IAaih9vj+aJns5ZcMwztJ1Tm5SOZQ4lnypenLOMzA/VbYU2Dn7VG
   N42kcCWwtDknBtZLGd5imwd5Y5bZpznmiQw6ghCdQsjopN2wqR9AFJe3K
   uMQ0osGK4zEXTCG544BPAMQTwQvh5iqp+R6601RqSEe7WjdD+fOTaXqHU
   5rDooBr8oxohzqDEgEP3frxQ/HvG45+7xn9W23WfCwKa3JpztPI/pFdpm
   KVAiuJWAWOMm2k7idSqZnNZ3RRmq775zyjoQinhsswoIL7WyjhhsVCIkA
   bQRcKiUqjzXuvKT9euIX3pOPesKprGgwi9sx4JiLGt//22dG4QsJVKWR/
   w==;
X-CSE-ConnectionGUID: E/n14+tmT6yK0/6MFkVLxw==
X-CSE-MsgGUID: uTQMLcOZQgOirF/mMzxKPA==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7413478"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="7413478"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 12:22:11 -0700
X-CSE-ConnectionGUID: a/A4cP3QR6+wDOFXpyubLg==
X-CSE-MsgGUID: wvMv0wbdQuWynV1lIHOBrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="18911324"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 04 Apr 2024 12:22:06 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rsSex-0001PS-2d;
	Thu, 04 Apr 2024 19:22:03 +0000
Date: Fri, 5 Apr 2024 03:21:55 +0800
From: kernel test robot <lkp@intel.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	chunkuang.hu@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, shawn.sung@mediatek.com,
	yu-chang.lee@mediatek.com, ck.hu@mediatek.com,
	jitao.shi@mediatek.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, wenst@chromium.org,
	kernel@collabora.com
Subject: Re: [PATCH v1 2/3] dt-bindings: arm: mediatek: mmsys: Add OF graph
 support for board path
Message-ID: <202404050315.7WBDW2E8-lkp@intel.com>
References: <20240404081635.91412-3-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404081635.91412-3-angelogioacchino.delregno@collabora.com>

Hi AngeloGioacchino,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on robh/for-next pza/reset/next linus/master v6.9-rc2 next-20240404]
[cannot apply to pza/imx-drm/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/AngeloGioacchino-Del-Regno/dt-bindings-display-mediatek-Add-OF-graph-support-for-board-path/20240404-161930
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20240404081635.91412-3-angelogioacchino.delregno%40collabora.com
patch subject: [PATCH v1 2/3] dt-bindings: arm: mediatek: mmsys: Add OF graph support for board path
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240405/202404050315.7WBDW2E8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404050315.7WBDW2E8-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml: properties:port:properties:required: ['endpoint@0'] is not of type 'object', 'boolean'
   	from schema $id: http://json-schema.org/draft-07/schema#
>> Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml: properties:port:properties: 'required' should not be valid under {'$ref': '#/definitions/json-schema-prop-names'}
   	hint: A json-schema keyword was found instead of a DT property name.
   	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
>> Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml: properties:port:properties:required: ['endpoint@0'] is not of type 'object', 'boolean'
   	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
--
>> Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml: ignoring, error in schema: properties: port: properties: required
   Documentation/devicetree/bindings/net/snps,dwmac.yaml: mac-mode: missing type definition

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

