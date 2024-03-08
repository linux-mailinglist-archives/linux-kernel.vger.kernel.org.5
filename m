Return-Path: <linux-kernel+bounces-97401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC093876A07
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A6A31C20E38
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAC555E78;
	Fri,  8 Mar 2024 17:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jiSNZR+G"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C6F4879B;
	Fri,  8 Mar 2024 17:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709919354; cv=none; b=YcFAHfLMG0YDY4FY9r2YmzBy7E3KTAW5D39yl68zsN8vMarA+3myj8p98XFCfFnU2nUUrsrtfAhVqILlB679TccLmxuIBAtSy4beP8z7BV+lIguuYaAF3Y7EdosZWBTA2sjFa6X9Y7rwaUgwqlEsbMAEz4b5chOddjM86hJ7b3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709919354; c=relaxed/simple;
	bh=7iOr2ujvj+DFNXgSr9F6MR/Wl7/NyCpzmfzegr9vFkM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=T2IofUAeLcSjOrHpuSfFfEkHmKYbgt2H0TXFqC2RuFqH7KrwOv7vl3DRxmBktiItide3N3DgsrY5tIgV1s1b2AEWJlzE7YlkIQ39t5NtqmwQaUwxEhGM7MHXZ65qrWpOK+zc1Iw8QFbaRwq9G34/NajVa3z9yQJfXTQ29bc20kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jiSNZR+G; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 428HO1Zu014026;
	Fri, 8 Mar 2024 17:35:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=T1gt1AlMskl2ebgO4dM9LtD7IBD/suD1IXel1r9hyvs=;
 b=jiSNZR+G+ygiS+In7vjxlkQWiA2wv51loLHhFnw/yG/FetM4h73OJRmI7KfySQNHroLX
 kzq4mNTE76ZZPRJfeIQI1oDVoU836hBBv5UZiOKyJztvYkv9Gju+7VmcARfouCY6+nV3
 75SeTEcPddfgOGsBhl8KNOa5QspgPX7Eu7THxWJrK9lETsGSf5NXUJ42shlTCZHTDmX8
 qYNM+qTPtY6AqCh0YRDBamgUyRYnwm+DYwErykX6c1qBgBVR54xlUw9IBgFtr1CZpyOC
 ZyDEVgInt8+oa0+uimlkj+rgC4QtByZwAjXfrOR5rB/GazsncpDN8XoeM7DwSmCWq+PQ gg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr67hs9r8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 17:35:12 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 428HTgrh026035;
	Fri, 8 Mar 2024 17:35:11 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr67hs9qt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 17:35:11 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 428G1W3h031530;
	Fri, 8 Mar 2024 17:35:10 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmgnknhk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 17:35:10 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 428HZ7jt46268786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Mar 2024 17:35:09 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 776F858060;
	Fri,  8 Mar 2024 17:35:07 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 257AB5803F;
	Fri,  8 Mar 2024 17:35:06 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.150.204])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 Mar 2024 17:35:06 +0000 (GMT)
Message-ID: <ddb1c28356fb8a4dcca9bff6dc206802d7981bb8.camel@linux.ibm.com>
Subject: Re: [RFC][PATCH 8/8] ima: Detect if digest cache changed since last
 measurement/appraisal
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
        dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        wufan@linux.microsoft.com, pbrobinson@gmail.com, zbyszek@in.waw.pl,
        hch@lst.de, mjg59@srcf.ucam.org, pmatilai@redhat.com, jannh@google.com,
        dhowells@redhat.com, jikos@kernel.org, mkoutny@suse.com,
        ppavlu@suse.com, petr.vorel@gmail.com, petrtesarik@huaweicloud.com,
        mzerqung@0pointer.de, kgold@linux.ibm.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Date: Fri, 08 Mar 2024 12:35:05 -0500
In-Reply-To: <20240214143525.2205481-9-roberto.sassu@huaweicloud.com>
References: <20240214143525.2205481-1-roberto.sassu@huaweicloud.com>
	 <20240214143525.2205481-9-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-23.el8_9) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IlDftZT5RuRbJ9On9uYeUGpCMuzzrfHq
X-Proofpoint-ORIG-GUID: Uja9by0fkc-2TosWj1c5XHtG1riNKJR_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 clxscore=1015 spamscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403080140

Hi Roberto,

> b/security/integrity/ima/ima_main.c
> index a66522a22cbc..e1b2f5737753 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -301,6 +301,15 @@ static int process_measurement(struct file *file, const
> struct cred *cred,
>  		}
>  	}
>  
> +	/* Check if digest cache changed since last measurement/appraisal. */
> +	if (iint->digest_cache &&
> +	    digest_cache_changed(inode, iint->digest_cache)) {
> +		iint->flags &= ~IMA_DONE_MASK;
> +		iint->measured_pcrs = 0;
> +		digest_cache_put(iint->digest_cache);
> +		iint->digest_cache = NULL;
> +	}
> +
>  	/* Determine if already appraised/measured based on bitmask
>  	 * (IMA_MEASURE, IMA_MEASURED, IMA_XXXX_APPRAISE, IMA_XXXX_APPRAISED,
>  	 *  IMA_AUDIT, IMA_AUDITED)
> @@ -371,8 +380,15 @@ static int process_measurement(struct file *file, const
> struct cred *cred,
>  	 * Since we allow IMA policy rules without func=, we have to enforce
>  	 * this restriction here.
>  	 */
> -	if (rc == 0 && policy_mask && func != DIGEST_LIST_CHECK)
> -		digest_cache = digest_cache_get(file_dentry(file));
> +	if (rc == 0 && policy_mask && func != DIGEST_LIST_CHECK) {
> +		if (!iint->digest_cache) {
> +			/* Released by ima_iint_free(). */
> +			digest_cache = digest_cache_get(file_dentry(file));
> +			iint->digest_cache = digest_cache;
> +		} else {
> +			digest_cache = iint->digest_cache;
> +		}

Simple cleanup:
		if (!iint->digest_cache)
			iint->digest_cache =digest_cache_get(file_dentry(file));

		digest_cache = iint->digest_cache;

> +	}
>  
>  	if (digest_cache) {
>  		found = digest_cache_lookup(file_dentry(file), digest_cache,
> @@ -386,8 +402,6 @@ static int process_measurement(struct file *file, const
> struct cred *cred,
>  			if (verif_mask_ptr)
>  				allow_mask = policy_mask & *verif_mask_ptr;
>  		}
> -
> -		digest_cache_put(digest_cache);

Keeping a reference to the digest_cache list for each file in the iint cache
until the file is re-accessed, might take a while to free.

I'm wondering if it necessary to keep a reference to the digest_cache.  Or is it
possible to just compare the existing iint->digest_cache pointer with the
current digest_cache pointer?

thanks,

Mimi

>  	}
>  
>  	if (action & IMA_MEASURE)


