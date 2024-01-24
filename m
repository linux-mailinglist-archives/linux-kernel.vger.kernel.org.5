Return-Path: <linux-kernel+bounces-36652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A04183A466
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22E8F289760
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C29117996;
	Wed, 24 Jan 2024 08:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t5rB2M5+"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CE017980
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 08:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706085807; cv=none; b=FUGPz+sz8eYRw7GeQ5v9DhUdSXwYqUwL47XTZJmwzp33cjKIaV8V6f4NjlyY11cmzvViCklItyBrOfT1R5SzNayU4RnWRcaHMlwkVGhZGgvw32SaUOtlB+Sl7nb/suEp6STBIcHu3+DXCCNgbHdKuiIEtOMNqcoQa2Wal0MGf3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706085807; c=relaxed/simple;
	bh=a5+Y4PK8Tvf+sigWvxT2Oizf/v8oqo1GVxi7PwImtVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SjWn/+NwWzXawKZ77LqrYcISWMGTIFkdyFph4oWqK1hEjwVkvH1AkXTppZTOGSonljN5WinakYPfzLJaZI2eT/2jq8LdlY5uh9Zvedm/O8easQctWXmi1CnLRuK4BmIvosC5+JtWhCdtaFHsXJwfaGScGbHpQ8pvtEbwH77gtno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t5rB2M5+; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3bd6581bca0so3306392b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 00:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706085804; x=1706690604; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5F77cepD96Xl+KWE10eagNpd7WlTaV/PHMJWTPQtzTE=;
        b=t5rB2M5+MAajF2aV9uQKCMpPhUIeDzUSKVnfCNkSHl/CL1QkZJiTOo1juuU6mFlSMA
         pv1MwOhTUEc0Aop8nlSlEcz3dCt+qRhDkzZONQ8LcgwjQRdFtelJWPKb+l/NutDdspIc
         6DM7FjDTmNrjrxtrPm5tR04FzonWwrCuhgaovkR8huepuM6LZ4e/wY2KSQNlwBSCEnUt
         z9N/u6MYNNSHIv63ippwl0nd4QvnQE2VkxQQqxtSurerPLwLu+csuVCxfPcXLX22aaRE
         Prmstzb7hAB+WRhsmj8ivh/ylHiDBIsOPLLzrpUjoSAWN2X3cI2swI1qV29vLPCTj+4f
         T0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706085804; x=1706690604;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5F77cepD96Xl+KWE10eagNpd7WlTaV/PHMJWTPQtzTE=;
        b=SwvDN1GAjaRQb6U9QNbGper2XmnQ9qtCMfU+GvsDR24H1gZVSI31YNyezYxalBmK3z
         I6PywG+D6xlY5+W6m5A1aKfLCbP0M92PR7FxfhcY2cRv+rIa+Iz9qkkLJRRLDicgRRjA
         F1KN+6LDaaS6fW53whEQ3i9juuNJQqt9fzEvUhTbPhc1CZnRyLUMTSw/+dZt/a5+JOM+
         dkR+VWcoilZNFpmJF72jR9AdS38dtabNX8ghN2Ppj8KukICTHc3Vr4xBkAFX1wx6okFi
         /mHk0imuSygDxJkaJglcl8uvp/I7GaI+pbXgiccY8IzJhY5+JfFVdxrqMOHP/LARdOoM
         n2jw==
X-Gm-Message-State: AOJu0Yxk+ZKoBnxDnEkx6Br+3tQbPGinQ9beMx11YyQ2/eyDI9LxVaDe
	jVoPuJudeFCtfS10uRrBxFttsESIYo73fHuLU4szrCjriCJnyO3qTkPL0KkZGg==
X-Google-Smtp-Source: AGHT+IHKCJEXy30SfEdm+8xbyObjZ+0ZwuX9yqOA4WKKW5OGso/7AlJuDblMWxjiQyWpjfRUI6IqJA==
X-Received: by 2002:a05:6808:11c9:b0:3bd:9ff7:6051 with SMTP id p9-20020a05680811c900b003bd9ff76051mr1163124oiv.72.1706085804661;
        Wed, 24 Jan 2024 00:43:24 -0800 (PST)
Received: from thinkpad ([117.217.189.109])
        by smtp.gmail.com with ESMTPSA id s36-20020a056a0017a400b006dd89752e8asm1067422pfg.22.2024.01.24.00.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 00:43:24 -0800 (PST)
Date: Wed, 24 Jan 2024 14:13:13 +0530
From: 'Manivannan Sadhasivam' <manivannan.sadhasivam@linaro.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, mturquette@baylibre.com,
	sboyd@kernel.org, jingoohan1@gmail.com, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
	linux@armlinux.org.uk, m.szyprowski@samsung.com,
	pankaj.dubey@samsung.com
Subject: Re: [PATCH v3 1/2] clk: Provide managed helper to get and enable
 bulk clocks
Message-ID: <20240124084313.GD4906@thinkpad>
References: <20240110110115.56270-1-shradha.t@samsung.com>
 <CGME20240110110156epcas5p36bac4093be0fa6eaa501d7eaed4d43d3@epcas5p3.samsung.com>
 <20240110110115.56270-2-shradha.t@samsung.com>
 <20240120150303.GB5405@thinkpad>
 <05ea01da4e92$0357d310$0a077930$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05ea01da4e92$0357d310$0a077930$@samsung.com>

On Wed, Jan 24, 2024 at 12:23:15PM +0530, Shradha Todi wrote:
> 
> 
> > -----Original Message-----
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Sent: 20 January 2024 20:33
> > To: Shradha Todi <shradha.t@samsung.com>
> > Cc: linux-clk@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> > pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-samsung-
> > soc@vger.kernel.org; mturquette@baylibre.com; sboyd@kernel.org;
> > jingoohan1@gmail.com; lpieralisi@kernel.org; kw@linux.com; robh@kernel.org;
> > bhelgaas@google.com; krzysztof.kozlowski@linaro.org;
> > alim.akhtar@samsung.com; linux@armlinux.org.uk;
> > m.szyprowski@samsung.com
> > Subject: Re: [PATCH v3 1/2] clk: Provide managed helper to get and enable bulk
> > clocks
> > 
> > On Wed, Jan 10, 2024 at 04:31:14PM +0530, Shradha Todi wrote:
> > > Provide a managed devm_clk_bulk* wrapper to get and enable all bulk
> > > clocks in order to simplify drivers that keeps all clocks enabled for
> > > the time of driver operation.
> > >
> > > Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> > > ---
> > >  drivers/clk/clk-devres.c | 41
> > ++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/clk.h      | 25 ++++++++++++++++++++++++
> > >  2 files changed, 66 insertions(+)
> > >
> > > diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c index
> > > 4fb4fd4b06bd..05b0ff4bc1d4 100644
> > > --- a/drivers/clk/clk-devres.c
> > > +++ b/drivers/clk/clk-devres.c
> > > @@ -102,6 +102,7 @@
> > EXPORT_SYMBOL_GPL(devm_clk_get_optional_enabled);
> > >  struct clk_bulk_devres {
> > >  	struct clk_bulk_data *clks;
> > >  	int num_clks;
> > > +	void (*exit)(int num_clks, const struct clk_bulk_data *clks);
> > >  };
> > >
> > >  static void devm_clk_bulk_release(struct device *dev, void *res) @@
> > > -182,6 +183,46 @@ int __must_check devm_clk_bulk_get_all(struct device
> > > *dev,  }  EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all);
> > >
> > > +static void devm_clk_bulk_release_all_enabled(struct device *dev,
> > > +void *res) {
> > > +	struct clk_bulk_devres *devres = res;
> > > +
> > > +	if (devres->exit)
> > > +		devres->exit(devres->num_clks, devres->clks);
> > > +
> > > +	clk_bulk_put_all(devres->num_clks, devres->clks); }
> > > +
> > > +int __must_check devm_clk_bulk_get_all_enabled(struct device *dev,
> > > +				  struct clk_bulk_data **clks, int *num_clks)
> > 
> > What is the user supposed to do with "num_clks" when you are already handling
> > the enable part?
> > 
> 
> Since the initial clk_bulk_get_all was returning the num_clks value, the thought was to maintain this
> as the user might want to have a check in their driver whether x number of clocks were successfully
> retrieved and enabled.
> 

IIUC, the returned clock count is only used for enabling or disabling the
clocks later. Since you are already handling it inside this API, I do not see a
necessity to return the count.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

