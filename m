Return-Path: <linux-kernel+bounces-133369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 641D189A2EB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 031D31F242AB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC00B171659;
	Fri,  5 Apr 2024 16:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lU7XaCZy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CBE171064;
	Fri,  5 Apr 2024 16:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712335986; cv=none; b=qJNO5ARdal3m/46eGjRCPr+b7ZUNdEIP8y+4uUhycFBxPRW6otV5IVvzp5cT7JNIOfnV4BKtbYrwD7nfDsxyRLt/9XJV0LRhn+qfl+ZttYrp1kElReRxwKVDLo0cmBTQ/lr7eD8A3Smt0SaIw7mptwcTOtuXXj/v2ZWsc97cpfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712335986; c=relaxed/simple;
	bh=k9joHHASRmPK5bSi2qiPET8+F5CIP1hGsb5+swdvcLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tOGjisSmkTLATYs2Ouf5K27GYa2ZEmho/wJm9lBBT7tPM0EKnkXKAZT2xyByjjBm0eFisdQGGq6H10pa+HtMRnXgIyEiTwWdjYj1OV9a9wbFHtk4V8BNHQU69E7b7fEL5F3BeUglfgN/oBeBTNqium7UH8E2K1xdx1+cqngN8xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lU7XaCZy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 435BKME5005086;
	Fri, 5 Apr 2024 16:52:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Hah74lr9Dv4JVnj9mvH0KaLuHd9eWSeuO8TbdyaT1Ms=; b=lU
	7XaCZym8+7U982/I5BBtfQTnuJ8i0ehtq2YVCv5lQuXJOwlgfOp4HbbmYhmlbXQd
	EFoE5rt1NFIx9xte29wrUF49zkikkmAR/2g4rsHmZqCzG4Rn914wlaahrURmGTUO
	HqlGDgTUrdb3N0sZOhhmnkr/C43XR77v4NlhvJdJEIB1Y79vLmJF+YzGhpFEMDH6
	piJq2lIRdGDNtFbMU5qLfhYsZXq1f/lkN0Dy3WUws3yU9XbBHxHaolJ3Gu//aTML
	w51flnZ7QuGF35Ah1BSDc3p7qoaSG107SWixba3ZhoFlbng4aJAS91XpqyFy3XSB
	4Y1nulRwXdmJiFBhpiVw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xa1xaaefh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 16:52:56 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 435Gqu6h008227
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 16:52:56 GMT
Received: from [10.216.23.38] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Apr 2024
 09:52:34 -0700
Message-ID: <d95b43f1-76bd-d633-1058-17dcf29e1d38@quicinc.com>
Date: Fri, 5 Apr 2024 22:22:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/2] soc: qcom: pmic_glink: notify clients about the
 current state
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil
 Armstrong <neil.armstrong@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Halaney <ahalaney@redhat.com>
References: <20240403-pmic-glink-fix-clients-v2-0-aed4e02baacc@linaro.org>
 <20240403-pmic-glink-fix-clients-v2-2-aed4e02baacc@linaro.org>
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20240403-pmic-glink-fix-clients-v2-2-aed4e02baacc@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -sPUZFPp81TBgI-j6PmJh3E91mxQ3kFp
X-Proofpoint-ORIG-GUID: -sPUZFPp81TBgI-j6PmJh3E91mxQ3kFp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_19,2024-04-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404050118



On 4/3/2024 8:40 AM, Dmitry Baryshkov wrote:
> In case the client is registered after the pmic-glink recived a response

                                                         received

> from the Protection Domain mapper, it is going to miss the notification
> about the state. Notify clients about the current state upon
> registration.
> 
> Fixes: 58ef4ece1e41 ("soc: qcom: pmic_glink: Introduce base PMIC GLINK driver")
> Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/soc/qcom/pmic_glink.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
> index 2b2cdf479654..e85a12ec2aab 100644
> --- a/drivers/soc/qcom/pmic_glink.c
> +++ b/drivers/soc/qcom/pmic_glink.c
> @@ -83,9 +83,14 @@ struct pmic_glink_client *devm_pmic_glink_register_client(struct device *dev,
>   	client->pdr_notify = pdr;
>   	client->priv = priv;
>   
> +	mutex_lock(&pg->state_lock);
>   	mutex_lock(&pg->client_lock);
> +
>   	list_add(&client->node, &pg->clients);
> +	client->pdr_notify(client->priv, pg->client_state);
> +
>   	mutex_unlock(&pg->client_lock);
> +	mutex_unlock(&pg->state_lock);

LGTM,

Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh
>   
>   	devres_add(dev, client);
>   
> 

