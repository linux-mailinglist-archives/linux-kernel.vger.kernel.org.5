Return-Path: <linux-kernel+bounces-74069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDC485CF8F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDB171F214F5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 05:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B40039FCC;
	Wed, 21 Feb 2024 05:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WMz2/Gzf"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0E739AF1
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 05:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708493178; cv=none; b=WJasGBm3/DruWp6wu05DT+nuVgcF134yd7xEolhu0C5vPG0Qp2qPv6quM1DGQGVZktSoqWhlnALUEVaCBOOTiCatsA5AYZaiEtbRLhLqz2KCHP2c6h1WfrtwfhtlUZ3dOr9IU0C2cOrRpDxTS/vjX9kKFfiPfETMyHZM2L3m+ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708493178; c=relaxed/simple;
	bh=rJCs/lTuNqz4lwNq2Iu1h8tZDBoOnXv0chyWC70/1xM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FL1qdXzTpgJx9ZMB/6Y0WVJ95RRi3wAoqj9cC0tpaz+EeuI+yLQDxOezXtxspDehMCbJvK9gf+ac0NbH276f9V0NsUYJDTquRmDf7t+IclhsHfAyNNOsTQ87clrHn1raRll873zS5DF27wyIHEIT0UMN8xNS2e0z6DIBzP2qdYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WMz2/Gzf; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d94323d547so46412535ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 21:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708493176; x=1709097976; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MTWJcnG98aeovE0bc5/gXqjs0hZE7lI82YidLyMzmGo=;
        b=WMz2/Gzf8oUkHP6Q4O53Qjo4NpZUTNc4SnSY1pfeZ/XB21WTpUehriMIN1H6c1VzBY
         STBufiGEFhTdlzMfgsTFjavCyxhWGmD6BgfThNpYK81cN9bm+b9lSsBknYsyThjKxCG2
         z9Nd+jxDi2T03wqHPk2Yvv3Lo43L9ZhDGCRUs+XVYaA/Jsq/lrh0bA/WmsTdoyQHSael
         ozplBZfRAAqWZxq41ZSA5PkSySo7uX4It1a3UZ6SFEBcNKs6J4Tl+lCssJjfnK+/TPAm
         83nXVXki/xVJnXVX6VvvpPfzBCKXD+z9tI1NNtJPudSmiRPd/hOSHDuFPamC73YCefEh
         yQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708493176; x=1709097976;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MTWJcnG98aeovE0bc5/gXqjs0hZE7lI82YidLyMzmGo=;
        b=QPokVPlf+5BMp9gzbiMtxw3hbG4FEwamxqlTMexqf+7LULWEYQW3P6eusXBe9VOgIe
         +il18xX6IVRx/pFX8FjVVxQnsvh++eg4H8FJ5ASNjNy/7uM+ByGV2F1vJl4HEcFwWDC/
         HHwHOMSNxQXMDliaUNU5T0P9VE45uGjadkgWmR8KCJDdFPcLscynoSBeH6w/gs16oHHu
         YuAIfYXH9HTKV1/n/SvqImVFPUl4tk6uBhG2OyDdBMHE5AEURZi1IP1Mi3UyOY4Ec4DR
         nVtW7wnclQUJofouhmNlm8k50PmACALYKyUP3FdyCcgnHgvMKP8IkMhhR4khzL8wh993
         /5tg==
X-Forwarded-Encrypted: i=1; AJvYcCXLk5gO1/4kq4MInCCp10qfGPOcKwEBEiRNreemeodHyYRC0N2LJ72asq11vHrmAUD/vM4urjKt5x626fbwCmATqPAgIe0v99ylWu+8
X-Gm-Message-State: AOJu0Ywq4gDneH3QKalx2A1PjiNkNveX+Sjy6I66M5LJRWPWlIMLUI2y
	jovtNKgFYIXNmV06gDHYdlZ0icDqSqtSn/4yHwrCg6LL0imE52J6rQA4c+YNJw==
X-Google-Smtp-Source: AGHT+IHuplcoWMw4r0gDZZn2ICKSFcQ8PLjle78E1d6SCAd4YVLTBAnWH4POCADFW4B7pRAQwvjENQ==
X-Received: by 2002:a17:902:c3c4:b0:1db:cb13:10f1 with SMTP id j4-20020a170902c3c400b001dbcb1310f1mr9654097plj.19.1708493175961;
        Tue, 20 Feb 2024 21:26:15 -0800 (PST)
Received: from thinkpad ([117.207.28.224])
        by smtp.gmail.com with ESMTPSA id p11-20020a170902bd0b00b001dc35e04b02sm95905pls.32.2024.02.20.21.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 21:26:15 -0800 (PST)
Date: Wed, 21 Feb 2024 10:56:07 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] dt-bindings: PCI: qcom: Do not require
 'msi-map-mask'
Message-ID: <20240221052607.GB11693@thinkpad>
References: <20240212165043.26961-1-johan+linaro@kernel.org>
 <20240212165043.26961-3-johan+linaro@kernel.org>
 <e396cf20-8598-4437-b635-09a4a737a772@linaro.org>
 <Zcy4Atjmb6-wofCL@hovoldconsulting.com>
 <59bd6e54-0d5d-4e1a-818a-475a96c223ff@linaro.org>
 <20240216165406.GD39963@thinkpad>
 <ZdRXpQnbDbojlMkV@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZdRXpQnbDbojlMkV@hovoldconsulting.com>

On Tue, Feb 20, 2024 at 08:41:25AM +0100, Johan Hovold wrote:
> On Fri, Feb 16, 2024 at 10:24:06PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Feb 14, 2024 at 02:38:57PM +0100, Krzysztof Kozlowski wrote:
> > > On 14/02/2024 13:54, Johan Hovold wrote:
> > > > On Wed, Feb 14, 2024 at 01:01:20PM +0100, Krzysztof Kozlowski wrote:
> > > >> On 12/02/2024 17:50, Johan Hovold wrote:
> > > >>> Whether the 'msi-map-mask' property is needed or not depends on how the
> > > >>> MSI interrupts are mapped and it should therefore not be described as
> > > >>> required.
> > > >>
> > > >> I could imagine that on all devices the interrupts are mapped in a way
> > > >> you need to provide msi-map-mask. IOW, can there be a Qualcomm platform
> > > >> without msi-map-mask?
> > > > 
> > > > I don't have access to the documentation so I'll leave that for you guys
> > > > to determine. I do note that the downstream DT does not use it and that
> > > > we have a new devicetree in linux-next which also does not have it:
> > > > 
> > > > 	https://lore.kernel.org/r/20240125-topic-sm8650-upstream-pcie-its-v1-1-cb506deeb43e@linaro.org
> > > > 
> > > > But at least the latter looks like an omission that should be fixed.
> > > 
> > > Hm, either that or the mask for sm8450 was not needed as well. Anyway,
> > > thanks for explanation, appreciated!
> > 
> > msi-map-mask is definitely needed as it would allow all the devices under the
> > same bus to reuse the MSI identifier. Currently, excluding this property will
> > not cause any issue since there is a single device under each bus. But we cannot
> > assume that is going to be the case on all boards.
> 
> Are you saying that there is never a use case for an identity mapping?
> Just on Qualcomm hardware or in general?
> 
> It looks like we have a fairly large number of mainline devicetrees that
> do use an identity mapping here (i.e. do not specify 'msi-map-mask') and
> the binding document also has an explicit example of this.
> 
> 	Documentation/devicetree/bindings/pci/pci-msi.txt

I don't know how other platforms supposed to work without this property for more
than one devices. Maybe they were not tested enough?

But for sure, Qcom SoCs require either per device MSI identifier or
msi-map-mask.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

