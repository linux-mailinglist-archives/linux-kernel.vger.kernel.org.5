Return-Path: <linux-kernel+bounces-132336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B147F899354
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 04:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 669871F250DC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 02:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72247179BD;
	Fri,  5 Apr 2024 02:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NyNLyw/v"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFF9200C7;
	Fri,  5 Apr 2024 02:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712285147; cv=none; b=B0NhvgbJI/RF4Y0zrHwGa+/zcqXcqfLFBJUv+KmMdJAoecOeZ5aOLXeKREzfElngzOPgkGUgxPfdyGJE3BbhNOLR5wazPG7bf5DowH9Tkmw+yUNaM4/3kfnGkjy1A+xcGoy5vcvxx8FXLqEX0ZJOiwIqi15MjRoRjF704TDoRlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712285147; c=relaxed/simple;
	bh=qqV0FguGCTgmP3Zlqv/SIQDUZMAcngfLSumSuiNyRAw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLYW60sQrNpk0fnWYmrZ7RwtzH/m9kvshCjKFMK4pqEjwVlMsNu63PHIGBWNyjXDjy1ZvA4TRqrQWmdxbUc83Pj1q6A9kiJWvCux1CKZiI9oUO+tRU8+c1Wf38eQTj8D5kcGCDlLClVKkY/OSu9+kpDqxSi851rgZu1FcvHaRZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NyNLyw/v; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4352f5Qh019527;
	Fri, 5 Apr 2024 02:45:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=bKdudp4O3Z4sw6Qonpwqy
	Pii2xiamxAolShtYA4Nnmo=; b=NyNLyw/v2Wg8hb/VrTOgpBobmInm/dJyptHzX
	c1jYEEbMl1V2pDBClQZic+ZyhqX8Ylwh7QR6CqycSAN1Dz00Jti/bxOehwXg4d7j
	ka7pSSxpkc4LbvNwBDJfjzPnzb1MdsGG17sXaUVjnz8cKHBpNh5zYa6uPvIgIqsV
	Jl9C5w8DfSq9L9WQC6ad492s0V8f/ZUU/izx6BaZzv0hg5hpSnZ6Prfw6GV0u2fm
	/J79gI3sAdGaGzRrzJba8kjRP4ZndyGuikRLoHBnP1XJECOfnh7GZSu4DUvGsu6O
	rJw6zvxpxFbpuxFVStNoOBE1NPA0h14UeAGBovo1IFFJcZblA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xa8fc00vt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 02:45:39 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4352jcJG025484
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 02:45:38 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 4 Apr 2024 19:45:38 -0700
Date: Thu, 4 Apr 2024 19:45:37 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: jianbin zhang <quic_jianbinz@quicinc.com>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Alexandre Belloni
	<alexandre.belloni@bootlin.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4 1/2] rtc-pm8xxx: clear the triggered alarm interrupt
 during driver probe
Message-ID: <Zg9l0cTBgoibIaDQ@hu-bjorande-lv.qualcomm.com>
References: <20240401-fix-rtc-alarm-which-fired-before-driver-probe-not-be-cleard-v1-0-aab2cd6ddab8@quicinc.com>
 <20240401-fix-rtc-alarm-which-fired-before-driver-probe-not-be-cleard-v1-1-aab2cd6ddab8@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240401-fix-rtc-alarm-which-fired-before-driver-probe-not-be-cleard-v1-1-aab2cd6ddab8@quicinc.com>
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Zr8u3Q0b5AUQp6yt-TjDjfG8Py73mOpe
X-Proofpoint-ORIG-GUID: Zr8u3Q0b5AUQp6yt-TjDjfG8Py73mOpe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_01,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404050019

On Mon, Apr 01, 2024 at 09:56:29AM +0800, jianbin zhang wrote:

Sorry, I think the patch looks good now, but the subject prefix
(rtc-pm8xxx) does not match other changes to this file.

> If the alarm is triggered before the driver gets probed, the alarm interrupt
> will be missed and it won't be detected, and the stale alarm settings will
> be still retained because of not being cleared.
> 
> Issue reproduce step:
> (1) set the alarm and poweroff the device
> (2) alarm happens and the device boots
> (3) poweroff the device again
> (4) alarm irq not be cleard, device boots again
> 
> the fixing here is clear the interrupt during the step(3) unconditionally.
> 
> Signed-off-by: jianbin zhang <quic_jianbinz@quicinc.com>
> ---
> Changes in v4:
> - add the cover letter
> - modify the patch to conform to the specification
> 
> Changes in v3:
> - clear the interrupt in driver probe unconditionally
> - link: https://lore.kernel.org/linux-rtc/20240319191037.GA3796206@hu-bjorande-lv.qualcomm.com/T/#t

These are expected to be links to the previous revisions of your patch,
not people's answers.

Please consult go/upstream and switch to b4 for the future, which does
this automatically for you. Please also use the internal review list!

Regards,
Bjorn

> 
> Changes in v2:
> - Adapt the V1 patch according to the newest rtc-pm8xxx
> - link: https://lore.kernel.org/linux-rtc/20240124024023df15ef6e@mail.local/
> 
> Changes in v1:
> - fixing is as below logic, During driver probe: read ALARM_EN, read ALARM_DATA, read RTC_RDATA,
>   if (ALARM_DATA < RTC_DATA), Trigger the alarm event and clear the alarm settins
> - link: https://lore.kernel.org/linux-rtc/20220321090514.4523-1-quic_jianbinz@quicinc.com/
> 
> Changes in original:
> - link to original: https://lore.kernel.org/linux-rtc/YTusgJlMUdXOKQaL@piout.net/
> ---
>  drivers/rtc/rtc-pm8xxx.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
> index f6b779c12ca7..e4e2307445cf 100644
> --- a/drivers/rtc/rtc-pm8xxx.c
> +++ b/drivers/rtc/rtc-pm8xxx.c
> @@ -527,6 +527,11 @@ static int pm8xxx_rtc_probe(struct platform_device *pdev)
>  	if (rc)
>  		return rc;
>  
> +	rc = regmap_update_bits(rtc_dd->regmap, rtc_dd->regs->alarm_ctrl2,
> +					  PM8xxx_RTC_ALARM_CLEAR, 1);
> +	if (rc)
> +		return rc;
> +
>  	return 0;
>  }
>  
> 
> -- 
> 2.43.2
> 

