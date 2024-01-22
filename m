Return-Path: <linux-kernel+bounces-33853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C6B836F8D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C48A71C2727C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD563DBA3;
	Mon, 22 Jan 2024 17:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Tg9sbVRd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDA4482D4;
	Mon, 22 Jan 2024 17:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945590; cv=none; b=H/WKnVintPTVpZqlq+UcC7sERXXl0IQyFdyWWXdcIuYqOBwbQ/y/rVUMpjrUTgcUhb+tkdmtDw0yDu+FsfQCGYtGO8okaFjG6DCLp+bpwJA7Fy+CfLCR+4v6uz0ykLNecAhOzQGkD5GPX/6Q/bHAiMmpxO/OljmDwtE3trOfpak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945590; c=relaxed/simple;
	bh=H4fd0I1xdlUdn8BCMsHZCDCvU+DZCKlUX3cBjWWeYPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SkWzV5DLMKkGr7K76wRyd/+W3tDtdoMNxG1dRyak8gLLewiHjH1rjSa3d55oEHqpUATb7PeeV+kvFfHcJkUSywLibK5ktNDU3J0stnDEbpCMPkJUOSNORI6BEtVR5KiJR9dtyoj8OQpiQkBMakVV2fXlOsjiDX5W1h6fBiBs6AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Tg9sbVRd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40MEkNNO004080;
	Mon, 22 Jan 2024 17:46:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Iv4kxuMYXz1LyQFxr93MbbXsbilUdrXgi24zSCxnXQQ=; b=Tg
	9sbVRdDTs1CPPlXAu0pFEnJCUr59ZovHKv8A6gSkHEcwQT0czwSQubMtOX9XiomB
	+qq8LBDUwieQSbSwr9IgFK2AeABl2MrJ9qJCwJz6rX2DoFAIPfOzsIA74Y/TwOrU
	ZAbonQcDNvVxqUzEJHoPo4Y4ux+iizEJnIJjiF24OD3z2EFO1OSlj9q4mmCHryOf
	d9P5FNp7BYr8k5DNNtzogQh9OqkzOhoCjCaWdgr/6uGFxeARqXBrz4MoolmZSr1K
	HiCjCRZMbEPzXi6V8SoPgRZoF0Z9+x6NFgesbHov8gsOY+ef47HmFTIbYWQ4DipA
	nLki8JJf7OuZ2LBuM2Og==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vstd98e08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 17:46:24 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40MHkNCp015656
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 17:46:23 GMT
Received: from [10.110.32.149] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 22 Jan
 2024 09:46:22 -0800
Message-ID: <41854d97-2ddf-6c0b-8ad4-c028ce15d653@quicinc.com>
Date: Mon, 22 Jan 2024 09:46:10 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/2] arm64: qcom: sm8550: add support for the SM8550-HDK
 board
Content-Language: en-US
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240122-topic-sm8550-upstream-hdk8550-v1-0-bff7eb3a17eb@linaro.org>
From: Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <20240122-topic-sm8550-upstream-hdk8550-v1-0-bff7eb3a17eb@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: y1ys2rR7_8Zd6CWnQJeXx9KhpV3jDsJ0
X-Proofpoint-ORIG-GUID: y1ys2rR7_8Zd6CWnQJeXx9KhpV3jDsJ0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_07,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 mlxlogscore=842 mlxscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401220124

On 1/22/2024 2:19 AM, Neil Armstrong wrote:
> The SM8550-HDK is an embedded development platforms for the
> Snapdragon 8 Gen 2 SoC aka SM8550, with the followwing features:
> - Qualcomm SM8550 SoC
> - 16GiB On-board LPDDR5
> - On-board WiFi 7 + Bluetooth 5.3/BLE
> - On-board UFS4.0
> - M.2 Key B+M Gen3x2 PCIe Slot
> - HDMI Output
> - USB-C Connector with DP Almode & Audio Accessory mode
> - Micro-SDCard Slot
> - Audio Jack with Playback and Microphone
> - 2 On-board Analog microphones
> - 2 On-board Speakers
> - 96Boards Compatible Low-Speed and High-Speed connectors [1]
> - For Camera, Sensors and external Display cards
> - Compatible with the Linaro Debug board [2]
> - SIM Slot for Modem
> - Debug connectors
> - 6x On-Board LEDs
> 
> On-Board PMICs:
> - PMK8550 2.1
> - PM8550 2.0
> - PM8550VS 2.0 x4
> - PM8550VE 2.0
> - PM8550B 2.0
> - PMR735D 2.0
> - PM8010 1.1 x2
> 
> Product Page: [3]
> 
> Dependencies: None
> 
> [1] https://www.96boards.org/specifications/
> [2] https://git.codelinaro.org/linaro/qcomlt/debugboard
> [3] https://www.lantronix.com/products/snapdragon-8-gen-2-mobile-hardware-development-kit/


Excellent. Thank you for adding the support here and it looks straightforward due to the 
the MTP support we had added earlier along w/ the 8550 SOC. 

-- 
---Trilok Soni


