Return-Path: <linux-kernel+bounces-158538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AB88B21D4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B2A51C21039
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00F11494DD;
	Thu, 25 Apr 2024 12:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jliPpKTR"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0E615AF6;
	Thu, 25 Apr 2024 12:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714049098; cv=none; b=JBv7CXlW/q7ye3oCM9Ms7MG8tRzKgOLrlgK2S+l0K216gZrKO4MKogBBNijrE7f4JfhuD8WHCi7e1sTG+UAYXJX6G0lZzqrWqE4fgkNuTZGJ40adqGF7iVgf5jAL7kYrTJOVOYT+NUNw2JK6WkQnD0lUVtdssr0+Rkuku+iHxQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714049098; c=relaxed/simple;
	bh=D43K3jGpaVU4uuG+SzR2bPrRRMUie46lvzgtWhcBk5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lFzXBmuTVaWQJtTfM0grfOA5RJQszVhlXRcEoSTdyBVXktEiJTgMkkm3oWjy1HyJnYSnw91PYx+T4WOjRrMdwptndX2m2gMdFZbSka6MOPO4rQFDLxsqQwmuz/2N00z9LgJkDJJ8GVNAm7pFSEAFWPxny/2byPGUiTwLuauDOkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jliPpKTR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PAQ0PL022550;
	Thu, 25 Apr 2024 12:44:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=gb4M3yEdzjmZ4GUFRr68nZ3b7wVJweDCfsDPC1ukULA=; b=jl
	iPpKTRsIXhB0mrjdCWxDfGSb584VZhHb6Eyo0lIYKvfEpEbRTGakNC9g0JZHvul/
	aW5INOmv6tEdkICDWsuCYl6/sPzUAu5p9Ab8s7SYB3DGaXjeJcpBY8gD2dhsMud9
	j6LUXFmfIIxCI9fofLgTOr1ir9R3Ix3cAQNy98bCwKKJZY9TheVU9doGLRDgsAfI
	mYCsvpczu5vDqhmoZ/JOP0SSrNcyLcfD6Wq9GSgMY1rWIadBrCyy1b3g6SkpQ0mg
	DBzdho3uP6dQwl3z7BDwEPdBur1WK6d4pqkBGjwmIJq4+0UMY1z627ZnaV+7kOxi
	WmljZTn3UWRrEO2AMzsw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqengjjkk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 12:44:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PCielI020600
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 12:44:40 GMT
Received: from [10.111.139.7] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Apr
 2024 05:44:36 -0700
Message-ID: <d0f49fdd-8a7e-0f08-a843-7c6640ccf6d2@quicinc.com>
Date: Thu, 25 Apr 2024 18:14:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 15/19] media: venus: pm_helpers: Simplify vcodec clock
 handling
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stanimir Varbanov
	<stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross
	<agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Mauro Carvalho
 Chehab" <mchehab@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC: Marijn Suijten <marijn.suijten@somainline.org>,
        Stanimir Varbanov
	<stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab
	<mchehab+huawei@kernel.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230911-topic-mars-v3-0-79f23b81c261@linaro.org>
 <20230911-topic-mars-v3-15-79f23b81c261@linaro.org>
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <20230911-topic-mars-v3-15-79f23b81c261@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RXYKBqi6sEPYKxB20gHaBJntNomUuC5q
X-Proofpoint-ORIG-GUID: RXYKBqi6sEPYKxB20gHaBJntNomUuC5q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_12,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250093

Hi Konrad,

On 3/27/2024 11:38 PM, Konrad Dybcio wrote:
> Currently the infrastructure is set up for vast expandability, but
> it's far too complex for what is just 0-2 clocks. Categorize the
> clocks and simplify their getting.
> 
> One notable change is that vcodec clocks are switched to use
> devm_clk_get_optional, which will let us commonize the code further
> while leaving the burden of figuring out which SoCs need codec-specific
> clocks and which don't to the bindings checker.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/core.c       |  18 ----
>  drivers/media/platform/qcom/venus/core.h       |  13 ++-
>  drivers/media/platform/qcom/venus/pm_helpers.c | 129 +++++++++++++------------
>  3 files changed, 71 insertions(+), 89 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index e61aa863b7f7..1f4a86b1bd73 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -581,9 +581,6 @@ static const struct venus_resources msm8996_res = {
>  	.reg_tbl_size = ARRAY_SIZE(msm8996_reg_preset),
>  	.clks = {"core", "iface", "bus", "mbus" },
>  	.clks_num = 4,
> -	.vcodec0_clks = { "core" },
> -	.vcodec1_clks = { "core" },
> -	.vcodec_clks_num = 1,
>  	.max_load = 2563200,
>  	.hfi_version = HFI_VERSION_3XX,
>  	.dma_mask = (GENMASK(31, 30) | GENMASK(28, 26) | GENMASK(24, 22)) - 1,
> @@ -636,9 +633,6 @@ static const struct venus_resources sdm660_res = {
>  	.bw_tbl_dec_size = ARRAY_SIZE(sdm660_bw_table_dec),
>  	.clks = {"core", "iface", "bus", "bus_throttle" },
>  	.clks_num = 4,
> -	.vcodec0_clks = { "vcodec0_core" },
> -	.vcodec1_clks = { "vcodec0_core" },
> -	.vcodec_clks_num = 1,
>  	.max_load = 1036800,
>  	.hfi_version = HFI_VERSION_3XX,
>  	.cp_size = 0x79000000,
> @@ -680,9 +674,6 @@ static const struct venus_resources sdm845_res = {
>  	.bw_tbl_dec_size = ARRAY_SIZE(sdm845_bw_table_dec),
>  	.clks = {"core", "iface", "bus" },
>  	.clks_num = 3,
> -	.vcodec0_clks = { "core", "bus" },
> -	.vcodec1_clks = { "core", "bus" },
> -	.vcodec_clks_num = 2,
>  	.max_load = 3110400,	/* 4096x2160@90 */
>  	.hfi_version = HFI_VERSION_4XX,
>  	.vpu_version = VPU_VERSION_AR50,
> @@ -699,9 +690,6 @@ static const struct venus_resources sdm845_res_v2 = {
>  	.bw_tbl_dec_size = ARRAY_SIZE(sdm845_bw_table_dec),
>  	.clks = {"core", "iface", "bus" },
>  	.clks_num = 3,
> -	.vcodec0_clks = { "vcodec0_core", "vcodec0_bus" },
> -	.vcodec1_clks = { "vcodec1_core", "vcodec1_bus" },
> -	.vcodec_clks_num = 2,
>  	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0", "vcodec1" },
>  	.vcodec_pmdomains_num = 3,
>  	.opp_pmdomain = pd_names_cx,
> @@ -744,8 +732,6 @@ static const struct venus_resources sc7180_res = {
>  	.bw_tbl_dec_size = ARRAY_SIZE(sc7180_bw_table_dec),
>  	.clks = {"core", "iface", "bus" },
>  	.clks_num = 3,
> -	.vcodec0_clks = { "vcodec0_core", "vcodec0_bus" },
> -	.vcodec_clks_num = 2,
>  	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
>  	.vcodec_pmdomains_num = 2,
>  	.opp_pmdomain = pd_names_cx,
> @@ -796,8 +782,6 @@ static const struct venus_resources sm8250_res = {
>  	.clks_num = 2,
>  	.resets = { "bus", "core" },
>  	.resets_num = 2,
> -	.vcodec0_clks = { "vcodec0_core" },
> -	.vcodec_clks_num = 1,
>  	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
>  	.vcodec_pmdomains_num = 2,
>  	.opp_pmdomain = pd_names_mx,
> @@ -851,8 +835,6 @@ static const struct venus_resources sc7280_res = {
>  	.ubwc_conf = &sc7280_ubwc_config,
>  	.clks = {"core", "bus", "iface"},
>  	.clks_num = 3,
> -	.vcodec0_clks = {"vcodec_core", "vcodec_bus"},
> -	.vcodec_clks_num = 2,
>  	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
>  	.vcodec_pmdomains_num = 2,
>  	.opp_pmdomain = pd_names_cx,
> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> index 19908f028441..b4c41dc0f8c7 100644
> --- a/drivers/media/platform/qcom/venus/core.h
> +++ b/drivers/media/platform/qcom/venus/core.h
> @@ -24,9 +24,10 @@
>  #define VDBGFW	"VenusFW  : "
>  
>  #define VIDC_CLKS_NUM_MAX		4
> -#define VIDC_VCODEC_CLKS_NUM_MAX	2
>  #define VIDC_RESETS_NUM_MAX		2
>  
> +#define MAX_NUM_VCODECS			2
> +
>  extern int venus_fw_debug;
>  
>  struct freq_tbl {
> @@ -68,8 +69,6 @@ struct venus_resources {
>  	const struct hfi_ubwc_config *ubwc_conf;
>  	const char * const clks[VIDC_CLKS_NUM_MAX];
>  	unsigned int clks_num;
> -	const char * const vcodec0_clks[VIDC_VCODEC_CLKS_NUM_MAX];
> -	const char * const vcodec1_clks[VIDC_VCODEC_CLKS_NUM_MAX];
>  	unsigned int vcodec_clks_num;
>  	const char **vcodec_pmdomains;
>  	unsigned int vcodec_pmdomains_num;
> @@ -123,8 +122,8 @@ struct venus_format {
>   * @aon_base:	AON base address
>   * @irq:		Venus irq
>   * @clks:	an array of struct clk pointers
> - * @vcodec0_clks: an array of vcodec0 struct clk pointers
> - * @vcodec1_clks: an array of vcodec1 struct clk pointers
> + * @vcodec_core_clks: an array of codec core clk pointers
> + * @vcodec_bus_clks: an array of codec bus clk pointers
>   * @video_path: an interconnect handle to video to/from memory path
>   * @cpucfg_path: an interconnect handle to cpu configuration path
>   * @has_opp_table: does OPP table exist
> @@ -176,8 +175,8 @@ struct venus_core {
>  	void __iomem *aon_base;
>  	int irq;
>  	struct clk *clks[VIDC_CLKS_NUM_MAX];
> -	struct clk *vcodec0_clks[VIDC_VCODEC_CLKS_NUM_MAX];
> -	struct clk *vcodec1_clks[VIDC_VCODEC_CLKS_NUM_MAX];
> +	struct clk *vcodec_core_clks[MAX_NUM_VCODECS];
> +	struct clk *vcodec_bus_clks[MAX_NUM_VCODECS];
>  	struct icc_path *video_path;
>  	struct icc_path *cpucfg_path;
>  	bool has_opp_table;
> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
> index d717e150b34f..583153bbb74e 100644
> --- a/drivers/media/platform/qcom/venus/pm_helpers.c
> +++ b/drivers/media/platform/qcom/venus/pm_helpers.c
> @@ -110,67 +110,74 @@ static void core_clks_disable(struct venus_core *core)
>  
>  static int core_clks_set_rate(struct venus_core *core, unsigned long freq)
>  {
> -	int ret;
> +	int i, ret;
>  
>  	ret = dev_pm_opp_set_rate(core->dev, freq);
>  	if (ret)
>  		return ret;
>  
> -	ret = clk_set_rate(core->vcodec0_clks[0], freq);
> -	if (ret)
> -		return ret;
> -
> -	ret = clk_set_rate(core->vcodec1_clks[0], freq);
> -	if (ret)
> -		return ret;
> +	for (i = 0; i < MAX_NUM_VCODECS; i++) {
> +		ret = clk_set_rate(core->vcodec_core_clks[i], freq);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	return 0;
>  }
>  
> -static int vcodec_clks_get(struct venus_core *core, struct device *dev,
> -			   struct clk **clks, const char * const *id)
> +static int vcodec_clks_get(struct venus_core *core, struct device *dev, u8 id)
>  {
> -	const struct venus_resources *res = core->res;
> -	unsigned int i;
> +	char buf[13] = { 0 }; /* vcodecX_core\0 */
>  
> -	for (i = 0; i < res->vcodec_clks_num; i++) {
> -		if (!id[i])
> -			continue;
> -		clks[i] = devm_clk_get(dev, id[i]);
> -		if (IS_ERR(clks[i]))
> -			return PTR_ERR(clks[i]);
> +	/* Best we can do is 2 cores */
> +	if (id > MAX_NUM_VCODECS - 1) {
> +		dev_err(dev, "Got impossible vcodec id %u\n", id);
> +		return -EINVAL;
> +	};
> +
> +	snprintf(buf, sizeof(buf), "vcodec%u_core", id);
> +
> +	/* First try the non-legacy name */
> +	core->vcodec_core_clks[id] = devm_clk_get_optional(dev, buf);
> +	if (IS_ERR(core->vcodec_core_clks[id])) {
> +		/* Try again, with the legacy name */
> +		core->vcodec_core_clks[id] = devm_clk_get_optional(dev, "core");
> +		if (IS_ERR(core->vcodec_core_clks[id]))
> +			return PTR_ERR(core->vcodec_core_clks[id]);
> +	}
> +
> +	memset(buf, 0, sizeof(buf));
> +	snprintf(buf, sizeof(buf), "vcodec%u_bus", id);
> +
> +	core->vcodec_bus_clks[id] = devm_clk_get_optional(dev, buf);
> +	if (IS_ERR(core->vcodec_bus_clks[id])) {
> +		core->vcodec_bus_clks[id] = devm_clk_get_optional(dev, "bus");
> +		if (IS_ERR(core->vcodec_bus_clks[id]))
> +			return PTR_ERR(core->vcodec_bus_clks[id]);
>  	}
>  
>  	return 0;
>  }
>  
> -static int vcodec_clks_enable(struct venus_core *core, struct clk **clks)
> +static int vcodec_clks_enable(struct venus_core *core, u8 id)
>  {
> -	const struct venus_resources *res = core->res;
> -	unsigned int i;
>  	int ret;
>  
> -	for (i = 0; i < res->vcodec_clks_num; i++) {
> -		ret = clk_prepare_enable(clks[i]);
> -		if (ret)
> -			goto err;
> -	}
> +	ret = clk_prepare_enable(core->vcodec_core_clks[id]);
> +	if (ret)
> +		return ret;
>  
> -	return 0;
> -err:
> -	while (i--)
> -		clk_disable_unprepare(clks[i]);
> +	ret = clk_prepare_enable(core->vcodec_bus_clks[id]);
> +	if (ret)
> +		clk_disable_unprepare(core->vcodec_core_clks[id]);
>  
>  	return ret;
>  }
>  
> -static void vcodec_clks_disable(struct venus_core *core, struct clk **clks)
> +static void vcodec_clks_disable(struct venus_core *core, u8 id)
>  {
> -	const struct venus_resources *res = core->res;
> -	unsigned int i = res->vcodec_clks_num;
> -
> -	while (i--)
> -		clk_disable_unprepare(clks[i]);
> +	clk_disable_unprepare(core->vcodec_bus_clks[id]);
> +	clk_disable_unprepare(core->vcodec_core_clks[id]);
>  }
>  
>  static u32 load_per_instance(struct venus_inst *inst)
> @@ -343,8 +350,7 @@ static int vdec_get_v3(struct device *dev)
>  {
>  	struct venus_core *core = dev_get_drvdata(dev);
>  
> -	return vcodec_clks_get(core, dev, core->vcodec0_clks,
> -			       core->res->vcodec0_clks);
> +	return vcodec_clks_get(core, dev, 0);
>  }
>  
>  static int vdec_power_v3(struct device *dev, int on)
> @@ -355,9 +361,9 @@ static int vdec_power_v3(struct device *dev, int on)
>  	vcodec_control_v3(core, VIDC_SESSION_TYPE_DEC, true);
>  
>  	if (on == POWER_ON)
> -		ret = vcodec_clks_enable(core, core->vcodec0_clks);
> +		ret = vcodec_clks_enable(core, 0);
>  	else
> -		vcodec_clks_disable(core, core->vcodec0_clks);
> +		vcodec_clks_disable(core, 0);
>  
>  	vcodec_control_v3(core, VIDC_SESSION_TYPE_DEC, false);
>  
> @@ -368,8 +374,7 @@ static int venc_get_v3(struct device *dev)
>  {
>  	struct venus_core *core = dev_get_drvdata(dev);
>  
> -	return vcodec_clks_get(core, dev, core->vcodec1_clks,
> -			       core->res->vcodec1_clks);
> +	return vcodec_clks_get(core, dev, 1);
>  }
>  
>  static int venc_power_v3(struct device *dev, int on)
> @@ -380,9 +385,9 @@ static int venc_power_v3(struct device *dev, int on)
>  	vcodec_control_v3(core, VIDC_SESSION_TYPE_ENC, true);
>  
>  	if (on == POWER_ON)
> -		ret = vcodec_clks_enable(core, core->vcodec1_clks);
> +		ret = vcodec_clks_enable(core, 1);
>  	else
> -		vcodec_clks_disable(core, core->vcodec1_clks);
> +		vcodec_clks_disable(core, 1);
>  
>  	vcodec_control_v3(core, VIDC_SESSION_TYPE_ENC, false);
>  
> @@ -441,7 +446,7 @@ static int poweroff_coreid(struct venus_core *core, unsigned int coreid_mask)
>  		if (ret)
>  			return ret;
>  
> -		vcodec_clks_disable(core, core->vcodec0_clks);
> +		vcodec_clks_disable(core, 0);
>  
>  		ret = vcodec_control_v4(core, VIDC_CORE_ID_1, false);
>  		if (ret)
> @@ -457,7 +462,7 @@ static int poweroff_coreid(struct venus_core *core, unsigned int coreid_mask)
>  		if (ret)
>  			return ret;
>  
> -		vcodec_clks_disable(core, core->vcodec1_clks);
> +		vcodec_clks_disable(core, 1);
>  
>  		ret = vcodec_control_v4(core, VIDC_CORE_ID_2, false);
>  		if (ret)
> @@ -484,7 +489,7 @@ static int poweron_coreid(struct venus_core *core, unsigned int coreid_mask)
>  		if (ret)
>  			return ret;
>  
> -		ret = vcodec_clks_enable(core, core->vcodec0_clks);
> +		ret = vcodec_clks_enable(core, 0);
>  		if (ret)
>  			return ret;
>  
> @@ -502,7 +507,7 @@ static int poweron_coreid(struct venus_core *core, unsigned int coreid_mask)
>  		if (ret)
>  			return ret;
>  
> -		ret = vcodec_clks_enable(core, core->vcodec1_clks);
> +		ret = vcodec_clks_enable(core, 1);
>  		if (ret)
>  			return ret;
>  
> @@ -763,20 +768,18 @@ static int vdec_get_v4(struct device *dev)
>  	if (!legacy_binding)
>  		return 0;
>  
> -	return vcodec_clks_get(core, dev, core->vcodec0_clks,
> -			       core->res->vcodec0_clks);
> +	return vcodec_clks_get(core, dev, 0);
>  }
>  
>  static void vdec_put_v4(struct device *dev)
>  {
>  	struct venus_core *core = dev_get_drvdata(dev);
> -	unsigned int i;
>  
>  	if (!legacy_binding)
>  		return;
>  
> -	for (i = 0; i < core->res->vcodec_clks_num; i++)
> -		core->vcodec0_clks[i] = NULL;
> +	core->vcodec_core_clks[0] = NULL;
> +	core->vcodec_bus_clks[0] = NULL;
>  }
>  
>  static int vdec_power_v4(struct device *dev, int on)
> @@ -792,9 +795,9 @@ static int vdec_power_v4(struct device *dev, int on)
>  		return ret;
>  
>  	if (on == POWER_ON)
> -		ret = vcodec_clks_enable(core, core->vcodec0_clks);
> +		ret = vcodec_clks_enable(core, 0);
>  	else
> -		vcodec_clks_disable(core, core->vcodec0_clks);
> +		vcodec_clks_disable(core, 0);
>  
>  	vcodec_control_v4(core, VIDC_CORE_ID_1, false);
>  
> @@ -808,20 +811,18 @@ static int venc_get_v4(struct device *dev)
>  	if (!legacy_binding)
>  		return 0;
>  
> -	return vcodec_clks_get(core, dev, core->vcodec1_clks,
> -			       core->res->vcodec1_clks);
> +	return vcodec_clks_get(core, dev, 1);
>  }
>  
>  static void venc_put_v4(struct device *dev)
>  {
>  	struct venus_core *core = dev_get_drvdata(dev);
> -	unsigned int i;
>  
>  	if (!legacy_binding)
>  		return;
>  
> -	for (i = 0; i < core->res->vcodec_clks_num; i++)
> -		core->vcodec1_clks[i] = NULL;
> +	core->vcodec_core_clks[1] = NULL;
> +	core->vcodec_bus_clks[1] = NULL;
>  }
>  
>  static int venc_power_v4(struct device *dev, int on)
> @@ -837,9 +838,9 @@ static int venc_power_v4(struct device *dev, int on)
>  		return ret;
>  
>  	if (on == POWER_ON)
> -		ret = vcodec_clks_enable(core, core->vcodec1_clks);
> +		ret = vcodec_clks_enable(core, 1);
>  	else
> -		vcodec_clks_disable(core, core->vcodec1_clks);
> +		vcodec_clks_disable(core, 1);
>  
>  	vcodec_control_v4(core, VIDC_CORE_ID_2, false);
>  
> @@ -934,11 +935,11 @@ static int core_get_v4(struct venus_core *core)
>  
>  	dev_info(dev, "%s legacy binding\n", legacy_binding ? "" : "non");
>  
> -	ret = vcodec_clks_get(core, dev, core->vcodec0_clks, res->vcodec0_clks);
> +	ret = vcodec_clks_get(core, dev, 0);
>  	if (ret)
>  		return ret;
>  
> -	ret = vcodec_clks_get(core, dev, core->vcodec1_clks, res->vcodec1_clks);
> +	ret = vcodec_clks_get(core, dev, 1);
>  	if (ret)
>  		return ret;
>  
> 
It is better to keep the information about all clocks being used for a
particular SOC in one place, like its currently captured in resource
structure. Leaving core clocks in resources and moving vcodec clocks to
other places makes it less readable.
Also let's say, if in future, a new clock is introcued, we will need to
introduce a new array additional to vcodec_core, vcodec_bus.

Thanks,
Dikshita

