Return-Path: <linux-kernel+bounces-137222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4133289DF15
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16C5B28C9F2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5871E13D8A4;
	Tue,  9 Apr 2024 15:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnGODQoN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6007013D891;
	Tue,  9 Apr 2024 15:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712676396; cv=none; b=BKD7McxvEnjEvYjqpNBGbFboag0x6b4A1HWNe/Z23klNOK9zFdxRzq9bHWH5fNooxC3La5RhEtQUeZAdEz4ECG8CQpHa1ErRQR38nVgjwz09PHaOuIw9dbYwcvmWenEmIo115zE3npxAvCCCp8uoKJyhlyKJZgtI9shnZCPnlzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712676396; c=relaxed/simple;
	bh=OymyiDNf4YW49xGrZ+gXBk6psnOk8MiiogrmhOiNcXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4hKoWXG1QNuKF9Rym8cntA8fiIYJgSMVKIf1/yDesfEMoq4WP1zSJGIQICU7iT2JuVmpJ17CO6WZ0YiEaDv5SxPPR8Y2HEzkeg7q9X1OjbLbnh/c4j5Gq/ueKOcoZ2LY/qwaydszvUCiCkqo2gLttPILkDIqE1JKNxH6FpPMYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnGODQoN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81708C43390;
	Tue,  9 Apr 2024 15:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712676395;
	bh=OymyiDNf4YW49xGrZ+gXBk6psnOk8MiiogrmhOiNcXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pnGODQoNm1sF/Hwhx/x6or1eK83G+5sisNDHVxdxJib16K/EkjwscrCNNcJbXBP9K
	 35TjBkFXzRRF1C6IVMk3h24ux8P4mWOm1oSxWPCfECO+KsVry/8YDIvdUKP+NK9RuS
	 tQzBy6VAN5YnfIR7dkvXtSA0eAJGGC8gHkLdcHVde3aFcp1yoX8NQNg/hGQVrZG5Lq
	 SF/ETWwUnfmiE35TDlMU8pvp1GK7jK+yREt6ial+dqfOIAq1kfjWg3VN6MwdaFLBrw
	 snfonA8cFCTX5ItW8G+zR+Bi8CWGhlVoJg5njGzbjhOWLfmklvncL1/i1W1WnpPB8G
	 hDTKD5GwIbFYg==
Date: Tue, 9 Apr 2024 16:26:28 +0100
From: Will Deacon <will@kernel.org>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: frank.li@nxp.com, mark.rutland@arm.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, john.g.garry@oracle.com, jolsa@kernel.org,
	namhyung@kernel.org, irogers@google.com, mike.leach@linaro.org,
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v8 3/8] perf: imx_perf: let the driver manage the counter
 usage rather the user
Message-ID: <20240409152627.GA23621@willie-the-truck>
References: <20240322063930.749126-1-xu.yang_2@nxp.com>
 <20240322063930.749126-3-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322063930.749126-3-xu.yang_2@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Mar 22, 2024 at 02:39:25PM +0800, Xu Yang wrote:
> In current design, the user of perf app needs to input counter ID to count
> events. However, this is not user-friendly since the user needs to lookup
> the map table to find the counter. Instead of letting the user to input
> the counter, let this driver to manage the counters in this patch.

I think we still have to support the old interface so that we don't break
those existing users (even if the driver just ignores whatever counter ID
is provided in a backwards-compatible way).

> This will be implemented by:
>  1. allocate counter 0 for cycle event.
>  2. find unused counter from 1-10 for reference events.
>  3. allocate specific counter for counter-specific events.
> 
> In this patch, counter attribute is removed too. To mark counter-specific
> events, counter ID will be encoded into perf_pmu_events_attr.id.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> 
> ---
> Changes in v6:
>  - new patch
> Changes in v7:
>  - no changes
> Changes in v8:
>  - add Rb tag
> ---
>  drivers/perf/fsl_imx9_ddr_perf.c | 168 ++++++++++++++++++-------------
>  1 file changed, 99 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
> index 0017f2c9ef91..b728719b494c 100644
> --- a/drivers/perf/fsl_imx9_ddr_perf.c
> +++ b/drivers/perf/fsl_imx9_ddr_perf.c
> @@ -245,14 +249,12 @@ static const struct attribute_group ddr_perf_events_attr_group = {
>  	.attrs = ddr_perf_events_attrs,
>  };
>  
> -PMU_FORMAT_ATTR(event, "config:0-7");
> -PMU_FORMAT_ATTR(counter, "config:8-15");
> +PMU_FORMAT_ATTR(event, "config:0-15");

Sadly, this is a user-visible change so I think it will break old tools,
won't it?

Will

