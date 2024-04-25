Return-Path: <linux-kernel+bounces-157962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E7D8B195C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C27A31C20FEC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D612200DB;
	Thu, 25 Apr 2024 03:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QSiXbH6h"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4554721342;
	Thu, 25 Apr 2024 03:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714015133; cv=none; b=PpU9j9+bq+QRXzrFJr6yKqKJCSJtij0rO199oa711M9caRsjXHrTbLpftLQPvmPM+Wjit7Ko0ck3a7nFa/iNJKSbwGD+i9mLeli5d2MGLA2OKHhx787LtrOV/p2zIWWh4PKWHOerMt1+gKWzounqIMRy+Br+pXLWiypn1wQCWtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714015133; c=relaxed/simple;
	bh=fVNg/LfDcq10widsGMVfZ6pCi/NJQcnNmTSeXtJkHJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IwXtETSNxJCfXuXSXMv5/S/X0Erl20wxCxv2Kq3K4iMzzwhKctIJTb3s/rXMZuYhyS5Rv7euHwBPMGW8bQE5x74mja3bUwv+yDKE41osAURb5oVi4bhW1s9I1VWm0qkpKEAz9xhiCjQshrtFPplpCLh5Cl9hrafV6FT0ehl8jZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QSiXbH6h; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P2iK6h002152;
	Thu, 25 Apr 2024 03:18:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=9DbiKCqZCWGi5s3l+CklUzC6YNSKpD3osXoU87041r0=; b=QS
	iXbH6hKJGUNNP7ltV/VAys9QLAYL8gm6XAAVWGiw6LgaTxfmqstKBzbwlMXhpjqg
	yzH+L1pinmZV7WYrLSRkqd5nlMX+Oh8DcyEE4/O6khf3TAZFlHr8W+24+9uQ3fhO
	44zFB4yOVKyvUfKqrkYmgZsu2W4OYUS17QvS7gcqGfnpnzmd/ntHSpi2hbs3DmQt
	vlmaMGz4RVkhOOTGdKtdkXFgvBY+U0dApi8UFV6jWpdx4a2zq/J3HCgX7vAPjXNh
	CNuFWkfsQPM8f3S4tL6n2rGlwFjly+qxM4JFUKd2ci//AEESAp5EWEOcOwN86OFG
	oA/v7+pUqSgusqIM7KxA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqengg2e6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 03:18:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43P3Il4o028406
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 03:18:47 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 24 Apr
 2024 20:18:44 -0700
Message-ID: <9b062d5c-f495-4fc3-8751-6efbea8ad11f@quicinc.com>
Date: Thu, 25 Apr 2024 11:18:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sm4450: Add cpufreq support
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <manivannan.sadhasivam@linaro.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20240424101503.635364-1-quic_tengfan@quicinc.com>
 <20240424101503.635364-3-quic_tengfan@quicinc.com>
 <CAA8EJpqGub3LuFPbwcA-MTYN2kY=94YXe=T3-mewYzxgcF-ZMQ@mail.gmail.com>
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <CAA8EJpqGub3LuFPbwcA-MTYN2kY=94YXe=T3-mewYzxgcF-ZMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IKoS-Ms86BjY197NdgngmndHRy3fBWjJ
X-Proofpoint-ORIG-GUID: IKoS-Ms86BjY197NdgngmndHRy3fBWjJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_02,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxlogscore=725 phishscore=0 malwarescore=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250023



On 4/25/2024 7:41 AM, Dmitry Baryshkov wrote:
> On Wed, 24 Apr 2024 at 13:16, Tengfei Fan <quic_tengfan@quicinc.com> wrote:
>>
>> Add a description of a SM4450 cpufreq-epss controller and references to
>> it from CPU nodes.
>>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sm4450.dtsi | 29 ++++++++++++++++++++++++++++
>>   1 file changed, 29 insertions(+)
> 
> With the next patch being squashed in:
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 


Clock support patch[PATCH 3/3] will be squashed in this patch in the new 
version patch series.


-- 
Thx and BRs,
Tengfei Fan

