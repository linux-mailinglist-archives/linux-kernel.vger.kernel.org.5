Return-Path: <linux-kernel+bounces-110513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D8D885FF6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 738B21C218E4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C8D130E54;
	Thu, 21 Mar 2024 17:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NVDrbSAX"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3B9E57B;
	Thu, 21 Mar 2024 17:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711042971; cv=none; b=aPXt5rH4wKiMseGYzDS7Z4i/M76ZQunS88V6aBIjB97+zxbLUKFtX7EEGcpfABN78haXhw7bvweY5slylveqKo8cQ3VUdt11MqXZNzvMC0HOsEHzzL92eXEcmLb2gtKoeukeTmAbw5i8vD3DvDXDR4sdbV+R9F3kBsitbq/FJnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711042971; c=relaxed/simple;
	bh=FOl0jD2FhGuKtZZbJK+O2pnGGkcUBPuHyNiYVFLKOSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WPBfpcO9ks+p6Bc3SiP9QCQNd8jZ/7xAi3E7aRd+2HdOOCDMqpzWhmSGdb5+WQFCChUN+tU86j7zwnCp0XySjPipEsy7E4nc1UG/xzirgEY9nKxFlC6dK+1OrlTprRWtNeUAlmHkrx8JT3U1AoRyDqhbaCFyruQpKV3oWUIp7sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NVDrbSAX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42LFppWA012292;
	Thu, 21 Mar 2024 17:42:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=KSnQV3YllzUvHyoJrCIDlSpzwCwnH3UBZsRsTjNUXZw=;
 b=NVDrbSAXuJPdcno3e/jfb0msowcYjj5m+1CVM37atLq7PeaF/5swfQQc4EtpeTR9TfSH
 LLwmr2tsd7ZQCiQk+qBWI76GXsdj6N4ivkIV0Ra/wq8BKuLw97DEdOXHw6MQRrwFlNCl
 YennpjtHgXBUOvcrqxlvzZlf590iVZz+9XOCuZ8jngzMGYtKa1N1kiuMCxM6SylDfJ54
 XJZvk2mFFExmkVFKd3BtZ6oEamMBL1J4b9QwH54s/8BmsykZm3B89fQGb72n3jUCn6yW
 WdOsu3waRqA9YvpEdrAbKEqqv+xpp2l6TN7JRj1V/i/2oMdCT2ovWovMziNjWXFggKdI Ng== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0nq48p98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 17:42:33 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42LHgX2a031885;
	Thu, 21 Mar 2024 17:42:33 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0nq48p95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 17:42:33 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42LHVedV015829;
	Thu, 21 Mar 2024 17:42:32 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wwp50eypk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 17:42:32 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42LHgUiV25821526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 17:42:32 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A42F85804B;
	Thu, 21 Mar 2024 17:42:28 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8E2B58063;
	Thu, 21 Mar 2024 17:42:27 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Mar 2024 17:42:27 +0000 (GMT)
Message-ID: <0216c143-445b-472d-a62a-57cbe8b19c24@linux.ibm.com>
Date: Thu, 21 Mar 2024 13:42:27 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 13/13] crypto: x509 - Add OID for NIST P521 and extend
 parser for it
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        bbhushan2@marvell.com, David Howells <dhowells@redhat.com>
References: <20240320114725.1644921-1-stefanb@linux.ibm.com>
 <20240320114725.1644921-14-stefanb@linux.ibm.com>
 <CZZLN3B7TMG5.1A0518I6Z3MEA@kernel.org>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CZZLN3B7TMG5.1A0518I6Z3MEA@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nGA2LflNtMqxtyU2siU3mfGrP2swOIKu
X-Proofpoint-GUID: p5zI515p7mLQZrKOAUkBs3EwvPdy7HOQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_10,2024-03-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403210129



On 3/21/24 13:20, Jarkko Sakkinen wrote:
> On Wed Mar 20, 2024 at 1:47 PM EET, Stefan Berger wrote:
>> Enable the x509 parser to accept NIST P521 certificates and add the
>> OID for ansip521r1, which is the identifier for NIST P521.
>>
>> Cc: David Howells <dhowells@redhat.com>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> Tested-by: Lukas Wunner <lukas@wunner.de>
>> ---
>>   crypto/asymmetric_keys/x509_cert_parser.c | 3 +++
>>   include/linux/oid_registry.h              | 1 +
>>   2 files changed, 4 insertions(+)
>>
>> diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
>> index 487204d39426..99f809b7910b 100644
>> --- a/crypto/asymmetric_keys/x509_cert_parser.c
>> +++ b/crypto/asymmetric_keys/x509_cert_parser.c
>> @@ -538,6 +538,9 @@ int x509_extract_key_data(void *context, size_t hdrlen,
>>   		case OID_id_ansip384r1:
>>   			ctx->cert->pub->pkey_algo = "ecdsa-nist-p384";
>>   			break;
>> +		case OID_id_ansip521r1:
>> +			ctx->cert->pub->pkey_algo = "ecdsa-nist-p521";
>> +			break;
>>   		default:
>>   			return -ENOPKG;
>>   		}
>> diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry.h
>> index 3921fbed0b28..af16d96fbbf2 100644
>> --- a/include/linux/oid_registry.h
>> +++ b/include/linux/oid_registry.h
>> @@ -65,6 +65,7 @@ enum OID {
>>   	OID_Scram,			/* 1.3.6.1.5.5.14 */
>>   	OID_certAuthInfoAccess,		/* 1.3.6.1.5.5.7.1.1 */
>>   	OID_id_ansip384r1,		/* 1.3.132.0.34 */
>> +	OID_id_ansip521r1,		/* 1.3.132.0.35 */
>>   	OID_sha256,			/* 2.16.840.1.101.3.4.2.1 */
>>   	OID_sha384,			/* 2.16.840.1.101.3.4.2.2 */
>>   	OID_sha512,			/* 2.16.840.1.101.3.4.2.3 */
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> BR, Jarkko


Thanks for the tags.
> 

