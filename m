Return-Path: <linux-kernel+bounces-147719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 289708A781E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 295EB1C20BA0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8D913AD1C;
	Tue, 16 Apr 2024 22:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IKGpzXwE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E81813A896;
	Tue, 16 Apr 2024 22:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713307579; cv=none; b=Yq2ePhj3+G1F70ErphWbOvSyPhwobU1DCoui+2y61FvUrB2SDEcnc5eENpo60n53dOoF+2LjrkTC28DUuELVO6LqJdhHWIfppyY0Toj7Zzx98rZH//CD22VOZ2jFTM9J5bdf2QcbQ7b9So8lv1bSvJfkFR3oJUhiUE7rJ03jPtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713307579; c=relaxed/simple;
	bh=ruPLZtboEM5XulxQNfwB0Bs5ITsVQhPBESRc6EcWqdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKPul9k9zB+aAmNVkzG5rjt9zHXsNTuouI/xIwGDUId+k3uEiBcYGhaM/v0jZ8WfOrsqhNRhBcQLNw0sxPwqPg1tJbzNKnZ+mECoOdDqHxsdBl2sFa8Wbp8NDFwF9gGKXPcSbI7HNuoHrIPYgRZVbe6mYCRWVB9hkW48qqA2W6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IKGpzXwE; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713307578; x=1744843578;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ruPLZtboEM5XulxQNfwB0Bs5ITsVQhPBESRc6EcWqdU=;
  b=IKGpzXwEz3Gwj7we2JskIYoln9tEzt17Z3+u4L/K2r4j8bGgOsbw904U
   oktCaro/dqg4+49yeh8ZOF0L8ZW86JFbnU2ZTUFfnsoAmc1P3LkGy742s
   muLwDqLHOCICh8VmBYHNKX/f5T59+IbHiFpdiHeVbU6zEZbkeURK9iJpp
   basWn5/D/g4mkbedSr+G3qh/hEa3lYxIj9XKk+1ZE3Scs2zyrkGAFu8ru
   3vHhXwF4QIme9B1olwQFBvYB1p/YNq58aBlwiJFIPdvoK4yJKv7WCrenV
   WsC/m5VXBapNZd8VzN0yBS5fJAX2/peUTiBWLJSAhWgcxYZk+nT/NgExs
   g==;
X-CSE-ConnectionGUID: zUFkkrnpQwGYTjm/B+6n5Q==
X-CSE-MsgGUID: JFtylfR1RACGwxCgQpA+vA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19336462"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="19336462"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 15:46:17 -0700
X-CSE-ConnectionGUID: XGtGOWL5S2adDgWQ0szi3g==
X-CSE-MsgGUID: ljDqj6luS4yibYyUZCSvJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="53381544"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 16 Apr 2024 15:46:13 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rwrZ5-0005nw-0D;
	Tue, 16 Apr 2024 22:46:11 +0000
Date: Wed, 17 Apr 2024 06:45:54 +0800
From: kernel test robot <lkp@intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Vladimir Zapolskiy <vz@mleia.com>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH 2/9] dt-bindings: rtc: google,goldfish-rtc: move to
 trivial-rtc
Message-ID: <202404170656.LoL9eBYs-lkp@intel.com>
References: <20240408-rtc_dtschema-v1-2-c447542fc362@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408-rtc_dtschema-v1-2-c447542fc362@gmail.com>

Hi Javier,

kernel test robot noticed the following build warnings:

[auto build test WARNING on fec50db7033ea478773b159e0e2efb135270e3b7]

url:    https://github.com/intel-lab-lkp/linux/commits/Javier-Carrasco/dt-bindings-rtc-orion-rtc-move-to-trivial-rtc/20240408-235612
base:   fec50db7033ea478773b159e0e2efb135270e3b7
patch link:    https://lore.kernel.org/r/20240408-rtc_dtschema-v1-2-c447542fc362%40gmail.com
patch subject: [PATCH 2/9] dt-bindings: rtc: google,goldfish-rtc: move to trivial-rtc
reproduce: (https://download.01.org/0day-ci/archive/20240417/202404170656.LoL9eBYs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404170656.LoL9eBYs-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/devicetree/bindings/power/wakeup-source.txt references a file that doesn't exist: Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
   Warning: Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
   Warning: Documentation/devicetree/bindings/sound/fsl-asoc-card.txt references a file that doesn't exist: Documentation/devicetree/bindings/sound/fsl,asrc.txt
   Warning: Documentation/gpu/amdgpu/display/display-contributing.rst references a file that doesn't exist: Documentation/GPU/amdgpu/display/mpo-overview.rst
>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/rtc/google,goldfish-rtc.txt
   Using alabaster theme

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

