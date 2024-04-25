Return-Path: <linux-kernel+bounces-158770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 256208B24AC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE8211F23A91
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3838414AD2E;
	Thu, 25 Apr 2024 15:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="awg59QXp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C25F14A087;
	Thu, 25 Apr 2024 15:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714057665; cv=none; b=TaWKQTm3NvomcQo0J/Ej6u6xgkH3YcR68X87QkQzhmfckPaMI61bqXcneP9y2/ESoPguRZihHKA3/AizkvfRArNvXGec6CQFBcyZSn2UVoO0uHr8smTkUmWwADkU8YaN5cKpxTXUIfMjMxQ9a/VGQTJsnll3vKXppkmz1o75pDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714057665; c=relaxed/simple;
	bh=+w1M8pWXIufZllVT2cd3eQpABjwHYXsC6tCfmPGVsH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bmertAnWWQGOR0Im/vS5ZZdGc7M8GSOoNI2sLaNkihU+JJpX4h39pLmqhl0DkRirZcwdfmyEJTay6RLyEqlJGCnHURUCKmCijT1+T1A+NcfF55gqTYcK/RHfZxio0XOqnxzwNKdo85b2x3INEhs6RZSXqEHurtYvb7Dt2ieyWKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=awg59QXp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PB1PWA023589;
	Thu, 25 Apr 2024 15:07:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ria7m5Fq40+4Cm6u2kT5RdP6PQUlD1XkRAAq94umFJs=; b=aw
	g59QXpAgz7CmdvOqVDFUcpvpvw7CtOLzTXf7Y3/56on9W+7OctnR6DdQbe0buJJr
	VeBnd92Hfw8P+J2IuZaN7qNW3FmyAZbMn765kBMHnOgBFmUI2wLiAEKguQ7Oumw/
	0JHH/RppxhGUN6xInhDPDGA+fRzJaOriOxNPKbBGa6o4pP+Rau8ooWb6aC+1Je6K
	HxWVL0xyCuo9CTVScFTPcl5y714TMvst5PVs3feJaM3MYtp1KADv/8B7W6ycnaVN
	ismnRf7quzN5ugPMjGiCl5ouaraI7cUKRFtgFJX2OyDWVn+DzoriSnN1kdaC5xC6
	jyr4kIpn0zmhm8nlXRYA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqenkjx7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 15:07:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PF7dbF016481
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 15:07:39 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Apr
 2024 08:07:38 -0700
Message-ID: <e0fb41f3-3080-c1b5-ab7c-bcff8bbbe754@quicinc.com>
Date: Thu, 25 Apr 2024 09:07:37 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v5 1/3] bus: mhi: host: Add sysfs entry to force device to
 enter EDL
Content-Language: en-US
To: Manivannan Sadhasivam <mani@kernel.org>,
        Qiang Yu
	<quic_qianyu@quicinc.com>
CC: <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_cang@quicinc.com>,
        <quic_mrana@quicinc.com>
References: <1713928915-18229-1-git-send-email-quic_qianyu@quicinc.com>
 <1713928915-18229-2-git-send-email-quic_qianyu@quicinc.com>
 <20240425145450.GH3449@thinkpad>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20240425145450.GH3449@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XkQ7qP8xCQZjU6tIZTPgFP0kzmrh0Vhc
X-Proofpoint-GUID: XkQ7qP8xCQZjU6tIZTPgFP0kzmrh0Vhc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_15,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxlogscore=819 priorityscore=1501 impostorscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250109

On 4/25/2024 8:54 AM, Manivannan Sadhasivam wrote:
> On Wed, Apr 24, 2024 at 11:21:53AM +0800, Qiang Yu wrote:
>> Add sysfs entry to allow users of MHI bus force device to enter EDL.
>> Considering that the way to enter EDL mode varies from device to device and
>> some devices even do not support EDL. Hence, add a callback edl_trigger in
>> mhi controller as part of the sysfs entry to be invoked and MHI core will
>> only create EDL sysfs entry for mhi controller that provides edl_trigger
>> callback. All of the process a specific device required to enter EDL mode
>> can be placed in this callback.
>>
>> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
>> Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> 
> All 3 patches are applied to mhi-next with my reported changes! Since you are
> doing upstreaming for some time, you should know that the changelog _must_ be
> present in the patches itself or in the cover letter.

It is/was in the cover letter.  Was the format not to your liking?

-Jeff

