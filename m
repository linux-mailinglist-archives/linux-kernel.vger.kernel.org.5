Return-Path: <linux-kernel+bounces-37985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA4783B93E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 318411F24D34
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 05:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E675510976;
	Thu, 25 Jan 2024 05:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CAUA8C8a"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D914563AC;
	Thu, 25 Jan 2024 05:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706162050; cv=none; b=TNL8vFhiVPpzoajPsNFkzpLO+YkZesNgFUP/1LKX1Gm7vdwXpVsKdyHG9AQWplCjZUGzbM7iREJyprHogjHdr9bddGVxTeUGLAeFRJQDRHs+mewRTMy6tHWnZ4fbTvuV32pCWKLBr0w3FA8RBhm7ymZnkU04mQZccYufCXp1M64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706162050; c=relaxed/simple;
	bh=4uyB5bWzwxXIoouNOljBYPXY0O7nRZDOeUOGJTkuvvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DNstHNhEBxyvFCqGfMn1aZrJpFxZNVtVaYrN+FsDPPPnAwvgBtMVMPJEzH3xzLiA7R3D6KhgkKLh3Iw9JhPfrTU34N4cvVULMOFkwKsosOGmKvRtCEgZQkxGJ0Vm5xrMgSaFritHYdQFM6IPWIU6w8uJVqzn59pzCYjSWYUH2IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CAUA8C8a; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40P5quSh019583;
	Thu, 25 Jan 2024 05:54:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=7Ilqz2zxW2TR2Hej71tgmUSq5ykFa5QzlC31L9455Ek=; b=CA
	UA8C8akTmeoE7FC6i/E95JgjtvMvt7HK1wxQtlfU3kQzIWkZDSpkkUKW6SzxzuuU
	60iW4KtDuU9aLy9K9YDwjkmEklz1QTygiH5Oaz3rijGdyticunhRcAaKm5RX2tnQ
	als3S08K8e2S9aCm/89pytPkSrEK1EDnLmqxOvtfJhRD60zGro/RxVSPyc1GkoAF
	eoWAKLuHy8hp5kRlh3dh3Q1PmBWgAt+PBPRUriiYJqxDxHSAVpCdAzcZOonsoFtR
	+SJybuw/VHYVRDawcpxSG0zISyNV/olRVJrkdgENuwWhtjnxMRuzYHHyLNlf9Amp
	nRcy1pVTiRUZewO+e+TQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vu49a1v96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 05:54:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40P5s1sr029680
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 05:54:01 GMT
Received: from [10.216.21.128] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 24 Jan
 2024 21:53:59 -0800
Message-ID: <7d1babf5-0999-4528-8202-09b8dd0ab06b@quicinc.com>
Date: Thu, 25 Jan 2024 11:23:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build warning after merge of the usb tree
To: Stephen Rothwell <sfr@canb.auug.org.au>, Greg KH <greg@kroah.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next
 Mailing List <linux-next@vger.kernel.org>
References: <20240108160221.743649b5@canb.auug.org.au>
 <2024010816-fabric-cassette-1548@gregkh>
 <20240125113527.5c9fca93@canb.auug.org.au>
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <20240125113527.5c9fca93@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2OMo8O27fcpAKL2mA1RwPGAyugJu3KMy
X-Proofpoint-ORIG-GUID: 2OMo8O27fcpAKL2mA1RwPGAyugJu3KMy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_02,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=897 mlxscore=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401250038



On 1/25/2024 6:05 AM, Stephen Rothwell wrote:
> Hi all,
> 
> On Mon, 8 Jan 2024 08:54:39 +0100 Greg KH <greg@kroah.com> wrote:
>>
>> On Mon, Jan 08, 2024 at 04:02:21PM +1100, Stephen Rothwell wrote:
>>>
>>> After merging the usb tree, today's linux-next build (htmldocs) produced
>>> this warning:
>>>
>>> Documentation/usb/gadget-testing.rst:459: ERROR: Malformed table.
>>> Text in column margin in table line 9.
>>>
>>> ===============   ==================================================
>>> ifname            network device interface name associated with this
>>>                    function instance
>>> qmult             queue length multiplier for high and super speed
>>> host_addr         MAC address of host's end of this
>>>                    Ethernet over USB link
>>> dev_addr          MAC address of device's end of this
>>>                    Ethernet over USB link
>>> max_segment_size  Segment size required for P2P connections. This
>>>                    will set MTU to (max_segment_size - 14 bytes)
>>> ===============   ==================================================
>>>
>>> Introduced by commit
>>>
>>>    1900daeefd3e ("usb: gadget: ncm: Add support to update wMaxSegmentSize via configfs")
>>
>> Krishna, can you send a fixup patch for this?
> 
> I am still seeing this warning.
> 
HI Stephen,

  Udipto and Randy sent patches for fixing this:

https://lore.kernel.org/all/20240108132720.7786-1-quic_ugoswami@quicinc.com/

https://lore.kernel.org/all/20240110203558.2638-1-rdunlap@infradead.org/

Greg, can you help pick one of them up.

Regards,
Krishna,

