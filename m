Return-Path: <linux-kernel+bounces-10835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C92681DCB2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 22:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F0481C21469
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 21:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD8B101E9;
	Sun, 24 Dec 2023 21:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nQeM2AY6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A634FC11
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 21:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3600101e819so18965ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 13:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703453995; x=1704058795; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f9Q+OMVGug+ylz+2uzJShCURagJfqE6miFHjz/+Dgvg=;
        b=nQeM2AY6cp/niLsBzgFiWuH2doedWEVHCah9TYHwAGD5bj3DcpFc+lt1C1oTlajYY6
         Yi1LdGlQi4MTt7b6gUxlqI2SZTjDbnp1CmJDdSUgJtom4uSXeG+6T/nv2j8WO9pk+L+e
         TFXBYKhElRLA6jx5IZAxvRwOIDib9uycesjwuT8Kji8utE8mZbyVXqNYgkwEn9VUQ/St
         RWCPBr2vKzHHvc/3trKPuqERBb+Tbz1IcmKG7lU6D8ju3PkdvNVBRUCETtm82LwmcGKC
         EZRYYycvNkHI+80et2GCRwewRXcyOrLUG75IBaJZGVXIJ3+UsyVEvoYA44MnQHHdvxI9
         TRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703453995; x=1704058795;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f9Q+OMVGug+ylz+2uzJShCURagJfqE6miFHjz/+Dgvg=;
        b=uPMAmPNAQS+bCBmwDtvUyZRXyC5EUEd0Mp/gms5R0vOcu3cG9XGo1lIomDKOGxTuOQ
         munf1Bz4B0S7k0rcF8lFy3Av1tMEUkYsC1sMO15DWNIOEeIVdvZmzHIF1lWNOjl4ke43
         PfGpwaESggDO1HgF0UpFALjHdu/f5RXIiNrr96jnuqmxcXN211rLcuMeppLeAegKcDJQ
         hsw45lwdVJxuXAceM4XlJV280jA9gpssHUCijatmiXkmc5hR5LPvoOOPKjaD0b1lUIMP
         qAzEOW/9dOHRVFB9bn4RjSyJAZevUniIGgVBQkReAB10Ensetgm+qtSFFx74FdHEpzxm
         4blw==
X-Gm-Message-State: AOJu0Yz/gAyuboMEEmhaHrHn2g/2TuAklAFXhXQcpwptlRwobzoMX2QJ
	jBo02jFx0Gx+Eo7hD9z4E6Ia86ntHKKE
X-Google-Smtp-Source: AGHT+IFJfsP5JhgYByhZLf3HirHsXDvYjSFYqzQ3snkAvp0nJS5eXaEyeAz3IXcv8WBPowwQKkdAPg==
X-Received: by 2002:a92:cb09:0:b0:35f:b09b:ccd2 with SMTP id s9-20020a92cb09000000b0035fb09bccd2mr397952ilo.7.1703453995330;
        Sun, 24 Dec 2023 13:39:55 -0800 (PST)
Received: from [2620:0:1008:15:c723:e11e:854b:ac88] ([2620:0:1008:15:c723:e11e:854b:ac88])
        by smtp.gmail.com with ESMTPSA id a13-20020a170902b58d00b001ca86a9caccsm6947051pls.228.2023.12.24.13.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 13:39:54 -0800 (PST)
Date: Sun, 24 Dec 2023 13:39:53 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
cc: akpm@linux-foundation.org, alim.akhtar@samsung.com, alyssa@rosenzweig.io, 
    asahi@lists.linux.dev, baolu.lu@linux.intel.com, bhelgaas@google.com, 
    cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com, 
    dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de, 
    iommu@lists.linux.dev, jernej.skrabec@gmail.com, jonathanh@nvidia.com, 
    joro@8bytes.org, krzysztof.kozlowski@linaro.org, linux-doc@vger.kernel.org, 
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org, linux-rockchip@lists.infradead.org, 
    linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
    linux-tegra@vger.kernel.org, lizefan.x@bytedance.com, marcan@marcan.st, 
    mhiramat@kernel.org, m.szyprowski@samsung.com, paulmck@kernel.org, 
    rdunlap@infradead.org, robin.murphy@arm.com, samuel@sholland.org, 
    suravee.suthikulpanit@amd.com, sven@svenpeter.dev, 
    thierry.reding@gmail.com, tj@kernel.org, tomas.mudrunka@gmail.com, 
    vdumpa@nvidia.com, wens@csie.org, will@kernel.org, yu-cheng.yu@intel.com
Subject: Re: [PATCH v2 07/10] iommu/sun50i: use page allocation function
 provided by iommu-pages.h
In-Reply-To: <20231130201504.2322355-8-pasha.tatashin@soleen.com>
Message-ID: <2a474224-80fa-3b71-c498-09cf22e5d130@google.com>
References: <20231130201504.2322355-1-pasha.tatashin@soleen.com> <20231130201504.2322355-8-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 30 Nov 2023, Pasha Tatashin wrote:

> Convert iommu/sun50i-iommu.c to use the new page allocation functions
> provided in iommu-pages.h.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Acked-by: David Rientjes <rientjes@google.com>

