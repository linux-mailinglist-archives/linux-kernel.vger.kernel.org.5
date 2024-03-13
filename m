Return-Path: <linux-kernel+bounces-101283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F8C87A50A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9535F28193A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C38210E9;
	Wed, 13 Mar 2024 09:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bluEiDfC"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AF520309;
	Wed, 13 Mar 2024 09:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710322339; cv=none; b=rVIhCozRIOpebQZw8TYwD8MgODpWU56ickfIYMTGetLu9dSQA0g/c7WM/zEHYta+GsIX/hor6yN/OTUFtsrI0wKU6m2TQZMv+j6yR/Rs1onui7i+sQQ7iOvUGm60WUBegPfgATXunKGVJrQkRN+z365IhKHqtL+jveE77CJyRKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710322339; c=relaxed/simple;
	bh=tM5Bd/lj1Kyh0D2rITpWKYzjyrlwg9YS7Q94u+Z2Bfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZvR0+TbkK4TRmn4e6ASSSjg2as2MCxDegdVfYHX+k3Jp0kq70qhV0sgexxwMMQd70ACovks+Z+gY9vol3556QTYTuoTgslfmGMOA01G7GxppJPHi7oBLNG8ENs/rpz5Bmt+RLGjJh4jvC3rrz2Ge5bFBqGuT3K8GGFsJml4EHuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bluEiDfC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42D5RUgB001669;
	Wed, 13 Mar 2024 09:32:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=AJdXhUYrFAQmdOJASSCpwGDADNqIOouBCpm330S19a4=; b=bl
	uEiDfCLJeRw4qHUupGybPn2B3Fd2OzgrqxEPGN9l9ixtB6IPqNr2geky7A6RIA+u
	Kv/qlO9ZyHq983kcf/rHS0omgzhNthvALo9q4YlxgJQBvudoCTRQB/XkVN5ufA17
	ZSyYATlVeDVGqIw28A8G/jk7zclCrE36WwsFgtKjNgge9XJ6ZtxQlS79xGBPJrgo
	HS6scxRoeAmsOzkn8iL2+TGoit6rHPzTguNaUIcV2+2e0yrUuJPe7taiDU9aywz6
	puQDLjv2VLSo38kM4WZJsf9limd8ygY3QYHFbfsOLGfKVIDiPkgdlUJWkdyBaEkK
	2b20vxyb5pFiZoYRNC4A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wu2j38td6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 09:32:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42D9W7fo022840
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 09:32:07 GMT
Received: from [10.201.2.96] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 13 Mar
 2024 02:32:04 -0700
Message-ID: <4a11d946-3c32-42fd-959b-32e61cc61ab5@quicinc.com>
Date: Wed, 13 Mar 2024 15:02:01 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] arm64: dts: qcom: ipq6018: add 1.2GHz CPU
 Frequency
Content-Language: en-US
To: Chukun Pan <amadeus@jmu.edu.cn>
CC: <andersson@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <dmitry.baryshkov@linaro.org>,
        <konrad.dybcio@linaro.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh@kernel.org>
References: <1a4e09da-b19b-4cf5-8fae-822c74cfe048@quicinc.com>
 <20240313071803.422343-1-amadeus@jmu.edu.cn>
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <20240313071803.422343-1-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VBL8yQRdRkupagCiRMOn9fQyixDIxWls
X-Proofpoint-GUID: VBL8yQRdRkupagCiRMOn9fQyixDIxWls
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_07,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015 phishscore=0
 mlxscore=0 mlxlogscore=739 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403130069



On 3/13/2024 12:48 PM, Chukun Pan wrote:
>> Could you share the OEM bootloader log on both these SoCs?
> 
> Chip silk screen: ipq6000, msm_id: ipq6000, bootloader log:
> 
> Format: Log Type - Time(microsec) - Message - Optional Info
> Log Type: B - Since Boot(Power On Reset),  D - Delta,  S - Statistic
> S - QC_IMAGE_VERSION_STRING=BOOT.XF.0.3-00086-IPQ60xxLZB-1
> S - IMAGE_VARIANT_STRING=IPQ6018LA
> S - OEM_IMAGE_VERSION_STRING=crm-ubuntu200
> S - Boot Interface: NAND
> S - Secure Boot: Off
> S - Boot Config @ 0x000a602c = 0x000002e5
> S - JTAG ID @ 0x000a607c = 0x001390e1

<snip>

> machid: 8030200
> 
> 
> Chip silk screen: ipq6000, msm_id: ipq6018, bootloader log:
> 
> Format: Log Type - Time(microsec) - Message - Optional Info
> Log Type: B - Since Boot(Power On Reset),  D - Delta,  S - Statistic
> S - QC_IMAGE_VERSION_STRING=BOOT.XF.0.3-00077-IPQ60xxLZB-2
> S - IMAGE_VARIANT_STRING=IPQ6018LA
> S - OEM_IMAGE_VERSION_STRING=crm-ubuntu64
> S - Boot Interface: NAND
> S - Secure Boot: Off
> S - Boot Config @ 0x000a602c = 0x000002e5
> S - JTAG ID @ 0x000a607c = 0x001390e1


JTAG ID represents the SKU part number. So this part is also IPQ6000 
only. Not IPQ6018.

SBL build BOOT.XF.0.3-00077-IPQ60xxLZB-2 doesn't have support to 
identify this SKU as IPQ6000. Please check if you can use the latest SBL 
image or the one used in another board (BOOT.XF.0.3-00086-IPQ60xxLZB-1).


> S - OEM ID @ 0x000a6080 = 0x00000000

<snip>

> machid: 8030200

Thanks,

