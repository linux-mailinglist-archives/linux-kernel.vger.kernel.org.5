Return-Path: <linux-kernel+bounces-39235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D1183CD37
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8BF1F26A01
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5436B13666C;
	Thu, 25 Jan 2024 20:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TgLIwN8w"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1301134730;
	Thu, 25 Jan 2024 20:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706213591; cv=none; b=mTNu6RY5mN5y0CxMhsoinCdQ2D6YTm1kw55F7A+dSIe4JPqVbS1sB2CuqTKvfJXTEqV18H0lnnH2LdTFKC7kVHgwMxgGfvZla4WOH0WEAikzSfggvMfwonWQ3q/K2ydGNX4DBRQI+dk6PU7JtWeeAnvALcD3e9m4SqA3dGvpMWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706213591; c=relaxed/simple;
	bh=B3ceFyw/SVZiDpOgeabLAgAu8612WJpmcKbUEA6KKl0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RKcQmIqCMMvAclp6SfnnzYIveX8Om7ycY4VGjM2dSDCBcGoPVRnnoHrzuIc4cAF//sEI564jchbrUZ0ci2foU5ZpzhqQLCCCtcUtpJzMcMDygK/g0lBgTT/B3ZbPWoYR8tv5dMq/muz2pA0LJZwP5DSCgSzeMdf9yjGsApdCnZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TgLIwN8w; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40PIMCV3018100;
	Thu, 25 Jan 2024 20:13:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=6/1Ftr9qHVfb8ZAHqobSXWEaC3k7lCqrnuCH3dsMTzI=;
 b=TgLIwN8wJWXBeD9xSVPyPwDJMyIp9AuwOepeevMeJY0K8rZ5k3nllBbFFWA5aCsju5Ap
 kljU//8IxpXJLg1kb2/SROZcjjeMsCX/8oCINk1YSXtP3R6mNkdoBwxFVZcvcsLwip8a
 uZ3o5oQiR+BWBv6GxI8REZkAp323S0WGrU0gb9KO8pq65zyXkwFLo16tZ1VAvkQisyXr
 jBTM5TlZqpq5w6BvbE//8vUj2uQdH3S9cHgtPxI7+Bl3o/Dda1HrRCz6l8y86ffWbskV
 4q0GwSaGdEY0WtSNJ+CbzTyA0aja3aA0+HSaoe31r8bUM5u8sLP08FgUVpw6tLcqJiBs eg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vuvv0tbmm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 20:13:03 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40PKBFYI004815;
	Thu, 25 Jan 2024 20:13:02 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vuvv0tbkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 20:13:02 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40PHxW3Y010860;
	Thu, 25 Jan 2024 20:13:01 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vrrw06hp7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 20:13:01 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40PKD07T5243778
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 20:13:00 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B56A58056;
	Thu, 25 Jan 2024 20:13:00 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59FBD58052;
	Thu, 25 Jan 2024 20:13:00 +0000 (GMT)
Received: from [9.24.12.86] (unknown [9.24.12.86])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 25 Jan 2024 20:13:00 +0000 (GMT)
Message-ID: <a7cef739-213c-4f9b-ae84-5e5912d2281a@linux.ibm.com>
Date: Thu, 25 Jan 2024 14:13:00 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] tpm: tis-i2c: Add more compatible strings
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
Cc: peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        Joel Stanley <joel@jms.id.au>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
References: <20231214144954.3833998-1-ninad@linux.ibm.com>
 <20231214144954.3833998-2-ninad@linux.ibm.com>
 <20240109-saddling-nintendo-c7fbb46bb0dd@spud>
 <77fe0ccd-53ff-4773-9787-0d038434297f@linux.ibm.com>
 <20240112-unrevised-wafer-649c0ebffda5@spud>
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <20240112-unrevised-wafer-649c0ebffda5@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 027WmfN-7LSDFb66WQhdOq7NGAmoGauX
X-Proofpoint-GUID: h2tM9gAfucWNsjkh8iD7RKxBG4kYU6EO
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_12,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=396 mlxscore=0
 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401250145

Hello Conor,

Can you please send ack for my last patch if you don't have further 
review comments?

https://lore.kernel.org/linux-kernel/20240116181754.3905754-1-ninad@linux.ibm.com/

Thanks & Regards,

Ninad Palsule



