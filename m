Return-Path: <linux-kernel+bounces-95093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F832874928
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04DBC285670
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C734A6312F;
	Thu,  7 Mar 2024 07:56:33 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8092C63113;
	Thu,  7 Mar 2024 07:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709798193; cv=none; b=m9lP7OTUWeaKRf+AU/iKRaKgy1eAFF+CHNcmzmbdGPeLhmjfb/R2+J8HdKgEZ5KrCSMCSJvefBlOSBBDFd/e7A+9ty5Q8tqee858KPzbIiKcx4kXelh0r1CzLcIFsGSv2sI1eiuCRf2sSnjhrXvTh1NkmheTA62jCG9/5aXrtPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709798193; c=relaxed/simple;
	bh=aDQo1bQl0RDAwOdXjNmrDGk/5u267gaajZWOBt0j6Es=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UE0Cxjd5HoAwZs1FeBtTrGOPJZXygvzjhIN9b9SJIlWRyPGq+NS2s8gCJihBWEAM9c2dFuMxHUuIrae6NcEhF694J0nG+4L8D6hqc5dwIN0n0VeDDFSXCqUe3zbHNslW+1BANeu8J7EWr+CBgqFaxO7V4DFuXrnkJu4otsPbJeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Tr1MY1qKTz9xwvx;
	Thu,  7 Mar 2024 15:36:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 142591404FE;
	Thu,  7 Mar 2024 15:56:21 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDHuhMac+ll5APgAw--.3745S2;
	Thu, 07 Mar 2024 08:56:20 +0100 (CET)
Message-ID: <85d71fd5ac7ffe9aee399b4754a8bb1ec44e7186.camel@huaweicloud.com>
Subject: Re: [PATCH v39 01/42] integrity: disassociate ima_filter_rule from
 security_audit_rule
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com, 
	linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, 
 john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, 
 stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
 mic@digikod.net,  linux-integrity@vger.kernel.org
Date: Thu, 07 Mar 2024 08:56:07 +0100
In-Reply-To: <5c99f987-d359-4366-984f-fe36fcff601b@schaufler-ca.com>
References: <20231215221636.105680-1-casey@schaufler-ca.com>
	 <20231215221636.105680-2-casey@schaufler-ca.com>
	 <d4cbe23822f7fdac900d1ebd5da9865d8bb96977.camel@huaweicloud.com>
	 <5c99f987-d359-4366-984f-fe36fcff601b@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwDHuhMac+ll5APgAw--.3745S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Gw1DZry3Xr1UKF1xCFykXwb_yoW7WF4UpF
	WUKF4UCFW0qFy7Gr9ay3Zru3ZaqrWrGr1DZrsxG34qyFn0yrnrGr13Ar4rur9Yg3y0yr1I
	vF17WrW3ur4Dt3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAPBF1jj5sSDgAAs8

On Wed, 2024-03-06 at 08:56 -0800, Casey Schaufler wrote:
> On 3/6/2024 1:54 AM, Roberto Sassu wrote:
> > On Fri, 2023-12-15 at 14:15 -0800, Casey Schaufler wrote:
> > > Create real functions for the ima_filter_rule interfaces.
> > > These replace #defines that obscure the reuse of audit
> > > interfaces. The new functions are put in security.c because
> > > they use security module registered hooks that we don't
> > > want exported.
> > Beginner question: what makes IMA special, that the audit subsystem
> > does not need an AUDIT_LSM field to do the same that IMA would do?
> >=20
> > In other words, why can't we add the lsm_id parameter to
> > security_audit_*() functions, so that IMA can just call those?
>=20
> I have never liked the reuse of the audit filter functions, especially
> the way that they're hidden behind #define. The assumption that the
> two facilities (audit and IMA) are going to use them the same way, and
> that they will never diverge in their requirements, has always seemed
> questionable.
>=20
> In most cases audit needs an lsmblob rather than a secid+lsm_id pair,
> as there is information required about all the LSMs, not just the one
> actively involved.

Fair enough.

Thanks

Roberto

> >=20
> > Thanks
> >=20
> > Roberto
> >=20
> > > Acked-by: Paul Moore <paul@paul-moore.com>
> > > Reviewed-by: John Johansen <john.johansen@canonical.com>
> > > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > > To: Mimi Zohar <zohar@linux.ibm.com>
> > > Cc: linux-integrity@vger.kernel.org
> > > ---
> > >  include/linux/security.h     | 24 ++++++++++++++++++++++++
> > >  security/integrity/ima/ima.h | 26 --------------------------
> > >  security/security.c          | 21 +++++++++++++++++++++
> > >  3 files changed, 45 insertions(+), 26 deletions(-)
> > >=20
> > > diff --git a/include/linux/security.h b/include/linux/security.h
> > > index 750130a7b9dd..4790508818ee 100644
> > > --- a/include/linux/security.h
> > > +++ b/include/linux/security.h
> > > @@ -2009,6 +2009,30 @@ static inline void security_audit_rule_free(vo=
id *lsmrule)
> > >  #endif /* CONFIG_SECURITY */
> > >  #endif /* CONFIG_AUDIT */
> > > =20
> > > +#if defined(CONFIG_IMA_LSM_RULES) && defined(CONFIG_SECURITY)
> > > +int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **ls=
mrule);
> > > +int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrul=
e);
> > > +void ima_filter_rule_free(void *lsmrule);
> > > +
> > > +#else
> > > +
> > > +static inline int ima_filter_rule_init(u32 field, u32 op, char *rule=
str,
> > > +					   void **lsmrule)
> > > +{
> > > +	return 0;
> > > +}
> > > +
> > > +static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op=
,
> > > +					    void *lsmrule)
> > > +{
> > > +	return 0;
> > > +}
> > > +
> > > +static inline void ima_filter_rule_free(void *lsmrule)
> > > +{ }
> > > +
> > > +#endif /* defined(CONFIG_IMA_LSM_RULES) && defined(CONFIG_SECURITY) =
*/
> > > +
> > >  #ifdef CONFIG_SECURITYFS
> > > =20
> > >  extern struct dentry *securityfs_create_file(const char *name, umode=
_t mode,
> > > diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/im=
a.h
> > > index c29db699c996..560d6104de72 100644
> > > --- a/security/integrity/ima/ima.h
> > > +++ b/security/integrity/ima/ima.h
> > > @@ -420,32 +420,6 @@ static inline void ima_free_modsig(struct modsig=
 *modsig)
> > >  }
> > >  #endif /* CONFIG_IMA_APPRAISE_MODSIG */
> > > =20
> > > -/* LSM based policy rules require audit */
> > > -#ifdef CONFIG_IMA_LSM_RULES
> > > -
> > > -#define ima_filter_rule_init security_audit_rule_init
> > > -#define ima_filter_rule_free security_audit_rule_free
> > > -#define ima_filter_rule_match security_audit_rule_match
> > > -
> > > -#else
> > > -
> > > -static inline int ima_filter_rule_init(u32 field, u32 op, char *rule=
str,
> > > -				       void **lsmrule)
> > > -{
> > > -	return -EINVAL;
> > > -}
> > > -
> > > -static inline void ima_filter_rule_free(void *lsmrule)
> > > -{
> > > -}
> > > -
> > > -static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op=
,
> > > -					void *lsmrule)
> > > -{
> > > -	return -EINVAL;
> > > -}
> > > -#endif /* CONFIG_IMA_LSM_RULES */
> > > -
> > >  #ifdef	CONFIG_IMA_READ_POLICY
> > >  #define	POLICY_FILE_FLAGS	(S_IWUSR | S_IRUSR)
> > >  #else
> > > diff --git a/security/security.c b/security/security.c
> > > index d7b15ea67c3f..8e5379a76369 100644
> > > --- a/security/security.c
> > > +++ b/security/security.c
> > > @@ -5350,6 +5350,27 @@ int security_audit_rule_match(u32 secid, u32 f=
ield, u32 op, void *lsmrule)
> > >  }
> > >  #endif /* CONFIG_AUDIT */
> > > =20
> > > +#ifdef CONFIG_IMA_LSM_RULES
> > > +/*
> > > + * The integrity subsystem uses the same hooks as
> > > + * the audit subsystem.
> > > + */
> > > +int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **ls=
mrule)
> > > +{
> > > +	return call_int_hook(audit_rule_init, 0, field, op, rulestr, lsmrul=
e);
> > > +}
> > > +
> > > +void ima_filter_rule_free(void *lsmrule)
> > > +{
> > > +	call_void_hook(audit_rule_free, lsmrule);
> > > +}
> > > +
> > > +int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrul=
e)
> > > +{
> > > +	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule=
);
> > > +}
> > > +#endif /* CONFIG_IMA_LSM_RULES */
> > > +
> > >  #ifdef CONFIG_BPF_SYSCALL
> > >  /**
> > >   * security_bpf() - Check if the bpf syscall operation is allowed


