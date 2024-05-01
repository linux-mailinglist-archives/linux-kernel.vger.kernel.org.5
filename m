Return-Path: <linux-kernel+bounces-164882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 711918B8471
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 05:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19B291F22D57
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 03:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C1D39FFB;
	Wed,  1 May 2024 02:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iqc7cXV6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E882F22097;
	Wed,  1 May 2024 02:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714532397; cv=none; b=dvjGTcpiDJSeU5lK5NufLwXYlCL/S0Xb4O1OHgB5OHFTDNSQEoH4KfTcGdqbiud38kiKYMdJ459XtwnWMvc3yUxh0u1cNv/YUZELTXWz5iRccdc93HsgKXOYanzGy02uMwzGIH7FSvKU2s9/0TqNzoR3WKc7OwP7axEVHUJc+CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714532397; c=relaxed/simple;
	bh=MQnN5PUuQD+tzgRsaSHWclswZAoVZ7LLD6yIhGN1XvA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ouV3xd/kkwRiFofRUDsbzmHcVsou+/QtgPbjWakReNM4+G29zwWI8aKoh23k27le83mtvq0NvBpu/H+bl4IQTfuSQgF2fdwvQI48JeFgAp2bLIQnvUFqbJkZq3tTvpOMLbjzuPec+lAijX+yaY+vsJaKWf9pHMuqAlMDuRnjAzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iqc7cXV6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4412kUFv024656;
	Wed, 1 May 2024 02:59:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=+2pVsfwpmu4Mx3VqoZ/aN
	oUk63zhgmR6SWkGMUXmiz0=; b=iqc7cXV6PF7WrC6ExDiLMN9ryWSWODbIfTPv7
	LKXDIJIkd25rlHNBCsumfrqEASi5sYPZFIE3QLb963On2xViaSRXbToqfys+fwHc
	AEth8QCVVR2ty4fvpccLxo+jnCDI5oxP34WY119LjaXVvaV0QMG12lblkM0ug5+v
	KVuhYV9cqPfFCxfy/DNFVavgPGwwwgdg3mUaJHBLwI9jWSQg/00B6lhjlrtnMF81
	PAUpE+dQcSt1Q5VeWMz9ZEF7zm7eTrK1XxGanWCRuwZmVkqZdjEDwhTV+T7zCyKH
	LwgomdgnZ4trenwVOce7+DFyVVt1u4QMO8+en+fbpjWRUi+DA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtw1hjbd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 May 2024 02:59:51 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4412xSXX007611
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 1 May 2024 02:59:28 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 30 Apr 2024 19:59:27 -0700
Date: Tue, 30 Apr 2024 19:59:26 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Chris Lew <quic_clew@quicinc.com>
CC: Sudeepgoud Patil <quic_sudeepgo@quicinc.com>, <andersson@kernel.org>,
        <mathieu.poirier@linaro.org>, <linux-kernel@vger.kernel.org>,
        <quic_deesin@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH V1] soc: qcom: smp2p: Introduce tracepoint support
Message-ID: <ZjGwDhqqe/MCKcEF@hu-bjorande-lv.qualcomm.com>
References: <20240429075528.1723133-1-quic_sudeepgo@quicinc.com>
 <172ab19b-4643-6ac0-53ab-d2d1e217171c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <172ab19b-4643-6ac0-53ab-d2d1e217171c@quicinc.com>
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WxdHsINzVHe2zT8a_15d1-NDMz_OkjV6
X-Proofpoint-ORIG-GUID: WxdHsINzVHe2zT8a_15d1-NDMz_OkjV6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_02,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 mlxlogscore=973 clxscore=1015 bulkscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405010021

On Tue, Apr 30, 2024 at 04:18:27PM -0700, Chris Lew wrote:
> On 4/29/2024 12:55 AM, Sudeepgoud Patil wrote:
> > Introduce tracepoint support for smp2p providing useful logging
> > for communication between clients.
> > 
> 
> Let's add some more description as to why these tracepoint are useful. Do
> they help us track latency? debugging information for us? for clients?

+1

> > diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
[..]
> > diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
> > index a21241cbeec7..dde8513641ae 100644
> > --- a/drivers/soc/qcom/smp2p.c
> > +++ b/drivers/soc/qcom/smp2p.c
> > @@ -20,6 +20,9 @@
> >   #include <linux/soc/qcom/smem_state.h>
> >   #include <linux/spinlock.h>
> > +#define CREATE_TRACE_POINTS
> > +#include "trace-smp2p.h"
> > +
> >   /*
> >    * The Shared Memory Point to Point (SMP2P) protocol facilitates communication
> >    * of a single 32-bit value between two processors.  Each value has a single
> > @@ -191,6 +194,7 @@ static void qcom_smp2p_do_ssr_ack(struct qcom_smp2p *smp2p)
> >   	struct smp2p_smem_item *out = smp2p->out;
> >   	u32 val;
> > +	trace_smp2p_ssr_ack(smp2p->remote_pid);
> >   	smp2p->ssr_ack = !smp2p->ssr_ack;
> >   	val = out->flags & ~BIT(SMP2P_FLAGS_RESTART_ACK_BIT);
> > @@ -213,6 +217,7 @@ static void qcom_smp2p_negotiate(struct qcom_smp2p *smp2p)
> >   			smp2p->ssr_ack_enabled = true;
> >   		smp2p->negotiation_done = true;
> > +		trace_smp2p_negotiate(smp2p->remote_pid, smp2p->ssr_ack_enabled);
> 
> since this tracepoint is for negotiating, maybe we should capture all of the
> features (out->features) instead of just the ssr_ack feature.
> 

Perhaps we can use __print_flags() in TP_printk() for that, it will
attempt to resolve the bits and if it fails include the numeric value.

> >   	}
> >   }
[..]
> > diff --git a/drivers/soc/qcom/trace-smp2p.h b/drivers/soc/qcom/trace-smp2p.h
[..]
> > +TRACE_EVENT(smp2p_ssr_ack,
> > +	TP_PROTO(unsigned int remote_pid),
> 
> Is there any way we can map the remote pid's to a string? I feel like the
> tracepoints would be more useful if they called out modem, adsp, etc instead
> of an integer value.
> 

And __print_symbolic() for this one.

Regards,
Bjorn

