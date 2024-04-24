Return-Path: <linux-kernel+bounces-156641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2C88B061A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9611EB242A6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B3A158DA7;
	Wed, 24 Apr 2024 09:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ro2hz1i6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A2C158D98;
	Wed, 24 Apr 2024 09:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713951183; cv=none; b=NgCTVHOhshiIJX8gc9WfF/6RVZOzJdtz/xcrde/Xf2zJClSf00VsUY8HWYcxyCl6q6g18pfVU7aat68lqcvd4b8CotFpkL9ewnHfmo6Xu/dy9TY3/O8T4nmWokA/sp/xwFYhvydjefyH0UfU7/aNChm7AO2zT7Shn29Ol6APJKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713951183; c=relaxed/simple;
	bh=XAoDaSLB7wCCpkwfe/8LxJovzMgC7falZxZ9yi3zYco=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hnpjyVlIF/GnEX9lVyFlHMylXO2kA2QiAEsw/jdmQLwYolLbP6bDFRKu1E2ZsEjwrU6aOHlfs/h8dhgoko+EcNfmFclTTspBuvKOIoRV03LENCfbEGhFsrw8aTjYMIvXq2eg2Fq8CVMhN70sRCv54cy3WGQefXSkiJ0VxO8XwwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ro2hz1i6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O6WwLV012712;
	Wed, 24 Apr 2024 09:32:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=KW9GG4RF2n2mUr66b+BQfKuNtOmG38alDo4jWjSHswY=; b=Ro
	2hz1i6NUISigWBS0OKIr+kFm8jGxFbcNhqPLbJPOL2JAnBYNxlnxKbT295u6GCEc
	obHAKRuLb9nt1I2FNtsPxNHAWk8o3rqP0+ub4s2kqXmifhOZ9tV0JaHE6HdoxVmE
	OaiRTP06RYWXQF3tTfg49bP7ivM7OHDgDh9fR1LATvgXlp8JoTdWIQEAMKysI1DH
	dnmfF9bF6VsEkQjmPfGExFbNXBA8odtAuUC4ek2Ht7xJ7jTuYmMxYO+J1wg4pwqw
	9Hwo53pnmhNqipdzb7OG+X09KJvZ2H84qA1osYaITyZ8ByMhI1OY3mT7tw6arjqj
	Fu+HCT2mILh1nu0KV8rQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9pge5q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 09:32:54 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43O9Wrlx007249
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 09:32:53 GMT
Received: from [10.253.14.221] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 24 Apr
 2024 02:32:51 -0700
Message-ID: <7b3dc952-d202-4377-9bb6-e7598e28de97@quicinc.com>
Date: Wed, 24 Apr 2024 17:32:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: qca: set power_ctrl_enabled on NULL returned
 by gpiod_get_optional()
To: Bartosz Golaszewski <brgl@bgdev.pl>, Wren Turkal <wt@penguintechs.org>
CC: <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bartosz
 Golaszewski <bartosz.golaszewski@linaro.org>,
        Marcel Holtmann
	<marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240422130036.31856-1-brgl@bgdev.pl>
 <99242a7c-53bf-4227-9623-7bc092f564b3@penguintechs.org>
 <CAMRc=MepDwUbAKrWgm0CXKObqy8=igtug0QDgo-CgwxjZCAC2Q@mail.gmail.com>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <CAMRc=MepDwUbAKrWgm0CXKObqy8=igtug0QDgo-CgwxjZCAC2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5WCdC2_pDCVX97UWnGHK0DBxAo5CLzAF
X-Proofpoint-ORIG-GUID: 5WCdC2_pDCVX97UWnGHK0DBxAo5CLzAF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_06,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240040

On 4/24/2024 5:04 PM, Bartosz Golaszewski wrote:
> On Wed, 24 Apr 2024 07:07:05 +0200, Wren Turkal <wt@penguintechs.org> said:
>> On 4/22/24 6:00 AM, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>
>>> Any return value from gpiod_get_optional() other than a pointer to a
>>> GPIO descriptor or a NULL-pointer is an error and the driver should
>>> abort probing. That being said: commit 56d074d26c58 ("Bluetooth: hci_qca:
>>> don't use IS_ERR_OR_NULL() with gpiod_get_optional()") no longer sets
>>> power_ctrl_enabled on NULL-pointer returned by
>>> devm_gpiod_get_optional(). Restore this behavior but bail-out on errors.
>>
>> Nack. This patch does fixes neither the disable/re-enable problem nor
>> the warm boot problem.
>>
>> Zijun replied to this patch also with what I think is the proper
>> reasoning for why it doesn't fix my setup.
>>
> 
> Indeed, I only addressed a single issue here and not the code under the
> default: label of the switch case. Sorry.
> 
> Could you give the following diff a try?
> 
> Bart
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 92fa20f5ac7d..0e98ad2c0c9d 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -2327,16 +2327,21 @@ static int qca_serdev_probe(struct
> serdev_device *serdev)
>  		    (data->soc_type == QCA_WCN6750 ||
>  		     data->soc_type == QCA_WCN6855)) {
>  			dev_err(&serdev->dev, "failed to acquire BT_EN gpio\n");
> -			power_ctrl_enabled = false;
> +			return PTR_ERR(qcadev->bt_en);
>  		}
> 
> +		if (!qcadev->bt_en)
> +			power_ctrl_enabled = false;
> +
>  		qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
>  					       GPIOD_IN);
>  		if (IS_ERR(qcadev->sw_ctrl) &&
>  		    (data->soc_type == QCA_WCN6750 ||
>  		     data->soc_type == QCA_WCN6855 ||
> -		     data->soc_type == QCA_WCN7850))
> -			dev_warn(&serdev->dev, "failed to acquire SW_CTRL gpio\n");
> +		     data->soc_type == QCA_WCN7850)) {
> +			dev_err(&serdev->dev, "failed to acquire SW_CTRL gpio\n");
> +			return PTR_ERR(qcadev->sw_ctrl);
> +		}
> 
>  		qcadev->susclk = devm_clk_get_optional(&serdev->dev, NULL);
>  		if (IS_ERR(qcadev->susclk)) {
> @@ -2355,10 +2360,13 @@ static int qca_serdev_probe(struct
> serdev_device *serdev)
>  		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
>  					       GPIOD_OUT_LOW);
>  		if (IS_ERR(qcadev->bt_en)) {
> -			dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
> -			power_ctrl_enabled = false;
> +			dev_err(&serdev->dev, "failed to acquire enable gpio\n");
> +			return PTR_ERR(qcadev->bt_en);
>  		}
> 
> +		if (!qcadev->bt_en)
> +			power_ctrl_enabled = false;
> +
>  		qcadev->susclk = devm_clk_get_optional(&serdev->dev, NULL);
>  		if (IS_ERR(qcadev->susclk)) {
>  			dev_warn(&serdev->dev, "failed to acquire clk\n");
i suggest stop here and request you code review for my changes, i found
the issue and given fix for my concern.

