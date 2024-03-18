Return-Path: <linux-kernel+bounces-106689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B785287F1F4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 730B0282919
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E1C58237;
	Mon, 18 Mar 2024 21:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="K4zdPqG9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD52E57326;
	Mon, 18 Mar 2024 21:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710796942; cv=none; b=uObXgS7oujN5PN7tMBh8g3Qq6mt7xmZLKzN3KdKRM1RcTF6w8jXZa1rHWJDGboeuLdm7FtV5Wfho7HY3W/mEzH/qJWHI4gkJv+9aMIjo4llq5spEG5ghIEnZL+0UKmAeReAUPPEr9rI2clmDiYYuhCjrX6aB0vr40ok1E+6vPbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710796942; c=relaxed/simple;
	bh=LlDKgfiSyuf8Fh/e1FReYnD1l9CJgtzSn9FFuDQqTtc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2q20PpvyS3ojxfaxXeg0lFIDU1Qq3z7b8Xq4dK/gmO1kVHIRRmiXaYESauU149wtOlHYRufuVL2mYtksfC/dL/unnN6M9opitXQB0phfeYqf/kchHWOD1qn/eIIoYBoVkKkuLzRPD5XC2x7xXB5yXnYijHNbJ/XoIWcVwL8dsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=K4zdPqG9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42IKK9Dx004252;
	Mon, 18 Mar 2024 21:22:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=ygBOQxXhpxWuogwPLKyey
	VNcq57ouue1TPByBN7mZC4=; b=K4zdPqG9u0r7TPfwQ/CAjIdz36ktPosJpYD20
	lkqVPVKY+9A8Q7fq+igH+41KLw3mY9VaIKlrC1hbLRu+EmHm4VknDmOSqZjHlaUD
	dr4iLSVJMkAI5/S61O/6tOuZkTxsiDVx7vGamExUn9Xn7TncCsBq19CIjg9Q68B/
	iDJP//BDjPrYZphviqTl3xY0DEp7nZrWobjaX564Q5nhjj6nsQhEtldcCgNSKvxa
	e2nrp2YR09bo5mmgRA8fl7aNU7jpeThrluclLSLX4PowDJlLVyxpLriFkbhIWLu0
	CuLisGBtUhyMmcBJfiyrhQwG76j+VbLcm5h6MBGQq4qeEYUPA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wxndk96wu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 21:22:16 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42ILMFab025405
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 21:22:15 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 18 Mar 2024 14:22:15 -0700
Date: Mon, 18 Mar 2024 14:22:14 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>
CC: Maulik Shah <quic_mkshah@quicinc.com>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_collinsd@quicinc.com>, <quic_lsrao@quicinc.com>,
        <stable@vger.kernel.org>
Subject: Re: Re: [PATCH v4] soc: qcom: rpmh-rsc: Enhance check for VRM
 in-flight request
Message-ID: <20240318142037265-0700.eberman@hu-eberman-lv.qualcomm.com>
Mail-Followup-To: Bjorn Andersson <andersson@kernel.org>, 
	Maulik Shah <quic_mkshah@quicinc.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, quic_collinsd@quicinc.com, 
	quic_lsrao@quicinc.com, stable@vger.kernel.org
References: <20240215-rpmh-rsc-fixes-v4-1-9cbddfcba05b@quicinc.com>
 <vuyzqntyhzz5at5q7rxkix6ogavow4kltge26q62ihzhsblsuv@o43un23zaf4w>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <vuyzqntyhzz5at5q7rxkix6ogavow4kltge26q62ihzhsblsuv@o43un23zaf4w>
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XoF1lNbt33ALAIclzKzG7h4kx1YBEAjM
X-Proofpoint-ORIG-GUID: XoF1lNbt33ALAIclzKzG7h4kx1YBEAjM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403180161

On Sun, Mar 17, 2024 at 10:18:25PM -0500, Bjorn Andersson wrote:
> On Thu, Feb 15, 2024 at 10:55:44AM +0530, Maulik Shah wrote:
> > Each RPMh VRM accelerator resource has 3 or 4 contiguous 4-byte aligned
> > addresses associated with it. These control voltage, enable state, mode,
> > and in legacy targets, voltage headroom. The current in-flight request
> > checking logic looks for exact address matches. Requests for different
> > addresses of the same RPMh resource as thus not detected as in-flight.
> > 
> > Add new cmd-db API cmd_db_match_resource_addr() to enhance the in-flight
> > request check for VRM requests by ignoring the address offset.
> > 
> > This ensures that only one request is allowed to be in-flight for a given
> > VRM resource. This is needed to avoid scenarios where request commands are
> > carried out by RPMh hardware out-of-order leading to LDO regulator
> > over-current protection triggering.
> > 
> > Fixes: 658628e7ef78 ("drivers: qcom: rpmh-rsc: add RPMH controller for QCOM SoCs")
> > cc: stable@vger.kernel.org
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > Tested-by: Elliot Berman <quic_eberman@quicinc.com> # sm8650-qrd
> > Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
> > ---
> > Changes in v4:
> > - Simplify cmd_db_match_resource_addr()
> > - Remove unrelated changes to newly added logic
> > - Update function description comments
> 
> You changed things, but retained Konrad's Reviewed-by...
> 
> > - Replace Signed-off-by: with Tested-by: from Elliot
> 
> Did Elliot test v4, or did you just translate his incorrect(?) s-o-b
> from v1 into a tested-by?
> 
> We're about to write into the git history that Elliot says this version
> is tested to the best of his abilities...
> 

No, I asked for it:

https://lore.kernel.org/all/20240214105605460-0800.eberman@hu-eberman-lv.qualcomm.com/


