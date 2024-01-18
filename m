Return-Path: <linux-kernel+bounces-30174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4598D831AFE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 782131C25782
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62013286B2;
	Thu, 18 Jan 2024 13:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VF0opJp6"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F3525618;
	Thu, 18 Jan 2024 13:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705586385; cv=none; b=PFBlc13zpEZYX+Pb5b2J7i1oVigmTx9jMT6E8UK5yn0QPhba5WaxgdBNA7SjDPIifAu9dfUoujTvkVga/NzSS+4/9WkUrYMNbZ/gZtZP9OVM62dyjKepddTQ0obvFbCvxkmeuhXLt1UHKKnk+6kHvo0lSl6tJErqNJolH3tKpjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705586385; c=relaxed/simple;
	bh=y0IwCMSq9y/W9Z03dL7iPuixI88ZRL/QExoQtq9zsx8=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:
	 Received:Received:Received:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details; b=VFAsGVdGKaRk+Vhp4j2IMRL0gpsjtx7FNzoWnYP+DJ1m2P+QIsep8aeZvS4ozw24MOh/LqAVNTC3F/vuXDvpiye8P/cGhhSAyoRPSCQcZUtN7ASgNvMzJkr49oLpoiAK7agPVeL3uknuIjD/tc46uf76iqaPm4R7jOAkASNUgok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VF0opJp6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40IDlrJo031053;
	Thu, 18 Jan 2024 13:59:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Lck6vOjOvjxQAjcjvAn+cEAdJmJF2EitvA9Y4tvDYd4=;
 b=VF0opJp6M0aeSvy7ZB5dvIOLP9AcQEy4OQRITalCHy1cylEAxs8PxcFcit58hs4GH9IG
 CFEaLz/Cjvofs9rsTaHVJxK7DFTdsNUcMV1ZU/2N4ZGIbnpnBwoQb7FyzPMEjL91ab5/
 myOP9zfgJL5Siu84Ukz70O8UpiqnnG4lCPe/8Y3n3huP3YYylDhBCin4uOts/u99ZANV
 GtsD//T2VV+eemIhqtGpVuFUh6eYo55RaZPVzX8JCNjIQYlrz7srerV3wYbXzNk/4rOT
 WVckFL+pcNNUMjuA4SnNUpQTUd4ECBx/7aLRRjWs+eRPcovXwVjmRzka5/NCym8iJFJ2 tA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vq56egbpp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 13:59:39 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40IDmuHM002853;
	Thu, 18 Jan 2024 13:59:39 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vq56egbns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 13:59:39 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40IAhkKM005797;
	Thu, 18 Jan 2024 13:59:38 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vm6bkuhs2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 13:59:38 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40IDxbJJ21496478
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jan 2024 13:59:37 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 483B458057;
	Thu, 18 Jan 2024 13:59:37 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9026B5805D;
	Thu, 18 Jan 2024 13:59:34 +0000 (GMT)
Received: from [9.179.26.4] (unknown [9.179.26.4])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Jan 2024 13:59:34 +0000 (GMT)
Message-ID: <20a1a1f3-789a-4d91-9a94-dca16161afd7@linux.ibm.com>
Date: Thu, 18 Jan 2024 14:59:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/15] net/smc: implement loopback-ism used by
 SMC-D
Content-Language: en-GB
To: Wen Gu <guwen@linux.alibaba.com>, wintera@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240111120036.109903-1-guwen@linux.alibaba.com>
 <f98849a7-41e9-421b-97b7-36d720cc43ee@linux.alibaba.com>
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <f98849a7-41e9-421b-97b7-36d720cc43ee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yxDY2XYbBvhB-CiSls17Oh2zCdMfEgfq
X-Proofpoint-GUID: cb_4uLsWVgsShUQGkDa-_w9LzrpbuFVD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_08,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 mlxlogscore=685 phishscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401180101



On 18.01.24 09:27, Wen Gu wrote:
> 
> 
> On 2024/1/11 20:00, Wen Gu wrote:
>> This patch set acts as the second part of the new version of [1] (The 
>> first
>> part can be referred from [2]), the updated things of this version are 
>> listed
>> at the end.
>>
> 
> Hi Wenjia and Jan, I would appreciate any thoughts or comments you might 
> have
> on this series. Thank you very much!
> 
Hi Wen,

I'm still in the middle of the proto type on IPPROTO_SMC and other 
issues, so that I need more time to review this patch series.

Thank you for your patience!
Wenjia


