Return-Path: <linux-kernel+bounces-3426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E83A816C20
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D60CAB20C51
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D211199CA;
	Mon, 18 Dec 2023 11:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bct7G7TE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2270A199C1;
	Mon, 18 Dec 2023 11:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BIBLcb9032689;
	Mon, 18 Dec 2023 11:23:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=pe0F6W5jgXvs6Rtoq81BDFSKgs1ZkfuHqIk9e9/ity4=; b=bc
	t7G7TEFcxtphKD02wGYb1XAVddKjmJxFlS9SpESOKB4dfvTdgMfqhEJNOq96cgYe
	Sr4o6F8pm25jL/v+prI5mdlvgCDS/bbtZMAEWHoWzggvWfE9613aYROBef4yNWpj
	C5rvXRF8iL6avOdHwfjfa0sWuqso8psgrw6OZQeNNWv9AEbvBsHJQ7YCKDaPXzPq
	5JTb6RlrKYUBu0tHgkKi9N6s+x5k08UlchBal4wJVdg4uoo3O5PnF8Tp5sN/7yLW
	O2vdrAmA+FgsRh/+bRZXjpV3VVTflb+9Ob6RAZCINgWTj+HnArDUbD7Njv+C6fCv
	8PPg1CwhhwKh2uP3dNqg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v2j2dgeej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 11:23:46 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BIBNjd8029644
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 11:23:45 GMT
Received: from [10.233.17.145] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 18 Dec
 2023 03:23:40 -0800
Message-ID: <caa424d3-7af0-43e6-8e13-e87cde0c4f67@quicinc.com>
Date: Mon, 18 Dec 2023 19:23:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] dt-bindings: arm: Add support for TPDM CMB MSR
 register
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin
	<alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Jinlong Mao <quic_jinlmao@quicinc.com>, Leo Yan <leo.yan@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Yuanfang Zhang
	<quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Song Chai
	<quic_songchai@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <andersson@kernel.org>
References: <1700533494-19276-1-git-send-email-quic_taozha@quicinc.com>
 <1700533494-19276-8-git-send-email-quic_taozha@quicinc.com>
 <e5fbbfab-02bf-4eda-8353-87c54c307af1@linaro.org>
 <1d57590d-2ecf-4bf6-9c8f-2a9d1ba08aaa@arm.com>
From: Tingwei Zhang <quic_tingweiz@quicinc.com>
In-Reply-To: <1d57590d-2ecf-4bf6-9c8f-2a9d1ba08aaa@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bcZc92j0kDYOMdnc2vCkINjfwJYfs-Wk
X-Proofpoint-GUID: bcZc92j0kDYOMdnc2vCkINjfwJYfs-Wk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=777
 mlxscore=0 bulkscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312180082

On 12/18/2023 6:47 PM, Suzuki K Poulose wrote:
> Tao Zhang,
> 
> On 21/11/2023 07:24, Krzysztof Kozlowski wrote:
>> On 21/11/2023 03:24, Tao Zhang wrote:
>>> Add property "qcom,cmb_msr_num" to support CMB MSR(mux select register)
>>> for TPDM. It specifies the number of CMB MSR registers supported by
>>> the TDPM.
>>>
>>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>>> ---
>>
>> I prefer not to take any new Qualcomm Coresight bindings or Qualcomm SoC
>> DTS nodes with Coresight till we fix all existing warnings. I don't know
>> how to fix them, so I need help with them. No such fixing happened so
>> far from Qcom, so pushback is my only way to get any attention.
>>
>> I already commented on this in other email thread.
> 
> Are you addressing this ?
The DT warning is fixed in 
https://lore.kernel.org/linux-arm-msm/20231210072633.4243-1-quic_jinlmao@quicinc.com/.
It's applied to linux-arm-msm yesterday.
> 
> Suzuki
> 
>>
>> Best regards,
>> Krzysztof
>>
> 

-- 
Thanks,
Tingwei


