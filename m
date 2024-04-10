Return-Path: <linux-kernel+bounces-139172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A77289FF77
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAD6F1C22E4B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F011802A5;
	Wed, 10 Apr 2024 18:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FrR0NnL3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF96017F36E;
	Wed, 10 Apr 2024 18:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712772701; cv=none; b=fF+2d1SqOYk3hAtPsO411IXuocRTxA2Xz5gRHiwcOS95H2LOXvDTLKYZ2H5j4ZflpCVjo4dQutECD0zJNmGl0DvhLWmKgR1YH5Qfa8D3jjv2M9H1kyi+nDQmtmCMEHxvjHHnqYgSoga1mRbCMsoWIX3TpA+ZKua3R1LOOinfkqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712772701; c=relaxed/simple;
	bh=lgXdpN79bNoWATp0JHo4jB5e5GypCmYkRd1tuE9N7+Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wh2pRm/DF9HvvL8lbjHJ15QdaqwBHLkk/KyjHE+b8U4fGcpHSsStKxZ9WwxKpctQTtEDaXoZYM6OSjcmXYl81nACYlFaHHhLrX9QQJd67vp54TMeaNE7Yvbyp6sHjEJkXcYI+2ou1GMa6HCMZfTP9BfdTkMC6q+Efld+PuizWlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FrR0NnL3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43AFrkQB010791;
	Wed, 10 Apr 2024 18:11:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=0x/BPTPCPjZNvNsz9aiQ+
	J5kwa0Uy5slWV4+66LlQd8=; b=FrR0NnL3baFbWiMeT7gL0MYmSsiw1m6XEDxTL
	W2V5mKz6wGEtCmB0J8VPJYsonASzoI75YK0VNl+WxkkYK0Xkkw7BIcukrNB36pA2
	3SOa+EfINtMtaH1Sgj7V2+s2fBzYsUd7+pQKyfzO+avBeeJBCXVwomXO+WleWLZO
	tBonLx4z0i7PjixRiIORm7YZqRpw8lK/eRYPYSV08H1P/ETFMJ+PHwsEsAxwFh+A
	3ICwlfmDsyXAZpUfTIri5sOFmQ7ZVvAYOvnE2hCBDTbp5fQ+TwFeerQxTCrDsPde
	PI6si6tLQO2IqxD/7wXEvlJ63eIS2sNe136r/Gdv2OpDsqw+A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xdkv8m4te-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 18:11:34 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43AIBXDS004675
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 18:11:33 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 10 Apr 2024 11:11:32 -0700
Date: Wed, 10 Apr 2024 11:11:31 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soc: qcom: fix module autoloading
Message-ID: <ZhbWU0lk4mNBv1OE@hu-bjorande-lv.qualcomm.com>
References: <20240410164045.233198-1-krzk@kernel.org>
 <22f5eb76-8f81-46ea-b0a7-5f1d231e7833@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <22f5eb76-8f81-46ea-b0a7-5f1d231e7833@linaro.org>
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4n_Ztwl9loTnczuji4pyqzzWEWZdtg7e
X-Proofpoint-GUID: 4n_Ztwl9loTnczuji4pyqzzWEWZdtg7e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 clxscore=1011 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=814 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404100132

On Wed, Apr 10, 2024 at 07:53:32PM +0200, Konrad Dybcio wrote:
> 
> 
> On 4/10/24 18:40, Krzysztof Kozlowski wrote:
> > Add MODULE_DEVICE_TABLE(), so the module could be properly autoloaded
> > based on the alias from of_device_id table.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> 
> These were omitted intentionally, as these are both debug drivers.
> 

Makes sense to me, could we have a comment added that clarifies this
intention?

> Perhaps we could mkdir drivers/soc/qcom/debug to make this clearer
> 

Not sure if that is necessary, and IMO it wouldn't convey that
MODULE_DEVICE_TABLE() was omitted intentionally.

Regards,
Bjorn

