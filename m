Return-Path: <linux-kernel+bounces-72362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A78F85B273
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BC051C21369
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE0A57320;
	Tue, 20 Feb 2024 05:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aduYe9JK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4AD45942;
	Tue, 20 Feb 2024 05:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708408150; cv=none; b=MvlDosZQaMUWvAoBwiPNdqAsMOysVSIInpapcJaT1F8Ig3D/gQNsrvBWrQySs+vXx7fnuCW6jd21L4appkjUGQRGD41Hj46jXE5z3BovAQYrOBu5f7dybKSnm9GLhgG/3/A9twG+e7hh2iO3sVXGObVPOYJf0d/W8AR5KU7q8Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708408150; c=relaxed/simple;
	bh=yEyXcMjJfCC4sirxjRTolR1gpd9nzLskW++Kz50YlZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Y/blRpzfeKZlyusX6BENOFhDSTaqsUeONDJFnqXkckTtt0ygDz4fHRDOw2WINdU3z9yVwh8S2eqjV/BZAix6I7EHWTtO6NyLZ19+TlHKqxsJQaZI7tilDPj37TR02vXwlAb8ZrfG8us3gFhFn64tKZASwhwRRGNp3QX59MGZ0U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aduYe9JK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41K4SYH6030421;
	Tue, 20 Feb 2024 05:48:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=6iLzWXnZbSKEXQ4L81Zd+B5q/JwdxAsNq6BxDPHyTPE=; b=ad
	uYe9JKVV9w9rzk9nBstl6ZyWGxO656xnVgWHx/rTqlPztEhQYfqqoxb9PmqZJKCF
	OK6P0+wPFSaAeh+gDLfGGncNUSlHCFzYfq1wvwO2Ybw9pVkGj9YvJMY4v0wbfFW9
	OO0kXeDso73M5IUTRSQxMtwQYE8uPvtyOGhioCZX8qkXQQrW9beblyQCK4ebbRrR
	G99kGiMb5HWRnJztEIfLW1++ZFtotBho+3jXnGviGdxop67uRlal7NDajxjEEFqZ
	N/rLdzoKATmsRlg2UGvimIEcjRLuPyv1xfwj0ykKndjyhgcnjXaQ1HjAaId2b+E8
	rPIkGh1+qw/AkJS7gdNA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wckv9g80w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 05:48:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41K5mjqF013268
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 05:48:45 GMT
Received: from [10.217.198.224] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 19 Feb
 2024 21:48:42 -0800
Message-ID: <dc16acc1-6ad1-4a81-8eeb-aadaf837ff2c@quicinc.com>
Date: Tue, 20 Feb 2024 11:18:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware/psci: Move psci_init_system_suspend() to
 late_initcall()
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, <andersson@kernel.org>,
        <ulf.hansson@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-pm@vger.kernel.org>, <quic_lsrao@quicinc.com>,
        <stable@vger.kernel.org>
References: <20240219-suspend_ops_late_init-v1-1-6330ca9597fa@quicinc.com>
 <ZdOP5oAwZvEhNAsn@lpieralisi>
Content-Language: en-US
From: "Maulik Shah (mkshah)" <quic_mkshah@quicinc.com>
In-Reply-To: <ZdOP5oAwZvEhNAsn@lpieralisi>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: l7mW_oF9zN_5fAmK4DoZu7ghd3zl5fUE
X-Proofpoint-GUID: l7mW_oF9zN_5fAmK4DoZu7ghd3zl5fUE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_04,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 mlxlogscore=999 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402200040



On 2/19/2024 10:59 PM, Lorenzo Pieralisi wrote:
> On Mon, Feb 19, 2024 at 03:02:04PM +0530, Maulik Shah wrote:
>> psci_init_system_suspend() invokes suspend_set_ops() very early during
>> bootup even before kernel command line for mem_sleep_default is setup.
>> This leads to kernel command line mem_sleep_default=s2idle not working
>> as mem_sleep_current gets changed to deep via suspend_set_ops() and never
>> changes back to s2idle.
>>
>> Move psci_init_system_suspend() to late_initcall() to make sure kernel
>> command line mem_sleep_default=s2idle sets up s2idle as default suspend
>> mode.
> 
> Why can't we fix it the other way around, namely enforce
> mem_sleep_current according to the mem_sleep_default command line
> even if suspend_set_ops() was already called ?

yes, this may be fixed other way also and i did not implement other way 
since mem_sleep_default_setup() only update mem_sleep_default and to 
avoid this race, it needs to also need to update mem_sleep_current along
with it. Below change also resolves the issue.

--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -192,6 +192,7 @@ static int __init mem_sleep_default_setup(char *str)
                 if (mem_sleep_labels[state] &&
                     !strcmp(str, mem_sleep_labels[state])) {
                         mem_sleep_default = state;
+                       mem_sleep_current = state;
                         break;
                 }

however it may be erasing thin line between mem_sleep_default v/s 
mem_sleep_current as both gets updated while set up of mem_sleep_default.

if this change looks Ok, i can send v2 with it.

> 
> Just asking, I am not super keen on using initcalls ordering, it
> looks fragile to me.

i agree with above.

Thanks,
Maulik

