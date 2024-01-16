Return-Path: <linux-kernel+bounces-27600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1210F82F2C2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F619286C58
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449351CD22;
	Tue, 16 Jan 2024 16:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iZXCTlrI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5E71CD0A;
	Tue, 16 Jan 2024 16:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705424297; cv=none; b=bLsEF6fCrv9do+K8T8bV3wLO1EemtXmERz0MgydlIrdYFbTpxi3HQngsU5j02FjcoV2SR89/Lr+EvK0/za2D9vEQJj/FWxMm7ReHRc+10nTtUCJWZ9de76Hzeq+SWqjNnfBNp0Cg+wC4HdtG7bEVyizEnCDcCUdUtXDq7dn3c2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705424297; c=relaxed/simple;
	bh=EG56JEJr5SSFJa1ProkXXetHXw6Bmln8ueAcpqQwFV4=;
	h=Received:DKIM-Signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:CC:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=uAQloF64iHPTMCvZy4yAAS75WyIPXc3lel+txursAimIGINgS9BYi4YB/RMINgaOHBedtapwqw76tPxn3VJ8P2bPTzPCfkqbKfi7sKBNOuyUeEDCLQWwxBMNP5P0RJIDu+J1ki48yJUdOGHcdQJInamN0vQIYA1yrsZ1LOOIeXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iZXCTlrI
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40GE0SRq017782;
	Tue, 16 Jan 2024 16:58:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=GGCf2oVrPExymJ+LoSpyhflVsJy1oqjW5/tJ73eB70E=; b=iZ
	XCTlrIAErVdZlGVSb/i0Hn44IG2n7ptRNNEWTfgWeaRMxPgVw0V0TRLwmy+15mH5
	L/UtoABG2B4NixijR3ewBDVmHgykD+H2Tot3Fu6yTW2UBDsTs0prmJTdnRtU+OI0
	lxo6Us7c8jAddwoqqjOM1+E6vCekAvtEKo8MXHeOvB+sYYlnaluhxVmEVtUsXAqS
	a5uUTWyz8DjNTrrxVEUZIGpxk40mRzC1V4qpgQKz12cHOPIJQVARyc4dy0snPa6n
	WAoo6QpBnRHwukKm+AuZoF/6fg22a3N+IFimqZzthfc3E2+1Iagyfo7e1wnKthc2
	ElhK4/w/trbrxkAnaprA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vnq4t13k8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 16:58:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40GGw56q005399
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 16:58:05 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 16 Jan
 2024 08:58:04 -0800
Message-ID: <b4f29511-e001-4964-b88d-208dabf88121@quicinc.com>
Date: Tue, 16 Jan 2024 08:58:04 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: document HAL_RX_BUF_RBM_SW4_BM
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240111-document-hal_rx_buf_rbm_sw4_bm-v1-1-ad277e8ab3cc@quicinc.com>
 <874jfg7xm4.fsf@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <874jfg7xm4.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yQp3OW0jwCxWbxg37ISj41BS-p-b-ZMg
X-Proofpoint-ORIG-GUID: yQp3OW0jwCxWbxg37ISj41BS-p-b-ZMg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=371 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401160134

On 1/14/2024 7:17 AM, Kalle Valo wrote:
> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
> 
>> Commit 7636c9a6e7d7 ("wifi: ath11k: Add multi TX ring support for WCN6750")
>> added HAL_RX_BUF_RBM_SW4_BM to enum hal_rx_buf_return_buf_manager. However,
>> as flagged by the kernel-doc script, the documentation was not updated:
>>
>> drivers/net/wireless/ath/ath11k/hal.h:689: warning: Enum value 'HAL_RX_BUF_RBM_SW4_BM' not described in enum 'hal_rx_buf_return_buf_manager'
>>
>> So update the documentation. No functional changes, compile tested only.
>>
>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> 
> I'm not really a fan of kernel-doc in wireless drivers, it feels more
> unnecessary work. Should we remove the kernel-doc markings from ath11k
> altogether?

Are you not a fan of kernel-doc format specifically, or not a fan of
documentation at all?

I'm personally a fan of documentation since good documentation makes the
code more maintainable. Yes, there is a cost in creating and maintaining
the documentation, but this is hopefully offset by cost saving when new
developers are trying to understand and modify the code.

I'm also a fan of consistency. And since kernel-doc is the standard
format defined for the kernel, it is my personal preference to use that
format.

I'm curious what others think of the ath10/11/12k level and style of
documentation.

/jeff

