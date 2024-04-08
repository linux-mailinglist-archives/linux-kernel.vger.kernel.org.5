Return-Path: <linux-kernel+bounces-135942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A8789CD94
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 23:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5818281CAF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 21:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E397E1487E9;
	Mon,  8 Apr 2024 21:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lbVMm1sC"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC561495CB;
	Mon,  8 Apr 2024 21:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712611919; cv=none; b=ROM9xdsCUwVvI4gGWi3h9IJkaztV09I0W6hjsxTmCzczr9MkahK7147a9YgxuEwugSDToZi9YVdrHq+kjv8kYJ0oSrs9+6HKNCuAvbCQJ/MGeHkQcdyCg7KWXKKu0HoxGRJ1furDd7Y8dDuy7KnSYBe6kZIWh3SKdIk9vcK0N2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712611919; c=relaxed/simple;
	bh=35umyuQSIw9GvY3GYtpMl5CQecaLkLnEvCCHRnLV/1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uV5KBQaV4b1fWnqZqfuZi69YPEdsjZJgqGyCtqVrr5YbuFQdZBPqwp0TXZrC3HObYC8QXraJINj42ALQgSaTizKlCg40AfGc1V8MC/TVnlxpWOAYIGwIZZD2mB22E8q9PiILBME3y6wQiuxfDz4QF8AmrSQ1Gm7s/KaPBkJVlFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lbVMm1sC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 438IxCRn011269;
	Mon, 8 Apr 2024 21:31:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=N3qsrgm/NCGXRkWXZiCfZKIOfFS82eYzOFQ43GlxgbE=; b=lb
	VMm1sCxTcVmvP0/at0MFRknESF5QJKf1saxtQllr5QWvKJU1z7wMLstuO5FY3oK0
	6+8b4EnExSkHl8mMMCRLMB6ymiQUfANWZLj7ZjH1F+6b7T+2bB8ErqeTNmBFBH3u
	wRBoJU6Ohp20DOaPHCTudt0BqC5yshwZRuTxHU2M7QBlQ8BG5XA/G3kU/gbLlKan
	2gGTpK0VTJ8adzlzN/8R8lAvljU07wWdzXs2mccJIl+5iReXKamWskHY8MhSnC9U
	JbD6TXCsaANgfAN8wTzP2Htcs4kIFC1N85AKOlAw6iv9Xc0Yp36H8oQ2l05lFpmO
	RA5OnG2KfJbW/mMstBxg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xcbg3hv03-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 21:31:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 438LVlZF012683
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Apr 2024 21:31:47 GMT
Received: from [10.71.109.81] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Apr 2024
 14:31:46 -0700
Message-ID: <711e8a6a-a849-3cd3-fde3-d60f756abfa5@quicinc.com>
Date: Mon, 8 Apr 2024 14:31:45 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 6/6] drm/msm/dp: Use function arguments for audio
 operations
Content-Language: en-US
To: Bjorn Andersson <andersson@kernel.org>, Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        "Bjorn
 Andersson" <quic_bjorande@quicinc.com>
References: <20240328-msm-dp-cleanup-v2-0-a5aed9798d32@quicinc.com>
 <20240328-msm-dp-cleanup-v2-6-a5aed9798d32@quicinc.com>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20240328-msm-dp-cleanup-v2-6-a5aed9798d32@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2k_Bdai7ojyugHIZWGf8OHEYClG3hmAP
X-Proofpoint-ORIG-GUID: 2k_Bdai7ojyugHIZWGf8OHEYClG3hmAP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_17,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404080165



On 3/28/2024 7:40 AM, Bjorn Andersson wrote:
> From: Bjorn Andersson <quic_bjorande@quicinc.com>
> 
> The dp_audio read and write operations uses members in struct dp_catalog
> for passing arguments and return values. This adds unnecessary
> complexity to the implementation, as it turns out after detangling the
> logic that no state is actually held in these variables.
> 
> Clean this up by using function arguments and return values for passing
> the data.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>   drivers/gpu/drm/msm/dp/dp_audio.c   | 20 +++++--------------
>   drivers/gpu/drm/msm/dp/dp_catalog.c | 39 +++++++++++++------------------------
>   drivers/gpu/drm/msm/dp/dp_catalog.h | 18 +++++++++--------
>   3 files changed, 28 insertions(+), 49 deletions(-)
> 

One quick question, was DP audio re-tested after this patch?

