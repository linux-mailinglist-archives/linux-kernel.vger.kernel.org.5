Return-Path: <linux-kernel+bounces-125138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E91E892098
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CCF71F29FDB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDFD11182;
	Fri, 29 Mar 2024 15:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oRUYCDDp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C615D171A5;
	Fri, 29 Mar 2024 15:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711726693; cv=none; b=S4uGeTq+/SgZQf21vCKZZn6HPPfSUnC58flToN4d/6Ce8iuPfROYAkbVMadN0COgi9T3nBP8P4sM4XT3lFDVS7dRfrPKImD7mn+2c4yYBNJx4ZdG27CKgP2czRy7HccLNiF3bVOLjtS1Kpjg1Omyp8owdtEKc4us0GuYyDdWJ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711726693; c=relaxed/simple;
	bh=EndZPXAh1p+24Y3FTLU32WLWZjDThw0ejj6i48DmoiI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnDjIa75TO/VE/YgzNEMti3hxsRkXRTuqkp+KK1c6PIYLwPHLE+l8rEXqYljcRnEqRF7iM1icjGt6xbvPBS4zV4zn23Jqis/kbtzXiUCWPbKgoZETJrM7Nvpp0fpMQVxWpC2algZo04Y2vP5WsXa1sMjq5JLCvlwgFwoDebES4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oRUYCDDp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42TEUrBd029454;
	Fri, 29 Mar 2024 15:37:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=OQFdy3sUVFWf0Klmkip3N
	FOHi61RbjiqyF7llsku+EY=; b=oRUYCDDpJpAq6rwi1iO1RFjusRAjgjizUQd/F
	wigVE629aZT5jKXY3ua3yC/0i2tVwWt7DRKXx2oTVfbSCBQgPruef+L3uR+sD1x/
	OqiuiqvBg00EUkMqvhi2oeUro0w3lKqZxUjFy4vcptIH5ypCtWV080qvN2tghLM0
	VtKl66Oiazy7KqbXLg/SZA4oen7h0wDCuTOg4m18QnUDSqbBVjorrsDuR9+tDJNV
	9wh3C7Hh/ynQq7P6EhPY6F2z4l41O5QDlJ/zMpoAS2i3XqnYim8TjTSAWKEVXz34
	NDE6fIIYNJ/dCQDdzTfEC8OP4CiIBAqlpIEVKVIBcykS/lOYw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5sm6h5p9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 15:37:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42TFbwOB013590
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 15:37:58 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 29 Mar 2024 08:37:58 -0700
Date: Fri, 29 Mar 2024 08:37:56 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar
	<quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, "Daniel
 Vetter" <daniel@ffwll.ch>,
        Abel Vesa <abel.vesa@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <freedreno@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/msm/dp: Remove now unused connector_type from desc
Message-ID: <20240329153756.GW3213752@hu-bjorande-lv.qualcomm.com>
References: <20240328-dp-connector-type-cleanup-v1-1-9bf84c5a6082@quicinc.com>
 <CAA8EJpoNBA7L3FMqf+4korbbYfrptHq3Fke86DpfNcbpiBaqzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAA8EJpoNBA7L3FMqf+4korbbYfrptHq3Fke86DpfNcbpiBaqzQ@mail.gmail.com>
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0nuwXDAwd1cpYAV1oHt8DmqD3pHS-S4I
X-Proofpoint-GUID: 0nuwXDAwd1cpYAV1oHt8DmqD3pHS-S4I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 suspectscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403290138

On Fri, Mar 29, 2024 at 07:23:07AM +0200, Dmitry Baryshkov wrote:
> On Fri, 29 Mar 2024 at 06:02, Bjorn Andersson <quic_bjorande@quicinc.com> wrote:
> > diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
[..]
> >  static const struct msm_dp_desc sc8280xp_edp_descs[] = {
> 
> This can now be merged with sc8280xp_dp_descs
> 

You're right, only saw the first level of cleanup. Will repsin this.

Thanks,
Bjorn

