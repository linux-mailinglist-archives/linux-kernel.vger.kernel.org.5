Return-Path: <linux-kernel+bounces-41090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B8083EBBA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 08:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4A651C21F85
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 07:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B721DDCF;
	Sat, 27 Jan 2024 07:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ncyyomq0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B844A1E863;
	Sat, 27 Jan 2024 07:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706341406; cv=none; b=hoP8vXlQApoRXPo9KdaOMgjdhkEZ1Mj+uSuGJRxW8KFpt6tvKNhQRemU+Qb3Mj2++2CdX2QaGpJgS+jeAbIYu4RG6mjyvZx+d8DUK9FsORahn0o8j4ETF8qvUSPnH0SBR7YuSLVZ+Dl48byui2uz9i0rP9cpgkhfYjfFwgxG4Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706341406; c=relaxed/simple;
	bh=4MGb1qflxhwRgTrrlk/7/kijvV1dwW1KJRjikJeWShU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cYDHbny+sgaiDEgCkQugndH6NRqORnuush6MEHMWSSutIBNUW/3qcx8D9/HTeK1NbiBhMnxs73sclpbkP9qzrPg892CR/tBB4bbr3kv9BylinUkUJ6x2AgXvDY5xg/C7EZ4WuTXGmrTTUPnZ4uQYhWdDqtgAY/AjkhzWW7kK920=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ncyyomq0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40R7YdKa022735;
	Sat, 27 Jan 2024 07:43:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=TT2snydsXyFTUAF8hdDPurbrANlkdPb7MXNMuqisxSo=; b=nc
	yyomq0Yma2auskhkqpTasXpWD/F5Towp7cPPFqHRYi4i4ejkeOFSgw8XlorPJCuu
	5NcO4/0LMNVv1DGI138eyCqbUec1kx5oqFouc0NywwiQ2n7y3M44eDGPMF+jiFqn
	wYgAatSOftJLFTsjfZx1ef6iFtmQWHM+71UNJv/9a2jkpC6K9D9hg2rP/pVWYT6C
	MTbex2RMOCEbsohyYCP2NgKCsZHdprQnQ3rUJ3UjLqpcsmYta0EUMZQhGeIv+JMa
	dQn6ITWb/WbjWEgg93Pb5KV7SGE8J2QeHtkQzAy1blU3tyTVOWV51ZhopCwOBwb2
	et2lk9V3qxteBWNhXFXw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvse4r9d5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 07:43:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40R7hIKY011758
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 07:43:18 GMT
Received: from [10.216.42.152] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 26 Jan
 2024 23:43:14 -0800
Message-ID: <ae1a2220-7494-4f7e-ac23-f0b2aebeee75@quicinc.com>
Date: Sat, 27 Jan 2024 13:13:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] arm64: dts: qcom: Fix hs_phy_irq for QUSB2 targets
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>
References: <20240120191904.15408-1-quic_kriskura@quicinc.com>
 <20240120191904.15408-2-quic_kriskura@quicinc.com>
 <wqdqkzvni4roqulgsiqxzubxcblzxnoydcwvv2av2pobjjx5o6@b7kwl6lq7hij>
 <a4606673-64e9-4e16-8d9e-307fb37d8763@quicinc.com>
 <7f780a0b-5f70-480e-82fc-08bd89870d13@linaro.org>
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <7f780a0b-5f70-480e-82fc-08bd89870d13@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bChgEQMgofsM3sNqgNFgllzcRIOB5u1p
X-Proofpoint-GUID: bChgEQMgofsM3sNqgNFgllzcRIOB5u1p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=916 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2401190000
 definitions=main-2401270055


> 
> v1.4.0? I am sorry, but what?
> 
> Isn't that like 10 years old? What systems are you using there? I am
> asking, because maybe we should be rejecting DTS patches assuming they
> were never tested (testing on ancient dtc counts like no testing).
> 
>> When I moved to 1.5.0, I did see these warnings. Fixed them up and sent v3.
> 
> Nope, you just moved from 10 years old to 5 years old.
> 
> Fix your systems and use the recent one. v1.6.1
> 

Hi Krzysztof,

  It was an old pc I was using this time and it was using local 
/usr/bin/dtc for some reason. I got the latest version working:

kriskura@hu-kriskura-hyd:/local/mnt/workspace/krishna/skales_dt_cleanup/skales/kernel$ 
dtc -v
Version: DTC 1.6.1-gabbd523b

And with this version, I don't see any errors in the v3 pushed.

Thanks,
Krishna,

