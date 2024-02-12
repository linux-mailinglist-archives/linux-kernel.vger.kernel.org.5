Return-Path: <linux-kernel+bounces-61082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09028850CFE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 04:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B1A81C220E9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 03:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EAA468F;
	Mon, 12 Feb 2024 03:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DaBLuR2q"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4073C0B;
	Mon, 12 Feb 2024 03:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707706896; cv=none; b=o1JxiPOeePxMd28Ujlw/s4KXvvsst1m8H08O1Pq8/1lQ0e2whmwYLrAPXi5ZI+dX6B51w0XjLgpG38cYcFT0uo3tu0HZEGj6NXwGZOZaGJaCsFfAl0thiRwEj4b6i2j3W09WxZQmNTu81FIswfFDCr0P1Kq9GqF1/zt7woycxCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707706896; c=relaxed/simple;
	bh=4jxNxqbbPkOSw8ue3Nyb20xACqDs10FTDEVUKIMb1w4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=t+4r5mr0E3eGb2mQ9nOXZDhqr/ynSpMdqRkr6BWTbxsnyr8pVHXMTmzBcyVU1CjPkZUebCcYcPE5ZwYZkIkR+2eo+FQ3HLetiadcG46vtZK/Kvr07ZuV7Qruv8Y41+EE2Vf8B7+8ougSTjIGp8w5dHmRflyQbF0p8dnfSzYjBzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DaBLuR2q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41C2kaKt007373;
	Mon, 12 Feb 2024 03:01:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=HbyEud8oCRMq2ig6tJgd3FsKNUjDeJrJ85T3IXPqjBQ=; b=Da
	BLuR2q/W+4mXnc4vKyu282ayH6XJfyKMt+GAMx/rQ4I2DQ2Rjp2TYrDAPcEhqDyE
	n/KVq9TBYwEr8fdpObgZPIUfzwdFSI0YrMl2sfHjv1zBD5eDy6LfWVYJKugGy2K7
	DJb9Y8LFQ+wL0AwB+r4FXTylOT+DGgBV/t9LNJpISJphi58DHlmFarRUdq1LnHqV
	pw8mToXUb0+TmUCWq2YOEdjQi62qXcUyb7N3kNX+ZX1y2KtrZIVG5UDMxa5EV7rI
	djRoF/XFh+l3EeMFvO3VKZg1ibzqYiggW03tbzQx7+kSnhxonAmQYh3k4ukcAqYZ
	XT/lEGdWgh6r4V2/GjdA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w62q2tbpm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 03:01:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41C313T4018081
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 03:01:03 GMT
Received: from [10.131.116.149] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 11 Feb
 2024 19:01:00 -0800
Message-ID: <06abbdc3-266b-47a9-8d08-fe90311269d3@quicinc.com>
Date: Mon, 12 Feb 2024 08:30:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: watchdog: qcom-wdt: Update maintainer to
 Rajendra Nayak
Content-Language: en-US
To: Jeffrey Hugo <quic_jhugo@quicinc.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240209161800.3872964-1-quic_jhugo@quicinc.com>
From: Rajendra Nayak <quic_rjendra@quicinc.com>
In-Reply-To: <20240209161800.3872964-1-quic_jhugo@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TT6eLdPACJTuM5n9TB48ItyazQY26F8V
X-Proofpoint-GUID: TT6eLdPACJTuM5n9TB48ItyazQY26F8V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-11_23,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 mlxscore=0 mlxlogscore=832 clxscore=1011
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402120022



On 2/9/2024 9:48 PM, Jeffrey Hugo wrote:
> The servers for the @codeaurora domain are long retired and any messages
> sent there will bounce. Sai has left the company and appears no longer
> active in the community which leaves this binding orphaned. Rajendra Nayak
> has volunteered to take over as maintainer.
> 
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

Acked-by: Rajendra Nayak <quic_rjendra@quicinc.com>

> ---
>   Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> index a4f35c598cdb..47587971fb0b 100644
> --- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>   title: Qualcomm Krait Processor Sub-system (KPSS) Watchdog timer
>   
>   maintainers:
> -  - Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> +  - Rajendra Nayak <quic_rjendra@quicinc.com>
>   
>   properties:
>     $nodename:

