Return-Path: <linux-kernel+bounces-76357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3016785F60F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5EF31F254D0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3393FB3A;
	Thu, 22 Feb 2024 10:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JE25D2Pj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808923C480;
	Thu, 22 Feb 2024 10:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599024; cv=none; b=V/WYZBaauifLLtSWXlI/6emPZqtmILjXkm69wiGDud6OXVszSETVAfwUD8AfDUdrxPkhSkNGWJvptjkzrsT6JWunf01Bu2gp3mIqd83pjxS30peS0QQxpK0oMXPUomWdk2Xp0WPi7Dp6IhHnq1tgawpqool57WF7w7dr4tvOlgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599024; c=relaxed/simple;
	bh=jNXg/fKUaSj9wpqoW0g2TuOyqnuEPbhRGtmkRiT1ZeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pKf7/MtZPgScDNDSR5De9CoZi0Kn24ECI4ZSD5GDn3OIhdtOtHnuDhFqFF/kZILjx27I6UC+/2J0VjppheN4dky6CQYiT5p4Tqxb/vY2JLF9FS7qFRTiY+TPAaMK5amLXw0lR58vVfcmMCpZJ/49hSskiSW8IpPhCT8SfTn7Wl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JE25D2Pj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41M8kQ0s006701;
	Thu, 22 Feb 2024 10:50:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=rnhYF+gVGsiUtYDftnir34spKnwFvPAcwR3w6tAZZMk=; b=JE
	25D2Pjvq4OXBgIGhTP1i8Rz2OpWI576qjejf2GXyrkQ49JoEsc6miF2g1jBBq5zJ
	Un5M/TTZqkhx8OH7lC8QO3F/JP7yNzV2v6OPXHA0RU+o7YZnoNxaIrdKBptIoiM7
	oKoQu5zN7fFLfKJWF8wU0FPAA7Sp/qaJi+S6cGS3xHEwyQtXdumYjV/0FrmzeiBC
	oBLeVIY8XRj1oaUWbZGhokXM8L6NpQQJVl7fotJbpxA9luggnsQh8fHxVtw4nzD3
	wN7wS6dtLRivc6X/MyDuDDowwrjZf5VRI62/5uuyV9R0rOJ6DGUusoVeGDL5Q2Ob
	mVIyXTjhPYz/dSbAkRvA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3we3230b3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 10:50:13 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41MAoCUN023509
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 10:50:12 GMT
Received: from [10.217.216.110] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 22 Feb
 2024 02:50:08 -0800
Message-ID: <fbdcd6e6-9d57-47d8-a462-908a03b373ea@quicinc.com>
Date: Thu, 22 Feb 2024 16:20:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] dt-bindings: interconnect: add clock property to
 configure QoS on SC7280
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, <djakov@kernel.org>
CC: <rafael@kernel.org>, <corbet@lwn.net>, <linux-pm@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_viveka@quicinc.com>, <peterz@infradead.org>,
        <quic_mdtipton@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <konrad.dybcio@linaro.org>
References: <20240205145606.16936-1-quic_okukatla@quicinc.com>
 <20240205145606.16936-4-quic_okukatla@quicinc.com>
 <e473937e-2d8e-47e3-bffd-025b87769335@linaro.org>
From: Odelu Kukatla <quic_okukatla@quicinc.com>
In-Reply-To: <e473937e-2d8e-47e3-bffd-025b87769335@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oUj0HjVDW3OCir1u929A5IGu3ZbvHaIY
X-Proofpoint-GUID: oUj0HjVDW3OCir1u929A5IGu3ZbvHaIY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_08,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 mlxlogscore=614 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220084



On 2/5/2024 8:40 PM, Krzysztof Kozlowski wrote:
> On 05/02/2024 15:56, Odelu Kukatla wrote:
>> Added clock property to enable clocks required for accessing
>> qos registers.
> 
> I have no idea how you came up with that CC list. It makes no sense.
> 
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC. It might happen, that command when run on an older
> kernel, gives you outdated entries. Therefore please be sure you base
> your patches on recent Linux kernel.
> 
> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
> people, so fix your workflow. Tools might also fail if you work on some
> ancient tree (don't, instead use mainline), work on fork of kernel
> (don't, instead use mainline) or you ignore some maintainers (really
> don't). Just use b4 and everything should be fine, although remember
> about `b4 prep --auto-to-cc` if you added new patches to the patchset.
> 
> You missed at least devicetree list (maybe more), so this won't be
> tested by automated tooling. Performing review on untested code might be
> a waste of time, thus I will skip this patch entirely till you follow
> the process allowing the patch to be tested.
> 
> Please kindly resend and include all necessary To/Cc entries. Tomorrow.
> 
> Best regards,
> Krzysztof
> 

Thanks for your comments. I used latest tree only, but looks like i made a mistake while sending it.
I will use scripts/get_maintainer.pl script to get the list for next revision with other's comments addressed.

Thanks,
Odelu

