Return-Path: <linux-kernel+bounces-6549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03773819A3B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D2FC1F26535
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940F71BDC0;
	Wed, 20 Dec 2023 08:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BojoMtow"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0887E18E07;
	Wed, 20 Dec 2023 08:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BK5VodL013774;
	Wed, 20 Dec 2023 08:14:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=LMZL/uRryDrpQbTFEE3szDwCnV0ZlSdzX3/BbTB2EyU=; b=Bo
	joMtowO5LnE6pzOyrYiEcHLNmkGlEXcw58EVnONz6XEB5HC4mHJ0W1rsiXxnnzxS
	dlIrebhTsZSG4VqNu//QHneqgzuDmxoKPsJUc6MITR0Uv1vL/NTMxBHDvi2COiql
	wZcAZ4+xlmQ6uLXIMXiCTn1E89P9R5iO/eGw9UQiaM6i5IrhiyFjy/TXZOBQm1fg
	5fdnBl7yrKq3Z7fchtr+MEhWRGXlJJTRJriLPfz8SiZRAdmGKuadyC9T5j+NaXfM
	+k9DCaWD2oWQZbC2UDWVZKiK3ObWyOn43hpqihp7XehOmfM/04Ymq20eyP9Wps3a
	mRr1lITnp44Vgh7ma6tg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v3rppggy2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 08:14:20 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BK8EJOY001697
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 08:14:19 GMT
Received: from [10.216.20.45] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Dec
 2023 00:14:14 -0800
Message-ID: <9d94317c-5da9-5494-26a2-12007761a1e5@quicinc.com>
Date: Wed, 20 Dec 2023 13:44:10 +0530
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
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Dikshita Agarwal <quic_dikshita@quicinc.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stanimir.k.varbanov@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>, <bryan.odonoghue@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_abhinavk@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
 <a033dfc5-dcf1-4969-ad4d-1836ff9ff0a3@linaro.org>
 <d0ea23ae-8fba-d229-b0f6-dc522f285233@quicinc.com>
 <CAA8EJpouBOLJ_1Pz_YauuOX+97ud9RkLYRaui4GM6ZFJUKYJMw@mail.gmail.com>
From: Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <CAA8EJpouBOLJ_1Pz_YauuOX+97ud9RkLYRaui4GM6ZFJUKYJMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eEQ-6XUzbU2L9s_u6TK_whB6bfQIsrnP
X-Proofpoint-GUID: eEQ-6XUzbU2L9s_u6TK_whB6bfQIsrnP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1 bulkscore=0 mlxscore=1
 priorityscore=1501 suspectscore=0 mlxlogscore=218 impostorscore=0
 clxscore=1015 spamscore=1 phishscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312200056

Hi,

On 12/20/2023 1:07 PM, Dmitry Baryshkov wrote:
> On Wed, 20 Dec 2023 at 08:32, Vikash Garodia <quic_vgarodia@quicinc.com> wrote:
>>
>> Hi Dmitry,
>>
>> On 12/19/2023 12:08 AM, Dmitry Baryshkov wrote:
>>> On 18/12/2023 13:31, Dikshita Agarwal wrote:
>>>> This patch series introduces support for Qualcomm new video acceleration
>>>> hardware architecture, used for video stream decoding/encoding. This driver
>>>> is based on new communication protocol between video hardware and application
>>>> processor.
>>>
>>> This doesn't answer one important point, you have been asked for v1. What is the
>>> actual change point between Venus and Iris? What has been changed so much that
>>> it demands a separate driver. This is the main question for the cover letter,
>>> which has not been answered so far.
>>>
>>> From what I see from you bindings, the hardware is pretty close to what we see
>>> in the latest venus generations. I asssme that there was a change in the vcodec
>>> inteface to the firmware and other similar changes. Could you please point out,
>>> which parts of Venus driver do no longer work or are not applicable for sm8550
>>
>> The motivation behind having a separate IRIS driver was discussed earlier in [1]
>> In the same discussion, it was ellaborated on how the impact would be with
>> change in the new firmware interface and other video layers in the driver. I can
>> add this in cover letter in the next revision.
> 
> Ok. So the changes cover the HFI interface. Is that correct?
Change wise, yes.

>> We see some duplication of code and to handle the same, the series brings in a
>> common code reusability between iris and venus. Aligning the common peices of
>> venus and iris will be a work in progress, once we land the base driver for iris.
> 
> This is not how it usually works. Especially not with the patches you
> have posted.
> 
> I have the following suggestion how this story can continue:
> You can _start_ by reworking venus driver, separating the HFI /
> firmware / etc interface to an internal interface in the driver. Then
> implement Iris as a plug in for that interface. I might be mistaken
> here, but I think this is the way how this can be beneficial for both
> the video en/decoding on both old and new platforms.

HFI/firmware interface is already confined to HFI layer in the existing venus
driver. We explained in the previous discussion [1], on how the HFI change
impacts the other layers by taking example of a DRC usecase. Please have a look
considering the usecase and the impact it brings to other layers in the driver.

[1] https://lore.kernel.org/lkml/8c97d866-1cab-0106-4ab3-3ca070945ef7@quicinc.com/
> Short rationale:
> The venus driver has a history of supported platforms. There is
> already some kind of buffer management in place. Both developers and
> testers have spent their effort on finding issues there. Sending new
> driver means that we have to spend the same amount of efforts on this.
> Moreover, even from the porter point of view. You are creating new
> bindings for the new hardware. Which do not follow the
> venus-common.yaml. And they do not follow the defined bindings for the
> recent venus platforms. Which means that as a developer I have to care
> about two different ways to describe nearly the same hardware.>> Again qualcomm video team does not have a plan to support sm8550/x1e80100 on
>> venus as the changes are too interleaved to absorb in venus driver. And there is
>> significant interest in community to start validating video driver on sm8550 or
>> x1e80100.
>>
>> [1] https://lore.kernel.org/lkml/8c97d866-1cab-0106-4ab3-3ca070945ef7@quicinc.com/
>>
>> Regards,
>> Vikash
> 
> 
> 

