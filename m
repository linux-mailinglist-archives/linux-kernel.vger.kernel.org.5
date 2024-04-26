Return-Path: <linux-kernel+bounces-159885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A548B3574
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AA401F21CA8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B349F143886;
	Fri, 26 Apr 2024 10:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BMYqoYBg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7913977F30;
	Fri, 26 Apr 2024 10:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714128157; cv=none; b=sYLmdIERL7rd1EFmwzNcuMK22RPUIPFPgvdRXnVxkek46C1NMHVaaBp+TMESgx84woJmtPZGFojK8vCg0xw+Q0GkwxTN/fHcyq9kRAJHDHtXtCNScu61qWECG+qMmvZnKTR2qLw5OrWET6uhvAiPqf7HkMDuWBDkzgYGif2NJzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714128157; c=relaxed/simple;
	bh=5jZaOy2PhOKuK73pSktlLzYYq/UWVVx/cSl8pNjughE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=K8zmsSAH3Uklt+sRIlNmcwm0Bsg2WLN1DnYKqPSKcB4svKT6hLYikVx6fVRs6NISN9Z/bUxcx3IwCi+a1qeZv6HMgfgHXbHwU+GPhknQBWbI2EFG9KP9HpHbaZ70P0VjGC8RsaWgGx7npoCxYVTj9MfXyfSXXrOTptg2IH2MhAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BMYqoYBg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43Q5dPXV021276;
	Fri, 26 Apr 2024 10:42:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=y2MVu4mhZFEgMJCbHWI/1+jaRluiMvPd1GS4dy8pZOk=; b=BM
	YqoYBgh6NVvdOvYfTbMTxTdk3uvrtuOWlz3A45bNkksfyk5xGgf5PuytrLpp0+OW
	nTjwJpGeqg0P+6c4SMtVxoQ3PF6PZJIQzgFJH6S63EBrpEfzcR+rKHt8kHekjBLb
	WcW+bzzXKSXVPW2gY+Wza9Ze6BPb2oTAcdv3vvUJDXvM45nCygw2abFXXtGBu1Yz
	WUwmSoJWef1uSfVFRxEAhiZ/o3kaU003+iTzB0t6BRabSpH8/wgp99r9Yalcv28C
	8LHKUzR1NTPgueKqsZbz6/tTVExju5cXpMuDdt/h5WcWqs0AvbsG/xl2s2zB6APw
	Ykg3xjbe2x3Wxil/MFiA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xr1ne9r4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 10:42:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43QAgLDZ018475
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 10:42:21 GMT
Received: from [10.216.47.179] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 26 Apr
 2024 03:42:13 -0700
Message-ID: <c10c94c4-5239-46d3-9b41-95e3c943e969@quicinc.com>
Date: Fri, 26 Apr 2024 16:12:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: qca: fix invalid device address check
Content-Language: en-US
From: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
To: Johan Hovold <johan@kernel.org>
CC: Doug Anderson <dianders@chromium.org>,
        Johan Hovold
	<johan+linaro@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        "Luiz
 Augusto von Dentz" <luiz.dentz@gmail.com>,
        Matthias Kaehlcke
	<mka@chromium.org>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, Stephen Boyd
	<swboyd@chromium.org>,
        <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>
References: <20240416091509.19995-1-johan+linaro@kernel.org>
 <CAD=FV=UBHvz2S5bd8eso030-E=rhbAypz_BnO-vmB1vNo+4Uvw@mail.gmail.com>
 <Zid6lfQMlDp3HQ67@hovoldconsulting.com>
 <CAD=FV=XoBwYmYGTdFNYMtJRnm6VAGf+-wq-ODVkxQqN3XeVHBw@mail.gmail.com>
 <ZioW9IDT7B4sas4l@hovoldconsulting.com>
 <c9ea5867-2db2-4f64-a1e3-f6c2836dd45d@quicinc.com>
 <Zip9vMHa2x-uW-pf@hovoldconsulting.com>
 <bb0e1baf-7e64-463a-8638-d403c7a29317@quicinc.com>
In-Reply-To: <bb0e1baf-7e64-463a-8638-d403c7a29317@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MLPPBesPkqd5KEe_zglqxKt6jhGKWm84
X-Proofpoint-GUID: MLPPBesPkqd5KEe_zglqxKt6jhGKWm84
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_09,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404260070


Hi Johan,

Please note BDA values listed below are in the firmware (FW) data
order, but the actual BDA value should be in the reverse of that order.

On 4/26/2024 11:53 AM, Janaki Ramaiah Thota wrote:
> 
> 
> On 4/25/2024 9:28 PM, Johan Hovold wrote:
>> Hi Janaki,
>>
>> On Thu, Apr 25, 2024 at 08:31:50PM +0530, Janaki Ramaiah Thota wrote:
>>
>>> Apologies for the delay. As of now, we have observed the following
>>> values in the upstream firmware files for default BD addresses.
>>> We will confirm ASAP if there are any changes.
>>>
>>> ---------------------------------------------------------
>>> |   BDA            |      Chipset                       |
>>> ---------------------------------------------------------
>>> | 20 00 00 10 80 39  | WCN3988 with ROM Version 0x0200    |
>>> ---------------------------------------------------------
>>> | 00 08 74 12 80 39  |  WCN3988 with ROM Version 0x0201    |
>>> ---------------------------------------------------------
>>> | 00 07 64 21 90 39  |  WCN3990                    |
>>> ---------------------------------------------------------
>>
>> Thanks a lot for these. I see now that the default Trogdor address Doug
>> reported (39:98:00:00:5a:ad) appears to comes from the fw too:
>>
>>     $ od -x crnv32.bin | grep 5aad
>>
>>     0000020 0000 0000 5aad 0000 3998 0008 0008 0000
>>
>> which means that patch I sent this morning should be all that is needed
>> for those machines at least.
>>
> 
> Yes correct, it will work for Trogdor
> 
>> Can you please confirm that all the WCN39xx have OTP storage for an
>> address that an OEM can choose to use?
>>
> 
> We are checking with internal FW team, will confirm on it.
> 
>> If that's not the case then we could simplify things by always marking
>> their addresses as invalid, but I assume that they all have address
>> storage.
>>
>> Johan
> 
> -Janakiram

-Janaki Ram

