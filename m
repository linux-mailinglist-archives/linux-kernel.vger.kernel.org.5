Return-Path: <linux-kernel+bounces-20242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E34827C59
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 02:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5743AB229A3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 01:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E66F2906;
	Tue,  9 Jan 2024 01:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UQ2qAH3G"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218622573;
	Tue,  9 Jan 2024 01:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 408NLtfS011415;
	Tue, 9 Jan 2024 01:02:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=GhuqgLT+Edx80P5u459iv8Evf80C0H/EK5npkY8dxAE=; b=UQ
	2qAH3GHCTtXpKJ641DRLLEokiTL73k/Lm3PsIDyQVD4uXfeqmrr2swKMsKL38W+W
	XMVWfj+F86ttXfHKYgwHwQmPn6WyainRv/G1ms0rhQbH5VGU+vOf9UG//BTACLli
	vPNadH0JWPjH05fj2itXK1br3unHWprQ4EtFDesYBG68UPafRVqKENSRQufcdYbS
	B6XnkNZxTx2ffA3eqpD7z40zZxYxsozL3P39YFAg0bFQtCir3Gjm3KQ/Fl/wxjYA
	BAAnIXjPDAJ6TJ+IAgMqmPtGgSLK4RkaJ7HoDTCNmwA4nyLpHI9Seye+JY3FPjBU
	oq+hmsexNcDineb5lM/Q==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgch524pc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 01:02:14 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40912EPG008386
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 01:02:14 GMT
Received: from [10.71.108.105] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 8 Jan
 2024 17:02:13 -0800
Message-ID: <55a0eb43-f740-4efc-8f1b-67911781cd39@quicinc.com>
Date: Mon, 8 Jan 2024 17:02:13 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/4] firmware: qcom: scm: Rework dload mode
 availability check
Content-Language: en-US
To: Mukesh Ojha <quic_mojha@quicinc.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linus.walleij@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
References: <1704727654-13999-1-git-send-email-quic_mojha@quicinc.com>
 <1704727654-13999-4-git-send-email-quic_mojha@quicinc.com>
From: Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <1704727654-13999-4-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mhTxCQ2YaepcWBdPgSvl3b_QaQQQ3LRf
X-Proofpoint-GUID: mhTxCQ2YaepcWBdPgSvl3b_QaQQQ3LRf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 mlxscore=0 adultscore=0 impostorscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401090004



On 1/8/2024 7:27 AM, Mukesh Ojha wrote:
> QCOM_SCM_BOOT_SET_DLOAD_MODE was only valid for very older
> target and firmware and for recent targets there is dload
> mode tcsr registers is available to set the download mode.
> 
> So, it is better to keep it as fallback check instead of
> checking its availability and failing it always.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>

Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>

> ---
>  drivers/firmware/qcom/qcom_scm.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 4421f219fe9a..87bcd5c02f2b 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -532,18 +532,16 @@ static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
>  static void qcom_scm_set_download_mode(bool enable)
>  {
>  	u32 val = enable ? QCOM_DLOAD_FULLDUMP : QCOM_DLOAD_NODUMP;
> -	bool avail;
>  	int ret = 0;
>  
> -	avail = __qcom_scm_is_call_available(__scm->dev,
> -					     QCOM_SCM_SVC_BOOT,
> -					     QCOM_SCM_BOOT_SET_DLOAD_MODE);
> -	if (avail) {
> -		ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
> -	} else if (__scm->dload_mode_addr) {
> +	if (__scm->dload_mode_addr) {
>  		ret = qcom_scm_io_rmw(__scm->dload_mode_addr,
>  				      QCOM_DLOAD_MASK,
>  				      FIELD_PREP(QCOM_DLOAD_MASK, val));
> +	} else if (__qcom_scm_is_call_available(__scm->dev,
> +						QCOM_SCM_SVC_BOOT,
> +						QCOM_SCM_BOOT_SET_DLOAD_MODE)) {
> +		ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
>  	} else {
>  		dev_err(__scm->dev,
>  			"No available mechanism for setting download mode\n");

