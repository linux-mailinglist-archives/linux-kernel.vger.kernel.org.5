Return-Path: <linux-kernel+bounces-150424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B078A9F0A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B87C285D8E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7633617108B;
	Thu, 18 Apr 2024 15:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SnDWsU68"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D0E16F8FD;
	Thu, 18 Apr 2024 15:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713455378; cv=none; b=mVdNX9Qdsw9dexNpJtns4ErozXImzV5BCy+CFcDpAhYwm78ABTy+8ipt1nxnVq3s2pfUxqmkE0+y3PGfBuxqfSmcQmg4R3hV87W2oTnamdmsEJFaQjtHxboZ+3UIyYxlDf/K/6t6Cycfz3Ehvd3ZYcrD2eealm70ZfcMxLChfR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713455378; c=relaxed/simple;
	bh=UwEg6jQHcTgWeL4xO3d8TIf8vYvHIDPpAbd7TlKkK9Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHeZagCK8Ifb6SjdpIyXSzqIxLsDS5jqpikR/YUgxDx7PxoFUk/rn3+ZeGdxhAwdYPL9TEPPncokB3MydQz2Yrj1naK/0Dvo+BN7K99guq3EEQQ3EHBb/PReeYPVnWRNgQWcHvM84ugEvmutPYszVXKT7Up+lBE3V39aunaLtjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SnDWsU68; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43I6JiOF007499;
	Thu, 18 Apr 2024 15:49:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=xDnVdRubm2YXL//ItdDE7
	olh+rPORPbRBCmmNqyZEqA=; b=SnDWsU68k87TLXy3IBt5MAPIPhXeEzEVDhxIH
	BRejN8tVvTTFK9cUUMjukaAyCmNpESQqVjegG1kuGZPhk87U4ckaTPrMnQYKYZFg
	kuRpytWviOwRj54Pg+4fF7oJg6tsOB2LUc7B7p3gBtubL8lYAGOLxfDymC5eQAcv
	LVVR4b82a/WNDq0pi/9wbeIDSg57fLYbis91bm94FzOzK09CDYsyX1myoEc/zAVz
	Vsq2DwUPtnwBXxcVYpnka+1KZhFcWPk8/vl2n2yVyVXvb2cQSAJ7kWIQ/rEa+3eB
	igjGbFBLnH60+mc3RU4vrjY6k5Uo2zmAmWbTU7XrQA4GgQNTQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xjx54h8cq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 15:49:29 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43IFnSkr009256
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 15:49:28 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 18 Apr 2024 08:49:27 -0700
Date: Thu, 18 Apr 2024 08:49:26 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Sibi Sankar <quic_sibis@quicinc.com>
CC: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jassisinghbrar@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <dmitry.baryshkov@linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_rgottimu@quicinc.com>, <quic_kshivnan@quicinc.com>,
        <conor+dt@kernel.org>, <quic_gkohli@quicinc.com>,
        <quic_nkela@quicinc.com>, <quic_psodagud@quicinc.com>
Subject: Re: [PATCH V3 2/5] mailbox: Add support for QTI CPUCP mailbox
 controller
Message-ID: <ZiFBBh+kQy6Pu3BM@hu-bjorande-lv.qualcomm.com>
References: <20240417132856.1106250-1-quic_sibis@quicinc.com>
 <20240417132856.1106250-3-quic_sibis@quicinc.com>
 <ZiA+mE3QduLxc+a5@hu-bjorande-lv.qualcomm.com>
 <b8ba5179-cb36-6b13-4244-6da1ff96c2d3@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b8ba5179-cb36-6b13-4244-6da1ff96c2d3@quicinc.com>
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VfKhppR1wgkYFVVoSwLUFTIakXyyUK0s
X-Proofpoint-ORIG-GUID: VfKhppR1wgkYFVVoSwLUFTIakXyyUK0s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_13,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxlogscore=860 bulkscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404180112

On Thu, Apr 18, 2024 at 01:01:50PM +0530, Sibi Sankar wrote:
> On 4/18/24 02:56, Bjorn Andersson wrote:
> > On Wed, Apr 17, 2024 at 06:58:53PM +0530, Sibi Sankar wrote:
> > > diff --git a/drivers/mailbox/qcom-cpucp-mbox.c b/drivers/mailbox/qcom-cpucp-mbox.c
[..]
> > 
> > > +		if (status & BIT(i)) {
> > 
> > Can't you combine the for loop and this conditional into a
> > for_each_bit_set()?
> 
> The only drawback I see here is if the number of channels increase to
> it's full capacity of 64 since for_each_set_bit expects unsigned long.
> 

It takes a unsigned long * and it can take a size > BITS_PER_LONG. But
I've not convinced myself that the bit order across two of those matches
the u64 bits.

> > 
> > > +			val = readl(cpucp->rx_base + APSS_CPUCP_RX_MBOX_CMD(i) + APSS_CPUCP_MBOX_CMD_OFF);
> > > +			chan = &cpucp->chans[i];
> > > +			spin_lock_irqsave(&chan->lock, flags);
> > 
> > Can you please add a comment here to document that the lock is taken
> > here to deal with races against client registration? (It wasn't obvious
> > to me...)
> 
> This is was put in to handle irqs after channel closure. Meaning we
> don't want to send data on a closed/empty channel.
> 

You're dealing with that through the chan->cl check below, not the lock
itself. So the lock here would be for synchronizing this code with
potentially concurrent execution of __mbox_bind_client() or e.g.
mbox_free_channel().

But if this is indeed the problem, then we're locking here to ensure
that mbox_chan_received_data() will not dereference chan->cl while it's
being modified elsewhere int he mailbox core.

If that's the case, I think this needs to be strongly documented in the
API, or perhaps better yet the lock being moved into
mbox_chan_received_data().

Regards,
Bjorn

