Return-Path: <linux-kernel+bounces-105716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A8787E35D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 06:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA6DF2825A6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 05:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B132231A;
	Mon, 18 Mar 2024 05:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DpZEY+Jm"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55974C84;
	Mon, 18 Mar 2024 05:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710741073; cv=none; b=exIHc+P06WOCvrCVt3c1EjFRN2u+wtWPX3FQJfALwHApannDUTPxgLV+gOVp8qcKtW1zyniRGl9aRpEZhyK6Byymfn0QQeeAsk++2ajVhlPc9aBfGrWM2KbNsSSybEoFenJEjtoce4rqXe35PlNwcVZ3Ya5qr7f+/rERfZfUByU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710741073; c=relaxed/simple;
	bh=ZifoHiHF+0G0DDlsU72Q6JVu635GgHFgddmFiDxF9wo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=peIp6umRXkK7P9LbO7HiJkYu4aBQ4KQGVhULGPoqvy+NFb+3jquf0uU4lvluWOht55dhiPXdPx+C6VUW7RR2umPRcAqDQ4tug1NuG4TxW5KDsM4lIFnqjcabdXoLmxRC42xCG8diHVwdbzA1ziALGjepwyFl+pVwmL306KUa5Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DpZEY+Jm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42I3SSOZ025531;
	Mon, 18 Mar 2024 05:51:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=u0ICDs2zU4jCIeOhWZh7E5vm94P6RpA3q7jsOApTmN0=; b=Dp
	ZEY+JmX3h9+8CJcjHBB4N6T5bCk8wYhIhLNvE+HWhpqKSy+yFrPNRVg8+9H7MHBG
	0xQh9oTHiedEzIRzyowTFK3S6g9utYDGQ5jYqYhCVSXZ8ijPX0I2XwkLacxwftRe
	fbpUyijCF26nvMhwOORVml8Y6V4U53kodUodjAaYbGBrKx69XjMT6Fiw/QK6b8A/
	ykAJbYO955sM4WCthaF3beannBOAeLzakbVDB8RTkj3mwrrbYo8Ess8+5wkCXqAg
	BIE3cGtL0F5JF9NZqgE6mYluvMkRMZnUL3iUv2iQ4Kfg9L7V5NSxo5LNY5sJpNw2
	KO+7Vo5B1A7HjlB2sPKA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wwxtb15aq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 05:51:07 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42I5p7Xs020079
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 05:51:07 GMT
Received: from [10.216.55.168] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 17 Mar
 2024 22:51:02 -0700
Message-ID: <7e1df07d-d047-4cfe-bfdd-fb17d0daf158@quicinc.com>
Date: Mon, 18 Mar 2024 11:20:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: ipq8074: Remove unused gpio from QPIC
 pins
Content-Language: en-US
To: =?UTF-8?Q?Pawe=C5=82_Owoc?= <frut3k7@gmail.com>
CC: Robert Marko <robimarko@gmail.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240313102713.1727458-1-frut3k7@gmail.com>
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <20240313102713.1727458-1-frut3k7@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Pa9ZIP-g9LF56JKA-WbuR6oGjbQmtCC5
X-Proofpoint-ORIG-GUID: Pa9ZIP-g9LF56JKA-WbuR6oGjbQmtCC5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-17_12,2024-03-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 clxscore=1011 phishscore=0 mlxlogscore=957
 impostorscore=0 bulkscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403140001
 definitions=main-2403180042



On 3/13/2024 3:57 PM, Paweł Owoc wrote:
> gpio16 will only be used for LCD support, as its NAND/LCDC data[8]
> so its bit 9 of the parallel QPIC interface, and ONFI NAND is only 8
> or 16-bit with only 8-bit one being supported in our case so that pin
> is unused.
> 
> It should be dropped from the default NAND pinctrl configuration
> as its unused and only needed for LCD.


Matches with downstream.

Reviewed-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>


> 
> Signed-off-by: Paweł Owoc <frut3k7@gmail.com>
> ---
>   arch/arm64/boot/dts/qcom/ipq8074.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> index e5b89753aa5c..8bed34174460 100644
> --- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> @@ -349,7 +349,7 @@ qpic_pins: qpic-state {
>   				       "gpio5", "gpio6", "gpio7",
>   				       "gpio8", "gpio10", "gpio11",
>   				       "gpio12", "gpio13", "gpio14",
> -				       "gpio15", "gpio16", "gpio17";
> +				       "gpio15", "gpio17";
>   				function = "qpic";
>   				drive-strength = <8>;
>   				bias-disable;

