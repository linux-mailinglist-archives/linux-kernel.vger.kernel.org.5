Return-Path: <linux-kernel+bounces-135467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C329889C48D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E737E1C21FC6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFA67FBB0;
	Mon,  8 Apr 2024 13:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZVweTJVT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774287EEF2;
	Mon,  8 Apr 2024 13:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712584023; cv=none; b=F/qc/G2w5fh5mbws5GODJR931X+O74+1W1cK1rdqGRvMEtLedv8IN5KQogowVubcA5vOWtQsv1pmxmSmJEpkXCaPbjdata2ETz+VL3rz+7Rwy835UUKiq42rT6HygtuOiMM5REwcbJHXctrapueHWP/oSPNJ3xqiD2FN2k+f530=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712584023; c=relaxed/simple;
	bh=L2xd1aiwTb639zOKYegthEwPMP+na8MbpMyULkrDrpo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=W/o71twOy/E9MDep5V4curhgg8OoM3WEgxuZpooz7/QfXJMIbQxi+ypAhWAToFxW1l6y0AAF3LzRuvkD9Fe6yU6uutSE6fW2mj9jPLcv2SWqP6k4BKqOXKp7oQZBSUl6bzUUPHHwlLSHIDszTq9S5d0oKNCo/1zK1z9NbwutZXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZVweTJVT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 438CuJQn002013;
	Mon, 8 Apr 2024 13:46:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:from:subject:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=welPpz4fuPVMQkgSviG18/N0pNIiqnjcj2TKyy5xmkk=; b=ZV
	weTJVTBQgWzShTFd0czdsiNEXh1Rm/iiK8KUGDfv4VgR1uRsnL+HqW6t7bdD24hN
	OnV2gELutDQCurZF7Rln1ZBlWKT/TABs22NHvvepU1ILgCatOhpKPi2CYpfYU2T2
	NFzWIpYPkVkgABfqJLvlZ/H/692/HPpNbqjlHOXDe9ylRD5JZmKK3rl3QA9fC3dn
	23Nhc8ur29eUhWcGdEGZIxr5AXb5PPRORbZx6ZTDdN4HQCshKgGDogLplagntlpf
	Kwh4TvhRXjk9fVpDtUlzVnpOSghxQrhzH1+MelheB9YTnfhteqiMQqM2IozmvDxa
	XzSvZr5bJxYhAuKKOkFw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xcbg2rwsu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 13:46:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 438Dkuws030322
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Apr 2024 13:46:56 GMT
Received: from [10.216.32.99] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Apr 2024
 06:46:53 -0700
Message-ID: <22d7abd1-139d-405b-984e-e4b57cc989cc@quicinc.com>
Date: Mon, 8 Apr 2024 19:16:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Subject: Re: [PATCH 2/5] usb: typec: ucsi: glink: move GPIO reading into
 connector_status callback
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Heikki Krogerus
	<heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: Neil Armstrong <neil.armstrong@linaro.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240408-ucsi-orient-aware-v1-0-95a74a163a10@linaro.org>
 <20240408-ucsi-orient-aware-v1-2-95a74a163a10@linaro.org>
Content-Language: en-US
In-Reply-To: <20240408-ucsi-orient-aware-v1-2-95a74a163a10@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: z6eXXlk_uhdoX2ZPcij72Do59dtFt2Jl
X-Proofpoint-GUID: z6eXXlk_uhdoX2ZPcij72Do59dtFt2Jl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_12,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 suspectscore=0 phishscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404080104



On 4/8/2024 10:00 AM, Dmitry Baryshkov wrote:
> To simplify the platform code move Type-C orientation handling into the
> connector_status callback. As it is called both during connector
> registration and on connector change events, duplicated code from
> pmic_glink_ucsi_register() can be dropped.
> 
> Also this moves operations that can sleep into a worker thread,
> removing the only sleeping operation from pmic_glink_ucsi_notify().
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Verified working of device mode (ADB) in SS in both orientations on 
QCS6490 RB3Gen2.

As an experiment, removed the connector status call being done in 
ucsi_register_port to see if the issue fixed by [1] would be 
reproducible or not and it is. So this patch is taking care of proper 
enumeration in bootup in host mode in reverse orientation as well.

Tested-by: Krishna Kurapati <quic_kriskura@quicinc.com>

[1]: 
https://lore.kernel.org/all/20240301040914.458492-1-quic_kriskura@quicinc.com/

> ---
>   drivers/usb/typec/ucsi/ucsi_glink.c | 48 ++++++++++++++++---------------------
>   1 file changed, 20 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
> index b91d2d15d7d9..d21f8cd2fe35 100644
> --- a/drivers/usb/typec/ucsi/ucsi_glink.c
> +++ b/drivers/usb/typec/ucsi/ucsi_glink.c
> @@ -187,10 +187,28 @@ static int pmic_glink_ucsi_sync_write(struct ucsi *__ucsi, unsigned int offset,
>   	return ret;
>   }
>   
> +static void pmic_glink_ucsi_connector_status(struct ucsi_connector *con)
> +{
> +	struct pmic_glink_ucsi *ucsi = ucsi_get_drvdata(con->ucsi);
> +	int orientation;
> +
> +	if (con->num >= PMIC_GLINK_MAX_PORTS ||
> +	    !ucsi->port_orientation[con->num - 1])
> +		return;
> +
> +	orientation = gpiod_get_value(ucsi->port_orientation[con->num - 1]);
> +	if (orientation >= 0) {
> +		typec_switch_set(ucsi->port_switch[con->num - 1],
> +				 orientation ? TYPEC_ORIENTATION_REVERSE
> +				 : TYPEC_ORIENTATION_NORMAL);
> +	}
> +}
> +
>   static const struct ucsi_operations pmic_glink_ucsi_ops = {
>   	.read = pmic_glink_ucsi_read,
>   	.sync_write = pmic_glink_ucsi_sync_write,
> -	.async_write = pmic_glink_ucsi_async_write
> +	.async_write = pmic_glink_ucsi_async_write,
> +	.connector_status = pmic_glink_ucsi_connector_status,
>   };
>   
>   static void pmic_glink_ucsi_read_ack(struct pmic_glink_ucsi *ucsi, const void *data, int len)
> @@ -229,20 +247,8 @@ static void pmic_glink_ucsi_notify(struct work_struct *work)
>   	}
>   
>   	con_num = UCSI_CCI_CONNECTOR(cci);
> -	if (con_num) {
> -		if (con_num <= PMIC_GLINK_MAX_PORTS &&
> -		    ucsi->port_orientation[con_num - 1]) {
> -			int orientation = gpiod_get_value(ucsi->port_orientation[con_num - 1]);
> -
> -			if (orientation >= 0) {
> -				typec_switch_set(ucsi->port_switch[con_num - 1],
> -						 orientation ? TYPEC_ORIENTATION_REVERSE
> -							     : TYPEC_ORIENTATION_NORMAL);
> -			}
> -		}
> -
> +	if (con_num)
>   		ucsi_connector_change(ucsi->ucsi, con_num);
> -	}
>   
>   	if (ucsi->sync_pending &&
>   		   (cci & (UCSI_CCI_ACK_COMPLETE | UCSI_CCI_COMMAND_COMPLETE))) {
> @@ -253,20 +259,6 @@ static void pmic_glink_ucsi_notify(struct work_struct *work)
>   static void pmic_glink_ucsi_register(struct work_struct *work)
>   {
>   	struct pmic_glink_ucsi *ucsi = container_of(work, struct pmic_glink_ucsi, register_work);
> -	int orientation;
> -	int i;
> -
> -	for (i = 0; i < PMIC_GLINK_MAX_PORTS; i++) {
> -		if (!ucsi->port_orientation[i])
> -			continue;
> -		orientation = gpiod_get_value(ucsi->port_orientation[i]);
> -
> -		if (orientation >= 0) {
> -			typec_switch_set(ucsi->port_switch[i],
> -					 orientation ? TYPEC_ORIENTATION_REVERSE
> -					     : TYPEC_ORIENTATION_NORMAL);
> -		}
> -	}
>   
>   	ucsi_register(ucsi->ucsi);
>   }
> 

