Return-Path: <linux-kernel+bounces-144560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C509D8A47C5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F680282AB0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DE014265;
	Mon, 15 Apr 2024 06:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CfDQdSBW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A220F4F1;
	Mon, 15 Apr 2024 06:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713161257; cv=none; b=DrgrUEsSJ7S6rlTmxPBeokNgp/KQblgLIoKF3D7s1gnKtiwcNnliv6TXNd0t2rTpaZEX1bvky4gTtuuVeynTx3NDPRh3BGSlxAV92DAOjdE5+bnP6RhjIEmYxp8pcyq826eQ/fDov4j30QLB7R895w5KISc5mo9YkoJ30abG1JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713161257; c=relaxed/simple;
	bh=UkDaGbQnkg8kX1gcuWyQClwKdbr1way3lHGmOYrBPaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VudU3HAbUIRP4vQlQ2SdvpIjsD/WX0zIaRMFYff6CZ+yXrdZIdoJZ3Ynw1UW+CN1C4tH8kuJVWU1cWja70N1zJ6yON88I9gornSQFu/gYtzDMyFsxl9o51oB59SasjPqsDeUc/2sGNkpohQl1WPz2+xgSMYkHst/EGF2UboFCfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CfDQdSBW; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713161255; x=1744697255;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UkDaGbQnkg8kX1gcuWyQClwKdbr1way3lHGmOYrBPaM=;
  b=CfDQdSBWKZU5F7OxvRLGvzHxIL/V+EkPZlFUsUYmP2LyZO1ZX/+ePWWa
   9g/5URH5GmsXQp5HmRnvSn49yFX3MKNJM0ZK8Af/Wyb7i2k8nbsULGHHe
   6fzsR397VVU1ObjSXPaQDaKzeFSI32XbASJ8ty0D3O3+Gzn9hjQ36br8u
   m8LNUDbuRL59PPfPDwNahjEDDFLQuQB8ZkkguL30hCUcQxL5FVbsDSqXz
   1Vnp3ysbCw44+QcVMuGz/Ek4wqPG4Z8S26PlKn0FkVmAQAJXuK/TlVpS3
   UKM6NVu/fnX7JI8ggkM8EM4p79iYLJBvvUugOQ7WM5r63wbf+5QEX0iov
   w==;
X-CSE-ConnectionGUID: 749Gbwt8SAmuqHeAo7Rb9g==
X-CSE-MsgGUID: Ek8KQpa5SVKzMnrVz9m7EQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="8642253"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="8642253"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2024 23:07:34 -0700
X-CSE-ConnectionGUID: ApDhLxBQQiiI8N17BUq/pw==
X-CSE-MsgGUID: 6yxzghOST7i4yhVu5wDk3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="21844525"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.38.19])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2024 23:07:30 -0700
Message-ID: <9b628524-0576-44c0-becf-ea76119b4577@intel.com>
Date: Mon, 15 Apr 2024 09:07:26 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] mmc: Constify struct sdhci_ops
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Angelo Dureghello <adureghello@baylibre.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Vignesh Raghavendra <vigneshr@ti.com>,
 Orson Zhai <orsonzhai@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>,
 Ben Dooks <ben-linux@fluff.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240414-mmc-const-sdhci-ops-v2-0-262f81faadac@kernel.org>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240414-mmc-const-sdhci-ops-v2-0-262f81faadac@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/04/24 17:07, Krzysztof Kozlowski wrote:
> Hi,
> 
> Changes in v2:
> - Patch 5 - sdhci-s3c: add __maybe_unused, reported by kernel test
>   robot.
> - Link to v1: https://lore.kernel.org/r/20240414-mmc-const-sdhci-ops-v1-0-178539d68093@kernel.org
> 
> The local struct sdhci_ops can be made const for code safety.
> No dependencies.
> 
> Best regards,
> Krzysztof
> 
> ---
> Krzysztof Kozlowski (5):
>       mmc: sdhci-esdhc-mcf: Constify struct sdhci_ops
>       mmc: sdhci-omap: Constify struct sdhci_ops
>       mmc: sdhci-sprd: Constify struct sdhci_ops
>       mmc: sdhci_am654: Constify struct sdhci_ops
>       mmc: sdhci-s3c: Choose sdhci_ops based on variant
> 
>  drivers/mmc/host/sdhci-esdhc-mcf.c |  2 +-
>  drivers/mmc/host/sdhci-omap.c      |  2 +-
>  drivers/mmc/host/sdhci-s3c.c       | 31 +++++++++++++++++--------------
>  drivers/mmc/host/sdhci-sprd.c      |  2 +-
>  drivers/mmc/host/sdhci_am654.c     |  6 +++---
>  5 files changed, 23 insertions(+), 20 deletions(-)
> ---
> base-commit: f67245b3062cdc225b37003085bdb2916e1670b6
> change-id: 20240414-mmc-const-sdhci-ops-c85762883004
> 
> Best regards,

For all:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>


