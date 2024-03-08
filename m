Return-Path: <linux-kernel+bounces-96724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CD48760A6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1FE0B23327
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8715F52F8B;
	Fri,  8 Mar 2024 09:05:46 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A73052F86;
	Fri,  8 Mar 2024 09:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709888745; cv=none; b=Psdiabah+5JOM9Pvp3nTcAShGc44yqrT0pm8Cx9UQDRJcZba4R1fZGas4Sw5JzeqG2Im8zYutDd4sr/OFo+Bw1LgXZNvbjDwiLefIZAuyXZcT4duyCyxcAKgjOQ2Rj7uPyhtwuDm2b7+Z+1ekmNz+IQw/cqIAYa8Cv/G7JD3jg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709888745; c=relaxed/simple;
	bh=ytd1Sesf5xLoIOlXM6SXjo4arGNwdSzEm4iEXQwSydE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=swJOMYf4oDCyE5cNKts+8ApaY6sRwCcQaQMJ2UHJGnhSHaz3SoyS9y8lbvAR9r2TCLpnbx15SLQLjv9g/BupMmStucGd9ZXUYOXUNIwX2dw+uXyEI+Z7gcj4w24gcH3R+vSV/+m7eVq2OrDOxGfgGMki10BqJMiS1CK2rA3wqIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Trfxb0yQPzB0437;
	Fri,  8 Mar 2024 16:49:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 32DE71407C6;
	Fri,  8 Mar 2024 17:05:30 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAHshrJ1OplWBbxAw--.20221S2;
	Fri, 08 Mar 2024 10:05:29 +0100 (CET)
Message-ID: <71c77bbef487ae3279f0c3f85785bd0c03a4ee8c.camel@huaweicloud.com>
Subject: Re: [RFC][PATCH 3/8] ima: Add digest_cache policy keyword
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Mimi Zohar <zohar@linux.ibm.com>, corbet@lwn.net,
 dmitry.kasatkin@gmail.com,  eric.snowberg@oracle.com, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
 wufan@linux.microsoft.com, pbrobinson@gmail.com, zbyszek@in.waw.pl,
 hch@lst.de,  mjg59@srcf.ucam.org, pmatilai@redhat.com, jannh@google.com,
 dhowells@redhat.com,  jikos@kernel.org, mkoutny@suse.com, ppavlu@suse.com,
 petr.vorel@gmail.com,  petrtesarik@huaweicloud.com, mzerqung@0pointer.de,
 kgold@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Date: Fri, 08 Mar 2024 10:05:09 +0100
In-Reply-To: <031d4ff2bf0c04df5f4094989b94f7ce3e3e73f6.camel@linux.ibm.com>
References: <20240214143525.2205481-1-roberto.sassu@huaweicloud.com>
	 <20240214143525.2205481-4-roberto.sassu@huaweicloud.com>
	 <031d4ff2bf0c04df5f4094989b94f7ce3e3e73f6.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwAHshrJ1OplWBbxAw--.20221S2
X-Coremail-Antispam: 1UD129KBjvAXoW3trWxCryruF4DXry7GryxAFb_yoW8Xw18Go
	Z3K39rJF4xGry5uayUCFnxAFW8W3yrK34xJF4vqr98A3Z2qryUKa9rWr1UZFWfZFy8Xayv
	k3WxJ340qFWkJas3n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYw7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
	x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
	JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JV
	W8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd8n
	5UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAQBF1jj5cePwABsQ

On Thu, 2024-03-07 at 14:43 -0500, Mimi Zohar wrote:
> On Wed, 2024-02-14 at 15:35 +0100, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > Add the 'digest_cache=3D' policy keyword, to enable the usage of digest
> > caches for specific IMA actions and purposes.
> >=20
> > At the moment, it accepts only 'content' as value, as digest caches can=
 be
> > only used only for measurement and appraisal of file content. In the
> > future, it might be possible to use them for file metadata too.
>=20
> At least from this patch, it is unclear why 'digest_cache' requires an op=
tion. =20
> The usage - measure, appraise - is based on 'action'.  From an IMA perspe=
ctive,
> does the file content make a difference?  And if it did, then file 'data'=
 would
> parallel file 'metadata'.

I wanted to express the fact that digest caches, if available, can only
be used to appraise file data, if there is no metadata (similarly to
module-style appended signatures).

That would prevent for example the scenario where appraisal of file
data is successful without having verified current metadata, and EVM
attaches to the file a valid HMAC on file close, based on the current
xattr value (trust at first use).

An IMA rule with 'digest_cache=3Dmetadata' would take a different code
path. It would make IMA send to evm_verifyxattr() the calculated file
digest (since there is no security.ima), and let EVM calculate and
search the digest of file metadata in the digest cache.

I didn't go that far yet, but this is more or less what I would like to
do, also based on my old implementation of the IMA Digest Lists
extension (which supports file metadata lookup).

> Without having to pass around "digest_cache_mask" would simplify this pat=
ch.

We need to pass it anyway, to let process_measurement() know that it
can use digest caches. Or we can make 'flags' in ima_iint_cache a u64,
and introduce new flags.

Roberto


> Mimi
>=20
> > The 'digest_cache=3D' keyword can be specified for the subset of IMA ho=
oks
> > listed in ima_digest_cache_func_allowed().
> >=20
> > POLICY_CHECK has been excluded for measurement, because policy changes =
must
> > be visible in the IMA measurement list. For appraisal, instead, it migh=
t be
> > useful to load custom policies in the initial ram disk (no security.ima
> > xattr).
> >=20
> > Add the digest_cache_mask member to the ima_rule_entry structure, and s=
et
> > the flag IMA_DIGEST_CACHE_MEASURE_CONTENT if 'digest_cache=3Dcontent' w=
as
> > specified for a measure rule, IMA_DIGEST_CACHE_APPRAISE_CONTENT for an
> > appraise rule.
> >=20
> > Propagate the mask down to ima_match_policy() and ima_get_action(), so =
that
> > process_measurement() can make the final decision on whether or not dig=
est
> > caches should be used to measure/appraise the file being evaluated.
> >=20
> > Since using digest caches changes the meaning of the IMA measurement li=
st,
> > which will include only digest lists and unknown files, enforce specify=
ing
> > 'pcr=3D' with a non-standard value, when 'digest_cache=3Dcontent' is sp=
ecified
> > in a measure rule.
> >=20
> > This removes the ambiguity on the meaning of the IMA measurement list.
> >=20
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  Documentation/ABI/testing/ima_policy  |  5 +-
> >  security/integrity/ima/ima.h          | 10 +++-
> >  security/integrity/ima/ima_api.c      |  6 ++-
> >  security/integrity/ima/ima_appraise.c |  2 +-
> >  security/integrity/ima/ima_main.c     |  8 +--
> >  security/integrity/ima/ima_policy.c   | 70 ++++++++++++++++++++++++++-
> >  6 files changed, 89 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/Documentation/ABI/testing/ima_policy
> > b/Documentation/ABI/testing/ima_policy
> > index 22237fec5532..be045fb60530 100644
> > --- a/Documentation/ABI/testing/ima_policy
> > +++ b/Documentation/ABI/testing/ima_policy
> > @@ -29,7 +29,7 @@ Description:
> >  				 [obj_user=3D] [obj_role=3D] [obj_type=3D]]
> >  			option:	[digest_type=3D] [template=3D] [permit_directio]
> >  				[appraise_type=3D] [appraise_flag=3D]
> > -				[appraise_algos=3D] [keyrings=3D]
> > +				[appraise_algos=3D] [keyrings=3D] [digest_cache=3D]
> >  		  base:
> >  			func:=3D
> > [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
> >  				[FIRMWARE_CHECK]
> > @@ -77,6 +77,9 @@ Description:
> >  			For example, "sha256,sha512" to only accept to appraise
> >  			files where the security.ima xattr was hashed with one
> >  			of these two algorithms.
> > +			digest_cache:=3D [content]
> > +			"content" means that the digest cache is used only
> > +			for file content measurement and/or appraisal.
> > =20
> >  		  default policy:
> >  			# PROC_SUPER_MAGIC
> > diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.=
h
> > index c9140a57b591..deee56d99d6f 100644
> > --- a/security/integrity/ima/ima.h
> > +++ b/security/integrity/ima/ima.h
> > @@ -43,6 +43,10 @@ enum tpm_pcrs { TPM_PCR0 =3D 0, TPM_PCR8 =3D 8, TPM_=
PCR10 =3D 10
> > };
> > =20
> >  #define NR_BANKS(chip) ((chip !=3D NULL) ? chip->nr_allocated_banks : =
0)
> > =20
> > +/* Digest cache usage flags. */
> > +#define IMA_DIGEST_CACHE_MEASURE_CONTENT	0x0000000000000001
> > +#define IMA_DIGEST_CACHE_APPRAISE_CONTENT	0x0000000000000002
> > +
> >  /* current content of the policy */
> >  extern int ima_policy_flag;
> > =20
> > @@ -367,7 +371,8 @@ int ima_get_action(struct mnt_idmap *idmap, struct =
inode
> > *inode,
> >  		   const struct cred *cred, u32 secid, int mask,
> >  		   enum ima_hooks func, int *pcr,
> >  		   struct ima_template_desc **template_desc,
> > -		   const char *func_data, unsigned int *allowed_algos);
> > +		   const char *func_data, unsigned int *allowed_algos,
> > +		   u64 *digest_cache_mask);
> >  int ima_must_measure(struct inode *inode, int mask, enum ima_hooks fun=
c);
> >  int ima_collect_measurement(struct ima_iint_cache *iint, struct file *=
file,
> >  			    void *buf, loff_t size, enum hash_algo algo,
> > @@ -398,7 +403,8 @@ int ima_match_policy(struct mnt_idmap *idmap, struc=
t inode
> > *inode,
> >  		     const struct cred *cred, u32 secid, enum ima_hooks func,
> >  		     int mask, int flags, int *pcr,
> >  		     struct ima_template_desc **template_desc,
> > -		     const char *func_data, unsigned int *allowed_algos);
> > +		     const char *func_data, unsigned int *allowed_algos,
> > +		     u64 *digest_cache_mask);
> >  void ima_init_policy(void);
> >  void ima_update_policy(void);
> >  void ima_update_policy_flags(void);
> > diff --git a/security/integrity/ima/ima_api.c
> > b/security/integrity/ima/ima_api.c
> > index b37d043d5748..87e286ace43c 100644
> > --- a/security/integrity/ima/ima_api.c
> > +++ b/security/integrity/ima/ima_api.c
> > @@ -173,6 +173,7 @@ void ima_add_violation(struct file *file, const uns=
igned
> > char *filename,
> >   * @template_desc: pointer filled in if matched measure policy sets te=
mplate=3D
> >   * @func_data: func specific data, may be NULL
> >   * @allowed_algos: allowlist of hash algorithms for the IMA xattr
> > + * @digest_cache_mask: Actions and purposes for which digest cache is =
allowed
> >   *
> >   * The policy is defined in terms of keypairs:
> >   *		subj=3D, obj=3D, type=3D, func=3D, mask=3D, fsmagic=3D
> > @@ -190,7 +191,8 @@ int ima_get_action(struct mnt_idmap *idmap, struct =
inode
> > *inode,
> >  		   const struct cred *cred, u32 secid, int mask,
> >  		   enum ima_hooks func, int *pcr,
> >  		   struct ima_template_desc **template_desc,
> > -		   const char *func_data, unsigned int *allowed_algos)
> > +		   const char *func_data, unsigned int *allowed_algos,
> > +		   u64 *digest_cache_mask)
> >  {
> >  	int flags =3D IMA_MEASURE | IMA_AUDIT | IMA_APPRAISE | IMA_HASH;
> > =20
> > @@ -198,7 +200,7 @@ int ima_get_action(struct mnt_idmap *idmap, struct =
inode
> > *inode,
> > =20
> >  	return ima_match_policy(idmap, inode, cred, secid, func, mask,
> >  				flags, pcr, template_desc, func_data,
> > -				allowed_algos);
> > +				allowed_algos, digest_cache_mask);
> >  }
> > =20
> >  static bool ima_get_verity_digest(struct ima_iint_cache *iint,
> > diff --git a/security/integrity/ima/ima_appraise.c
> > b/security/integrity/ima/ima_appraise.c
> > index 3497741caea9..27ccc9a2c09f 100644
> > --- a/security/integrity/ima/ima_appraise.c
> > +++ b/security/integrity/ima/ima_appraise.c
> > @@ -81,7 +81,7 @@ int ima_must_appraise(struct mnt_idmap *idmap, struct=
 inode
> > *inode,
> >  	security_current_getsecid_subj(&secid);
> >  	return ima_match_policy(idmap, inode, current_cred(), secid,
> >  				func, mask, IMA_APPRAISE | IMA_HASH, NULL,
> > -				NULL, NULL, NULL);
> > +				NULL, NULL, NULL, NULL);
> >  }
> > =20
> >  static int ima_fix_xattr(struct dentry *dentry, struct ima_iint_cache =
*iint)
> > diff --git a/security/integrity/ima/ima_main.c
> > b/security/integrity/ima/ima_main.c
> > index 18285fc8ac07..e3ca80098c4c 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -232,7 +232,7 @@ static int process_measurement(struct file *file, c=
onst
> > struct cred *cred,
> >  	 */
> >  	action =3D ima_get_action(file_mnt_idmap(file), inode, cred, secid,
> >  				mask, func, &pcr, &template_desc, NULL,
> > -				&allowed_algos);
> > +				&allowed_algos, NULL);
> >  	violation_check =3D ((func =3D=3D FILE_CHECK || func =3D=3D MMAP_CHEC=
K ||
> >  			    func =3D=3D MMAP_CHECK_REQPROT) &&
> >  			   (ima_policy_flag & IMA_MEASURE));
> > @@ -489,11 +489,11 @@ static int ima_file_mprotect(struct vm_area_struc=
t *vma,
> > unsigned long reqprot,
> >  	inode =3D file_inode(vma->vm_file);
> >  	action =3D ima_get_action(file_mnt_idmap(vma->vm_file), inode,
> >  				current_cred(), secid, MAY_EXEC, MMAP_CHECK,
> > -				&pcr, &template, NULL, NULL);
> > +				&pcr, &template, NULL, NULL, NULL);
> >  	action |=3D ima_get_action(file_mnt_idmap(vma->vm_file), inode,
> >  				 current_cred(), secid, MAY_EXEC,
> >  				 MMAP_CHECK_REQPROT, &pcr, &template, NULL,
> > -				 NULL);
> > +				 NULL, NULL);
> > =20
> >  	/* Is the mmap'ed file in policy? */
> >  	if (!(action & (IMA_MEASURE | IMA_APPRAISE_SUBMASK)))
> > @@ -972,7 +972,7 @@ int process_buffer_measurement(struct mnt_idmap *id=
map,
> >  		security_current_getsecid_subj(&secid);
> >  		action =3D ima_get_action(idmap, inode, current_cred(),
> >  					secid, 0, func, &pcr, &template,
> > -					func_data, NULL);
> > +					func_data, NULL, NULL);
> >  		if (!(action & IMA_MEASURE) && !digest)
> >  			return -ENOENT;
> >  	}
> > diff --git a/security/integrity/ima/ima_policy.c
> > b/security/integrity/ima/ima_policy.c
> > index 7cfd1860791f..4ac83df8d255 100644
> > --- a/security/integrity/ima/ima_policy.c
> > +++ b/security/integrity/ima/ima_policy.c
> > @@ -122,6 +122,7 @@ struct ima_rule_entry {
> >  	struct ima_rule_opt_list *keyrings; /* Measure keys added to these
> > keyrings */
> >  	struct ima_rule_opt_list *label; /* Measure data grouped under this
> > label */
> >  	struct ima_template_desc *template;
> > +	u64 digest_cache_mask;	/* Actions and purposes for which digest cache
> > is allowed */
> >  };
> > =20
> >  /*
> > @@ -726,6 +727,7 @@ static int get_subaction(struct ima_rule_entry *rul=
e, enum
> > ima_hooks func)
> >   * @template_desc: the template that should be used for this rule
> >   * @func_data: func specific data, may be NULL
> >   * @allowed_algos: allowlist of hash algorithms for the IMA xattr
> > + * @digest_cache_mask: Actions and purposes for which digest cache is =
allowed
>=20
> Purpose=20
> >   *
> >   * Measure decision based on func/mask/fsmagic and LSM(subj/obj/type)
> >   * conditions.
> > @@ -738,7 +740,8 @@ int ima_match_policy(struct mnt_idmap *idmap, struc=
t inode
> > *inode,
> >  		     const struct cred *cred, u32 secid, enum ima_hooks func,
> >  		     int mask, int flags, int *pcr,
> >  		     struct ima_template_desc **template_desc,
> > -		     const char *func_data, unsigned int *allowed_algos)
> > +		     const char *func_data, unsigned int *allowed_algos,
> > +		     u64 *digest_cache_mask)
> >  {
> >  	struct ima_rule_entry *entry;
> >  	int action =3D 0, actmask =3D flags | (flags << 1);
> > @@ -783,6 +786,9 @@ int ima_match_policy(struct mnt_idmap *idmap, struc=
t inode
> > *inode,
> >  		if (template_desc && entry->template)
> >  			*template_desc =3D entry->template;
> > =20
> > +		if (digest_cache_mask)
> > +			*digest_cache_mask |=3D entry->digest_cache_mask;
> > +
> >  		if (!actmask)
> >  			break;
> >  	}
> > @@ -859,6 +865,30 @@ static int ima_appraise_flag(enum ima_hooks func)
> >  	return 0;
> >  }
> > =20
> > +static bool ima_digest_cache_func_allowed(struct ima_rule_entry *entry=
)
> > +{
> > +	switch (entry->func) {
> > +	case NONE:
> > +	case FILE_CHECK:
> > +	case MMAP_CHECK:
> > +	case MMAP_CHECK_REQPROT:
> > +	case BPRM_CHECK:
> > +	case CREDS_CHECK:
> > +	case FIRMWARE_CHECK:
> > +	case POLICY_CHECK:
> > +	case MODULE_CHECK:
> > +	case KEXEC_KERNEL_CHECK:
> > +	case KEXEC_INITRAMFS_CHECK:
> > +		/* Exception: always add policy updates to measurement list! */
> > +		if (entry->action =3D=3D MEASURE && entry->func =3D=3D POLICY_CHECK)
> > +			return false;
> > +
> > +		return true;
> > +	default:
> > +		return false;
> > +	}
> > +}
> > +
> >  static void add_rules(struct ima_rule_entry *entries, int count,
> >  		      enum policy_rule_list policy_rule)
> >  {
> > @@ -1073,7 +1103,7 @@ enum policy_opt {
> >  	Opt_digest_type,
> >  	Opt_appraise_type, Opt_appraise_flag, Opt_appraise_algos,
> >  	Opt_permit_directio, Opt_pcr, Opt_template, Opt_keyrings,
> > -	Opt_label, Opt_err
> > +	Opt_label, Opt_digest_cache, Opt_err
> >  };
> > =20
> >  static const match_table_t policy_tokens =3D {
> > @@ -1122,6 +1152,7 @@ static const match_table_t policy_tokens =3D {
> >  	{Opt_template, "template=3D%s"},
> >  	{Opt_keyrings, "keyrings=3D%s"},
> >  	{Opt_label, "label=3D%s"},
> > +	{Opt_digest_cache, "digest_cache=3D%s"},
> >  	{Opt_err, NULL}
> >  };
> > =20
> > @@ -1245,6 +1276,18 @@ static bool ima_validate_rule(struct ima_rule_en=
try
> > *entry)
> >  	if (entry->action !=3D MEASURE && entry->flags & IMA_PCR)
> >  		return false;
> > =20
> > +	/* New-style measurements with digest cache cannot be on default PCR.=
 */
> > +	if (entry->action =3D=3D MEASURE &&
> > +	    (entry->digest_cache_mask & IMA_DIGEST_CACHE_MEASURE_CONTENT)) {
> > +		if (!(entry->flags & IMA_PCR) ||
> > +		    entry->pcr =3D=3D CONFIG_IMA_MEASURE_PCR_IDX)
> > +			return false;
> > +	}
> > +
> > +	/* Digest caches can be used only for a subset of the IMA hooks. */
> > +	if (entry->digest_cache_mask && !ima_digest_cache_func_allowed(entry)=
)
> > +		return false;
> > +
> >  	if (entry->action !=3D APPRAISE &&
> >  	    entry->flags & (IMA_DIGSIG_REQUIRED | IMA_MODSIG_ALLOWED |
> >  			    IMA_CHECK_BLACKLIST | IMA_VALIDATE_ALGOS))
> > @@ -1881,6 +1924,26 @@ static int ima_parse_rule(char *rule, struct
> > ima_rule_entry *entry)
> >  						 &(template_desc->num_fields));
> >  			entry->template =3D template_desc;
> >  			break;
> > +		case Opt_digest_cache:
> > +			ima_log_string(ab, "digest_cache", args[0].from);
> > +
> > +			result =3D -EINVAL;
> > +
> > +			if (!strcmp(args[0].from, "content")) {
> > +				switch (entry->action) {
> > +				case MEASURE:
> > +					entry->digest_cache_mask |=3D
> > IMA_DIGEST_CACHE_MEASURE_CONTENT;
> > +					result =3D 0;
> > +					break;
> > +				case APPRAISE:
> > +					entry->digest_cache_mask |=3D
> > IMA_DIGEST_CACHE_APPRAISE_CONTENT;
> > +					result =3D 0;
> > +					break;
> > +				default:
> > +					break;
> > +				}
> > +			}
> > +			break;
> >  		case Opt_err:
> >  			ima_log_string(ab, "UNKNOWN", p);
> >  			result =3D -EINVAL;
> > @@ -2271,6 +2334,9 @@ int ima_policy_show(struct seq_file *m, void *v)
> >  		seq_puts(m, "digest_type=3Dverity ");
> >  	if (entry->flags & IMA_PERMIT_DIRECTIO)
> >  		seq_puts(m, "permit_directio ");
> > +	if ((entry->digest_cache_mask & IMA_DIGEST_CACHE_MEASURE_CONTENT) ||
> > +	    (entry->digest_cache_mask & IMA_DIGEST_CACHE_APPRAISE_CONTENT))
> > +		seq_puts(m, "digest_cache=3Dcontent ");
> >  	rcu_read_unlock();
> >  	seq_puts(m, "\n");
> >  	return 0;
>=20


