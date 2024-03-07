Return-Path: <linux-kernel+bounces-95871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B019A87545A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4A061C21885
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873AA12FF75;
	Thu,  7 Mar 2024 16:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SUnav6ZE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBABE1BDDB;
	Thu,  7 Mar 2024 16:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709829702; cv=none; b=jpejH92KV4ej8TL3qMdnhtRFEeG2MPYODip4zSncw76yhzmJBirAbrpxCRVh5yajKcBc7bFllisVCYF7a/qUC/lVFVLxUznl+beeHstOuf2IRfepd36rwhsLOCIAg9D+SIbHOJryW5/wwPSL+00w5wM3t9EX0nXbWtZkKebhioM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709829702; c=relaxed/simple;
	bh=/1yv2voYazdhfYiCba0+H2ZUZDL9rA+8uY9mleYG4cw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKUlin+NxqXNM2HrOMwQj7QYI6nagz1VvYcddR1/RkOA21RaIJG31rLAJs0fOvKnGcSt6VztaBKU8mmfYgY1f/qjXyNR5VJZFODduYmt0TRwCOf4mPVXmiBBi3WbNWl0+7aD4swVazwrr4YAY2AtwxelSvmRkMA/7uhmmT2CRE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SUnav6ZE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 427BrCPO009368;
	Thu, 7 Mar 2024 16:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=IhCM9GWGGCh+z/XvnkdtX
	dFWqYJpK598AUrSkFnXIWc=; b=SUnav6ZEvKO+0hU8fPqiO+h7HIIcnW36ev51o
	UMXjUxg6jwvYKHiD464eS+HgPtJPuVQ8W4DtyRLPC9VGyA8vSOhOHXgK5eBBndH8
	aFA4Bs8jC22Biq7i9PRP8uBJ7434r5UcuRfho+dpX0O+j27kpEQfumffg2m3ywTs
	bFYHWe4j1L+tHsZkqqMAgjzmdz8v4L5XMJPRv13a0DdmQAZkjPkQD0pnHZp+kvVC
	BFlYVRT4Z9/VNiuIYhAJY7H9rg1nfv6sMvHL3Hwuc0tYFkDX1w2xu4daMLYyP3AY
	K2c429Gza+Xtj6KaQUqnot0p+tcGfOpoIatqoEl7pkkczIowQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wqd3d18vp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 16:41:17 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 427GfGZW010824
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Mar 2024 16:41:16 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 7 Mar 2024 08:41:14 -0800
Date: Thu, 7 Mar 2024 08:41:14 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
CC: Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla
	<srinivas.kandagatla@linaro.org>,
        Murali Nalajal <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Carl van Schaik
	<quic_cvanscha@quicinc.com>,
        Philip Derrin <quic_pderrin@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Jonathan Corbet
	<corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Fuad
 Tabba" <tabba@google.com>,
        Sean Christopherson <seanjc@google.com>,
        "Andrew
 Morton" <akpm@linux-foundation.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>
Subject: Re: Re: [PATCH v17 07/35] gunyah: rsc_mgr: Add resource manager RPC
 core
Message-ID: <20240307083827092-0800.eberman@hu-eberman-lv.qualcomm.com>
Mail-Followup-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>, 
	Alex Elder <elder@linaro.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Murali Nalajal <quic_mnalajal@quicinc.com>, Trilok Soni <quic_tsoni@quicinc.com>, 
	Carl van Schaik <quic_cvanscha@quicinc.com>, Philip Derrin <quic_pderrin@quicinc.com>, 
	Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>, Jonathan Corbet <corbet@lwn.net>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Fuad Tabba <tabba@google.com>, Sean Christopherson <seanjc@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mm@kvack.org
References: <20240222-gunyah-v17-0-1e9da6763d38@quicinc.com>
 <20240222-gunyah-v17-7-1e9da6763d38@quicinc.com>
 <20240307153843.GC1695516@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240307153843.GC1695516@quicinc.com>
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0-XBk_3tQgGP4ZavfFBD2TJdDBfBlRCf
X-Proofpoint-GUID: 0-XBk_3tQgGP4ZavfFBD2TJdDBfBlRCf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_13,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403070114

On Thu, Mar 07, 2024 at 09:08:43PM +0530, Srivatsa Vaddagiri wrote:
> * Elliot Berman <quic_eberman@quicinc.com> [2024-02-22 15:16:30]:
> 
> > The resource manager is a special virtual machine which is always
> > running on a Gunyah system. It provides APIs for creating and destroying
> > VMs, secure memory management, sharing/lending of memory between VMs,
> > and setup of inter-VM communication. Calls to the resource manager are
> > made via message queues.
> > 
> > This patch implements the basic probing and RPC mechanism to make those
> > API calls. Request/response calls can be made with gh_rm_call.
> > Drivers can also register to notifications pushed by RM via
> > gh_rm_register_notifier
> > 
> > Specific API calls that resource manager supports will be implemented in
> > subsequent patches.
> > 
> > Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> 
> Left a minor comment below. LGTM otherwise.
> 
> Reviewed-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
> 
> > +static irqreturn_t gunyah_rm_rx(int irq, void *data)
> > +{
> > +	enum gunyah_error gunyah_error;
> > +	struct gunyah_rm_rpc_hdr *hdr;
> > +	struct gunyah_rm *rm = data;
> > +	void *msg = &rm->recv_msg[0];
> > +	size_t len;
> > +	bool ready;
> > +
> > +	do {
> > +		gunyah_error = gunyah_hypercall_msgq_recv(rm->rx_ghrsc.capid,
> > +							  msg,
> > +							  sizeof(rm->recv_msg),
> > +							  &len, &ready);
> > +		if (gunyah_error != GUNYAH_ERROR_OK) {
> > +			if (gunyah_error != GUNYAH_ERROR_MSGQUEUE_EMPTY)
> > +				dev_warn(rm->dev,
> > +					 "Failed to receive data: %d\n",
> > +					 gunyah_error);
> > +			return IRQ_HANDLED;
> > +		}
> > +
> > +		if (len < sizeof(*hdr)) {
> > +			dev_err_ratelimited(
> > +				rm->dev,
> > +				"Too small message received. size=%ld\n", len);
> > +			continue;
> 
> In practice we should never hit this condition, in case we do encounter, do you
> see a reason why continue is preferred over simply breaking the loop?
> 

There might be more messages to read, which we would not otherwise read.
Since those messages might be parseable, I'd rather try to recover than
break communication with RM.

As you mention, we should never encounter this condition. The guard is
to avoid reading garbage values.

> > +		}
> > +
> > +		hdr = msg;
> > +		if (hdr->api != RM_RPC_API) {
> > +			dev_err(rm->dev, "Unknown RM RPC API version: %x\n",
> > +				hdr->api);
> > +			return IRQ_HANDLED;
> > +		}
> > +
> > +		switch (FIELD_GET(RM_RPC_TYPE_MASK, hdr->type)) {
> > +		case RM_RPC_TYPE_NOTIF:
> > +			gunyah_rm_process_notif(rm, msg, len);
> > +			break;
> > +		case RM_RPC_TYPE_REPLY:
> > +			gunyah_rm_process_reply(rm, msg, len);
> > +			break;
> > +		case RM_RPC_TYPE_CONTINUATION:
> > +			gunyah_rm_process_cont(rm, rm->active_rx_message, msg,
> > +					       len);
> > +			break;
> > +		default:
> > +			dev_err(rm->dev,
> > +				"Invalid message type (%lu) received\n",
> > +				FIELD_GET(RM_RPC_TYPE_MASK, hdr->type));
> > +			return IRQ_HANDLED;
> > +		}
> > +	} while (ready);
> > +
> > +	return IRQ_HANDLED;
> > +}

