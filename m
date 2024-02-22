Return-Path: <linux-kernel+bounces-76504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DF385F80A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFCFA1F248AE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A23360B93;
	Thu, 22 Feb 2024 12:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToZBtbdG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8476F51031;
	Thu, 22 Feb 2024 12:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708604630; cv=none; b=dx95ppMOHHKXgdzNKg49nhEi5fXm6UQGFwz4o9wiFNIkhwV1cOJIJnZnBk6mcvm2NMtE736uJbFrSF3lM1b1Yq7vSNmfF9cXOLOF/7V3M8J/S9C5YaIBOC0++ffSrbZRO3kJ06E6EOpArHhGLn0F+LqgWgIh88mdYQOjTW6qgjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708604630; c=relaxed/simple;
	bh=fXftZTVW/nwvXX0LAYCCLyy5b88uDduzlIcQF1WbDJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/808dzB8uppSmd5m/lbTnv6LmRTdbR2iWQpKW8BsxssQDgloQbwqnWI1bSfrXVj2uH3GmPSCCMmnM2Dg1N9YwbCK4yElFKMVL1Yx+ghMFGjOlGC6pGCvtHzW3cDoqEJMv0LIy0Yt1a39iIKTIejz+mpM+cF/bFrC0MJXUfThD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToZBtbdG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A4BC433F1;
	Thu, 22 Feb 2024 12:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708604630;
	bh=fXftZTVW/nwvXX0LAYCCLyy5b88uDduzlIcQF1WbDJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ToZBtbdGSt5Vu5AvcI1jj5zV/j6Cv4LyR63tG1ht77yAd8/7nBtOuYhrFZoowNset
	 XR6fsxdpGY686h/Ib7I8JzOc01ZuZ9liV5MYVEZ3i74XO8wXRcRBUA6mHuqUz15+0I
	 RSRjp52aH/vXUQbhiKZCZEzSGRUpDycGCfDawMu4qwDLSTHJX86Xjql2gHQWYDHvfJ
	 NPJX5EivYXpndeL4eQ3Bpr/dS/PEkFanch1dzKVqIxgeoo+pxyGHzadKZKlFCN70BW
	 3+omj34h0/55eP2dddORjGu7nXruWkB38HF0bQmEzFN5UB2xcPydCwJp9h7nAN2mgE
	 4ru/raDSwju/A==
Date: Thu, 22 Feb 2024 12:23:41 +0000
From: Will Deacon <will@kernel.org>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: Frank.li@nxp.com, mark.rutland@arm.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, john.g.garry@oracle.com, jolsa@kernel.org,
	namhyung@kernel.org, irogers@google.com, linux-imx@nxp.com,
	mike.leach@linaro.org, leo.yan@linaro.org, peterz@infradead.org,
	mingo@redhat.com, acme@kernel.org,
	alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v4 4/6] perf: imx_perf: add macro definitions for parsing
 config attr
Message-ID: <20240222122341.GC8308@willie-the-truck>
References: <20240131055811.3035741-1-xu.yang_2@nxp.com>
 <20240131055811.3035741-4-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131055811.3035741-4-xu.yang_2@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Jan 31, 2024 at 01:58:09PM +0800, Xu Yang wrote:
> The user can set event and counter in cmdline and the driver need to parse
> it using 'config' attr value. This will add macro definitions to avoid
> hard-code in driver.
> 
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> 
> ---
> Changes in v4:
>  - new patch
> ---
>  drivers/perf/fsl_imx9_ddr_perf.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
> index 85aaaef7212f..94041f06c152 100644
> --- a/drivers/perf/fsl_imx9_ddr_perf.c
> +++ b/drivers/perf/fsl_imx9_ddr_perf.c
> @@ -52,6 +52,11 @@
>  #define NUM_COUNTERS		11
>  #define CYCLES_COUNTER		0
>  
> +#define CONFIG_EVENT_MASK	0x00FF
> +#define CONFIG_EVENT_OFFSET	0
> +#define CONFIG_COUNTER_MASK	0xFF00
> +#define CONFIG_COUNTER_OFFSET	8

Can you move this patch earlier, please, so that the imx95 support can use
these new definitions immediately?

Will

