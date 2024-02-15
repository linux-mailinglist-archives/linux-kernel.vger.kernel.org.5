Return-Path: <linux-kernel+bounces-66983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67016856474
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BF9D1C21960
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A48130E52;
	Thu, 15 Feb 2024 13:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e2nnmTpY"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069D4130AEC
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 13:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708003933; cv=none; b=qkplfkDvF/XBZao5xR4qqXXiAdoAnlV/yA8GSLmTVKvykvuPtOT5jMlefpuRyOF+Hv1+45LoxhdNLeV96I3cRAZUgd1lOuXAB2F7sUohpKiJSTSczpetSXdcKAlvr698oLOblyp+lhdi3/uMpqxUOAOBSuSQ02dh0JtVlXSGZts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708003933; c=relaxed/simple;
	bh=m8hYdh+/UVrqtVPhk6AGLID+nWtFtpRf/uvN+uMW/6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qW2bASTxF5Y3t1rGia+JQzbe+PYsXLzHQ7htrlrNYQfnM0fO2A7Nm8iQuBFDwCLLdABaK1e4uTD+4AC4Knzg07oeYO4IRuKJ7enagiaHirbXhLhX80ILpzPbBZQP66NJPXCYCDsSzopSwEPUl6inD0pEg8HITOgAARFBIc47cB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e2nnmTpY; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-563d017696eso112896a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 05:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708003930; x=1708608730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=itPC4yjw+MZTTzalNg7Ob1FeA2iLjpKFIQ9B9VJV75g=;
        b=e2nnmTpYpaMea6mnpaWIiXu5yIg1UrDGSKXkeRzKMDt4SsnMlgMgaDWhNt9bIq77m5
         OC32/A6KKguXvLbuatMyWRD3CSyImw7RGsxYiVKuK/w/H1Ffs4pXdKdEEFxx8PDTCTuo
         624Y6m9uGHmwfBxfMe45Bz1K+VoakhATvQjg6RlkebMZH2XSp680OyYpqNCwBcECd9BB
         LK2noxnvwLyH7SSupf3YvVZaCT5fwmMEFYmftZT5R7LNhzd9YbpqmV4gtsoukchq6z5E
         c3oZw2xU0johSl178KKpnmqdj6zUvBMyfatigK97RAsPV4RpVSFGUjHT5GOgBk2yoWzX
         HJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708003930; x=1708608730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itPC4yjw+MZTTzalNg7Ob1FeA2iLjpKFIQ9B9VJV75g=;
        b=C/aUbKofMtsesbaHDwyuN+D3afb2q0x/XYx4riQUo3eNm5bbKWMS2aGcnnoicKh6Jb
         STKGTbUNvY0w9AAMQCoMmL9EiKMHrTg9bTaXNd8JwAbA1Uw4uXURycpGzFo3MIRL/Qmh
         UT/SljDQCT1NXu02HW4y33sJOK2ga3P+WWrd0YKZwZPdSzsKanhHKiohwORwXNdQMo+j
         au+HrRaKypfUXjhqNS2eROPlqQl0ZHFfb+W93dRehp5r2NJ9yxkHDsHr2gBgZZHAKuvK
         G6jjMGR/o+F0U+DUxhy6RgttjHHyxJeMrCFoYBw+qAUSxS0VZhtCrfRhjPviARjYFsN6
         1qeg==
X-Forwarded-Encrypted: i=1; AJvYcCVo6fChHGma/dIc5OvqJwjagMxlqUW6YeojmGtlXrSkLXMMZszvZMxhkPf4mXPPn/e/uQXLbQ/868tWBv3s6plQIIcyKRbQrFkPDfJe
X-Gm-Message-State: AOJu0YzsYD1e75mTKqbI9IuwxrsSWPjiAr5J1v3M/S0ECMRrjKBnhGXt
	ogdSrzsLThRcRYSvEG9P9MeMdgfugwHzUtf9XKfcQ0L1yxJDuSE+u5UhBP0NR8b3No3LtTTcbHZ
	H
X-Google-Smtp-Source: AGHT+IE7pGrmIuos0u7FslcOP5vVFjySkiA6nt4+X/E67cQyceQ3AtGt6cC5RO+cNGVYo8uyVRvA8w==
X-Received: by 2002:a05:6402:287:b0:561:4238:e6d3 with SMTP id l7-20020a056402028700b005614238e6d3mr1513003edv.2.1708003930158;
        Thu, 15 Feb 2024 05:32:10 -0800 (PST)
Received: from linaro.org ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id p3-20020a05640243c300b00563c22abac2sm228295edc.61.2024.02.15.05.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 05:32:09 -0800 (PST)
Date: Thu, 15 Feb 2024 15:32:08 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH RFC v3 3/4] spmi: pmic-arb: Make core resources acquiring
 a version operation
Message-ID: <Zc4SWIViTS0uf952@linaro.org>
References: <20240214-spmi-multi-master-support-v3-0-0bae0ef04faf@linaro.org>
 <20240214-spmi-multi-master-support-v3-3-0bae0ef04faf@linaro.org>
 <d9d8e86b-a499-49d1-90ad-6fae5b7dcbb7@linaro.org>
 <Zc0yXR/fC2OcObLB@linaro.org>
 <CAA8EJpq=kYeZfNbFtfQ_oLS0Xi4imyEGV+dDNO+h6LZfqmpxZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpq=kYeZfNbFtfQ_oLS0Xi4imyEGV+dDNO+h6LZfqmpxZg@mail.gmail.com>

On 24-02-15 11:30:23, Dmitry Baryshkov wrote:
> On Wed, 14 Feb 2024 at 23:36, Abel Vesa <abel.vesa@linaro.org> wrote:
> >
> > On 24-02-14 22:18:33, Konrad Dybcio wrote:
> > > On 14.02.2024 22:13, Abel Vesa wrote:
> > > > Rather than setting up the core, obsrv and chnls in probe by using
> > > > version specific conditionals, add a dedicated "get_core_resources"
> > > > version specific op and move the acquiring in there.
> > > >
> > > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > > ---
> > > >  drivers/spmi/spmi-pmic-arb.c | 111 ++++++++++++++++++++++++++++++-------------
> > > >  1 file changed, 78 insertions(+), 33 deletions(-)
> > > >
> > > > diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
> > > > index 23939c0d225f..489556467a4c 100644
> > > > --- a/drivers/spmi/spmi-pmic-arb.c
> > > > +++ b/drivers/spmi/spmi-pmic-arb.c
> > > > @@ -203,6 +203,7 @@ struct spmi_pmic_arb {
> > > >   */
> > > >  struct pmic_arb_ver_ops {
> > > >     const char *ver_str;
> > > > +   int (*get_core_resources)(struct platform_device *pdev, void __iomem *core);
> > > >     int (*init_apid)(struct spmi_pmic_arb *pmic_arb, int index);
> > > >     int (*ppid_to_apid)(struct spmi_pmic_arb *pmic_arb, u16 ppid);
> > > >     /* spmi commands (read_cmd, write_cmd, cmd) functionality */
> > > > @@ -956,6 +957,19 @@ static int pmic_arb_init_apid_min_max(struct spmi_pmic_arb *pmic_arb)
> > > >     return 0;
> > > >  }
> > > >
> > > > +static int pmic_arb_get_core_resources_v1(struct platform_device *pdev,
> > > > +                                     void __iomem *core)
> > > > +{
> > > > +   struct spmi_pmic_arb *pmic_arb = platform_get_drvdata(pdev);
> > > > +
> > > > +   pmic_arb->wr_base = core;
> > > > +   pmic_arb->rd_base = core;
> > > > +
> > > > +   pmic_arb->max_periphs = PMIC_ARB_MAX_PERIPHS;
> > > > +
> > > > +   return 0;
> > > > +}
> > > > +
> > > >  static int pmic_arb_init_apid_v1(struct spmi_pmic_arb *pmic_arb, int index)
> > > >  {
> > > >     u32 *mapping_table;
> > > > @@ -1063,6 +1077,41 @@ static u16 pmic_arb_find_apid(struct spmi_pmic_arb *pmic_arb, u16 ppid)
> > > >     return apid;
> > > >  }
> > > >
> > > > +static int pmic_arb_get_obsrvr_chnls_v2(struct platform_device *pdev)
> > > > +{
> > > > +   struct spmi_pmic_arb *pmic_arb = platform_get_drvdata(pdev);
> > > > +   struct device *dev = &pdev->dev;
> > > > +   struct resource *res;
> > > > +
> > > > +   res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> > >
> > > It's no longer indented to deep, no need to keep such aggressive wrapping
> > >
> >
> > The pmic_arb_get_obsrvr_chnls_v2 is used by both:
> > pmic_arb_get_core_resources_v2
> > pmic_arb_get_core_resources_v7
> >
> > > > +                                      "obsrvr");
> > > > +   pmic_arb->rd_base = devm_ioremap(dev, res->start,
> > > > +                                    resource_size(res));
> > > > +   if (IS_ERR(pmic_arb->rd_base))
> > > > +           return PTR_ERR(pmic_arb->rd_base);
> > > > +
> > > > +   res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> > > > +                                      "chnls");
> > > > +   pmic_arb->wr_base = devm_ioremap(dev, res->start,
> > > > +                                    resource_size(res));
> > > > +   if (IS_ERR(pmic_arb->wr_base))
> > > > +           return PTR_ERR(pmic_arb->wr_base);
> > >
> > > Could probably make it "devm_platform_get_and_ioremap_resource "
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
> If there were no DT files which used two SPMI devices, I think we
> should drop this comment and use existing helpers. We must keep
> compatibility with the existing DTs, not with the _possible_ device
> trees.

Sure.

Should I drop the qcom,bus-id from the driver as well? It is optional
after all.

> 
> >
> > >
> > > Konrad
> 
> 
> 
> -- 
> With best wishes
> Dmitry

