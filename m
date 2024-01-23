Return-Path: <linux-kernel+bounces-35056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D04838B34
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6861B273A2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CE55A107;
	Tue, 23 Jan 2024 09:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lWdQQ02p"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8175A0E7;
	Tue, 23 Jan 2024 09:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706003910; cv=none; b=Dikb9ASX8Ksg39S1gWrYLAgHNHLs2483aFet9N1fqPxA517w2OT77Qoj+aQzsdyVK+zcmoA7MyVhs7TPmr4JKRgFfr647TeMuFpwxeZHb4XYHlLvGwGUJEIMRWa1cYfyjNNzztDofjTh6K/v7yYXuiK90r+TXVpfAwvjCG7XosY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706003910; c=relaxed/simple;
	bh=B/XdHveTk/vCgwuSUasgaL3WoKuViUrGU6zatSifKeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qDf40SeUmZUeAVXqAL6X5t2zXJuoBG/0qy48NQUoUMCK2PzmC3tezljtSZ5hLLKYDsGWj055JZa3Xtz9aVumamDdqttIlomOckDow6C2MViX51Ha4Zb7Qy+34he/u3AhveSm6Ynxkv5IvIfmDzIaRx+iit1PKHUtlNwCqjeMUCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lWdQQ02p; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40N6NTqu019016;
	Tue, 23 Jan 2024 09:58:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ML50tmsauSLPSsxul+Bt7KDrvonH8WWyY0pjbre6+vE=; b=lW
	dQQ02pnQh1KUWrnlv/r0FUna/v/1rdnVEmKQuTU0GuOezewIE+i8SrYcwBV6HSWH
	Gr+GkhuF0QdJ8XTOD5UJ+kY1FJNNxMsqlJDaxf4yy+4tDxQcM2ElT8v8sPDBHWD8
	bknATzXIX8C3do7D+0b/hQP+LIbFWCuMHV7xMWiBMZY+K+IYPMxCFiHbwu2zsfdH
	1td2Itsu/p85LHsEb2yVr9qVSAOakR47XpBCH+5Pi1MbvNacqRkz6Hn+M0xhm9Ea
	QTy91t+Ns84tkHMoIxUWCif8yBcyOvabYkbkmyWXmq1F9hDb/3E2sZ9xTh2Vh95J
	qbi3lodjGvE7n5pz0few==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vspw8u07j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 09:58:24 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40N9wN6E030712
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 09:58:23 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 23 Jan
 2024 01:58:15 -0800
Message-ID: <1359cab8-9459-826d-4f7b-b5ffef44bebc@quicinc.com>
Date: Tue, 23 Jan 2024 15:28:11 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 4/4] arm64: dts: qcom: sm8650: add missing
 qlink_logging reserved memory for mpss
Content-Language: en-US
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross
	<agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob
 Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240123-topic-sm8650-upstream-remoteproc-v7-0-61283f50162f@linaro.org>
 <20240123-topic-sm8650-upstream-remoteproc-v7-4-61283f50162f@linaro.org>
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20240123-topic-sm8650-upstream-remoteproc-v7-4-61283f50162f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pIld4pwsZ4YtLYk6XpX3LP3sF9Fkkeyo
X-Proofpoint-ORIG-GUID: pIld4pwsZ4YtLYk6XpX3LP3sF9Fkkeyo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_04,2024-01-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 mlxlogscore=902
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401230071



On 1/23/2024 2:21 PM, Neil Armstrong wrote:
> The qlink_logging memory region is also used by the modem firmware,
> add it to the reserved memories and add it to the MPSS memory regions.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

LGTM,

Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh

> ---
>   arch/arm64/boot/dts/qcom/sm8650.dtsi | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> index 2df77123a8c7..7a1cbc823306 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> @@ -525,6 +525,11 @@ qdss_mem: qdss@82800000 {
>   			no-map;
>   		};
>   
> +		qlink_logging_mem: qlink-logging@84800000 {
> +			reg = <0 0x84800000 0 0x200000>;
> +			no-map;
> +		};
> +
>   		mpss_dsm_mem: mpss-dsm@86b00000 {
>   			reg = <0 0x86b00000 0 0x4900000>;
>   			no-map;
> @@ -2627,7 +2632,8 @@ remoteproc_mpss: remoteproc@4080000 {
>   					     "mss";
>   
>   			memory-region = <&mpss_mem>, <&q6_mpss_dtb_mem>,
> -					<&mpss_dsm_mem>, <&mpss_dsm_mem_2>;
> +					<&mpss_dsm_mem>, <&mpss_dsm_mem_2>,
> +					<&qlink_logging_mem>;
>   
>   			qcom,qmp = <&aoss_qmp>;
>   
> 

