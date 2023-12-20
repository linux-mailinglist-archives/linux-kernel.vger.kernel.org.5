Return-Path: <linux-kernel+bounces-6534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B11A819A10
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01B751F213E1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B450A1C6AB;
	Wed, 20 Dec 2023 08:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aVcHGjlI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE57E1C68D;
	Wed, 20 Dec 2023 08:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BK7e9kh019593;
	Wed, 20 Dec 2023 08:06:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=qhWfJCnEVk7VW0wZk4ywbbVKtxxrOawMsLfc0Qe/XUU=; b=aV
	cHGjlI1yVi78LH6croZVmW8iGljR55oLfNgCdjr2qIM+JxkUbxTvq+X4XmhcTwtS
	CRxg8WEpwc70+tUpGnrI0ToCGL0QftWhe2N6gzFBfSa3Twqe/dg7TaldroyqYfrW
	a5l7tkq5Yc+J6QP8eZn2skezM0VTqtQ3ccv9e0Y/H3QajLfZPSrEIHF90L0g1xNC
	ZnzTOJGqm8JHO7iJZ9f2ZmdhB7T7tfBh3nv6LcIs+wTFVF7zVDbq054TM2MmKY7Q
	I0+3IxzUg9MTFBknblJUDeaOLInbiIeTehxxK5XV6qhlV7HyHsXiROsIM8VUj6ol
	y78v+hKu6s0bcJmDMt9Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v3v3381ru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 08:06:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BK864Xw006761
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 08:06:04 GMT
Received: from [10.216.36.155] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Dec
 2023 00:06:00 -0800
Message-ID: <f6739eb7-d445-1075-d911-290e79c24060@quicinc.com>
Date: Wed, 20 Dec 2023 13:35:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 09/34] media: iris: initialize shared queues for host
 and firmware communication
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stanimir.k.varbanov@gmail.com>,
        <quic_vgarodia@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <mchehab@kernel.org>,
        <bryan.odonoghue@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <quic_abhinavk@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
 <1702899149-21321-10-git-send-email-quic_dikshita@quicinc.com>
 <7b3674ce-e372-44e4-adda-8af78e2a9053@linaro.org>
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <7b3674ce-e372-44e4-adda-8af78e2a9053@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NXgMLcCnGTC6n2tv8sZ0KB6aZqsl6tCI
X-Proofpoint-GUID: NXgMLcCnGTC6n2tv8sZ0KB6aZqsl6tCI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=991 clxscore=1015 priorityscore=1501
 adultscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312200054



On 12/19/2023 3:03 AM, Konrad Dybcio wrote:
> 
> 
> On 12/18/23 12:32, Dikshita Agarwal wrote:
>> Shared queues are used for communication between driver and firmware.
>> There are 3 types of queues:
>> Command queue - driver to write any command to firmware.
>> Message queue - firmware to send any response to driver.
>> Debug queue - firmware to write debug message.
>>
>> Above queues are initialized and configured to firmware during probe.
>>
>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>> ---
> [...]
> 
>> +    ret = hfi_queue_init(core->dev, &core->iface_q_table, &core->sfr,
>> +                 &core->command_queue, &core->message_queue,
>> +                 &core->debug_queue, core);
>> +    if (ret) {
>> +        dev_err_probe(core->dev, ret,
>> +                  "%s: interface queues init failed\n", __func__);
>> +        goto err_vdev_unreg;
>> +    }
>> +
>>       return ret;
> Like before, you're suppose to return dev_err_probe
Sure, will fix all such instances.
> 
> Konrad

