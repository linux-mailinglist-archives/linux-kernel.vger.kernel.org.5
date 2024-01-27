Return-Path: <linux-kernel+bounces-40962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8612883E901
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 02:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007AD1F28243
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F429470;
	Sat, 27 Jan 2024 01:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="l3dh4Mx+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102C68BFA;
	Sat, 27 Jan 2024 01:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706319312; cv=none; b=ZPhVxlMelWHEnvKfJEWYQKD8zs9i5vNn6e4YK/UDPx3pJe2vGHDcr02Ic84+DnS/W0tbvQpGfth1syqj268+Yh/EIMqQZlsTejm6oNueIw4jrbmAybdWCovEJqp2vd42jOVcrGmg3BEJxQMHCGIQiQi2hlFS0BJisxoWkDGLNMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706319312; c=relaxed/simple;
	bh=RAt4TGYj4CDfNMAaFwl+npvlbK5AdVGTFwYU7wwV5VI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IkdumZSYjekl9D6HxyhUwiBwpDnSrDcE8jJ1svK07A/DIz5HJgt+A1CZKRZzprJPdrbL7zxGwaxlUcnxcuXULXRJ23hCfGJGXkMIQfVCu1CdWY0/bIYT4VQFppHXomdaqZNQfqBcpfBk6fJbEVXHvFHqo+3x8DhwsH7GYTOT4Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=l3dh4Mx+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40R1IMEa029647;
	Sat, 27 Jan 2024 01:35:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=IfiXA3f8VWPIlfEHVXfTSgzZqC70I0cKMaf6Mgip5TY=; b=l3
	dh4Mx+DMGZEO9Dl+yNrINrUNGTlLpBtDJFhBSxPV2qbAg8XH89MFFF1qPsFVV4P3
	z5oV0UrnMkf08+jQv0XqRX8vvmaZvxMC2GexTyEqzasOxeOctXg1hQFCQJobx044
	dbjr8u+0C1f5EgeC5QQpzDutUURQDwx0DP7fy/UDJ+gWh+JWUKuDTpuxukV/jZdj
	yeCY1xNZwcuJ9kPb+AAB4V5H9cXVod0GEmeTelA2S7tuUckkM1I4zZ9sMDcz+TzF
	XA4e6xXy6zFaTvX/5R3MTX7npEuuOGq5/CwJDWxqtACsnj+M5e4SVp1xsjKNYNCu
	DiyCzMbP8/wQ+40lk2Gg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvgp2gw54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 01:35:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40R1Z3Xt024439
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 01:35:03 GMT
Received: from [10.110.53.178] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 26 Jan
 2024 17:35:02 -0800
Message-ID: <86f3bc0b-79cf-f1ae-02a7-79c38d0292e7@quicinc.com>
Date: Fri, 26 Jan 2024 17:35:01 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3] soc: qcom: aoss: Add debugfs interface for sending
 messages
Content-Language: en-US
To: Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andrew
 Lunn" <andrew@lunn.ch>,
        Stephen Hemminger <stephen@networkplumber.org>
References: <20240117-qcom-aoss-debugfs-v2-v3-1-1aa779124822@quicinc.com>
From: Chris Lew <quic_clew@quicinc.com>
In-Reply-To: <20240117-qcom-aoss-debugfs-v2-v3-1-1aa779124822@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zTHj7lEW9V2_lMtq_HYZQTCE4IiDEGge
X-Proofpoint-ORIG-GUID: zTHj7lEW9V2_lMtq_HYZQTCE4IiDEGge
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1011 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401270010



On 1/17/2024 6:31 PM, Bjorn Andersson wrote:
> In addition to the normal runtime commands, the Always On Processor
> (AOP) provides a number of debug commands which can be used during
> system debugging for things such as preventing power collapse or placing
> floor votes for certain resources. Some of these are documented in the
> Robotics RB5 "Debug AOP ADB" linked below.
> 
> Provide a debugfs interface for the developer/tester to send some of
> these commands to the AOP, which allow the user to override the DDR
> frequency, preventing power collapse of cx and ddr, and prevent AOSS
> from going to sleep.
> 
> Link: https://docs.qualcomm.com/bundle/publicresource/topics/80-88500-3/85_Debugging_AOP_ADB.html
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
> Changes in v3:
> - Stop passing command string straight from userspace to the firmware
> - Format the commands in the driver instead
> - Provide a few useful commands
> - Link to v2: https://lore.kernel.org/linux-arm-msm/20230811205839.727373-3-quic_bjorande@quicinc.com/
> ---
> +		qmp->debugfs_files[i] = debugfs_create_file(entry->name, 0220,
> +							    qmp->debugfs_root,
> +							    qmp,
> +							    &qmp_debugfs_fops);

With group permissions fixed:

Reviewed-by: Chris Lew <quic_clew@quicinc.com>

