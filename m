Return-Path: <linux-kernel+bounces-69220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 472628585E7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA554B21048
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A7B135A48;
	Fri, 16 Feb 2024 19:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f/lTtXn2"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1365512F369;
	Fri, 16 Feb 2024 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708110221; cv=none; b=BJCKCjg/2O9oc8NlhLRRyLnL9Cn7X5CbESPxd8X0qHr/x4K25Atsoi8/gWz6zh6oGPUFeUCBaa5t6d+HYh3t+Z1rdkZlkeysWcTmPWWyn0jmd3Qbjsch92GQ1KMxYokfiVpUsCqGhOINqKDD3JZdC5UuuUWxqnl5KRy4KM1TOoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708110221; c=relaxed/simple;
	bh=HB0D5Sj54XR6dVqOCAU9iJme/Ni8rgdc7NtQ4J161JQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NwUvRGsABHiAhsICVIgJ8wUHvFJO4OzkNAUPxtl+cbRRBfq0veobeCwEko2c9Wex4bRj1EzhntwTn5ipmkPJp6y/MVDTIVluSTu7+fKiiQLXW4GCsaYEAB2h8ch0UyVtXG/g9RPfeXSdSqMSmBRAldB5URlOGdDmpMS49TWA39w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f/lTtXn2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41GIDeoF032401;
	Fri, 16 Feb 2024 19:03:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Qz0aHND61ieKnxXfugw5FRubzhuSqEDmnCQFdKTg9wo=;
 b=f/lTtXn2s7z3sAHApejwnf1ZDJlc8L57NMLAZPQxwBbHSnIMYi8uAC9T9xeONIlso9wh
 6hoNIFXK7DhSZnJJdGVsZLakfKUGTdXHBVqvrIY/sro5hORhD5Jesxlv9kRzXPTm55Hk
 pQjKk96EdZpOb3dBnb25V8dRn2SVw1BvUBttPHq+P11pehKzd0paeveM2EVUYq7ybSgV
 5SBcdplnUe5OhCjSFqRjg9tTx8Ob/oBzuTh5f5L9t9NPHX6McVy5tGmEk33g7b8hjMyW
 FsOnmAUtJHYqbSsYaJ7l8BLdR4djfilOr0s2Gpe9lvHnMTUAV96AbYs6dQuYIN+ODXyF Lw== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wacst8spq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 19:03:30 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41GGiXkt010060;
	Fri, 16 Feb 2024 19:03:30 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6npmcu9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 19:03:30 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41GJ3R2424511050
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 19:03:29 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1BA525805F;
	Fri, 16 Feb 2024 19:03:27 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 954EF58059;
	Fri, 16 Feb 2024 19:03:26 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 16 Feb 2024 19:03:26 +0000 (GMT)
Message-ID: <631a6d09-daac-49ac-aec9-9b8f23af34c8@linux.ibm.com>
Date: Fri, 16 Feb 2024 14:03:24 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/14] crypto: ecc - Add NIST P521 curve parameters
Content-Language: en-US
To: "Elliott, Robert (Servers)" <elliott@hpe.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "saulo.alessandre@tse.jus.br" <saulo.alessandre@tse.jus.br>
References: <20240215231414.3857320-1-stefanb@linux.ibm.com>
 <20240215231414.3857320-7-stefanb@linux.ibm.com>
 <MW5PR84MB184295E25332F1516BE10BA5AB4C2@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <MW5PR84MB184295E25332F1516BE10BA5AB4C2@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cTDUHXX0W_CG8EFFa75fwBnjg7jdHT7h
X-Proofpoint-GUID: cTDUHXX0W_CG8EFFa75fwBnjg7jdHT7h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_18,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 clxscore=1011 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 mlxscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402160149



On 2/16/24 13:48, Elliott, Robert (Servers) wrote:
>> -----Original Message-----
>> From: Stefan Berger <stefanb@linux.ibm.com>
>> Sent: Thursday, February 15, 2024 5:14 PM
>> Subject: [PATCH v2 06/14] crypto: ecc - Add NIST P521 curve parameters
>>
>> Add the parameters for the NIST P521 curve and define a new curve ID
>> for it. Make the curve available in ecc_get_curve.
>>
> ...
>> diff --git a/crypto/ecc_curve_defs.h b/crypto/ecc_curve_defs.h
> ...
>> +static struct ecc_curve nist_p521 = {
>> +	.name = "nist_521",
> 
> Are the name fields in the ecc_curve structures used anywhere or
> exposed to userspace?
> 
> It'd be nice if the strings for the nist_p192, nist_p256, and nist_p384
> structures and this new nist_p521 structure included "p" before
> the number, better matching all the code and the NIST FIPS 186-4 names:
>      .name = "nist_p192"
>      .name = "nist_p256"
>      .name = "nist_p384"
>      .name = "nist_p521"
> 
> 

This is what is exposed:

$ cat /proc/crypto | grep nist
name         : ecdh-nist-p384
driver       : ecdh-nist-p384-generic
name         : ecdh-nist-p256
driver       : ecdh-nist-p256-generic
name         : ecdh-nist-p192
driver       : ecdh-nist-p192-generic
name         : ecdsa-nist-p384
driver       : ecdsa-nist-p384-generic
name         : ecdsa-nist-p256
driver       : ecdsa-nist-p256-generic
name         : ecdsa-nist-p192
driver       : ecdsa-nist-p192-generic

