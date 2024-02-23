Return-Path: <linux-kernel+bounces-79306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 095EF862095
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65318284604
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B02514D42B;
	Fri, 23 Feb 2024 23:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WFnNPflj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3302D1EB34
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 23:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708730493; cv=none; b=u+TF7NarduP5I5S5m8PFb6/OdJVgf9FcyfWuFJRcjW5veQDa5SOSt9NoxPoigjaqqVLWh4QHbJbqQ1zd8J1G3fLBWLNQ80YaUM/gvW6RtVGiK8gh9DCNHylvtPh4KdDGyRXY62bPtHbqjWanZQJMVUkso6Ql4EZwxcUQiUL7pXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708730493; c=relaxed/simple;
	bh=xscoC/V7feI+XaMIY8rQRrTAXP1mzokg/ZRXXRswI1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bCqbqIBA9Enfc16N2EAzFnZ7tpPzZWWeFHpKKgQn1IFtJd8KL9yyRl6G6hlL4tufZjlg3WG9AqRH92DDVGtZi0QIsC1jzl64lYyTIHO+HvYjEnttEtseiSU1n79w8FJer/k65L3qF6LpKau/qJlDU60OiEoHl4zaNlNgHPh5WXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WFnNPflj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NNGc5Q009854;
	Fri, 23 Feb 2024 23:21:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Lv8kK7ptZjOhqG6I8U4WtzwN64CZSv0zam2PuJamwfc=; b=WF
	nNPfljQA/UQ1MEVspoZLGrxPtMjKZthGAgSdzzd/CKVbs9n5tGEHKijqDixlB4j2
	By6wEenYhnrwDdWx7sUK4Oz6MmP4HO26XPUINl5cWoMQXoJJfGwYUEi/vJCgsdYw
	Pm6Hp1CSRBYmWSt7mTt2GCPHtG4Rxg8Lwj8lz1E+Be/HQmVMb6ONGA1g/Dpnv58l
	W39Ma7/Bhop8PPIPs/nSagXnw360T2/S3+KGIi7/XQCvQg4mbDlTo49UpVnWSlMe
	lWAq0nSLAs+LaUiYJLPxO3/rGAuNrTKj8CMUXpZSRU4Xp7H3ulx/w7muw+wHQ9Ka
	n6HrcRU2hncAjIrFqt5g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3weqxd1tkp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 23:21:25 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41NNLPle021564
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 23:21:25 GMT
Received: from [10.110.73.113] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 23 Feb
 2024 15:21:24 -0800
Message-ID: <9d58dfb9-bb1e-ff58-5abd-e2a9d9595446@quicinc.com>
Date: Fri, 23 Feb 2024 15:21:24 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] accel/habanalabs/hwmon: rate limit errors user can
 generate
Content-Language: en-US
To: Oded Gabbay <ogabbay@kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC: Ofir Bitton <obitton@habana.ai>
References: <20240220160129.909714-1-ogabbay@kernel.org>
 <20240220160129.909714-10-ogabbay@kernel.org>
From: Carl Vanderlip <quic_carlv@quicinc.com>
In-Reply-To: <20240220160129.909714-10-ogabbay@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xrK019jIS6Eo8zFlHgCvIp7fhI1AWL6I
X-Proofpoint-ORIG-GUID: xrK019jIS6Eo8zFlHgCvIp7fhI1AWL6I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_06,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=615 malwarescore=0
 suspectscore=0 phishscore=3 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230167

On 2/20/2024 8:01 AM, Oded Gabbay wrote:
> From: Ofir Bitton <obitton@habana.ai>
> 
> Fetching sensor data can fail due to various reasons. In order
> not to pollute the kernel log, those error prints must be
> rate limited.
> 
> Signed-off-by: Ofir Bitton <obitton@habana.ai>
> Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
> Signed-off-by: Oded Gabbay <ogabbay@kernel.org>

Reviewed-by: Carl Vanderlip <quic_carlv@quicinc.com>

