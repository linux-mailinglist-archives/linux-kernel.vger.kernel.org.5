Return-Path: <linux-kernel+bounces-1101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 902D1814A62
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FFA41F2141A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581B03172E;
	Fri, 15 Dec 2023 14:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R1ZuomwB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7662E315AD;
	Fri, 15 Dec 2023 14:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BFCTfXJ010194;
	Fri, 15 Dec 2023 14:22:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=oRRArLvECVGH55PpYZXpIucjWY4MTvMDV/T4hZ4cdvQ=; b=R1
	ZuomwBwZwiFQKCEqhwVy3LKiOvdaLGGeAmE4KjQ4yiOiFf7IDdb/0T9bDQb36bRX
	B/5UICe7M0Wh/cj7SL6HnwiJv78nLOHs7sXs+tbiXKLMX+NPXKjAVLKNAlmvzKHe
	2sBctIM7vBWDLurqwmkAAHM2PDIidZUvwUk4JyGlhqjteuIj2Ne9akqGlkIHEF4w
	4AHlDzFGDmfXDS/kbq6jLPgef14owFndVQoc63eLN8Nlrix2o97kMV0tZlT6y7zi
	9kvh0AxwsgmXtq0NWwcdMvS0nDP+n7OVjvafRF8/GX0AHPzKggCpz3oVRP6L/6zj
	JodtXB78ePysFTdSCGGw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v0hqch58d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 14:22:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BFEMjVq002341
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 14:22:45 GMT
Received: from [10.218.15.57] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Dec
 2023 06:22:42 -0800
Message-ID: <de1181fe-a948-a1e2-04c8-dcd88085f1df@quicinc.com>
Date: Fri, 15 Dec 2023 19:49:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] tty: Add comments for tty-ldisc module loading logic
Content-Language: en-CA
To: Zijun Hu <quic_zijuhu@quicinc.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <quic_qiancai@quicinc.com>,
        <quic_arandive@quicinc.com>, <quic_saipraka@quicinc.com>,
        <quic_eberman@quicinc.com>
CC: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1702640236-22824-1-git-send-email-quic_zijuhu@quicinc.com>
 <1702647690-6787-1-git-send-email-quic_zijuhu@quicinc.com>
From: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
In-Reply-To: <1702647690-6787-1-git-send-email-quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: S3hyn1q1ttcdaf_ODB0WyucHyIpk_vD6
X-Proofpoint-GUID: S3hyn1q1ttcdaf_ODB0WyucHyIpk_vD6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1011 suspectscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312150098

Hi,


On 12/15/2023 7:11 PM, Zijun Hu wrote:
> Current tty-ldisc module loading logic within tty_ldisc_get()
> is prone to mislead beginner that the module is able to be loaded
> by a user without capability CAP_SYS_MODULE, add comments to make
> the logic easy to undertand.
>
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
> Changes in v2:
> - Remove condition checking changes
>
>   drivers/tty/tty_ldisc.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
> index 3f68e213df1f..34526ffaccbc 100644
> --- a/drivers/tty/tty_ldisc.c
> +++ b/drivers/tty/tty_ldisc.c
> @@ -150,6 +150,10 @@ static struct tty_ldisc *tty_ldisc_get(struct tty_struct *tty, int disc)
>   	 */
>   	ldops = get_ldops(disc);
>   	if (IS_ERR(ldops)) {
> +		/*
> +		 * Always request tty-ldisc module regardless of user's
> +		 * CAP_SYS_MODULE if autoload is enabled.
> +		 */

Without much knowledge of this file...


What the if condition below accomplishes is evident, it probably doesn't 
require a comment.

A more useful comment would be why it does so?

Thank you...

-Vijay/


>   		if (!capable(CAP_SYS_MODULE) && !tty_ldisc_autoload)
>   			return ERR_PTR(-EPERM);
>   		request_module("tty-ldisc-%d", disc);

