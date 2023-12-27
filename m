Return-Path: <linux-kernel+bounces-12185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DF281F108
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 18:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7723D1F2148E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A204653C;
	Wed, 27 Dec 2023 17:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g0ojs7z1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318A946522;
	Wed, 27 Dec 2023 17:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703698892; x=1735234892;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=A1VfCaddzy2SDlg+XO8w3Lq94MaVqkU//Wetdj4bhzc=;
  b=g0ojs7z1CBfFmJaMN071RkpghFZhuxb3gETKLkelAhsvLv55P3YIUmVe
   J5MH/J/2SBAM7DcxHXSQqOwa9f47hO4mqMqX0lNaG7A8x7Le/0wZhYYn0
   UWrI44BdWzni5XfLujD2d8X1ixcZlyg5ehxG3WnQUN86Qyu5tRUD/TL6z
   KFkX9zDrxefR+SU+xGdIXyD+JJ9Vv8kEnCFaKH6RuWfnBeUbcA2tHzMq8
   teryGbUABxhErZ8foHx6gTnU+y9YYhngWDUXMzW+F/pXejqQem9yqXQJA
   b1beQknCKVcXuADXVOwBwOvC9pPvFE5vcq22nsw3OONXzc5lWbFY7uZ3S
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="381440462"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="381440462"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 09:41:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="812585943"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="812585943"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 09:41:25 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rIXuE-00000009Tgl-06dW;
	Wed, 27 Dec 2023 19:41:22 +0200
Date: Wed, 27 Dec 2023 19:41:21 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: broonie@kernel.org, conor+dt@kernel.org, krzysztof.kozlowski@linaro.org,
	robh+dt@kernel.org, kevin-lu@ti.com, baojun.xu@ti.com,
	devicetree@vger.kernel.org, lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, 13916275206@139.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	liam.r.girdwood@intel.com, soyer@irl.hu, tiwai@suse.de,
	peeyush@ti.com, navada@ti.com
Subject: Re: [PATCH v3 3/5] ASoC: tas2781: Add tas2563 into header file for
 DSP mode
Message-ID: <ZYxhwW97kFu1pp6p@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo


On Mon, Dec 25, 2023 at 01:39:29PM +0800, Shenghao Ding wrote:
> Move tas2563 from tas2562 header file to tas2781 header file, because
> tas2563 only work in bypass-DSP mode with tas2562 driver. In oder to
> enable DSP mode for tas2563, it has been moved to tas2781 driver. As to
> the hardware part, such as register setting and DSP firmware, all these
> are stored in the binary firmware. What tas2781 drivder dooes is to parse
> the firmware and download them to the tas2781 or tas2563, then power on
> tas2781 or tas2563. So, tas2781 driver can be resued as tas2563 driver。
> Only attention will be paid to downloading corresponding firmware.

>  enum audio_device {
>  	TAS2781	= 0,
> +	TAS2563
>  };

Please, make it ordered, it doesn't seem to be an ABI.

enum audio_device {
	TAS2563,
	TAS2781,
};

Yes, and leave comma as the last entry is _not_ a terminator.

-- 
With Best Regards,
Andy Shevchenko



