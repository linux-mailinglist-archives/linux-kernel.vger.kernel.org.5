Return-Path: <linux-kernel+bounces-103917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9F787C68C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4B601F211B5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A78712B93;
	Thu, 14 Mar 2024 23:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="H6QikYBW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5EA11185;
	Thu, 14 Mar 2024 23:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710459584; cv=none; b=QpuFjHyQkISOst9mtxRX6paGihAvgWHjonQMzpHexvLq8BbumUypwDAHbVHZyjHYvv4s9h6dSwuRHb4WuRTzJXLCpOoGSUINEDIz/VqXUR41ty1cc0m6sJKOUfWvKYsVyRj2qNPs3mkD6CZZNVAonJaYK9OPkX4oo57mm8TopJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710459584; c=relaxed/simple;
	bh=5wJ0QPO5pEtrf+2wTjqJLoRgXaQfZ+wsh5hqDRQ/8oA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QgI7xFd/sTfaXNdUUbryiPbk9xCWAc8KYTCJRyOvKx7Kz8TDaLI/mFd+owR9lUt2IVkHTwgPSoYZWhBtj3ylrAmCVm/r3wVYfpoonuDMaPKn4p6kHspc3o25uOFE4OPcywEKlE3ib+2Sz+lUyPlberZWDlfe1RjQUxFUQ+K4hj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=H6QikYBW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42EMl74u024573;
	Thu, 14 Mar 2024 23:39:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=fZYnzVj/nareEdnr5n/qOHTEyx46QdBEfBsFABzo1fA=; b=H6
	QikYBWKWj6IQG01aF7Rx1sfqyKdcRB2/mSyobt/FK86CQyksQV/yc6C9MMhwCdRj
	CQRZtUV2sUowdAJ08RbbLCII86M4XikxWXiCs1oaFsmJ2vVeU7/aTlfxeXYgtzRC
	9vw5w7K4wuRTT1un8UIFlORH9IwtLQ8buYCxjezJA07d+HfxRImOZArhm0t/9tJ8
	FlGnCSVXtzYFwqjtA8Mzh6L2Rk8FqF/9x4HeQy2wi3947CcU1zzt1GNc3ZhrRV5H
	gRgowp8watjrGW1AsNKIByWkZtWhecWdlIF0Vj0ERh9Qvuv5tdiWdgiGdT4Wfv/B
	zgZZNyzXngI08Ynmqngw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wv9yt03mm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 23:39:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42ENdXGB003969
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 23:39:33 GMT
Received: from [10.110.35.191] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 14 Mar
 2024 16:39:28 -0700
Message-ID: <f638e848-36c5-4cea-c2c8-841a003b1863@quicinc.com>
Date: Thu, 14 Mar 2024 16:39:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RESEND v4 3/3] arm64: dts: qcom: sc7280: Add power-domains for
 cpuidle states
Content-Language: en-US
To: Doug Anderson <dianders@chromium.org>,
        Maulik Shah
	<quic_mkshah@quicinc.com>
CC: <andersson@kernel.org>, <ulf.hansson@linaro.org>, <swboyd@chromium.org>,
        <wingers@google.com>, <daniel.lezcano@linaro.org>, <rafael@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <sudeep.holla@arm.com>,
        <jwerner@chromium.org>, <quic_lsrao@quicinc.com>,
        <quic_rjendra@quicinc.com>, <devicetree@vger.kernel.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        "Rob
 Clark" <robdclark@chromium.org>
References: <20230703085555.30285-1-quic_mkshah@quicinc.com>
 <20230703085555.30285-4-quic_mkshah@quicinc.com>
 <CAD=FV=XWH+Eoa9XjDns--NSDTZHeUwTdrX_r_QZhSPpbZNwz+w@mail.gmail.com>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <CAD=FV=XWH+Eoa9XjDns--NSDTZHeUwTdrX_r_QZhSPpbZNwz+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: F0EtSGQkIOWOteAUJFml1iye4a_kKci2
X-Proofpoint-GUID: F0EtSGQkIOWOteAUJFml1iye4a_kKci2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 suspectscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403140182

Hi Doug

On 3/14/2024 4:20 PM, Doug Anderson wrote:
> Hi,
> 
> On Mon, Jul 3, 2023 at 1:56 AM Maulik Shah <quic_mkshah@quicinc.com> wrote:
>>
>> Add power-domains for cpuidle states to use psci os-initiated idle states.
>>
>> Cc: devicetree@vger.kernel.org
>> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>> Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7280.dtsi | 98 +++++++++++++++++++++-------
>>   1 file changed, 73 insertions(+), 25 deletions(-)
> 
> FWIW, I dug up an old sc7280-herobrine board to test some other change
> and found it no longer booted. :( I bisected it and this is the change
> that breaks it. Specifically, I can make mainline boot with:
> 
> git revert --no-edit db5d137e81bc # arm64: dts: qcom: sc7280: Update
> domain-idle-states for cluster sleep
> git revert --no-edit 7925ca85e956 # arm64: dts: qcom: sc7280: Add
> power-domains for cpuidle states
> 

We noticed that some variants of sc7280 herobrine boards didnt boot but 
some did atleast till linux 6.8 rc-6. I have not tested linux 6.9 rc-1 yet.

We did not narrow down which change broke some of the boards, I can go 
back and confirm if its this one next week.

> (I get an ath11k crash after that, but that's easy to hack out since I
> don't need WiFi)
> 

hmm, wifi worked alright on 6.8 rc-6 for us.

> I suppose the two options here are to either:
> 
> 1. Track the problem down and figure out why the breaks boot and then
> fix it. I'm personally not going to track this down, but if someone
> wants me to test a patch I can do that.
> 

Can Maulik help us do that?

> 2. Delete all the herobrine dts files.
> 
> So far we've been keeping the herobrine dts files alive because I
> thought some graphics folks (Rob, Abhinav, Jessica, for instance) were
> still using it. ...but Rob says he hasn't booted his in a while. No
> idea if Abhinav and Jessica are using theirs. Any opinions? Is
> herobrine hardware support near and dear to anyone these days?
> 

Yes, so we have been using sc7280 herobrine devices even till the last 
cycle and quite a bit of feature development was actually done on that.

It was the only device having eDP other than sc8280xp till x1e80100 
landed last cycle.

I do want to start using sc8280xp as well because from the experience we 
got, it has more visibility in terms of users. So that will address my 
eDP concern.

But, the nice thing about chromebooks is we really like to use them for 
IGT development / CI debug as CrOS provides a nice environment to 
cros-deploy IGT.

We can continue to use sc7180 for IGT development but if we want to 
debug issues with eDP + IGT, sc7280 is a really useful platform for that.

sc8280xp or x1e80100 is not a CrOS supported device. So we will have to 
develop and test IGT directly on the device (which is a bit of a pain) 
unless someone has a better way of "cross-compilation" for IGT on 
non-CrOS images.


> 
> -Doug

