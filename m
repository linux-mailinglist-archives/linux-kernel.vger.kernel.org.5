Return-Path: <linux-kernel+bounces-107659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0F087FFB6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 278B71C21B97
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748D41CD09;
	Tue, 19 Mar 2024 14:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xf8lavlI"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551DB46BF
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 14:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710858957; cv=none; b=WsnuVtjJvSPzhX6gyzEgjZWo/GF1AjPg/rn9sHk7/wdLyrEIKPr/j9w+X1hsOOxwzo6TYQWpwXsPqXv+pw8ZSIFEO3gg0R6Zypsu8jNgmq+1wnTMGJejTOmOkNrJ4xwR9aluxI3T47QxWOLDdwjSAjKKWNJNAsxRyh46x0sT6eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710858957; c=relaxed/simple;
	bh=EcuA9tSY6JM0dsJgPVUUMJtMwUoFd/d5CljB8jyEi/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgO/8VrL9lByrpnot5AMzMRzjHr9ap0oTFm3MKtuwZO0+XcF/LSMyuyFtQVSvm8wCc8bUHrczAJTB/54LQksMUKpH0ft/i4vAA8QOUGNOG/KvW4fVogBwXmIRwMoL5ErXv1gD39Xl2boqvGivtBx0FWq1I+DpFB5G4heXN5erTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xf8lavlI; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e0000cdf99so23215825ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 07:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710858956; x=1711463756; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5wdi00cm3s/81EsxS4pMnclHO/YdjCWaOMZ5jrnhsmg=;
        b=Xf8lavlIGjB3jQ6zyVJXKmCAR1oRcS3w03Z2w2cMbwopxHy7POGSq8t7hb6ZgfIOW9
         ZJuMyF9/4oXURlNZDQpB2OTu9BAZ+R+0nq0BpVBwA/O2XLSetA7JFosE+ijX5Y++tfyc
         vR8pBCk+x65QpkbEHakeEMxwI/O5lEnyj6RCLmYFl+7deohYn5mNHDAy+DkO5hK+Tiq2
         Aa22KUSHNjqp+eanDP+40j50O88mjI6/aHQ5DicDi5bPu/KgjBsO2SVK1HDRIXP2DGyA
         CFrqjlCbZhjvlAd1Q5Ygk54LmznhF2cuoh1pgQhgJyFX8ZXCY9BV1M3YyKSTZ4ToLBOU
         Lv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710858956; x=1711463756;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5wdi00cm3s/81EsxS4pMnclHO/YdjCWaOMZ5jrnhsmg=;
        b=Arx0hpFu16LezqJtqlTci83dIdNB1w4q0JY0oAfsKcN38X3E2iHSD+BzUkP5gvuhvl
         Vus+rmIRjX0mD9+gT/hLxUWNJdsLk9riid2ifDhGFzNnhLR2PlKvR6thKxUUPMPNypzI
         NmA+k2043Zu/IslqFnnyOqDqiArvM6sNMFNl8ApLoIPRNu/5AhAfIJEoeep8rqckgeDZ
         flu299slA0G3iSoXSNk0G0YpYn4YqeJLOnOAXaJVdzujGGE0KKCC33AtdT/d38NQmXKZ
         JlM48xAqLEX5VlV0GlO83C41M0mVH8MzH5eZat992sABWykuCnc8XyOBaGBy8Pj+39hl
         4+Ug==
X-Forwarded-Encrypted: i=1; AJvYcCXVo71+u9Moglmv5qExmIVUiBiwcshWZN3GEe42e+lr+poF86+ExHKFLNczmB+g/I04Y0E10q+I854iECbxppqkaSVGX6d5NwEG7YuQ
X-Gm-Message-State: AOJu0YwRc60lCDUgR84vhCWXrSv8h7LGCuftvBzMe3wRna2qwM+II2pR
	7a5ND4FBx5rki5IzC3tQtoa9HrLJ02zLP29beW8Ge0odZc1CXqk06Ua0ojl4JQ==
X-Google-Smtp-Source: AGHT+IGVktTqxahTsIRHvRZJmS6K3iDWwmMhm0wkkhg4/nPef1AzPXHDQX5eV//nmXDF1yXgnydumw==
X-Received: by 2002:a17:903:32c8:b0:1de:f7cf:471 with SMTP id i8-20020a17090332c800b001def7cf0471mr15357431plr.69.1710858955427;
        Tue, 19 Mar 2024 07:35:55 -0700 (PDT)
Received: from thinkpad ([120.56.201.52])
        by smtp.gmail.com with ESMTPSA id d4-20020a170903230400b001db5ecd115bsm10017612plh.276.2024.03.19.07.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 07:35:55 -0700 (PDT)
Date: Tue, 19 Mar 2024 20:05:49 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: Migrate to Genalloc framework for
 outbound window memory allocation
Message-ID: <20240319143549.GB3297@thinkpad>
References: <20240317-pci-ep-genalloc-v1-1-70fe52a3b9be@linaro.org>
 <20240318170843.GA1187538@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240318170843.GA1187538@bhelgaas>

On Mon, Mar 18, 2024 at 12:08:43PM -0500, Bjorn Helgaas wrote:
> On Sun, Mar 17, 2024 at 11:39:17AM +0530, Manivannan Sadhasivam wrote:
> > As proposed during the last year 'PCI Endpoint Subsystem Open Items
> > Discussion' of Linux Plumbers conference [1], let's migrate to Genalloc
> > framework for managing the endpoint outbound window memory allocation.
> > 
> > PCI Endpoint subsystem is using a custom memory allocator in pci-epc-mem
> > driver from the start for managing the memory required to map the host
> > address space (outbound) in endpoint. Even though it works well, it
> > completely defeats the purpose of the 'Genalloc framework', a general
> > purpose memory allocator framework created to avoid various custom memory
> > allocators in the kernel.
> 
> Nice idea.  I wonder if something like this could be done for PCI BAR
> assignment, i.e., the stuff in setup-bus.c.  There are a lot of
> constraints there, so maybe it wouldn't be practical.
> 

I took a quick look at it and I share the same view.

> > The migration to Genalloc framework is done is such a way that the existing
> > API semantics are preserved. So that the callers of the EPC mem APIs do not
> > need any modification (apart from the pcie-designware-epc driver that
> > queries page size).
> > 
> > Internally, the EPC mem driver now uses Genalloc framework's
> > 'gen_pool_first_fit_order_align' algorithm that aligns the allocated memory
> > based on the requested size as like the previous allocator. And the
> > page size passed during pci_epc_mem_init() API is used as the minimum order
> > for the memory allocations.
> 
> /as like the previous allocator/as the previous allocator did/
> 
> > During the migration, 'struct pci_epc_mem' is removed as it is seems
> > redundant and the existing 'struct pci_epc_mem_window' in 'struct pci_epc'
> > is now used to hold the address windows of the endpoint controller.
> 
> s/as it is seems/as it seems/
> 
> If this is not a logically required part of the conversion, could the
> pci_epc_mem removal be a separate patch?
> 

genalloc migration essentially makes the 'struct pci_epc_mem' unused. So I
thought it makes sense to remove it in the same patch. But I do not have a
stronger opinion to not split it.

So, I can split it in next version.

> The docs refer to it as "genalloc", i.e., not capitalized:
> https://docs.kernel.org/core-api/genalloc.html
> 

Ok. Will change it.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

