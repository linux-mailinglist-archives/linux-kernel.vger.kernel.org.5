Return-Path: <linux-kernel+bounces-160774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C007F8B42BE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 01:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1E2E1C21D72
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 23:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684313BBF5;
	Fri, 26 Apr 2024 23:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Frlo/t2R"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3FF3A8E4;
	Fri, 26 Apr 2024 23:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714173939; cv=none; b=YSBWoNsxikzGq2ZY5EJrLVarLU0DGP8GcsSb7SPfhDLFPhz53eZPnyCR2R/i7BN6bv54doCLNf6bU3uPocKN3K8/MTTEr8LKLfUOApZpFi6TfM6YXYE7YT0L08LfcKiSYzyEpqbVJIP7X6J0xYQsvIWVwV9ZvMWafGMwvGHKpXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714173939; c=relaxed/simple;
	bh=Oo3OtoMFZgV8oyBBeZdB6VsYE2VPjoVz9FYqPtF9BJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gvoR41PXNmd6YrLu3+82eKtJvmh9bg6jvWLIOHFnDL6cZhsDQnrE575gtZ+v4TIjjVFy0nUVBT2abrDanKoKwVw8SSUdJcCUbfisIQsNrjZYxPw50kvWUa/WZbG+ACFfWdOrWPks13HRfFjlWkwTmCLhilZDCFz89GZCA+LC3bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Frlo/t2R; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43QNMkCt023899;
	Fri, 26 Apr 2024 23:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=XDkUIigcVGqC8gCqZT1/+lGYK1cHWMUguzns/fZY7WU=; b=Fr
	lo/t2RcNY7/5flTCMi4u2SOlyAMPDSEwsc5QfQXcCIxS/7krFsc6Lq4Iflf9zr6i
	/KB3S0Ff0e+eKDWwkJ3GaAQEnsFsUlWS3fJuhYBdxQ5ZMhmGEbrhnAje3z17BHkv
	qBOH1+Ck/IOC1lcMHAd88IE1G24mdO1gTQWp6WD5RuszIw59q6QKhT72fye/w9z+
	08iaTt495KwEfjPo90H2rQ6h0d7Cl4su0QtW7I/ipP4Ecssd6fOEgJA6tShzDrYO
	/9RW9FZAy2q0Z4GInnmmSXRjyM2X1DQTcAw/796v579I1WnO7oJyWHBrCULi8pzh
	+He/KOi+cVVQkF3JXBOw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xranmhfnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 23:25:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43QNPV1I031896
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 23:25:31 GMT
Received: from [10.110.11.138] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 26 Apr
 2024 16:25:30 -0700
Message-ID: <6b6298c4-485d-ebe5-fa8d-9edc461467a0@quicinc.com>
Date: Fri, 26 Apr 2024 16:25:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 5/6] soc: qcom: add pd-mapper implementation
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sibi Sankar
	<quic_sibis@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Xilin Wu <wuxilin123@gmail.com>,
        Bryan O'Donoghue
	<bryan.odonoghue@linaro.org>
References: <20240424-qcom-pd-mapper-v7-0-05f7fc646e0f@linaro.org>
 <20240424-qcom-pd-mapper-v7-5-05f7fc646e0f@linaro.org>
Content-Language: en-US
From: Chris Lew <quic_clew@quicinc.com>
In-Reply-To: <20240424-qcom-pd-mapper-v7-5-05f7fc646e0f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xiSbrLKX4H3KLGrkCGae4cBJFRNzDXEx
X-Proofpoint-ORIG-GUID: xiSbrLKX4H3KLGrkCGae4cBJFRNzDXEx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_20,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404260166



On 4/24/2024 2:28 AM, Dmitry Baryshkov wrote:

> +static int qcom_pdm_start(void)
> +{
> +	const struct of_device_id *match;
> +	const struct qcom_pdm_domain_data * const *domains;
> +	struct device_node *root;
> +	int ret, i;
> +
> +	root = of_find_node_by_path("/");
> +	if (!root)
> +		return -ENODEV;
> +
> +	match = of_match_node(qcom_pdm_domains, root);
> +	of_node_put(root);
> +	if (!match) {
> +		pr_notice("PDM: no support for the platform, userspace daemon might be required.\n");
> +		return -ENODEV;
> +	}
> +
> +	domains = match->data;
> +	if (!domains) {
> +		pr_debug("PDM: no domains\n");
> +		return -ENODEV;
> +	}
> +
> +	mutex_lock(&qcom_pdm_mutex);
> +	for (i = 0; domains[i]; i++) {
> +		ret = qcom_pdm_add_domain(domains[i]);
> +		if (ret)
> +			goto free_domains;
> +	}
> +
> +	ret = qmi_handle_init(&qcom_pdm_handle, 1024,
> +			      NULL, qcom_pdm_msg_handlers);

1024 here seems arbitrary, I think most other usage of qmi_handle_init 
has a macro defined for the max message length of the qmi service.

> +	if (ret)
> +		goto free_domains;
> +
> +	ret = qmi_add_server(&qcom_pdm_handle, SERVREG_LOCATOR_SERVICE,
> +			     SERVREG_QMI_VERSION, SERVREG_QMI_INSTANCE);
> +	if (ret) {
> +		pr_err("PDM: error adding server %d\n", ret);
> +		goto release_handle;
> +	}
> +	mutex_unlock(&qcom_pdm_mutex);
> +
> +	return 0;
> +
> +release_handle:
> +	qmi_handle_release(&qcom_pdm_handle);
> +
> +free_domains:
> +	qcom_pdm_free_domains();
> +	mutex_unlock(&qcom_pdm_mutex);
> +
> +	return ret;
> +}
> +
> +static void qcom_pdm_stop(void)
> +{
> +	qmi_del_server(&qcom_pdm_handle, SERVREG_LOCATOR_SERVICE,
> +		       SERVREG_QMI_VERSION, SERVREG_QMI_INSTANCE);
> +
> +	qmi_handle_release(&qcom_pdm_handle);
> +

I don't think doing an explicit qmi_del_server() is necessary. As part 
of the qmi_handle_release(), the qrtr socket will be closed and the qrtr 
ns will broadcast a DEL_SERVER and DEL_CLIENT notification as part of 
the cleanup.

> +	qcom_pdm_free_domains();
> +}
> +

