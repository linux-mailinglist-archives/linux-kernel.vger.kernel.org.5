Return-Path: <linux-kernel+bounces-33998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDD18371BD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5160C1C2A13F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5175B5BB;
	Mon, 22 Jan 2024 18:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="c8faY7MP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C5B56468;
	Mon, 22 Jan 2024 18:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705949067; cv=none; b=iQDdPUelLE4oDziCkDZK9PsfqulhDeF3KJiOygNU6mXtZflX6prOPoxe+/h+KS+zqg6Y/B5w94ToNU6xKYeLtxDfyY9J6k2Zrw/blBsof6BB+6FkuNj+4ALK8X24+q9SsfT7kVSoiOxTJw0dIYEUuHwsMgWpC1011Q+tW99b+LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705949067; c=relaxed/simple;
	bh=1WCIOYu6o9ZNAeIt8H5e5xO3cgcftRHkmCVeQPtUoRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uhBUs5xCDoLK0kK2pHFNJ0sXpunE7CF+gvyslcp4aSIHsuFU/uoVBEyZQVmPBafsZQ+vbKsTjoerFtUY2Tc7SSdk3GSrZH2ptb8AxRHDab3N+cOUmoAD+nPaVPAWl+sAYTtiyanSZfAzKcn7fdChgjfKP25FA5I7PzOpNrOAR9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=c8faY7MP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40MGx4Fq003574;
	Mon, 22 Jan 2024 18:44:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=vnOCaYTHwMn9FwULO/VcAeFAY60b2pA3nzOOeXWRiZY=; b=c8
	faY7MPpx6gu48CfltjP6hWpWJU8jsFLqIkbjOwBsVTA8C8na99fzG9bo9n7oU0UN
	kkVhazR5nNUa6KtZc01ieW1b+SoM5kEchNgGrh2xs0VjcD/JT7IsLdSC+YvNSQ7q
	6xi+ATRdQVzm6p/JQogbNyiyiRoWD4afev2m28JJi6+482D44rjGFy1cjWLjSSbK
	CYESWov8ozcqjJM8KdjaGw6/H9t7CtGuTIxsTL5sPTDHJiVNIBQ1ys5kf3Td3DYT
	oZpbbfG8GlrJS1Zt95Hwdan0lvzeb3MVeYEMNYpsywN08Is/loiKj7AGeeZpMbvt
	pQoPNVDmmVtpM34Heanw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vspw8s92a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 18:44:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40MIiBas019057
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 18:44:11 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 22 Jan
 2024 10:44:10 -0800
Message-ID: <52479377-ff61-7537-e4aa-064ab4a77c03@quicinc.com>
Date: Mon, 22 Jan 2024 11:44:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 0/2] Remove QDF2xxx pinctrl drivers
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin
 Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Marijn
 Suijten <marijn.suijten@somainline.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20240122-topic-qdf_cleanup_pinctrl-v1-0-0c619ea25091@linaro.org>
 <8c9b157b-4698-70a3-57b7-c588998eeda7@quicinc.com>
 <CAA8EJprDk=HnqWJ_F5zdUKMPFPpx1RD9KN-KQP9yopP6LMh_fw@mail.gmail.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <CAA8EJprDk=HnqWJ_F5zdUKMPFPpx1RD9KN-KQP9yopP6LMh_fw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aPWlgGktUCnoyDRfg-opDD3bBqYhymSU
X-Proofpoint-ORIG-GUID: aPWlgGktUCnoyDRfg-opDD3bBqYhymSU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_08,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1011 suspectscore=0 impostorscore=0 mlxlogscore=712
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401220130

On 1/22/2024 10:56 AM, Dmitry Baryshkov wrote:
> On Mon, 22 Jan 2024 at 19:43, Jeffrey Hugo <quic_jhugo@quicinc.com> wrote:
>>
>> On 1/22/2024 4:57 AM, Konrad Dybcio wrote:
>>> The SoC line was never productized, remove the maintenance burden.
>>>
>>> Compile-tested only.
>>>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>> Konrad Dybcio (2):
>>>         pinctrl: qcom: Remove QDF2xxx support
>>>         arm64: defconfig: Remove QDF24XX pinctrl
>>>
>>>    arch/arm64/configs/defconfig           |   1 -
>>>    drivers/pinctrl/qcom/Kconfig.msm       |   7 --
>>>    drivers/pinctrl/qcom/Makefile          |   1 -
>>>    drivers/pinctrl/qcom/pinctrl-qdf2xxx.c | 164 ---------------------------------
>>>    4 files changed, 173 deletions(-)
>>> ---
>>> base-commit: 319fbd8fc6d339e0a1c7b067eed870c518a13a02
>>> change-id: 20240122-topic-qdf_cleanup_pinctrl-98e17cdb375b
>>>
>>> Best regards,
>>
>> NACK.
>>
>> This was productized, there are some out in the wild, and the platform
>> is still in (limited) use.
>>
>> I'd like to see support hang around for a few more years yet.
> 
> The problem is that... its support is pretty strange. I can see
> pinctrl, ethernet and quirks for the platform in GIC-ITS and PL011
> drivers. Is this enough to get the platform into the useful state? I
> can imagine that "QCOM2430" ACPI handle was used for USB hosts on that
> platform, but I don't remember when we last tested DWC3 with the ACPI.
> 
> So, all this boils down to the question whether mainline (or something
> close by, LTS for example) is actually used and tested on these
> devices?

Its an ACPI system, so you won't see all of the fun DTisms of a MSM chip.

The platform was fully functional upstream, and had an Ubuntu 
certification.  I run Ubuntu on the two that I have in my office.  I 
haven't strictly checked out mainline in a while, but I could.  I still 
have access to the documentation.

There is a small, but active set of users including myself.  From what 
I've seen, they've been happy with things.

-Jeff

