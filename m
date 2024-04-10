Return-Path: <linux-kernel+bounces-138413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D66F89F0EB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 388B028BBE0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A4315959A;
	Wed, 10 Apr 2024 11:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="K0RMnapA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B0C2837B;
	Wed, 10 Apr 2024 11:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712748610; cv=none; b=UVS+zTfCqY4fwpf9Q4HjReRuPTWQUYeprGqO93j3zNv4a3wUAcA3RkqM+tdwlLEY5EwCUXGhEiQuugIRZ0VQ/Ua62kl/+0IMdre/XNcLZQuyRipRaYVxtR9l9E8WiM5radJyKjoRLkM+EqhtmBuV27IPpZ7CUEtlm/FGq3Hz2vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712748610; c=relaxed/simple;
	bh=YZB+zpMuolGmgdG92DofGaTe2fyQ0gFaw353gbd2/4U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDMOD3jOn1Saz6AIAfpGdP9vgr/DaGUhq0mjIfGV+uqdp5zS1RRk8oTD/7klHAHTzxVzrPFteIoAQ1yAmTlpRSqbTftPrX8VRlVFkbL+Epw0wOqULk5JOyuSZlmtr8yPniCtw+L2KuNA9ATjMA3YJtrsR6snfqlCokFJNO+tKs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=K0RMnapA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43A97lp5016153;
	Wed, 10 Apr 2024 11:29:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=UabYkyhdrQmUkvj3/LTlT
	8g57arwdsP/D2XBukOqTOs=; b=K0RMnapAhZXqYokubtMYbRT3kiED8IjCi2eVT
	3dP5XV93w8aM3H+vordkDkRJn4IasFenatg1g/yB95Che2JBfHoIt4/SPSxwN+xG
	SAKq8cH+fcM06IzXo/hgbEyLOsZ2tq/kKfJJtHdn5XqEDtB3qUSl8R2mjc76YLTc
	omK/0ty4CAjw2GpVGLfReNqAiwLlrv04XgixIomBLoq4IBpuPiqiNXqDPuOxncuJ
	wRMfE7PVeiPxuczMxF26PWBK01rdmpmi3Kf8b9heEzuS/HNJyG04C6Fr8k4WMMrz
	UpGt/1ecbZrdXxVTCtDFWWFCTzZ1sOlkCwnkmDZ9wsN8z+dxw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xdquhrqqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 11:29:44 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43ABTiJQ013137
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 11:29:44 GMT
Received: from hu-atulpant-hyd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 10 Apr 2024 04:29:36 -0700
Date: Wed, 10 Apr 2024 16:59:33 +0530
From: Atul Kumar Pant <quic_atulpant@quicinc.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <mingo@redhat.com>, <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <kernel@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [RFC PATCH 0/2] Disable RT-throttling for idle-inject threads
Message-ID: <20240410112933.GA3190796@hu-atulpant-hyd.qualcomm.com>
References: <20240410045417.3048209-1-quic_atulpant@quicinc.com>
 <20240410085441.GA21455@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240410085441.GA21455@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JU3z3IG_6EdWT11hJ9dEADC79H8XVY3K
X-Proofpoint-GUID: JU3z3IG_6EdWT11hJ9dEADC79H8XVY3K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 adultscore=0 clxscore=1015 mlxscore=0 malwarescore=0 mlxlogscore=785
 phishscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404100082

On Wed, Apr 10, 2024 at 10:54:41AM +0200, Peter Zijlstra wrote:
> On Wed, Apr 10, 2024 at 10:24:15AM +0530, Atul Pant wrote:
> > We are trying to implement a solution for thermal mitigation by using
> > idle injection on CPUs.  However we face some limitations with the
> > current idle-inject framework. As per our need, we want to start
> > injecting idle cycles on a cpu for indefinite time (until the
> > temperature/power of the CPU falls below a threshold). This will allow
> > to keep the hot CPUs in the sleep state until we see improvement in
> > temperature/power. If we set idle duration to a large value or have an
> > idle-injection ratio of 100%,  then the idle-inject RT thread suffers
> > from RT throttling. This results in the CPU exiting from the sleep state
> > and consume some power.
> > 
> > To solve this limitation, we propose a solution to disable RT-throttling
> > whenever idle-inject threads run. We achieve this by not accounting the
> > runtime for the idle-inject threads.
> 
> Running RT tasks for indefinite amounts of time will wreck the system.
> Things like workqueues and other per-cpu threads expect service or
> things will pile up and run to ground.
> 
> Idle injection, just like every other RT user must not be able to starve
> the system of service.
> 
> If your system design requires this (I would argue it is broken), look
> at other means, like CPU-hotplug (which I also really detest) -- which
> takes down the CPU in a controlled manner and avoids the resource
> issues.

Hi Peter,
We are trying to add support for true 100% idle-injection ratio from
idle-injection framework. It might happen that we want to run idle cycles for
slightly more time than permitted by RT-bandwidth control.  We understand the
concern about it hogging the cpu. Will it be better if we make it a choice for
the user who uses idle-inject framework, whether to have true 100%
idle-injection support or not?

Thanks
Atul

