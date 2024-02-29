Return-Path: <linux-kernel+bounces-86898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E0D86CC70
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80B5F1F237AC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8352C13F01E;
	Thu, 29 Feb 2024 15:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Z6x3HCOH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEB213776F;
	Thu, 29 Feb 2024 15:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709219377; cv=none; b=ro0jIntkPvNAyHXN2k46Bs2NjFdp5+j4j77dWXoiENIWEE33RTH61uNDmGLOgHxLmKqKQfIadcbD7qp3E8xC3/i4eKEeTtmpuVLDUB8IlWZEgVq3+QMSBkrC0107Wos0CBx9+lbzKBhgD2qT0XNnN46uEn7tfCMagxH3K36TMRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709219377; c=relaxed/simple;
	bh=tek9DUSGqpyfY4A1mYJ+aK0P4X9tgkILz9JjuHu4vjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RMQa2eFlqhVV1T9YNqjYI9eCAxoAkWQuvgllKvmlkminpUio1qeU1z8y/zLKe9ZK9rO9RiLEHrgWpB3oeEPESCfQr7kmgEiAUQq8LanGojqFrWtqo/5Sav5JWV0Zx/WRM0gG3rMDc8L5e2pm2qmIsR7cLdoaw53MsP+Bj9A2hnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Z6x3HCOH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41T5L4Jb009844;
	Thu, 29 Feb 2024 15:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=FuENqAaB6m4xxxysjIYTNmhvkd60JBJYJz+44lqrGUQ=; b=Z6
	x3HCOH0kVx/pcLmufD5esd7HnZkpkSLdzDeAEh8+ilHlZjCfo1kK+xjDzTNJ4WvR
	HIxHov3CPxqVaqTqGmtNLL18I5iTFhlbh3rVVvy6mZKFg5nm7hH5YzJCAEIGfT7y
	3lEbuKFCUP11Dd+hld89fbKac6HW0fi9xhxcEs0Fb2aL/cijV+UBYsN/0/zUpOoS
	oUXYrtmuYsH8clTMSKcTTMb4tTdivVPAt35iwK1t8YKfTcnAWm55O4PYq5sFZe5q
	xIV7lc8YZypTUy5/dLuEX+WeJw6zFHrgpoq5nxM3ZAzNhEEuGoE9y9Av0KMHQe6B
	cxp+2w1mw4ug8ET/AnKA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wjey3a2bh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 15:09:19 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41TF9IfM019512
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 15:09:18 GMT
Received: from [10.216.47.47] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 29 Feb
 2024 07:09:14 -0800
Message-ID: <8bf182b1-e05f-0c90-a358-e5c8bf6bd430@quicinc.com>
Date: Thu, 29 Feb 2024 20:39:11 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 00/34] Qualcomm video encoder and decoder driver
Content-Language: en-US
To: Hans Verkuil <hans.verkuil@cisco.com>, <mchehab@kernel.org>,
        <stanimir.k.varbanov@gmail.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <bryan.odonoghue@linaro.org>,
        <agross@kernel.org>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <quic_abhinavk@quicinc.com>,
        "Dikshita
 Agarwal" <quic_dikshita@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
From: Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3-EWurB-1zpOuXLBF9A3jEH-Z7CLGVlc
X-Proofpoint-GUID: 3-EWurB-1zpOuXLBF9A3jEH-Z7CLGVlc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=19
 lowpriorityscore=19 clxscore=1011 priorityscore=1501 impostorscore=0
 mlxscore=0 malwarescore=0 phishscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402290116

Hello All,

On 12/18/2023 5:01 PM, Dikshita Agarwal wrote:
> This patch series introduces support for Qualcomm new video acceleration
> hardware architecture, used for video stream decoding/encoding. This driver
> is based on new communication protocol between video hardware and application
> processor.
> This driver comes with below capabilities:
> - V4L2 complaint video driver with M2M and STREAMING capability.
> - Supports H264, H265, VP9 decoders.
> - Supports H264, H265 encoders.
> This driver comes with below features:
> - Centralized resource and memory management.
> - Centralized management of core and instance states.
> - Defines platform specific capabilities and features. As a results, it provides
>   a single point of control to enable/disable a given feature depending on 
>   specific platform capabilities.
> - Handles hardware interdependent configurations. For a given configuration from
>   client, the driver checks for hardware dependent configuration/s and updates
>   the same.
> - Handles multiple complex video scenarios involving state transitions - DRC,
>   Drain, Seek, back to back DRC, DRC during Drain sequence, DRC during Seek
>   sequence.
> - Introduces a flexible way for driver to subscribe for any property with
>   hardware. Hardware would inform driver with those subscribed property with any
>   change in value.
> - Introduces performance (clock and bus) model based on new hardware
>   architecture.
> - Introduces multi thread safe design to handle communication between client and
>   hardware.
> - Adapts encoder quality improvements available in new hardware architecture.
> - Implements asynchronous communication with hardware to achieve better
>   experience in low latency usecases.
> - Supports multi stage hardware architecture for encode/decode.
> - Output and capture planes are controlled independently. Thereby providing a
>   way to reconfigure individual plane.
> - Hardware packetization layer supports synchronization between configuration
>   packet and data packet.
> - Introduces a flexibility to receive a hardware response for a given command
>   packet.
> - Native hardware support of LAST flag which is mandatory to align with port
>   reconfiguration and DRAIN sequence as per V4L guidelines.
> - Native hardware support for drain sequence.

1. We considered enhancing the venus driver to support iris functionality but
concluded that the result would essentially be two parallel drivers implemented
in the same folder.
2. Although the underlying hardware for venus and iris are quite similar, but
there are other factors which brings the need of new driver:
   a. the host firmware interface (HFI) changed between the two. Venus supports
HFI protocol 1.0 while iris supports HFI protocol 2.0.
   b. unlike HFI protocol 1.0, HFI protocol 2.0 is better aligned to V4L2 APIs.
   c. iris driver modularize platforms, hardware variants, and states to extend
it for any upcoming SOC. Thereby more extendable to newer SOCs in future.
   d. Iris also supports many advanced features.
3. Based on the comments received on posted iris driver [1], we evaluated it
further and to better align with the upstream standard and practices, we
acknowledge that even though iris driver is the way forward, it would be ideal
to bring in the Venus hardwares enabled in this driver.
4. Hence, we decided to rework iris driver to add support of HFI protocol 1.0 as
well.
5. Initially we would start with adding support for one HFI protocol 1.0 based
platform which would be SM8250.
6. SM8250 enablement on iris driver would be incremental, starting with basic
decode for H264 codec.
7. In long-term, all venus supported platforms would be migrated to iris.
8. Iris driver and venus driver will co-exist till remaining supported targets
also gets migrated to iris driver.
9. We would continue to support and maintain venus driver during this phased out
approach.

Please share your thoughts on the above proposal.

[1]
https://patchwork.kernel.org/project/linux-media/cover/1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com/#25643473

Regards,
Vikash

