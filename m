Return-Path: <linux-kernel+bounces-101098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D7787A24C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 05:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0930282999
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 04:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A16D11193;
	Wed, 13 Mar 2024 04:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="n9KcuKFp"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E365E65C;
	Wed, 13 Mar 2024 04:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710304035; cv=none; b=k6ZVGDUQvmQnwOvGDU8/a5eVvuOcU7SuQ1EWdCnUdh4wuTOquHZ6mv9cw6DDtpax9xggA3OctN2eZmwYBMvIMI+HMWgpyLBN77REBRS+KLjnBXzn8Ju5o2LYqfOh+JccC7KrfbLnDvAvSYtkvPjbvIuoT3yACyuSYp7qywcPNe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710304035; c=relaxed/simple;
	bh=RFRDpG5Td68f6Fw5cn/ZXvS9iR0pwkfieQGofQe5jeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ptPfOV0nJQhCqnApt/zwb3uVFHSZAOFzqMDTFkwX+UoEJn1zUVXwzJyMiSHCEH9U2LQvLGxPbys5Z4fBmiedtpOAh6XfWDIZO2DOOLzwAuVblfsFl9FoDVV6jlyuH7ESyH7yvU6QnOdgbIxc7gzM8E8x2aglI6Uni8BsHwNIhT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=n9KcuKFp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42D1ARCL022857;
	Wed, 13 Mar 2024 04:27:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=+82VzOw1lv5FIzC+UC5eKLpt50PCuzFKY5+brNawC8M=; b=n9
	KcuKFplHW+ArWdvFXVy1oLpFuUGTn96X0WaYqhgx9PBzufo5cZ+/0F8B0NLXrkMA
	8MFNAYzpcNXEevwscod/trwoD98j6dSvVrylnZrs/XPXsr13BXVeDXZnvsYYuwxC
	sa+Mcjudle5JuAJSFOCD16bIMnmi8FBZG8VaXBPR9wQEMpNXQsccpAVn9Ide5V7z
	n6cYbZQ1XzZcrz3D7U6fbaB7AXFTzImDhA7hMoCsH3lhChotVvqt/chN8JMHsbSl
	q/E8LfFGmT6/t3e2YhhF+tUlkjQJ1eHUbreVDiqsfG+Zx/dIBWNelG8CUkbqYn57
	g5aNMw9iPBGVTSWWH/RQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wtw3h0y4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 04:27:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42D4QWf0012924
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 04:26:32 GMT
Received: from [10.201.2.96] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 12 Mar
 2024 21:26:28 -0700
Message-ID: <690cba7c-4362-4e19-8573-ab20b8119ae2@quicinc.com>
Date: Wed, 13 Mar 2024 09:56:25 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: apss-ipq-pll: use stromer ops for IPQ5018 to
 fix boot failure
Content-Language: en-US
To: Gabor Juhos <j4g8y7@gmail.com>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Sricharan
 Ramabadhran" <quic_srichara@quicinc.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Gokul Sriram Palanisamy
	<quic_gokulsri@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20240311-apss-ipq-pll-ipq5018-hang-v1-1-8ed42b7a904d@gmail.com>
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <20240311-apss-ipq-pll-ipq5018-hang-v1-1-8ed42b7a904d@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Uaj_-QNsnGVNrBV1qqwUJKtX_Oo3BZYT
X-Proofpoint-GUID: Uaj_-QNsnGVNrBV1qqwUJKtX_Oo3BZYT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_04,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 mlxlogscore=833
 spamscore=0 malwarescore=0 impostorscore=0 clxscore=1011 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403130031



On 3/11/2024 8:36 PM, Gabor Juhos wrote:
> Booting v6.8 results in a hang on various IPQ5018 based boards.
> Investigating the problem showed that the hang happens when the
> clk_alpha_pll_stromer_plus_set_rate() function tries to write
> into the PLL_MODE register of the APSS PLL.
> 
> Checking the downstream code revealed that it uses [1] stromer
> specific operations for IPQ5018, whereas in the current code
> the stromer plus specific operations are used.
> 
> The ops in the 'ipq_pll_stromer_plus' clock definition can't be
> changed since that is needed for IPQ5332, so add a new alpha pll
> clock declaration which uses the correct stromer ops and use this
> new clock for IPQ5018 to avoid the boot failure.
> 
> 1. https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/blob/NHSS.QSDK.12.4/drivers/clk/qcom/apss-ipq5018.c#L67


Thanks for catching this!

Tested-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Reviewed-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>


> 
> Cc: stable@vger.kernel.org
> Fixes: 50492f929486 ("clk: qcom: apss-ipq-pll: add support for IPQ5018")
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
> Based on v6.8.
> ---
>   drivers/clk/qcom/apss-ipq-pll.c | 20 +++++++++++++++++++-
>   1 file changed, 19 insertions(+), 1 deletion(-)

