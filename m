Return-Path: <linux-kernel+bounces-156879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD68C8B09CB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AC2B288FC6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07D9156C71;
	Wed, 24 Apr 2024 12:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HoKBOGnj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406CF1422AF;
	Wed, 24 Apr 2024 12:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713962117; cv=none; b=MQ5sLm4GBbfSySFuikhl5Pta/64cdlslEJ6xYuRLcm1FbSQvoYwYPZFwPFC69PCna/rHIIeWvvj3WF0w25SJeDIzVLYVJOnEXXkPotcX6R/5zCIep7vHd9vUVVAv25V7v+0y7O4S29Cz/M6CuX95HpQy6CnKAp5RNhleMipejLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713962117; c=relaxed/simple;
	bh=euBhKKRAZfP8bkZP7NfOoDWm2mrR1O7s+NJunVNlrN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oGn0IUYG//OaWhPZ8/OPZilydBizMgfU7bZq6QTcyYsxZVYFhHyJ7jCLLv71Q0RrhBU7HQlHvoymYySeQHdX+ZTduntIRCvQPPoYPKi6wdRNzbwTzJvjYVJOWnGg4ShgHJcO6ZASz/xTRv96miS1jv1zBQDX7szKvFezQsw9erg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HoKBOGnj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O6X6Nk016591;
	Wed, 24 Apr 2024 12:35:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=LIuvOopV6jIZ86QWy/NYqyoYufHIQ2SMGNewMIp+6fs=; b=Ho
	KBOGnjXCyxmt3CaMbDV5QcKBWD4tMckFl4lJqiDo4zJIAbAw1ji1HXXw00sgdgAL
	f3yCMDOjtxoee51XboZJq8CyNJgMDEXxIkRiyOB+KnkLxhmGtshaXuO4FhYIwtdU
	8p19CK/gKsNTMnk4iGyVKOmaP+Gk+nZ+y/uIha93s/5T0pJGsVsxFBdel7HM9Qq+
	DSqF+TjZRODx4fXQC09qTvvRmXBtitMRPUXG1xH9OnThwyz6Q4MnSm9K4gQTuezu
	eI2Z8/o3qCFyMBMDUCVXC4pesOO/KXRbtyEwCgPfgTXuJDjABLVULbv8WrZMReZc
	F2Zlu74aX9FwARrO3BFw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9krt0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 12:35:09 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43OCZ8UZ031675
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 12:35:08 GMT
Received: from [10.253.14.221] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 24 Apr
 2024 05:35:06 -0700
Message-ID: <716ba868-c54f-4728-bb39-2e41c63dad29@quicinc.com>
Date: Wed, 24 Apr 2024 20:35:03 +0800
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
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: m8v00ksKYrVO3p1NVCZ6XWsJY2Okiz24
X-Proofpoint-GUID: m8v00ksKYrVO3p1NVCZ6XWsJY2Okiz24
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_10,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240046

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
> +		if (!qcadev->bt_en)
> +			power_ctrl_enabled = false;
> +
>  		qcadev->susclk = devm_clk_get_optional(&serdev->dev, NULL);
>  		if (IS_ERR(qcadev->susclk)) {
>  			dev_warn(&serdev->dev, "failed to acquire clk\n");NAK, you don't answer my question for your v1 before send v2


