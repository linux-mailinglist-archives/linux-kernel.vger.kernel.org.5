Return-Path: <linux-kernel+bounces-163359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BC28B69D1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E4322862E8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 05:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDE51798C;
	Tue, 30 Apr 2024 05:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UkwCPcx2"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00511125BA
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 05:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714454226; cv=none; b=WTO+QKI0Ncq6eolQclYVCbBJW9SzlP5Hl4y3dlx7DapCNAZmMLIhSA2V5e6O4EMZtXkS/LjVmXH6ENtCjb1/wHuQTlaMJOx0+W/weezgf4uqR2ipw8FBI53aduJIWbN5Ub1ud9r6zjg0CXuWUYBBPbsFZLQCmLPXk/pZLQEp/hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714454226; c=relaxed/simple;
	bh=X1vBe8uy2scxUJixEbvfFTMb+bweVxUZtX/Ylg3mEfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOHjQa8JMghu4SVKd3sG1gscPy+UWMSv8/55nKQzDvZ/6kVkN3tVFSKdciGAl21U/hMkRUY+sBmE7KkjIAE2J1q8XBM8yeyFkzReUhNAIhjYs+1wzpoRTgZ74GiweflZcvmQt9LRDGRc7ZB0zveF/LcWFWhzsUhqBuqASqyu3BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UkwCPcx2; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ed32341906so4845394b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 22:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714454223; x=1715059023; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V0avMUsDc59rYN7coX7sm9Yp5eSnR9Q04mgQzckQ9lw=;
        b=UkwCPcx21AW7wq0fo62AYWe9kY7I+Y/Sm2yXQdFYzdRVl5a1cDwqgo0MBpuBFmY7T2
         m0oiCKzu/AJFo9RVdE52gBqpW/YvjBrE73H047CkHbafqXbXqZT4Ma73IQJpPI8djLl2
         nCUB4rcJ/eNdecPqpRHXDvXJ84S0AzgUVYNN3JGobnDbPm3V3baz+0wLswYL1pA5+wuM
         d+Fsq18e9Yi5kuA8DIdOezZ/3AxOIJ1QlsEXIKJsgGt5xn85LczsimC3BgutR7HLve1P
         LpWznJv7iSZD3gcT2Sv3L25YfXLmDUMZqyRMUltodhJLiai1k8a9+jaUPYjJ1hkPfBy/
         H+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714454223; x=1715059023;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V0avMUsDc59rYN7coX7sm9Yp5eSnR9Q04mgQzckQ9lw=;
        b=iDFEgqENA78z0RovXF3OWBX9pv9uRlZ7IOq+Fw3qbyAgyu4nVFc7LiKA17y1dQWq1S
         P0tV7su4tZY4zvCUDkaGwVVNchkxqzvbWJVYq9/KIkUAGRgWr+yW6d3oBQEmyFr60Y1S
         FPjxdccI7sPynB/GxRNhvpogG/53q6FP7BQ+LZjvem+T1xm1AD7vNcyuqpNa3YF1eB0v
         6SpLz787lNjDbohGcjAbMOB9HU7lXAGunKNH2CvXsAN6q/KaUanridm+UPA0R+YuCYhb
         kXbclGtq8fSWPjmNldlzoh/4tFaFvhhAO1QH10MPXo+V+WEt7InWCSKdk5ianUXbQNln
         p2ZA==
X-Forwarded-Encrypted: i=1; AJvYcCVlpgf0Jm+5I9JemrYZe5GOAMZCVyNqsBQMiqRxf2EsyCFyYVYN+Gf0SQK+bIEYK/mgzIYCEAVchJ9zfUXxC/0vHk4mNadaNOshO/dZ
X-Gm-Message-State: AOJu0YzDfyvpjCGkiTf/D/MdLp7fPdzTw7UTyrMsDi8N99uF/vqGZvrt
	pvCSrFEOVRGoTNX83zLyOQBV1A+7BdPRiKL6vAkjITVgn8puk/QtQTWSIjmAMh4yq2oascIcidw
	=
X-Google-Smtp-Source: AGHT+IFWRZGQxckWXPNLxXAG7MGt/iJLdvfO4+V6xpas6sXD4xSC0z15Fh9sptvi1twg0sW4mfipRw==
X-Received: by 2002:a05:6a20:72a0:b0:1aa:59ff:5d31 with SMTP id o32-20020a056a2072a000b001aa59ff5d31mr14465799pzk.0.1714454223164;
        Mon, 29 Apr 2024 22:17:03 -0700 (PDT)
Received: from thinkpad ([220.158.156.15])
        by smtp.gmail.com with ESMTPSA id su11-20020a17090b534b00b002b27eb61901sm602961pjb.21.2024.04.29.22.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 22:17:02 -0700 (PDT)
Date: Tue, 30 Apr 2024 10:46:53 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Frank Li <Frank.Li@nxp.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-amlogic@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Yue Wang <yue.wang@Amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Xiaowei Song <songxiaowei@hisilicon.com>,
	Binghui Wang <wangbinghui@hisilicon.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH v3 1/5] PCI: dra7xx: Add missing header inclusion
Message-ID: <20240430051653.GB3301@thinkpad>
References: <20240429102510.2665280-1-andriy.shevchenko@linux.intel.com>
 <20240429102510.2665280-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240429102510.2665280-2-andriy.shevchenko@linux.intel.com>

On Mon, Apr 29, 2024 at 01:23:18PM +0300, Andy Shevchenko wrote:
> Driver is using chained_irq_*() APIs, add the respective inclusion.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pci-dra7xx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> index d2d17d37d3e0..b67071a63f8a 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -13,6 +13,7 @@
>  #include <linux/err.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> +#include <linux/irqchip/chained_irq.h>
>  #include <linux/irqdomain.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -- 
> 2.43.0.rc1.1336.g36b5255a03ac
> 

-- 
மணிவண்ணன் சதாசிவம்

