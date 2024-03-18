Return-Path: <linux-kernel+bounces-106503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5470887EF90
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 588141C20DC6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0C155E76;
	Mon, 18 Mar 2024 18:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IoC2DWv8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4588455E62;
	Mon, 18 Mar 2024 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710785822; cv=none; b=DRN80DhfqXau3tmE2ZT4NnSf8DsWyuEf5cQ6tjLFSLn+IPz80jaa/X06LddWBzL5z17RPoukCCQAKc2AfG4lLEXIcPR5+dfC1yd01vn/MsYRXcV6FgTl5mLxWnpKEDKu+BdG6p0rP7VaZNe0KHaxxQWP02uT8Nakdo5s0ATeZlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710785822; c=relaxed/simple;
	bh=JcVqeY7++urceSeBZme5sT5/Eqn1uROl9On3TLxZOTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ekSHHjXtfwBPDimHg2v98j771CTgzb5mHhlcpwv82Td3XypNZGfm/VkwRr7Txqkfn9dAlTZCYsRUpw4IrxWP2nALP6Oh7lO9Z1Ie3/IWDdnTgcM5qRItSixrRhmQaT/+GWr8W9U7mZwTrKA7zP6kJWJEfvpY9vHfTFCOFL/N/7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IoC2DWv8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42IF9CVm020268;
	Mon, 18 Mar 2024 18:16:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=eDytk79ivhEiAWoVatjD/gJmwiCoaoLie4h+vDUztPw=; b=Io
	C2DWv8wHorR/k7/d6GaZ6GWaCL3/3kUNuJLRsQq1nnjgRFl/uCmSGh8WnvdrE2uj
	Shsbtx2yDpY3vkWFkATNwXBnMGyibZ6C4nX72xSmAXUHKwiFfxPj1+efzRYn/8iK
	3efCVxgezYBdYsZ859duGSwNVn3CXS6x1tqdm18NqLMJ8nqkstyh20LtuTkQuj/r
	RewWJdejeSqLHuLXvHSk4MA6TOYZgCJGva/tkceBue/3YUJ/52nVGNRf50B5RFTq
	AFuU9MLlLD5I1gXrgnDrPv814eB7H5vhpJSb6vTRVrpR27eSfULQWn2/uFIYT2gn
	HuPlQxuvgK/OwuL77aYA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wxr0gghah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 18:16:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42IIGrfx009166
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 18:16:53 GMT
Received: from [10.110.10.159] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 18 Mar
 2024 11:16:47 -0700
Message-ID: <ab9161d5-1cb9-4929-9f34-a7371832fea4@quicinc.com>
Date: Mon, 18 Mar 2024 11:16:45 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/4] drm/msm/dp: Avoid a long timeout for AUX transfer
 if nothing connected
Content-Language: en-US
To: Douglas Anderson <dianders@chromium.org>, Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Bjorn Andersson <quic_bjorande@quicinc.com>,
        Daniel Vetter
	<daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
        Guenter Roeck
	<groeck@chromium.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        Sean Paul <sean@poorly.run>, Stephen Boyd
	<swboyd@chromium.org>,
        Vara Reddy <quic_varar@quicinc.com>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240315213717.1411017-1-dianders@chromium.org>
 <20240315143621.v2.1.I16aff881c9fe82b5e0fc06ca312da017aa7b5b3e@changeid>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20240315143621.v2.1.I16aff881c9fe82b5e0fc06ca312da017aa7b5b3e@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 16Z_2W68sx25tOvpih_eSQtg4gAibQwQ
X-Proofpoint-ORIG-GUID: 16Z_2W68sx25tOvpih_eSQtg4gAibQwQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 spamscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403180138



On 3/15/2024 2:36 PM, Douglas Anderson wrote:
> As documented in the description of the transfer() function of
> "struct drm_dp_aux", the transfer() function can be called at any time
> regardless of the state of the DP port. Specifically if the kernel has
> the DP AUX character device enabled and userspace accesses
> "/dev/drm_dp_auxN" directly then the AUX transfer function will be
> called regardless of whether a DP device is connected.
> 
> For eDP panels we have a special rule where we wait (with a 5 second
> timeout) for HPD to go high. This rule was important before all panels
> drivers were converted to call wait_hpd_asserted() and actually can be
> removed in a future commit.
> 
> For external DP devices we never checked for HPD. That means that
> trying to access the DP AUX character device (AKA `hexdump -C
> /dev/drm_dp_auxN`) would very, very slowly timeout. Specifically on my
> system:
>    $ time hexdump -C /dev/drm_dp_aux0
>    hexdump: /dev/drm_dp_aux0: Connection timed out
>    real    0m8.200s
> We want access to the drm_dp_auxN character device to fail faster than
> 8 seconds when no DP cable is plugged in.
> 
> Let's add a test to make transfers fail right away if a device isn't
> plugged in. Rather than testing the HPD line directly, we have the
> dp_display module tell us when AUX transfers should be enabled so we
> can handle cases where HPD is signaled out of band like with Type C.
> 
> Fixes: c943b4948b58 ("drm/msm/dp: add displayPort driver support")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> Changes in v2:
> - Don't look at the HPD line directly; have dp_display call us.
> 
>   drivers/gpu/drm/msm/dp/dp_aux.c     | 20 ++++++++++++++++++++
>   drivers/gpu/drm/msm/dp/dp_aux.h     |  1 +
>   drivers/gpu/drm/msm/dp/dp_display.c |  4 ++++
>   3 files changed, 25 insertions(+)
> 

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

