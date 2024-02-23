Return-Path: <linux-kernel+bounces-79298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D279886207F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BD79283611
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9531814CADB;
	Fri, 23 Feb 2024 23:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VeBdkj71"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633CF14CAD1
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 23:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708729814; cv=none; b=sWh3tEvN2XbdE/c7onqsfjZUmZtEN5QnMC3DjzBrE8oDh54P1aeeBAuPoSuCr5LuRDY73gCWyarTyzwFyQ8/kVtWzlVY5LUNV4rUdgu+dCCsZUiyRObS2SBjtaBiHER9h20VESgixis4C0FUkkPDmN6QPdCKud0CQLtTLWGBK94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708729814; c=relaxed/simple;
	bh=ohmHgBARl2DYBpvn4i6d5NMSBMYp2gUexfLn0TpJ6kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OaAUOAu3YZrrBuM890KZ/hDU/hpud4gKBIQYWjFj7wUKRx3fru0Or2HykXaIDj7ItmEJThMTiJxKSApm15MDR86KGMgoX1rn7vE1kqCNW25MCdWxO4RR8A5m+IcBOHJu30TnKZgdAjpj5Pj609hvWlPfuYaQe3Bk+V595COsQQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VeBdkj71; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NKXf77006489;
	Fri, 23 Feb 2024 23:10:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=zJI42VOR+e2dmgHGLNSGex3DllroWTVPuenFO8Y7c9w=; b=Ve
	Bdkj71uNz+2m1BTXcf4kyRQKcNZiI+kInbBiEei3m7pAayOM1tJDS6ArT+uI8c6D
	2Eo6ENEOO3eE3BOMO/LnH04J4aJQXDZq2hRJylQd8c8hWWD5JRyyNZt1koVLayzH
	Nwx6lOHNRur7OLaALoQMizFSMavutedQLOz47CaZiWKAl4FMXZwzzerb3vUBSbZj
	9xLGjwLf986o+66+LHMLYy3rjSdR4azcTINm4X3x7QFl0je9N8ykhBG7Y1dRWDP0
	hMe4xUyylpEGOf9newj6szg4yhpJaiZ8U80Jz4Yx+Epedtde+ng80/N3c33KI5Iv
	fY6O/qRILn6FEnE6n2mA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wekveta8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 23:10:06 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41NNA53Q022130
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 23:10:05 GMT
Received: from [10.110.73.113] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 23 Feb
 2024 15:10:04 -0800
Message-ID: <1bf4de9d-da3c-b42e-9055-d135ca859085@quicinc.com>
Date: Fri, 23 Feb 2024 15:10:04 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] accel/habanalabs: fix debugfs files permissions
Content-Language: en-US
To: Oded Gabbay <ogabbay@kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC: Avri Kehat <akehat@habana.ai>
References: <20240220160129.909714-1-ogabbay@kernel.org>
 <20240220160129.909714-6-ogabbay@kernel.org>
From: Carl Vanderlip <quic_carlv@quicinc.com>
In-Reply-To: <20240220160129.909714-6-ogabbay@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Q4THYx-IsHBC-7k1_7yY7xOS2zLnGNGW
X-Proofpoint-ORIG-GUID: Q4THYx-IsHBC-7k1_7yY7xOS2zLnGNGW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_06,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 impostorscore=0 clxscore=1011 spamscore=0 phishscore=0 mlxlogscore=792
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230166

On 2/20/2024 8:01 AM, Oded Gabbay wrote:
> From: Avri Kehat <akehat@habana.ai>
> 
> debugfs files are created with permissions that don't align
> with the access requirements.
> 
> Signed-off-by: Avri Kehat <akehat@habana.ai>
> Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
> Signed-off-by: Oded Gabbay <ogabbay@kernel.org>

Reviewed-by: Carl Vanderlip <quic_carlv@quicinc.com>

