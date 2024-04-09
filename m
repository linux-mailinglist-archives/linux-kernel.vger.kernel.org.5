Return-Path: <linux-kernel+bounces-137691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 884A889E607
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2844A1F21DF4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF35158DB9;
	Tue,  9 Apr 2024 23:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LnccMz9O"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5928B158DAA;
	Tue,  9 Apr 2024 23:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712704756; cv=none; b=ggWOnKetlKkHnkl2VM1C6Tga97td3UksYOFi1121Evy+TNAu86S2R2tE+Wj4g/QiZItk/pBhthLlZCICozrfRT8YttSBue2KClGqIVrjgh0clZrmjryOxTI9n+iWxz3G96RoefS+Xa6yMTBDTBIa4TYclSW/74cPFobprp9j9OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712704756; c=relaxed/simple;
	bh=gsro14HSF+eG7gyjutrPG/+a7zpFxjtt1NQDwQItges=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9VUfRni83Ig++pe2Ijoij7bJ9+DEJt3SwszaoCuQiDDdRvl/K+PWiugm/CS2h6fxjd1IYxHFHqLhWbbGpV00u4S4Im652OfEz+K+sIc8GpNYPHwQ82VLBNjNawrwSwsD/yYoNu6O4U573SuEOfTZvrm3wvaVIaZbc2pF0s0aKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LnccMz9O; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 439MwNQo007240;
	Tue, 9 Apr 2024 23:18:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=N+J/7ZTkrzTpb+40/f8nU
	YISV6T5vuTq1CdcjZQHAW4=; b=LnccMz9OsUhMbx+t0EvHpAIHfPxiawqv5aS7k
	YSpFVssGqam50WkQ34tUWp08kniwoa6VjkKJf0tU9eVqqHEtQmnciRg8ijtEpV0u
	Avr2vqbvv1lVFmfE7HOc65mjSVXlMcmix8Q2MdPpGFwHYOL8luxLHU/pU9alTVHI
	9duTEa6DVaETFoARmTokQDZhh6sHWaF7AWNkwr0WXH6wdG93XhJnGwA5pqE3UZOG
	0apYtI932R17ie5+f3lwe4SAb93z/AbW2PtAe277dpryJ7/ST349j4yxQk4yza3+
	8SLmVjJYp4RX2oJcJO3WAQVp6ioB+eR0sXWMpvdZ1NX7GNt6g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xd4uesqjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 23:18:57 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 439NIudR015984
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Apr 2024 23:18:56 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 9 Apr 2024 16:18:55 -0700
Date: Tue, 9 Apr 2024 16:18:54 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
CC: Bjorn Andersson <andersson@kernel.org>, Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 6/6] drm/msm/dp: Use function arguments for audio
 operations
Message-ID: <ZhXM3ldkY7FBlFjF@hu-bjorande-lv.qualcomm.com>
References: <20240328-msm-dp-cleanup-v2-0-a5aed9798d32@quicinc.com>
 <20240328-msm-dp-cleanup-v2-6-a5aed9798d32@quicinc.com>
 <711e8a6a-a849-3cd3-fde3-d60f756abfa5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <711e8a6a-a849-3cd3-fde3-d60f756abfa5@quicinc.com>
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rJwRBaALpi4XBpdebfX132nxJz8Au_YR
X-Proofpoint-ORIG-GUID: rJwRBaALpi4XBpdebfX132nxJz8Au_YR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_12,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 spamscore=0 mlxscore=0 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 clxscore=1015 mlxlogscore=965 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404090160

On Mon, Apr 08, 2024 at 02:31:45PM -0700, Abhinav Kumar wrote:
> On 3/28/2024 7:40 AM, Bjorn Andersson wrote:
> > From: Bjorn Andersson <quic_bjorande@quicinc.com>
> > 
> > The dp_audio read and write operations uses members in struct dp_catalog
> > for passing arguments and return values. This adds unnecessary
> > complexity to the implementation, as it turns out after detangling the
> > logic that no state is actually held in these variables.
> > 
> > Clean this up by using function arguments and return values for passing
> > the data.
> > 
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > ---
> >   drivers/gpu/drm/msm/dp/dp_audio.c   | 20 +++++--------------
> >   drivers/gpu/drm/msm/dp/dp_catalog.c | 39 +++++++++++++------------------------
> >   drivers/gpu/drm/msm/dp/dp_catalog.h | 18 +++++++++--------
> >   3 files changed, 28 insertions(+), 49 deletions(-)
> > 
> 
> One quick question, was DP audio re-tested after this patch?

No, sorry for not being explicit about that. I don't have any target
with working DP audio...

Regards,
Bjorn

