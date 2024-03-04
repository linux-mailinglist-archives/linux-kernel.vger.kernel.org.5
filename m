Return-Path: <linux-kernel+bounces-90079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F67986F9F9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 610601C20C87
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 06:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0971D517;
	Mon,  4 Mar 2024 06:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UkdwZ0NJ"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CF4C15B
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 06:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709533152; cv=none; b=Kr5gjenPsLrLa8CYnF31XREtlzffnoWUl0Fb1UxkSr31QvK+wEzrxvrpNKQlkeHJ56CuBtBaH6fd35es8Rm2RsPnFaIcCxJzeUTxknAp/btg9d9sPWVIrZq9izztvKcvr/fM0JZGSWyKgElF7m8eOTL5TUm8YZuHsLJ9f4DSfuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709533152; c=relaxed/simple;
	bh=oDnfxJ4A8v+Y+oMepOulbgQydBSN2yDgubk57DJ4nVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVMQgVPUz2R+vadW8I6OC+jO42RGOEFjziEK9rqpxnUxVMK+XkdjxNI+TDGQ30h4NKWYKlYtNqwz58ItxjFY+pn1TSbi/j0EUS2+0fvj4VBFnqIkl2kzPtvurU8vlmyZn9Oun4rPshfXHbpvCNPNrfv1ydNNfmnUkhcS/TVOV/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UkdwZ0NJ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e58a984ea1so2603562b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 22:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709533149; x=1710137949; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yY8EnFgYAlXlPqttQTMQ9X4CPIclgM7lc+6szk0vfN0=;
        b=UkdwZ0NJO/t+VeRQ3jJaAJWmtWtHhKKNpJDL8AnzczA5poxIkP82dlz2Nz3ZvQaA5j
         042n+WMa/w1Z1PmxEDdZ+r7jrAX6o+4erId+uuiw40c6rNLfagxqvvs3sCp7PmXk3oY+
         p7z8YX5yAkFjrnDGq4yUApovsYKc/v106gUdPYksnuaFAz978pmQUBVm484eaJhbCZN4
         Sloh50Q44CSXV5G67vSnWWKOJ4ho0R4hNbViDYrKxyBJvG+htd+UdGVJjnMNBkHMLpOf
         jJW8OKwZmqof6MZl+/eLJGjheZqCLf3+NQiWtBMgLVBw7JTZoK8fvHx7ixno2eS74MnX
         6jMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709533149; x=1710137949;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yY8EnFgYAlXlPqttQTMQ9X4CPIclgM7lc+6szk0vfN0=;
        b=psi8dOyeCTQHhWzskluy963AbiVITPi6caXBIEPbK8a7XepZwvLSy+X0DhwU9w9l2d
         CgITg87c9oDY8UkmJm+jjitPWGWgH73CnP/aUrbraegp6vBH5QOCr8UbG3JQ8G1/+qNx
         t8cSxcixtV6Wy4TWw29TzH0NgqtyXXDzRp1Dtd/qD/MpNfvSUdYzp5dqttDCE/pflH3w
         RIeTPQDX+p0fi9b//pvxEmWMQyYjCILa6lwUefg8fFArPATasB9tbt1z/8dORtW68sBt
         58rOebF92V8+/7SkU1z8sSdoT3MYUXIVa/riqWUiHuX0hwZbbg+QUVgLVAAXGwoA07nj
         8D3w==
X-Forwarded-Encrypted: i=1; AJvYcCUoS0A3n9cqwWUb1hfMjHNe540FNBCZifO+4cNBqIUTAfKy7IwKtJKP4Vvd3OhZ5242hLDx+5ATYevCC4ygtB1vpfwCzQDecMFvhr3c
X-Gm-Message-State: AOJu0YzzV9Jefg111jE7+IQWf4KVOnYFlW49tIWveUzDZzFoQGleQMrh
	cvlhVjAIc04HmwBnWVYn09fTlIcjbts9/aBJaUZC6oewx0TSzNAMD+nuaCytug==
X-Google-Smtp-Source: AGHT+IEGGhWfMbQLfvF9uJtsc7Y6qkosURA49AQc9jMC4u8Vp5VihTolBAdcYaH2nlvvK6/zVXQicg==
X-Received: by 2002:a05:6a00:2e26:b0:6e4:f32a:4612 with SMTP id fc38-20020a056a002e2600b006e4f32a4612mr8718386pfb.16.1709533149188;
        Sun, 03 Mar 2024 22:19:09 -0800 (PST)
Received: from thinkpad ([117.207.30.163])
        by smtp.gmail.com with ESMTPSA id k19-20020a63ff13000000b005cfb6e7b0c7sm6825218pgi.39.2024.03.03.22.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 22:19:08 -0800 (PST)
Date: Mon, 4 Mar 2024 11:49:00 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
	Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: Re: [PATCH v3 3/5] PCI: dwc: Pass the eDMA mapping format flag
 directly from glue drivers
Message-ID: <20240304061900.GF2647@thinkpad>
References: <20240226-dw-hdma-v3-0-cfcb8171fc24@linaro.org>
 <20240226-dw-hdma-v3-3-cfcb8171fc24@linaro.org>
 <Zdy8lVU6r+JO6OSJ@lizhi-Precision-Tower-5810>
 <20240227074533.GH2587@thinkpad>
 <Zd4eLBXscaV1WkbV@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zd4eLBXscaV1WkbV@lizhi-Precision-Tower-5810>

On Tue, Feb 27, 2024 at 12:38:52PM -0500, Frank Li wrote:
> On Tue, Feb 27, 2024 at 01:15:33PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Feb 26, 2024 at 11:30:13AM -0500, Frank Li wrote:
> > > On Mon, Feb 26, 2024 at 05:07:28PM +0530, Manivannan Sadhasivam wrote:
> > > > Instead of maintaining a separate capability for glue drivers that cannot
> > > > support auto detection of the eDMA mapping format, let's pass the mapping
> > > > format directly from them.
> > > 
> > > Sorry, what's mapping? is it register address layout?
> > > 
> > 
> > Memory map containing the register layout for iATU, DMA etc...
> 
> the world 'map' is too general. can you use 'register map' at least at one
> place? There are bunch 'map' related DMA, such iommu map, stream id map, 
> memory page map. The reader need go though whole thread to figure out it is
> register map. 
> 

This is what used from the start and also what "mf" corresponds to. So I had to
use the same terminology.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

