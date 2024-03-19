Return-Path: <linux-kernel+bounces-108052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 570D4880543
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1246D283816
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51ED39FD7;
	Tue, 19 Mar 2024 19:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dkJXUGsm"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDC724B34;
	Tue, 19 Mar 2024 19:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710875454; cv=none; b=g9VcUMr3Ko0S2bSDf81ShPNiIumODCVSoTJ1+Toek1J1d4J/bbQpG4O4VjFzWZ76eiIL5jP3GHxFA1vwy/wbFskdg6mNc1yQBUVie4+59QxbbvqB8RLQ8Mqy39s7W5dGhFB7EyG4+REc8qrXZLQhBjo8Z+wwCh28MNQ2b6MUQFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710875454; c=relaxed/simple;
	bh=UYfQzAigBaSo2tPgRsSk2yLR1FZdEOinHqV6/uG4Ogc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3u0eOvkqGzv7nyA5NF7Mp0e3xw4GRBs4ywIHxJYzf1q/172LMM1mjzuhlE9cZUHapeTAdfX7ZuRHryFtxpBWRMvmw9NneCe+EgrKs8uPyxgAjZEwOkfUUjRvl17sZ+gMjJq7f7hAmt60YTIMlS099nEkAoEqweV0kiitMorg20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dkJXUGsm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42JI8LQf032145;
	Tue, 19 Mar 2024 19:10:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=crxwogswKOFC+Q4+wYZbi
	EBobILCOLXUGq7qV+S4vF4=; b=dkJXUGsmrXrUyc3ggY1O0cDn16kgNrMvR/c5T
	Y+PZmCqYiyGgVhTaRwC0WsdfU9/fSBAvaAOmP/CM1u3R2MMPJaXtYtuXAJQjNUNi
	O/kf3LdoDdAlpkvdPXFnGngcGf4wlMtS+9XVAGZEbV8ZhF1rxRb6cCxefLK2TYjw
	8qC7ueVgJwl+b+KOaHFOVMPWCLSGXcNJswkn8vGTQXlE+Wtp1lz6j+nKDrw8DnGs
	z8Rc6etSCyPwG/N4nzzZjtvyKSgVwSwiJi1MhymA8BEERxoQUsc3z1+Lc+gfMsyJ
	YfIVCkbL23ZWby2BXfLrW8Uw1N9uEDZy6G4DH904p48My/0/A==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wyfqbg513-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 19:10:40 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42JJAd03010929
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 19:10:39 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Mar 2024 12:10:39 -0700
Date: Tue, 19 Mar 2024 12:10:37 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: jianbinz <quic_jianbinz@quicinc.com>
CC: <alexandre.belloni@bootlin.com>, <a.zummo@towertech.it>,
        <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] rtc: rtc-pm8xxx: clear the interrupt in probe
Message-ID: <20240319191037.GA3796206@hu-bjorande-lv.qualcomm.com>
References: <20240314033344.10775-1-quic_jianbinz@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240314033344.10775-1-quic_jianbinz@quicinc.com>
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: POIFQOorQQD_DUnf--BB03xTlaZhgvZ_
X-Proofpoint-GUID: POIFQOorQQD_DUnf--BB03xTlaZhgvZ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=914 clxscore=1011 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403190146

On Thu, Mar 14, 2024 at 11:33:44AM +0800, jianbinz wrote:
> If the alarm is triggered before the driver gets probed, the alarm
> interrupt will be missed and it won't be detected, so clear the
> stale interrupt in probe.
> 
> Changes in v3:

The change log goes below the '---' line below.

> *clear the interrupt in driver probe
> 
> Changes in v2:
> *Adapt the V1 patch according to the newest rtc-pm8xxx
> link to v2: https://lore.kernel.org/linux-rtc/20240124024023df15ef6e@mail.local/
> 
> Changes in v1:
> *During driver probe: read ALARM_EN, read ALARM_DATA, read RTC_RDATA,
> if (ALARM_DATA < RTC_DATA), Trigger the alarm event and clear the alarm settins
> Link to v1:https://lore.kernel.org/linux-rtc/20220321090514.4523-1-quic_jianbinz@quicinc.com/
> 
> Changes in original:
> link to original: https://lore.kernel.org/linux-rtc/YTusgJlMUdXOKQaL@piout.net/
> 
> Signed-off-by: jianbinz <quic_jianbinz@quicinc.com>

Please use your full name, both for authorship and signed-off.

Your two patches are not sent as a series, and you don't have a
cover-letter, which is expected.

Please read through go/upstream, and start using b4 for preparing your
patches, as this will help you with the practicalities.

> ---
>  drivers/rtc/rtc-pm8xxx.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
> index f6b779c12ca7..1b5a96924e57 100644
> --- a/drivers/rtc/rtc-pm8xxx.c
> +++ b/drivers/rtc/rtc-pm8xxx.c
> @@ -527,6 +527,10 @@ static int pm8xxx_rtc_probe(struct platform_device *pdev)
>  	if (rc)
>  		return rc;
>  
> +	rc = regmap_update_bits(rtc_dd->regmap, rtc_dd->regs->alarm_ctrl2, PM8xxx_RTC_ALARM_CLEAR, 1);

Unless I'm mistaken, this line is over 100 characters, please wrap it.


Please also Cc: linux-arm-msm@vger.kernel.org on your next version.

Regards,
Bjorn

> +	if (rc)
> +		return rc;
> +
>  	return 0;
>  }
>  
> -- 
> 2.17.1
> 

