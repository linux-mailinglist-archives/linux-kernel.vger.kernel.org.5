Return-Path: <linux-kernel+bounces-76367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A75F85F63B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BFDDB26415
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B670B446DE;
	Thu, 22 Feb 2024 10:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gjNpRHNc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6753EA7B;
	Thu, 22 Feb 2024 10:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599300; cv=none; b=s5Ryw+QY8IB1KbgbSCiyl8v4So8p+Kd6ZJBBt1wVcnBy+mOgKMgZcmtiOt5qnkTal+7eRHu6OI19U04x7GntIW1mEEV/2Oz1B3BjQ8mV3MZJ1UXgeyLkmidlugWhjieNGo47EzNrEc6zpr11hdWXv/avlDZnDsZDKH2S1V/eu30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599300; c=relaxed/simple;
	bh=RedU7cjDZ5jk5QCJD5LXoLPJJWRvLq4jZq/wgBlLcTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EOg3Qs8HYc8HrjcSzcD/fnc6RyGJMM6lUGqvopiOE0Mge7i3C9m94qo4ZaQtTlfaQrS9rNHqxM8BVIIyeyRiUjgsoD8uRBj+pojc/PLD93CokU9HC7mMEiOgYQfZNhMrkU2BJQSoakX4wHDuK3t6a+lQ/bP1m9V1Lq8BNQ2sqVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gjNpRHNc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41M6nHhl020415;
	Thu, 22 Feb 2024 10:54:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=NI/KfsTyaC0QX8r1LRI4NAkA3iKn0O+gPUEgOUGWsx0=; b=gj
	NpRHNcUtEQyagH0kZeGcCYgKg8IwrKVVLLYQFFeMLimDWdUN2KzwhnKEDE5kzTko
	H8tPtBhLNuC7DT+9ak243VmXWZoLU1IESUa3J/dndNoztwqUeufDt9hTC1Wh5lKN
	KY4w2H7GBj/TP5c5lUU4Slh5FKqFek9qaBWeH13k98ItPBXLztdYtQKiqgRqp7YX
	8J6uBr/TzGAIpts7eK6dmosd4EdHAswSC3gB0vqL1nhmNU0q2LS+pODCa0Lo6e0a
	UgI9q/42W4FRquyayKbCPjJk/gaOo/igwepc+Vsb3jrt+mg3OrYQuV0SLQDXwpj1
	7WVFp6qyes6IU29eTOAw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3we1b0gqxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 10:54:53 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41MAsqRA028508
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 10:54:52 GMT
Received: from [10.217.216.110] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 22 Feb
 2024 02:54:48 -0800
Message-ID: <ddef6339-6a37-4048-80f0-7c008ec51cf0@quicinc.com>
Date: Thu, 22 Feb 2024 16:24:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Add support for QoS configuration
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <djakov@kernel.org>
CC: <rafael@kernel.org>, <corbet@lwn.net>, <linux-pm@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_viveka@quicinc.com>, <peterz@infradead.org>,
        <quic_mdtipton@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <krzysztof.kozlowski@linaro.org>, <quic_rlaggysh@quicinc.com>
References: <20240205145606.16936-1-quic_okukatla@quicinc.com>
 <8189e50a-290c-494d-af42-a954a5d231ea@linaro.org>
From: Odelu Kukatla <quic_okukatla@quicinc.com>
In-Reply-To: <8189e50a-290c-494d-af42-a954a5d231ea@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ugENXyXxM07IrtegMDzAOQ1WnFa0UPvP
X-Proofpoint-GUID: ugENXyXxM07IrtegMDzAOQ1WnFa0UPvP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_09,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=813
 mlxscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220086



On 2/6/2024 2:37 PM, Konrad Dybcio wrote:
> 
> 
> On 2/5/24 15:56, Odelu Kukatla wrote:
>> This series adds QoS support for QNOC type device which can be found on
>> SC7280 platform. It adds support for programming priority,
>> priority forward disable and urgency forwarding. This helps in
>> priortizing the traffic originating from different interconnect masters
>> at NOC(Network On Chip).
>>
>> Changes in v2:
>>   - Updated regmap_update to make use GENMASK and FIELD_PREP.
>>   - Removed the regmap structure from qcom_icc_node.
>>   - Made qcom_icc_rpmh_configure_qos() static
>>   - Removed qcom_icc_rpmh_map() API, inlined the code in probe
>>     function.
>>   - Updated declarations to reverse christmas tree fashion.
> 
> You ignored some of my previous review comments without a response.
> 
> Konrad

Thanks Konrad! i replied to all of your comments.
I will send V3 with all the comments addressed.

Thanks,
Odelu

