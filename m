Return-Path: <linux-kernel+bounces-133531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A4189A4F6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9424C2847EF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DAB172BDB;
	Fri,  5 Apr 2024 19:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aXjZLI8c"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3329A16D328;
	Fri,  5 Apr 2024 19:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712345503; cv=none; b=cZD9JiklCgNsv0iNj/B+UIb1dAnmnYYt4WsKNnk/Ie8GjMjqx3U3CRtKRiWiHG8fZXIJjHmQTxjJMyxiysihXvRDGLpFcMHpFkvLnyqfLTmnszfY4Oz9PTqPhEKXIO8pAQHH/KXwjgbymG+03q29HqiivL7297ILz5e3riaynIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712345503; c=relaxed/simple;
	bh=CCqosY6LwrXSOVMTJ5pTTL5HXPdD8OYPTtkbzw4LRIE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gjc6pbtlEc3uO9mQPoFV0gCjfliPomFVo4mJ283KzdRBg/goc9M0mCSpdINe03skk3u+ylKtG4KrhI7HeZmbvkuTypRY1w2BMJHs1gNUBTGOjmPJjt6lVvHxsDonGRmNmNa3YJcYNLn/O6jPGn42mPfM6rsJBwxY03NUxdtuZqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aXjZLI8c; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 435IrBYd022293;
	Fri, 5 Apr 2024 19:31:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=BlNAeShZDOvgUo9npknTomdfOyDC0s2Vs6WntYULbdQ=; b=aX
	jZLI8c++GogdAHBUN6Pm81OmUdyvuxYwb7kt9kmnvW+3W+HyqRuLG1Uc86AtPX5b
	DyKWlQ62EIrVA9DYXcm0+GMJKSermzil4IHTS1rpPo46CKDu1HAx+evxy+1lfszp
	lTuFrmKJFJattO2gzVpiPhfchW0l5mLzDsGjH37D7PjRYow9pSodIRZ/iI/IU8vg
	UDo4DFGRgJTL0vPu87j3cmSWYiTd1ipDuh/m1ADmKnK9sFCxHKa9kFGL0XhhZdZX
	FlhE6UkgdFYPymR/e90vVN9mIFQaNYvK24ynS8LZlbijz3IPThg5ZL/r7mLbJOKd
	lS25mFrgRHV5K+oc2Fig==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xa7m5j4n4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 19:31:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 435JVSGI028038
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 19:31:28 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 5 Apr 2024 12:31:28 -0700
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
To: <freedreno@lists.freedesktop.org>, Rob Clark <robdclark@gmail.com>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        Sean Paul
	<sean@poorly.run>,
        "Marijn Suijten" <marijn.suijten@somainline.org>,
        David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Kuogee Hsieh
	<quic_khsieh@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
CC: <dri-devel@lists.freedesktop.org>, <swboyd@chromium.org>,
        <quic_jesszhan@quicinc.com>, <quic_parellan@quicinc.com>,
        Rob Clark
	<robdclark@chromium.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/msm/dp: fix typo in dp_display_handle_port_status_changed()
Date: Fri, 5 Apr 2024 12:31:19 -0700
Message-ID: <171234544659.7383.17823778354576081313.b4-ty@quicinc.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240306193515.455388-1-quic_abhinavk@quicinc.com>
References: <20240306193515.455388-1-quic_abhinavk@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7i4OSB_z0mQ5ymGTvxpNAQcBr-MBaljR
X-Proofpoint-GUID: 7i4OSB_z0mQ5ymGTvxpNAQcBr-MBaljR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_21,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 bulkscore=0 phishscore=0 adultscore=0
 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 mlxlogscore=894 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404050138


On Wed, 06 Mar 2024 11:35:15 -0800, Abhinav Kumar wrote:
> Fix the typo in the name of dp_display_handle_port_status_changed().
> 
> 

Applied, thanks!

[1/1] drm/msm/dp: fix typo in dp_display_handle_port_status_changed()
      (no commit info)
      https://gitlab.freedesktop.org/drm/msm/-/commit/cd49cca222bc
Best regards,
-- 
Abhinav Kumar <quic_abhinavk@quicinc.com>

