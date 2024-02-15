Return-Path: <linux-kernel+bounces-66533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE48855E00
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E54D1289901
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A3C1AAB1;
	Thu, 15 Feb 2024 09:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hTzLhped"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FA3175BD
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989214; cv=none; b=ZFKFE1l9jPwYCkkDrVRRvo91e9HuIzYA4JI8cwJpnIwHzvWwwLCLjXKFHMLQ0Fx/oKgEOy2vAuWHfPxox/8Jg7tt8qyEBGLcjDKv2JwoNxcFDKq3QASZWB+cEkpaXFpx9PYVZtde+wxQv6diRXkcMsDlsAqdOxqh/ll0uo7XrpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989214; c=relaxed/simple;
	bh=ecamQUc576R0epdKqjkRQszTyH7lrl46ZIPoPGR3oZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZwYD82fSGFMkXUCSzJDsa9xDbIsPSi/iSsr8BpBwL5CDhLlNBJIYZ26UWAtZU4ve4TaRLmB0bsmLDqt8GjIJsAg9UOJLXj+BVJNQ0KaZBU4V106j0vQo3fO+lpqPPoD94CxNL9STFVN4Hz41XTF5tPdVWDgKWHXXPPiBihMT+1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hTzLhped; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5610cc8cc1aso683717a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 01:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707989211; x=1708594011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w5KcKTaCQn4pBwWr+P+bPuhSGEvM0dqpC2FO7BYBz7I=;
        b=hTzLhpedxfvPm1+XZ+qDyo5GhvYoiebAWFD+PwrKQtJsfSGftXBPOBnvX9pvGMW744
         FPRJNskhWd3BDdMXknCi2C+Q1tHJxlaJ9BfJlgE3XWsel5TtrNoz2N0fF1UGI4OEqPr2
         dw2uBSwRhENB+FVhAfFEqIVYqo4H+KuTQskYqbBrpAiv7Pjq+DvREFsrYjaOvT4HoF70
         bODEYujb55T0FvmXWOyynubpLOsMcfMxKjpG3LPOio1/Hzor/YPXSRaeCJuWI4CtXjYC
         zS6YF5yyoPKE+sVS9KUr+ktX8JD3mh0gJ2Feoi3a44j68xqE0FF79wCyqBLNt9dDdeD2
         KpwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707989211; x=1708594011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5KcKTaCQn4pBwWr+P+bPuhSGEvM0dqpC2FO7BYBz7I=;
        b=omVKL8p/M/V0QG6YvMzWiw7PFiAhPRufwAZKtBSXGg1Efj/b5vMOCcpQdNwNVC78KD
         H0jdDhu5CBxfLOc87mI9gwptAom1EnMtH/dPOWcZAD5piQuq4JI0qrci6nfGd0aiR4A4
         N1mGlA38n4nLXckhrjEjDCWS4nfns0zcHXUJVWJfsCjD90Su0CXpgg9HvlIq7akKtwBt
         NNAp6PNKeiQ6iXynTTh8ZPdqYh5ZvkeWPc/EPm4ZAdLGjPxaclg7/UX1u5ofSA4vQ3B4
         BMEbhTU2nODREpebYt9O+FwOk3UabYqH2o9AzLMoA6N0T0wlr/zE9kEB/5kWFxIxxhDG
         fWhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwhjosNzQdYFZ3JmZYvpkzo/wnPYv+6I7bvdO0I4uq1gXtLSxmoYYWSubZq8K3LnfZewqU1DsWDPsFZ2FT3yFgdeqaozGblS2/eVQr
X-Gm-Message-State: AOJu0YxMDoj/7q+rIijIcpL6yM7xn+MuHVp0uqHxf4kmkW/yWa2ZIrhb
	OaADC3o9nkBde2cwIBGJ9QOuI5ZdBys28OL5lMw119lqZ0OQx6l/vrrn7qgfLQD2WPvAktElfOC
	p
X-Google-Smtp-Source: AGHT+IEoMFpPFkQ98MpNIYsjxXySN2OmKZ5WeYtjXYVrEAtCkS8teqIlHftZm4rd0q8pEldzBbNu4g==
X-Received: by 2002:a17:906:5f89:b0:a3d:5e44:83aa with SMTP id a9-20020a1709065f8900b00a3d5e4483aamr848262eju.20.1707989211294;
        Thu, 15 Feb 2024 01:26:51 -0800 (PST)
Received: from linaro.org ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id bq14-20020a170906d0ce00b00a3d2157e267sm360824ejb.11.2024.02.15.01.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 01:26:50 -0800 (PST)
Date: Thu, 15 Feb 2024 11:26:49 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH RFC v3 3/4] spmi: pmic-arb: Make core resources acquiring
 a version operation
Message-ID: <Zc3Y2YmjZ1gYjmmq@linaro.org>
References: <20240214-spmi-multi-master-support-v3-0-0bae0ef04faf@linaro.org>
 <20240214-spmi-multi-master-support-v3-3-0bae0ef04faf@linaro.org>
 <d9d8e86b-a499-49d1-90ad-6fae5b7dcbb7@linaro.org>
 <Zc0yXR/fC2OcObLB@linaro.org>
 <5e878fd9-8215-499d-ac1c-191cb5bfe798@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e878fd9-8215-499d-ac1c-191cb5bfe798@linaro.org>

On 24-02-14 22:44:55, Konrad Dybcio wrote:
> On 14.02.2024 22:36, Abel Vesa wrote:
> > On 24-02-14 22:18:33, Konrad Dybcio wrote:
> >> On 14.02.2024 22:13, Abel Vesa wrote:
> >>> Rather than setting up the core, obsrv and chnls in probe by using
> >>> version specific conditionals, add a dedicated "get_core_resources"
> >>> version specific op and move the acquiring in there.
> >>>
> >>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> >>> ---
> >>>  drivers/spmi/spmi-pmic-arb.c | 111 ++++++++++++++++++++++++++++++-------------
> >>>  1 file changed, 78 insertions(+), 33 deletions(-)
> >>>
> >>> diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
> >>> index 23939c0d225f..489556467a4c 100644
> >>> --- a/drivers/spmi/spmi-pmic-arb.c
> >>> +++ b/drivers/spmi/spmi-pmic-arb.c
> >>> @@ -203,6 +203,7 @@ struct spmi_pmic_arb {
> >>>   */
> >>>  struct pmic_arb_ver_ops {
> >>>  	const char *ver_str;
> >>> +	int (*get_core_resources)(struct platform_device *pdev, void __iomem *core);
> >>>  	int (*init_apid)(struct spmi_pmic_arb *pmic_arb, int index);
> >>>  	int (*ppid_to_apid)(struct spmi_pmic_arb *pmic_arb, u16 ppid);
> >>>  	/* spmi commands (read_cmd, write_cmd, cmd) functionality */
> >>> @@ -956,6 +957,19 @@ static int pmic_arb_init_apid_min_max(struct spmi_pmic_arb *pmic_arb)
> >>>  	return 0;
> >>>  }
> >>>  
> >>> +static int pmic_arb_get_core_resources_v1(struct platform_device *pdev,
> >>> +					  void __iomem *core)
> >>> +{
> >>> +	struct spmi_pmic_arb *pmic_arb = platform_get_drvdata(pdev);
> >>> +
> >>> +	pmic_arb->wr_base = core;
> >>> +	pmic_arb->rd_base = core;
> >>> +
> >>> +	pmic_arb->max_periphs = PMIC_ARB_MAX_PERIPHS;
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>>  static int pmic_arb_init_apid_v1(struct spmi_pmic_arb *pmic_arb, int index)
> >>>  {
> >>>  	u32 *mapping_table;
> >>> @@ -1063,6 +1077,41 @@ static u16 pmic_arb_find_apid(struct spmi_pmic_arb *pmic_arb, u16 ppid)
> >>>  	return apid;
> >>>  }
> >>>  
> >>> +static int pmic_arb_get_obsrvr_chnls_v2(struct platform_device *pdev)
> >>> +{
> >>> +	struct spmi_pmic_arb *pmic_arb = platform_get_drvdata(pdev);
> >>> +	struct device *dev = &pdev->dev;
> >>> +	struct resource *res;
> >>> +
> >>> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> >>
> >> It's no longer indented to deep, no need to keep such aggressive wrapping
> >>
> > 
> > The pmic_arb_get_obsrvr_chnls_v2 is used by both:
> > pmic_arb_get_core_resources_v2
> > pmic_arb_get_core_resources_v7
> 
> I meant line wrapping

Oh, ok. Will do.

> 
> > 
> >>> +					   "obsrvr");
> >>> +	pmic_arb->rd_base = devm_ioremap(dev, res->start,
> >>> +					 resource_size(res));
> >>> +	if (IS_ERR(pmic_arb->rd_base))
> >>> +		return PTR_ERR(pmic_arb->rd_base);
> >>> +
> >>> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> >>> +					   "chnls");
> >>> +	pmic_arb->wr_base = devm_ioremap(dev, res->start,
> >>> +					 resource_size(res));
> >>> +	if (IS_ERR(pmic_arb->wr_base))
> >>> +		return PTR_ERR(pmic_arb->wr_base);
> >>
> >> Could probably make it "devm_platform_get_and_ioremap_resource "
> > 
> > The reason this needs to stay as is is because of reason explained by
> > the following comment found in probe:
> > 
> > /*                                                                           
> >  * Please don't replace this with devm_platform_ioremap_resource() or        
> >  * devm_ioremap_resource().  These both result in a call to                  
> >  * devm_request_mem_region() which prevents multiple mappings of this        
> >  * register address range.  SoCs with PMIC arbiter v7 may define two         
> >  * arbiter devices, for the two physical SPMI interfaces, which  share       
> >  * some register address ranges (i.e. "core", "obsrvr", and "chnls").        
> >  * Ensure that both devices probe successfully by calling devm_ioremap()     
> >  * which does not result in a devm_request_mem_region() call.                
> >  */                                                                          
> > 
> > Even though, AFAICT, there is no platform that adds a second node for
> > the second bus, currently, in mainline, we should probably allow the
> > "legacy" approach to still work.
> 
> OK right, let's keep it.
> 
> Konrad

