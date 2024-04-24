Return-Path: <linux-kernel+bounces-156950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 297888B0AC4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B18E1C2130C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6D315B973;
	Wed, 24 Apr 2024 13:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Yl0/GJvh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315A23398A;
	Wed, 24 Apr 2024 13:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713964971; cv=none; b=tmiDp4mirg9HhkynA2w8cVJX6klp8l+TpvBs22SSU2Ie/a2fZ2RfEqpeKKcA5zB+t3GjmYwH1d/mcFpqVSKrdOUR+AZUn/lf16d+xepwQtjXOQLdXHE97ctdO+McOAsVoATAgAvSlTSQrZAeg13IbssOGeuztBqmFdmWExig3ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713964971; c=relaxed/simple;
	bh=zCmcNTrU+2v35BqUDZyBMZL4UCxWMlwF7GcVOh+HcPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=brP6WHRc4sh7zFfiygojrw7KxBVovZJB8nPm56PZPY3OVKP62dvwrNf+1qebeYAln7tHBt4MyDGDQaCEXsczTq7HONNlWX52Cc1PYvQno3V+S7M+aOglG5l/gmasQDpAWw4vTCqbJmWBM8HxhXGDSjh79eNu/+FV9Yt6ZpOGqpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Yl0/GJvh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O6Xxuu016973;
	Wed, 24 Apr 2024 13:22:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=I7Qat0qrSIh4PYASELAjsK3Cr+jX7M+SZPOfBlwwPts=; b=Yl
	0/GJvhFIS3cE+ljFM7BGKEQyGlYKa21/To6a9u/LoqblQCmHVnBcUBZh3ZARCNht
	c7XFLWsaGS39ArgbpnJGXTmj3sDowsOkbeO6ujrbi9Qi+0s+jPVkreugcqV8vTcN
	o8bWuGn7obYIYFcEX/94iEe9lvxvV3pAMXXooYaZKQkje/xv2zMlTl7RGXdCdSE5
	LCVqDScoGRtSVvVkUxjSo8AruAGCRvT/dDCAwvfeL/Ts9Zs60QJTF8bOEqHbed5C
	nBgDXsuWdmb69zTHLsryT7zHvblgshuzZIoKUQ5dyCbPJnYkEIb8ETdY1zu0KL/c
	FYWWlSRucSOcm43W28CA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9e0why-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 13:22:42 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43ODMgrK005321
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 13:22:42 GMT
Received: from [10.253.14.221] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 24 Apr
 2024 06:22:40 -0700
Message-ID: <0e6bc9af-71f2-46b5-8b92-5da674b44ad7@quicinc.com>
Date: Wed, 24 Apr 2024 21:22:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: qca: set power_ctrl_enabled on NULL
 returned by gpiod_get_optional()
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Wren Turkal
	<wt@penguintechs.org>
CC: Bartosz Golaszewski <brgl@bgdev.pl>,
        Marcel Holtmann
	<marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240424122932.79120-1-brgl@bgdev.pl>
 <ba9b0e6e-3601-4460-ab5c-a02eb7708a4f@penguintechs.org>
 <CACMJSesZqCG=fdWe5C31a0iOFJ-ZpPRr70T_1TNLn7xqChZ4Sg@mail.gmail.com>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <CACMJSesZqCG=fdWe5C31a0iOFJ-ZpPRr70T_1TNLn7xqChZ4Sg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kpIiotUzHWS9Y9dvQ8ddRGHlGCODoqWH
X-Proofpoint-ORIG-GUID: kpIiotUzHWS9Y9dvQ8ddRGHlGCODoqWH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_10,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 phishscore=0 mlxlogscore=907
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404240046

On 4/24/2024 9:18 PM, Bartosz Golaszewski wrote:
> On Wed, 24 Apr 2024 at 15:10, Wren Turkal <wt@penguintechs.org> wrote:
>>
>> On 4/24/24 5:29 AM, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski<bartosz.golaszewski@linaro.org>
>>>
>>> Any return value from gpiod_get_optional() other than a pointer to a
>>> GPIO descriptor or a NULL-pointer is an error and the driver should
>>> abort probing. That being said: commit 56d074d26c58 ("Bluetooth: hci_qca:
>>> don't use IS_ERR_OR_NULL() with gpiod_get_optional()") no longer sets
>>> power_ctrl_enabled on NULL-pointer returned by
>>> devm_gpiod_get_optional(). Restore this behavior but bail-out on errors.
>>> While at it: also bail-out on error returned when trying to get the
>>> "swctrl" GPIO.
>>>
>>> Reported-by: Wren Turkal<wt@penguintechs.org>
>>> Reported-by: Zijun Hu<quic_zijuhu@quicinc.com>
>>> Closes:https://lore.kernel.org/linux-bluetooth/1713449192-25926-2-git-send-email-quic_zijuhu@quicinc.com/
>>> Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()")
>>> Reviewed-by: Krzysztof Kozlowski<krzysztof.kozlowski@linaro.org>
>>> Signed-off-by: Bartosz Golaszewski<bartosz.golaszewski@linaro.org>
>>
>> Tested-by: "Wren Turkal" <wt@penguintechs.org>
>>
>>
>> Like this?
> 
> Yes, awesome, thanks.
> 
> This is how reviewing works too in the kernel, look at what Krzysztof
> did under v1, he just wrote:
> 
> Reviewed-by: Krzysztof Kozlowski<krzysztof.kozlowski@linaro.org>
> 
v1 have obvious something wrong as i pointed and verified.
so i think it is not suitable to attach v1's review-by tag to v2 anyway.

> And mailing list tools will pick it up.
> 
> Bartosz


