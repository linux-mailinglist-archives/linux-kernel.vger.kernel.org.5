Return-Path: <linux-kernel+bounces-4439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A71817D1C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 282BDB23E05
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 22:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F09B740BC;
	Mon, 18 Dec 2023 22:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z0wNal1V"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30B8740B0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 22:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50e297d0692so2553792e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 14:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702937307; x=1703542107; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wsJa9VdYDRrbXCF+P/wnlKDM0XN+e4MY7opB/mrRfg8=;
        b=Z0wNal1VQ7Kdy/7b8yGl7s+thny0Aqm1eWmiURw2eSY/YQcsRYa479ySRHP+nkrU5d
         75fT0L+dyz9VNlWGQCsryiGrCuQvjtnQLzyxhHY7fY5MdF4VOIeSD5TzJaW3c/WrZt6F
         VD6RNtW4h3jRNzeMveulAdbVxj/0Y1BzoJqdevAGrBJsjZGst6vy+Iumn192oU6eXZSa
         otL5OOZ+SILo9zzhksHcmDTBe89I7BeGYpc+TIkxpt/iRt+dAKGCBxyi5PwR41vPOJ/3
         RPmPM52d+TA3MT/RuElliEO3GY1222T/WljQVPhia3FBtg2u9qf0ZAejNCaviBKdfaIx
         1HLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702937307; x=1703542107;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wsJa9VdYDRrbXCF+P/wnlKDM0XN+e4MY7opB/mrRfg8=;
        b=Uz9tmvhlWEEtWhPezbVXXYrxbPqSiGn6KltTiXXtjP/2258whl4xOylErBWCcjXXMl
         D8kT0MDzC3sFRlreoU9A2mN5NR42KNewogvpiSei21VkrAedW3+7JOecqbRZP4ThOIiX
         VPnwZ6rJJT1cikxYwgn8TxJRdWJFqP5jwfr+bf/a2zbTWyhq6AWjMraeC6QZBj6fGuNV
         InvYJ7geItbR74ehTKPDjnCUWZvzy0vbIZY5yUXEg3RxG0Pt/1uFKj5Lrg6Wwl1MzKZF
         GXVjZp0KNZ9tPG3xZF+M8vd3V8RJsLHRZdL4gP5Q7EB73EZwjOSWBdA6d9C9AcIomCoO
         C46Q==
X-Gm-Message-State: AOJu0YwIf2TkJIyP/2Wm92T0JLH4m5okmzh4ewnhHcXAWUT8NWvvJ/62
	lV2F9IRwG0HpYHrSdUI9IXLaQ1PbWcIV/A==
X-Google-Smtp-Source: AGHT+IEdfj+yQB03trrUmdxVJSj7D983Xg4QmP/J8O1XsOxdm8nbN0BEDhzbXyO11tY5JZQGk3Z7zw==
X-Received: by 2002:a05:6512:33d4:b0:50e:3007:620f with SMTP id d20-20020a05651233d400b0050e3007620fmr42489lfg.7.1702937306906;
        Mon, 18 Dec 2023 14:08:26 -0800 (PST)
Received: from [172.30.205.119] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id c16-20020a197610000000b0050bf30083b2sm2998297lff.142.2023.12.18.14.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 14:08:26 -0800 (PST)
Message-ID: <8e587947-4ae1-49c0-9d54-b95f9d539a7c@linaro.org>
Date: Mon, 18 Dec 2023 23:08:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/34] media: iris: introduce platform specific
 capabilities for core and instance
Content-Language: en-US
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com, agross@kernel.org,
 andersson@kernel.org, mchehab@kernel.org, bryan.odonoghue@linaro.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
 <1702899149-21321-14-git-send-email-quic_dikshita@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1702899149-21321-14-git-send-email-quic_dikshita@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/18/23 12:32, Dikshita Agarwal wrote:
> Capabilities are set of video specifications and features supported
> by a specific platform(SOC). Each capability is defined with
> min, max, range, default value and corresponding HFI.
> 
> Also, platform data defines different resource details for
> a specific platform(SOC). This change defines resource tables
> for sm8550 platform data and use for initializing these resources.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> ---
[...]
[...]

> -	ret = protect_secure_region(CP_START, CP_SIZE, CP_NONPIXEL_START,
> -				    CP_NONPIXEL_SIZE, IRIS_PAS_ID);
> +	cp_start = core->cap[CP_START].value;
> +	cp_size = core->cap[CP_SIZE].value;
> +	cp_nonpixel_start = core->cap[CP_NONPIXEL_START].value;
> +	cp_nonpixel_size = core->cap[CP_NONPIXEL_SIZE].value;
but you just hardcoded these a couple patches ago.. are they
variable after all?

[...]

> +	{DEC_CODECS, H264 | HEVC | VP9},
> +	{MAX_SESSION_COUNT, 16},
> +	{MAX_MBPF, 278528}, /* ((8192x4352)/256) * 2 */
> +	{MAX_MBPS, 7833600}, /* max_load 7680x4320@60fps */
> +	{NUM_VPP_PIPE, 4},
> +	{HW_RESPONSE_TIMEOUT, HW_RESPONSE_TIMEOUT_VALUE},
> +	{DMA_MASK, GENMASK(31, 29) - 1},
> +	{CP_START, 0},
> +	{CP_SIZE, 0x25800000},
> +	{CP_NONPIXEL_START, 0x01000000},
> +	{CP_NONPIXEL_SIZE, 0x24800000},
Why this and not an array of enum-indexed u32s?

> +};
> +
> +static struct plat_inst_cap instance_cap_data_sm8550[] = {
you know all of the possible members here as well, you can just
create a struct of actual configurations instead of turning them
into generic capabilities that you have to parse either way at
some point

[...]

> +
> +static const struct bus_info sm8550_bus_table[] = {
> +	{ NULL, "iris-cnoc", 1000, 1000     },
> +	{ NULL, "iris-ddr",  1000, 15000000 },
This is a copy of the common data from the previous patches that you're
now dropping (why was it there in the first place then?). Is it specific
to this platform, or can it be reused?
> +};
> +
> +static const struct clock_info sm8550_clk_table[] = {
> +	{ NULL, "gcc_video_axi0", GCC_VIDEO_AXI0_CLK, 0 },
> +	{ NULL, "core_clk",       VIDEO_CC_MVS0C_CLK, 0 },
> +	{ NULL, "vcodec_core",    VIDEO_CC_MVS0_CLK,  1 },
> +};
Are these the input pad names?

> +
> +static const char * const sm8550_clk_reset_table[] = { "video_axi_reset", NULL };
Ditto

> +
> +static const char * const sm8550_pd_table[] = { "iris-ctl", "vcodec", NULL };
Ditto

> +
> +static const char * const sm8550_opp_pd_table[] = { "mxc", "mmcx", NULL };
Ditto

> +
> +static const struct bw_info sm8550_bw_table_dec[] = {
> +	{ 2073600, 1608000, 2742000 },	/* 4096x2160@60 */
> +	{ 1036800,  826000, 1393000 },	/* 4096x2160@30 */
> +	{  489600,  567000,  723000 },	/* 1920x1080@60 */
> +	{  244800,  294000,  372000 },	/* 1920x1080@30 */
> +};
> +
> +static const struct reg_preset_info sm8550_reg_preset_table[] = {
> +	{ 0xB0088, 0x0, 0x11 },
lowercase hex for non-defines, please
> +};
> +
> +static struct ubwc_config_data ubwc_config_sm8550[] = {
> +	UBWC_CONFIG(8, 32, 16, 0, 1, 1, 1),
I think it would be far more telling to drop this #define and fill
in the values inline

> +};
> +
> +struct platform_data sm8550_data = {
> +	.bus_tbl = sm8550_bus_table,
> +	.bus_tbl_size = ARRAY_SIZE(sm8550_bus_table),
> +	.clk_tbl = sm8550_clk_table,
> +	.clk_tbl_size = ARRAY_SIZE(sm8550_clk_table),
> +	.clk_rst_tbl = sm8550_clk_reset_table,
> +	.clk_rst_tbl_size = ARRAY_SIZE(sm8550_clk_reset_table),
> +
> +	.bw_tbl_dec = sm8550_bw_table_dec,
> +	.bw_tbl_dec_size = ARRAY_SIZE(sm8550_bw_table_dec),
> +
> +	.pd_tbl = sm8550_pd_table,
> +	.pd_tbl_size = ARRAY_SIZE(sm8550_pd_table),
> +	.opp_pd_tbl = sm8550_opp_pd_table,
> +	.opp_pd_tbl_size = ARRAY_SIZE(sm8550_opp_pd_table),
> +
> +	.reg_prst_tbl = sm8550_reg_preset_table,
> +	.reg_prst_tbl_size = ARRAY_SIZE(sm8550_reg_preset_table),
> +	.fwname = "vpu30_4v.mbn",
> +	.pas_id = 9,
> +
> +	.core_data = core_data_sm8550,
> +	.core_data_size = ARRAY_SIZE(core_data_sm8550),
> +	.inst_cap_data = instance_cap_data_sm8550,
> +	.inst_cap_data_size = ARRAY_SIZE(instance_cap_data_sm8550),
> +	.ubwc_config = ubwc_config_sm8550,
Unless any of these are going to be reused, please inline all of the
values here..

Konrad

