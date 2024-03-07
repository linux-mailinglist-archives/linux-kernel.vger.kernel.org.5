Return-Path: <linux-kernel+bounces-96130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACD0875777
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8065AB2112C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BE5137C48;
	Thu,  7 Mar 2024 19:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hxHfffWC"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95086136991;
	Thu,  7 Mar 2024 19:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709840936; cv=none; b=ptU5RbnIZxNXv5P/j8g2an30ppJPoB1sabuE5Z9Cn40nabUL3QIIOgXD6dX9wlOZGtJajDMjqDHcV++J+8jo/i2o4TslpIj+8gZky6UcI2RXQ6npxVBa5fGU548BG2gm7PZ9W3BsUn0O0P3QC/MBdFBZIsJ8CsYVR5Cbq04Mi04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709840936; c=relaxed/simple;
	bh=PfjtiY5BSu9RUY9kEDtgOzs9DcwZeom0ZTjw0QvKakM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=s1PywRwSLnqxrN+9loWoth4WD/iP1eFgFzPbgB99Wo8uXGnB1P206QeibTjWTIBed40ZZAm2IS6/yqZuCrFvfsnMtntNg2IrtHoO2WvodnXVw/tMudtnRbzJZEBY4yJF0uwUbjJQP9PW0+gNYTwq2IcJSYI08nqPPcZhFUi/34A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hxHfffWC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 427JRCZ0017075;
	Thu, 7 Mar 2024 19:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=LGTv9dsjx32u/5Ptx7ie3IIAHZQQyKvXYvldp9BGYzA=;
 b=hxHfffWCBr5Y7eMEK2h3MWuBDE47SthGutZLaqnZXKPvKzXI4AC+nj6ocz49LzDdnYfc
 WH0XGBhF8E/+nJ7M5YjiY0atDCEHkHUn5wofFUfV7yjerXPzR8KTcc+YXch1xblx4iih
 u8lZcLsRt5KyjeUb9Fr6YcMMP1UkkOuBsh8BxZE/05oKe6jnwKAoH2biIusneXiMfWXY
 1aG1YAzV9iMZiDtqDgM0oMrdsZL9pws2bfftySYCtmJ2ZwH0rgrKyKde7LQ7OE+XoYo1
 srW0PQuT0orw6nqkGDw9HxpbgVoYdfjzMDuLwEU+3u16/3GI5Xrflfd3+8XDH+dnAm5o Cg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wqkrb8bxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 19:48:11 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 427JeDSO026378;
	Thu, 7 Mar 2024 19:48:10 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wqkrb8bwx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 19:48:10 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 427J7Ro6026212;
	Thu, 7 Mar 2024 19:42:44 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wmfep7sx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 19:42:44 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 427Jgfq729950264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Mar 2024 19:42:43 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A5B25805D;
	Thu,  7 Mar 2024 19:42:41 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 096A358061;
	Thu,  7 Mar 2024 19:42:40 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.133.222])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 Mar 2024 19:42:39 +0000 (GMT)
Message-ID: <2f2d07c33170b6ed06f72e927a0d31989bca7c85.camel@linux.ibm.com>
Subject: Re: [RFC][PATCH 2/8] ima: Nest iint mutex for DIGEST_LIST_CHECK hook
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
Date: Thu, 07 Mar 2024 14:42:39 -0500
In-Reply-To: <20240214143525.2205481-3-roberto.sassu@huaweicloud.com>
References: <20240214143525.2205481-1-roberto.sassu@huaweicloud.com>
	 <20240214143525.2205481-3-roberto.sassu@huaweicloud.com>
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
X-Proofpoint-GUID: 9q3FLHGm8L4aqkf7QjKJUbXERS_yyoBH
X-Proofpoint-ORIG-GUID: T-KG-TwXTy6r_BBRcBSwABmX6NIDzyu9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_14,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 impostorscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403070139

On Wed, 2024-02-14 at 15:35 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Invoking digest_cache_get() inside the iint->mutex critical region can
> cause deadlocks due to the fact that IMA can be recursively invoked for
> reading the digest list. The deadlock would occur if the digest_cache LSM
> attempts to read the same inode that is already locked by IMA.
> 
> However, since the digest_cache LSM makes sure that the above situation
> never happens, as it checks the inodes, it is safe to call
> digest_cache_get() inside the critical region and nest the iint->mutex
> when the DIGEST_LIST_CHECK hook is executed.
> 
> Add a lockdep subclass to the iint->mutex, that is 0 if the IMA hook
> executed is not DIGEST_LIST_CHECK, and 1 when it is. Since lockdep allows
> nesting with higher classes and subclasses, that effectively eliminates the
> warning about the unsafe lock.
> 
> Pass the new lockdep subclass (nested variable) from ima_inode_get() to
> ima_iint_init_always() and ima_iint_lockdep_annotate().
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/integrity/ima/ima.h      |  2 +-
>  security/integrity/ima/ima_iint.c | 11 ++++++-----
>  security/integrity/ima/ima_main.c |  6 +++---
>  3 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index cea4517e73ab..c9140a57b591 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -216,7 +216,7 @@ static inline void ima_inode_set_iint(const struct inode
> *inode,
>  }
>  
>  struct ima_iint_cache *ima_iint_find(struct inode *inode);
> -struct ima_iint_cache *ima_inode_get(struct inode *inode);
> +struct ima_iint_cache *ima_inode_get(struct inode *inode, bool nested);
>  void ima_inode_free(struct inode *inode);
>  void __init ima_iintcache_init(void);
>  
> diff --git a/security/integrity/ima/ima_iint.c
> b/security/integrity/ima/ima_iint.c
> index e7c9c216c1c6..b4f476fae437 100644
> --- a/security/integrity/ima/ima_iint.c
> +++ b/security/integrity/ima/ima_iint.c
> @@ -41,7 +41,7 @@ struct ima_iint_cache *ima_iint_find(struct inode *inode)
>   * See ovl_lockdep_annotate_inode_mutex_key() for more details.
>   */
>  static inline void ima_iint_lockdep_annotate(struct ima_iint_cache *iint,
> -					     struct inode *inode)
> +					     struct inode *inode, bool nested)
>  {
>  #ifdef CONFIG_LOCKDEP
>  	static struct lock_class_key ima_iint_mutex_key[IMA_MAX_NESTING];


"nested" is being pushed all the way down to here, perhaps I'm missing
something, but I don't see it being used in any of the patches.

Mimi

> @@ -56,7 +56,7 @@ static inline void ima_iint_lockdep_annotate(struct
> ima_iint_cache *iint,
>  }
>  
>  static void ima_iint_init_always(struct ima_iint_cache *iint,
> -				 struct inode *inode)
> +				 struct inode *inode, bool nested)
>  {
>  	iint->ima_hash = NULL;
>  	iint->version = 0;
> @@ -69,7 +69,7 @@ static void ima_iint_init_always(struct ima_iint_cache
> *iint,
>  	iint->ima_creds_status = INTEGRITY_UNKNOWN;
>  	iint->measured_pcrs = 0;
>  	mutex_init(&iint->mutex);
> -	ima_iint_lockdep_annotate(iint, inode);
> +	ima_iint_lockdep_annotate(iint, inode, nested);
>  }
>  
>  static void ima_iint_free(struct ima_iint_cache *iint)
> @@ -82,13 +82,14 @@ static void ima_iint_free(struct ima_iint_cache *iint)
>  /**
>   * ima_inode_get - Find or allocate an iint associated with an inode
>   * @inode: Pointer to the inode
> + * @nested: Whether or not the iint->mutex lock can be nested
>   *
>   * Find an iint associated with an inode, and allocate a new one if not
> found.
>   * Caller must lock i_mutex.
>   *
>   * Return: An iint on success, NULL on error.
>   */
> -struct ima_iint_cache *ima_inode_get(struct inode *inode)
> +struct ima_iint_cache *ima_inode_get(struct inode *inode, bool nested)
>  {
>  	struct ima_iint_cache *iint;
>  
> @@ -100,7 +101,7 @@ struct ima_iint_cache *ima_inode_get(struct inode *inode)
>  	if (!iint)
>  		return NULL;
>  
> -	ima_iint_init_always(iint, inode);
> +	ima_iint_init_always(iint, inode, nested);
>  
>  	inode->i_flags |= S_IMA;
>  	ima_inode_set_iint(inode, iint);
> diff --git a/security/integrity/ima/ima_main.c
> b/security/integrity/ima/ima_main.c
> index 780627b0cde7..18285fc8ac07 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -248,7 +248,7 @@ static int process_measurement(struct file *file, const
> struct cred *cred,
>  	inode_lock(inode);
>  
>  	if (action) {
> -		iint = ima_inode_get(inode);
> +		iint = ima_inode_get(inode, func == DIGEST_LIST_CHECK);
>  		if (!iint)
>  			rc = -ENOMEM;
>  	}
> @@ -699,7 +699,7 @@ static void ima_post_create_tmpfile(struct mnt_idmap
> *idmap,
>  		return;
>  
>  	/* Nothing to do if we can't allocate memory */
> -	iint = ima_inode_get(inode);
> +	iint = ima_inode_get(inode, false);
>  	if (!iint)
>  		return;
>  
> @@ -731,7 +731,7 @@ static void ima_post_path_mknod(struct mnt_idmap *idmap,
> struct dentry *dentry)
>  		return;
>  
>  	/* Nothing to do if we can't allocate memory */
> -	iint = ima_inode_get(inode);
> +	iint = ima_inode_get(inode, false);
>  	if (!iint)
>  		return;
>  


