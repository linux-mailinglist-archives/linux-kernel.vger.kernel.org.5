Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20ACD75331C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 09:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbjGNHXI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 14 Jul 2023 03:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235259AbjGNHXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 03:23:02 -0400
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147F72722;
        Fri, 14 Jul 2023 00:22:57 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4R2N2D2s05z9xHf8;
        Fri, 14 Jul 2023 15:11:48 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwC3hl2197BkUW5+BA--.7298S2;
        Fri, 14 Jul 2023 08:22:37 +0100 (CET)
Message-ID: <ecbf405c6806fa4706051e0bf946d742f3442367.camel@huaweicloud.com>
Subject: Re: [PATCH v3] integrity: Always reference the blacklist keyring
 with apprasial
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>, zohar@linux.ibm.com
Cc:     dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, roberto.sassu@huawei.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Fri, 14 Jul 2023 09:22:25 +0200
In-Reply-To: <20230714011141.2288133-1-eric.snowberg@oracle.com>
References: <20230714011141.2288133-1-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-CM-TRANSID: GxC2BwC3hl2197BkUW5+BA--.7298S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JFyxKF45Kw1rKF4DXr1xAFb_yoW3Xr4fpa
        95tF1j9FyxGryIvFy7Aw4q9F4S9r4jqF4UCFZ8t340yFs5Xr10gr18GrZxZFWFkr95t3Z2
        qF1UK3yUA3Wjq37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgASBF1jj4xobAABss
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-07-13 at 21:11 -0400, Eric Snowberg wrote:
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
> v3 changes:
>   No longer display appraise_flag=check_blacklist in the policy
> v2 changes:
>   Update the "case Opt_apprase_flag"
>   Removed "appraise_flag=" in the powerpc arch specific policy rules
> ---
>  Documentation/ABI/testing/ima_policy  |  6 +++---
>  arch/powerpc/kernel/ima_arch.c        |  8 ++++----
>  security/integrity/ima/ima_appraise.c | 12 +++++++-----
>  security/integrity/ima/ima_policy.c   | 17 +++++------------
>  4 files changed, 19 insertions(+), 24 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> index 49db0ff288e5..a712c396f6e9 100644
> --- a/Documentation/ABI/testing/ima_policy
> +++ b/Documentation/ABI/testing/ima_policy
> @@ -57,9 +57,9 @@ Description:
>  				stored in security.ima xattr. Requires
>  				specifying "digest_type=verity" first.)
>  
> -			appraise_flag:= [check_blacklist]
> -			Currently, blacklist check is only for files signed with appended
> -			signature.
> +			appraise_flag:= [check_blacklist] (deprecated)
> +			Setting the check_blacklist flag is no longer necessary.
> +			All apprasial functions set it by default.

Typo.

>  			digest_type:= verity
>  			    Require fs-verity's file digest instead of the
>  			    regular IMA file hash.
> diff --git a/arch/powerpc/kernel/ima_arch.c b/arch/powerpc/kernel/ima_arch.c
> index 957abd592075..b7029beed847 100644
> --- a/arch/powerpc/kernel/ima_arch.c
> +++ b/arch/powerpc/kernel/ima_arch.c
> @@ -23,9 +23,9 @@ bool arch_ima_get_secureboot(void)
>   * is not enabled.
>   */
>  static const char *const secure_rules[] = {
> -	"appraise func=KEXEC_KERNEL_CHECK appraise_flag=check_blacklist appraise_type=imasig|modsig",
> +	"appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig|modsig",
>  #ifndef CONFIG_MODULE_SIG
> -	"appraise func=MODULE_CHECK appraise_flag=check_blacklist appraise_type=imasig|modsig",
> +	"appraise func=MODULE_CHECK appraise_type=imasig|modsig",
>  #endif
>  	NULL
>  };
> @@ -49,9 +49,9 @@ static const char *const trusted_rules[] = {
>  static const char *const secure_and_trusted_rules[] = {
>  	"measure func=KEXEC_KERNEL_CHECK template=ima-modsig",
>  	"measure func=MODULE_CHECK template=ima-modsig",
> -	"appraise func=KEXEC_KERNEL_CHECK appraise_flag=check_blacklist appraise_type=imasig|modsig",
> +	"appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig|modsig",
>  #ifndef CONFIG_MODULE_SIG
> -	"appraise func=MODULE_CHECK appraise_flag=check_blacklist appraise_type=imasig|modsig",
> +	"appraise func=MODULE_CHECK appraise_type=imasig|modsig",
>  #endif
>  	NULL
>  };
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 491c1aca0b1c..870dde67707b 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -458,11 +458,13 @@ int ima_check_blacklist(struct integrity_iint_cache *iint,
>  		ima_get_modsig_digest(modsig, &hash_algo, &digest, &digestsize);
>  
>  		rc = is_binary_blacklisted(digest, digestsize);
> -		if ((rc == -EPERM) && (iint->flags & IMA_MEASURE))
> -			process_buffer_measurement(&nop_mnt_idmap, NULL, digest, digestsize,
> -						   "blacklisted-hash", NONE,
> -						   pcr, NULL, false, NULL, 0);
> -	}
> +	} else if (iint->flags & IMA_DIGSIG_REQUIRED && iint->ima_hash)
> +		rc = is_binary_blacklisted(iint->ima_hash->digest, iint->ima_hash->length);

Curiosity (I didn't read the previous discussions), if you are checking
if binaries are blacklisted, why not doing for the BPRM_CHECK hook?

> +
> +	if ((rc == -EPERM) && (iint->flags & IMA_MEASURE))

Uhm, the measurement will be done only if you are also doing appraisal
with digital signatures. But if you have only measure rules, you won't
know. Shouldn't you run is_binary_blacklisted() also for measure rules?

Thanks

Roberto

> +		process_buffer_measurement(&nop_mnt_idmap, NULL, digest, digestsize,
> +					   "blacklisted-hash", NONE,
> +					   pcr, NULL, false, NULL, 0);
>  
>  	return rc;
>  }
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index c9b3bd8f1bb9..69452b79686b 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -1280,7 +1280,7 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
>  				     IMA_FSNAME | IMA_GID | IMA_EGID |
>  				     IMA_FGROUP | IMA_DIGSIG_REQUIRED |
>  				     IMA_PERMIT_DIRECTIO | IMA_VALIDATE_ALGOS |
> -				     IMA_VERITY_REQUIRED))
> +				     IMA_CHECK_BLACKLIST | IMA_VERITY_REQUIRED))
>  			return false;
>  
>  		break;
> @@ -1355,7 +1355,7 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
>  
>  	/* Ensure that combinations of flags are compatible with each other */
>  	if (entry->flags & IMA_CHECK_BLACKLIST &&
> -	    !(entry->flags & IMA_MODSIG_ALLOWED))
> +	    !(entry->flags & IMA_DIGSIG_REQUIRED))
>  		return false;
>  
>  	/*
> @@ -1803,11 +1803,11 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  				if (entry->flags & IMA_VERITY_REQUIRED)
>  					result = -EINVAL;
>  				else
> -					entry->flags |= IMA_DIGSIG_REQUIRED;
> +					entry->flags |= IMA_DIGSIG_REQUIRED | IMA_CHECK_BLACKLIST;
>  			} else if (strcmp(args[0].from, "sigv3") == 0) {
>  				/* Only fsverity supports sigv3 for now */
>  				if (entry->flags & IMA_VERITY_REQUIRED)
> -					entry->flags |= IMA_DIGSIG_REQUIRED;
> +					entry->flags |= IMA_DIGSIG_REQUIRED | IMA_CHECK_BLACKLIST;
>  				else
>  					result = -EINVAL;
>  			} else if (IS_ENABLED(CONFIG_IMA_APPRAISE_MODSIG) &&
> @@ -1816,18 +1816,13 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  					result = -EINVAL;
>  				else
>  					entry->flags |= IMA_DIGSIG_REQUIRED |
> -						IMA_MODSIG_ALLOWED;
> +						IMA_MODSIG_ALLOWED | IMA_CHECK_BLACKLIST;
>  			} else {
>  				result = -EINVAL;
>  			}
>  			break;
>  		case Opt_appraise_flag:
>  			ima_log_string(ab, "appraise_flag", args[0].from);
> -			if (IS_ENABLED(CONFIG_IMA_APPRAISE_MODSIG) &&
> -			    strstr(args[0].from, "blacklist"))
> -				entry->flags |= IMA_CHECK_BLACKLIST;
> -			else
> -				result = -EINVAL;
>  			break;
>  		case Opt_appraise_algos:
>  			ima_log_string(ab, "appraise_algos", args[0].from);
> @@ -2271,8 +2266,6 @@ int ima_policy_show(struct seq_file *m, void *v)
>  	}
>  	if (entry->flags & IMA_VERITY_REQUIRED)
>  		seq_puts(m, "digest_type=verity ");
> -	if (entry->flags & IMA_CHECK_BLACKLIST)
> -		seq_puts(m, "appraise_flag=check_blacklist ");
>  	if (entry->flags & IMA_PERMIT_DIRECTIO)
>  		seq_puts(m, "permit_directio ");
>  	rcu_read_unlock();

