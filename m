Return-Path: <linux-kernel+bounces-45809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B08B1843680
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBFA91C22819
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAC93E494;
	Wed, 31 Jan 2024 06:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hqeI0xKU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D423E479;
	Wed, 31 Jan 2024 06:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706681837; cv=none; b=m4kPcDjVvj7Ybx9SoRj3th9Jmsy7wHCTmOAzdKCDxEyi6nZ525pBkumG/qahZda6oGq/3yO7OnmwFO6a5hJzTZQPVqvPjfWe1CIniUlHFU2+0D+clsiUJ3Op0NjmaeSk3tlIo9YNjruolAh+vlskM5A2e+TTxh3+6es6FMGJOSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706681837; c=relaxed/simple;
	bh=6u0A0dodxOKmius8q/eiQ7I4KMI7Wv44bJDRdBK0674=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKNqTYKTTWyTnNJzd87uJ4haD7+DRWs04XdRBkck/dFmPOoFBpOpjivUyA0TKjvzQlnx6XsBHR9eMmq7sutqrxWv4/0pp5o9L7/dBor+JVQD3Oc4BUPHrv6doXeHDu2L7xTS4BkDfDpTgiPpcabSqjpv1dVrdrwkC6h7dr/BPTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hqeI0xKU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40V2hwRW005740;
	Wed, 31 Jan 2024 06:16:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=yKSfpvugHf+JQ0J3LtbX8
	a2Mm8cLaRBEPpgaXA2yC/k=; b=hqeI0xKU5L2CCU2zGqda38OUGugldQayqHHpe
	lQ/yZHeOrXtJlL23LOq58ItjZJP3fHMluWty0EdWucP55wVV/LihyrZ6Tt1uc4ra
	rLjtcrKzosMVhbr+gHlIj50Qqn4y3lAMYTZwXBOoNP2X6z9/NUCLaCBfT1E0BtQJ
	FF0fGEa6aldv1DG/swXY1See8wQrSdLOC9XoJuFLQN51mF3xEHqz2kxE6W4BmbyD
	bFD7mM7J+1tNURO7B0RFxgGiI75tg2C8i5Vi0WAe05bqyEbWf8+d3C/rlgPHLbaO
	sW8XP9DH/eNPxd4b3bdq3h/teAQ8YOKrP+Fa29llUVLuNcRkQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vy9nk8v67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 06:16:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40V6GouX028711
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 06:16:50 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 30 Jan 2024 22:16:47 -0800
Date: Wed, 31 Jan 2024 11:46:44 +0530
From: Pavan Kondeti <quic_pkondeti@quicinc.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Wim Van
 Sebroeck" <wim@linux-watchdog.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Mukesh Ojha
	<quic_mojha@quicinc.com>
Subject: Re: [PATCH] watchdog: qcom: Start the watchdog in probe
Message-ID: <cfaaed23-8f59-4447-af0b-b94b35ce68ba@quicinc.com>
References: <20240131-qcom-wdt-start-probe-v1-1-bee0a86e2bba@quicinc.com>
 <1a996038-bcc7-4c0f-8f27-ca36a2eb9d3d@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1a996038-bcc7-4c0f-8f27-ca36a2eb9d3d@roeck-us.net>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IK2kdITIGZ0pKDu6r-2FdvMqQkk6KcDI
X-Proofpoint-ORIG-GUID: IK2kdITIGZ0pKDu6r-2FdvMqQkk6KcDI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_02,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 spamscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 clxscore=1015
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401310046

On Tue, Jan 30, 2024 at 10:01:15PM -0800, Guenter Roeck wrote:
> On 1/30/24 20:15, Pavankumar Kondeti wrote:
> > When CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is enabled, kernel can pet the
> > watchdog until user space takes over. Make use of this feature and
> > start the watchdog in probe.
> > 
> > Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
> > ---
> >   drivers/watchdog/qcom-wdt.c | 6 +++++-
> >   1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
> > index 9e790f0c2096..4fb5dbf5faee 100644
> > --- a/drivers/watchdog/qcom-wdt.c
> > +++ b/drivers/watchdog/qcom-wdt.c
> > @@ -276,12 +276,16 @@ static int qcom_wdt_probe(struct platform_device *pdev)
> >   	watchdog_init_timeout(&wdt->wdd, 0, dev);
> >   	/*
> > +	 * Kernel can pet the watchdog until user space takes over.
> > +	 * Start the watchdog here to make use of this feature.
> > +	
> 
> No, that is not what CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is about.
> Please see its description.
> 
> NACK.
> 
Thanks for taking a look Guenter. I thought of using
WATCHDOG_HANDLE_BOOT_ENABLED and infiniite open timeout as a hint to start
the watchdog in probe. After seeing your NACK for this patch, I guess 
that would also would have been rejected.

Do you think we can revive this [1] to add support for watchdog pet from
the kernel? It would be helpful in cases where the user space has no
support for watchdog pet (say minimal ramdisk).

[1]
https://lore.kernel.org/linux-watchdog/20210924133509.3454834-1-f.suligoi@asem.it/#t

