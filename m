Return-Path: <linux-kernel+bounces-54962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D49484B57E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10ED1B21FF1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC64012EBE1;
	Tue,  6 Feb 2024 12:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OdgGO4Sp"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0941AB811;
	Tue,  6 Feb 2024 12:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707223519; cv=none; b=sEUo5LCZSqeJjhyyVJg3VSOOJ69Rv2zpN34FO3tOVKlZA1bLwc37EratsjEYgaDNdTvaSTGhW9smjkaKN4k2jdY/rdjB/Dwax38X6FTj+6do4T8wXhnmp5ZPYRGA86gcWp1SiP6t3YHvt/GoqpsXAi1iuapHUOYs5U0CFf4dbjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707223519; c=relaxed/simple;
	bh=wgk0R6xYpdvfMbfC3hL5n90HcTa0N22dWHpnm/GidCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cSGpcMZKNGQZfNDipLnmMyLQ3AjPNH5vcDj/b90OhideWrL89j9zx8tbZfXXQRATYkB9mOmI1zONL6mAh3HzG4chTEYWvnz8Pho7snX2pqA3AFtDi9OliwGce1hSZYBguOqsGFx4gUK8s3t5uTV4eizM3DKPKuA2aHbyQ4QJXNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OdgGO4Sp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4168NiKs018049;
	Tue, 6 Feb 2024 12:45:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=fURlMuDtt1YpTEY8UBIo59b/87YA6fm1XN/jKUCmreI=; b=Od
	gGO4SpmYbOXzNDSvrbywDtLN2C9x46ofQnuInQVAkeOvb7z8Z3FMug4CF2L1sBBm
	tsHaSULL58cBNJAHh3U0ht7P7/eq5+rkUE+FmsUmDYp0+CMiCyYt+E0iRtXWrcI9
	SxWEODhQGm4jmtqfKQ7ti2uHB1s2e2Lkrvi1S4NbF5PEDkzK8k86FWeY8igrSmfj
	hd59IcNyO8+8QsguZFx28mLtYm5gh1D/1k4JO5ClYLy1V4L4ATNiGUczcoOthbca
	pY5kSCDQNFRVjnZuANP3HMNQJ8BGEf/6YSf5gdJXGs5SgE3W+BTglexfx+PYYJkk
	r7asstyJmY2wGv1NwVUw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w3h7hrfsa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 12:45:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 416CjBxI029529
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 Feb 2024 12:45:12 GMT
Received: from [10.214.82.119] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 6 Feb
 2024 04:45:07 -0800
Message-ID: <5af1ed27-2c59-4d8e-90cb-9ca7a2184b92@quicinc.com>
Date: Tue, 6 Feb 2024 18:15:03 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11] bus: mhi: host: Add tracing support
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        "Manivannan
 Sadhasivam" <mani@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Masami
 Hiramatsu" <mhiramat@kernel.org>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <mhi@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_parass@quicinc.com>
References: <20240206-ftrace_support-v11-1-3f71dc187544@quicinc.com>
Content-Language: en-US
From: Naman Jain <quic_namajain@quicinc.com>
In-Reply-To: <20240206-ftrace_support-v11-1-3f71dc187544@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IoCosgZZG8vc7WDqIJP3N1SlIftcIJv3
X-Proofpoint-ORIG-GUID: IoCosgZZG8vc7WDqIJP3N1SlIftcIJv3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_06,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=639 mlxscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402060090

On 2/6/2024 10:02 AM, Krishna chaitanya chundru wrote:
> This change adds ftrace support for following functions which
> helps in debugging the issues when there is Channel state & MHI
> state change and also when we receive data and control events:

Please write commit msg in imperative mood.
https://www.kernel.org/doc/html/v4.10/process/submitting-patches.html#describe-your-changes

> 1. mhi_intvec_mhi_states
> 2. mhi_process_data_event_ring
> 3. mhi_process_ctrl_ev_ring
> 4. mhi_gen_tre
> 5. mhi_update_channel_state
> 6. mhi_tryset_pm_state
> 7. mhi_pm_st_worker
> 
> Change the implementation of the arrays which has enum to strings mapping
> to make it consistent in both trace header file and other files.
> 
> Where ever the trace events are added, debug messages are removed.

Ditto.

Regards,
Naman



