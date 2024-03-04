Return-Path: <linux-kernel+bounces-90946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C367F87075B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A6A0281CF3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BC54CE11;
	Mon,  4 Mar 2024 16:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="E1emAWOa"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188BD1E48B;
	Mon,  4 Mar 2024 16:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709570422; cv=none; b=FZiyRdyv54d5zIoXGZxyA6clwnCKaOr/nt6aTL/pQ70N4KW5z9+YtCR0yUI3rXs2aKRslZ2GXlzWFh6KRjZ6E3MJnkwpxwdGAvWHW7eV1yHYWyGT93AWG6gyL/mMmMxAaOuLd/rfLSqjmXUY0vTHeJS/nGo8wUecR1NkbCp7/vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709570422; c=relaxed/simple;
	bh=ysTz6CoSf/OaCBd/3gnRXFxv2KlvPVHfiM45BdLhUK0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvTTRUQqmtvbRKf+bCwlyiFRejoiSGjEw/uAZowqksDp9i2XRvzicuhc4IJNqYOY9As8m4y4oSIyiu/ElDMU264WVu8c162J/UTSvaWjtCDhzHdjmVCAQPIBGByHQsqCjKIvIIDF+5wEgDVryWwYK3bYD/f3vJOxl4RF80sHNNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=E1emAWOa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 424EQgNS018061;
	Mon, 4 Mar 2024 16:40:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=YQv9TQce1ynh6DdrjSi+5
	dUsbguvINcdIdJh+2uY/74=; b=E1emAWOaHnzZfRmliwM4v+Y3N9B5QOmaUdqnh
	YYB6hie/1YGdwERsSFMYx6xsr21bqVA6Gqdpr+m0jPeG8G7UOmRrSPXHjCI7FkLf
	hfoAnnCFp3bFytnHoj8Pk1g88VOc9io3FAn6FIJM8em+P0XbtkCTeiKUyqGZwIyI
	JEObrCjhfSkNG7NRP8J4I2EvZ0pO57/OV9dcvkmStn10B25Ca5/lzVXVURODpvKA
	n6DYMuoZK1LPuFpEn32AUpEv0C9iBS+S30PnnYG0kCudrqqosxmVuSBclJrsDPHT
	9U3rMKmCDek5ivMibjlOSxtv5BDKUxMvYQRHbXnxx39+sBBkQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wn6qx1e2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 16:40:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 424GeBPZ019578
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Mar 2024 16:40:11 GMT
Received: from hu-mdtipton-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 4 Mar 2024 08:40:11 -0800
Date: Mon, 4 Mar 2024 08:40:09 -0800
From: Mike Tipton <quic_mdtipton@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>, Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] interconnect: qcom: x1e80100: Remove inexistent ACV_PERF
 BCM
Message-ID: <20240304164009.GB25492@hu-mdtipton-lv.qualcomm.com>
References: <20240302-topic-faux_bcm_x1e-v1-1-c40fab7c4bc5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240302-topic-faux_bcm_x1e-v1-1-c40fab7c4bc5@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5_dHSE6Mnh83dLBXjjHb3uQ4VpzK4_jE
X-Proofpoint-ORIG-GUID: 5_dHSE6Mnh83dLBXjjHb3uQ4VpzK4_jE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_12,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 clxscore=1011 adultscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403040127

On Sat, Mar 02, 2024 at 03:22:49AM +0100, Konrad Dybcio wrote:
> Booting the kernel on X1E results in a message like:
> 
> [    2.561524] qnoc-x1e80100 interconnect-0: ACV_PERF could not find RPMh address
> 
> And indeed, taking a look at cmd-db, no such BCM exists. Remove it.
> 
> Fixes: 9f196772841e ("interconnect: qcom: Add X1E80100 interconnect provider driver")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Mike Tipton <quic_mdtipton@quicinc.com>

For some background, ACV "perf mode" does exist, but not as a separate
BCM. It's controlled by a separate bit in the ACV mask. By default, the
ACV node only sets the bit indicating the HLOS voter. It doesn't assert
the perf mode bit.

Enabling perf mode toggles different trade-offs within the DDR subsystem
for slightly improved performance at the expense of slightly higher
power. There are limited use cases of this downstream, where we expose
control over this bit to clients through icc_set_tag(). It primarily
improves certain latency sensitive benchmarks, AFAIK. I don't think it
has much impact on real world use cases.

This is true for many other targets as well, not just x1e80100.

Voting for perf-mode is entirely optional and in most cases also
entirely unnecessary. So, removing this broken way to control it without
adding the proper control is totally fine.

I have a local series to add the proper support, but haven't posted it
yet. There aren't any users for it upstream yet, nor am I aware of any
near term plans to add them. So, it would be unused for a little while,
at least. That said, anybody could use it to set that tag on their BW
votes on the off-chance it improves performance and they don't care
about the power trade-offs.

I could post the series soon if there's interest.

> ---
>  drivers/interconnect/qcom/x1e80100.c | 26 --------------------------
>  1 file changed, 26 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/x1e80100.c b/drivers/interconnect/qcom/x1e80100.c
> index 99824675ee3f..654abb9ce08e 100644
> --- a/drivers/interconnect/qcom/x1e80100.c
> +++ b/drivers/interconnect/qcom/x1e80100.c
> @@ -116,15 +116,6 @@ static struct qcom_icc_node xm_sdc2 = {
>  	.links = { X1E80100_SLAVE_A2NOC_SNOC },
>  };
>  
> -static struct qcom_icc_node ddr_perf_mode_master = {
> -	.name = "ddr_perf_mode_master",
> -	.id = X1E80100_MASTER_DDR_PERF_MODE,
> -	.channels = 1,
> -	.buswidth = 4,
> -	.num_links = 1,
> -	.links = { X1E80100_SLAVE_DDR_PERF_MODE },
> -};
> -
>  static struct qcom_icc_node qup0_core_master = {
>  	.name = "qup0_core_master",
>  	.id = X1E80100_MASTER_QUP_CORE_0,
> @@ -688,14 +679,6 @@ static struct qcom_icc_node qns_a2noc_snoc = {
>  	.links = { X1E80100_MASTER_A2NOC_SNOC },
>  };
>  
> -static struct qcom_icc_node ddr_perf_mode_slave = {
> -	.name = "ddr_perf_mode_slave",
> -	.id = X1E80100_SLAVE_DDR_PERF_MODE,
> -	.channels = 1,
> -	.buswidth = 4,
> -	.num_links = 0,
> -};
> -
>  static struct qcom_icc_node qup0_core_slave = {
>  	.name = "qup0_core_slave",
>  	.id = X1E80100_SLAVE_QUP_CORE_0,
> @@ -1377,12 +1360,6 @@ static struct qcom_icc_bcm bcm_acv = {
>  	.nodes = { &ebi },
>  };
>  
> -static struct qcom_icc_bcm bcm_acv_perf = {
> -	.name = "ACV_PERF",
> -	.num_nodes = 1,
> -	.nodes = { &ddr_perf_mode_slave },
> -};
> -
>  static struct qcom_icc_bcm bcm_ce0 = {
>  	.name = "CE0",
>  	.num_nodes = 1,
> @@ -1583,18 +1560,15 @@ static const struct qcom_icc_desc x1e80100_aggre2_noc = {
>  };
>  
>  static struct qcom_icc_bcm * const clk_virt_bcms[] = {
> -	&bcm_acv_perf,
>  	&bcm_qup0,
>  	&bcm_qup1,
>  	&bcm_qup2,
>  };
>  
>  static struct qcom_icc_node * const clk_virt_nodes[] = {
> -	[MASTER_DDR_PERF_MODE] = &ddr_perf_mode_master,
>  	[MASTER_QUP_CORE_0] = &qup0_core_master,
>  	[MASTER_QUP_CORE_1] = &qup1_core_master,
>  	[MASTER_QUP_CORE_2] = &qup2_core_master,
> -	[SLAVE_DDR_PERF_MODE] = &ddr_perf_mode_slave,
>  	[SLAVE_QUP_CORE_0] = &qup0_core_slave,
>  	[SLAVE_QUP_CORE_1] = &qup1_core_slave,
>  	[SLAVE_QUP_CORE_2] = &qup2_core_slave,
> 
> ---
> base-commit: 1870cdc0e8dee32e3c221704a2977898ba4c10e8
> change-id: 20240302-topic-faux_bcm_x1e-8639adf9d010
> 
> Best regards,
> -- 
> Konrad Dybcio <konrad.dybcio@linaro.org>
> 

