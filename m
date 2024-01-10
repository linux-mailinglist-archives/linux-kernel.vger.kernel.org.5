Return-Path: <linux-kernel+bounces-21790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAE582944F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 08:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E38B91F27155
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 07:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2685E39FCC;
	Wed, 10 Jan 2024 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ak4OHJZG"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1E039AF4
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 07:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-59879109c33so907762eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 23:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704871749; x=1705476549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wo2ow3R5rRd9qIwMEMsgAnkS6j0WPS9tTieV0e+8cjc=;
        b=ak4OHJZG0U+Gm+9znDg742WwHTekzoLHC0hUsY3HWxdn4+Z++frQkXK7d4OfDy7Kdx
         CUs47DfLOXf3obL/l8UKgjzY9Dg51fQO8bwacOjZELK4LsAAJ8DhW04ZLltkz8xKJlKL
         sfXITp1nIc6vy6bvRhtDHw4tcB9tYAFYBZrgIi1lH3vFpjOycmsa6oHFqkBj9sD8udFt
         StATYFxZAGppFhtCm5J/KiVTBdynp7ulCm9RoG6vEpmqHm4vowt7VoCMH3y7z0rMVdP7
         dxU0wGyfjNpcesUXCeELSzgqAy4gXA7zNzBcfQSD9miyW2JiaFaBhRs8uXsSd6uvo7m5
         An9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704871749; x=1705476549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wo2ow3R5rRd9qIwMEMsgAnkS6j0WPS9tTieV0e+8cjc=;
        b=NS6HeZXt7OljIeVFqQwHIBUX3vEMT+t0Hsp2M+m8U/ITM6LXhYHsvoz7SwRZhUnzLD
         uqel3u76Ho0LK9Kb6udga1YhF+yg178v4C8SAvnTGU03ExSg5J9J85TL39tDD68WMonb
         Nimlc8fn8w5XQqyTt2MbMsxNkW+l+3c+mwjo1XJLFj28LefBGasMdYAOf0PDlzf2auzw
         KFFhbhBjtNJiedf65p2DKNRialIQSIcxqmB5oMCmKrGcpe5aH5XIlhjRH2gw2SLeNj2w
         vEEM3WuidH6hN37+owzIp0ojBODqaEcmtkqT0P5xIiJBJxe8Q1nUtlRsHSG19s3N12iB
         yntg==
X-Gm-Message-State: AOJu0YzDPnbgqaVjK5pZ4a6MIViJ0S1w9FVIjROYQozyZt+UCzwTMw+K
	gsVW5Cp/Mqqgc3q/J3vZZeNt973tbx4SGA==
X-Google-Smtp-Source: AGHT+IFBaMUQIrZ5GE8hoUnVwohwAlLo7uTYGkTzq+F0FKAwPL8/m4gCZV61h+d7TvAYjRrRkyIYZg==
X-Received: by 2002:a05:6358:e4a3:b0:175:61e3:4ca8 with SMTP id by35-20020a056358e4a300b0017561e34ca8mr550444rwb.44.1704871748972;
        Tue, 09 Jan 2024 23:29:08 -0800 (PST)
Received: from localhost ([122.172.81.83])
        by smtp.gmail.com with ESMTPSA id fh12-20020a056a00390c00b006d0d90edd2csm2842919pfb.42.2024.01.09.23.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 23:29:08 -0800 (PST)
Date: Wed, 10 Jan 2024 12:59:06 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, rafael@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_mdtipton@quicinc.com,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/3] firmware: arm_scmi: Add perf_opp_xlate interface
Message-ID: <20240110072906.7vnqykkcw3rkhoxa@vireshk-i7>
References: <20240108140118.1596-1-quic_sibis@quicinc.com>
 <20240108140118.1596-3-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108140118.1596-3-quic_sibis@quicinc.com>

On 08-01-24, 19:31, Sibi Sankar wrote:
> Add a new perf_opp_xlate interface to the existing perf_ops to translate
> a given perf index to frequency.
> 
> This can be used by the cpufreq driver and framework to determine the
> throttled frequency from a given perf index and apply HW pressure
> accordingly.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>  drivers/firmware/arm_scmi/perf.c | 21 +++++++++++++++++++++
>  include/linux/scmi_protocol.h    |  3 +++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
> index c167bb5e3607..f26390924e1c 100644
> --- a/drivers/firmware/arm_scmi/perf.c
> +++ b/drivers/firmware/arm_scmi/perf.c
> @@ -964,6 +964,26 @@ static int scmi_notify_support(const struct scmi_protocol_handle *ph, u32 domain
>  	return 0;
>  }
>  
> +static int scmi_perf_opp_xlate(const struct scmi_protocol_handle *ph, u32 domain,
> +			       int idx, unsigned long *freq)
> +{
> +	struct perf_dom_info *dom;
> +
> +	dom = scmi_perf_domain_lookup(ph, domain);
> +	if (IS_ERR(dom))
> +		return PTR_ERR(dom);
> +
> +	if (idx >= dom->opp_count)
> +		return -ERANGE;
> +
> +	if (!dom->level_indexing_mode)
> +		*freq = dom->opp[idx].perf * dom->mult_factor;
> +	else
> +		*freq = dom->opp[idx].indicative_freq * dom->mult_factor;
> +
> +	return 0;
> +}
> +
>  static const struct scmi_perf_proto_ops perf_proto_ops = {
>  	.num_domains_get = scmi_perf_num_domains_get,
>  	.info_get = scmi_perf_info_get,
> @@ -979,6 +999,7 @@ static const struct scmi_perf_proto_ops perf_proto_ops = {
>  	.fast_switch_possible = scmi_fast_switch_possible,
>  	.power_scale_get = scmi_power_scale_get,
>  	.perf_notify_support = scmi_notify_support,
> +	.perf_opp_xlate = scmi_perf_opp_xlate,

The use of "opp" here is a bit confusing as this doesn't have anything to do
with the OPP framework and you are only getting the frequency out of it after
all.

-- 
viresh

