Return-Path: <linux-kernel+bounces-48830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC78846229
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8269DB24439
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509523B19E;
	Thu,  1 Feb 2024 20:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X9vT/Zry"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369261E481;
	Thu,  1 Feb 2024 20:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706820675; cv=none; b=QCcVV8qf/RakzqWuD9aYBM15qRfS7urDzbiXaimmdFuC61h0bxarSxaoNhTn9RPlu8ImyIL3YRisKoLDHdEQnkGvkqNteRiY1y1FeKDGsdmwQdIuufEjvL6U0u2E/y0JJAFGxGSQjckXbVp/Nj0Gm8ar0N1sLhLlodNZ8z8DHLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706820675; c=relaxed/simple;
	bh=1y3tB+8OR5a+oK80QgL2DDOV5HjDDpbICbswfNVB/rE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=C956oZewBcdoMrEzE0uY7bc/vtVpx4DuIJmIZjy2Mftpa2827TKdLvZqsABkqhkXQc6u9i1mwlPlcYVd3N20TNiZWsiIywI3R3moZWhLWPQLPXcB+8PavzARsZWlATolHAtL4qYrw6rJ/ac+APlHwEVxxqP3M6LITnlDopt4FRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=X9vT/Zry; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 411KItgE019216;
	Thu, 1 Feb 2024 20:51:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=TchIPbHei8Kt0jqqhIsDC8ViugTKZOh+iKlkU86j9xY=; b=X9
	vT/ZryRijIOb+KVfW5U5LlS8q4Pd9j6/OFtYeIGzWPqHdBhWvMbRQnTiBhEiy+FS
	c+ou6HJTqM8cRzVhZ0Kia0vlF5k4VqPXRLKR8cohFbMc4SAI4y+3GW+GBO1h9xMz
	zhzNMxNU3wx1AQjtE/7O4msfA1TJ1+Luhf08ywBqiP0ipmcExjSA23nWvYvZpK26
	HlgvLVOTyt6hjI8r7K3Vy0eqYLs8R0LEKMdJHtgoqHoVdcMEHIsZClTts8zo406B
	6YQ8D3OLsVN1Jy8OH0yp3v646N3St8DFrn0uj95AFrIEgYfdq0nL5kAMu7bDy0Kq
	MwOwkcYUK8IWS38TYRCQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0b1qs91w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 20:51:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 411Kp1Bq012792
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Feb 2024 20:51:01 GMT
Received: from [10.110.0.40] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 1 Feb
 2024 12:51:00 -0800
Message-ID: <fa376881-349b-c3bd-ba61-c8f183ce63bb@quicinc.com>
Date: Thu, 1 Feb 2024 12:50:48 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v8 3/7] soc: qcom: add QCOM PBS driver
Content-Language: en-US
To: Lee Jones <lee@kernel.org>, Bjorn Andersson <andersson@kernel.org>
CC: <pavel@ucw.cz>, <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <luca.weiss@fairphone.com>,
        <konrad.dybcio@linaro.org>, <u.kleine-koenig@pengutronix.de>,
        <quic_subbaram@quicinc.com>, <quic_gurus@quicinc.com>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
References: <20231221185838.28440-1-quic_amelende@quicinc.com>
 <20231221185838.28440-4-quic_amelende@quicinc.com>
 <ut6jbawqqdgfyoxmt76hm67rbnv67x54eho3nae2dd2szbejfb@7joy57g4i3qt>
 <20240131085842.GF8551@google.com>
From: Anjelique Melendez <quic_amelende@quicinc.com>
In-Reply-To: <20240131085842.GF8551@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Wb8aFo_Pb2ZnFguV7fIUaGDcbUfmJVLs
X-Proofpoint-GUID: Wb8aFo_Pb2ZnFguV7fIUaGDcbUfmJVLs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_06,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 mlxscore=0 mlxlogscore=616 priorityscore=1501 adultscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2402010161



On 1/31/2024 12:58 AM, Lee Jones wrote:
> Intentional generic top-post reply.
> 
> Please work quickly to resolve Bjorn's comments.
> 
> I'm being hounded over a broken LEDs tree due to the missing headerfile.
> 
> /end
> 

Updated changes for QCOM PBS driver with Bjorn's comments can be found
at new series:
https://lore.kernel.org/all/20240201204421.16992-2-quic_amelende@quicinc.com/

