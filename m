Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D647769EF0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 19:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbjGaRIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 13:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbjGaRIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 13:08:25 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E3E3C0F;
        Mon, 31 Jul 2023 10:05:33 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VGiPtN023008;
        Mon, 31 Jul 2023 17:04:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=9s+asaePODdRt5hKbett46tpTwR3OUK0tm4vj0uLeK0=;
 b=k/ykxdVJmXBDN5+jqeWWkLscwdPXjiUVgnTHxKxsHygyyyw64GDiEmRfnEgGfD7St35k
 dwjr7gYfl7DlxLGkxtUPz4xP58lJPZ5xv+jR8NDqVn4f7fKe85zz0aYIN1n/GDNL00zg
 WmDU7BiHXwQmiy+Byh8YQoMtUrEirCaF7dnFjzq9HGUvdLcXkRvl2bxYROn3J1NosjQU
 X+xQMru1uIfllAY1C0n/tJnpYt1l/Hspic7TgCcFp7gv0wTnzn9AAt/BiejupgQjPhp1
 azDNu2Vbssl0yyJ+oQxHAG0pLcOvHNpHs9TYp+TNdakjEYn38mdFu0PeS6IzL3qMPcVE ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s6gr0rmdk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 17:04:42 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36VGn9NX006840;
        Mon, 31 Jul 2023 17:04:41 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s6gr0rmcf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 17:04:41 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36VFv9N6015486;
        Mon, 31 Jul 2023 17:04:40 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s5e3mmufr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 17:04:40 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36VH4dvN5505674
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 17:04:40 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE40B5804B;
        Mon, 31 Jul 2023 17:04:39 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB7E958059;
        Mon, 31 Jul 2023 17:04:38 +0000 (GMT)
Received: from [9.61.57.205] (unknown [9.61.57.205])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 31 Jul 2023 17:04:38 +0000 (GMT)
Message-ID: <b1b92581-56f2-b684-573f-50a66ca9fbf2@linux.vnet.ibm.com>
Date:   Mon, 31 Jul 2023 13:04:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4] integrity: Always reference the blacklist keyring with
 appraisal
To:     Eric Snowberg <eric.snowberg@oracle.com>, zohar@linux.ibm.com
Cc:     dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, roberto.sassu@huawei.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20230726211725.393056-1-eric.snowberg@oracle.com>
Content-Language: en-US
From:   Nayna <nayna@linux.vnet.ibm.com>
In-Reply-To: <20230726211725.393056-1-eric.snowberg@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: m8Brc2qtqorRhLNe2PYoQTFYxuCsdDBQ
X-Proofpoint-ORIG-GUID: mEL0qzk3mTtVM_Rrcnb0-7cr0iryTkCT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_09,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 clxscore=1011 mlxscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310149
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/26/23 17:17, Eric Snowberg wrote:
> Commit 273df864cf746 ("ima: Check against blacklisted hashes for files with
> modsig") introduced an appraise_flag option for referencing the blacklist
> keyring.  Any matching binary found on this keyring fails signature
> validation. This flag only works with module appended signatures.
>
> An important part of a PKI infrastructure is to have the ability to do
> revocation at a later time should a vulnerability be found.  Expand the
> revocation flag usage to all appraisal functions. The flag is now
> enabled by default. Setting the flag with an IMA policy has been
> deprecated. Without a revocation capability like this in place, only
> authenticity can be maintained. With this change, integrity can now be
> achieved with digital signature based IMA appraisal.
>
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
> v4 changes:
>    Fixed typo
>    Also did some performance testing with this patch. With the associative array
>    implementation used within the keyring code, there doesn't seem to be much of a
>    difference between doing  an appraisal with an empty blacklist keyring and one
>    containing 1500 entries.  At this time it is unknown how many entries a user
>    would place in this keyring, but this seemed like a bigger number than most use
>    cases.  With the 1500 entries, there were only 7 lookups to get through the
>    entire list for a file not contained within it.  For something that was
>    on the list, there was an average of 4 lookups and a single string compare.
>    Based on this testing, IMHO, there could be a lot more entries added to the
>    blacklist keyring without any real performance issues.

Nice to see the performance test results.

Reviewed-by: Nayna Jain <nayna@linux.ibm.com>

Thanks & Regards,

      - Nayna

>
> v3 changes:
>    No longer display appraise_flag=check_blacklist in the policy
>
> v2 changes:
>    Update the "case Opt_apprase_flag"
>    Removed "appraise_flag=" in the powerpc arch specific policy rules
> ---
>   Documentation/ABI/testing/ima_policy  |  6 +++---
>   arch/powerpc/kernel/ima_arch.c        |  8 ++++----
>   security/integrity/ima/ima_appraise.c | 12 +++++++-----
>   security/integrity/ima/ima_policy.c   | 17 +++++------------
>   4 files changed, 19 insertions(+), 24 deletions(-)
>
> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> index 49db0ff288e5..c2385183826c 100644
> --- a/Documentation/ABI/testing/ima_policy
> +++ b/Documentation/ABI/testing/ima_policy
> @@ -57,9 +57,9 @@ Description:
>   				stored in security.ima xattr. Requires
>   				specifying "digest_type=verity" first.)
>
> -			appraise_flag:= [check_blacklist]
> -			Currently, blacklist check is only for files signed with appended
> -			signature.
> +			appraise_flag:= [check_blacklist] (deprecated)
> +			Setting the check_blacklist flag is no longer necessary.
> +			All appraisal functions set it by default.
>   			digest_type:= verity
>   			    Require fs-verity's file digest instead of the
>   			    regular IMA file hash.
> diff --git a/arch/powerpc/kernel/ima_arch.c b/arch/powerpc/kernel/ima_arch.c
> index 957abd592075..b7029beed847 100644
> --- a/arch/powerpc/kernel/ima_arch.c
> +++ b/arch/powerpc/kernel/ima_arch.c
> @@ -23,9 +23,9 @@ bool arch_ima_get_secureboot(void)
>    * is not enabled.
>    */
>   static const char *const secure_rules[] = {
> -	"appraise func=KEXEC_KERNEL_CHECK appraise_flag=check_blacklist appraise_type=imasig|modsig",
> +	"appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig|modsig",
>   #ifndef CONFIG_MODULE_SIG
> -	"appraise func=MODULE_CHECK appraise_flag=check_blacklist appraise_type=imasig|modsig",
> +	"appraise func=MODULE_CHECK appraise_type=imasig|modsig",
>   #endif
>   	NULL
>   };
> @@ -49,9 +49,9 @@ static const char *const trusted_rules[] = {
>   static const char *const secure_and_trusted_rules[] = {
>   	"measure func=KEXEC_KERNEL_CHECK template=ima-modsig",
>   	"measure func=MODULE_CHECK template=ima-modsig",
> -	"appraise func=KEXEC_KERNEL_CHECK appraise_flag=check_blacklist appraise_type=imasig|modsig",
> +	"appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig|modsig",
>   #ifndef CONFIG_MODULE_SIG
> -	"appraise func=MODULE_CHECK appraise_flag=check_blacklist appraise_type=imasig|modsig",
> +	"appraise func=MODULE_CHECK appraise_type=imasig|modsig",
>   #endif
>   	NULL
>   };
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 491c1aca0b1c..870dde67707b 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -458,11 +458,13 @@ int ima_check_blacklist(struct integrity_iint_cache *iint,
>   		ima_get_modsig_digest(modsig, &hash_algo, &digest, &digestsize);
>
>   		rc = is_binary_blacklisted(digest, digestsize);
> -		if ((rc == -EPERM) && (iint->flags & IMA_MEASURE))
> -			process_buffer_measurement(&nop_mnt_idmap, NULL, digest, digestsize,
> -						   "blacklisted-hash", NONE,
> -						   pcr, NULL, false, NULL, 0);
> -	}
> +	} else if (iint->flags & IMA_DIGSIG_REQUIRED && iint->ima_hash)
> +		rc = is_binary_blacklisted(iint->ima_hash->digest, iint->ima_hash->length);
> +
> +	if ((rc == -EPERM) && (iint->flags & IMA_MEASURE))
> +		process_buffer_measurement(&nop_mnt_idmap, NULL, digest, digestsize,
> +					   "blacklisted-hash", NONE,
> +					   pcr, NULL, false, NULL, 0);
>
>   	return rc;
>   }
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index c9b3bd8f1bb9..69452b79686b 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -1280,7 +1280,7 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
>   				     IMA_FSNAME | IMA_GID | IMA_EGID |
>   				     IMA_FGROUP | IMA_DIGSIG_REQUIRED |
>   				     IMA_PERMIT_DIRECTIO | IMA_VALIDATE_ALGOS |
> -				     IMA_VERITY_REQUIRED))
> +				     IMA_CHECK_BLACKLIST | IMA_VERITY_REQUIRED))
>   			return false;
>
>   		break;
> @@ -1355,7 +1355,7 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
>
>   	/* Ensure that combinations of flags are compatible with each other */
>   	if (entry->flags & IMA_CHECK_BLACKLIST &&
> -	    !(entry->flags & IMA_MODSIG_ALLOWED))
> +	    !(entry->flags & IMA_DIGSIG_REQUIRED))
>   		return false;
>
>   	/*
> @@ -1803,11 +1803,11 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>   				if (entry->flags & IMA_VERITY_REQUIRED)
>   					result = -EINVAL;
>   				else
> -					entry->flags |= IMA_DIGSIG_REQUIRED;
> +					entry->flags |= IMA_DIGSIG_REQUIRED | IMA_CHECK_BLACKLIST;
>   			} else if (strcmp(args[0].from, "sigv3") == 0) {
>   				/* Only fsverity supports sigv3 for now */
>   				if (entry->flags & IMA_VERITY_REQUIRED)
> -					entry->flags |= IMA_DIGSIG_REQUIRED;
> +					entry->flags |= IMA_DIGSIG_REQUIRED | IMA_CHECK_BLACKLIST;
>   				else
>   					result = -EINVAL;
>   			} else if (IS_ENABLED(CONFIG_IMA_APPRAISE_MODSIG) &&
> @@ -1816,18 +1816,13 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>   					result = -EINVAL;
>   				else
>   					entry->flags |= IMA_DIGSIG_REQUIRED |
> -						IMA_MODSIG_ALLOWED;
> +						IMA_MODSIG_ALLOWED | IMA_CHECK_BLACKLIST;
>   			} else {
>   				result = -EINVAL;
>   			}
>   			break;
>   		case Opt_appraise_flag:
>   			ima_log_string(ab, "appraise_flag", args[0].from);
> -			if (IS_ENABLED(CONFIG_IMA_APPRAISE_MODSIG) &&
> -			    strstr(args[0].from, "blacklist"))
> -				entry->flags |= IMA_CHECK_BLACKLIST;
> -			else
> -				result = -EINVAL;
>   			break;
>   		case Opt_appraise_algos:
>   			ima_log_string(ab, "appraise_algos", args[0].from);
> @@ -2271,8 +2266,6 @@ int ima_policy_show(struct seq_file *m, void *v)
>   	}
>   	if (entry->flags & IMA_VERITY_REQUIRED)
>   		seq_puts(m, "digest_type=verity ");
> -	if (entry->flags & IMA_CHECK_BLACKLIST)
> -		seq_puts(m, "appraise_flag=check_blacklist ");
>   	if (entry->flags & IMA_PERMIT_DIRECTIO)
>   		seq_puts(m, "permit_directio ");
>   	rcu_read_unlock();
