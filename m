Return-Path: <linux-kernel+bounces-149621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F018A938D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A7251F21E5F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF41376E4;
	Thu, 18 Apr 2024 06:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HXomSYYh"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4902C6BB
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 06:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713423195; cv=none; b=ISfWD2cn1LLrdibSzBlLSrJWf6TFf0FThN5+f1bUwXSRXgty+EQMP/sD5JiugysZ1UyTMNThKzWy7rsTE0wzjIF4iTyoAsElzKamJIuBFQ7qs86ie2dVJ0QvoNh+m3sKY/sw0JS7lW7ucjbl3wnGrYYcH07sWGX4gKqiuyAp/P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713423195; c=relaxed/simple;
	bh=pl0E0/CPNvyU7tX7pTfKZh9cVPJsQcytPBidCAR/NJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7WZHj07GGVDBBIlJeQDl0lIY5UdK5wSFLABfrTDbZVOf3/Nl22blzsrFYM9btHeaLU7SKhuVtusjRP6c/Zl7eUaiiVy3XdUS1bPT0KQdQduASs6/hNw28Y2kQ0vqPCAwyecgSImuDv+Wm/Hf2Ozn0/tKX3InDCYIy8u8LarHBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HXomSYYh; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5e42b4bbfa4so298318a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 23:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713423192; x=1714027992; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qC0zbqS3FQ+Zn4xV4lRWFo3BO0VRfJLwRrQ9QuGIorY=;
        b=HXomSYYhKH6YcsukxcbuyFVExmZbki9R/E9JdlcJPVWF75621Bua/owT40IYgrNOVT
         LTkXTyg17UVy6EpOku2KyTUqqQ8bucS16wogHMAOV92RR5K5ZRYk8pmgbcogGlL2bpVh
         VMiBIUk39Z2JWzGXnTA9f6SoCHotHC4Fm73dzK3xbK/5v5UwzrXnA7MgWGTfEiYIcwnv
         9JZvSbUlQSrdntKJv5LXTuM0KQ3NO8O+xlMR8nfGxhnQwDk7Z5q1sZXh5DexATu26W82
         CioYaSoNpf3H/OeyNR1lLKQ6/I1bV3yRpaJ5joHeUBXQN3v7BBpr9oxL1Mhr/S6JPOwz
         4I7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713423192; x=1714027992;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qC0zbqS3FQ+Zn4xV4lRWFo3BO0VRfJLwRrQ9QuGIorY=;
        b=pf4G1oLkTmAms6oVjMtvbYemJPLEUwPwDOEPujxZ8IYprV6p7E+egLHu+qj4TScfwm
         ujeCwlbyX56kevEEFC1zet4otsSF6SqgV6wPtkHyLDSWOLqfOmmUFM3J89ee90hTTiWU
         lUW2nUMcJ2/5cigPz+6rurwelJet3DgY9TrCs+wgaFc75i7G1feNe7OsaEz9sxsNcUMj
         DyAr0IWecPvgXpXC69m8itImO2n7OfheGAZ9tGd70Kr5tuoboGpv4sVSyj9cTQcZxk1i
         aPGgqGXwqCJyHi+KlFinLGMysLSNCQX6RhnUkaCMqtidOfbu1YrITDBNF3GLeohaqaP/
         +fUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkD9sfope51vVHYf6vidgGju0wxjIL9SPy1jHV+sx13jgrlNVg4Aw1COGqOR66KBzqfImeQtCoR4tCmBU0vGogyf0AfED52Knid/mV
X-Gm-Message-State: AOJu0Yy9hiOSZHI5Q0CmKy21r7v2v6FeajKexQKVTcK9vAplBLYSe1zP
	QhuzMWeEz3X84046+xzhw9SiYE9XGpzFHSg+2V8KrA9InpofDPWyXXm4D3aWsQ==
X-Google-Smtp-Source: AGHT+IGjCdWHFS5SAG//RjXHhury0Bmks00ilQi7+/67t3HVtZgtedJYa8UQ7HA8XSK5FTOavG52Ow==
X-Received: by 2002:a05:6a21:1f27:b0:1aa:5d76:1916 with SMTP id ry39-20020a056a211f2700b001aa5d761916mr2203144pzb.34.1713423192398;
        Wed, 17 Apr 2024 23:53:12 -0700 (PDT)
Received: from thinkpad ([120.56.197.253])
        by smtp.gmail.com with ESMTPSA id fj32-20020a056a003a2000b006eac4297ed3sm766902pfb.20.2024.04.17.23.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 23:53:11 -0700 (PDT)
Date: Thu, 18 Apr 2024 12:23:08 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Make use of cached
 'epc_features' in pci_epf_test_core_init()
Message-ID: <20240418065308.GG2861@thinkpad>
References: <20240417-pci-epf-test-fix-v1-1-653c911d1faa@linaro.org>
 <ZiALuYlshLmwLhvu@ryzen>
 <20240418054319.GB2861@thinkpad>
 <ZiDB18w4bnUCSH7D@ryzen>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZiDB18w4bnUCSH7D@ryzen>

On Thu, Apr 18, 2024 at 08:46:47AM +0200, Niklas Cassel wrote:
> On Thu, Apr 18, 2024 at 11:13:19AM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Apr 17, 2024 at 07:49:45PM +0200, Niklas Cassel wrote:
> > > On Wed, Apr 17, 2024 at 10:47:25PM +0530, Manivannan Sadhasivam wrote:
> > > > Instead of getting the epc_features from pci_epc_get_features() API, use
> > > > the cached pci_epf_test::epc_features value to avoid the NULL check. Since
> > > > the NULL check is already performed in pci_epf_test_bind(), having one more
> > > > check in pci_epf_test_core_init() is redundant and it is not possible to
> > > > hit the NULL pointer dereference. This also leads to the following smatch
> > > > warning:
> > > > 
> > > > drivers/pci/endpoint/functions/pci-epf-test.c:784 pci_epf_test_core_init()
> > > > error: we previously assumed 'epc_features' could be null (see line 747)
> > > > 
> > > > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > > Closes: https://lore.kernel.org/linux-pci/024b5826-7180-4076-ae08-57d2584cca3f@moroto.mountain/
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > 
> > > I think you forgot:
> > > Fixes: a01e7214bef9 ("PCI: endpoint: Remove "core_init_notifier" flag")
> > > 
> > 
> > No, that's not the correct fixes tag I suppose. This redudant check is
> > introduced by commit, 5e50ee27d4a5 ("PCI: pci-epf-test: Add support to defer
> > core initialization") and this commit removes the redundant check (fixing smatch
> > warning is a side effect). So if the fixes tag needs to be added, then this
> > commit should be referenced.
> 
> Well, you have a Closes: tag that links to a bug report about a smatch
> warning that was introduced with 5e50ee27d4a5 ("PCI: pci-epf-test: Add
> support to defer core initialization").
> 
> So if you want to reference another commit, then you should probably
> drop the Closes: tag.
> 

Then checkpatch will complain... But I think I can keep the two tags? One is for
fixing the redudant check and another is for the smatch warning reported.

> 
> > 
> > > 

[...]

> > > That way, we assign msi_capable/msix_capable just before the if-statement
> > > where it is used. (Which matches how we already assign msix_capable just
> > > before the if-statement in pci_epf_test_alloc_space().)
> > > 
> > 
> > Ok, if we go with this pattern, then pci_epf_test_set_bar() also needs to be
> > updated.
> 
> pci_epf_test_set_bar() ? I presume that you mean pci_epf_test_alloc_space().
> 

Oops. I referred from an old branch.

> How about a 1/2 patch that modifies pci_epf_test_core_init() and Closes: the
> bug report, and a 2/2 patch that modifies pci_epf_test_alloc_space() ?
> 

Yes, that's the plan.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

