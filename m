Return-Path: <linux-kernel+bounces-162807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5B38B60CB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 579A8285DFF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A5612839D;
	Mon, 29 Apr 2024 17:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FhOuAbcv"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DB8127E24;
	Mon, 29 Apr 2024 17:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714413237; cv=none; b=eZi5gQ+rYeLMCk3MqmHuT1V4baS3VIRry71OJbKD2uTcAx/1SYaEYcm/gxGft5dMFDXS5GLad7sYPNI3hJpymHluSk+Y0CKGD4kSsZ9zlMdI3Cn7Hn0o1FMyItIihnK0Zs8wWrX0qlJL37BVjRKIAViEn+BRbhvxVaBl+zfs/5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714413237; c=relaxed/simple;
	bh=Mu2xjdBMiMwzwUS/tqROHZIqj20yWyChjQNECrOchpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CKJ2EYj8RkErsC8qGDiC33lhDjSTQN6IHZDNl5xA1MYryfZk3fpBtcptZMhmmGLKbv3uz2t/71k2Gvag3v/y2xDFQngUFYzhUfF9oIjy6YXvJQxNt1zios2twhK2gsxIQLTtQEAQE74JjYiddbwrorK/OkQDBKBCAY8fYLfsaIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FhOuAbcv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43THrFSO032615;
	Mon, 29 Apr 2024 17:53:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=lZgKyo7o04rm3Pl0yI1YOAtST2FJkyWDoNpEAjU+5l8=; b=Fh
	OuAbcvgnQAuwV50ND7eujhtqFT2Yz15LxKfmXy1Ca25VYzWa8/4M+Gne5PUZNIud
	2guuI6o1n+Srf6ysvhUDocW0PY/pZt7DycTn46f52IJW3gmXiI8KVznqBMJ0Q3HY
	FPI/6fMZvD2NtraLWCKx5A4pnNicXhUkbnDv707ws5QEty5E/XBZLTr4e7FwZ0TH
	VGpEi6sQDr+2siMzyimm0c49cn9EjgV5yhBNAYab3U8C8KUxkVfMnfCeuUl+crax
	6Q/TtEh2wBKz3x0Jo1hXvsDAJ6bn2CEn9DhwBNQAdc5Xiq/dsc/T+cCkalfQTYBr
	rzEfFDH1WGAnkZvvthsA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xt5xkb1yy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 17:53:51 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43THroJf007571
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 17:53:50 GMT
Received: from [10.71.110.192] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 29 Apr
 2024 10:53:47 -0700
Message-ID: <2f5e514a-cb49-4c10-a3bd-76b517032953@quicinc.com>
Date: Mon, 29 Apr 2024 10:53:46 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] of: reserved_mem: Remove the use of phandle from the
 reserved_mem APIs
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
CC: <saravanak@google.com>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>, <devicetree@vger.kernel.org>
References: <20240422235243.2878536-1-quic_obabatun@quicinc.com>
 <171440638161.1895148.11194020129017609758.robh@kernel.org>
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
In-Reply-To: <171440638161.1895148.11194020129017609758.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3EcTqAjlXgGAR5Ko14Jbzt8DH354LLOk
X-Proofpoint-GUID: 3EcTqAjlXgGAR5Ko14Jbzt8DH354LLOk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_15,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 mlxlogscore=687
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404290115


On 4/29/2024 8:59 AM, Rob Herring wrote:
> On Mon, 22 Apr 2024 16:52:43 -0700, Oreoluwa Babatunde wrote:
>> The __find_rmem() function is the only place that references the phandle
>> field of the reserved_mem struct. __find_rmem() is used to match a
>> device_node object to its corresponding entry in the reserved_mem array
>> using its phandle value. But, there is already a function called
>> of_reserved_mem_lookup() which carries out the same action using the
>> name of the node.
>>
>> Using the of_reserved_mem_lookup() function is more reliable because
>> every node is gauranteed to have a name, but not all nodes will have a
>> phandle.
>>
>> Nodes are only assigned a phandle if they are explicitly defined in the
>> DT using "phandle = <phandle_number>", or if they are referenced by
>> another node in the DT. Hence, If the phandle field is empty, then
>> __find_rmem() will return a false negative.
>>
>> Hence, delete the __find_rmem() function and switch to using the
>> of_reserved_mem_lookup() function to find the corresponding entry of a
>> device_node in the reserved_mem array. Since the phandle field of the
>> reserved_mem struct is now unused, delete that as well.
>>
>> Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
>> ---
>>  drivers/of/of_reserved_mem.c    | 26 +++-----------------------
>>  include/linux/of_reserved_mem.h |  1 -
>>  2 files changed, 3 insertions(+), 24 deletions(-)
>>
> Applied, thanks!
Thank you!
>

