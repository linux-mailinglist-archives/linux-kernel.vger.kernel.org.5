Return-Path: <linux-kernel+bounces-45843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5518436FB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5E6B1F24BB6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0AF3DB8C;
	Wed, 31 Jan 2024 06:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="L0thNyrU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F403F53E25;
	Wed, 31 Jan 2024 06:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706683928; cv=none; b=qPIYp6hCnX2wFmSGcAAcanAlJ1nhS9dVJkMyJKeE2WijZg51iLLCZO7TsyrEP14tBKtbg61I5Oj+On0Tl26xZl3cEuYmmEvE3aU+HbKfFyf1ygQ86Dx+mVtpPDe7TqkhMWLNoUv2cPtK3cFpYmPnVVuUkvUY0oUucL4+2ppJ3fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706683928; c=relaxed/simple;
	bh=AyL/KhP/HPP4upzed4m2SWG+KUTVwHmJxnBFBU6C+8c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGb9GbvtALryy86/Dszmlt7SEXig0PDygYg/6M2mTj2GvQ1jRW2nHIl2iiI96NEBwP+vZIFQlc/xaP0ohEnMBeD0Af8etsTSQ+Pr0G1numi+aNwbm6bbVuER2Dn8X9tBJgSjmkzIMepggOSP1LFFUj98xfStXFu1YzQCNNHuvkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=L0thNyrU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40V54ljx023208;
	Wed, 31 Jan 2024 06:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=CftI+Lys/8CRlMkhsd2f7
	8hD8i/Bez1eefh+WebX7n8=; b=L0thNyrUR35qgullDQI/qlrqL1ReHvByvrVca
	MIhACUp7+gf8jWIds9o+m27T8v4Ev89SHspy7tnN6KhXMp5JDkePiDph6XBJwnzN
	Z0+8kJe1sR0K3HbPL7sY5OffdSecWzCjDZcRa/JHWBa4OZwfLyFONB2iaf1OLhV/
	9buyyx7jMTpFzxgdjXOFPEybYPF38SwY88QbV8i5f8UCdsk44EH1W8a9P9sg+ecg
	KAO1K8P1lVlC1/nufSYDzXNUZZvmIp/AFw9QH3pLsGuumvYN527pJtE7L80TA+G6
	IBS/O8GCn1ocaSleAX6srqLg3y5B83dHh6NiGPMokMt486dXg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vyfr30a7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 06:51:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40V6pdwp011752
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 06:51:39 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 30 Jan 2024 22:51:35 -0800
Date: Wed, 31 Jan 2024 12:21:33 +0530
From: Pavan Kondeti <quic_pkondeti@quicinc.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Wim Van
 Sebroeck" <wim@linux-watchdog.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Mukesh Ojha
	<quic_mojha@quicinc.com>
Subject: Re: [PATCH] watchdog: qcom: Start the watchdog in probe
Message-ID: <22141056-bc6b-48bf-a4af-405f747aaa29@quicinc.com>
References: <20240131-qcom-wdt-start-probe-v1-1-bee0a86e2bba@quicinc.com>
 <1a996038-bcc7-4c0f-8f27-ca36a2eb9d3d@roeck-us.net>
 <cfaaed23-8f59-4447-af0b-b94b35ce68ba@quicinc.com>
 <a908d04b-8068-4831-87ef-44175250c226@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a908d04b-8068-4831-87ef-44175250c226@roeck-us.net>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tpOrUK483pRbQF9jmoYq4-F4ocrVEmaW
X-Proofpoint-ORIG-GUID: tpOrUK483pRbQF9jmoYq4-F4ocrVEmaW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_02,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401190000 definitions=main-2401310051

On Tue, Jan 30, 2024 at 10:37:50PM -0800, Guenter Roeck wrote:
> On 1/30/24 22:16, Pavan Kondeti wrote:
> > On Tue, Jan 30, 2024 at 10:01:15PM -0800, Guenter Roeck wrote:
> > > On 1/30/24 20:15, Pavankumar Kondeti wrote:
> > > > When CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is enabled, kernel can pet the
> > > > watchdog until user space takes over. Make use of this feature and
> > > > start the watchdog in probe.
> > > > 
> > > > Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
> > > > ---
> > > >    drivers/watchdog/qcom-wdt.c | 6 +++++-
> > > >    1 file changed, 5 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
> > > > index 9e790f0c2096..4fb5dbf5faee 100644
> > > > --- a/drivers/watchdog/qcom-wdt.c
> > > > +++ b/drivers/watchdog/qcom-wdt.c
> > > > @@ -276,12 +276,16 @@ static int qcom_wdt_probe(struct platform_device *pdev)
> > > >    	watchdog_init_timeout(&wdt->wdd, 0, dev);
> > > >    	/*
> > > > +	 * Kernel can pet the watchdog until user space takes over.
> > > > +	 * Start the watchdog here to make use of this feature.
> > > > +	
> > > 
> > > No, that is not what CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is about.
> > > Please see its description.
> > > 
> > > NACK.
> > > 
> > Thanks for taking a look Guenter. I thought of using
> > WATCHDOG_HANDLE_BOOT_ENABLED and infiniite open timeout as a hint to start
> > the watchdog in probe. After seeing your NACK for this patch, I guess
> > that would also would have been rejected.
> > 
> WATCHDOG_HANDLE_BOOT_ENABLED is not supposed to be used in drivers.
> It is a flag for the watchdog core. Before you bring it up, stm32_iwdg.c
> is a corner case because (presumably) the driver can not determine
> if the watchdog is running.
> 
> > Do you think we can revive this [1] to add support for watchdog pet from
> > the kernel? It would be helpful in cases where the user space has no
> > support for watchdog pet (say minimal ramdisk).
> > 
> 
> If done properly, sure. Looking at the exchange, the patch still had issues
> which I don't think were ever resolved.

Thanks. I will take a look at your review feedback on the series and
address them before sending the next revision.

> 
> Personally I would not want to rely on this, though. It won't address situations
> where userspace hangs but low level kernel interrupts still work. I think
> it is mostly useful to cover the time from loading the watchdog driver
> to starting the watchdog daemon, but even that would better be solved by
> starting the watchdog in the ROM monitor or BIOS. A minimal watchdog daemon
> would not consume that much memory, so I don't think "user space has no
> support for watchdog pet (say minimal ramdisk)" would ever be a real problem.
> Such a minimal system would probably (hopefully) be based on busybox which
> does support a watchdog.
> 

Got it. I will find ways to start the watchdog in firmware so that we
don't need anything special handling.

Thanks,
Pavan

