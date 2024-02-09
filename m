Return-Path: <linux-kernel+bounces-58889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E5F84EE2B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 01:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 297D81C21453
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E85567A;
	Fri,  9 Feb 2024 00:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KUCVSNlY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE6F4C98;
	Fri,  9 Feb 2024 00:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707436966; cv=none; b=AoJ8qbQPVcMWzuV3WDxasyCImuueLL0CzC6fsZWZqOdFRRpbwKrET4LY1DLs/be880unAwK8R4Qh/mK0sBsGdodJOlbxPuc7f2UmA1/WkMtV55HDWvOMDID74Dz+bpFtHAKdi1cdY6ufJBX0Ix+H1UGoS/bM++048jbUP/x3rA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707436966; c=relaxed/simple;
	bh=LkOLHY+o+udSpmGULxHUmPKRpvZuIshUcc2fP9oCCrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bt2TlGyzk5h0i01mHYn/DireCVpTnOqKo97xUjUiI+zuV4mQAuDkeqUZoMo7taJq7OfjeX6jVXDITwREpk8gPd0tLIYgbr0VCEeVm8W95wAD3jwMfZTbnmySBrO90upqms/CtSWZgZbNdqxFHqIhf0QzQrb6457rR4bs8J5PO+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KUCVSNlY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 418NFdp3020989;
	Fri, 9 Feb 2024 00:02:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=MqLMn6LQbwP7IL1EM9H4WRHLW1o/0KkA3yYJBHsfiIo=; b=KU
	CVSNlYom3Nz0XELJoV8z9RWY9g3yr4zZJW+UZ3LBN6hACc5UjgJknXBCZRypR/Jk
	U+3IAhayB4gShwjXRN6U3ga1A5yBeNT+hEcd2b/niB0lfYpe2WXQ987Y+PSIF8Ca
	XdE7cOhHsCmmzCPpzAic7Bg/1zNv4Mqsp/DO5ts5t0Neq17rD2RTwfDHQhIR4jCT
	kOrQdIJRKHN5wd/2Tv5mloznH8Zzk6DFvIJ7xuvmr1nJ5ca7MfHxoCITVI4iheeQ
	KLqWuwY2lWcBKF0No+uk6qYtLvOjeoYW62EmKCp/hV5S3Qco0KKPCB2Ibxs7pSVn
	jSsEyA8qOZij3mnUbt2w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w4sudjda5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 00:02:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41902P8J012556
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 9 Feb 2024 00:02:25 GMT
Received: from [10.110.97.178] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 8 Feb
 2024 16:02:21 -0800
Message-ID: <79ae310b-5536-49a3-b3f7-3e4cd2328632@quicinc.com>
Date: Thu, 8 Feb 2024 16:02:21 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4] net: stmmac: dwmac-qcom-ethqos: Enable TBS on
 all queues but 0
Content-Language: en-US
To: Abhishek Chauhan <quic_abchauha@quicinc.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, <netdev@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Andrew Halaney <ahalaney@redhat.com>
CC: <kernel@quicinc.com>
References: <20240208231145.2732931-1-quic_abchauha@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240208231145.2732931-1-quic_abchauha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: iGEwXLVeaYe23bKPdYAeNiPm84VMjsqR
X-Proofpoint-ORIG-GUID: iGEwXLVeaYe23bKPdYAeNiPm84VMjsqR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_12,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0 phishscore=0
 mlxlogscore=504 clxscore=1015 priorityscore=1501 adultscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402080138

On 2/8/2024 3:11 PM, Abhishek Chauhan wrote:
> TSO and TBS cannot co-exist. TBS requires special descriptor to be
> allocated at bootup. Initialising Tx queues at probe to support
> TSO and TBS can help in allocating those resources at bootup.
> 
> TX queues with TBS can support etf qdisc hw offload.
> 
> This is similar to the patch raised by NXP
> commit 3b12ec8f618e ("net: stmmac: dwmac-imx: set TSO/TBS TX queues default settings")
> 
> Tested-by: Andrew Halaney <ahalaney@redhat.com> # sa8775p-ride
> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>


