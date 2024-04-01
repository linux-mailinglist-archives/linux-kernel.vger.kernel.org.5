Return-Path: <linux-kernel+bounces-126837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 736FD893DB8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1367D1F22ED2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8ED535C4;
	Mon,  1 Apr 2024 15:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="L8i+EQ+I"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068D4481DB;
	Mon,  1 Apr 2024 15:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711986879; cv=none; b=pvxuSv7d6PTiXzBFkq9RDafZmr1GqLi9czLSI3bU0JhdbeQxbh2mrl2SVLQgwMOIHA3QOc+qAT0AwJTb2eFmPnJq0KCyz5y5geY0wwUm6VTx7A9DRLUbuw82wvhp0dXxc91MVZxoMRrfczwpB5EiFijMoP1+MeVUrE4o5c8s0HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711986879; c=relaxed/simple;
	bh=m7eoAdTO/BKzFu9Jl2RbaqPrtSBW0xXzh2n8+x+UQdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=H8IOYwE59TtzGgup6LHQUDi83jZ6Dx1c3fp8PifQonZYrI3Wf87eQ/Pv1GV+zsgZFy5SRhvBVU1stuAbbVEHPklLWYv8Vx1O/5PV/QIYIZfDu4eavyFJ5gmdg38UcwaY8XeVU+aYeE+jrdjsGUiWfG7ySSDXpnxlWeogbHlS1oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=L8i+EQ+I; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 431A6c8T015307;
	Mon, 1 Apr 2024 15:54:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=VcChgHfKeOYZ2vjgkmVzNAEWknG0rYWnKYsVIbgSYH8=; b=L8
	i+EQ+INglfkpH1O4FOKUYlylaYVs3SmZf15aM6E+0nrzpjvY588U3yiBfJXmK1/z
	PlqNgslNLemjuWO0Cr8QhpJQvxZBWBuMWOKKPEwvxnQKflIKD63NI80KGwqSFagB
	F+tMEjZJ6JMsOm+KI8ENbzYdFCCs78+ciQKkZnptoUsP9JhC1htj0cBGY/0t51er
	iMyezYNuDatjZhLHxQ6nwviBg8yG0mndyK+8EbC75Hwwg57arTFL4mIdLTkVKHtp
	pH8nSIImQbEEITMAw35aOwIVh8ds9GoRkeFXtVVzrxdQpehM4uaIE1RYXxIB6G2F
	PR/qjfr+bXElJOZm8Qtg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x7tgqrqba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 15:54:21 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 431FsKfc014013
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Apr 2024 15:54:20 GMT
Received: from [10.110.91.214] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 1 Apr
 2024 08:54:15 -0700
Message-ID: <31f0b5d2-5b92-cc74-68bd-94fd42527a22@quicinc.com>
Date: Mon, 1 Apr 2024 08:54:14 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 RESEND 0/4] arm64: qcom: add AIM300 AIoT board support
To: Tengfei Fan <quic_tengfan@quicinc.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <keescook@chromium.org>, <tony.luck@intel.com>, <gpiccoli@igalia.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <kernel@quicinc.com>
References: <20240401093843.2591147-1-quic_tengfan@quicinc.com>
Content-Language: en-US
From: Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <20240401093843.2591147-1-quic_tengfan@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WMHuqxjh4wI1g-PgDNttw0KXqsQaFEp4
X-Proofpoint-GUID: WMHuqxjh4wI1g-PgDNttw0KXqsQaFEp4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_10,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 clxscore=1011 suspectscore=0 mlxlogscore=757
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403210001 definitions=main-2404010112

On 4/1/2024 2:38 AM, Tengfei Fan wrote:
> Here is a diagram of AIM300 AIoT Carrie Board and SoM
>  +--------------------------------------------------+
>  |             AIM300 AIOT Carrie Board             |

spellcheck

s/Carrie/Carrier ? 

-- 
---Trilok Soni


