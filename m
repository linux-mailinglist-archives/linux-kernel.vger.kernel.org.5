Return-Path: <linux-kernel+bounces-24345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D7982BB5C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 07:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C4101C2496D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 06:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0165C8FD;
	Fri, 12 Jan 2024 06:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GPAgfvQD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C4F45015;
	Fri, 12 Jan 2024 06:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40C3uKnN020967;
	Fri, 12 Jan 2024 06:51:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=2N4/PBv52utP6tUgzFaxxFCAiFD/OYFv5YNh9cACnVg=; b=GP
	AgfvQD4/BUUVJTwzgLf7DhCmpt5fq2Wr87ldCafn060qAU8ypjUCgGFdRWE45Op/
	4OU1Fv/MZewVA0ZXDgi0rbvQeiUiomNKI5uB/CHPr4rYMgtIOh0tiR9NFeyiQ4G6
	cd7lZ2aco36jWv6WD2jB9wjfBQM1Cl27GG+St3e/ij2plW6Nt6Y1BuEG9WeouXl5
	HJMytfXo9VLLIO9mndQyshZZKWNTkFTohGHQKecRXbepYa/hKpep0pOor/aOcyGG
	kPe6G2yPfyDugLul35x6lQhMQcOSdqUtEYZSQEcBOE6fH+mp7e6pn1LbSgYk6e+x
	eiecUoM/qdeYGjWyz87g==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vjjjj1uy2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 06:51:23 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40C6pMtH024587
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 06:51:22 GMT
Received: from [10.216.55.240] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 11 Jan
 2024 22:51:18 -0800
Message-ID: <f0d33617-3edf-6fa7-5e4b-9dbddcd6e697@quicinc.com>
Date: Fri, 12 Jan 2024 12:20:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] media: venus: flush all buffers in output plane
 streamoff
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
CC: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab
	<mchehab+huawei@kernel.org>,
        Stanimir Varbanov
	<stanimir.varbanov@linaro.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Stanimir
 Varbanov" <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia
	<quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Mauro
 Carvalho Chehab" <mchehab@kernel.org>
References: <1704867134-5522-1-git-send-email-quic_dikshita@quicinc.com>
Content-Language: en-US
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <1704867134-5522-1-git-send-email-quic_dikshita@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QqmEl9B5QrZh9f-84xri1b9dDRg91LbI
X-Proofpoint-GUID: QqmEl9B5QrZh9f-84xri1b9dDRg91LbI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxscore=0 spamscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401120050

Hi Bryan,

I realized later that I missed to add your reviewed-by tag to this v2
patch, Sorry for this silly mistake, will be more careful in future.

On 1/10/2024 11:42 AM, Dikshita Agarwal wrote:
> For scenarios, when source change is followed by VIDIOC_STREAMOFF
> on output plane, driver should discard any queued OUTPUT
> buffers, which are not decoded or dequeued.
> Flush with HFI_FLUSH_INPUT does not have any actual impact.
> So, fix it, by invoking HFI_FLUSH_ALL, which will flush all
> queued buffers.
> 
> Fixes: 85872f861d4c ("media: venus: Mark last capture buffer")
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
> Changes since v1:
> - Added fixes tag (Bryan)
> 
>  drivers/media/platform/qcom/venus/vdec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index 29130a9..0d2ab95 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -1255,7 +1255,7 @@ static int vdec_stop_output(struct venus_inst *inst)
>  		break;
>  	case VENUS_DEC_STATE_INIT:
>  	case VENUS_DEC_STATE_CAPTURE_SETUP:
> -		ret = hfi_session_flush(inst, HFI_FLUSH_INPUT, true);
> +		ret = hfi_session_flush(inst, HFI_FLUSH_ALL, true);
>  		break;
>  	default:
>  		break;

