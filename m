Return-Path: <linux-kernel+bounces-62128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52558851BF0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC3EDB27DAD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D589D3F9E6;
	Mon, 12 Feb 2024 17:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="P3DFtDVk"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F053F9CC;
	Mon, 12 Feb 2024 17:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707760043; cv=none; b=BSyStFC+Wrc/y+LcDABQv40EMMiO2Isv6iavjm0qUJ0T3GKtA2Yvu6PNK6R+cC1ImaxqokSLpn1QwlKBK67krCnS4H+DLavSCVURP87bAQHUTNhws/eKRKyJs7YcFQTjszdXgTTy260M+rRKHPEBRNLDpfeQ0nch+d1Ru9LpCLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707760043; c=relaxed/simple;
	bh=OybOR9kPB3GYPxQJUA5gaQ/HEOlZCcTK9qUs25f+0yI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=k4NbIM5wYadpLJX5PTmkjsD6HmKv6202Gi5v42DnYPgC9iUmtbl4gHd92W5ztJG/baVoD+91TewFHOSd09agNOLEz0XXmXhHjs1D6pueN08bX6p2Ha9RSMcQYqQxoLLpJO33faR20YwD030kok2qeKjUx8yeG+HRQfx9JVOqeVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=P3DFtDVk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41CGwOcI009214;
	Mon, 12 Feb 2024 17:47:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Fgr6iY1ALVYW9Zu2xd74cVCtBaZ1e9imGCIaF5VTL4M=; b=P3
	DFtDVk+HAqQHXwUvM8T90+5WkO5v9aCuZDglBlpiiL1Vngr50CPpGS4SO8ukpsKz
	wYGYtFp6IRrf8bi9rxInt7DghqeejpCRPkpI+X8OOuhC2StRwEeHUhrhA+pvbSBy
	1V4S7Tl6xYqrFQwbMUHnz34F+EYqtX5idVWLUUoNMGqSMniSbWSfxL/6XTXDYE/Z
	O40I2+ew5xF7gfD8uD47PnBlXDQYYHjzPAJY1DwlXLpcrOeSxPEYl3/K8VS8QrJC
	eZNpHsTB1siAjHc1LEkhXdqQFicXvb907oXlHX8Dm0CEc6tE2Uiy/kwY7OXicWfJ
	zIquQs5wfhH72nPE0rZA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7nk90ceu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 17:47:17 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41CHlHw5004519
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 17:47:17 GMT
Received: from [10.110.51.3] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 12 Feb
 2024 09:47:14 -0800
Message-ID: <989fa518-4f02-4725-97a4-2f711126939d@quicinc.com>
Date: Mon, 12 Feb 2024 09:47:09 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] soc: qcom: llcc: Check return value on Broadcast_OR
 reg read
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Abel Vesa
	<abel.vesa@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>, Elliot Berman <quic_eberman@quicinc.com>
References: <20240210011415.3440236-1-quic_uchalich@quicinc.com>
 <cfc42c1f-ff17-4d66-8e88-cbd4230e7d7b@quicinc.com>
From: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
In-Reply-To: <cfc42c1f-ff17-4d66-8e88-cbd4230e7d7b@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: H_zfbY_f6YAQn6GggDBPV9NNdtVFcC3q
X-Proofpoint-ORIG-GUID: H_zfbY_f6YAQn6GggDBPV9NNdtVFcC3q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_14,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=503 impostorscore=0
 clxscore=1015 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402120135

On 2/9/2024 5:30 PM, Jeff Johnson wrote:
> On 2/9/2024 5:14 PM, Unnathi Chalicheemala wrote:
>> Commit c72ca343f911 ("soc: qcom: llcc: Add v4.1 HW version support")
>> introduced a new 4.1 if statement in llcc_update_act_ctrl() without
>> considering that ret might be overwritten. So, adding return value check
> 
> nit: s/adding/add/ (use imperative voice)
> 

Ack.

>> after Broadcast_OR register read in llcc_update_act_ctrl().
>>
>> Fixes: c72ca343f911 ("soc: qcom: llcc: Add v4.1 HW version support">
> 
> remove this blank line -- the Fixes tag should be grouped with the other
> tags
> 

Ack. I'll post v3 with these changes, thanks Jeff.

>> Signed-off-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
>> Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>

