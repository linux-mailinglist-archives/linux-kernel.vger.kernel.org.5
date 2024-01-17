Return-Path: <linux-kernel+bounces-28941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C378304EA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 090E11F24635
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E62E1DFF6;
	Wed, 17 Jan 2024 12:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NLe2U6KU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1394C1DFC7;
	Wed, 17 Jan 2024 12:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705493250; cv=none; b=cHEcNl6CTzFsZpVTmfBmExOxTY4xvH12+xxyrGZtD8Wh9MduPaD0J/VZn2uPXR++F8BdN+E9YBSH5odbSluQcxVv7Q1/9vh8nzaJGeQh5Imu7uyRRfqGBi+SoyECCMDvvK5egV/rxfdaovTpHroJKV2R/LnEpUg3o71NqYLzHCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705493250; c=relaxed/simple;
	bh=IArXwFvZDoiTHZFdxHm8UwzDHOeQK97yKh7sOEA9mMo=;
	h=Received:DKIM-Signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:CC:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=AH5bj4ZqT/KY2OBuf9PXiff3TdYrJDe+lNwiNrBwY6Y/ys6r9KfHoy8R+OvNTs3nHw4PYQqZsXfDlYXkt+Y1W56yEE8utmBrThKWHh8W0AHXY94cNQNkrogsmLNLRoTGSAqc9Dmeh1/w/HgtES5s3Xav69E47iIbuG4pL2ELJM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NLe2U6KU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40HB1CjG019753;
	Wed, 17 Jan 2024 12:07:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=BzJA2P8XRyRHOryogsZXMMaTvL8nGkxACVkL27cO4B4=; b=NL
	e2U6KUeSVsrvu42sDH7vyHZ36S9W10/QKzU8hX7jK7drz2dlnsKy4R4AC/9CXGdV
	9y8zQdLsyzXzT7MliT7lczK+CVsVbvYWHM/b6y5Zi7aXlRQ4j2T0vo+/jJgdNpLG
	Os5WSXCUjUucC7p3xKfWkmd/aAsR+rPcOtapU0dwGCWKhpRUDTDlhV858L86/qJT
	jOFT8zzg0gmOfyA1Gkj5arIDx3sW2JMVhkJnRSJPVgd/LMx9cbNlNkMkF5XlDe2z
	d3Z+mFCrs2YVdbtpVKXRuTGNH/yIQnYoPsl/ZpPqQ6TwCQrrfa/32fHYKOaFjk5P
	rqjhsolAZ8eqmRzceicg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vp4ak18h4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 12:07:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40HC6wIh002523
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 12:06:58 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 17 Jan
 2024 04:06:55 -0800
Message-ID: <674d8057-94b1-2e8a-a3ce-d8719e978298@quicinc.com>
Date: Wed, 17 Jan 2024 17:36:52 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/3] firmware: arm_scmi: Register and handle limits change
 notification
Content-Language: en-US
To: Cristian Marussi <cristian.marussi@arm.com>
CC: <sudeep.holla@arm.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>
References: <20240108140118.1596-1-quic_sibis@quicinc.com>
 <Zaeg1H9G5jOeOXh2@pluto>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <Zaeg1H9G5jOeOXh2@pluto>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bxvcGTIC7OcA3Hn2rsZKKOjFdCxbmhMp
X-Proofpoint-GUID: bxvcGTIC7OcA3Hn2rsZKKOjFdCxbmhMp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_06,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxlogscore=704 mlxscore=0 impostorscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401170087



On 1/17/24 15:11, Cristian Marussi wrote:
> On Mon, Jan 08, 2024 at 07:31:15PM +0530, Sibi Sankar wrote:
>> This series registers for scmi limits change notifications and adds
>> perf_notify_support/perf_opp_xlate interfaces which are used by the
>> scmi cpufreq driver to determine the throttled frequency and apply HW
>> pressure.
>>
> 
> Hi,
> 
> a few initial remarks from the mere SCMI standpoint.
> 
> Unlinke most SCMI protocols that expose domains info bits via an
> *info_get protocol operation, PERF does no do this since (till now) there
> wasn't a compelling reason (i.e. users)
> 
> Ulf recently in his GenPD/SCMI series recently started exposing something
> and now you need to expose even more, adding also a new xlate ops.
> 
> For the sake of simplicity, I think that we could now expose straight
> away the whole perf_domain_info and embedded structs via the usual *info_get.
> 
> After having done that, you can just drop your patch 1 and 2 since you
> can access the needed info from the cpufreq_driver right away.
> 
> Having said, I have already such patch ready (for my internal testing), I
> wll post it by the end of week after a minor cleanup, if you can bear with me.
> 
> Thoughts ?

Ack, just from the naming I initially thought info_get would include
everything but it just exposed minimal info. We certainly don't want to
keep adding very similar ops just to expose more such info. I'll re-send
the remainder of the series after you are done with your patches.
Thanks.

-Sibi

> 
> Thanks,
> Cristian

