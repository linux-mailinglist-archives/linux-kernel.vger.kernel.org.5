Return-Path: <linux-kernel+bounces-78678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B73861720
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BA38285D99
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D221129A94;
	Fri, 23 Feb 2024 16:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="k+zVQjvr"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D05839FB;
	Fri, 23 Feb 2024 16:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704507; cv=none; b=KigkX1yXZm95CoVTyxCcg30eiaEpFgPYFnT8VJ4yVffF2hgwBugcaL/Z7OidrNkWE27acaSXfyVXqOaD/vZGizpcZc9VmvwMhD2lxBNaX7FwvU+qRq4HDFZhx5/GMsiiN7RScpkCLfjUuEH1Z76E7DT4KtSwHhN3nL7s4RI0T2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704507; c=relaxed/simple;
	bh=lgbREh7v0NnG/ICl5sLmpbx22EKj66y9siwDJ5sOCG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=m5Jw81aKWy/gHtTVM/O2NyeXDnlriK2I++ju0Kpeo/LsOe0/qww8ZGKJg/+e5IIJArmCgj7UOYTuS6eZdW5t/7NL3J49LPaLQCNuUrwREuluA9Hg0YJ1OyY3A7pTfE51qbsNJfWYOQAXUCVrZFV5QpX7xPHja3UrkBcrkyiMow8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=k+zVQjvr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NDNanl018265;
	Fri, 23 Feb 2024 16:08:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=SccUfYPJX3UO95qLD6HfOHJFsJDW0CMTKEANJbGg3V4=; b=k+
	zVQjvryPwSZKjaNrcsnhUstJ4UUyKh5p0H3KOJUUlvjxURSmLQJQ7Q+9KZZwxiTL
	tivnLzLcjkIq80ONJ6IRLx/Xs1rinAt7tQ0Nv3jqRO0oVIw3Ub5NnRcdZ+odbKjh
	q/7zichH2AR0qQv9c4PWSUKZmqYKDhUsYm+PiqG+xflrCK1hAQdbAqzw4YRL9cZ0
	cAvlKgKQmrtTg91D72M2L5XilucCwlHv44bc0ysXDoY1DBC9vILz0hgEbzVlD17H
	FYif6h+ZEIJq2uv5ruSd0AgWV8FK3wSkf1pu/pWw769rc6YonMppmECYT4VHGIZ0
	SwNJs52uQRkUWuZcL3Gg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wer8ms0m8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 16:08:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41NG8GNA016082
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 16:08:16 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 23 Feb
 2024 08:08:12 -0800
Message-ID: <c1bd881c-2181-8fd1-e28c-1a34fee2ffa8@quicinc.com>
Date: Fri, 23 Feb 2024 09:08:12 -0700
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
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qp9esPXD3y-RZVk2Q7fnVK_CtCQ7KlQF
X-Proofpoint-ORIG-GUID: qp9esPXD3y-RZVk2Q7fnVK_CtCQ7KlQF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_02,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1015 mlxscore=0
 impostorscore=0 mlxlogscore=741 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230117

On 2/22/2024 6:06 PM, Jeff Johnson wrote:
> MHI allows the channel configs to be const, so constify
> aic100_channels to prevent runtime modification.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Applied to drm-misc-next

-Jeff

