Return-Path: <linux-kernel+bounces-6424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4CE8198A4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBA85288258
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 06:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8332214F9D;
	Wed, 20 Dec 2023 06:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RFXgY9h+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A250414AA6;
	Wed, 20 Dec 2023 06:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BK5LJki030251;
	Wed, 20 Dec 2023 06:32:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=H+yzUCisvEbkPUEHym0QjsjP6XAzDoMfyOVXQ9S3PqE=; b=RF
	XgY9h+49royOk+metHq3zw+9NBGoCXAODQHgoV++KnJx+n/6Tvph1tyvi8QPifa4
	Rl9LXw+tP2IE/5+oC4/aG9y5mPB96AdZcSlF0/5ssLL2lWhstG51CO/bsIzj6DMM
	dnb4Mt7FmooTINFDWs6Do+/rXFPaal+fRLcZgSX7YA6EsOn9KHccYBF3yfjQKBNF
	UwmoYr1CiMpQ/QLsoov68VAhkCgb9dn2YpBFZD2yGzpDfb++gLPe2mp062sdwG78
	82L58PieXarbVGzloeUFulci4n9YWPgK8MauOe6W5WT6QGLFDm7cVMeLJ0MnyXWU
	OSTnsgXMFKjRL9f+yxgQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v37vxtp8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 06:32:53 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BK6WrWE024537
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 06:32:53 GMT
Received: from [10.216.20.45] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Dec
 2023 22:32:49 -0800
Message-ID: <d0ea23ae-8fba-d229-b0f6-dc522f285233@quicinc.com>
Date: Wed, 20 Dec 2023 12:02:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 00/34] Qualcomm video encoder and decoder driver
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Dikshita Agarwal
	<quic_dikshita@quicinc.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stanimir.k.varbanov@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>, <bryan.odonoghue@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <quic_abhinavk@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
 <a033dfc5-dcf1-4969-ad4d-1836ff9ff0a3@linaro.org>
From: Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <a033dfc5-dcf1-4969-ad4d-1836ff9ff0a3@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: quYc5HixXbRvfkGHmsyyua48rxpl76PE
X-Proofpoint-GUID: quYc5HixXbRvfkGHmsyyua48rxpl76PE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=485
 suspectscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1011 mlxscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312200042

Hi Dmitry,

On 12/19/2023 12:08 AM, Dmitry Baryshkov wrote:
> On 18/12/2023 13:31, Dikshita Agarwal wrote:
>> This patch series introduces support for Qualcomm new video acceleration
>> hardware architecture, used for video stream decoding/encoding. This driver
>> is based on new communication protocol between video hardware and application
>> processor.
> 
> This doesn't answer one important point, you have been asked for v1. What is the
> actual change point between Venus and Iris? What has been changed so much that
> it demands a separate driver. This is the main question for the cover letter,
> which has not been answered so far.
> 
> From what I see from you bindings, the hardware is pretty close to what we see
> in the latest venus generations. I asssme that there was a change in the vcodec
> inteface to the firmware and other similar changes. Could you please point out,
> which parts of Venus driver do no longer work or are not applicable for sm8550

The motivation behind having a separate IRIS driver was discussed earlier in [1]
In the same discussion, it was ellaborated on how the impact would be with
change in the new firmware interface and other video layers in the driver. I can
add this in cover letter in the next revision.

We see some duplication of code and to handle the same, the series brings in a
common code reusability between iris and venus. Aligning the common peices of
venus and iris will be a work in progress, once we land the base driver for iris.

Again qualcomm video team does not have a plan to support sm8550/x1e80100 on
venus as the changes are too interleaved to absorb in venus driver. And there is
significant interest in community to start validating video driver on sm8550 or
x1e80100.

[1] https://lore.kernel.org/lkml/8c97d866-1cab-0106-4ab3-3ca070945ef7@quicinc.com/

Regards,
Vikash

