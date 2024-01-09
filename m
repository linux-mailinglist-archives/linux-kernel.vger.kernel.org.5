Return-Path: <linux-kernel+bounces-20241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8D6827C56
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 02:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09E9E2846CD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 01:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404F810E4;
	Tue,  9 Jan 2024 01:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Vxv9aHZh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223717F7;
	Tue,  9 Jan 2024 01:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4090GfGs005238;
	Tue, 9 Jan 2024 01:01:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=YkE9BePJ3/T+gfxs4QOPxXY1xvEbQyIvPXXzyseE/7o=; b=Vx
	v9aHZhG6nBRhCNbvz1rVhCPj0anAC3VvIlrYXwbU0AUULwyIEk+XylHM5maASC/k
	W8WKc2FRZrgzWn5Y703Hgo5w1MNoCPr2O7mNeiY0K+irjqwwcytsbYFm4eU4CWuv
	at0XdMSrpZQjI5Ih14BXOyTvKN+cFuAMUllRYJInrdQ5UJsir6xeIrlR9pOkiU8e
	461sR9NSlmKNebRg7r1qv459xarpWoSpJl4eBimQsx7ayGlWaErQxE48SdYSM2Nz
	/YrmEo8PX/WC+lzxiLC/TG8FrltNFUSxIjSICkmLpJuULgod/Ack7V87mHHVuHQ7
	1JPpMm101OH5LjxhqUzA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgch524mm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 01:01:19 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40911Ia8009354
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 01:01:18 GMT
Received: from [10.71.108.105] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 8 Jan
 2024 17:01:18 -0800
Message-ID: <25d96ce7-749b-4fb7-826c-d5e3a4d733f5@quicinc.com>
Date: Mon, 8 Jan 2024 17:01:17 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/4] firmware: qcom: scm: Modify only the download
 bits in TCSR register
Content-Language: en-US
To: Mukesh Ojha <quic_mojha@quicinc.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linus.walleij@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        Poovendhan Selvaraj <quic_poovendh@quicinc.com>
References: <1704727654-13999-1-git-send-email-quic_mojha@quicinc.com>
 <1704727654-13999-3-git-send-email-quic_mojha@quicinc.com>
From: Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <1704727654-13999-3-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MQCsuPwx3nWfeHE64sSiDQvJH0O1kZbv
X-Proofpoint-GUID: MQCsuPwx3nWfeHE64sSiDQvJH0O1kZbv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 mlxscore=0 adultscore=0 impostorscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401090004



On 1/8/2024 7:27 AM, Mukesh Ojha wrote:
> Crashdump collection is done based on DLOAD bits of TCSR register.
> To retain other bits, scm driver need to read the register and
> modify only the DLOAD bits, as other bits in TCSR may have their
> own significance.
> 
> Co-developed-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
> Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> Tested-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com> # IPQ9574 and IPQ5332
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>

> ---
>  drivers/firmware/qcom/qcom_scm.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 25549178a30f..4421f219fe9a 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -4,6 +4,8 @@
>   */
>  
>  #include <linux/arm-smccc.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
>  #include <linux/clk.h>
>  #include <linux/completion.h>
>  #include <linux/cpumask.h>
> @@ -117,6 +119,12 @@ static const u8 qcom_scm_cpu_warm_bits[QCOM_SCM_BOOT_MAX_CPUS] = {
>  #define QCOM_SMC_WAITQ_FLAG_WAKE_ONE	BIT(0)
>  #define QCOM_SMC_WAITQ_FLAG_WAKE_ALL	BIT(1)
>  
> +#define QCOM_DLOAD_MASK		GENMASK(5, 4)
> +enum qcom_dload_mode {
> +	QCOM_DLOAD_NODUMP	= 0,
> +	QCOM_DLOAD_FULLDUMP	= 1,
> +};
> +
>  static const char * const qcom_scm_convention_names[] = {
>  	[SMC_CONVENTION_UNKNOWN] = "unknown",
>  	[SMC_CONVENTION_ARM_32] = "smc arm 32",
> @@ -523,6 +531,7 @@ static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
>  
>  static void qcom_scm_set_download_mode(bool enable)
>  {
> +	u32 val = enable ? QCOM_DLOAD_FULLDUMP : QCOM_DLOAD_NODUMP;
>  	bool avail;
>  	int ret = 0;
>  
> @@ -532,8 +541,9 @@ static void qcom_scm_set_download_mode(bool enable)
>  	if (avail) {
>  		ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
>  	} else if (__scm->dload_mode_addr) {
> -		ret = qcom_scm_io_writel(__scm->dload_mode_addr,
> -				enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0);
> +		ret = qcom_scm_io_rmw(__scm->dload_mode_addr,
> +				      QCOM_DLOAD_MASK,
> +				      FIELD_PREP(QCOM_DLOAD_MASK, val));
>  	} else {
>  		dev_err(__scm->dev,
>  			"No available mechanism for setting download mode\n");

