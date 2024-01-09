Return-Path: <linux-kernel+bounces-20610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A5C82825E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B6A2281CB2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1332E83D;
	Tue,  9 Jan 2024 08:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SuhjkCPm"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398C92E636;
	Tue,  9 Jan 2024 08:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4096fE0p006338;
	Tue, 9 Jan 2024 08:43:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=BGibbLuPsp6YqJ9RGSe1cHagl2jLZ2fUPegRL4mMGKs=; b=Su
	hjkCPmGfC9mIlqDcxdKxhVpvVCMtFIqmk3qiOG48qOe93iC7AqWGse1H3Re9rhO/
	xGW4DQfGeRBtkcaTZwqWuSuty0Tc++3hodT+Zgf5u+ppYpzrZlNhNQphj5xC9Arm
	/X6sKkRrW9HN5bDRYWyjoMp8Wn8yB/0eBiFt5lunTcqz6NPD8TqrSppnbL7hs9rh
	nk3PgYCFHHpdwPw/momyqggqKCcOFffOPFIN19AFAAY64ow1uzwwAFAO/BSFUlBH
	aECfqq9ukbVIkouqP6cOYQEA/aOgJ6097y6UpHRde3htF6JQkOQkIerCFbwXyCls
	t+3qCdg9J1EF0Ssz4/PA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgwq1rjxs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 08:43:19 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4098hIn8022107
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 08:43:18 GMT
Received: from [10.253.78.145] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 9 Jan
 2024 00:43:15 -0800
Message-ID: <78b0b2c0-20b5-4682-8020-335395d0af68@quicinc.com>
Date: Tue, 9 Jan 2024 16:43:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bus: mhi: host: Add sysfs entry to force device to enter
 EDL
Content-Language: en-US
To: Jeffrey Hugo <quic_jhugo@quicinc.com>, <mani@kernel.org>
CC: <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_cang@quicinc.com>,
        <quic_mrana@quicinc.com>, Bhaumik Bhatt <quic_bbhatt@quicinc.com>
References: <1703490474-84730-1-git-send-email-quic_qianyu@quicinc.com>
 <cff4b828-9566-a2bd-287a-138d74a76a59@quicinc.com>
From: Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <cff4b828-9566-a2bd-287a-138d74a76a59@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sMM0X-rw5YV5v5z0lL21EP0t4MCX79PI
X-Proofpoint-ORIG-GUID: sMM0X-rw5YV5v5z0lL21EP0t4MCX79PI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 impostorscore=0 mlxlogscore=706 spamscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090068


On 1/2/2024 11:31 PM, Jeffrey Hugo wrote:
> On 12/25/2023 12:47 AM, Qiang Yu wrote:
>> From: Bhaumik Bhatt <quic_bbhatt@quicinc.com>
>>
>> Forcing the device (eg. SDX75) to enter Emergency Download Mode involves
>> writing the 0xEDEDEDED cookie to the channel 91 doorbell register and
>> forcing an SOC reset afterwards. Allow users of the MHI bus to 
>> exercise the
>> sequence using a sysfs entry.
>
> I don't see this documented in the spec anywhere.  Is this standard 
> behavior for all MHI devices?

This is documented in MHI spec v1.2, 13.2 Emergency download (EDL) mode 
cookie. So I think

it is standard behavior. At least, SDX65 and SDX75 support it.

>
> What about devices that don't support EDL mode?
>
> How should the host avoid using this special cookie when EDL mode is 
> not desired?

Can I include another flag in mhi_pci_dev_info and mhi_controller and 
check this flag

before writing EDL cookie?

>
> -Jeff

