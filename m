Return-Path: <linux-kernel+bounces-156279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 691008B00B5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23222284A0F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0299E154446;
	Wed, 24 Apr 2024 04:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="S6sjMxfK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4CE13C82F;
	Wed, 24 Apr 2024 04:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713934549; cv=none; b=pu10oJXrzMw+j8jRcsT5/0WmMLAKQSgT5O1gGFjV/9mdWeKqQtcFdXObTtHUfgmKPYIYPq32CqiMrnnjvd0nUxs4HfcA+dreefe0bFmGpowauw+maKC+oa/p7Ipr59cy//dSXzgXSn27M/p+g5uutfo2cnrZyy4bb+hgxcqx4is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713934549; c=relaxed/simple;
	bh=3HNfuRsq5bP8CtlU4c34os9Pd3q+GbzNbJqEXXr5x1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WTYWtJwNpCSt1j+qRMO5B+WnYWrw4pjIHy3Yf961GB4Zu11MvuN0YwMxUope9PVm49Lzq+8V5imwz04udRxsQ6JPapFfNjWL2vj2r7Ed7uEpeaJFWDpSabiH980qI8hQHIxGMjU+9/iKlf0CgZy3FjdfaTqJXviYD3Q/gTQgLmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=S6sjMxfK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O4YpaL009997;
	Wed, 24 Apr 2024 04:55:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=d6RfTbleXipL1qn6KV8zRM3DFf84k4bMIcll6M1FFlg=; b=S6
	sjMxfKoVyTRCUtb/opByWZ/jpzdNz7UTxVOUXXFz4LI9XjntL7pS/8CXHQ8FE0MG
	to+l0tsrEiJronR2J2GPJPzBI2xLhz1jZThvCzbrHQYEhyqqzsK300ordUJiVa73
	IJLpT+PUClGTGi4oZIKYwFSXKdPnVi1fqBYvJt9ltCRWqGXkgWCbCRFXPuHE5HOW
	c248AjQj3pOEk59RJqctuOjWVrueD2uyN3NdgCWVJFwxsdvOS+A5nHfsjcBQajsw
	pvUlsKmCS6EMe6v/J5XGYyhZ2D6T8tNVdlFnX1wSVQi8K9GJvoJNQhzckCMxGtsB
	TtUWovkCfCB/+ac5Xchw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpu6a00yp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 04:55:42 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43O4tfAH008444
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 04:55:42 GMT
Received: from [10.253.72.119] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 23 Apr
 2024 21:55:40 -0700
Message-ID: <a5744a30-8464-441d-b306-546b08099400@quicinc.com>
Date: Wed, 24 Apr 2024 12:55:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: qca: set power_ctrl_enabled on NULL returned
 by gpiod_get_optional()
To: Bartosz Golaszewski <brgl@bgdev.pl>,
        Marcel Holtmann
	<marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bartosz
 Golaszewski <bartosz.golaszewski@linaro.org>,
        Wren Turkal
	<wt@penguintechs.org>,
        Greg KH <gregkh@linuxfoundation.org>
References: <20240422130036.31856-1-brgl@bgdev.pl>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <20240422130036.31856-1-brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 24XnXVLNxtl46AyVO20Y4CMnI-rDQNGL
X-Proofpoint-GUID: 24XnXVLNxtl46AyVO20Y4CMnI-rDQNGL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_02,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxscore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1011
 spamscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240020

On 4/22/2024 9:00 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Any return value from gpiod_get_optional() other than a pointer to a
> GPIO descriptor or a NULL-pointer is an error and the driver should
> abort probing. That being said: commit 56d074d26c58 ("Bluetooth: hci_qca:
> don't use IS_ERR_OR_NULL() with gpiod_get_optional()") no longer sets
> power_ctrl_enabled on NULL-pointer returned by
> devm_gpiod_get_optional(). Restore this behavior but bail-out on errors.
> 
> Reported-by: Wren Turkal <wt@penguintechs.org>
> Reported-by: Zijun Hu <quic_zijuhu@quicinc.com>
> Closes: https://lore.kernel.org/linux-bluetooth/1713449192-25926-2-git-send-email-quic_zijuhu@quicinc.com/
> Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/bluetooth/hci_qca.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 92fa20f5ac7d..739248c6d6b9 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -2327,9 +2327,12 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>  		    (data->soc_type == QCA_WCN6750 ||
>  		     data->soc_type == QCA_WCN6855)) {
>  			dev_err(&serdev->dev, "failed to acquire BT_EN gpio\n");
> -			power_ctrl_enabled = false;
> +			return PTR_ERR(qcadev->bt_en);
>  		}
>  
For QCA6390, control logic do not reach here, so it has no any help for
QCA6390.
> +		if (!qcadev->bt_en)
> +			power_ctrl_enabled = false;
> +
property enable-gpios are obviously marked as required for WCN6750 and
WCN6855 by dts binding spec as shown by below link:
https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/tree/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml

if user don't config the property then "qcadev->bt_en is NULL", can we
still treat this case as good case?

that is why i changed my fix from reverting the wrong commit to only
focusing on QCA6390.

i will give different fix for other impacted QCA controllers.

>  		qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
>  					       GPIOD_IN);
>  		if (IS_ERR(qcadev->sw_ctrl) &&

NAK as explained above.

