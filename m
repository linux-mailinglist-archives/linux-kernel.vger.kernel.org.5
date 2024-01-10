Return-Path: <linux-kernel+bounces-21614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5058291E3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 02:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACA2C1C23857
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 01:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105C817C8;
	Wed, 10 Jan 2024 01:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jx5OGt22"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA08EC7
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 01:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-28bc8540299so2172237a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 17:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704849261; x=1705454061; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P0QW46Gis+61G/am4G3OnlXBRgJBpR8nOsCNrDI0sD8=;
        b=Jx5OGt229aC2z8kbAMoVpUDoEj4N94X3CzTdWjehz7YMabPnJBWEvvEVu2tTO9IpLf
         Bo9XPdHtd/7kTx9A1sR/0T6Ifh+gcbQxy61g7+c0xlTufDZleKwyd1UJhM2IVHXabdvf
         Ipe4KcDJPDhp5uk9UoCu/GbItzGWhO4IfgJ5GwvEuVys5rSiRdwlVdKSMCNCOvUN8elR
         stTNlPIlGMUNqPASvkndEQeWnbm9WcAgFa/OexWmD+BFgi/cpcursjHp0152vGMh9PYH
         upw5ei6PbSxh89RpesvP0YpJ+5NHkWMrGODpNUjuyhFGlOpWE0PAZVdOQHxn1gRpT5NW
         O7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704849261; x=1705454061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0QW46Gis+61G/am4G3OnlXBRgJBpR8nOsCNrDI0sD8=;
        b=FuniBBdWUHngBuXm0TRGg3NfSM3VUg4H8t3Hg9EUrRZQWFXZJumVNvp33XBkV+TdZU
         OYRtxSc6y3Ir3Q6HTiK+JN2PwxrESMAsauv6JPfU0eCJrHg0wvRTyqyvwje7xkXCSCDj
         JybDdP4EA0Brr+vpSSi8bIqL5owXdf+4D/K4sCobx2s7/wCu7JD/lk44+xdxdW3sTf5v
         zOYOqUu9dzUSTvuLrBlncak6oKPqWOv1jDYHjS3gjPmqCeCZADLB5v4OSG7QZbyOY/UY
         o9YV7USq8vbiY8m9IlJWrDZBimOp0Ucu8R6ZhKT245V2hzIArDE0XTr/ioEH8gtS02at
         nd0g==
X-Gm-Message-State: AOJu0YxQTxcIvgFPyiOnBdUPsr+XNRYqaS324Zef1ylx+jtshKeS8fHL
	g9OZf+VBSpz3cwjoIyBve/TDD4EujGweNA==
X-Google-Smtp-Source: AGHT+IHFZW5QjM5bsJ4IwgGYllbjTit0iYgpIyphSzLzLhYj8lH6rkx9T2tEfel77gaAg/WPdDTpAQ==
X-Received: by 2002:a17:90a:31c8:b0:28c:3042:f8cb with SMTP id j8-20020a17090a31c800b0028c3042f8cbmr119341pjf.21.1704849261353;
        Tue, 09 Jan 2024 17:14:21 -0800 (PST)
Received: from debian-dev (211-75-219-200.hinet-ip.hinet.net. [211.75.219.200])
        by smtp.gmail.com with ESMTPSA id js16-20020a17090b149000b0028c2de909e4sm136337pjb.50.2024.01.09.17.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 17:14:20 -0800 (PST)
Date: Wed, 10 Jan 2024 09:14:13 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Besar Wicaksono <bwicaksono@nvidia.com>
Cc: acme@redhat.com, catalin.marinas@arm.com, will@kernel.org,
	john.g.garry@oracle.com, james.clark@arm.com, mike.leach@linaro.org,
	peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	namhyung@kernel.org, irogers@google.com, alisaidi@amazon.com,
	vsethi@nvidia.com, rwiley@nvidia.com, ywan@nvidia.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-tegra@vger.kernel.org,
	treding@nvidia.com, jonathanh@nvidia.com
Subject: Re: [PATCH v1 3/3] perf arm-spe: Add Neoverse-V2 to neoverse list
Message-ID: <20240110011413.GA44@debian-dev>
References: <20240109192310.16234-1-bwicaksono@nvidia.com>
 <20240109192310.16234-4-bwicaksono@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109192310.16234-4-bwicaksono@nvidia.com>

On Tue, Jan 09, 2024 at 01:23:10PM -0600, Besar Wicaksono wrote:
> Add Neoverse-V2 MIDR to neoverse_spe range list.
> 
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>

This patch series looks good to me:

Reviewed-by: Leo Yan <leo.yan@linaro.org>

