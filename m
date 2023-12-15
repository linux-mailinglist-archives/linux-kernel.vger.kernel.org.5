Return-Path: <linux-kernel+bounces-1778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C888153D4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02FE91C20DFE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F2F18034;
	Fri, 15 Dec 2023 22:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FnRbQ5ZE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183D013B12E;
	Fri, 15 Dec 2023 22:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BFLVMlU023006;
	Fri, 15 Dec 2023 22:38:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=i5e3VNsHMtLdnZjKEnpBG17/DfBO8lIAIhhbJZLJYwE=; b=Fn
	RbQ5ZEXEHBuX4ttkNQ3M26mGIGsNg+wmUPp6CqOydH0nusvg8tWBlYDjqu4R515P
	M6JPdi1pZRKj2oiaLOB7/TbqlHISBFpqGsMY34Wyk7nOFyvNr3V+8+E2EpdRLjT7
	TiNUDoHwPFLLMLpSoGrECEDlDeXr9OF+F8dc50JpJtoxAf+qqkxmGesOZXKZqKSz
	8l+msL9CiH43M8XgJbHQeilIGAmXG1d/WZJYH102Z9ZmsGvHBIgkYefwo38sVoDn
	hkgAu7M3DuOP/LBoquOzViJd1H3A5BqJKjODHH0z7yf9jJ4vimXkDJ5OJ0eIuFZb
	thCIunEJ7q6mR+pN6Rhg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v0m46hrg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 22:38:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BFMct9A027457
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 22:38:55 GMT
Received: from [10.110.36.237] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Dec
 2023 14:38:54 -0800
Message-ID: <80111881-13dd-4b05-876a-a97eb3889726@quicinc.com>
Date: Fri, 15 Dec 2023 14:38:53 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 18/41] ALSA: usb-audio: qcom: Add USB QMI definitions
Content-Language: en-US
To: Wesley Cheng <quic_wcheng@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <mathias.nyman@intel.com>, <perex@perex.cz>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <gregkh@linuxfoundation.org>, <lgirdwood@gmail.com>,
        <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <konrad.dybcio@linaro.org>, <Thinh.Nguyen@synopsys.com>,
        <broonie@kernel.org>, <bgoswami@quicinc.com>, <tiwai@suse.com>,
        <robh+dt@kernel.org>, <agross@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <alsa-devel@alsa-project.org>
References: <20231215214955.12110-1-quic_wcheng@quicinc.com>
 <20231215214955.12110-19-quic_wcheng@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231215214955.12110-19-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: y0Zvylxqky0dYnXVoe0CvMAArWBxbEqy
X-Proofpoint-ORIG-GUID: y0Zvylxqky0dYnXVoe0CvMAArWBxbEqy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 clxscore=1011
 mlxlogscore=899 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312150159

On 12/15/2023 1:49 PM, Wesley Cheng wrote:
> The Qualcomm USB audio offload driver utilizes the QMI protocol to
> communicate with the audio DSP.  Add the necessary QMI header and field
> definitions, so the QMI interface driver is able to route the QMI packet
> received to the USB audio offload driver.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  sound/usb/qcom/usb_audio_qmi_v01.c | 892 +++++++++++++++++++++++++++++
>  sound/usb/qcom/usb_audio_qmi_v01.h | 162 ++++++
>  2 files changed, 1054 insertions(+)
>  create mode 100644 sound/usb/qcom/usb_audio_qmi_v01.c
>  create mode 100644 sound/usb/qcom/usb_audio_qmi_v01.h
> 
> diff --git a/sound/usb/qcom/usb_audio_qmi_v01.c b/sound/usb/qcom/usb_audio_qmi_v01.c
> new file mode 100644
> index 000000000000..bdfd67d980eb
> --- /dev/null
> +++ b/sound/usb/qcom/usb_audio_qmi_v01.c
> @@ -0,0 +1,892 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/soc/qcom/qmi.h>
> +
> +#include "usb_audio_qmi_v01.h"
> +
> +static struct qmi_elem_info mem_info_v01_ei[] = {

I believe all of the struct qmi_elem_info arrays can be const.

At least that was the goal of commit ff6d365898d4 ("soc: qcom: qmi: use
const for struct qmi_elem_info")

/jeff


