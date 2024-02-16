Return-Path: <linux-kernel+bounces-68741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B97857F43
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E30A1F27A55
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50C312BF38;
	Fri, 16 Feb 2024 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tbQPa5XO"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABF412CDBC;
	Fri, 16 Feb 2024 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708093522; cv=none; b=WoQAVc2sfS0Qt5kKwTWuhZMurV1GmFeAO37mnV0YHqr3dhRy7uHx/aDUC/u2gy/v5/w3JAuhPd2KTPd/JXXDoCl7/Tl23a0sjrTxAmGFCPL9uXDGuU9kyQz1Dee+8lOe0E1q416KK+CEDYEVtkk8mAtX+mjP6k9YmPpkDFjnNvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708093522; c=relaxed/simple;
	bh=O7MFxcQlW6/oLUDwi9hslFjNvFqB7lPa29B3FpAyVvg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hPaLeS4cfZG7VCzAoyGFK+d4ZSKBTraACha4Mnqo7JEb4bcaj0Jbg+ApoPqq0+AUYY/ZOE+8cBuNuSO3oCUy+pjF0IhS9MW0TmYYRgxZVxiIW/J/ConPbsuGEnOk1/jGVK71A7g/njAsDNtpVsRaixQWUWB5tU+ZNoeNKrU/xNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tbQPa5XO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41GDS2VR009205;
	Fri, 16 Feb 2024 14:25:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=nlnNDCB++mrZtl4jprxCchDhuznxfG86krnhXkgxIn8=;
 b=tbQPa5XOywT+Xfwh6609A7vyZWr5OlhcNs5uFq9qs7HCGPqjmnJ/4WhUGvSuRu5zyhk8
 3EsGM/Hf35XDJi9P3fpXcMaP4z84L52urATEeR/cN1YXppSV2BA8XCgt2f8O1ijRXHWJ
 8D3o3yDAiicq3zPkvyWCer2JJ3ny1tnFqIUg2iBkv0R50bUB1XbD29no8+qxfA21rq3h
 hYYMRhuBTzmSgXiSrcMT3JSw596UsEJaw5CsrefX9DmYI3TgmJDU6qMR30wRI8V1auP3
 3aWC6ePaMh5rxMqAloLy/ja6+Av4vCcGpQ50n2nnI6hYbLUyrIuBKopM8J2AVV7XaO7+ sw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wa8m29a5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 14:25:15 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41GDU7Jr015721;
	Fri, 16 Feb 2024 14:25:15 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wa8m29a5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 14:25:14 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41GDa3DC016203;
	Fri, 16 Feb 2024 14:25:14 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6myn3nue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 14:25:14 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41GEPAKh17498760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 14:25:13 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB74C58061;
	Fri, 16 Feb 2024 14:25:08 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6603B58050;
	Fri, 16 Feb 2024 14:25:05 +0000 (GMT)
Received: from [9.171.40.55] (unknown [9.171.40.55])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 16 Feb 2024 14:25:05 +0000 (GMT)
Message-ID: <350f1cb8-b205-47be-a296-c610b9afe5fc@linux.ibm.com>
Date: Fri, 16 Feb 2024 15:25:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Wenjia Zhang <wenjia@linux.ibm.com>
Subject: Re: [PATCH net-next 13/15] net/smc: introduce loopback-ism DMB type
 control
To: Wen Gu <guwen@linux.alibaba.com>, wintera@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jaka@linux.ibm.com, Gerd Bayer <gbayer@linux.ibm.com>
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240111120036.109903-1-guwen@linux.alibaba.com>
 <20240111120036.109903-14-guwen@linux.alibaba.com>
Content-Language: en-GB
In-Reply-To: <20240111120036.109903-14-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NxRbpwPOulmqbzB3VeVuqevT4XGhMX2_
X-Proofpoint-GUID: SDew2dCRulUv8MbMxbI0RFumLOi-Saip
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_13,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=997 bulkscore=0 spamscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402160115



On 11.01.24 13:00, Wen Gu wrote:
> This provides a way to {get|set} type of DMB offered by loopback-ism,
> whether it is physically or virtually contiguous memory.
> 
> echo 0 > /sys/devices/virtual/smc/loopback-ism/dmb_type # physically
> echo 1 > /sys/devices/virtual/smc/loopback-ism/dmb_type # virtually
> 
> The settings take effect after re-activating loopback-ism by:
> 
> echo 0 > /sys/devices/virtual/smc/loopback-ism/active
> echo 1 > /sys/devices/virtual/smc/loopback-ism/active
> 
> After this, the link group and DMBs related to loopback-ism will be
> flushed and subsequent DMBs created will be of the desired type.
> 
> The motivation of this control is that physically contiguous DMB has
> best performance but is usually expensive, while the virtually
> contiguous DMB is cheap and perform well in most scenarios, but if
> sndbuf and DMB are merged, virtual DMB will be accessed concurrently
> in Tx and Rx and there will be a bottleneck caused by lock contention
> of find_vmap_area when there are many CPUs and CONFIG_HARDENED_USERCOPY
> is set (see link below). So an option is provided.
> 
I'm courious about why you say that physically contiguous DMB has best 
performance. Because we saw even a bit better perfomance with the 
virtual one than the performance with the physical one.

