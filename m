Return-Path: <linux-kernel+bounces-133512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6348B89A4B5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88A841C20A88
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5B7172BAD;
	Fri,  5 Apr 2024 19:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R1mac/GG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2E416D328;
	Fri,  5 Apr 2024 19:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712344303; cv=none; b=b0AzHs35Q4Rlpz59bsQskAyvFNkG8Z6ntRGwYKfYNV7DJVYbIn4AAk1D1f3bq8tOXqt3I7w+9Ianfe25Owuno2VjzczW2uD5QnT0DdkY65TsgvBpURIUR7b7FbHIqAQtIeRD4PPSP1PgIey3VbtjmdA2WdBs/vc7V4edBRXdJSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712344303; c=relaxed/simple;
	bh=Y/mZewUJKgsd4rJk1TieQgRy1+ROsm8HFW0FMW10wAQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qKm7xop09U0FnM3yIaE0CYCecMVK6vwPBV/2Z97NGYAALpHh9l1Z6A0YejPQtmpL8MToIE5RQNGIKFytJudOgVEYabBP+KSjD0Q7AWtG7G93MZTXMqEsuUAljRPyspw16PyS/cEzdIlW/kfe4ZI7FHLpSQWKAAxH/CIZkSB6FGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R1mac/GG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 435CU31r010030;
	Fri, 5 Apr 2024 19:11:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=2jNyq1jPDHHHDCOcurM2gKVgKiNdMohMwubwgPaZ9NI=; b=R1
	mac/GGNTRKVX2yzlHB6+tMp7Jx9RlldBgt9agqFLyuxpCfAvIfe44/2KtfOVaLHN
	VDjJ9J0OqYf6K6QwMcsKJZl9jEf2+FHlrwcx+orUxLEbQ/dTScJ9IlqKh47II9u6
	YrZmAvXYVlN+VtXrb5K+HrBqJpki+BAkcIa+Jy3WlXnukwWQW3PMU5QXeUTsDjiV
	Dy0swEfYv272K9aPQlT2MR91ufuUh2Fay9GycqoPIoqaf8axhK/GUUSf/lIuxwKb
	VQlp5+IWbiwhQMax5bjynputPHi3puk3lQXpp+lOsKvCVEDKeUPVVMSaNL7YY9gh
	aP+iFHDHu24Xw+K2N0SQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xahb10xan-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 19:11:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 435JBO3U016289
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 19:11:24 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 5 Apr 2024 12:11:24 -0700
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
To: Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>
CC: Abhinav Kumar <quic_abhinavk@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <patches@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <freedreno@lists.freedesktop.org>
Subject: Re: [PATCH] drm/msm: Add newlines to some debug prints
Date: Fri, 5 Apr 2024 12:11:03 -0700
Message-ID: <171234416740.9339.9412761579283803223.b4-ty@quicinc.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240325210810.1340820-1-swboyd@chromium.org>
References: <20240325210810.1340820-1-swboyd@chromium.org>
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
X-Proofpoint-ORIG-GUID: BqucVcjZx0K5UVv6t6SuUHmg1ofbKVKp
X-Proofpoint-GUID: BqucVcjZx0K5UVv6t6SuUHmg1ofbKVKp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_21,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 malwarescore=0 impostorscore=0 mlxlogscore=751
 mlxscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404050136


On Mon, 25 Mar 2024 14:08:09 -0700, Stephen Boyd wrote:
> These debug prints are missing newlines, leading to multiple messages
> being printed on one line and hard to read logs. Add newlines to have
> the debug prints on separate lines. The DBG macro used to add a newline,
> but I missed that while migrating to drm_dbg wrappers.
> 
> 

Applied, thanks!

[1/1] drm/msm: Add newlines to some debug prints
      https://gitlab.freedesktop.org/drm/msm/-/commit/c588f7d67044

Best regards,
-- 
Abhinav Kumar <quic_abhinavk@quicinc.com>

