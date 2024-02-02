Return-Path: <linux-kernel+bounces-50289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4151B847703
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF62C1F27963
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9795614C598;
	Fri,  2 Feb 2024 18:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=soleen.com header.i=@soleen.com header.b="CI0ae5x+"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DAA14AD10
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 18:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706897086; cv=none; b=fR2Ydv2/PzvVNsObKTPkaBE0M3l/kw8eZ2/numINTWVof0m1gpiC6yPYJDLCjyXIcwjF0l5hOjD9QH+HfzwWYT4NDAtS2IlRUgZW4ZCE5BDgP7cyX1c1bme0C7yP1cv51scWZ8f7SHWau0+nuAIcq1yIFKB+YF/xaw3cytMUH7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706897086; c=relaxed/simple;
	bh=Zx4DDxuZPCP/PEq8O78n9UklQLgFp6VRMfg1bUcF2K8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WpKmZVeFKZ4hmh0Ibm22DPx014eaMsYeKlkkpIWhQxqg3UMEaV/A29ShRpHyue/NGSU74eHzlflceu0pjNmDNyJ6wJRa0hYEXkfBId6AcoC502XpJg9Z5AsU1PKz9bew43ywPU5dSaQ4QSxcVdaWL+PQahIjhx0pnxB/U0qRw9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com; spf=none smtp.mailfrom=soleen.com; dkim=fail (0-bit key) header.d=soleen.com header.i=@soleen.com header.b=CI0ae5x+ reason="key not found in DNS"; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=soleen.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-42a029c8e76so13338491cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 10:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1706897084; x=1707501884; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9bijSb9yEaTmlnOsnr5FnwiHhV7CJXfrStAeun3CCBg=;
        b=CI0ae5x+4EsSoDWh6pmbUopB8snBPFOp7OyVmAkDWCu2mzbvPgYwUNNBqg09ox20Z4
         5VoQSdr1ly3zim0hXNuYfu91qY++8DDv751zW1VaifZUqyBeAVchFi2MLhum+8wYGXFQ
         hB6o9gjmydDRInU75EW2it5bUzcEsg0/4Dh0zvu5vsQhLrW1dQGO2TKDPS8XF85vRQz9
         ItFkEFl3spBgAcNZsWrI8Kyzxs2DxgxdBGlzS8DfHllyMYx1v5iZRC7i5SPUWmsxo/H8
         PnvCSqZKq/xCPCMZ4TD87wyjddbmuDFygIvgq5j9lCqbymidtVslnuByRvgvRia3Ek2o
         6pVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706897084; x=1707501884;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9bijSb9yEaTmlnOsnr5FnwiHhV7CJXfrStAeun3CCBg=;
        b=fGebbwvlp2f/ddQlZ6v3n8+yKc0xEb9Jf44RzHADvvWGOwMmrPwIi36fTFQARtehek
         5rUViyr8z3hc55SFQQVQ4AV/CmYAjt1uDq0iayVI2DEDrFjFEMoqTzWJLCtccc+cP2AE
         e3q0l2JnkhZ1mQcZbdDJizkdJrmPGWmGkvTI9ea8q4H80yMCvA3ZQtVHmjr+jZ9CFXGT
         1qf+ox+SOMEv19IEC7CRn84eN1GE+ongE3TRGzwBq9d5AGiCFAS5dlYFwY8Z1i1Y0hsk
         TwkzusVQS24OwZG/jHRpDRe+SV9tF/cC3eJnyOjDUXsO3GPuMwp4oQuG1Pytfe8+E7dJ
         bJmw==
X-Gm-Message-State: AOJu0YwGYYeZQEq3WYNuHziVojyluG9ZA8Kcs3fQtmkH17ey6CI411OJ
	Dotu2u03bevCzEOTG7Ps9e8ZP6ydBpzO4C1HnDOi2uyibvqDwtuflyGo7979OnLuycbQAogxQQX
	aHhmmu/EJMPVYeS77RXMuFxKrc7gqL+PwwSyQfw==
X-Google-Smtp-Source: AGHT+IHZP6Un/HfjT028jnx0QVAGxq1NUEXIMQe8jhyWY9SpyTJFVDbuNtWHifT6v8EukAWp/hKqGTYNjWvGHCDW5lY=
X-Received: by 2002:a05:622a:343:b0:42b:eee7:5f5c with SMTP id
 r3-20020a05622a034300b0042beee75f5cmr9136031qtw.63.1706897084294; Fri, 02 Feb
 2024 10:04:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201193014.2785570-1-tatashin@google.com> <02610629-05ef-4956-a122-36b6ac98fbc2@arm.com>
 <CA+CK2bD_q3pnThtLVSzFCjyevBEaG6Ad+1o2=1tVZsYg35UMmg@mail.gmail.com> <84c7e816-f749-48d8-a429-8b0ef799cdbb@arm.com>
In-Reply-To: <84c7e816-f749-48d8-a429-8b0ef799cdbb@arm.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 2 Feb 2024 13:04:08 -0500
Message-ID: <CA+CK2bCFbeRHT172KUci5+8WJNUeo-2A1M=UXsSqqOy64w1LJw@mail.gmail.com>
Subject: Re: [PATCH] iommu/iova: use named kmem_cache for iova magazines
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, rientjes@google.com
Content-Type: text/plain; charset="UTF-8"

> Hmm, I did misspeak slightly (it's late and I really should have left
> this for tomorrow...) - that's 12KB per CPU *per domain*, but still that
> would seem to imply well over 100 domains if you have 242MB of magazine
> allocations while the iommu_iova cache isn't even on the charts... what
> the heck is that driver doing?
>
> (I don't necessarily disagree with the spirit of the patch BTW, I just
> really want to understand the situation that prompted it, and make sure
> we don't actually have a subtle leak somewhere.)

Hi Robin,

The following tracing is without Google TPU, simply upstream kernel:

The iova_domain_init_rcaches is called 159 with the following stack:

 iova_domain_init_rcaches
 iommu_setup_dma_ops
 amd_iommu_probe_finalize
 bus_iommu_probe
 iommu_device_register
 iommu_init_pci
 amd_iommu_init_pci
 state_next
 iommu_go_to_state
 amd_iommu_init
 pci_iommu_init
 do_one_initcall

Each time 1536K is allocated: in total 159 * 1536K = 238.5M

The allocation happens like this:
for (IOVA_RANGE_CACHE_MAX_SIZE)
    for_each_possible_cpu()
        iova_magazine_alloc
        iova_magazine_alloc

IOVA_RANGE_CACHE_MAX_SIZE = 6
ncpu = 128
sizeof (struct iova_magazine) = 1K

6 * 128 * (1K + 1K) = 1536K

Pasha

