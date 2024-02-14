Return-Path: <linux-kernel+bounces-65231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E376A8549C4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A084F28A62C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5992852F90;
	Wed, 14 Feb 2024 12:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EFc3LRbK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1CF487BC;
	Wed, 14 Feb 2024 12:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707915383; cv=none; b=fJihn8LkEtPfwDlweawxyUG8XVmyR6wjsPAhKruLRzEHWuiQ8llZjY82InDnvBfeo8YNzJRwbKTqkYCPm31rCgP860Fh+BfQ0YywCvyl8c+dJ7Ui3C6NeewWVdeguB0HTc7f6JzeKl8dYIy0kXcWC3FWg6an6vh76eo9Zhf/Blo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707915383; c=relaxed/simple;
	bh=6DR0P/WQ+fKVZKkQryKokxeT6znavJmaWnFd7byWnkc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=iDNYWHcEbXy12cK4vssvDMwhVDc03kN8igpJRTxgy/tT2sDXfXDsVLpqOOR34/JtiFPxQExMYN+nbwII6kAyTJgBo9sp+5Z3fFdTMNKxawpftdtEiJN2E/Lb5dDjEcFSJRKhQSs3RAUmpgRSB7t7fKXXWkH5CHZ/L8/+HKSbCqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EFc3LRbK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41E6q01Z027945;
	Wed, 14 Feb 2024 12:56:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=IqeTyFlzG5Lbc99OW9HRKNNfQNLD+RGgkxJvm4oKLAI=; b=EF
	c3LRbKYJhnk8C1CCCe3TrG/gmzRlh7kBJsxHSXvXv/66oK5Wey/mpHGMASWvD0aV
	OhJ4J1PGqLHwgUSPY1im0/XBlZbaaPaaRkm0tUh6sgSAh3NOBo4lRuIdX0HyBK1L
	CyOhsvDwVW79UVIl5DrvpolUA96RQVN3jCQLeD+qiaojlK1kW2lIXlbznhTTHiUC
	hHdUBPanEGniRX0VgchpIoD7Uvjm3zCFlZyEtSd4pAxxrQ8loXY+FZeGBsiZMFp/
	YuNmvLD48Ux9SumJ7b3/YtqvUc+9M1YMjYT1VgRWnyi4mvEfUP78BKX2mLyXi/QZ
	BV6l/FAoLovjoHAYKBCg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w8myg1165-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 12:56:17 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41ECuG3j008259
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 12:56:16 GMT
Received: from [10.214.225.222] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 14 Feb
 2024 04:56:09 -0800
Message-ID: <a930a3d6-0846-a709-8fe9-44335fec92ca@quicinc.com>
Date: Wed, 14 Feb 2024 18:26:06 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/2] Add board-id support for multiple DT selection
Content-Language: en-US
From: Amrit Anand <quic_amrianan@quicinc.com>
To: Rob Herring <robh@kernel.org>
CC: <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <kernel@quicinc.com>
References: <1705749649-4708-1-git-send-email-quic_amrianan@quicinc.com>
 <20240124145631.GA873781-robh@kernel.org>
 <b929f0cd-89b6-c48d-d466-db6bbed621b5@quicinc.com>
In-Reply-To: <b929f0cd-89b6-c48d-d466-db6bbed621b5@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: k8sSZjfZbDmNnlavKhPAmg49Bqb6K69a
X-Proofpoint-ORIG-GUID: k8sSZjfZbDmNnlavKhPAmg49Bqb6K69a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_05,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401310000
 definitions=main-2402140099

On 2/2/2024 10:30 AM, Amrit Anand wrote:
<snip>
>> There's a similar issue for EFI boot with how to select an OS installed
>> DTB[1]. You might not care now, but users may later on (like we have
>> already with QCom devices with fixed bootloaders). If you do this
>> board-id route, then no doubt that compatible values won't be specific
>> enough or have suitable fallbacks to be used. Then EFI boot can't use
>> compatible either and needs to use this QCom specific logic. It may be a
>> common property name, but all the types you defined are QCom specific
>> and the matching logic is pretty much undocumented. I'm not saying we
>> have to use compatible. There wasn't even agreement to use it for EFI
>> boot case. This does need to work for multiple vendors and multiple boot
>> scenarios.
>>
> Agree, given so many hardware identifiers Qcom uses to find the DT 
> based on a best and exact match algorithm, it may not work as is for 
> other vendors/users outside the scope of Qcom.
> Since we have none to very limited visibility into complete set of DT 
> selection identifiers being used by other users or into their 
> selection algorithms since it is mostly undocumented,
> designing a perfectly generic solution (one-size-fits-all) could be 
> far-fetched. The number of board files in Qcom DT selection software 
> package often reaches over 100 DT files due to multiple SoCs and
> board types being supported out of a single software package and these 
> multiple hardware identifiers helps to pick the closest best match DT 
> within a very large pool of DTs.
> Not to affect other users/vendors who would be using their own set of 
> identifiers and an entirely different algorithm for DT selection, 
> would it make more sense to define these Qcom specific
> identifiers within Qcom specific bindings (qcom.yaml), along with 
> detailed documentation on our DT selection algorithm?


I have written a patch for defining Qcom specific identifiers within 
Qcom specific bindings (qcom.yaml) along with documentation on DT 
selection algorithm, would it be okay to send for review?

>
> Thanks,
> Amrit
>
>>
>> Rob
>>
>> [1] https://lore.kernel.org/u-boot/20231114232012.GD6601@bill-the-cat/#r

