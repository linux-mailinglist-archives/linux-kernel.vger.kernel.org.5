Return-Path: <linux-kernel+bounces-36119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B81839BDF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C60B81F27CCB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F384F212;
	Tue, 23 Jan 2024 22:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lXBtnw+3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0663B4F201;
	Tue, 23 Jan 2024 22:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706047822; cv=none; b=Oz48J+8L74KGkgEShejbkoyKp8jw6dksadPf9124JCB39Fj3m75UpOX9BLlg3nyVmO+zSxQUCjteSO80qjmWJApgqYBhdds1P7JFCmsTXW1743JJi3kbD3C/klK3HrGMS0kqzOz8UcBkmdtYyNONuZ4fdb5ELHXMB2a4+QhBd1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706047822; c=relaxed/simple;
	bh=4tLvgtW9phV6f8odf0il9TWr49sI69U76al3modxrbs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkhCeqODo7jp41j4Pw83UBOXp8GRKNPHE2t383Wtaz5zO09DCLKMIqzCe2cTsWboZi2RoOBhk8m73fHiEYPljOYR3E6tcJoppDYbK9PWccC87DiNOItEsLwru39BhePqOQUHs4hnRZTirlCcjw5nuUJyQlAXvyTfQeJs+3lwTw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lXBtnw+3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40NKvwjl024439;
	Tue, 23 Jan 2024 22:10:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=bMUGP/ExetbQlmoXaOtIF
	/n/k5ZMkOe7YT4/9Tx2TRE=; b=lXBtnw+3NINvG0kz8cksz6lSjMy12Huo61tvD
	EiP86dOOImKlLThEVW2VrWhiDMji3D0YHgVA9tfXT95HYmEoHlyPsM5gQYy2eLI6
	b2Mfh2pOxc5yNlrQ/TEe0wZZIX80TPQcC4DlZsH9ZoV/J/AH4Wl9C5Py3UOsP3V2
	27X3bErqnCx5jglbFp1lCPUi7suKmOVTCM+26UjiWK8ELCgRMdM9xTN8HZkj8AVD
	oUY59ONOwYi58mjMqU1GqyIWzVBqBGdX0bCaPfiHQci5WhMXg62k9X+CoVE3njaV
	YdegOHoJtvDFtOuS44Tj2NAWBZ0f1VLHoDAKNhMDl+IeOk8Jg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vtmgwg5ub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 22:10:16 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40NMAGgZ023105
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 22:10:16 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 23 Jan 2024 14:10:15 -0800
Date: Tue, 23 Jan 2024 14:10:14 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Chris Lew <quic_clew@quicinc.com>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soc: qcom: aoss: Add tracepoints in qmp_send()
Message-ID: <20240123221014.GG2936378@hu-bjorande-lv.qualcomm.com>
References: <20240117-qcom-aoss-tracepoints-v1-1-4f935920cf4b@quicinc.com>
 <02dc2748-e73d-f565-9879-6a05e84cbd8b@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <02dc2748-e73d-f565-9879-6a05e84cbd8b@quicinc.com>
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FBBPbl3TJbuz1fzTOxSoVcJMpshJVUq1
X-Proofpoint-ORIG-GUID: FBBPbl3TJbuz1fzTOxSoVcJMpshJVUq1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_13,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 impostorscore=0 spamscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401230164

On Tue, Jan 23, 2024 at 10:54:16AM -0800, Chris Lew wrote:
> 
> 
> On 1/17/2024 7:52 PM, Bjorn Andersson wrote:
> > @@ -235,6 +238,8 @@ int qmp_send(struct qmp *qmp, const char *fmt, ...)
> >   	mutex_lock(&qmp->tx_lock);
> > +	trace_aoss_send(buf);
> > +
> >   	/* The message RAM only implements 32-bit accesses */
> >   	__iowrite32_copy(qmp->msgram + qmp->offset + sizeof(u32),
> >   			 buf, sizeof(buf) / sizeof(u32));
> > @@ -256,6 +261,8 @@ int qmp_send(struct qmp *qmp, const char *fmt, ...)
> >   		ret = 0;
> >   	}
> > +	trace_aoss_send_done(buf, ret);
> > +
> 
> As a side note, another place where we've traced before is on the receiving
> irq to get the full timing of how long AOSS takes to process a command. I
> think we've discussed this in the past and decided that we can use kprobes
> if that need occurs.
> 

Right, these two tracepoints would not provide an accurate measurement
for the that time. But as we discussed, we can use this in combination
with other events to acquire such measurements.

> >   	mutex_unlock(&qmp->tx_lock);
> >   	return ret;
> > diff --git a/drivers/soc/qcom/trace-aoss.h b/drivers/soc/qcom/trace-aoss.h
> > new file mode 100644
> > index 000000000000..48cd3f0f4cb8
> > --- /dev/null
> > +++ b/drivers/soc/qcom/trace-aoss.h
> > @@ -0,0 +1,48 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> > + */
> > +
> > +#undef TRACE_SYSTEM
> > +#define TRACE_SYSTEM qcom_aoss
> > +
> > +#if !defined(_TRACE_RPMH_H) || defined(TRACE_HEADER_MULTI_READ)
> > +#define _TRACE_RPMH_H
> 
> Any Reason for this to be _TRACE_RPMH_H instead of _TRACE_AOSS_H?
> 

That's what copy-paste gave me... Thanks for spotting that!

Regards,
Bjorn

