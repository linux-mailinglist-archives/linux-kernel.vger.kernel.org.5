Return-Path: <linux-kernel+bounces-6580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 531D9819A92
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 866EF1C25005
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FE51CA8C;
	Wed, 20 Dec 2023 08:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oits1DqF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875D716434;
	Wed, 20 Dec 2023 08:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BK6Nece009963;
	Wed, 20 Dec 2023 08:33:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=suSNo3U5hsuWHi0+378sKR4p5lsFJAErXMkh8SjpODM=; b=oi
	ts1DqF6x8gKIsHRN/hxFbwfcV7YWwINIINl92utrQFc33peIazkQ1lZlWX27OTlg
	UPyW5x61qRjvpBcgKtoqkdvcHlt8EvuG+a7tlMts/vppKwEfHlndL+2iKMmBupDm
	Mve6Gcgc78KCeZsImem3t4Ih1F8kRbHkfjceofobD9N7PMMN9O+911gM68myZNhS
	tmgzN1pkBl17BEmzRCmQrUCInGK3+86o4rEN4aFh9Q6vBY1OKVOtPS8VidbNmew9
	hBOBjkoj+bhAsCDKlSdBgjYsACEnQKackkmNgHy9ZJUdwd2UiRQLCMfW0lijIzwC
	9VdfnEmQjhxBWn9DEdFA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v37vxtyu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 08:33:04 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BK8X36o024185
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 08:33:03 GMT
Received: from [10.216.20.45] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Dec
 2023 00:32:58 -0800
Message-ID: <55585c99-2359-1e21-51ac-1a211150defd@quicinc.com>
Date: Wed, 20 Dec 2023 14:02:54 +0530
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
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stanimir.k.varbanov@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>, <bryan.odonoghue@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <quic_abhinavk@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
 <a033dfc5-dcf1-4969-ad4d-1836ff9ff0a3@linaro.org>
 <d0ea23ae-8fba-d229-b0f6-dc522f285233@quicinc.com>
 <50760ff7-656b-4487-b061-3a679da59917@kernel.org>
From: Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <50760ff7-656b-4487-b061-3a679da59917@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CyXLTm1qSt0eEBaQdODMevObCL-1ed1c
X-Proofpoint-GUID: CyXLTm1qSt0eEBaQdODMevObCL-1ed1c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=831
 suspectscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1011 mlxscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312200058

Hi Krzysztof,

On 12/20/2023 1:45 PM, Krzysztof Kozlowski wrote:
> On 20/12/2023 07:32, Vikash Garodia wrote:
>>> From what I see from you bindings, the hardware is pretty close to what we see
>>> in the latest venus generations. I asssme that there was a change in the vcodec
>>> inteface to the firmware and other similar changes. Could you please point out,
>>> which parts of Venus driver do no longer work or are not applicable for sm8550
>>
>> The motivation behind having a separate IRIS driver was discussed earlier in [1]
>> In the same discussion, it was ellaborated on how the impact would be with
>> change in the new firmware interface and other video layers in the driver. I can
>> add this in cover letter in the next revision.
>>
>> We see some duplication of code and to handle the same, the series brings in a
>> common code reusability between iris and venus. Aligning the common peices of
>> venus and iris will be a work in progress, once we land the base driver for iris.
>>
>> Again qualcomm video team does not have a plan to support sm8550/x1e80100 on
> 
> If you want it to get merged, then create such plan, please.
> 
>> venus as the changes are too interleaved to absorb in venus driver. And there is
>> significant interest in community to start validating video driver on sm8550 or
>> x1e80100.
> 
> Community does not want duplicated drivers leading to maintenance costs.
> Your approach to this is not how upstreaming process works.
If you go over the pseudo code which i explained in [1], you can see that the
maintenance cost would be higher if try to impose the new interface in existing
driver. Video team, alongwith Stan, have considered the aspect of maintenance
before starting on this new driver.

[1] https://lore.kernel.org/lkml/8c97d866-1cab-0106-4ab3-3ca070945ef7@quicinc.com/

Regards,
Vikash


