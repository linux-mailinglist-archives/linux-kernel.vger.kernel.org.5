Return-Path: <linux-kernel+bounces-93365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FA1872E8E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8600F2860A0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 06:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5D01BDD8;
	Wed,  6 Mar 2024 06:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O37JzgXq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E24138C;
	Wed,  6 Mar 2024 06:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709704956; cv=none; b=s2qV6yFPwu4tis75dlFt+HRp69Lxgap3xiniSHIEoF4dZdWtm/VfWxs7Biwg/p0fGKdvaKHTvOZs9h1MGGEDQwJKOZIhIaSNWzXjNqpXZ6jMY8S2u/K+EfVZK3L/gk/zXUIQePlruDmDFCdTGYtWHwimzVJ7thSyS9Fo1WSPOEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709704956; c=relaxed/simple;
	bh=1pF1YW0n3KuV997EU7Rs5bi6i+K0zbDH0kusoUW33sc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=GFBni0mqigCE8yNvQkVXzIgwdECS7qF5xEn+Nvj/5OcKTUwQowNvouKpFxy+ZrY6RkurGP1iQAXixWMfbBS7sGZgazGxcGnnbi+QTdvNVb9QY0EWT+AZQE8Q23dS3rmYZFdOSxbGbqMqN1gYEar06RQ1097Wl9ckOGUmBXO1nr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=O37JzgXq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4264lnL6025042;
	Wed, 6 Mar 2024 06:02:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=1agwj1KEBjXJb1VsQmvvWQDpTBswQ8dZsb3xaybDUfA=; b=O3
	7JzgXqIAQRBJs2N4xDV3yOhhsX/4023Gwu0vO2d8p0GWbfVvOgxy8wTYlQ7k/uB9
	8ETK+B5slU2P0V+WA1B1Q92sauFU2DuXmamZ0fHvPT9aSqBNfUOst/ijFi+fHX5L
	A+ynX8MyU2I/ZYMm3J+oADniWO8VUmF8fy+/Ij+KNOz+FPm5ZrRRNasqht295ObZ
	gRKhhHXQ715/OYAW3ZN5g/RNPaS5RbaObderlh/vViC8Nxnl90Y0jjHtQ0RgE3+s
	3PdpUC0myFgfSs+H/vbcraNpRlh+gBNX0VLZwPrLNvYsaW8E98Vr3ALoBKxb7zfT
	O/3dYh+l7y+LMgMR8MZQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wp7ky1dsm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 06:02:13 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42661skN008895
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Mar 2024 06:01:54 GMT
Received: from [10.216.3.154] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 5 Mar
 2024 22:01:47 -0800
Message-ID: <3e544d37-b1d2-9c58-3130-9e6950430671@quicinc.com>
Date: Wed, 6 Mar 2024 11:31:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 3/5] spi: spi-qpic: Add qpic spi nand driver support
From: Md Sadre Alam <quic_mdalam@quicinc.com>
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
Content-Language: en-US
In-Reply-To: <f5177fad-214f-1b60-46ba-1dc0a4fb059e@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: f8jqsuNHAm51FTD0iqA6FB3d6deFb5aV
X-Proofpoint-ORIG-GUID: f8jqsuNHAm51FTD0iqA6FB3d6deFb5aV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_03,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1011
 mlxlogscore=963 lowpriorityscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403060047

Konrad,

On 2/20/2024 5:44 PM, Md Sadre Alam wrote:
>>> +    ecc_cfg->cfg0 = (cwperpage - 1) << CW_PER_PAGE
>>> +                | ecc_cfg->cw_data << UD_SIZE_BYTES
>>> +                | 1 << DISABLE_STATUS_AFTER_WRITE
>>> +                | 3 << NUM_ADDR_CYCLES
>>> +                | ecc_cfg->ecc_bytes_hw << ECC_PARITY_SIZE_BYTES_RS
>>> +                | 0 << STATUS_BFR_READ
>>> +                | 1 << SET_RD_MODE_AFTER_STATUS
>>> +                | ecc_cfg->spare_bytes << SPARE_SIZE_BYTES;
>>
>> Let me introduce you to FIELD_PREP/GET and GENMASK().. Many assignments
>> in this file could use these.
> 
>   Ok

While doing the change i realized that it will impact raw nand driver as well.
Shall I post this change as separate patch. Is this ok? Please let me know.

Regards,
Alam.

>>
>> Konrad
> 
> Thanks for reviewing, will fix all the comments in next patch.
> 
> Regards,
> Alam.
> 

