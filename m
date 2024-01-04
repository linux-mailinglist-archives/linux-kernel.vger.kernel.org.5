Return-Path: <linux-kernel+bounces-16476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5198B823F20
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B1F61C2146C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5622920B09;
	Thu,  4 Jan 2024 10:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SCVOsVLT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDE6208CA;
	Thu,  4 Jan 2024 10:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 404A061G032126;
	Thu, 4 Jan 2024 10:00:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=wQgYPle5TH7i7u2I3wtHU0/ODC612atETv4t+r4pHLY=; b=SC
	VOsVLT+TO7K1whJIXutaO97sDptbPDld427p/QkERjPsHfbe/Xel7RStWrUUfhoC
	oLK8NrVtFYNzn2g8x+gVPBLKDydqUDjmpJXkBTBWBTE8Gx3GY5lTk/DznLDeUmvV
	RveEuraKKxWEjmIJ/ZQ0do3EWs6ck/08YYIY9pCr4E/sZWJiUEXhFGxIeubSM2FK
	UB2kTFbQKaELM78wsYojFyi9SUkDbdWJ/As1+cb5Vxdt1jAHxJ1L7AUo3Swr5b3M
	+IqGHRqe5O+FH5q+GovIFZMGuhH4gQyIGqBtQB4eFRzSrHCoVe64Qwn9vJ+ag1b4
	ortlBEzZdpaHKy51Ov6w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vdqb1rhyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 10:00:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 404A04wf029122
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Jan 2024 10:00:04 GMT
Received: from [10.216.41.156] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 4 Jan
 2024 02:00:00 -0800
Message-ID: <4d4d5d3b-cdb2-484a-8297-4b8bb0817986@quicinc.com>
Date: Thu, 4 Jan 2024 15:29:54 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] interconnect: qcom: x1e80100: Remove bogus per-RSC
 BCMs and nodes
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Sibi Sankar" <quic_sibis@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>
CC: Marijn Suijten <marijn.suijten@somainline.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20240102-topic-x1e_fixes-v1-0-70723e08d5f6@linaro.org>
 <20240102-topic-x1e_fixes-v1-1-70723e08d5f6@linaro.org>
Content-Language: en-US
From: Rajendra Nayak <quic_rjendra@quicinc.com>
In-Reply-To: <20240102-topic-x1e_fixes-v1-1-70723e08d5f6@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: l8NlhSNnbSWm5-kHa27Qosoq8C-yUZtz
X-Proofpoint-ORIG-GUID: l8NlhSNnbSWm5-kHa27Qosoq8C-yUZtz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 clxscore=1011
 malwarescore=0 phishscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401040075



On 1/2/2024 11:59 PM, Konrad Dybcio wrote:
> The downstream kernel has infrastructure for passing votes from different
> interconnect nodes onto different RPMh RSCs. This neither implemented, not
> is going to be implemented upstream (in favor of a different solution
> using ICC tags through the same node).
> 
> Unfortunately, as it happens, meaningless (in the upstream context) parts
> of the vendor driver were copied, ending up causing havoc - since all
> "per-RSC" (in quotes because they all point to the main APPS one) BCMs
> defined within the driver overwrite the value in RPMh on every
> aggregation.
> 
> To both avoid keeping bogus code around and possibly introducing
> impossible-to-track-down bugs (busses shutting down for no reason), get
> rid of the duplicated BCMs and their associated ICC nodes.

Thanks Konrad for catching this, I do see these nodes in other Qualcomm 
SoCs upstream (atleast sm8350/sm8450 and sm8550), perhaps they need to 
be cleaned up as well?

Reviewed-by: Rajendra Nayak <quic_rjendra@quicinc.com>

> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/interconnect/qcom/x1e80100.c | 315 -----------------------------------
>   1 file changed, 315 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/x1e80100.c b/drivers/interconnect/qcom/x1e80100.c
> index d19501d913b3..5b2de9c3a1d6 100644
> --- a/drivers/interconnect/qcom/x1e80100.c
> +++ b/drivers/interconnect/qcom/x1e80100.c
> @@ -670,150 +670,6 @@ static struct qcom_icc_node xm_usb4_2 = {
>   	.links = { X1E80100_SLAVE_AGGRE_USB_SOUTH },
>   };
>   
> -static struct qcom_icc_node qnm_mnoc_hf_disp = {
> -	.name = "qnm_mnoc_hf_disp",
> -	.id = X1E80100_MASTER_MNOC_HF_MEM_NOC_DISP,
> -	.channels = 2,
> -	.buswidth = 32,
> -	.num_links = 1,
> -	.links = { X1E80100_SLAVE_LLCC_DISP },
> -};
> -
> -static struct qcom_icc_node qnm_pcie_disp = {
> -	.name = "qnm_pcie_disp",
> -	.id = X1E80100_MASTER_ANOC_PCIE_GEM_NOC_DISP,
> -	.channels = 1,
> -	.buswidth = 64,
> -	.num_links = 1,
> -	.links = { X1E80100_SLAVE_LLCC_DISP },
> -};
> -
> -static struct qcom_icc_node llcc_mc_disp = {
> -	.name = "llcc_mc_disp",
> -	.id = X1E80100_MASTER_LLCC_DISP,
> -	.channels = 8,
> -	.buswidth = 4,
> -	.num_links = 1,
> -	.links = { X1E80100_SLAVE_EBI1_DISP },
> -};
> -
> -static struct qcom_icc_node qnm_mdp_disp = {
> -	.name = "qnm_mdp_disp",
> -	.id = X1E80100_MASTER_MDP_DISP,
> -	.channels = 2,
> -	.buswidth = 32,
> -	.num_links = 1,
> -	.links = { X1E80100_SLAVE_MNOC_HF_MEM_NOC_DISP },
> -};
> -
> -static struct qcom_icc_node qnm_pcie_pcie = {
> -	.name = "qnm_pcie_pcie",
> -	.id = X1E80100_MASTER_ANOC_PCIE_GEM_NOC_PCIE,
> -	.channels = 1,
> -	.buswidth = 64,
> -	.num_links = 1,
> -	.links = { X1E80100_SLAVE_LLCC_PCIE },
> -};
> -
> -static struct qcom_icc_node llcc_mc_pcie = {
> -	.name = "llcc_mc_pcie",
> -	.id = X1E80100_MASTER_LLCC_PCIE,
> -	.channels = 8,
> -	.buswidth = 4,
> -	.num_links = 1,
> -	.links = { X1E80100_SLAVE_EBI1_PCIE },
> -};
> -
> -static struct qcom_icc_node qnm_pcie_north_gem_noc_pcie = {
> -	.name = "qnm_pcie_north_gem_noc_pcie",
> -	.id = X1E80100_MASTER_PCIE_NORTH_PCIE,
> -	.channels = 1,
> -	.buswidth = 64,
> -	.num_links = 1,
> -	.links = { X1E80100_SLAVE_ANOC_PCIE_GEM_NOC_PCIE },
> -};
> -
> -static struct qcom_icc_node qnm_pcie_south_gem_noc_pcie = {
> -	.name = "qnm_pcie_south_gem_noc_pcie",
> -	.id = X1E80100_MASTER_PCIE_SOUTH_PCIE,
> -	.channels = 1,
> -	.buswidth = 64,
> -	.num_links = 1,
> -	.links = { X1E80100_SLAVE_ANOC_PCIE_GEM_NOC_PCIE },
> -};
> -
> -static struct qcom_icc_node xm_pcie_3_pcie = {
> -	.name = "xm_pcie_3_pcie",
> -	.id = X1E80100_MASTER_PCIE_3_PCIE,
> -	.channels = 1,
> -	.buswidth = 64,
> -	.num_links = 1,
> -	.links = { X1E80100_SLAVE_PCIE_NORTH_PCIE },
> -};
> -
> -static struct qcom_icc_node xm_pcie_4_pcie = {
> -	.name = "xm_pcie_4_pcie",
> -	.id = X1E80100_MASTER_PCIE_4_PCIE,
> -	.channels = 1,
> -	.buswidth = 8,
> -	.num_links = 1,
> -	.links = { X1E80100_SLAVE_PCIE_NORTH_PCIE },
> -};
> -
> -static struct qcom_icc_node xm_pcie_5_pcie = {
> -	.name = "xm_pcie_5_pcie",
> -	.id = X1E80100_MASTER_PCIE_5_PCIE,
> -	.channels = 1,
> -	.buswidth = 8,
> -	.num_links = 1,
> -	.links = { X1E80100_SLAVE_PCIE_NORTH_PCIE },
> -};
> -
> -static struct qcom_icc_node xm_pcie_0_pcie = {
> -	.name = "xm_pcie_0_pcie",
> -	.id = X1E80100_MASTER_PCIE_0_PCIE,
> -	.channels = 1,
> -	.buswidth = 16,
> -	.num_links = 1,
> -	.links = { X1E80100_SLAVE_PCIE_SOUTH_PCIE },
> -};
> -
> -static struct qcom_icc_node xm_pcie_1_pcie = {
> -	.name = "xm_pcie_1_pcie",
> -	.id = X1E80100_MASTER_PCIE_1_PCIE,
> -	.channels = 1,
> -	.buswidth = 16,
> -	.num_links = 1,
> -	.links = { X1E80100_SLAVE_PCIE_SOUTH_PCIE },
> -};
> -
> -static struct qcom_icc_node xm_pcie_2_pcie = {
> -	.name = "xm_pcie_2_pcie",
> -	.id = X1E80100_MASTER_PCIE_2_PCIE,
> -	.channels = 1,
> -	.buswidth = 16,
> -	.num_links = 1,
> -	.links = { X1E80100_SLAVE_PCIE_SOUTH_PCIE },
> -};
> -
> -static struct qcom_icc_node xm_pcie_6a_pcie = {
> -	.name = "xm_pcie_6a_pcie",
> -	.id = X1E80100_MASTER_PCIE_6A_PCIE,
> -	.channels = 1,
> -	.buswidth = 32,
> -	.num_links = 1,
> -	.links = { X1E80100_SLAVE_PCIE_SOUTH_PCIE },
> -};
> -
> -static struct qcom_icc_node xm_pcie_6b_pcie = {
> -	.name = "xm_pcie_6b_pcie",
> -	.id = X1E80100_MASTER_PCIE_6B_PCIE,
> -	.channels = 1,
> -	.buswidth = 16,
> -	.num_links = 1,
> -	.links = { X1E80100_SLAVE_PCIE_SOUTH_PCIE },
> -};
> -
>   static struct qcom_icc_node qns_a1noc_snoc = {
>   	.name = "qns_a1noc_snoc",
>   	.id = X1E80100_SLAVE_A1NOC_SNOC,
> @@ -1514,76 +1370,6 @@ static struct qcom_icc_node qns_aggre_usb_south_snoc = {
>   	.links = { X1E80100_MASTER_AGGRE_USB_SOUTH },
>   };
>   
> -static struct qcom_icc_node qns_llcc_disp = {
> -	.name = "qns_llcc_disp",
> -	.id = X1E80100_SLAVE_LLCC_DISP,
> -	.channels = 8,
> -	.buswidth = 16,
> -	.num_links = 1,
> -	.links = { X1E80100_MASTER_LLCC_DISP },
> -};
> -
> -static struct qcom_icc_node ebi_disp = {
> -	.name = "ebi_disp",
> -	.id = X1E80100_SLAVE_EBI1_DISP,
> -	.channels = 8,
> -	.buswidth = 4,
> -	.num_links = 0,
> -};
> -
> -static struct qcom_icc_node qns_mem_noc_hf_disp = {
> -	.name = "qns_mem_noc_hf_disp",
> -	.id = X1E80100_SLAVE_MNOC_HF_MEM_NOC_DISP,
> -	.channels = 2,
> -	.buswidth = 32,
> -	.num_links = 1,
> -	.links = { X1E80100_MASTER_MNOC_HF_MEM_NOC_DISP },
> -};
> -
> -static struct qcom_icc_node qns_llcc_pcie = {
> -	.name = "qns_llcc_pcie",
> -	.id = X1E80100_SLAVE_LLCC_PCIE,
> -	.channels = 8,
> -	.buswidth = 16,
> -	.num_links = 1,
> -	.links = { X1E80100_MASTER_LLCC_PCIE },
> -};
> -
> -static struct qcom_icc_node ebi_pcie = {
> -	.name = "ebi_pcie",
> -	.id = X1E80100_SLAVE_EBI1_PCIE,
> -	.channels = 8,
> -	.buswidth = 4,
> -	.num_links = 0,
> -};
> -
> -static struct qcom_icc_node qns_pcie_mem_noc_pcie = {
> -	.name = "qns_pcie_mem_noc_pcie",
> -	.id = X1E80100_SLAVE_ANOC_PCIE_GEM_NOC_PCIE,
> -	.channels = 1,
> -	.buswidth = 64,
> -	.num_links = 1,
> -	.links = { X1E80100_MASTER_ANOC_PCIE_GEM_NOC_PCIE },
> -};
> -
> -static struct qcom_icc_node qns_pcie_north_gem_noc_pcie = {
> -	.name = "qns_pcie_north_gem_noc_pcie",
> -	.id = X1E80100_SLAVE_PCIE_NORTH_PCIE,
> -	.channels = 1,
> -	.buswidth = 64,
> -	.num_links = 1,
> -	.links = { X1E80100_MASTER_PCIE_NORTH_PCIE },
> -};
> -
> -static struct qcom_icc_node qns_pcie_south_gem_noc_pcie = {
> -	.name = "qns_pcie_south_gem_noc_pcie",
> -	.id = X1E80100_SLAVE_PCIE_SOUTH_PCIE,
> -	.channels = 1,
> -	.buswidth = 64,
> -	.num_links = 1,
> -	.links = { X1E80100_MASTER_PCIE_SOUTH_PCIE },
> -};
> -
>   static struct qcom_icc_bcm bcm_acv = {
>   	.name = "ACV",
>   	.num_nodes = 1,
> @@ -1755,72 +1541,6 @@ static struct qcom_icc_bcm bcm_sn4 = {
>   	.nodes = { &qnm_usb_anoc },
>   };
>   
> -static struct qcom_icc_bcm bcm_acv_disp = {
> -	.name = "ACV",
> -	.num_nodes = 1,
> -	.nodes = { &ebi_disp },
> -};
> -
> -static struct qcom_icc_bcm bcm_mc0_disp = {
> -	.name = "MC0",
> -	.num_nodes = 1,
> -	.nodes = { &ebi_disp },
> -};
> -
> -static struct qcom_icc_bcm bcm_mm0_disp = {
> -	.name = "MM0",
> -	.num_nodes = 1,
> -	.nodes = { &qns_mem_noc_hf_disp },
> -};
> -
> -static struct qcom_icc_bcm bcm_mm1_disp = {
> -	.name = "MM1",
> -	.num_nodes = 1,
> -	.nodes = { &qnm_mdp_disp },
> -};
> -
> -static struct qcom_icc_bcm bcm_sh0_disp = {
> -	.name = "SH0",
> -	.num_nodes = 1,
> -	.nodes = { &qns_llcc_disp },
> -};
> -
> -static struct qcom_icc_bcm bcm_sh1_disp = {
> -	.name = "SH1",
> -	.num_nodes = 2,
> -	.nodes = { &qnm_mnoc_hf_disp, &qnm_pcie_disp },
> -};
> -
> -static struct qcom_icc_bcm bcm_acv_pcie = {
> -	.name = "ACV",
> -	.num_nodes = 1,
> -	.nodes = { &ebi_pcie },
> -};
> -
> -static struct qcom_icc_bcm bcm_mc0_pcie = {
> -	.name = "MC0",
> -	.num_nodes = 1,
> -	.nodes = { &ebi_pcie },
> -};
> -
> -static struct qcom_icc_bcm bcm_pc0_pcie = {
> -	.name = "PC0",
> -	.num_nodes = 1,
> -	.nodes = { &qns_pcie_mem_noc_pcie },
> -};
> -
> -static struct qcom_icc_bcm bcm_sh0_pcie = {
> -	.name = "SH0",
> -	.num_nodes = 1,
> -	.nodes = { &qns_llcc_pcie },
> -};
> -
> -static struct qcom_icc_bcm bcm_sh1_pcie = {
> -	.name = "SH1",
> -	.num_nodes = 1,
> -	.nodes = { &qnm_pcie_pcie },
> -};
> -
>   static struct qcom_icc_bcm *aggre1_noc_bcms[] = {
>   };
>   
> @@ -1982,10 +1702,6 @@ static const struct qcom_icc_desc x1e80100_cnoc_main = {
>   static struct qcom_icc_bcm * const gem_noc_bcms[] = {
>   	&bcm_sh0,
>   	&bcm_sh1,
> -	&bcm_sh0_disp,
> -	&bcm_sh1_disp,
> -	&bcm_sh0_pcie,
> -	&bcm_sh1_pcie,
>   };
>   
>   static struct qcom_icc_node * const gem_noc_nodes[] = {
> @@ -2004,11 +1720,6 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
>   	[SLAVE_GEM_NOC_CNOC] = &qns_gem_noc_cnoc,
>   	[SLAVE_LLCC] = &qns_llcc,
>   	[SLAVE_MEM_NOC_PCIE_SNOC] = &qns_pcie,
> -	[MASTER_MNOC_HF_MEM_NOC_DISP] = &qnm_mnoc_hf_disp,
> -	[MASTER_ANOC_PCIE_GEM_NOC_DISP] = &qnm_pcie_disp,
> -	[SLAVE_LLCC_DISP] = &qns_llcc_disp,
> -	[MASTER_ANOC_PCIE_GEM_NOC_PCIE] = &qnm_pcie_pcie,
> -	[SLAVE_LLCC_PCIE] = &qns_llcc_pcie,
>   };
>   
>   static const struct qcom_icc_desc x1e80100_gem_noc = {
> @@ -2067,19 +1778,11 @@ static const struct qcom_icc_desc x1e80100_lpass_lpicx_noc = {
>   static struct qcom_icc_bcm * const mc_virt_bcms[] = {
>   	&bcm_acv,
>   	&bcm_mc0,
> -	&bcm_acv_disp,
> -	&bcm_mc0_disp,
> -	&bcm_acv_pcie,
> -	&bcm_mc0_pcie,
>   };
>   
>   static struct qcom_icc_node * const mc_virt_nodes[] = {
>   	[MASTER_LLCC] = &llcc_mc,
>   	[SLAVE_EBI1] = &ebi,
> -	[MASTER_LLCC_DISP] = &llcc_mc_disp,
> -	[SLAVE_EBI1_DISP] = &ebi_disp,
> -	[MASTER_LLCC_PCIE] = &llcc_mc_pcie,
> -	[SLAVE_EBI1_PCIE] = &ebi_pcie,
>   };
>   
>   static const struct qcom_icc_desc x1e80100_mc_virt = {
> @@ -2092,8 +1795,6 @@ static const struct qcom_icc_desc x1e80100_mc_virt = {
>   static struct qcom_icc_bcm * const mmss_noc_bcms[] = {
>   	&bcm_mm0,
>   	&bcm_mm1,
> -	&bcm_mm0_disp,
> -	&bcm_mm1_disp,
>   };
>   
>   static struct qcom_icc_node * const mmss_noc_nodes[] = {
> @@ -2110,8 +1811,6 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
>   	[SLAVE_MNOC_HF_MEM_NOC] = &qns_mem_noc_hf,
>   	[SLAVE_MNOC_SF_MEM_NOC] = &qns_mem_noc_sf,
>   	[SLAVE_SERVICE_MNOC] = &srvc_mnoc,
> -	[MASTER_MDP_DISP] = &qnm_mdp_disp,
> -	[SLAVE_MNOC_HF_MEM_NOC_DISP] = &qns_mem_noc_hf_disp,
>   };
>   
>   static const struct qcom_icc_desc x1e80100_mmss_noc = {
> @@ -2139,16 +1838,12 @@ static const struct qcom_icc_desc x1e80100_nsp_noc = {
>   
>   static struct qcom_icc_bcm * const pcie_center_anoc_bcms[] = {
>   	&bcm_pc0,
> -	&bcm_pc0_pcie,
>   };
>   
>   static struct qcom_icc_node * const pcie_center_anoc_nodes[] = {
>   	[MASTER_PCIE_NORTH] = &qnm_pcie_north_gem_noc,
>   	[MASTER_PCIE_SOUTH] = &qnm_pcie_south_gem_noc,
>   	[SLAVE_ANOC_PCIE_GEM_NOC] = &qns_pcie_mem_noc,
> -	[MASTER_PCIE_NORTH_PCIE] = &qnm_pcie_north_gem_noc_pcie,
> -	[MASTER_PCIE_SOUTH_PCIE] = &qnm_pcie_south_gem_noc_pcie,
> -	[SLAVE_ANOC_PCIE_GEM_NOC_PCIE] = &qns_pcie_mem_noc_pcie,
>   };
>   
>   static const struct qcom_icc_desc x1e80100_pcie_center_anoc = {
> @@ -2166,10 +1861,6 @@ static struct qcom_icc_node * const pcie_north_anoc_nodes[] = {
>   	[MASTER_PCIE_4] = &xm_pcie_4,
>   	[MASTER_PCIE_5] = &xm_pcie_5,
>   	[SLAVE_PCIE_NORTH] = &qns_pcie_north_gem_noc,
> -	[MASTER_PCIE_3_PCIE] = &xm_pcie_3_pcie,
> -	[MASTER_PCIE_4_PCIE] = &xm_pcie_4_pcie,
> -	[MASTER_PCIE_5_PCIE] = &xm_pcie_5_pcie,
> -	[SLAVE_PCIE_NORTH_PCIE] = &qns_pcie_north_gem_noc_pcie,
>   };
>   
>   static const struct qcom_icc_desc x1e80100_pcie_north_anoc = {
> @@ -2189,12 +1880,6 @@ static struct qcom_icc_node * const pcie_south_anoc_nodes[] = {
>   	[MASTER_PCIE_6A] = &xm_pcie_6a,
>   	[MASTER_PCIE_6B] = &xm_pcie_6b,
>   	[SLAVE_PCIE_SOUTH] = &qns_pcie_south_gem_noc,
> -	[MASTER_PCIE_0_PCIE] = &xm_pcie_0_pcie,
> -	[MASTER_PCIE_1_PCIE] = &xm_pcie_1_pcie,
> -	[MASTER_PCIE_2_PCIE] = &xm_pcie_2_pcie,
> -	[MASTER_PCIE_6A_PCIE] = &xm_pcie_6a_pcie,
> -	[MASTER_PCIE_6B_PCIE] = &xm_pcie_6b_pcie,
> -	[SLAVE_PCIE_SOUTH_PCIE] = &qns_pcie_south_gem_noc_pcie,
>   };
>   
>   static const struct qcom_icc_desc x1e80100_pcie_south_anoc = {
> 

