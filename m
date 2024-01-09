Return-Path: <linux-kernel+bounces-20389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A850B827E09
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 06:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95DC31C23551
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 05:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104B217C3;
	Tue,  9 Jan 2024 05:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GPFETII6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF09639;
	Tue,  9 Jan 2024 05:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4094I7mh012490;
	Tue, 9 Jan 2024 05:05:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=HapUkiGBY9kujzPn31TvG
	bVnGF5rJxbzFQeZddrdLBg=; b=GPFETII66CX/WhjAvpDeoz4VVBPvnMgt3fE7L
	DeCwhmZqAt9GJv05J1lpG4hlY0CIkD5Ik+NYSpk9FE8zqV8LiwpqYvxUoiKs1TJF
	YnvYkVBnxpMJOr1MqZwR14jMITTywzoqMeY3grfy4OXoeXi+F6S2rR2fZRB0Bbj1
	+csIb1AMZKLWCJOZjMLvRD3mp3hSPMoeIJ0ZIenSysJu57zmGbmLc5PDIAUQe6Bv
	JOBnIvcBIBFboi88ctLniZ8IyM8tl4WlFZdWkV8BUCc2EFatLT0XHH1ao9shz9Xy
	/GhQHIPweHFLaXAiI1NCjED01OXgP2ENCTL7+CgPoz3FDoWWw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgwq1r6w7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 05:05:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4095509P022216
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 05:05:00 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 8 Jan 2024 21:04:57 -0800
Date: Tue, 9 Jan 2024 10:34:54 +0530
From: Pavan Kondeti <quic_pkondeti@quicinc.com>
To: Mukesh Ojha <quic_mojha@quicinc.com>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linus.walleij@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v11 1/4] firmware: qcom: scm: provide a read-modify-write
 function
Message-ID: <6e99c4ff-a377-4385-b79c-60438e3e8735@quicinc.com>
References: <1704727654-13999-1-git-send-email-quic_mojha@quicinc.com>
 <1704727654-13999-2-git-send-email-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1704727654-13999-2-git-send-email-quic_mojha@quicinc.com>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MZJY4oSui7IA64-2MonCZ-_Yj3so-ANf
X-Proofpoint-ORIG-GUID: MZJY4oSui7IA64-2MonCZ-_Yj3so-ANf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 lowpriorityscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 impostorscore=0 mlxlogscore=852 spamscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090034

On Mon, Jan 08, 2024 at 08:57:31PM +0530, Mukesh Ojha wrote:
> It was realized by Srinivas K. that there is a need of
> read-modify-write scm exported function so that it can
> be used by multiple clients.
> 
> Let's introduce qcom_scm_io_rmw() which masks out the bits
> and write the passed value to that bit-offset.
> 
> Suggested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> Tested-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com> # IPQ9574 and IPQ5332
> ---
>  drivers/firmware/qcom/qcom_scm.c       | 26 ++++++++++++++++++++++++++
>  include/linux/firmware/qcom/qcom_scm.h |  1 +
>  2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 520de9b5633a..25549178a30f 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -19,6 +19,7 @@
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> +#include <linux/spinlock.h>
>  #include <linux/reset-controller.h>
>  #include <linux/types.h>
>  
> @@ -41,6 +42,8 @@ struct qcom_scm {
>  	int scm_vote_count;
>  
>  	u64 dload_mode_addr;
> +	/* Atomic context only */
> +	spinlock_t lock;

IMHO, this comment can be confusing later. one might think that
qcom_scm_call_atomic() needs to be called with this lock, but that does
not seems to be the intention here.

>  };
>  
>  struct qcom_scm_current_perm_info {
> @@ -481,6 +484,28 @@ static int qcom_scm_disable_sdi(void)
>  	return ret ? : res.result[0];
>  }
>  
> +int qcom_scm_io_rmw(phys_addr_t addr, unsigned int mask, unsigned int val)
> +{
> +	unsigned int old, new;
> +	int ret;
> +
> +	if (!__scm)
> +		return -EINVAL;
> +
> +	spin_lock(&__scm->lock);

So, this function can't be called from hardirq context. If that ever
happens, with this new spinlock (without disabling interrupts), can
result in deadlock.

> +	ret = qcom_scm_io_readl(addr, &old);
> +	if (ret)
> +		goto unlock;
> +
> +	new = (old & ~mask) | (val & mask);
> +
> +	ret = qcom_scm_io_writel(addr, new);
> +unlock:
> +	spin_unlock(&__scm->lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(qcom_scm_io_rmw);

Thanks,
Pavan

