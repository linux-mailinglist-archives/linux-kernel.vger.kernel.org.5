Return-Path: <linux-kernel+bounces-132341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3B789935D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 04:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57ACA2836E3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 02:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EC9219ED;
	Fri,  5 Apr 2024 02:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dbBRh/0z"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE83D1799D;
	Fri,  5 Apr 2024 02:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712285236; cv=none; b=RNVfV7oWeDijXIycDOMv7+pZrZVE6HAwH3WxgOJMaRPAPlYs+HkXYRXbdbNFzYnSXoNPxTrI4FX98O2T4ddWWiTXOgaEo1woC5upHstLnmW1vqRBZ1ok/krJ4QgGdkCcyKNC2+Bi3iIsqFFQ8yiV8e5qb6OnPw5klhqb1/R1mjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712285236; c=relaxed/simple;
	bh=wBv65L9hzKyYfs1C1huLb7fG9q+nSSzcBwhEwfzOwG8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDVKE/C73p4GlEdxq8spaLYPRw+Ym8GbmgQ+/l3Ur8sjKXR41PvPZEPJN/Giq8PaOvyCJPdFkpo/OgGDhKL4NDBwroDsrTT6rsNAhpHv+bqZv9vtot7Y7Af9SVvF6m8clGeeG/E36ZMdJWpgp4claBv6YKpGzhP0hzqMhOt52PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dbBRh/0z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4351rhNg002845;
	Fri, 5 Apr 2024 02:47:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=uZmR3IxZAMghnqIZ+nWXT
	+Q4Kb5D1wfuQ7GlN09EhNU=; b=dbBRh/0zZxfNQSXst9iYqGxEBuCRISQhOyALi
	XrxBkIZOAh2KwBzEgJEa8WIujoqfe2NdMXMOJY1G8ig2ePnWmmHkIRUB73ag6JiM
	OiFL7BwOZMlrYSF9F5SVW3NNe/JCenoEnZNub0wya+enHtKAXNksznbdSFL07ev9
	zCP40tHWepTIy9m4Fma9+NoarBA0ro68zXJ1sn2NtArZMbdAXPbgWqk6VO8UUopj
	J9nC7lLHmnKnxFdHk6j9pwN5f/37ZUHZ80iXiZLYneLeuueXrCXwcn+ULen0O2yN
	g6Wdd69UyFuCiRfFdDkI4zwvQbw3/rwsPgmSF8xl6yj+BuU5Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xa4ej8cjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 02:47:09 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4352l8ON027698
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 02:47:08 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 4 Apr 2024 19:47:08 -0700
Date: Thu, 4 Apr 2024 19:47:06 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: jianbin zhang <quic_jianbinz@quicinc.com>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Alexandre Belloni
	<alexandre.belloni@bootlin.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4 2/2] rtc-pm8xxx: Correct the value written into the
 PM8xxx_RTC_ALARM_CLEAR
Message-ID: <Zg9mKnPrhTTNafdb@hu-bjorande-lv.qualcomm.com>
References: <20240401-fix-rtc-alarm-which-fired-before-driver-probe-not-be-cleard-v1-0-aab2cd6ddab8@quicinc.com>
 <20240401-fix-rtc-alarm-which-fired-before-driver-probe-not-be-cleard-v1-2-aab2cd6ddab8@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240401-fix-rtc-alarm-which-fired-before-driver-probe-not-be-cleard-v1-2-aab2cd6ddab8@quicinc.com>
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vOj5pO2_65fYxxyJEZhV-k4xuJhsRmMy
X-Proofpoint-GUID: vOj5pO2_65fYxxyJEZhV-k4xuJhsRmMy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_01,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 clxscore=1015 adultscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404050019

On Mon, Apr 01, 2024 at 09:56:30AM +0800, jianbin zhang wrote:
> Writing 1 to the PM8xxx_RTC_ALARM_CLEAR register is expected to clear
> the triggered alarm status. In patch v2, the value written to the

I'm not sure what "in patch v2" refers to here.

Also, as with patch 1, please fix your subject line and use internal
review list.

Regards,
Bjorn

> PM8xxx_RTC_ALARM_CLEAR register in the trigger function is incorrectly
> written as 0. So correct the value written to PM8xxx_RTC_ALARM_CLEAR
> register into 1.
> 
> Signed-off-by: jianbin zhang <quic_jianbinz@quicinc.com>
> ---
> Changess in v4:
> - add the cover letter
> - modify the patch to conform to the specification
> 
> Changes in v3:
> - Correct the value written into the PM8xxx_RTC_ALARM_CLEAR to 1.
> - link: https://lore.kernel.org/linux-rtc/20240319191216.GB3796206@hu-bjorande-lv.qualcomm.com/T/#t
> 
> Changes in v2:
> - Switch to using regmap_update_bits() instead of open coding
>   read-modify-write accesses.
> - link: https://lore.kernel.org/lkml/20230202155448.6715-4-johan+linaro@kernel.org/
> 
> Changes in v1:
> -link: https://lore.kernel.org/linux-rtc/20230126142057.25715-4-johan+linaro@kernel.org/
> ---
>  drivers/rtc/rtc-pm8xxx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
> index e4e2307445cf..806c99cdac9a 100644
> --- a/drivers/rtc/rtc-pm8xxx.c
> +++ b/drivers/rtc/rtc-pm8xxx.c
> @@ -391,7 +391,7 @@ static irqreturn_t pm8xxx_alarm_trigger(int irq, void *dev_id)
>  
>  	/* Clear alarm status */
>  	rc = regmap_update_bits(rtc_dd->regmap, regs->alarm_ctrl2,
> -				PM8xxx_RTC_ALARM_CLEAR, 0);
> +				PM8xxx_RTC_ALARM_CLEAR, 1);
>  	if (rc)
>  		return IRQ_NONE;
>  
> 
> -- 
> 2.43.2
> 

