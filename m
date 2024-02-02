Return-Path: <linux-kernel+bounces-49728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD88846EA1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8481C270B5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CB313D4E4;
	Fri,  2 Feb 2024 11:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Tj4cFTjR"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D4267A15;
	Fri,  2 Feb 2024 11:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706871942; cv=none; b=FxWC/qZtvbB97/FX0ULpqlsddHsDmeWHdptUpV9zthbTlRwZIdrM5UpTHQqGr6YWw7npJDbB9WXEZFU5DzcQNdYD/TwRvQli2ZmBDeNx7a5BVdWYILLnUhOJ1VmLtNv8vRBWBnJ6XBy32ILyY7NbRVitok1Z1S6F5Uo8whGylf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706871942; c=relaxed/simple;
	bh=zSXA+iPCtIXHysA/656JrfpWk3Pmc54FYLHJuA9VxEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eUqykXiE1Z/wu0PFI6oddCW0UxBpxbylbX9G1uOvkzr6u3z+l21XxsxRoXQcTrxCnZZo+HD0/BIHjFacwo91qZcwffpX3u5cPo3gE9pQJLTAQWiUBZtagWBIkV4MB0Q/YYtKRza/iHO1+u6cjDhDrVyIEXnXK4XsvehrQyWi/lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Tj4cFTjR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4126UMDO005707;
	Fri, 2 Feb 2024 11:05:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=hs7wvNkO8/AEv7pfPPTccUb/jzx3va4zybhw+pXcMGc=; b=Tj
	4cFTjRtH22LE3E/dl9fLN3Cx36wYo5lteOWgXgXI7aH4foioBSqHh3qiYtrHVOLr
	DCLnQU0lhMUsWGavx88HJwU1/L8yn7IEud1woJZdUD4hrh956XKAzRfee11ZENEu
	Zhqblw4ngYvJkQqEXVeNcxeDRSngyHSgaktj/QVwR2tf0WaPBLQtuKw2n31iPgzr
	jhH6G//M6MCLNfJ2XCZj5wKQSwmVIzR276+HYP8xGEESyUZ26W93zOP835La2yna
	6JBWdQrWnPwQOI6mJ8QS8y8AUZfV9dsJL5i7cXbR0YmWUaUbAOKxTbM29Aox40ks
	4hfY/hGL/oBDHFUu2EYQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0pu1s65j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 11:05:36 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 412B5ZkQ012056
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 11:05:35 GMT
Received: from [10.239.132.150] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 2 Feb
 2024 03:05:30 -0800
Message-ID: <613ee374-6e63-40ab-b5d7-3aee3474bb14@quicinc.com>
Date: Fri, 2 Feb 2024 19:05:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] pinctrl: Add lock to ensure the state atomization
Content-Language: en-US
To: Linus Walleij <linus.walleij@linaro.org>
CC: <andersson@kernel.org>, <kernel@quicinc.com>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20231225082305.12343-1-quic_aiquny@quicinc.com>
 <CACRpkdYM5=55m2ywC981VXVzbCg64Opbh4yEw2TLja998cES-w@mail.gmail.com>
From: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>
In-Reply-To: <CACRpkdYM5=55m2ywC981VXVzbCg64Opbh4yEw2TLja998cES-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SXc3On6AMLgRdynIfUSwFvlKWTLk3_Sb
X-Proofpoint-ORIG-GUID: SXc3On6AMLgRdynIfUSwFvlKWTLk3_Sb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_05,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=441 malwarescore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 adultscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020081



On 1/28/2024 6:43 AM, Linus Walleij wrote:
> Hi Maria,
> 
> I wanted to apply this v3 patch, but I can't figure out what it is based on?
> 
> Could you rebase the patch on v6.8-rc1 and resend?
Hi Linus,

Here you go:
https://lore.kernel.org/all/20240202105854.26446-1-quic_aiquny@quicinc.com/T/#u

When I rebase to v6.8-rc1, there is little conflict about header file, 
so the cleanup.h is already added from other commits.
So I just mark it as v4 instead of Resend.

Hope this information is clear to you.
> 
> Yours,
> Linus Walleij

-- 
Thx and BRs,
Aiqun(Maria) Yu

