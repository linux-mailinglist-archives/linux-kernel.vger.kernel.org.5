Return-Path: <linux-kernel+bounces-95826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFF1875384
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4C9F1F24078
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C0012FB15;
	Thu,  7 Mar 2024 15:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PewkiV9M"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A53B12FB02;
	Thu,  7 Mar 2024 15:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709825968; cv=none; b=uvIxnu3FiI5zWUga8Jy3JfxWASx3wRMSz36RtZsJNcYfyhAYXpNTonHYMHvYicQ9cf6uHgQ8ceBkrbkBd5ghzqP9dOoide0xxckeCU9KTrhmNqYWd/9CKm1BAY/Kdq504d5SJgcrAKHy1wfPHlH9PhQbP+YzPC9Nnj4zk6vnKKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709825968; c=relaxed/simple;
	bh=x4fzYeDENcTUx3XNmtUKgesKg5aoTwEyjOQLJxwmdcM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSK0lJv5ZxYbMJChAp6YDJUng5NLGdvrpg6EE7tPeI7oEoJ1LUznxZfvrLg4/DcYprMYgRjS2909lvvSJIl+Jb+zxvwREGamsSUW19G6pXWWyXz6qdWy+/eJ2VqIqsWsD8TuzkU2Om26C440wx71O2iuc9cxy4mql8DubtB/bn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PewkiV9M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 427ALcsM012641;
	Thu, 7 Mar 2024 15:39:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:reply-to:references
	:mime-version:content-type:in-reply-to; s=qcppdkim1; bh=5nx7YKDK
	UKYaf+RGFR3mjyRftZOQ0lMCWnwUnwRPBmQ=; b=PewkiV9MUKDOPYdt6AQXqbcM
	CMs004tAeFJZVxX1PSIKOzVusi2NbJ1PP8vWYn/s638Ejb7OBClgSVYTu+xdyEOE
	7cCHzXPt+7hyrRyPupUGIm5GW8SobTJugIWiUe/K4XauBe7EelyzbWWrDEUU5B5y
	QfNAoFFT7dwk5HhjNq0eAgruJv9ijWSXHu9H6FDzwNb1XqikZrBDew7SA+wqB90B
	Z7ehefGmy6QMtWR+omkQMe3EwvpSNox2CS2yNeSzzw5t3rpPKCs3IfdByNy00DcT
	A81S7gBTSHU8ivKjDEEIAK3ZdIGzgu6NXAHBGMDKYpeNYVJtPncmq4WPDe+qnw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wqbrhse67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 15:38:56 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 427FcsKI006303
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Mar 2024 15:38:54 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 7 Mar
 2024 07:38:47 -0800
Date: Thu, 7 Mar 2024 21:08:43 +0530
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To: Elliot Berman <quic_eberman@quicinc.com>
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
Subject: Re: [PATCH v17 07/35] gunyah: rsc_mgr: Add resource manager RPC core
Message-ID: <20240307153843.GC1695516@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <20240222-gunyah-v17-0-1e9da6763d38@quicinc.com>
 <20240222-gunyah-v17-7-1e9da6763d38@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <20240222-gunyah-v17-7-1e9da6763d38@quicinc.com>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SAqqeAVAnHjsZR1Kz4QUiMS6P36MU6IS
X-Proofpoint-ORIG-GUID: SAqqeAVAnHjsZR1Kz4QUiMS6P36MU6IS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_07,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403070084

* Elliot Berman <quic_eberman@quicinc.com> [2024-02-22 15:16:30]:

> The resource manager is a special virtual machine which is always
> running on a Gunyah system. It provides APIs for creating and destroying
> VMs, secure memory management, sharing/lending of memory between VMs,
> and setup of inter-VM communication. Calls to the resource manager are
> made via message queues.
> 
> This patch implements the basic probing and RPC mechanism to make those
> API calls. Request/response calls can be made with gh_rm_call.
> Drivers can also register to notifications pushed by RM via
> gh_rm_register_notifier
> 
> Specific API calls that resource manager supports will be implemented in
> subsequent patches.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

Left a minor comment below. LGTM otherwise.

Reviewed-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>

> +static irqreturn_t gunyah_rm_rx(int irq, void *data)
> +{
> +	enum gunyah_error gunyah_error;
> +	struct gunyah_rm_rpc_hdr *hdr;
> +	struct gunyah_rm *rm = data;
> +	void *msg = &rm->recv_msg[0];
> +	size_t len;
> +	bool ready;
> +
> +	do {
> +		gunyah_error = gunyah_hypercall_msgq_recv(rm->rx_ghrsc.capid,
> +							  msg,
> +							  sizeof(rm->recv_msg),
> +							  &len, &ready);
> +		if (gunyah_error != GUNYAH_ERROR_OK) {
> +			if (gunyah_error != GUNYAH_ERROR_MSGQUEUE_EMPTY)
> +				dev_warn(rm->dev,
> +					 "Failed to receive data: %d\n",
> +					 gunyah_error);
> +			return IRQ_HANDLED;
> +		}
> +
> +		if (len < sizeof(*hdr)) {
> +			dev_err_ratelimited(
> +				rm->dev,
> +				"Too small message received. size=%ld\n", len);
> +			continue;

In practice we should never hit this condition, in case we do encounter, do you
see a reason why continue is preferred over simply breaking the loop?

> +		}
> +
> +		hdr = msg;
> +		if (hdr->api != RM_RPC_API) {
> +			dev_err(rm->dev, "Unknown RM RPC API version: %x\n",
> +				hdr->api);
> +			return IRQ_HANDLED;
> +		}
> +
> +		switch (FIELD_GET(RM_RPC_TYPE_MASK, hdr->type)) {
> +		case RM_RPC_TYPE_NOTIF:
> +			gunyah_rm_process_notif(rm, msg, len);
> +			break;
> +		case RM_RPC_TYPE_REPLY:
> +			gunyah_rm_process_reply(rm, msg, len);
> +			break;
> +		case RM_RPC_TYPE_CONTINUATION:
> +			gunyah_rm_process_cont(rm, rm->active_rx_message, msg,
> +					       len);
> +			break;
> +		default:
> +			dev_err(rm->dev,
> +				"Invalid message type (%lu) received\n",
> +				FIELD_GET(RM_RPC_TYPE_MASK, hdr->type));
> +			return IRQ_HANDLED;
> +		}
> +	} while (ready);
> +
> +	return IRQ_HANDLED;
> +}

