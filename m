Return-Path: <linux-kernel+bounces-33854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 053B7836F90
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DA571F30316
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B593E484;
	Mon, 22 Jan 2024 17:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ioBK2xZJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DFE3DBA5;
	Mon, 22 Jan 2024 17:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945601; cv=none; b=AAVjo/eb3msaXB7K/L2sRxaDxAPCHM1U7/ttmO5ryE66Bbs73m8oNCS3qD34ucn/F+gSrRXvQcQmkvql6zfD/bwptVW9pABs0r87TIvnKaImgCU47BNyMotTIsp33znIUwN9dfFaTab8fIj3epHjgNSVRMrFQ0s4LP5I7spfOfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945601; c=relaxed/simple;
	bh=e4V9gVDnH5g/BjgcqLGkLNGLWlAqhNlDvw/xrXdlMFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CpUoiTGnMaMAX9y4SJEeWUWteC66/aIW3hE2EmusnQK9cp5pC8iXaftq5qWa2bGrdfyLJGQhRtk0uTu2OfC0McExiGzNPC8s3kBt2XZjGcxwjyUFUz1abzNBsi/LkjERUuMWCKS/H42jl2nmM/iHP1QFh3KpoxVLkYU8tUgkE24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ioBK2xZJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40MFU72h004074;
	Mon, 22 Jan 2024 17:46:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=rH5RZ7wzk8tepWbpNiSNYb2L1ssV1ELX2qEh7rhnGAM=; b=io
	BK2xZJBy/JLSJglEae1vr3FgTtvPfOHkQtX1eG+3rDZNZRwbT6TF9OX6wNfum97f
	tsCprA3z1nE2ERQjA/dR6tgNaxl03XQdEs0E+Oar62QaIfIQGBvBiP8kh3Y2jNns
	fVpqsI8Y4rQOnHePzVuwOzIo26wFJIioesNDkGdDnlTmLshtZHj1HT1U+ilegHlw
	2+QBdYQwdn9wTrzoVYaJhA2c7bNyi1iYf/YZ8ycTUzmvEy15KtY5OgOEeU12C5Ja
	QJnXQ4tNZPqc/sSAuauQ4vBlCWs7pq+R3Tz8aQqbwI2hraM6N4k4Bh5JsfCfl30Y
	b/km0uy8R+P44gr90mQQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vsjkthr77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 17:46:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40MHkVHc006937
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 17:46:31 GMT
Received: from [10.216.24.76] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 22 Jan
 2024 09:46:27 -0800
Message-ID: <a70e7219-5fd8-4797-be43-199f8995409b@quicinc.com>
Date: Mon, 22 Jan 2024 23:16:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/3] clk: qcom: clk-rcg2: introduce support for
 multiple conf for same freq
Content-Language: en-US
To: Christian Marangi <ansuelsmth@gmail.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael
 Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231220221724.3822-1-ansuelsmth@gmail.com>
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <20231220221724.3822-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: og2mkFzAv4ALy79YRw0iFYayGtV_ozbv
X-Proofpoint-ORIG-GUID: og2mkFzAv4ALy79YRw0iFYayGtV_ozbv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_07,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 suspectscore=0 clxscore=1011 phishscore=0 bulkscore=0 adultscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401220124



On 12/21/2023 3:47 AM, Christian Marangi wrote:
> This small series fix a current problem with ipq8074 where the 2 uniphy
> port doesn't work in some corner case with some clk configuration. The
> port to correctly work require a specific frequency, using the wrong one
> results in the port not transmitting data.
> 
> With the current code with a requested freq of 125MHz, the frequency is
> set to 105MHz. This is caused by the fact that there are 2 different
> configuration to set 125MHz and it's always selected the first one that
> results in 105MHz.
> 
> In the original QSDK code, the frequency configuration selection is
> different and the CEIL FLOOR logic is not present. Instead it's used a
> BEST approach where the frequency table is checked and then it's checked
> if there are duplicate entry.
> 
> This proposed implementation is more specific and introduce an entire new
> set of ops and a specific freq table to support this special configuration.
> 
> A union is introduced in rcg2 struct to not duplicate the struct.
> A new set of ops clk_rcg2_fm_ops are introduced to support this new kind
> of frequency table.
> 


Bjorn / Stephen Boyd,

I would like to know if there are any comments on this series. To enable 
the clocks required for the Ethernet interfaces on the IPQ platforms, 
these patches are needed. If no concerns, can this be picked up for v6.9?

Thanks,
Kathiravan T.


> Changes v8:
> - Add Tested-by tag
> - Fix typo in commit description
> - Address requested fixup for Stephen
> Changes v7:
> - Improve handling of exit condition on missing parent.
> Changes v6:
> - Small rework of best_conf selection to mute Sparse warn.
> Changes v5:
> - Rework selection logic with suggestion from Konrad
> - Return -EINVAL and WARN if we fail to find a correct conf
> Changes v4:
> - Drop suggested but wrong re-search patch
> - Move everything to separate ops and struct to not affect current rcg2
>    users.
> Changes v3:
> - Add qcom_find_freq_exact
> - Drop re-search on rcg2_set_rate
> - Rework multiple conf patch to follow new implementation
> Changes v2:
> - Out of RFC
> - Fix compile warning from buildbot related to F redefinition
> 
> Christian Marangi (3):
>    clk: qcom: clk-rcg: introduce support for multiple conf for same freq
>    clk: qcom: clk-rcg2: add support for rcg2 freq multi ops
>    clk: qcom: gcc-ipq8074: rework nss_port5/6 clock to multiple conf
> 
>   drivers/clk/qcom/clk-rcg.h     |  24 ++++-
>   drivers/clk/qcom/clk-rcg2.c    | 166 +++++++++++++++++++++++++++++++++
>   drivers/clk/qcom/common.c      |  18 ++++
>   drivers/clk/qcom/common.h      |   2 +
>   drivers/clk/qcom/gcc-ipq8074.c | 120 +++++++++++++++---------
>   5 files changed, 285 insertions(+), 45 deletions(-)
> 

