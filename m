Return-Path: <linux-kernel+bounces-151230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7F98AAB71
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06D551F2152C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6933879950;
	Fri, 19 Apr 2024 09:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zGUF9Kg+"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CBD745D6
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 09:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713518798; cv=none; b=gQzp/MlcQUjQLBUB00/tK4RU7k5eYQ9i/2dXrI2/IoarSJDSvW1wummHo81Q2b/BlUX9RNfyK8LYEwuZ+Au1Lx6x4OGJqnRROQ0tpaROEN3J9C/XlM4WG095H/1RapY0BMvznpiqujfCDAqg2fRd4rXuWpX5RLmKNVxu7POaCco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713518798; c=relaxed/simple;
	bh=nEQE1bgcahfGAeEROm4nIOqoBwmVPoodJbRFX+eJFiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CU1WMo+0Uathou1EiJtkTegXNRlDxvqFf3k4OI0e/bJgD6PSqMwq4UFJjpCCrwRl+wUW+Zz8ZAnzN5vyShD0RfJ0vgoAZRpssC14rTwELTpYG+erzONaQTI9nL5gVmCRIgKVyskbOpicTq1flQ+hVF3oqXiFKOJEi2+MAz2DDG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zGUF9Kg+; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-234db9dde9bso824057fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 02:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713518796; x=1714123596; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f2k6wBjEwpSJIIcZ8MPn1YroTKsxMSXWDSsv1Yc3sRE=;
        b=zGUF9Kg+YfIg5reVeeXUQSnLyDkpUGj4ulcrTG/5U9jobWew3+UbDq2OCWNOICgrin
         7hq+3cPPix++lBy9F14RWm5Kz62j93bljrW2wyIbZfSBeV6hVlDONbm0khRSoONFcdlX
         m41WZ3vCnL/HRQCbm9Qj5cOGZ83h+9xNVYIElD3ISyaC3qoGA2OXFv93nWqtkEmGcRmf
         xia1REZQMbnyGTtMXEg7PqQug4haRsaTWrvhTunIto3xjfTmbDau0evVRjD2xId5dtLs
         XrYMSEZPOuvjnznpUiRiIb5UH5FkSK+75423udCleJnPXJH82URJBsBFXKV9Z6T+oSqn
         DmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713518796; x=1714123596;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f2k6wBjEwpSJIIcZ8MPn1YroTKsxMSXWDSsv1Yc3sRE=;
        b=EemuQkpIhWcfALTIcKZ2kJepfKCjy6tMmSpaTCJympx5G66yAk9/q6tGPWJfrIwD0E
         vsE08Uj92pdv8Ya78aITvH9SecdMEP9naXYFnUjapRr2iK04Ssoq8bjo/AGA2JRY0WNG
         MVTSqmw3U65LM3LYHE3s+h8A5eLTVp4VnbD6EsICAR9X0fxYGjHnWBAtgxdnxe6JoFN4
         voiddq6OBPHg4QngngW73FrHAMwuOmaCKIX4JZRCwpnKw28/j2pSY7k4EQ+tyw4QTAmT
         yBEZA8JWywBvNKgHkCcNHlTl9o3xDmF3JpxAfy/Txj1xbUt07k2O4l4cwb1kivQylRje
         NZPA==
X-Forwarded-Encrypted: i=1; AJvYcCWGMqegPOqUCZF1PeTfb1SprDiM73kVSOGOumzNAfcFq5aXa+blwBiuKroG+RKeBaOMa7/p1vkVGw4KJPwrzqqkjgMDTo2v48AKpJkf
X-Gm-Message-State: AOJu0YwF/9SxIC3C/Ir9zbK89/aNO1ZpWWZGzFSTSt5PeTEmKPm7V1s2
	b2+FN6DM7opORkSDdPkP3vrRXF+l0wStEVsxKGmNg9L0Hu4BS7k53hJ+Ii/g1A==
X-Google-Smtp-Source: AGHT+IGPIPPIitXX4Yw0hrulDjF2tnglO0Qdegfb3hKjRqYEF4E5wtIteUhkJR61YJc1aF7VAjq+9A==
X-Received: by 2002:a05:6870:12d9:b0:22e:c37c:453d with SMTP id 25-20020a05687012d900b0022ec37c453dmr1625314oam.30.1713518796449;
        Fri, 19 Apr 2024 02:26:36 -0700 (PDT)
Received: from thinkpad ([220.158.156.51])
        by smtp.gmail.com with ESMTPSA id z17-20020a634c11000000b005f0793db2ebsm2715872pga.74.2024.04.19.02.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 02:26:35 -0700 (PDT)
Date: Fri, 19 Apr 2024 14:56:29 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	mhi@lists.linux.dev, linux-tegra@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v3 3/9] PCI: endpoint: Rename BME to Bus Master Enable
Message-ID: <20240419092629.GA3636@thinkpad>
References: <20240418-pci-epf-rework-v3-0-222a5d1ed2e5@linaro.org>
 <20240418-pci-epf-rework-v3-3-222a5d1ed2e5@linaro.org>
 <ZiEy4EVcVpUry9qn@ryzen>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZiEy4EVcVpUry9qn@ryzen>

On Thu, Apr 18, 2024 at 04:49:04PM +0200, Niklas Cassel wrote:
> On Thu, Apr 18, 2024 at 05:28:31PM +0530, Manivannan Sadhasivam wrote:
> > BME which stands for 'Bus Master Enable' is not defined in the PCIe base
> > spec even though it is commonly referred in many places (vendor docs). But
> > to align with the spec, let's rename it to its expansion 'Bus Master
> > Enable'.
> > 
> > Suggested-by: Damien Le Moal <dlemoal@kernel.org>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> 
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> 
> 
> Outside the scope of this patch/series:
> Do we perhaps want to add a bus_master_enable() callback also for the
> pci-epf-test driver?
> 

Makes sense to me.

> In my opinion, the test driver should be "the driver" that tests that
> all the EPF features/callbacks work, at least a basic test "does it
> work at all". Other EPF drivers can implement the callbacks, and do
> more intelligent things, i.e. more than just seeing that "it works".
> 

Agree. Feel free to send a patch :)

- Mani

-- 
மணிவண்ணன் சதாசிவம்

