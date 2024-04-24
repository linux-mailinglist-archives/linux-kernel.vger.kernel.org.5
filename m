Return-Path: <linux-kernel+bounces-156914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C498B0A44
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D67FFB282E2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECAF15B153;
	Wed, 24 Apr 2024 12:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="avol3+KF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C521415ADB8;
	Wed, 24 Apr 2024 12:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713963589; cv=none; b=tcz7eZYSfw3LbuEDGoub7LgCsC8X76erwq8QPSjbQI3jXDpS2l2we86bK+RQqOO/TLeGaHksne/YIif/wrXi3+tiFz3towEnRXYuDD6bM9p8qEHhwf2jfkenUbDlKN68dADMsOrsX6snWfyNdLRt8yeb9apAsTl0Sk4fYo5Lfio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713963589; c=relaxed/simple;
	bh=nYaJwBHScwcf8mZ+65pvV+Cbut1NnlCU/Umn54RReB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HDOHuX0xNuAEDZi73/TCC7//Xm5O+UZidoDHryfFc8Pn377o2EOs5f2t6edW/s5Qa7MN3FLGuy5GQHTGAw4SskKG6aYu7IwtBPxBNl37Q8q4t8wF29XIUe8QBaX+C/b5QZcD2AuxpNuaDx56YZnq0VCZi6wtge3Qsbuo04ivD4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=avol3+KF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43OBd8Id027237;
	Wed, 24 Apr 2024 12:59:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=f20yqpl+kz5jwmAiKMXqy19f1liqCLMYGbmBPOR+394=; b=av
	ol3+KFGx8hrnnaDm4e4fmWebokluWlX9A4YCqlYe+QQDWUwtpw+OXrv1z2HKZj7f
	dDyR2r0pxY8j9bB4161zBZpEbiibo+27AiE06XIQfjKi9EyrY1baO5OiZhmdn77S
	JosA8rHCSuXhGBWnBcb9UWQ+17oE2b+jSJZsy7TMpdStLZjViHe6WQivfgeXnMAp
	0+jgDvs8noXZcHQafMnPyUlOJAn+qaRE/dmp3g8eIliW3dMEpmxqZwGFBUVjf1hu
	+YfxZspKhpvaog+brNK1pgXN2N+EufQDWPqujFGW3afAhBoK6Enoa0E2nrcgcJsb
	GIgIFcXpUed9Yju5weCA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9g8uck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 12:59:40 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43OCxdto002521
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 12:59:39 GMT
Received: from [10.253.14.221] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 24 Apr
 2024 05:59:37 -0700
Message-ID: <2d3823bd-bc30-4e3f-a350-eb9a718261aa@quicinc.com>
Date: Wed, 24 Apr 2024 20:59:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: qca: set power_ctrl_enabled on NULL
 returned by gpiod_get_optional()
To: Bartosz Golaszewski <brgl@bgdev.pl>,
        Marcel Holtmann
	<marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bartosz
 Golaszewski <bartosz.golaszewski@linaro.org>,
        Wren Turkal
	<wt@penguintechs.org>
References: <20240424122932.79120-1-brgl@bgdev.pl>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <20240424122932.79120-1-brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: F4kwVAATKcRsWYNE87LArXDTUMGAAx9o
X-Proofpoint-GUID: F4kwVAATKcRsWYNE87LArXDTUMGAAx9o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_10,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 mlxlogscore=999 malwarescore=0 adultscore=0
 mlxscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404240046

On 4/24/2024 8:29 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Any return value from gpiod_get_optional() other than a pointer to a
> GPIO descriptor or a NULL-pointer is an error and the driver should
> abort probing. That being said: commit 56d074d26c58 ("Bluetooth: hci_qca:
> don't use IS_ERR_OR_NULL() with gpiod_get_optional()") no longer sets
> power_ctrl_enabled on NULL-pointer returned by
> devm_gpiod_get_optional(). Restore this behavior but bail-out on errors.
> While at it: also bail-out on error returned when trying to get the
> "swctrl" GPIO.
> 
> Reported-by: Wren Turkal <wt@penguintechs.org>
> Reported-by: Zijun Hu <quic_zijuhu@quicinc.com>
> Closes: https://lore.kernel.org/linux-bluetooth/1713449192-25926-2-git-send-email-quic_zijuhu@quicinc.com/
> Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()")
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
is it really reviewed-by Krzysztof?
suggest reviewer give explicit review-by tag by public way, then you add
this tag.
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> v1 -> v2:
> - also restore the previous behavior for QCA6390 and other models that
>   fall under the default: label in the affected switch case
> - bail-out on errors when getting the swctrl GPIO too
> 
>  drivers/bluetooth/hci_qca.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 92fa20f5ac7d..0e98ad2c0c9d 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -2327,16 +2327,21 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>  		    (data->soc_type == QCA_WCN6750 ||
>  		     data->soc_type == QCA_WCN6855)) {
>  			dev_err(&serdev->dev, "failed to acquire BT_EN gpio\n");
> -			power_ctrl_enabled = false;
> +
think about what will happen for present lunched products if this type
error really happens.
BT don't work at all with your change. BT can be used mostly without
your change.
			return PTR_ERR(qcadev->bt_en);
>  		}
>  
> +		if (!qcadev->bt_en)
> +			power_ctrl_enabled = false;
> +
you don't answer me how to treat a required enable is not configured by user
>  		qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
>  					       GPIOD_IN);
>  		if (IS_ERR(qcadev->sw_ctrl) &&
>  		    (data->soc_type == QCA_WCN6750 ||
>  		     data->soc_type == QCA_WCN6855 ||
> -		     data->soc_type == QCA_WCN7850))
> -			dev_warn(&serdev->dev, "failed to acquire SW_CTRL gpio\n");
> +		     data->soc_type == QCA_WCN7850)) {
> +			dev_err(&serdev->dev, "failed to acquire SW_CTRL gpio\n");
> +			return PTR_ERR(qcadev->sw_ctrl);have the same question as above.
> +		}
>  
>  		qcadev->susclk = devm_clk_get_optional(&serdev->dev, NULL);
>  		if (IS_ERR(qcadev->susclk)) {
> @@ -2355,10 +2360,13 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>  		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
>  					       GPIOD_OUT_LOW);
>  		if (IS_ERR(qcadev->bt_en)) {
> -			dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
> -			power_ctrl_enabled = false;
> +			dev_err(&serdev->dev, "failed to acquire enable gpio\n");
> +			return PTR_ERR(qcadev->bt_en);
>  		}
> 
have the same question as above.
is it right for such prompt ?
> +		if (!qcadev->bt_en)
> +			power_ctrl_enabled = false;
> +
>  		qcadev->susclk = devm_clk_get_optional(&serdev->dev, NULL);
>  		if (IS_ERR(qcadev->susclk)) {
>  			dev_warn(&serdev->dev, "failed to acquire clk\n");
have the same question as above.

how do you known the root cause of the issue reported without my earlier
debugging and fix?

do my fix regarding the issue i concerned have any  fault?

NAK by me.





