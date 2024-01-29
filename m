Return-Path: <linux-kernel+bounces-42485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB708401FB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C125C1C20E02
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D8A55C3C;
	Mon, 29 Jan 2024 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GX26r+TY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA0455C0B;
	Mon, 29 Jan 2024 09:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706521503; cv=none; b=JtnzKHUghvYeawLBhHXX/luMBPVGFEWDGKM1j5l+Ec+ygetVAVNqQo57+Kl8cAaweThKR6vgq/aNFpf6NYooM4YQTXAW2Eo9LP8JCvQCpDrL7VtVNGT5B2PRaDGbPmQx7E7J94yvk91KOwNRMxl+zV9a1gdwkb/BHepJuCZ+05s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706521503; c=relaxed/simple;
	bh=QX/PFUYDG2vhsO4TCvlDaojkMhlNxRxarKZxxn4FApA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ofq2aGgPGNSYLJ08PnpDlhx24S45mVvf4WFVEX3oH8jP4XJXMzZNYg/ZvcwwM1WLqQply2VMOAzQOaQEqsiRz4jkrghbI4oEGqzSxrowyiWMRSQn0VubK9tqAgHYEcJ7oNa9BpRYT1gPgsKUGLcv5CI4U9GoFX2O13+6WZtqObE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GX26r+TY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T3j1fd007708;
	Mon, 29 Jan 2024 09:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=9wAZq4jboDZtPCARUsN9UHi5l7EnsT/DcCmFq7v51XI=; b=GX
	26r+TYeRRyyN8DBELJ/3ILCw2Ai/87MUnV5U3PMYcKO/OWr252DVWLNnrsd7LdxF
	CQM/5DKNO5og9cuhcC+WaXstAVSGfGu/+HlhT6kn8dFgBi/qDk/MxO0NxaEuNZo1
	bepSxo8JdFgxVLlIBi6xJYn6rKuZacF0n0iF+Xk9wUkyVDQ8aQ3kxwFHtb/wWwve
	gZCIGshM3rcOS4PtIlFuspnxe0f/AAn5XgmiXOiOgTVwNRM+H3F50zW/skdyAPI8
	iURERb5C8OjscGL7evWPxsdvIVAwjLmN4Y8LQ+wIuddd97hzRh0DFvwj3fK6oKOs
	eNP7jCbpe2lINj7qbTHg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvqhmug57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 09:44:37 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40T9iadn008167
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 09:44:36 GMT
Received: from [10.50.63.208] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 01:44:22 -0800
Message-ID: <c566c3fc-8eac-4f53-9a5a-1d4495071bb1@quicinc.com>
Date: Mon, 29 Jan 2024 15:14:16 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: stmmac: dwmac-qcom-ethqos: Add support
 for 2.5G SGMII
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
CC: Vinod Koul <vkoul@kernel.org>, Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu
	<joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>, <netdev@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>, Andrew Halaney <ahalaney@redhat.com>
References: <20240124092215.14678-1-quic_snehshah@quicinc.com>
 <20240126113619.GA401354@kernel.org>
From: Sneh Shah <quic_snehshah@quicinc.com>
In-Reply-To: <20240126113619.GA401354@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yDevhHvjNuuNdsiUa3vCw0iWq4ry_wVS
X-Proofpoint-ORIG-GUID: yDevhHvjNuuNdsiUa3vCw0iWq4ry_wVS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_05,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 mlxlogscore=579
 spamscore=0 impostorscore=0 clxscore=1011 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401290070



On 1/26/2024 5:06 PM, Simon Horman wrote:
> On Wed, Jan 24, 2024 at 02:52:15PM +0530, Sneh Shah wrote:
>> Serdes phy needs to operate at 2500 mode for 2.5G speed and 1000
>> mode for 1G/100M/10M speed.
>> Added changes to configure serdes phy and mac based on link speed.
>> Changing serdes phy speed involves multiple register writes for
>> serdes block. To avoid redundant write opertions only update serdes
>> phy when new speed is different.
>>
>> Signed-off-by: Sneh Shah <quic_snehshah@quicinc.com>
> 
> Hi,
> 
> unfortunately this patch does not seem to apply to current net-next.
> Please rebase and repost.
> 
My bad! let me rebase and repost the patch!

