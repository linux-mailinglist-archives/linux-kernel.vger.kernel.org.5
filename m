Return-Path: <linux-kernel+bounces-159674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C448B31F2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99A421F229FF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E9F13C9BC;
	Fri, 26 Apr 2024 08:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="svwAEpNi"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4883A13BC28;
	Fri, 26 Apr 2024 08:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714118688; cv=none; b=kEg+k75/wZhqD9AeBFnfVpd4mFHNofy2rH+OBkceMn5GYnOmr1lzAWfJ7zR4MQ4shApz02dyCP+M2gRvirBW4ypDjXUEx7507kM7OHClkYTHg4WFsFrLSfRpdM8RWRu2EDb9BMmmOy/NxBOeYdXSuQoZdjC1yXg85HZFlFu1Wxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714118688; c=relaxed/simple;
	bh=gkrVI/hEJ5vPdNwfDc1cqgOQSI4zGxPCnC5lJLAXYTs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kh5hpj2Y5ozs2whn5zSQBf6ZWbxfosiS/RMaAND41MJqVhGN/ks2/ie/iw0XivUaoBCK4a1AoT1MzcTCOmaDU5eXcqFGWS7ia+6qT7WBmlAWtKm6n3qDFITTjYly/AJ/SRM9Vu6cHmedS4D6K89aqI907rx4IgXGGll0YjeINVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=svwAEpNi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43Q82ZOn010160;
	Fri, 26 Apr 2024 08:04:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=dXVCujixqBnPqm5Kh3D7JLPwnYnmNrEdPMF0rWzu/Q0=;
 b=svwAEpNisBQMsGfAOPTx0c7DhZdP3h4y7O9ssBZ8eKAb6+jl6H9Gq4sXxtjxDTt2Njop
 LK+paDX3yfUhVc6/goIjkVhSKAdWrsJUOG5b8NBDEdOe4Bdhr78M5NjO3cFLrnhhW3/w
 TPY87vyJrfsGJP9ZvqOpnuY+vHfR/86TL0L/Y/vuSvBFBUDSnqnBdpLX3RyL+9GJjKt4
 7govMyIKfRiyTfE/D7BwgEUcXdjOzgIQzxAqUlphnflnlEEUN/ged9frgVyJocZ3R6Fe
 BYzjQeGj/cOxqVRicmX7+daKg79fBdx00RRoMZoLUpCcPPvZypeFPEu/2QhEtOtIoN+X IA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xr8dd003y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 08:04:41 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43Q84eUt012938;
	Fri, 26 Apr 2024 08:04:40 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xr8dd003u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 08:04:40 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43Q4l4ae020886;
	Fri, 26 Apr 2024 08:04:39 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xmre0eqxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 08:04:39 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43Q84aDO66322714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 08:04:38 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 512CB5806A;
	Fri, 26 Apr 2024 08:04:36 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 051CE58056;
	Fri, 26 Apr 2024 08:04:33 +0000 (GMT)
Received: from [9.171.42.122] (unknown [9.171.42.122])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Apr 2024 08:04:32 +0000 (GMT)
Message-ID: <d0b8e551-6330-4b1d-98bc-ef1b0e41fbb4@linux.ibm.com>
Date: Fri, 26 Apr 2024 10:04:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 07/11] net/smc: register loopback-ism into
 SMC-D device list
Content-Language: en-GB
To: Alexandra Winter <wintera@linux.ibm.com>,
        Wen Gu
 <guwen@linux.alibaba.com>, twinkler@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org
References: <20240414040304.54255-1-guwen@linux.alibaba.com>
 <20240414040304.54255-8-guwen@linux.alibaba.com>
 <ef936c58-e87c-4078-a4dc-ed7313dba2a3@linux.ibm.com>
 <23cff564-a65c-4db6-a386-2a7e56be84c8@linux.ibm.com>
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <23cff564-a65c-4db6-a386-2a7e56be84c8@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: d5OOasa6LH4wdU1zG06SqGHMVWAEV8Ei
X-Proofpoint-GUID: 9nhuHZSwqFZB7kPXUXd0eYYmvDOMbPmX
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_07,2024-04-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=885 spamscore=0 mlxscore=0 phishscore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2404010000 definitions=main-2404260050



On 25.04.24 15:29, Alexandra Winter wrote:
> 
> 
> On 25.04.24 13:29, Wenjia Zhang wrote:
>>> +    if (!smcd->pnetid[0]) {
>>> +        fentry = list_first_entry_or_null(&smcd_dev_list.list,
>>> +                          struct smcd_dev, list);
>>> +        if (fentry && smc_ism_is_loopback(fentry))
>>> +            list_add(&smcd->list, &fentry->list);
>>> +        else
>>> +            list_add(&smcd->list, &smcd_dev_list.list);
>>> +    } else {
>>>            list_add_tail(&smcd->list, &smcd_dev_list.list);
>>> -    else
>>> -        list_add(&smcd->list, &smcd_dev_list.list);
>>> +    }
>>
>> Nit: here the pair of curly brackets are unnecessary.
> 
> Actually
> https://www.kernel.org/doc/html/latest/process/coding-style.html#codingstyle
> tells you to use those braces.
Thanks, @Alexandra!
Then @Wen, forget my comments on this pls!

