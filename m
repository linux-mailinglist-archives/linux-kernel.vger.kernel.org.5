Return-Path: <linux-kernel+bounces-49488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4C6846B02
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FC87B21386
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257AE633E5;
	Fri,  2 Feb 2024 08:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xVc5INHk"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68753626D2
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863326; cv=none; b=dJGT5l7rVAJ5SdzRgb+j4l2+ouYZTsnHfa/jlH75AdNN01xh3ZNlWY4BEYcuECNDaBvhMq6s1fy+byalpCJ5GyFrN9jZW/UyFLLL+0FVRd2FVtoyj7GgX64aeecZO7aShq69J7Kv8CXIz25o2Swr+rXBgbZELHNF7fxtyrucV+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863326; c=relaxed/simple;
	bh=ZDgYBSdHUqvVtgWwNERWyROBmahpZQM352YbvD82Z2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eN4sQvuNBZpMld8sHL9iz05VzM6mFZ+rhUMIQaovNz3gWrDoc8akxcO7oqu2zwR0U8hv0i0J/EIRGwij24Os7mcH2y3jhhSeGLIp/l2Ndv+3ufVXYRJCyCaOAHtkdCne6BcgoDbtTSr3EIxGWKgXGZiFbF90xVBs9YGbuluE7gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xVc5INHk; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d7881b1843so15395085ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 00:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706863323; x=1707468123; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oA9Pz0U+zB8iLdA+DZx7A8mWXGcixcYAfyaOM28M5MA=;
        b=xVc5INHkXghJc/SCsXdXXmh/HUF4b214j83rZpmPChyvS3I0x5mXXAWhhIMG26PdZo
         H9pPbvsKR+ACL+Eewx7Bw1AhMJuueVx/z0E9mEEgM2UMvsXybj/EgRksiwHwripdx9ma
         uspup77M31+3iiIFK61+45D4ue4emC8laOXLQP95Jwrr68GOeIB6791BO/5ocOkopRBC
         BT6Y126q4PTWfmgjT3/3IzLhchX/3OnG/ZCIOcOC49tixDA0jtpjMxksIcH24m2VN+6H
         kOgQTmJMcK8tqT6hDp0Wd3mAL0VfxMXg2gGzZYlBMaBYSdStmMnF7uXwtI1LaMOgmhIc
         4ELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706863323; x=1707468123;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oA9Pz0U+zB8iLdA+DZx7A8mWXGcixcYAfyaOM28M5MA=;
        b=iTklhGzBrrGXs7s4XhR3phjF9LSmiKIS+OAfbcxhXaDyQc4NV36kC7fXuh+5vp31qw
         OlQcoRULvSAuYZchSaotFsoVR6YcJJOsvOdXT5tj7NouhCdtc1ra12c2JUVtpQK2yHMD
         T4PzWkfc5ZOj3enLzNb3H858r5Imj4C576/cx+z8Tnyw6sGONou1ZjEi+SoRej3fm0c8
         1yoeoG99H0FTdUYQqrm3L33lLoeo/xqbTHvmX5NP+Bj77mgMpfzQbgJzOM7rpYkloDnU
         yYsULJXjjvfuksaYgc5jP0vHKB2BAlbczP7BfqHsfe2F+y0n98VRWSNg7IyIVcIOTpXf
         6tnQ==
X-Gm-Message-State: AOJu0Yz3q7fCYiGV87C3aYn/lJA3drWeJCnm/F3mqSwQIRsADN4GJao7
	PIpZTajoxRrQMIyDmoc5pYPd2nwoF3IeHJtHrjpdsOabJkCT2GRd3s7KVwc1vyS9njIWSiXEHEI
	=
X-Google-Smtp-Source: AGHT+IGjNFKpCQgBo+OS5e/hYX7NUDiUJBBwnBMuf/w5Bw9mgn5cpJPNFXMTL5wo8VwT1mhLsYYROg==
X-Received: by 2002:a17:902:bd97:b0:1d8:d58d:7ea1 with SMTP id q23-20020a170902bd9700b001d8d58d7ea1mr1376090pls.59.1706863323641;
        Fri, 02 Feb 2024 00:42:03 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWq/9URP6zPVWfFFUuvFYv/ZCeW6HuWTDYwWvOv9TNAZicvX9spBshq8COdLfWC3fFJQIiyOha32SnPF6C35e35Rh0fs9wKXkwDTfSd2AEgYp6HpGsxsoRL0wjtOfO5bFN1ubpxx0ozxCLPoC7ExO/s04oHzRSCqehY/sge7FMer2ayFITkmAowOmytUzEbxLhQYvnc7WOm/rcSXwRe5gVUs0k+Dh9sAIC//kaYvinhlodo0rwLUSVHZ0mzxIhbVTNMNPRoMerkmcZNjRPEVfJOJM2fZIR9fJ2kBwaG1K2Fc5NUiWJfCykeXUair+cJ38Hkhw/JARTjCUEMX3lj
Received: from thinkpad ([120.56.198.122])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902ce8700b001d8f81ecebesm1064741plg.192.2024.02.02.00.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 00:42:03 -0800 (PST)
Date: Fri, 2 Feb 2024 14:11:57 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: neil.armstrong@linaro.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: qcom: Add X1E80100 PCIe support
Message-ID: <20240202084157.GE2961@thinkpad>
References: <20240129-x1e80100-pci-v2-0-a466d10685b6@linaro.org>
 <20240129-x1e80100-pci-v2-2-a466d10685b6@linaro.org>
 <30360d96-4513-40c4-9646-e3ae09121fa7@linaro.org>
 <a0034c34-4af7-4733-93f7-f82f665f36f3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0034c34-4af7-4733-93f7-f82f665f36f3@linaro.org>

On Fri, Feb 02, 2024 at 09:13:25AM +0100, neil.armstrong@linaro.org wrote:
> On 01/02/2024 20:20, Konrad Dybcio wrote:
> > On 29.01.2024 12:10, Abel Vesa wrote:
> > > Add the compatible and the driver data for X1E80100.
> > > 
> > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > ---
> > >   drivers/pci/controller/dwc/pcie-qcom.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > index 10f2d0bb86be..2a6000e457bc 100644
> > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > @@ -1642,6 +1642,7 @@ static const struct of_device_id qcom_pcie_match[] = {
> > >   	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &cfg_1_9_0 },
> > >   	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
> > >   	{ .compatible = "qcom,pcie-sm8550", .data = &cfg_1_9_0 },
> > > +	{ .compatible = "qcom,pcie-x1e80100", .data = &cfg_1_9_0 },
> > 
> > I swear I'm not delaying everything related to x1 on purpose..
> > 
> > But..
> > 
> > Would a "qcom,pcie-v1.9.0" generic match string be a good idea?
> 
> Yes as fallback, this is why I used qcom,pcie-sm8550 as fallback for SM8650.
> 

Right. Fallback should be used here also.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

