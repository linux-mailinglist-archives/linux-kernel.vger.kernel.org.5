Return-Path: <linux-kernel+bounces-87736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E049386D858
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E5B31C20D16
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0735F443E;
	Fri,  1 Mar 2024 00:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g1cWBos1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D490D3FE0
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 00:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709253100; cv=none; b=JV/Gz/rycPWEE8pB0lSSd7iAeIe6D9xxq2R1JPPpJJVpa7Dy48kP6W9SzPxdHitNIg9XHQAmMSvsMp1hSwT/C8AcF0RU+6ZAbz+8yptP9VzVj4Hst5ItHB28uXmKR96BWnDakYAIDg0aidS/2OL9iTztJdR8uJEKV7A61mGe9tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709253100; c=relaxed/simple;
	bh=XqGP3N4S81KjyIuGyBqMnZsaMdH0L01+F4RiutGx70s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=T4xyHN5LW2n456e4domrSyMi4uNiDT3v3eZMv/Vi2EcVGsWZZn/Px94UNQfHY6HLfG6GNm44oNyoolvYVvT2F9n/EgcQ4EnVqilgQHSTbZ+N/p5TKKCwPhW2Rxa7Y2yE4gLYlOKm6t+Whaf1Dl+kbaa13LS0NEpxHnsfXHQKReg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g1cWBos1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41TNhi70001324;
	Fri, 1 Mar 2024 00:31:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=yqlbLy0YUnYJdLp+bH3E1Uw77dnQJkGWU9TfZrIfoUY=; b=g1
	cWBos1JZ5wvgGfzhRmwMTUf1a7/lfGDB6mTS8QOklWz2ILTJ2BXaphh8V/3isPxW
	QyJi0gplvJysTbOqMFc7iE7XBJZSHdKMwGmxHpqzXqhYBEjLeAePzfEXt9jmv7Rb
	OuhkyutyQFdkaR0VyouWDb36DeYC+eKnJpIwA4hEmMNhbvitK2UTjWLTV5dp95RE
	wTea5spozQa4aJoAXVnvukldE5a22BKUI8wMv6sPvKY1D34vm4w1TX4RBPIfct68
	bUtMSG/Yl5RVmgweQh77gbB9Fbt4nmkjzd3BQYNsGtj452b1Vg7H87zS2E1bYj4C
	PCpIwwGB+3BLACe5aFtw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wjupp1n5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 00:31:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4210V3BP019415
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 1 Mar 2024 00:31:03 GMT
Received: from [10.71.109.81] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 29 Feb
 2024 16:31:01 -0800
Message-ID: <c882a1da-e3a3-0ee1-9782-8c1e1caefcc1@quicinc.com>
Date: Thu, 29 Feb 2024 16:31:01 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 9/9] drm/panel: truly-nt35597: Don't log an error when
 DSI host can't be found
Content-Language: en-US
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        "Jernej
 Skrabec" <jernej.skrabec@gmail.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        owen <qwt9588@gmail.com>, Jagan Teki
	<jagan@amarulasolutions.com>,
        Marek Vasut <marex@denx.de>,
        Adrien Grassein
	<adrien.grassein@gmail.com>,
        Srinivas Kandagatla
	<srinivas.kandagatla@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        "Bjorn
 Andersson" <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        "Dmitry
 Baryshkov" <dmitry.baryshkov@linaro.org>,
        Vinay Simha BN
	<simhavcs@gmail.com>,
        Christopher Vollo <chris@renewoutreach.org>,
        Jessica
 Zhang <quic_jesszhan@quicinc.com>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@somainline.org>
CC: <kernel@collabora.com>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
References: <20240229-anx7625-defer-log-no-dsi-host-v2-0-00506941049a@collabora.com>
 <20240229-anx7625-defer-log-no-dsi-host-v2-9-00506941049a@collabora.com>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20240229-anx7625-defer-log-no-dsi-host-v2-9-00506941049a@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: y8pjSHe4I20K9_5qUELFXFufedqYesAg
X-Proofpoint-GUID: y8pjSHe4I20K9_5qUELFXFufedqYesAg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_07,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403010002



On 2/29/2024 4:12 PM, Nícolas F. R. A. Prado wrote:
> Given that failing to find a DSI host causes the driver to defer probe,
> make use of dev_err_probe() to log the reason. This makes the defer
> probe reason available and avoids alerting userspace about something
> that is not necessarily an error.
> 
> Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>   drivers/gpu/drm/panel/panel-truly-nt35597.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

