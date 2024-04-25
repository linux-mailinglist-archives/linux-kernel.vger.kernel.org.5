Return-Path: <linux-kernel+bounces-158598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7490F8B22B9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7B0D1C20ED6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A2014A086;
	Thu, 25 Apr 2024 13:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Wnt7oiI5"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E38149C70;
	Thu, 25 Apr 2024 13:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714051758; cv=none; b=nr81e9XkUS+lk+j/lboK7wYdx7V/TZ8kQtPObW5+eaUeFG5sjstYNuhGODhxk3NNHqPaX/YQaWl2K+3bve1OSzITP/0WzEV1nJNjdPaV8xyWbnWC3/YykKoaODjDJQAmVpxrE5uoRXVqqQhMrY/rWfB8Gshv8Cw2R4su1tG0UQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714051758; c=relaxed/simple;
	bh=wskz/AmsaP1lhsfbNrm1mdT4szU5tDRPLVfU0H5AD8Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CJ/KW5hGqHXbphLsm+4R8weJnhQuvlBLP9J9faHU70v731eVJH81oNlVOdIS5fF3x1qyndnjmyvkPfOvfhQnqkBzFunemrquAGhuROI1WFoYEUps4PuXpaxUO/SKT5TkBQhB013thTyAuMZVREqteJPPX4OM1Y38yQQWRgCHYXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Wnt7oiI5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43PD28UN005279;
	Thu, 25 Apr 2024 13:29:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=etx9ghK6vaLriQU+/XjIUoOHCizC2xGLldFfgXXdbEo=;
 b=Wnt7oiI5YeOgUd2vxzu9EnRLJ+Xlm7ErBahpBNx4dIIu8eE+MPxlDwxSq0p8FG4OjlY+
 en0wG8vCe/LT07VucDiBUzfpHhSaARLXzAD1L+iqsQTh65RN2PzO/aut6wC2uHB/xz1c
 FLXoMcerR/v5yXTGmWekn6IXXGDD8zqVqbOfB5FWkZTsSKz088blo+axJ6Yd1QgnHSMy
 84QgwyPyIWSM7vbOyDTfneH+fVjHhZHyQLbuYuSUfskuTOT7gAnoYjT3itgJmiEzyD72
 niYUDW3IrhZP2Fdt9oduGEnojEP35gAlqHMbw5JOZ6PtGdi2McDjW9Lqrz2lurooI1KM hg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xqqpwr228-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 13:29:07 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43PDT7Hi013788;
	Thu, 25 Apr 2024 13:29:07 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xqqpwr221-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 13:29:07 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43PD40ra005352;
	Thu, 25 Apr 2024 13:29:06 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xmx3crpbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 13:29:05 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43PDT0va42991884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 13:29:02 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A473420049;
	Thu, 25 Apr 2024 13:29:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D78520040;
	Thu, 25 Apr 2024 13:29:00 +0000 (GMT)
Received: from [9.152.224.141] (unknown [9.152.224.141])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 25 Apr 2024 13:29:00 +0000 (GMT)
Message-ID: <23cff564-a65c-4db6-a386-2a7e56be84c8@linux.ibm.com>
Date: Thu, 25 Apr 2024 15:29:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 07/11] net/smc: register loopback-ism into
 SMC-D device list
Content-Language: en-US
To: Wenjia Zhang <wenjia@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>,
        twinkler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org
References: <20240414040304.54255-1-guwen@linux.alibaba.com>
 <20240414040304.54255-8-guwen@linux.alibaba.com>
 <ef936c58-e87c-4078-a4dc-ed7313dba2a3@linux.ibm.com>
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <ef936c58-e87c-4078-a4dc-ed7313dba2a3@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EpMIQ47RwUwKg1qn6GATtcSYn5LIp0y-
X-Proofpoint-GUID: mx6fJ0iRSsp-atADs5qci4ckRHoC4wcK
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
 definitions=2024-04-25_13,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=859 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404250098



On 25.04.24 13:29, Wenjia Zhang wrote:
>> +    if (!smcd->pnetid[0]) {
>> +        fentry = list_first_entry_or_null(&smcd_dev_list.list,
>> +                          struct smcd_dev, list);
>> +        if (fentry && smc_ism_is_loopback(fentry))
>> +            list_add(&smcd->list, &fentry->list);
>> +        else
>> +            list_add(&smcd->list, &smcd_dev_list.list);
>> +    } else {
>>           list_add_tail(&smcd->list, &smcd_dev_list.list);
>> -    else
>> -        list_add(&smcd->list, &smcd_dev_list.list);
>> +    }
> 
> Nit: here the pair of curly brackets are unnecessary.

Actually
https://www.kernel.org/doc/html/latest/process/coding-style.html#codingstyle
tells you to use those braces.

