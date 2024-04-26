Return-Path: <linux-kernel+bounces-159561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DEE8B304F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDCED1F23718
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010B713A886;
	Fri, 26 Apr 2024 06:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eCBiTbHA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01C42F2F;
	Fri, 26 Apr 2024 06:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714112646; cv=none; b=c3hbU3S/TR5yllBuTHF6j5209qTPUGr5XTucP937/R9E1yn6xzxm30SbSbTOp5infrR5+UZngxHnkWLj9Gyc+fnVT2/ZqwRbZKcTCW/bf77jr+S73280tqTmgyYVSjK6zinsws5Dk6T+k+Uz1lwtTR5IhpAKPuQ4TOwnXSj1tJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714112646; c=relaxed/simple;
	bh=b2MZma9l4fy+G4zHh3Z8yNnEeOicyqWTEnp4r3RVNss=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mm4i/J9MCNMfCNSPECdBS6b+8+JMHSEG8Z1+CVAGe58F8lR0BbbKhLBEI+405FJ+dPnNBNrmG+uYBIuakEZ0FijeXzNYkWbiN0cPi4uPwtCmOSxiS/FdHDN6pC0FDKezjppjaybWqUaLO3u7NT0V7gXtZC4ofVDABLfTmFR9vJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eCBiTbHA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43Q5KETJ015548;
	Fri, 26 Apr 2024 06:23:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=IYL4Dmml/wM3KshkBFg2RgswGdKMTxaxDmvPZEY115k=; b=eC
	BiTbHAXbNFa6xXaBTIclmwcGuUZOqdH8sasA0h9I4UBgYTRXIZSE5kB+GJ8F9nL5
	X3pDZX1tFPeIpD8I0AmYF4q5r7jjJuaDRDOzkghqMRywq0TYSWEGBqARBT+646b1
	EZT8lTcnl81MvVlsNmdc3AkKye6X+CkOm36MlDw1UO2Z5eYvYdaqVORZsUH6VYIO
	iutJ8BBDD0QJAyFedlmfFnzbSQSM1e5RvaTmNdiR4QC5x6CXxcg6BENP/uV+/p8p
	DKCKAdGdFdh6U2By90acoGy9uMpvRfjEbOZ/LHdItcXSJdq3QLAhGqN1AnSampHS
	ubGdtCSP+LMlYfNs4j0A==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xr611gc0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 06:23:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43Q6NvbX002196
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 06:23:57 GMT
Received: from [10.216.47.179] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Apr
 2024 23:23:51 -0700
Message-ID: <bb0e1baf-7e64-463a-8638-d403c7a29317@quicinc.com>
Date: Fri, 26 Apr 2024 11:53:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: qca: fix invalid device address check
Content-Language: en-US
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
From: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
In-Reply-To: <Zip9vMHa2x-uW-pf@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WVySy3-XRiWsIXPMrvasnqop4nNmuV3I
X-Proofpoint-GUID: WVySy3-XRiWsIXPMrvasnqop4nNmuV3I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_06,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404260037



On 4/25/2024 9:28 PM, Johan Hovold wrote:
> Hi Janaki,
> 
> On Thu, Apr 25, 2024 at 08:31:50PM +0530, Janaki Ramaiah Thota wrote:
> 
>> Apologies for the delay. As of now, we have observed the following
>> values in the upstream firmware files for default BD addresses.
>> We will confirm ASAP if there are any changes.
>>
>> ---------------------------------------------------------
>> |   BDA	        |      Chipset		               |
>> ---------------------------------------------------------	
>> | 20 00 00 10 80 39  | WCN3988 with ROM Version 0x0200	|
>> ---------------------------------------------------------	
>> | 00 08 74 12 80 39  |  WCN3988 with ROM Version 0x0201	|
>> ---------------------------------------------------------	
>> | 00 07 64 21 90 39  |  WCN3990			        |
>> ---------------------------------------------------------
> 
> Thanks a lot for these. I see now that the default Trogdor address Doug
> reported (39:98:00:00:5a:ad) appears to comes from the fw too:
> 
> 	$ od -x crnv32.bin | grep 5aad
> 
> 	0000020 0000 0000 5aad 0000 3998 0008 0008 0000
> 
> which means that patch I sent this morning should be all that is needed
> for those machines at least.
> 

Yes correct, it will work for Trogdor

> Can you please confirm that all the WCN39xx have OTP storage for an
> address that an OEM can choose to use?
> 

We are checking with internal FW team, will confirm on it.

> If that's not the case then we could simplify things by always marking
> their addresses as invalid, but I assume that they all have address
> storage.
> 
> Johan

-Janakiram

