Return-Path: <linux-kernel+bounces-46461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C42D84400D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD602295D6B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE997AE68;
	Wed, 31 Jan 2024 13:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pMZn55e9"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C227762DD
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 13:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706706396; cv=none; b=YPyS1qsnymKCGUdQVQy9yGsY9WtZ9yMAP4uqmK4UnZb5OK79ZFSVrqkFQjwoGqlwy8dWFbOkV4gkyEK1AUQBmvIlFO4OZ6Ugx58A6KgPX9H558g91HL0gsj1dy/9FePxvxXCVc6Kkjuc7ZV0+BVlUIvXzQTr2wxjdhwsuLfXv6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706706396; c=relaxed/simple;
	bh=UWd6hxmzjst2tmlJYuu/wEkr38i7qrWlsq1SqRUtK1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZJyHi6g5rq7OGLH5YKDLw7Gxhn4Ba6JtsiHE1++PMyEOe1MvsoAihfKdb5miNVluENweCv8wRZU4oyRnFs36tBReAYVlZziqYyHGz53IC6xJum2FHk8FDldfMWsYMTNKv5VcFWoQoePrSAUS7ZUcb56fYUKLzUQ01FfFwA0dS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pMZn55e9; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6e132fef7baso1498778a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 05:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706706394; x=1707311194; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pT4FU5pRnshAjRYitOLrEWUECqNIReMX/bO9hZqR15Y=;
        b=pMZn55e96zZ1erZT3/BBvYNh0Z/gkSO+OljHIj2HEiW91G7jXNfPCYZk/+2Nb1VhwL
         /I9WSm6KezPm2kd2Jm8weXyRqNqSYSUMvKapbQAXfp6t5DmXpoIZSnFpuTPRxBuQy02b
         TgPeLh1w92sLvvCKqom+eUbT/JPffWQ60KMxC2O+kteuE44ddxG7KmAIpsxEFI1x1q6f
         V3pCGIbvOjsjL6NQjP4tlek1wOu8fu6TmnQ1FUn0ifJgovYGClqX6+tKzJggDGt8eoIS
         fN/IKbtM+VFbC8iReEUmeMYRGDJaAaG1JixeDGnX4zXmqfSMlPodhPf/SopHuY90NmuT
         3ZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706706394; x=1707311194;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pT4FU5pRnshAjRYitOLrEWUECqNIReMX/bO9hZqR15Y=;
        b=O+irfDTd6SbTnra/A2tSndL2fY1Iwg3A3j6CCM5S259yvrmaIWPbcPAMt9dAOoEgzA
         Kh+E0fp8N9W7DlVVxHX0KvndWIKNw4FI/uQKBVf/RpF4D3Yv8efL1JE9Y6P8IqSL0Esy
         dRWw1aXOhsBJWpJnR2RAvHAA0yDR1HcktccHgR2FwKlcyGzDdaI8Gh8Sr3Vb3v3LtDgA
         hHFMrz5Qs+Yq8yGqvPL/moiY/l097qYcfiaSTtsXCeZOi5zByO2TwXE0UnBD8ZnjXD6m
         38r/xm0/FjHPmsOVQMEwBom25yb9hgr2SR/OxibfUaGCr7aB47KSTij3fCSbGtmwgK8B
         Cxpw==
X-Gm-Message-State: AOJu0YybKUbo99WcqapGtq108aTwf/d9DOKW0oXoxyecRD9+vmbFsEIO
	8rfieTBR2fHfrw2RVAxdVlFxMTN12Qg+S9oFK+tyNUa+trNeARb+R0AIQZAddw==
X-Google-Smtp-Source: AGHT+IHEvuTXeoIZkbi5Q32g6UFdTGDY2fx6KtFvOEjO6m0fOI9Fr33QQfHBO13SONWpgqrwaivohw==
X-Received: by 2002:a9d:4e95:0:b0:6e1:3d4b:4b27 with SMTP id v21-20020a9d4e95000000b006e13d4b4b27mr1417284otk.27.1706706394166;
        Wed, 31 Jan 2024 05:06:34 -0800 (PST)
Received: from thinkpad ([117.248.7.45])
        by smtp.gmail.com with ESMTPSA id lh10-20020a05621454ca00b0068c5eb56dc9sm1705667qvb.63.2024.01.31.05.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 05:06:33 -0800 (PST)
Date: Wed, 31 Jan 2024 18:36:28 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Step down as PCI ENDPOINT maintainer
Message-ID: <20240131130628.GB5273@thinkpad>
References: <20240129165933.33428-1-lpieralisi@kernel.org>
 <20240130195501.GA562748@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240130195501.GA562748@bhelgaas>

On Tue, Jan 30, 2024 at 01:55:01PM -0600, Bjorn Helgaas wrote:
> On Mon, Jan 29, 2024 at 05:59:33PM +0100, Lorenzo Pieralisi wrote:
> > The PCI endpoint subsystem is evolving at a rate I
> > cannot keep up with, therefore I am standing down as
> > a maintainer handing over to Manivannan (currently
> > reviewer for this code) and Krzysztof who are doing
> > an excellent job on the matter - they don't need my
> > help any longer.
> > 
> > Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Cc: Krzysztof Wilczyński <kw@linux.com>
> 
> Happy to merge this, and would be good to include your ack, Mani.
> Would hate to sign you up for more work unless you're expecting it :)
> 

It's my pleasure :) Thanks, Bjorn!

- Mani

> > ---
> >  MAINTAINERS | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 8d1052fa6a69..a40cfcd1c65e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -16856,9 +16856,8 @@ F:	Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> >  F:	drivers/pci/controller/pcie-xilinx-cpm.c
> >  
> >  PCI ENDPOINT SUBSYSTEM
> > -M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
> > +M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >  M:	Krzysztof Wilczyński <kw@linux.com>
> > -R:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >  R:	Kishon Vijay Abraham I <kishon@kernel.org>
> >  L:	linux-pci@vger.kernel.org
> >  S:	Supported
> > -- 
> > 2.34.1
> > 

-- 
மணிவண்ணன் சதாசிவம்

