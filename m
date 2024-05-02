Return-Path: <linux-kernel+bounces-166526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 661C58B9BD7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3B281F21E8F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDE813C67D;
	Thu,  2 May 2024 13:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QetbCS5c"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FD27441E;
	Thu,  2 May 2024 13:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714657607; cv=none; b=C5trsDLwhmwNHVzq/IdrMH2/9VAilsEe7Qpartq0MyWBsGHYIVhs5Twu6ch5SCMlsgw8+Q3wtwheSnQhpk9asvuif7HcW/l3WAcmjoh56QCniZQ4F+kUrD9DVOhiAD/jKT0LweQxNYSyfOnVUtBsaNzaI3XB1/ea8PwmsfS5V8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714657607; c=relaxed/simple;
	bh=C1dTioCTbJAqPdX5fiQM5i2I9L/XeeoaYhZ/nM6DKO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BznuI4K7yvAhwpvlSBSDOll0faU2WC+Lyfn4GsStR4J3FN23mp+wEox1RbgfSi+qgapDL+sXyS/g+x1IWX3GtXVZADJ9IsYkkK0GpFg1MfO5m3+sBu73kZILBr28c4H2SCifQHAi5221bV9i/an2Nbsz7q/+t8N3HPo5CGS1Y88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QetbCS5c; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4426KPDu013262;
	Thu, 2 May 2024 13:46:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=pbtefCiALFzu30bj6ncNXLiyVomEQeGevWPDsu1b3jo=; b=Qe
	tbCS5cdGdqaoyoIfrIMHm7ZuECV2b9XW9gcw+puJx4C2AMtpOgkpU0uPB11YBq2K
	cpbr5sGwI31cidjhcsG3URRWqNonQO5plAiWujx+ecfzcz/zYYQxGDiQ22b9ktwA
	0GUdCuV3HJInZHKRGYjiuokC/6g2c4iuJQ71XHDvQ+9tYxKto6HwbUhPZFPssVgZ
	xCx4piEycx1x/xq+UJvgSKZmcwv+5YQ1SkzDwtLsbPhjbcLTbThxNzHtdY9jxkym
	JPV32/OVEv0dyDPM9GCJhzRU70506TdclSBLMb/lTfcUZ62WO5xaw3Q42iqVJ2+t
	a1aHSrUOA3t0ZpjG20hA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xv01tsad5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 May 2024 13:46:42 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 442DkfZC008757
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 2 May 2024 13:46:41 GMT
Received: from [10.253.35.130] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 2 May 2024
 06:46:40 -0700
Message-ID: <f1b45d7d-27e0-4ad7-976c-670a0e0d136b@quicinc.com>
Date: Thu, 2 May 2024 21:46:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QCA NVM file for the X13s (WCN6855)
To: Johan Hovold <johan@kernel.org>
CC: Tim Jiang <quic_tjiang@quicinc.com>,
        Janaki Ramaiah Thota
	<quic_janathot@quicinc.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <ZjNxfFJmCgIyq8J6@hovoldconsulting.com>
 <5aea3149-ba44-400f-acc6-1a3eca8a7e72@quicinc.com>
 <ZjOUWqor4q1Efy0W@hovoldconsulting.com>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <ZjOUWqor4q1Efy0W@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: d3fhczlvIBbzMi7hAaTslBgM_2KSMSHE
X-Proofpoint-GUID: d3fhczlvIBbzMi7hAaTslBgM_2KSMSHE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-02_02,2024-05-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2405020089

On 5/2/2024 9:25 PM, Johan Hovold wrote:
> On Thu, May 02, 2024 at 08:56:12PM +0800, quic_zijuhu wrote:
>> On 5/2/2024 6:57 PM, Johan Hovold wrote:
> 
>>> I noticed that you have both submitted firmware and NVM files for
>>> QCA2066 to linux-firmware. [1][2]
>>>
>>> I'm working on Linux support for the Lenovo ThinkPad X13s (Windows on
>>> Arm, Snapdragon), which has the related WCN6855 controller that uses the
>>> same firmware (hpbtfw21.tlv).
> 
>> which SOC type does the machine use?  WCN6855 or QCA2066?
> 
> It's WCN6855 but the Linux driver currently uses the firmware you pushed
> for QCA2066.
> 
>>> The current Linux driver is using the generic NVM file (hpnv21.bin) for
>>> WCN6855, but connectivity is quite bad and I only get 2-3 meters of
>>> range.
> 
>>>> Switching to the board-specific NVM configuration (hpnv21b.b8c) that
>> it seems hpnv21b.b8c is a wrong NVM name.
>> is it hpnv21g.b8c?
> 
hpnv21g.b8c is the right NVM for the machine.
i am afraid that i can't answer your question due to company CCI policy
> I've only tested with the NVM file without the "g" infix, but there
> indeed also is a 'hpnv21g.b8c' in the Windows installation.
> 
> What is the difference between those two?
> 
>>> came with the Windows driver make all issues go away and the range is
>>> really good, but I'm not sure if that file is fully compatible with the
>>> firmware used by the Linux driver.
>>>
>>> Could you help us submit an NVM configuration file for the controller
>>> with board id 0x008c to linux-firmware?
>>>
>> For Windows OS, there are relevant channel to deliver BT firmware.
>> For Linux OS, we normally upload relevant BT firmware to linux-firmware.
>>
>> it seems customer would like to use Linux OS instead of preinstalled
>> Windows OS for the machine.
>> right?
> 
> Exactly. It's a Lenovo machine that comes with Windows pre-installed and
> we're working on enabling Linux on it with some help from Lenovo.
> 
>> need customer to make a request for their requirements if the answer is
>> yes for above question.
> 
> Lenovo has made requests for X13s firmware from Qualcomm and pushed it
> to linux-firmware [1], but they have not yet been able to get Qualcomm
> to provide an NVM configuration file for Bluetooth (I think the problem
> may be finding the right person to talk to inside Qualcomm).
> 
> So I was hoping maybe you could help us with this since the difference
> between 'hpnv21.bin' that you pushed to linux-firmware and what came
> with Windows appears to be really small (e.g. just a few bytes).
> 
let me try to find out the right person who will push this task at next
monday.
there are some other internal procedures before we can push BT firmware
into linux-firmware.
> Johan
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/qcom?id=4ae4ae88918928e15006eb129ad981aa58216b59
> 


