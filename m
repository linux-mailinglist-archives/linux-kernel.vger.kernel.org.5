Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E3F808735
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379136AbjLGL6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 06:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjLGL62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 06:58:28 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2E7A9;
        Thu,  7 Dec 2023 03:58:33 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B7BE6Qb007485;
        Thu, 7 Dec 2023 11:58:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=5AIGLhmKwS2D8pIipwyxJCz4XNAIG6lVdFBauuPajhE=;
 b=nZQr4mo+8vyh5A2mGHItQcDvf/t4DCsMIUDas0ni+bMdPsQocIRz3fiSNWdL0qrlWKQD
 kMRkXjNSAxeVyXzbbiVWDpokKIK2T8pVRAT2g7QTPYQLy8sUSA9w+gNtNmo7g3htP5E2
 Js2XctVEstxtWrxo5pE2MGBmesu1WN2CMETI6/5qtfCpcJFDiZ7qm8E7jwW8EQqm7eva
 1+OIBwArXAQ5d5awyV6wtcoXol2gt3reTM23XG9R1ccBC1n5L6PJ4ANRT8itD5pDMnK6
 gnxqvHL70RU03+G8/u8EEaopEGbYDohCcAuc1t9bxdX1IT2nZpeISGt2+XCl0bRGq6Nk RQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uu1069hvp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Dec 2023 11:58:23 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B7BwMnH001236
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Dec 2023 11:58:22 GMT
Received: from [10.253.69.179] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 7 Dec
 2023 03:58:19 -0800
Message-ID: <a9b3889a-04aa-4352-914e-7889f8d8afef@quicinc.com>
Date:   Thu, 7 Dec 2023 19:58:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] clk: qcom: clk-rcg2: add support for rcg2 freq
 multi ops
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20231124151847.1915-1-ansuelsmth@gmail.com>
 <20231124151847.1915-3-ansuelsmth@gmail.com>
From:   Lei Wei <quic_leiwei@quicinc.com>
In-Reply-To: <20231124151847.1915-3-ansuelsmth@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nczeAWJl9aRmRU2SnCmd9sWIDO0QXZ6p
X-Proofpoint-ORIG-GUID: nczeAWJl9aRmRU2SnCmd9sWIDO0QXZ6p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_09,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 lowpriorityscore=0
 clxscore=1011 bulkscore=0 impostorscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2312070097
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/24/2023 11:18 PM, Christian Marangi wrote:
> Some RCG frequency can be reached by multiple configuration.
> 
> Add clk_rcg2_fm_ops ops to support these special RCG configurations.
> 
> These alternative ops will select the frequency using a CEIL policy.
> 
> When the correct frequency is found, the correct config is selected by
> calculating the final rate (by checking the defined parent and values
> in the config that is being checked) and deciding based on the one that
> is less different than the requested one.
> 
> These check are skipped if there is just on config for the requested
> freq.
> 
> qcom_find_freq_multi is added to search the freq with the new struct
> freq_multi_tbl.
> __clk_rcg2_select_conf is used to select the correct conf by simulating
> the final clock.
> If a conf can't be found due to parent not reachable, a WARN is printed
> and -EINVAL is returned.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Tested-by: Wei Lei <quic_leiwei@quicinc.com>

Regards
Lei
> ---
>   drivers/clk/qcom/clk-rcg.h  |   1 +
>   drivers/clk/qcom/clk-rcg2.c | 166 ++++++++++++++++++++++++++++++++++++
>   drivers/clk/qcom/common.c   |  18 ++++
>   drivers/clk/qcom/common.h   |   2 +
>   4 files changed, 187 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
> index c81458db6ce4..dc9a77965e68 100644
> --- a/drivers/clk/qcom/clk-rcg.h
> +++ b/drivers/clk/qcom/clk-rcg.h
> @@ -190,6 +190,7 @@ struct clk_rcg2_gfx3d {
>   
>   extern const struct clk_ops clk_rcg2_ops;
>   extern const struct clk_ops clk_rcg2_floor_ops;
> +extern const struct clk_ops clk_rcg2_fm_ops;
>   extern const struct clk_ops clk_rcg2_mux_closest_ops;
>   extern const struct clk_ops clk_edp_pixel_ops;
>   extern const struct clk_ops clk_byte_ops;
> diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
> index e22baf3a7112..2393c7df0402 100644
> --- a/drivers/clk/qcom/clk-rcg2.c
> +++ b/drivers/clk/qcom/clk-rcg2.c
> @@ -266,6 +266,115 @@ static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq_tbl *f,
>   	return 0;
>   }
>   
> +static const struct freq_conf *
> +__clk_rcg2_select_conf(struct clk_hw *hw, const struct freq_multi_tbl *f,
> +		       unsigned long req_rate)
> +{
> +	unsigned long rate_diff, best_rate_diff = ULONG_MAX;
> +	const struct freq_conf *conf, *best_conf = NULL;
> +	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
> +	const char *name = clk_hw_get_name(hw);
> +	unsigned long parent_rate, rate;
> +	struct clk_hw *p;
> +	int index, i;
> +
> +	/* Exit early if only one config is defined */
> +	if (f->num_confs == 1) {
> +		best_conf = f->confs;
> +		goto exit;
> +	}
> +
> +	/* Search in each provided config the one that is near the wanted rate */
> +	for (i = 0, conf = f->confs; i < f->num_confs; i++, conf++) {
> +		index = qcom_find_src_index(hw, rcg->parent_map, conf->src);
> +		if (index < 0)
> +			continue;
> +
> +		p = clk_hw_get_parent_by_index(hw, index);
> +		if (!p)
> +			continue;
> +
> +		parent_rate =  clk_hw_get_rate(p);
> +		rate = calc_rate(parent_rate, conf->n, conf->m, conf->n, conf->pre_div);
> +
> +		if (rate == req_rate) {
> +			best_conf = conf;
> +			goto exit;
> +		}
> +
> +		rate_diff = abs(req_rate - rate);
> +		if (rate_diff < best_rate_diff) {
> +			best_rate_diff = rate_diff;
> +			best_conf = conf;
> +		}
> +	}
> +
> +	/*
> +	 * Very unlikely. Warn if we couldn't find a correct config
> +	 * due to parent not found in every config.
> +	 */
> +	if (unlikely(!best_conf)) {
> +		WARN(1, "%s: can't find a configuration for rate %lu.",
> +		     name, req_rate);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +exit:
> +	return best_conf;
> +}
> +
> +static int _freq_tbl_fm_determine_rate(struct clk_hw *hw, const struct freq_multi_tbl *f,
> +				       struct clk_rate_request *req)
> +{
> +	unsigned long clk_flags, rate = req->rate;
> +	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
> +	const struct freq_conf *conf;
> +	struct clk_hw *p;
> +	int index;
> +
> +	f = qcom_find_freq_multi(f, rate);
> +	if (!f || !f->confs)
> +		return -EINVAL;
> +
> +	conf = __clk_rcg2_select_conf(hw, f, rate);
> +	if (IS_ERR(conf))
> +		return PTR_ERR(conf);
> +	index = qcom_find_src_index(hw, rcg->parent_map, conf->src);
> +	if (index < 0)
> +		return index;
> +
> +	clk_flags = clk_hw_get_flags(hw);
> +	p = clk_hw_get_parent_by_index(hw, index);
> +	if (!p)
> +		return -EINVAL;
> +
> +	if (clk_flags & CLK_SET_RATE_PARENT) {
> +		rate = f->freq;
> +		if (conf->pre_div) {
> +			if (!rate)
> +				rate = req->rate;
> +			rate /= 2;
> +			rate *= conf->pre_div + 1;
> +		}
> +
> +		if (conf->n) {
> +			u64 tmp = rate;
> +
> +			tmp = tmp * conf->n;
> +			do_div(tmp, conf->m);
> +			rate = tmp;
> +		}
> +	} else {
> +		rate =  clk_hw_get_rate(p);
> +	}
> +
> +	req->best_parent_hw = p;
> +	req->best_parent_rate = rate;
> +	req->rate = f->freq;
> +
> +	return 0;
> +}
> +
>   static int clk_rcg2_determine_rate(struct clk_hw *hw,
>   				   struct clk_rate_request *req)
>   {
> @@ -282,6 +391,14 @@ static int clk_rcg2_determine_floor_rate(struct clk_hw *hw,
>   	return _freq_tbl_determine_rate(hw, rcg->freq_tbl, req, FLOOR);
>   }
>   
> +static int clk_rcg2_fm_determine_rate(struct clk_hw *hw,
> +				      struct clk_rate_request *req)
> +{
> +	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
> +
> +	return _freq_tbl_fm_determine_rate(hw, rcg->freq_multi_tbl, req);
> +}
> +
>   static int __clk_rcg2_configure(struct clk_rcg2 *rcg, const struct freq_tbl *f,
>   				u32 *_cfg)
>   {
> @@ -377,6 +494,30 @@ static int __clk_rcg2_set_rate(struct clk_hw *hw, unsigned long rate,
>   	return clk_rcg2_configure(rcg, f);
>   }
>   
> +static int __clk_rcg2_fm_set_rate(struct clk_hw *hw, unsigned long rate)
> +{
> +	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
> +	const struct freq_multi_tbl *f;
> +	const struct freq_conf *conf;
> +	struct freq_tbl f_tbl;
> +
> +	f = qcom_find_freq_multi(rcg->freq_multi_tbl, rate);
> +	if (!f || !f->confs)
> +		return -EINVAL;
> +
> +	conf = __clk_rcg2_select_conf(hw, f, rate);
> +	if (IS_ERR(conf))
> +		return PTR_ERR(conf);
> +
> +	f_tbl.freq = f->freq;
> +	f_tbl.src = conf->src;
> +	f_tbl.pre_div = conf->pre_div;
> +	f_tbl.m = conf->m;
> +	f_tbl.n = conf->n;
> +
> +	return clk_rcg2_configure(rcg, &f_tbl);
> +}
> +
>   static int clk_rcg2_set_rate(struct clk_hw *hw, unsigned long rate,
>   			    unsigned long parent_rate)
>   {
> @@ -389,6 +530,12 @@ static int clk_rcg2_set_floor_rate(struct clk_hw *hw, unsigned long rate,
>   	return __clk_rcg2_set_rate(hw, rate, FLOOR);
>   }
>   
> +static int clk_rcg2_fm_set_rate(struct clk_hw *hw, unsigned long rate,
> +				unsigned long parent_rate)
> +{
> +	return __clk_rcg2_fm_set_rate(hw, rate);
> +}
> +
>   static int clk_rcg2_set_rate_and_parent(struct clk_hw *hw,
>   		unsigned long rate, unsigned long parent_rate, u8 index)
>   {
> @@ -401,6 +548,12 @@ static int clk_rcg2_set_floor_rate_and_parent(struct clk_hw *hw,
>   	return __clk_rcg2_set_rate(hw, rate, FLOOR);
>   }
>   
> +static int clk_rcg2_fm_set_rate_and_parent(struct clk_hw *hw,
> +		unsigned long rate, unsigned long parent_rate, u8 index)
> +{
> +	return __clk_rcg2_fm_set_rate(hw, rate);
> +}
> +
>   static int clk_rcg2_get_duty_cycle(struct clk_hw *hw, struct clk_duty *duty)
>   {
>   	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
> @@ -511,6 +664,19 @@ const struct clk_ops clk_rcg2_floor_ops = {
>   };
>   EXPORT_SYMBOL_GPL(clk_rcg2_floor_ops);
>   
> +const struct clk_ops clk_rcg2_fm_ops = {
> +	.is_enabled = clk_rcg2_is_enabled,
> +	.get_parent = clk_rcg2_get_parent,
> +	.set_parent = clk_rcg2_set_parent,
> +	.recalc_rate = clk_rcg2_recalc_rate,
> +	.determine_rate = clk_rcg2_fm_determine_rate,
> +	.set_rate = clk_rcg2_fm_set_rate,
> +	.set_rate_and_parent = clk_rcg2_fm_set_rate_and_parent,
> +	.get_duty_cycle = clk_rcg2_get_duty_cycle,
> +	.set_duty_cycle = clk_rcg2_set_duty_cycle,
> +};
> +EXPORT_SYMBOL_GPL(clk_rcg2_fm_ops);
> +
>   const struct clk_ops clk_rcg2_mux_closest_ops = {
>   	.determine_rate = __clk_mux_determine_rate_closest,
>   	.get_parent = clk_rcg2_get_parent,
> diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
> index 75f09e6e057e..48f81e3a5e80 100644
> --- a/drivers/clk/qcom/common.c
> +++ b/drivers/clk/qcom/common.c
> @@ -41,6 +41,24 @@ struct freq_tbl *qcom_find_freq(const struct freq_tbl *f, unsigned long rate)
>   }
>   EXPORT_SYMBOL_GPL(qcom_find_freq);
>   
> +const struct freq_multi_tbl *qcom_find_freq_multi(const struct freq_multi_tbl *f,
> +						  unsigned long rate)
> +{
> +	if (!f)
> +		return NULL;
> +
> +	if (!f->freq)
> +		return f;
> +
> +	for (; f->freq; f++)
> +		if (rate <= f->freq)
> +			return f;
> +
> +	/* Default to our fastest rate */
> +	return f - 1;
> +}
> +EXPORT_SYMBOL_GPL(qcom_find_freq_multi);
> +
>   const struct freq_tbl *qcom_find_freq_floor(const struct freq_tbl *f,
>   					    unsigned long rate)
>   {
> diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
> index 9c8f7b798d9f..2d4a8a837e6c 100644
> --- a/drivers/clk/qcom/common.h
> +++ b/drivers/clk/qcom/common.h
> @@ -45,6 +45,8 @@ extern const struct freq_tbl *qcom_find_freq(const struct freq_tbl *f,
>   					     unsigned long rate);
>   extern const struct freq_tbl *qcom_find_freq_floor(const struct freq_tbl *f,
>   						   unsigned long rate);
> +extern const struct freq_multi_tbl *qcom_find_freq_multi(const struct freq_multi_tbl *f,
> +							 unsigned long rate);
>   extern void
>   qcom_pll_set_fsm_mode(struct regmap *m, u32 reg, u8 bias_count, u8 lock_count);
>   extern int qcom_find_src_index(struct clk_hw *hw, const struct parent_map *map,
