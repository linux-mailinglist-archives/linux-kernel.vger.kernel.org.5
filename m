Return-Path: <linux-kernel+bounces-78579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 548D6861550
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E9F72867DE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFAF81ACB;
	Fri, 23 Feb 2024 15:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eJJMsG6n"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB44A5FEE5;
	Fri, 23 Feb 2024 15:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701200; cv=none; b=pIcjT5SrG4fjBpEDTDURMKzikJnciRc94jcN1wAwBrlie6x5P0ZMAymCxU2oNELjqrtIevoNG9dRYefuZe51gkgXWtroV/I6xmfqjsS1xWvpO/NwY/xCXevFWHPj8hCfSUmq3gCWVl2GKUJOrsYxkco+4iBw28iOL6yamK3hzvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701200; c=relaxed/simple;
	bh=WFnOyzagEoL2XMAHfjJHHnkD1L2Pm476EQxtsVG/O7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uQvE+HuLT3h7A8j1Tmtm+GfIDH3IUFEPJW37sIlj/G6957bpYOVj3UxWjO2GjMgm3kq9Ho6QFCKngv2257c8hFFcBy81JedKSwxQQyfVrJzOyzqv5kyrYfyRYcDEYRPsdxLRVrypKS8z0GxKkPL+Y+lyAI4+qj2bUfdzLsUc+WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eJJMsG6n; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41N9RQtH007795;
	Fri, 23 Feb 2024 15:13:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=NI4LeKwprpZtjLkpzn66X7efzVrPdTCPBGszzolQ1cE=; b=eJ
	JMsG6nCvv2k+5QyECjO4ximmOoxEkGt5yk+2i6H4Mszx0xeuels1iuT2M2OZe+ib
	7mvKGBDUNDy1XPyZ9Xsp0xwXecU6AwhYFK5+EfGI3tVK4x5Ww/6g3Wfa84XHALNN
	qdYWY0ZFEYNLsFCBzK7IrYiWywnPMD8bp7wyc1P0uxo5747QCEJixMpHkEJPDvSY
	GPX5kvEe6i9489gxseUczVYcviwYse8cveFVOkUvZkSUlb0+/qGy5Q5/BhTYqoD7
	fgZC7KoSURVIflhtniSK76fdtYw10rV1VXRzlw4izoPLlwvuL1f8mOCq0XnTsgfC
	HIAjW2jO6lnJtXwKfSkA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wer8mruj0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 15:13:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41NFDB9q020906
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 15:13:11 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 23 Feb
 2024 07:13:07 -0800
Message-ID: <add8e7de-a153-4d8e-7226-a5ec177a4223@quicinc.com>
Date: Fri, 23 Feb 2024 08:13:07 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] accel/qaic: Constify aic100_channels
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
        Carl Vanderlip
	<quic_carlv@quicinc.com>,
        Pranjal Ramajor Asha Kanojiya
	<quic_pkanojiy@quicinc.com>,
        Oded Gabbay <ogabbay@kernel.org>
CC: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>
References: <20240222-mhi-const-accel-qaic-v1-1-028db0dd9098@quicinc.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20240222-mhi-const-accel-qaic-v1-1-028db0dd9098@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CsL34TIa0p9Sz7JxxjFGxwAcZmzsryZ6
X-Proofpoint-ORIG-GUID: CsL34TIa0p9Sz7JxxjFGxwAcZmzsryZ6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_01,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1011 mlxscore=0
 impostorscore=0 mlxlogscore=825 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230111

On 2/22/2024 6:06 PM, Jeff Johnson wrote:
> MHI allows the channel configs to be const, so constify
> aic100_channels to prevent runtime modification.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

I plan to apply to drm-misc-next before the rc6 freeze.

