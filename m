Return-Path: <linux-kernel+bounces-59138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0E984F1CE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D6411C239B5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BB6664B5;
	Fri,  9 Feb 2024 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YyxwCu+G"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66922339AE
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 08:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707468977; cv=none; b=W09uHBX/h84xj3d9tsoy4dIRi59aSU5hvPLfYn0VWV5Onfxw1owslkEzP4VZjPXEV4PZ9xbIsFfCrUY9e+HD+aJ//IXflcKTP7sGnykALLTg2KlqZJFtM6QrXU6l+N1wSKFywfxYGi2EXSlTXVyXv8PjyN1M9iedsm0B4kfj36E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707468977; c=relaxed/simple;
	bh=Tsk3+SWBU2wtfCviD1D0EIgRdEZr+tyO/cWXmkE5rdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mzb2evgOnagJ9Jam098iHl96jW7AkxixdC7wTS/vkDZhxrJCZrEcQ/djgYrFc5taNY5xyWzFngOdYKfiw8x2PY5qJ4ESaWNw7rL5bYkxMutMttlGMkI+nXu4JmJOYuC1S4Nf2y7UQ8F7TiBSr8ixg5Ji0vml/X3b714BqWGFm14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YyxwCu+G; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e04fd5e05aso533358b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 00:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707468976; x=1708073776; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3lo5xA9QhcQnRR0TlF3RgqNJRfAbqwqu9OwhqreO4As=;
        b=YyxwCu+GBUaC4A1qvR/zkHQB+N01lCm7KwX6grdgQdUk6ecDmnfEfMbFceuHPQwXq7
         IgmsE/Eu6y3SfSbfPUkXP+Kpm8qWpjjomWu/bS9KyvVffRuCnO4shUFY8CZXLQY1HDzM
         9eMJqOWWv/U9kaoPQO4xNhGQfY03IGan00CXfqD96Nx3NoDz/+zb/WGe1OEENkUBYFA2
         O/8i2gWx7w7L0l4l8bfjL7s0WH4iSZUt1ME4N51GRuMmZVGIh0TP1aCkKEkFSRRfLKEZ
         Yw73erWaAFEhpaaUbfpIy5HgzIFUb7jwsbUTjPPZ+l6IkQar0bB6exUEPYOdM+pq1goJ
         RXHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707468976; x=1708073776;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3lo5xA9QhcQnRR0TlF3RgqNJRfAbqwqu9OwhqreO4As=;
        b=d3F88W+cLsDZpIJtBthy6wWFoYUKc+JGk1hDSBWT+lPCo7jtL+BRbG689jzZv0NiUM
         N+00JpkZz9ylXey5+x1Xm4oKcfS2/uHl7oM5H5qp3GZfl1ybrVkHwT8H0R3vr4RJYJpB
         oGd954b4EJPQWVEijgiN0qZ+fAyim7TLP9dOGT9bqXz+KEpmbjSweWixImJ78xreb7od
         fReLzvIUwr0PTxi+xBgL+gib7l1Okhc4lc66ZyWljd53tfqGQTIDImY6/GBVvLEdFcz2
         QJbbTdbmZXJDtrkMjd07JS6PKRuexHxc9Rj56/U97yUtOgSXfTotpMIaNSgmtcRaAz2g
         jFRw==
X-Gm-Message-State: AOJu0Ywcd2WW6vOBo4x/ThdTAgOrgER1kzM8mZi4pUMz/3R4IscxCWKh
	7K0OF/npXK9LaKy9qmp8d+tgbICLLil/KmePYlRwugARkuUizeoN7/HwZ2bBpA==
X-Google-Smtp-Source: AGHT+IEXsA9uACLUeyN8xPmf8XG/8zUXkMIT0ahSD4Po+zfV0lmB1Kjq8X5WYnzQm7sT8g8xordHFA==
X-Received: by 2002:a05:6a00:92a2:b0:6e0:50cb:5f0a with SMTP id jw34-20020a056a0092a200b006e050cb5f0amr523099pfb.12.1707468975686;
        Fri, 09 Feb 2024 00:56:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVJAz69nCCB+96fo5TstLe7LOYwqTtw/dUxesoLLYPclY9CaH4H9q4NKLFKzwHuTTt7xbQGNcVpz+J53U8mdgNPqbAMRL/yv0INmsubL/Ys2DA9uf7Fn0VYHS8TuBoOIEHvGV7062M7CytL6NMHTfBPSf9xn6+ylhrJw8KJDqMZBOAHTn9iU+2QU/Bz9PSn3DF0ySFGTV6G6Kxf2L5JZTDCIQ==
Received: from thinkpad ([120.138.12.20])
        by smtp.gmail.com with ESMTPSA id d16-20020a056a00199000b006e0427b57e8sm1134443pfl.4.2024.02.09.00.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 00:56:15 -0800 (PST)
Date: Fri, 9 Feb 2024 14:26:11 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH] MAINTAINERS: Step down as PCI ENDPOINT maintainer
Message-ID: <20240209085611.GG12035@thinkpad>
References: <20240129165933.33428-1-lpieralisi@kernel.org>
 <20240131150116.GA585251@bhelgaas>
 <Zb2RVNkL+AkvqXWq@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zb2RVNkL+AkvqXWq@lizhi-Precision-Tower-5810>

On Fri, Feb 02, 2024 at 08:05:24PM -0500, Frank Li wrote:
> On Wed, Jan 31, 2024 at 09:01:16AM -0600, Bjorn Helgaas wrote:
> > On Mon, Jan 29, 2024 at 05:59:33PM +0100, Lorenzo Pieralisi wrote:
> > > The PCI endpoint subsystem is evolving at a rate I
> > > cannot keep up with, therefore I am standing down as
> > > a maintainer handing over to Manivannan (currently
> > > reviewer for this code) and Krzysztof who are doing
> > > an excellent job on the matter - they don't need my
> > > help any longer.
> > > 
> > > Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > Cc: Krzysztof Wilczyński <kw@linux.com>
> > 
> > Applied with Mani's ack to for-linus for v6.8, thanks!
> 
> One question:
> 
> who will pick up endpoint patches? 
> 

I will pick them.

- Mani

> Frank
> 
> > 
> > > ---
> > >  MAINTAINERS | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 8d1052fa6a69..a40cfcd1c65e 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -16856,9 +16856,8 @@ F:	Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> > >  F:	drivers/pci/controller/pcie-xilinx-cpm.c
> > >  
> > >  PCI ENDPOINT SUBSYSTEM
> > > -M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
> > > +M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > >  M:	Krzysztof Wilczyński <kw@linux.com>
> > > -R:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > >  R:	Kishon Vijay Abraham I <kishon@kernel.org>
> > >  L:	linux-pci@vger.kernel.org
> > >  S:	Supported
> > > -- 
> > > 2.34.1
> > > 

-- 
மணிவண்ணன் சதாசிவம்

