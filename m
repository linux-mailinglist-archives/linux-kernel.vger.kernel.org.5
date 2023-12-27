Return-Path: <linux-kernel+bounces-11735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBC681EAFC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 01:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99EA02833CE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 00:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3420C1FBE;
	Wed, 27 Dec 2023 00:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CrnZQeIp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614434428
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 00:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d3ea8d0f9dso464935ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 16:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703636859; x=1704241659; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tWB8GEfhgaG2StCZxtDIu7qsHSf/rZ4sNtnlAoGbWAQ=;
        b=CrnZQeIpKav4Cx1+pi85tQ/J2VP4ZQV4SfFgznLL0bZxyTBd2fdhWVomTtTzcB9b5p
         7UgLg//yi5Oa7lbYXXuilviOf261D1+VbLRE0X59BYC2vFFQrUV0cOepxikHehjOXGsA
         w3tO5+jRe+shjZxQhy6hxO3hY/HCpLz0xdkbIz2U5FG+oUJtqVw4/ri4Q5wXjZXSW9zc
         DNWq+OTkf6C//zJ1XHh9sPxSku6GX5fflurK9PhT+SzNadOq6S8Tt4dHAkB/IsnQaJhI
         AAK3ildEWGVLvxZi7h/srDjS8+HCpyfqb8m92Zdzs8SpEJMkZpHiqZWUhu6aH5PKWC78
         hVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703636859; x=1704241659;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tWB8GEfhgaG2StCZxtDIu7qsHSf/rZ4sNtnlAoGbWAQ=;
        b=paYWNey3X26xibCR9gUS80SNCASM96eex7OdTNbaVPNXx49yBIo1D3U53TgDHSa7JU
         NJJQetNmraqjNOIljFxADFDbAWmRhZr2EyRtt/Lq3M1TKmiH4KL0vRJDC682YRjJDGTS
         3LX3Az+C/oTxknx031y4R/2q25bXCjSxkigu9dVKIgtkV4BMriqnXKblNt40PgCvvIh2
         rakYCuPBWb21QpyPzivY0Ag3EHyXZSJIWVDFp4egLXRGkq0xxXVlWW4o1F7XZv4qZIMQ
         WsysOqAhv1QlvzM+4QIFsT3YO24gFtkSm2qnT8PgvdLEtAl/iCt5D9F0SCurjfzJnFx1
         GqUQ==
X-Gm-Message-State: AOJu0YwP5jdI2p42VLaX80okQqaI8CkIUV8K0Oxva2gLcHhZQNH3j+Fy
	+Zf9piuvYz8Q+J/WMoyxvkvhzVFZCqJm
X-Google-Smtp-Source: AGHT+IEt5kz+5IRUGXbqQvg0LHmZbhtvIOnJMwFJGwN1byHl8pOfJREKbeZKfGVR7i5FozKA6XE7xw==
X-Received: by 2002:a17:902:d508:b0:1d4:69f7:792b with SMTP id b8-20020a170902d50800b001d469f7792bmr170997plg.17.1703636858562;
        Tue, 26 Dec 2023 16:27:38 -0800 (PST)
Received: from [2620:0:1008:15:5a8c:89e6:ca2f:ea30] ([2620:0:1008:15:5a8c:89e6:ca2f:ea30])
        by smtp.gmail.com with ESMTPSA id l7-20020a170902f68700b001d39af62b1fsm10527546plg.232.2023.12.26.16.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 16:27:38 -0800 (PST)
Date: Tue, 26 Dec 2023 16:27:37 -0800 (PST)
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
Subject: Re: [PATCH v3 01/10] iommu/vt-d: add wrapper functions for page
 allocations
In-Reply-To: <20231226200205.562565-2-pasha.tatashin@soleen.com>
Message-ID: <c8311c45-72e3-8ff2-c206-3dd21f6a9bed@google.com>
References: <20231226200205.562565-1-pasha.tatashin@soleen.com> <20231226200205.562565-2-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 26 Dec 2023, Pasha Tatashin wrote:

> In order to improve observability and accountability of IOMMU layer, we
> must account the number of pages that are allocated by functions that
> are calling directly into buddy allocator.
> 
> This is achieved by first wrapping the allocation related functions into a
> separate inline functions in new file:
> 
> drivers/iommu/iommu-pages.h
> 
> Convert all page allocation calls under iommu/intel to use these new
> functions.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Acked-by: David Rientjes <rientjes@google.com>

