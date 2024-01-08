Return-Path: <linux-kernel+bounces-20030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5C8827869
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11493B212CA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DFA55787;
	Mon,  8 Jan 2024 19:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="W+6MyplU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88E454FA6;
	Mon,  8 Jan 2024 19:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 408JHrGL021761;
	Mon, 8 Jan 2024 19:19:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=lYLhdt2TaMhMnLwccdHPr7JOIJ9gLHN04/UeL40e/nY=; b=W+
	6MyplUU1oEFdaIUTy5zRzgxiPivmnG+kR1DMx6hG+mC4jzfYymmtTqeKQ5d0kmsK
	msqXIre8twEJsh9k+7swJNNcZVXJE/ZtwFgcHNW6mMEbpd/o8cw1VDe9XvBE9mOT
	escN8SM2V0zDg/oAOrI6Ru4CxgAdnhLTCPQSWmgXnFYpFtyoSFgQci4XtlsxT9tk
	LhG0Cg1Nh12ts1Lu2tGzySyrS9MGranY4IE+NeQR60ZSoQ5PRCPR4ZMD6fMqOqbg
	+Y1LpyjrHHzQgw9GWqVDDdbFSz21fkSSMO+v1RKMEfquoPxGbudFFGWjnMgXUPGG
	1SobtKdXrji1kis4XHrQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgq2yr03m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 19:19:10 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 408JJ9bp028859
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jan 2024 19:19:09 GMT
Received: from [10.110.97.125] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 8 Jan
 2024 11:19:08 -0800
Message-ID: <39f9f842-5e40-13af-beff-0078d5a92cce@quicinc.com>
Date: Mon, 8 Jan 2024 11:19:03 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v12 00/41] Introduce QC USB SND audio offloading support
Content-Language: en-US
To: Hillf Danton <hdanton@sina.com>
CC: <gregkh@linuxfoundation.org>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
References: <20240102214549.22498-1-quic_wcheng@quicinc.com>
 <20240106085403.3076-1-hdanton@sina.com>
From: Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <20240106085403.3076-1-hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: U6xr9sxnidqsUesypQZL-q3pZUjixxeQ
X-Proofpoint-ORIG-GUID: U6xr9sxnidqsUesypQZL-q3pZUjixxeQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=607 clxscore=1011 priorityscore=1501 phishscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401080159

Hi,

On 1/6/2024 12:54 AM, Hillf Danton wrote:
> On Tue, 2 Jan 2024 13:45:08 -0800 Wesley Cheng <quic_wcheng@quicinc.com>
>> Changes in v2:
>>
>> XHCI:
>> - Replaced XHCI and HCD changes with Mathias' XHCI interrupter changes
>> in his tree:
>> https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/log/?h=feature_interrupters
>>
>> Adjustments made to Mathias' changes:
>>    - Created xhci-intr.h to export/expose interrupter APIs versus exposing xhci.h.
>>      Moved dependent structures to this file as well. (so clients can parse out
>>      information from "struct xhci_interrupter")
>>    - Added some basic locking when requesting interrupters.
>>    - Fixed up some sanity checks.
>>    - Removed clearing of the ERSTBA during freeing of the interrupter. (pending
>>      issue where SMMU fault occurs if DMA addr returned is 64b - TODO)
>>
>> - Clean up pending events in the XHCI secondary interrupter.  While testing USB
>> bus suspend, it was seen that on bus resume, the xHCI HC would run into a command
>> timeout.
>> - Added offloading APIs to xHCI to fetch transfer and event ring information.
>>
>> ASoC:
>> - Modified soc-usb to allow for multiple USB port additions.  For this to work,
>> the USB offload driver has to have a reference to the USB backend by adding
>> a "usb-soc-be" DT entry to the device saved into XHCI sysdev.
> 
> Could you tip point to where the usb-soc-be DT entry is added?
> 

Intention is that the USB class driver needs to be able to reference the 
ASoC DPCM USB backend dai, so the entry has to reside somewhere within 
the USB bus.  In our case, it would be within the device node which is 
saved under the bus->sysdev (XHCI based).  Specifically, for a DWC3 
based implementation, it would be within the DWC3 node.

Thanks
Wesley Cheng

