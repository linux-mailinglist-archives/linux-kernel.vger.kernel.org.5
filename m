Return-Path: <linux-kernel+bounces-149539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A45E18A9295
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BBA21F219E5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 05:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9385757334;
	Thu, 18 Apr 2024 05:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H+HFtCVV"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF2153AC
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 05:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713419237; cv=none; b=RCq6NvRMNBNQCgXa6Mdpu6qPTXxkEEOb7c5orrQmMskAM9FiwSKX73hZidw3y0643LRE0QNpYsAKBBgdmtnAEHoMHCVbGhePUrw4Pw2zJfgX4+L16J/+Cv3WMbgWxyDflr8aB6LDzm37yiwANa+ReT9jmjTVFBr2MUiELR6CSIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713419237; c=relaxed/simple;
	bh=Nan2Lzf74Vcrmmcjb06iRvfKVjD+6Nn1IcpeEKK8nyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wq7u5Vhof6+H5aWsQAQGCbz8vBwIZCwcRqEiMRSezxLKYfEWRZo8wvX1fLNrnjGS4ofkpwh6Su2aK2zBx6UfJQqsgwXW9tvsjjBfwWVBhQ3d1dgwA8/unY+NxOSh00YCiLBBM8m2VMMbM0Kja4lBDkjdGp8yBgRe19R9zUoBCms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H+HFtCVV; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ed5109d924so486443b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 22:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713419234; x=1714024034; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rJ0ucjqO681AGSVpzOzpFDV0+o+xgP7xumjdjPG5uGY=;
        b=H+HFtCVVQThhOw1Je7Y/iXYKJ/8KQd4LX1pCRTu5zu0MhuUuU3H20B0suXaz+Ews8S
         ecvLc2S4wL4vlh2uBbcBaCBc+0S3s2rZOeSuG0UhZYHSr6Yxc+KwVXvwsET09Xxl4bfT
         m9EAQdxgBu7rk4GhH+5VizC8qD97EMfG2yql4GxU29pHZ4ribq62/aMXh2KQmJTJloI9
         Qk0SnRjW0qo/b5ODFlJW/L+oTWr//yGfb92lpcezSjy6eOoTutMg4LalGdYnG02XqHZe
         4YxgPmZ0sjA8GInLKVdbtTPw0z4JP3uG97hTi6FkopfkNFIpXhq4gaE6g49HeShXLi0K
         dWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713419234; x=1714024034;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rJ0ucjqO681AGSVpzOzpFDV0+o+xgP7xumjdjPG5uGY=;
        b=RMVkXQlQj9Cqb+Zf37LsRZGIJB7KF7raC6bLZqPKGEgk2KdDxvM2oWjIiBMyvr369A
         nNdxZ5FnNwVMhgZclyChoz/oOMx7W6mZFA4nsIVJWm1chIIpOEOA6rM4aJNfHF+fbmFW
         2JHZxPJki1xmnTpl4OX/P7BjR2BVIJMfMoLDriHlL/lYYmiGff3vN5+ZHU9FO1sEyd0M
         e+gtMWHE0WKz632dC7wnzMKYeyP3QrjdJtiF/fu+Hcky3XVkcW/T/wvFGRrfvH6hljXW
         tsbibI+amkV13mXC6vUGx729DIHjWKaSDmCSX1stgT0Sk2tPo2TkJL8jK7uxqUv7gD02
         S2KQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsakfpPW9aRuD7R8n57U3rvtqoz2WvXbSkmPtY7RQZygPcC9djX11IvhorEd4Ei+dDyIy7tQcATDnOSA4GNSRj1qTr3/Mt5Y6KW/VN
X-Gm-Message-State: AOJu0Ywc5P4mVrsB/hz4TW1FnWu92fWPqPFqPB+Qr9RCZjCQZrcGxewB
	8Fdp52uEyWJPUQbV0vVy01ee2TGGx1UmjAj3AV4C9TczFLgvhCWJRR3wlthk/Q==
X-Google-Smtp-Source: AGHT+IG9No3vP9eUDX6SRaldDoIbhYetj8jaxmpj2g7yR2uDF76eNih7yDR/ywwqm0hXg8GeXnDkpg==
X-Received: by 2002:a05:6a21:2b13:b0:1a7:336c:555c with SMTP id ss19-20020a056a212b1300b001a7336c555cmr1890716pzb.60.1713419234473;
        Wed, 17 Apr 2024 22:47:14 -0700 (PDT)
Received: from thinkpad ([120.56.197.253])
        by smtp.gmail.com with ESMTPSA id f21-20020a17090a4a9500b002a058af5e12sm2347965pjh.12.2024.04.17.22.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 22:47:13 -0700 (PDT)
Date: Thu, 18 Apr 2024 11:17:08 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Make use of cached
 'epc_features' in pci_epf_test_core_init()
Message-ID: <20240418054708.GC2861@thinkpad>
References: <20240417-pci-epf-test-fix-v1-1-653c911d1faa@linaro.org>
 <ZiALuYlshLmwLhvu@ryzen>
 <ZiAM8Hp24XF8CyUJ@ryzen>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZiAM8Hp24XF8CyUJ@ryzen>

On Wed, Apr 17, 2024 at 07:54:56PM +0200, Niklas Cassel wrote:
> On Wed, Apr 17, 2024 at 07:49:45PM +0200, Niklas Cassel wrote:
> > On Wed, Apr 17, 2024 at 10:47:25PM +0530, Manivannan Sadhasivam wrote:
> > > Instead of getting the epc_features from pci_epc_get_features() API, use
> > > the cached pci_epf_test::epc_features value to avoid the NULL check. Since
> > > the NULL check is already performed in pci_epf_test_bind(), having one more
> > > check in pci_epf_test_core_init() is redundant and it is not possible to
> > > hit the NULL pointer dereference. This also leads to the following smatch
> > > warning:
> > > 
> > > drivers/pci/endpoint/functions/pci-epf-test.c:784 pci_epf_test_core_init()
> > > error: we previously assumed 'epc_features' could be null (see line 747)
> > > 
> > > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > Closes: https://lore.kernel.org/linux-pci/024b5826-7180-4076-ae08-57d2584cca3f@moroto.mountain/
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > I think you forgot:
> > Fixes: a01e7214bef9 ("PCI: endpoint: Remove "core_init_notifier" flag")
> > 
> > 
> > > ---
> > >  drivers/pci/endpoint/functions/pci-epf-test.c | 9 ++++-----
> > >  1 file changed, 4 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > index 977fb79c1567..0d28f413cb07 100644
> > > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > @@ -743,11 +743,10 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
> > >  	bool msi_capable = true;
> > >  	int ret;
> > >  
> > > -	epc_features = pci_epc_get_features(epc, epf->func_no, epf->vfunc_no);
> > > -	if (epc_features) {
> > > -		msix_capable = epc_features->msix_capable;
> > > -		msi_capable = epc_features->msi_capable;
> > > -	}
> > > +	epc_features = epf_test->epc_features;
> > 
> > How about:
> > 
> > index 977fb79c1567..4d6105c07ac0 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -735,7 +735,7 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
> >  {
> >         struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> >         struct pci_epf_header *header = epf->header;
> > -       const struct pci_epc_features *epc_features;
> > +       const struct pci_epc_features *epc_features = epf_test->epc_features;
> >         struct pci_epc *epc = epf->epc;
> >         struct device *dev = &epf->dev;
> >         bool linkup_notifier = false;
> > @@ -743,12 +743,6 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
> >         bool msi_capable = true;
> >         int ret;
> >  
> > -       epc_features = pci_epc_get_features(epc, epf->func_no, epf->vfunc_no);
> > -       if (epc_features) {
> > -               msix_capable = epc_features->msix_capable;
> > -               msi_capable = epc_features->msi_capable;
> > -       }
> > -
> >         if (epf->vfunc_no <= 1) {
> >                 ret = pci_epc_write_header(epc, epf->func_no, epf->vfunc_no, header);
> >                 if (ret) {
> > @@ -761,6 +755,7 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
> >         if (ret)
> >                 return ret;
> >  
> > +       msi_capable = epc_features->msi_capable;
> >         if (msi_capable) {
> >                 ret = pci_epc_set_msi(epc, epf->func_no, epf->vfunc_no,
> >                                       epf->msi_interrupts);
> > @@ -770,6 +765,7 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
> >                 }
> >         }
> >  
> > +       msix_capable = epc_features->msix_capable;
> >         if (msix_capable) {
> >                 ret = pci_epc_set_msix(epc, epf->func_no, epf->vfunc_no,
> >                                        epf->msix_interrupts,
> > @@ -814,11 +810,9 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
> >         void *base;
> >         enum pci_barno test_reg_bar = epf_test->test_reg_bar;
> >         enum pci_barno bar;
> > -       const struct pci_epc_features *epc_features;
> > +       const struct pci_epc_features *epc_features = epf_test->epc_features;
> >         size_t test_reg_size;
> >  
> > -       epc_features = epf_test->epc_features;
> > -
> >         test_reg_bar_size = ALIGN(sizeof(struct pci_epf_test_reg), 128);
> >  
> >         msix_capable = epc_features->msix_capable;
> > 
> > 
> > Instead?
> > 
> > That way, we assign msi_capable/msix_capable just before the if-statement
> > where it is used. (Which matches how we already assign msix_capable just
> > before the if-statement in pci_epf_test_alloc_space().)
> 
> ...or just kill the local variables:
> bool msi_capable/msix_capable in pci_epf_test_core_init(), and
> bool msix_capable pci_epf_test_alloc_space()
> and just do:
> 
> if (epc_features->msix_capable) / if (epc_features->msi_capable)
> 
> directly?
> 

Yeah, that will also work.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

