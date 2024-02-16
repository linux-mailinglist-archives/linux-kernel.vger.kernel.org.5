Return-Path: <linux-kernel+bounces-68943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB2E858238
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA9EC284435
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1ED12FB31;
	Fri, 16 Feb 2024 16:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lFFJCQwz"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7DE12FB2A;
	Fri, 16 Feb 2024 16:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708100033; cv=none; b=N03AQ0Tv/8Y/D/XMjpMjgNltGbxirvZNSloMoyuM+ZBOdJcd/WgDAjqlPYUiTt05+w6snmJE7FDBWm9mTtgJMrJCgU1Zrda4w7y2Ab6FF0NUrrPyw3EXyaQO/4XvB6GLO21ALlpWKPlj1f9wzWmWt5BcL3ojPad97UPGeodR6MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708100033; c=relaxed/simple;
	bh=pgWB8gIDXuJeUwDAXlFyiHSuW8VCIa9c0sSJlQvxunQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=M6kck5E1nmqu/l49ZEy0lm+OG9r26K8yQh6WDBGdvWwop9tc/cUaxva5odVm6C5YQgcCIH56Ye7LMmvINlLLHYM42j7ZYGQ2zOW1rRBKWCftvhh+4FPsdFrHcBrEHumex6mOb6FlZwgU/WgV96PjkRjb3Z88cPiZvqi1dsr20/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lFFJCQwz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41GDrAhE004249;
	Fri, 16 Feb 2024 16:13:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=+s47s+oRh66JHw0QvJ6IVx2HVUlYYq8i2oqDQRbbDig=; b=lF
	FJCQwzs80Of5CG+ukeY9DHL2bH7il19HDv5gI9hnHgau0nkXlj3Ld+CmTXojaddx
	fQOiQ30S7Zzn04MpZ/j6dG5B+s56Brbakz1+kqEs74n2IM5SCbxOUeXv7DL0AjW6
	5OO11o6eA+hAZgkBsXxevUFrifBHQt/MwqGlMYN0p3rNbRqkIvNycD8W+2BBeqJy
	JKMXJniTgZoNf5mbyLzJ1nU5V7U5Te0LY/srqMU6VZevK1Hf/lLSbjrsTi08k9IO
	qSrwT4+7Y1ig9oOieup8oGy9Dnok7ZcUacZ3LaSn5EGzK6Qn4wUB+6gcJdfzjx7H
	ZP+m9OL9Sta2iQC41VQg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9fkfc0y0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 16:13:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41GGDZiH015439
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 16:13:35 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 16 Feb
 2024 08:13:35 -0800
Message-ID: <ce40205b-25c6-6ba5-23a4-70a51b4e1b21@quicinc.com>
Date: Fri, 16 Feb 2024 09:13:34 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] f2fs: doc: Fix bouncing email address for Sahitya Tummala
Content-Language: en-US
To: <jaegeuk@kernel.org>, <chao@kernel.org>, <quic_stummala@quicinc.com>,
        <quic_bjorande@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20240202165208.4091800-1-quic_jhugo@quicinc.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20240202165208.4091800-1-quic_jhugo@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Cr2KoCkvvaPxsIziVfFyMR7TPWg19cuW
X-Proofpoint-GUID: Cr2KoCkvvaPxsIziVfFyMR7TPWg19cuW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_15,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=307
 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402160130

On 2/2/2024 9:52 AM, Jeffrey Hugo wrote:
> The servers for the @codeaurora domain are long retired and any messages
> addressed there will bounce.  Sahitya Tummala has a .mailmap entry to an
> updated address, but the documentation files still list @codeaurora
> which might be a problem for anyone reading the documentation directly.
> Update the documentation files to match the .mailmap update.
> 
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

Jaegeuk Kim will you apply this?

-Jeff

