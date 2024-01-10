Return-Path: <linux-kernel+bounces-22559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E07829FAD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B3941C22B81
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90854D10E;
	Wed, 10 Jan 2024 17:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C2p0v1xq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D553D4CE17;
	Wed, 10 Jan 2024 17:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40AGp3o2017791;
	Wed, 10 Jan 2024 17:48:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=/bdtln2mv/AR3WB209nyHXWipkDnlC54ppu54z3Gv/k=; b=C2
	p0v1xq9OT8UpXHCHXL4txvgO43XBYUyAV3lseHHpyAVIOSEoaE8fj26BxN+gh3JU
	uBxPESHsZAgLOZq0vt38s5V3H+pg38/iS1BAOWb9c6uYcZ+bwc5XGVnw+ZXdPcBj
	oKZpuNGaKjB/7QVFjA8sw2a9tAeMVHz/vf1tymfYCEEZR7P/sTXmEVhwGkIFOJDb
	xeJL512BHdxWZ9HM/3w9s5s0dzCylgLIpsgQqhZiEyQaRPLeferDw4qnnZ1QkGyF
	hsb0soGiVZYTkPb1LXzOlT3GJd9xAJ05+euP8u+KOhh3N03UKS1QvqB06bw7NPIs
	iopWUvT/Ll+2RWW/gBag==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vhkem1wb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 17:48:18 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40AHmHrw026167
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 17:48:17 GMT
Received: from [10.71.108.105] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 10 Jan
 2024 09:48:17 -0800
Message-ID: <77105c72-0ab5-4822-8f66-4f051cbbd39a@quicinc.com>
Date: Wed, 10 Jan 2024 09:48:16 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 07/34] gunyah: rsc_mgr: Add resource manager RPC core
To: Hillf Danton <hdanton@sina.com>
CC: Will Deacon <will@kernel.org>, Sean Christopherson <seanjc@google.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240109-gunyah-v16-0-634904bf4ce9@quicinc.com>
 <20240110114101.3343-1-hdanton@sina.com>
Content-Language: en-US
From: Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <20240110114101.3343-1-hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -FYfbVBkdgFvCE3uW-74_rmwNaQgd0CA
X-Proofpoint-GUID: -FYfbVBkdgFvCE3uW-74_rmwNaQgd0CA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 mlxlogscore=417 impostorscore=0 phishscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100142



On 1/10/2024 3:41 AM, Hillf Danton wrote:
> On Tue, 9 Jan 2024 11:37:45 -0800 Elliot Berman <quic_eberman@quicinc.com>
>> +
>> +static irqreturn_t gunyah_rm_tx(int irq, void *data)
>> +{
>> +	struct gunyah_rm *rm = data;
>> +
>> +	complete_all(&rm->send_ready);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int gunyah_rm_msgq_send(struct gunyah_rm *rm, size_t size, bool push)
>> +	__must_hold(&rm->send_lock)
>> +{
>> +	const u64 tx_flags = push ? GUNYAH_HYPERCALL_MSGQ_TX_FLAGS_PUSH : 0;
>> +	enum gunyah_error gunyah_error;
>> +	void *data = &rm->send_msg[0];
>> +	bool ready;
> 
> 	lockdep_assert_held(&rm->send_lock); instead of __must_hold
>> +
>> +again:
>> +	wait_for_completion(&rm->send_ready);
>> +	/* reinit completion before hypercall. As soon as hypercall returns, we could get the
>> +	 * ready interrupt. This might be before we have time to reinit the completion
>> +	 */
>> +	reinit_completion(&rm->send_ready);
> 
> Given wait_for_completion(&rm->send_ready) with rm->send_lock held,
> complete(&rm->send_ready) works for you with the bonus of cutting this
> reinit off.
> 

Good point, thanks! Applied both suggestions

- Elliot

