Return-Path: <linux-kernel+bounces-83851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94050869F3E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FE9C1C243B9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4356D3EA86;
	Tue, 27 Feb 2024 18:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pa9Mfe3T"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082A03E48E
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 18:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709059226; cv=none; b=W4qt3RtkoGDW9rvnIPXSd1VBEKpEBmSJCm26nJVSzCZu9ON/SyoFbe6itarl/dfg6tAUO2U7uA8v0xD54b1EARb3K6p0KLvzB71/WjtH3S9gRYDWz9yIfiuNt9Nqb5Z1vsDPKkvK5HzWMprS5uzCPF85F8EDGuZpD3+h5uug3ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709059226; c=relaxed/simple;
	bh=ViTSaMCoFmUnUvNaRtzDSioopiJ0Msh1q2S12nrTU9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+G83Rpr/x4951DNcpeYFhKw62O+BXGWg2MTmYqlS1n6u92+xDJVYXPpA9Oy1s3P7fLFTBBO0O+C80Yg/SqWezYmTQvygorBQPIzrWt7cVxmzhFWYWMKy5RXh67YCybSdgamMR5kxp1d/uwh1uD8yfepQjK5FGWXfr92WoLv22w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pa9Mfe3T; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-36517cfd690so12906415ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 10:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709059224; x=1709664024; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SsuS6sOVug3YrAmxtUqH/1NuaIV6/SsNBHUd/9g2JPc=;
        b=Pa9Mfe3TsC4mP/Pgeg7sN2zLEYA/uFPKLEn7+v9GtwI7AfMCY+WDUC70Mu4bjS/o2i
         rjdgWgk4zJ0wCMOWPofOBrWkx57DxNpQAlI7MCmR1HK6P0WaDWAMZz0QEq48FbCnVA7k
         2rKexDnVjiZJQc4umKcyCVetCdtdYdOysdlfhUhKO4OrvzRlozVUuTaz02IPhZMNzRgZ
         2MDFPGFdtWLlJid7Lg/OzpFApUqU+CJ3GtCJAfAvTN1NNgt6piGIrUai+2wgkWeBBc1x
         SrD0lD2Zc5KZngu2ViHV940vNskgtZMlJ3c6GLpN99281Vk6AnxAdgYLixIf0e8Mq7Lh
         6SyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709059224; x=1709664024;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SsuS6sOVug3YrAmxtUqH/1NuaIV6/SsNBHUd/9g2JPc=;
        b=aoFz+/FpQSi1V0Gy//Bnl++E4eTG8UnSMo+CZVmE8DzX2DN00lXH1KJ9LacOChHIcT
         w0SCjPLhCLfmuxiDEBI+gQblJseL/9xLBNFrnNIDulxF5N1990MboS63zHIjU407nedk
         iJXxyOBPsIaastd4TCkTcD63m4j5zKvoOuAEYyQX+CZem/BGK4AtSGVl7moTlD0IPIME
         gKNkh2UipqPo6bO3F3T72A1kPzMdwjtv01QxFkgYXMcACcHbG+phhLvSKjcYki2CSR+5
         6UtYk2mDjjJG/E1Q4CcW+mdzQLsWHSXLFy9pZvSZAfholiGUskFw4AHXb/Bgb5FDwpCx
         G3cA==
X-Forwarded-Encrypted: i=1; AJvYcCV5t0IpaLkSD5OlpBflp+brUt98lhPPXedwwbgZbtJExZPUkMpGYtpzrFOU/rpHu4CkFZjrS4s0F9mPK6HVBV7PKy0hYYI8OJUKOh5w
X-Gm-Message-State: AOJu0YxQNVoEM1/vbxwCN5LzpX0FL39/yW5nEnrHDyUmz+HIv7Ksd7H9
	ZgdmiACWP9G+k+mgraP/Fc6JbYm9XrQLI+2x/lDv4D0ZacqeRqvjMK1MeZ1v3w==
X-Google-Smtp-Source: AGHT+IE1HPlgRLmyc0g98GoU1CTnytDy7+9nFOvg3SADRSfZqNGjuszigV4PbhP+5Jys/tCC9c5OXw==
X-Received: by 2002:a92:c94d:0:b0:365:1f83:24a3 with SMTP id i13-20020a92c94d000000b003651f8324a3mr11623288ilq.18.1709059224133;
        Tue, 27 Feb 2024 10:40:24 -0800 (PST)
Received: from thinkpad ([117.213.97.177])
        by smtp.gmail.com with ESMTPSA id d7-20020a056a0010c700b006e2b23ea858sm6257160pfu.195.2024.02.27.10.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 10:40:23 -0800 (PST)
Date: Wed, 28 Feb 2024 00:10:15 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	quic_krichai@quicinc.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3] PCI: Add D3 support for PCI bridges in DT based
 platforms
Message-ID: <20240227184015.GS2587@thinkpad>
References: <20240227170840.GR2587@thinkpad>
 <20240227173705.GA241732@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240227173705.GA241732@bhelgaas>

On Tue, Feb 27, 2024 at 11:37:05AM -0600, Bjorn Helgaas wrote:
> On Tue, Feb 27, 2024 at 10:38:40PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Feb 27, 2024 at 10:25:35AM -0600, Bjorn Helgaas wrote:
> > 
> > [...]
> > 
> > > > Ok, I got the issue. TBH, I added the device tree property based on
> > > > the existing quirks for the ACPI devices. But none of the DT based
> > > > platforms I'm aware of (even the legacy Qcom MSM8996 chipset
> > > > released in early 2016) doesn't have any issue with D3hot. But I'm
> > > > just nervous to assume it is the case for all the DT based platforms
> > > > in the wild.
> > > > 
> > > > But to proceed further, what is your preference? Should we ammend
> > > > the DT property to make it explicit that the propery only focuses on
> > > > the D3hot capability of the bridge and it works as per the spec
> > > > (PMCSR) or bite the bullet and enable D3hot for all the non-ACPI
> > > > platforms?
> > > > 
> > > > We can add quirks for the bridges later on if we happen to receive
> > > > any bug report.
> > > 
> > > I would assume all devices support D3hot via PMCSR per spec.  We can
> > > add quirks if we discover something that doesn't.
> > 
> > When you say "all devices", are you referring to bridges in DT
> > platforms or the bridges across all platforms?
> 
> This patch is only concerned with DT, so that's what I'm commenting on
> here.  I don't know how to untangle the question of ACPI systems.
> 

Ok, I just wanted to confirm.

> This patch affects platform_pci_bridge_d3(), so just based on the
> "platform" in the function name, I would expect it to be concerned
> with the D3cold case and whether the platform supports controlling
> main power.
> 
> It looks like this patch says "we can put devices in D3cold if DT has
> 'supports-d3'".  But I don't know how to make sense of that because
> that requires (a) platform hardware to control main power and (b)
> software that knows how to use that hardware.  Wouldn't this require a
> little more DT description, like "regulator X controls main power for
> this bridge"?  And then an OS would only be able to actually use
> D3cold if it knows how to *operate* the regulator, and it doesn't seem
> like DT could answer that.
> 

Fair point. And for most of the DT based platforms, there is no dedicated power
supply for the bridge described in DT. So transitioning the bridge to D3cold is
not entirely possible in the OS.

Since we concluded that enabling D3hot for all bridges in DT platforms is the
way to go, I'll drop supporting the DT property in next version.

I'll also remove it from the binding.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

