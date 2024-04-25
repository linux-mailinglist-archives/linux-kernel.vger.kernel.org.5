Return-Path: <linux-kernel+bounces-159078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AC48B290A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2A2828541A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EBA152504;
	Thu, 25 Apr 2024 19:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QjyRtX95"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422752135A;
	Thu, 25 Apr 2024 19:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714073417; cv=none; b=pJ+zZ+4gruH8Bo1zbchzMNfxLD2UKYFHeXlQSIe1mP/Ifg6FRjjgdSKvO6mkIuwJHYceyUvEawssjcDOtdWeoaPJzEW/SZem1j6ppvNUM32pXF3KYCDtQ1qJU7isNGOC4BMZwStCn6K4QngIPYHO5PLOcnOceeT56kxlFKhNAj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714073417; c=relaxed/simple;
	bh=QaXBz6hCQE64ka3eS8b1UvrKwdInmlXbY7024YOXUq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Kz0iYh1+73ehN4oykQ+7Gz1pHJ7ky5S88FITTwYJ/xOvyMQRHAdOWq+gdjB6rl57C291grhU5/863SeD8FpfbcOCZ05ePNDdjhlLB/ZzxFtacXpko8xRiwKiMBHrK2UjILPT554aOXpjcE8Lq5rA65SXuEnqDay24dMLLQj/W44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QjyRtX95; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PItkEE009250;
	Thu, 25 Apr 2024 19:30:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=BPyYe415dTkCdrIWikjwxnhAfeyA2CT12485YcYWpBk=; b=Qj
	yRtX957dSpTt62piG/2yqriMpwhW+I8LbPt1cYDf9anmdW0laFR5nFkNYF0WS3p3
	rrCEY6dVcm+UO4yMCDL9cWutWv2tfdeYVbxik8plttxyhM9Ej8wcU90rZ1q/dNlI
	YqrkgnVrfv+UHDZ2xdBXRQYfcCV8tA27ocL2r6bnLm7i6CC6QrEwxlPMUwWwivt7
	OU/c+Bc2AbRPzTMQMR96g9IrS7ac2zP3cy0h6DZEsWmKmIYRNgPM5uDTDxLBfMMz
	IrhwQk/J7V+VGN82etiXhwzTQfpm7BXpUr53gD48dWZG23Fpxe3g+xxh6omXW6cw
	xiwC3C3bA4M8bwx9t26Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqenkkh1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 19:30:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PJU8nm008532
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 19:30:08 GMT
Received: from [10.110.3.55] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Apr
 2024 12:30:07 -0700
Message-ID: <d71c677f-eff7-2bc4-4328-38e4d83e1115@quicinc.com>
Date: Thu, 25 Apr 2024 12:30:07 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 1/6] soc: qcom: pdr: protect locator_addr with the main
 mutex
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
	<bryan.odonoghue@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20240424-qcom-pd-mapper-v7-0-05f7fc646e0f@linaro.org>
 <20240424-qcom-pd-mapper-v7-1-05f7fc646e0f@linaro.org>
Content-Language: en-US
From: Chris Lew <quic_clew@quicinc.com>
In-Reply-To: <20240424-qcom-pd-mapper-v7-1-05f7fc646e0f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mC-kUwEGWlYylnplApAnj_Fn0ljkiIoN
X-Proofpoint-GUID: mC-kUwEGWlYylnplApAnj_Fn0ljkiIoN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_19,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250140


On 4/24/2024 2:27 AM, Dmitry Baryshkov wrote:
> If the service locator server is restarted fast enough, the PDR can
> rewrite locator_addr fields concurrently. Protect them by placing
> modification of those fields under the main pdr->lock.
> 
> Fixes: fbe639b44a82 ("soc: qcom: Introduce Protection Domain Restart helpers")
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/soc/qcom/pdr_interface.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/qcom/pdr_interface.c b/drivers/soc/qcom/pdr_interface.c
> index a1b6a4081dea..19cfe4b41235 100644
> --- a/drivers/soc/qcom/pdr_interface.c
> +++ b/drivers/soc/qcom/pdr_interface.c
> @@ -76,12 +76,12 @@ static int pdr_locator_new_server(struct qmi_handle *qmi,
>   					      locator_hdl);
>   	struct pdr_service *pds;
>   
> +	mutex_lock(&pdr->lock);
>   	/* Create a local client port for QMI communication */
>   	pdr->locator_addr.sq_family = AF_QIPCRTR;
>   	pdr->locator_addr.sq_node = svc->node;
>   	pdr->locator_addr.sq_port = svc->port;
>   
> -	mutex_lock(&pdr->lock);
>   	pdr->locator_init_complete = true;
>   	mutex_unlock(&pdr->lock);
>   
> @@ -104,10 +104,10 @@ static void pdr_locator_del_server(struct qmi_handle *qmi,
>   
>   	mutex_lock(&pdr->lock);
>   	pdr->locator_init_complete = false;
> -	mutex_unlock(&pdr->lock);
>   
>   	pdr->locator_addr.sq_node = 0;
>   	pdr->locator_addr.sq_port = 0;
> +	mutex_unlock(&pdr->lock);
>   }
>   
>   static const struct qmi_ops pdr_locator_ops = {
> 

These two functions are provided as qmi_ops handlers in pdr_locator_ops. 
Aren't they serialized in the qmi handle's workqueue since it as an 
ordered_workqueue? Even in a fast pdr scenario I don't think we would 
see a race condition between these two functions.

The other access these two functions do race against is in the 
pdr_notifier_work. I think you would need to protect locator_addr in 
pdr_get_domain_list since the qmi_send_request there uses 
'pdr->locator_addr'.

Thanks!
Chris

