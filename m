Return-Path: <linux-kernel+bounces-94948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1073E874716
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 05:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 423BD1C22101
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C8117727;
	Thu,  7 Mar 2024 04:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZpJE59e3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CDFEAD4;
	Thu,  7 Mar 2024 04:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709784657; cv=none; b=M+pzUoOkMZC9wm1lZ2oBc0JzrHAw8Yv44keDwIRvNdX6a/BsEDhNt0spy+Y1JKpPCSz/NqHYyumGEhdRMMprTDTjUw0Yu5+PaB/5AbuDvSsaMLou1z8XdiOiiF0gvhwZyYSCVMpGtB9o/sBeOVMsQXPoREZHnMDawXnqkMsxmYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709784657; c=relaxed/simple;
	bh=ILtxDksrVlyJprDMbaIAqDrftrQUFo631YapNaAUlgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pNa6srRVNThDnh8mvy/6JR0P2yq+FdtxKQMpblhG50lBpcJibaBll9LrRSuY8e8gFDr/s05hNEtWRW98X74uikObW8j0wOxrM0LtDRejI62yHIn+GE+30JHRIYDAUc2RzF0Xd8zqBuM2QlnE21b7d1j3WhnoCED/W63t40D+sVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZpJE59e3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4274Ahmv023139;
	Thu, 7 Mar 2024 04:10:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=7TJ3n/0fLnBwB4tq1En+ngQc6f0xHxORsLFGuLy1AT8=; b=Zp
	JE59e3su4jwgTyG8df7mLw0oeUoDqDAHe2YZKwn0dAq6rWxapfVLp66jKe2J8GnX
	07I2QHDQQrktFLso0OdjcuqrdQvlN6RT5XMiQ/6hE/qOY6p1m+FTu5hQNl9e2nsE
	e+Ew3Bg3paDUXeg6LVXkM+sMhHFoXuitezsedw87RpnlmvHCa+DlvCb1XLae40FN
	9o2xiz53WfFdYGxo0QRRxDHzYsSuBUOoaiWoYOoe2UgA+moXX7l9TrEWkF8QyCPW
	dTvIqM2IN02QSXFqld+DC8XX5e1yM8E7NVRk1yLhLXoZs3ihdSlSge3JuOTTgroo
	ZUsKe5ynOaCOLbkHV6Wg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wq0u3ghfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 04:10:43 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4274Af06004104
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Mar 2024 04:10:41 GMT
Received: from [10.201.3.124] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 6 Mar
 2024 20:10:36 -0800
Message-ID: <b11eb8c8-8bdf-2554-eb36-64618b6e1ac7@quicinc.com>
Date: Thu, 7 Mar 2024 09:40:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 3/5] spi: spi-qpic: Add qpic spi nand driver support
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <andersson@kernel.org>,
        <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
References: <20240215134856.1313239-1-quic_mdalam@quicinc.com>
 <20240215134856.1313239-4-quic_mdalam@quicinc.com>
 <d1c80d3f-3b70-4630-8f7d-b00983b487dd@linaro.org>
 <f5177fad-214f-1b60-46ba-1dc0a4fb059e@quicinc.com>
 <3e544d37-b1d2-9c58-3130-9e6950430671@quicinc.com>
 <19176685-898b-4aeb-b819-fec54a126233@linaro.org>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <19176685-898b-4aeb-b819-fec54a126233@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HGBlTF-g-DbUeilbsrEZ7p2PEOyyL914
X-Proofpoint-GUID: HGBlTF-g-DbUeilbsrEZ7p2PEOyyL914
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_14,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=835
 lowpriorityscore=0 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403070026



On 3/6/2024 9:57 PM, Konrad Dybcio wrote:
> 
> 
> On 3/6/24 07:01, Md Sadre Alam wrote:
>> Konrad,
>>
>> On 2/20/2024 5:44 PM, Md Sadre Alam wrote:
>>>>> +    ecc_cfg->cfg0 = (cwperpage - 1) << CW_PER_PAGE
>>>>> +                | ecc_cfg->cw_data << UD_SIZE_BYTES
>>>>> +                | 1 << DISABLE_STATUS_AFTER_WRITE
>>>>> +                | 3 << NUM_ADDR_CYCLES
>>>>> +                | ecc_cfg->ecc_bytes_hw << ECC_PARITY_SIZE_BYTES_RS
>>>>> +                | 0 << STATUS_BFR_READ
>>>>> +                | 1 << SET_RD_MODE_AFTER_STATUS
>>>>> +                | ecc_cfg->spare_bytes << SPARE_SIZE_BYTES;
>>>>
>>>> Let me introduce you to FIELD_PREP/GET and GENMASK().. Many assignments
>>>> in this file could use these.
>>>
>>>   Ok
>>
>> While doing the change i realized that it will impact raw nand driver as well.
>> Shall I post this change as separate patch. Is this ok? Please let me know.
> 
> One patch per file/topic, yes, please
  Thank you
> 
> Konrad

