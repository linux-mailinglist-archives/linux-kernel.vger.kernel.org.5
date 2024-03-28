Return-Path: <linux-kernel+bounces-123627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A42890BE9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8DB3299BCB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFDC13AA2C;
	Thu, 28 Mar 2024 20:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lg4YQqTq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E34A27446;
	Thu, 28 Mar 2024 20:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711658883; cv=none; b=mile2NFAFZTbYAOC6vzcO174T5AJtjiWKzSDYJWkguTXLJ4oL38j2xxQocFTK5Dv2rHveaWQLkhVcRAJOKJXZSncAAyXmjxLxZpl+fdujBSbGAyNO+ZwPBrVRCmifxZ/OJ3dw0N086kCpyjzkkzb3/CIjE7dGKacgi2pJjBx/7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711658883; c=relaxed/simple;
	bh=gqTYTlfwBBgcZXm1wwwUcREXO1OlHOxzRoKa0YS+7NY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ERAGHvtjk4/KXei1Y+7daiWSsb/cOao4i4ibPTycLNBdtnfqUjgaAZo6w/RN+R/3nctSYsSDvk/uTb43kvfRItKjNE2sya15rc3X/ZiJv0xv4Ht7f36+xu2YCyCDiXjyf9Ktv7ifqNdgLJ4E1HMfyb90AW8IJ55J7xuqHJE5HDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lg4YQqTq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D0C2C433C7;
	Thu, 28 Mar 2024 20:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711658882;
	bh=gqTYTlfwBBgcZXm1wwwUcREXO1OlHOxzRoKa0YS+7NY=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=lg4YQqTqetjhkHUa4M6dE0cLEPBNDXygOSkk8aOv3jhMLaNvu0586N8dBFqPmd/xf
	 BlSEAz2x+ZdX5Sf6iRW0JMgpRU3qdJsFyODNxph8HpmkWd9FQAOYRW7xyulBvJiuSh
	 /SoezZKG13ASTcxV1/pCQFl4nZGOly1H57BS3xOx3/ZXyJziNttnwuXuNN114VC9jp
	 /XeO1pVMfug1Q/QGE/4Ybfu/aJLHyoIKeX0qY5WXHvUBQmwwDz7WrsU9QuP02VUbC9
	 VfdWEEygQr3kqdOJNK6qqyGS2um/zV2avaIod8MWB5R7pQnihXTS4p86QvE4CAwscy
	 H7LpNU2TD3WYw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 Mar 2024 22:47:56 +0200
Message-Id: <D05OFKMW9DF7.3QI1B5EDFHWO0@kernel.org>
Cc: <linux-doc@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <fsverity@lists.linux.dev>,
 <linux-block@vger.kernel.org>, <dm-devel@lists.linux.dev>,
 <audit@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Deven Bowers"
 <deven.desai@linux.microsoft.com>
Subject: Re: [PATCH v16 02/20] ipe: add policy parser
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Fan Wu" <wufan@linux.microsoft.com>, <corbet@lwn.net>,
 <zohar@linux.ibm.com>, <jmorris@namei.org>, <serge@hallyn.com>,
 <tytso@mit.edu>, <ebiggers@kernel.org>, <axboe@kernel.dk>,
 <agk@redhat.com>, <snitzer@kernel.org>, <eparis@redhat.com>,
 <paul@paul-moore.com>
X-Mailer: aerc 0.17.0
References: <1711657047-10526-1-git-send-email-wufan@linux.microsoft.com>
 <1711657047-10526-3-git-send-email-wufan@linux.microsoft.com>
In-Reply-To: <1711657047-10526-3-git-send-email-wufan@linux.microsoft.com>

On Thu Mar 28, 2024 at 10:17 PM EET, Fan Wu wrote:
> From: Deven Bowers <deven.desai@linux.microsoft.com>
>
> IPE's interpretation of the what the user trusts is accomplished through
> its policy. IPE's design is to not provide support for a single trust
> provider, but to support multiple providers to enable the end-user to
> choose the best one to seek their needs.
>
> This requires the policy to be rather flexible and modular so that
> integrity providers, like fs-verity, dm-verity, dm-integrity, or
> some other system, can plug into the policy with minimal code changes.
>
> Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
>
> ---
> v2:
>   + Split evaluation loop, access control hooks,
>     and evaluation loop from policy parser and userspace
>     interface to pass mailing list character limit
>
> v3:
>   + Move policy load and activation audit event to 03/12
>   + Fix a potential panic when a policy failed to load.
>   + use pr_warn for a failure to parse instead of an
>     audit record
>   + Remove comments from headers
>   + Add lockdep assertions to ipe_update_active_policy and
>     ipe_activate_policy
>   + Fix up warnings with checkpatch --strict
>   + Use file_ns_capable for CAP_MAC_ADMIN for securityfs
>     nodes.
>   + Use memdup_user instead of kzalloc+simple_write_to_buffer.
>   + Remove strict_parse command line parameter, as it is added
>     by the sysctl command line.
>   + Prefix extern variables with ipe_
>
> v4:
>   + Remove securityfs to reverse-dependency
>   + Add SHA1 reverse dependency.
>   + Add versioning scheme for IPE properties, and associated
>     interface to query the versioning scheme.
>   + Cause a parser to always return an error on unknown syntax.
>   + Remove strict_parse option
>   + Change active_policy interface from sysctl, to securityfs,
>     and change scheme.
>
> v5:
>   + Cause an error if a default action is not defined for each
>     operation.
>   + Minor function renames
>
> v6:
>   + No changes
>
> v7:
>   + Further split parser and userspace interface into two
>     separate commits, for easier review.
>   + Refactor policy parser to make code cleaner via introducing a
>     more modular design, for easier extension of policy, and
>     easier review.
>
> v8:
>   + remove unnecessary pr_info emission on parser loading
>   + add explicit newline to the pr_err emitted when a parser
>     fails to load.
>
> v9:
>   + switch to match table to parse policy
>   + remove quote syntax and KERNEL_READ operation
>
> v10:
>   + Fix memory leaks in parser
>   + Fix typos and change code styles
>
> v11:
>   + Fix code style issues
>
> v12:
>   + Add __always_unused to an unused parameter
>   + Simplify error case handling
>
> v13:
>   + No changes
>
> v14:
>   + No changes
>
> v15:
>   + No changes
>
> v16:
>   + No changes
> ---
>  security/ipe/Makefile        |   2 +
>  security/ipe/policy.c        | 101 ++++++++
>  security/ipe/policy.h        |  83 ++++++
>  security/ipe/policy_parser.c | 487 +++++++++++++++++++++++++++++++++++
>  security/ipe/policy_parser.h |  11 +
>  5 files changed, 684 insertions(+)
>  create mode 100644 security/ipe/policy.c
>  create mode 100644 security/ipe/policy.h
>  create mode 100644 security/ipe/policy_parser.c
>  create mode 100644 security/ipe/policy_parser.h
>
> diff --git a/security/ipe/Makefile b/security/ipe/Makefile
> index f7a80d0f18f8..c09aec4904f2 100644
> --- a/security/ipe/Makefile
> +++ b/security/ipe/Makefile
> @@ -7,3 +7,5 @@
> =20
>  obj-$(CONFIG_SECURITY_IPE) +=3D \
>  	ipe.o \
> +	policy.o \
> +	policy_parser.o \
> diff --git a/security/ipe/policy.c b/security/ipe/policy.c
> new file mode 100644
> index 000000000000..f22a576a6d68
> --- /dev/null
> +++ b/security/ipe/policy.c
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) Microsoft Corporation. All rights reserved.
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/verification.h>
> +
> +#include "ipe.h"
> +#include "policy.h"
> +#include "policy_parser.h"
> +
> +/**
> + * ipe_free_policy - Deallocate a given IPE policy.
> + * @p: Supplies the policy to free.
> + *
> + * Safe to call on IS_ERR/NULL.
> + */
> +void ipe_free_policy(struct ipe_policy *p)
> +{
> +	if (IS_ERR_OR_NULL(p))
> +		return;
> +
> +	free_parsed_policy(p->parsed);
> +	/*
> +	 * p->text is allocated only when p->pkcs7 is not NULL
> +	 * otherwise it points to the plaintext data inside the pkcs7
> +	 */
> +	if (!p->pkcs7)
> +		kfree(p->text);
> +	kfree(p->pkcs7);
> +	kfree(p);
> +}
> +
> +static int set_pkcs7_data(void *ctx, const void *data, size_t len,
> +			  size_t asn1hdrlen __always_unused)
> +{
> +	struct ipe_policy *p =3D ctx;
> +
> +	p->text =3D (const char *)data;
> +	p->textlen =3D len;
> +
> +	return 0;
> +}
> +
> +/**
> + * ipe_new_policy - Allocate and parse an ipe_policy structure.
> + *
> + * @text: Supplies a pointer to the plain-text policy to parse.
> + * @textlen: Supplies the length of @text.
> + * @pkcs7: Supplies a pointer to a pkcs7-signed IPE policy.
> + * @pkcs7len: Supplies the length of @pkcs7.
> + *
> + * @text/@textlen Should be NULL/0 if @pkcs7/@pkcs7len is set.
> + *
> + * Return:
> + * * !IS_ERR	- Success
> + * * -EBADMSG	- Policy is invalid
> + * * -ENOMEM	- Out of memory
> + */
> +struct ipe_policy *ipe_new_policy(const char *text, size_t textlen,
> +				  const char *pkcs7, size_t pkcs7len)
> +{
> +	int rc =3D 0;
> +	struct ipe_policy *new =3D NULL;

In many places: reverse christmas tree would be so much more readable.

> +
> +	new =3D kzalloc(sizeof(*new), GFP_KERNEL);
> +	if (!new)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (!text) {
> +		new->pkcs7len =3D pkcs7len;
> +		new->pkcs7 =3D kmemdup(pkcs7, pkcs7len, GFP_KERNEL);
> +		if (!new->pkcs7) {
> +			rc =3D -ENOMEM;
> +			goto err;
> +		}
> +
> +		rc =3D verify_pkcs7_signature(NULL, 0, new->pkcs7, pkcs7len, NULL,
> +					    VERIFYING_UNSPECIFIED_SIGNATURE,
> +					    set_pkcs7_data, new);
> +		if (rc)
> +			goto err;
> +	} else {
> +		new->textlen =3D textlen;
> +		new->text =3D kstrdup(text, GFP_KERNEL);
> +		if (!new->text) {
> +			rc =3D -ENOMEM;
> +			goto err;
> +		}
> +	}
> +
> +	rc =3D parse_policy(new);
> +	if (rc)
> +		goto err;
> +
> +	return new;
> +err:
> +	ipe_free_policy(new);
> +	return ERR_PTR(rc);
> +}
> diff --git a/security/ipe/policy.h b/security/ipe/policy.h
> new file mode 100644
> index 000000000000..fb906f41522b
> --- /dev/null
> +++ b/security/ipe/policy.h
> @@ -0,0 +1,83 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) Microsoft Corporation. All rights reserved.
> + */
> +#ifndef _IPE_POLICY_H
> +#define _IPE_POLICY_H
> +
> +#include <linux/list.h>
> +#include <linux/types.h>
> +
> +enum ipe_op_type {
> +	IPE_OP_EXEC =3D 0,
> +	IPE_OP_FIRMWARE,
> +	IPE_OP_KERNEL_MODULE,
> +	IPE_OP_KEXEC_IMAGE,
> +	IPE_OP_KEXEC_INITRAMFS,
> +	IPE_OP_POLICY,
> +	IPE_OP_X509,
> +	__IPE_OP_MAX,
> +};
> +
> +#define IPE_OP_INVALID __IPE_OP_MAX
> +
> +enum ipe_action_type {
> +	IPE_ACTION_ALLOW =3D 0,
> +	IPE_ACTION_DENY,
> +	__IPE_ACTION_MAX
> +};
> +
> +#define IPE_ACTION_INVALID __IPE_ACTION_MAX
> +
> +enum ipe_prop_type {
> +	__IPE_PROP_MAX
> +};
> +
> +#define IPE_PROP_INVALID __IPE_PROP_MAX
> +
> +struct ipe_prop {
> +	struct list_head next;
> +	enum ipe_prop_type type;
> +	void *value;
> +};
> +
> +struct ipe_rule {
> +	enum ipe_op_type op;
> +	enum ipe_action_type action;
> +	struct list_head props;
> +	struct list_head next;
> +};
> +
> +struct ipe_op_table {
> +	struct list_head rules;
> +	enum ipe_action_type default_action;
> +};
> +
> +struct ipe_parsed_policy {
> +	const char *name;
> +	struct {
> +		u16 major;
> +		u16 minor;
> +		u16 rev;
> +	} version;
> +
> +	enum ipe_action_type global_default_action;
> +
> +	struct ipe_op_table rules[__IPE_OP_MAX];
> +};
> +
> +struct ipe_policy {
> +	const char *pkcs7;
> +	size_t pkcs7len;
> +
> +	const char *text;
> +	size_t textlen;
> +
> +	struct ipe_parsed_policy *parsed;
> +};
> +
> +struct ipe_policy *ipe_new_policy(const char *text, size_t textlen,
> +				  const char *pkcs7, size_t pkcs7len);
> +void ipe_free_policy(struct ipe_policy *pol);
> +
> +#endif /* _IPE_POLICY_H */
> diff --git a/security/ipe/policy_parser.c b/security/ipe/policy_parser.c
> new file mode 100644
> index 000000000000..612839b405f4
> --- /dev/null
> +++ b/security/ipe/policy_parser.c
> @@ -0,0 +1,487 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) Microsoft Corporation. All rights reserved.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/slab.h>
> +#include <linux/parser.h>
> +#include <linux/types.h>
> +#include <linux/ctype.h>
> +
> +#include "policy.h"
> +#include "policy_parser.h"
> +
> +#define START_COMMENT	'#'
> +#define IPE_POLICY_DELIM " \t"
> +#define IPE_LINE_DELIM "\n\r"
> +
> +/**
> + * new_parsed_policy - Allocate and initialize a parsed policy.
> + *
> + * Return:
> + * * !IS_ERR	- OK
> + * * -ENOMEM	- Out of memory
> + */
> +static struct ipe_parsed_policy *new_parsed_policy(void)
> +{
> +	size_t i =3D 0;
> +	struct ipe_parsed_policy *p =3D NULL;
> +	struct ipe_op_table *t =3D NULL;
> +
> +	p =3D kzalloc(sizeof(*p), GFP_KERNEL);
> +	if (!p)
> +		return ERR_PTR(-ENOMEM);
> +
> +	p->global_default_action =3D IPE_ACTION_INVALID;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(p->rules); ++i) {
> +		t =3D &p->rules[i];
> +
> +		t->default_action =3D IPE_ACTION_INVALID;
> +		INIT_LIST_HEAD(&t->rules);
> +	}
> +
> +	return p;
> +}
> +
> +/**
> + * remove_comment - Truncate all chars following START_COMMENT in a stri=
ng.
> + *
> + * @line: Supplies a policy line string for preprocessing.
> + */
> +static void remove_comment(char *line)
> +{
> +	line =3D strchr(line, START_COMMENT);
> +
> +	if (line)
> +		*line =3D '\0';
> +}
> +
> +/**
> + * remove_trailing_spaces - Truncate all trailing spaces in a string.
> + *
> + * @line: Supplies a policy line string for preprocessing.
> + *
> + * Return: The length of truncated string.
> + */
> +static size_t remove_trailing_spaces(char *line)
> +{
> +	size_t i =3D 0;
> +
> +	i =3D strlen(line);
> +	while (i > 0 && isspace(line[i - 1]))
> +		i--;
> +
> +	line[i] =3D '\0';
> +
> +	return i;
> +}
> +
> +/**
> + * parse_version - Parse policy version.
> + * @ver: Supplies a version string to be parsed.
> + * @p: Supplies the partial parsed policy.
> + *
> + * Return:
> + * * 0	- OK
> + * * !0	- Standard errno
> + */
> +static int parse_version(char *ver, struct ipe_parsed_policy *p)
> +{
> +	int rc =3D 0;
> +	size_t sep_count =3D 0;
> +	char *token;
> +	u16 *const cv[] =3D { &p->version.major, &p->version.minor, &p->version=
rev };
> +
> +	while ((token =3D strsep(&ver, ".")) !=3D NULL) {
> +		/* prevent overflow */
> +		if (sep_count >=3D ARRAY_SIZE(cv))
> +			return -EBADMSG;
> +
> +		rc =3D kstrtou16(token, 10, cv[sep_count]);
> +		if (rc)
> +			return rc;
> +
> +		++sep_count;
> +	}
> +
> +	/* prevent underflow */
> +	if (sep_count !=3D ARRAY_SIZE(cv))
> +		return -EBADMSG;
> +
> +	return 0;
> +}
> +
> +enum header_opt {
> +	IPE_HEADER_POLICY_NAME =3D 0,
> +	IPE_HEADER_POLICY_VERSION,
> +	__IPE_HEADER_MAX
> +};
> +
> +static const match_table_t header_tokens =3D {
> +	{IPE_HEADER_POLICY_NAME,	"policy_name=3D%s"},
> +	{IPE_HEADER_POLICY_VERSION,	"policy_version=3D%s"},
> +	{__IPE_HEADER_MAX,		NULL}
> +};
> +
> +/**
> + * parse_header - Parse policy header information.
> + * @line: Supplies header line to be parsed.
> + * @p: Supplies the partial parsed policy.
> + *
> + * Return:
> + * * 0	- OK
> + * * !0	- Standard errno
> + */
> +static int parse_header(char *line, struct ipe_parsed_policy *p)
> +{
> +	int rc =3D 0;
> +	char *t, *ver =3D NULL;
> +	substring_t args[MAX_OPT_ARGS];
> +	size_t idx =3D 0;
> +
> +	while ((t =3D strsep(&line, IPE_POLICY_DELIM)) !=3D NULL) {
> +		int token;
> +
> +		if (*t =3D=3D '\0')
> +			continue;
> +		if (idx >=3D __IPE_HEADER_MAX) {
> +			rc =3D -EBADMSG;
> +			goto out;
> +		}
> +
> +		token =3D match_token(t, header_tokens, args);
> +		if (token !=3D idx) {
> +			rc =3D -EBADMSG;
> +			goto out;
> +		}
> +
> +		switch (token) {
> +		case IPE_HEADER_POLICY_NAME:
> +			p->name =3D match_strdup(&args[0]);
> +			if (!p->name)
> +				rc =3D -ENOMEM;
> +			break;
> +		case IPE_HEADER_POLICY_VERSION:
> +			ver =3D match_strdup(&args[0]);
> +			if (!ver) {
> +				rc =3D -ENOMEM;
> +				break;
> +			}
> +			rc =3D parse_version(ver, p);
> +			break;
> +		default:
> +			rc =3D -EBADMSG;
> +		}
> +		if (rc)
> +			goto out;
> +		++idx;
> +	}
> +
> +	if (idx !=3D __IPE_HEADER_MAX)
> +		rc =3D -EBADMSG;
> +
> +out:
> +	kfree(ver);
> +	return rc;
> +}
> +
> +/**
> + * token_default - Determine if the given token is "DEFAULT".
> + * @token: Supplies the token string to be compared.
> + *
> + * Return:
> + * * 0	- The token is not "DEFAULT"
> + * * !0	- The token is "DEFAULT"
> + */
> +static bool token_default(char *token)
> +{
> +	return !strcmp(token, "DEFAULT");
> +}
> +
> +/**
> + * free_rule - Free the supplied ipe_rule struct.
> + * @r: Supplies the ipe_rule struct to be freed.
> + *
> + * Free a ipe_rule struct @r. Note @r must be removed from any lists bef=
ore
> + * calling this function.
> + */
> +static void free_rule(struct ipe_rule *r)
> +{
> +	struct ipe_prop *p, *t;
> +
> +	if (IS_ERR_OR_NULL(r))
> +		return;
> +
> +	list_for_each_entry_safe(p, t, &r->props, next) {
> +		list_del(&p->next);
> +		kfree(p);
> +	}
> +
> +	kfree(r);
> +}
> +
> +static const match_table_t operation_tokens =3D {
> +	{IPE_OP_EXEC,			"op=3DEXECUTE"},
> +	{IPE_OP_FIRMWARE,		"op=3DFIRMWARE"},
> +	{IPE_OP_KERNEL_MODULE,		"op=3DKMODULE"},
> +	{IPE_OP_KEXEC_IMAGE,		"op=3DKEXEC_IMAGE"},
> +	{IPE_OP_KEXEC_INITRAMFS,	"op=3DKEXEC_INITRAMFS"},
> +	{IPE_OP_POLICY,			"op=3DPOLICY"},
> +	{IPE_OP_X509,			"op=3DX509_CERT"},
> +	{IPE_OP_INVALID,		NULL}
> +};
> +
> +/**
> + * parse_operation - Parse the operation type given a token string.
> + * @t: Supplies the token string to be parsed.
> + *
> + * Return: The parsed operation type.
> + */
> +static enum ipe_op_type parse_operation(char *t)
> +{
> +	substring_t args[MAX_OPT_ARGS];
> +
> +	return match_token(t, operation_tokens, args);
> +}
> +
> +static const match_table_t action_tokens =3D {
> +	{IPE_ACTION_ALLOW,	"action=3DALLOW"},
> +	{IPE_ACTION_DENY,	"action=3DDENY"},
> +	{IPE_ACTION_INVALID,	NULL}
> +};
> +
> +/**
> + * parse_action - Parse the action type given a token string.
> + * @t: Supplies the token string to be parsed.
> + *
> + * Return: The parsed action type.
> + */
> +static enum ipe_action_type parse_action(char *t)
> +{
> +	substring_t args[MAX_OPT_ARGS];
> +
> +	return match_token(t, action_tokens, args);
> +}
> +
> +/**
> + * parse_property - Parse the property type given a token string.
> + * @t: Supplies the token string to be parsed.
> + * @r: Supplies the ipe_rule the parsed property will be associated with=
.
> + *
> + * Return:
> + * * !IS_ERR	- OK
> + * * -ENOMEM	- Out of memory
> + * * -EBADMSG	- The supplied token cannot be parsed
> + */
> +static int parse_property(char *t, struct ipe_rule *r)
> +{
> +	return -EBADMSG;
> +}
> +
> +/**
> + * parse_rule - parse a policy rule line.
> + * @line: Supplies rule line to be parsed.
> + * @p: Supplies the partial parsed policy.
> + *
> + * Return:
> + * * !IS_ERR	- OK
> + * * -ENOMEM	- Out of memory
> + * * -EBADMSG	- Policy syntax error
> + */
> +static int parse_rule(char *line, struct ipe_parsed_policy *p)
> +{
> +	int rc =3D 0;
> +	bool first_token =3D true, is_default_rule =3D false;
> +	bool op_parsed =3D false;
> +	enum ipe_op_type op =3D IPE_OP_INVALID;
> +	enum ipe_action_type action =3D IPE_ACTION_INVALID;
> +	struct ipe_rule *r =3D NULL;
> +	char *t;
> +
> +	r =3D kzalloc(sizeof(*r), GFP_KERNEL);
> +	if (!r)
> +		return -ENOMEM;
> +
> +	INIT_LIST_HEAD(&r->next);
> +	INIT_LIST_HEAD(&r->props);
> +
> +	while (t =3D strsep(&line, IPE_POLICY_DELIM), line) {
> +		if (*t =3D=3D '\0')
> +			continue;
> +		if (first_token && token_default(t)) {
> +			is_default_rule =3D true;
> +		} else {
> +			if (!op_parsed) {
> +				op =3D parse_operation(t);
> +				if (op =3D=3D IPE_OP_INVALID)
> +					rc =3D -EBADMSG;
> +				else
> +					op_parsed =3D true;
> +			} else {
> +				rc =3D parse_property(t, r);
> +			}
> +		}
> +
> +		if (rc)
> +			goto err;
> +		first_token =3D false;
> +	}
> +
> +	action =3D parse_action(t);
> +	if (action =3D=3D IPE_ACTION_INVALID) {
> +		rc =3D -EBADMSG;
> +		goto err;
> +	}
> +
> +	if (is_default_rule) {
> +		if (!list_empty(&r->props)) {
> +			rc =3D -EBADMSG;
> +		} else if (op =3D=3D IPE_OP_INVALID) {
> +			if (p->global_default_action !=3D IPE_ACTION_INVALID)
> +				rc =3D -EBADMSG;
> +			else
> +				p->global_default_action =3D action;
> +		} else {
> +			if (p->rules[op].default_action !=3D IPE_ACTION_INVALID)
> +				rc =3D -EBADMSG;
> +			else
> +				p->rules[op].default_action =3D action;
> +		}
> +	} else if (op !=3D IPE_OP_INVALID && action !=3D IPE_ACTION_INVALID) {
> +		r->op =3D op;
> +		r->action =3D action;
> +	} else {
> +		rc =3D -EBADMSG;
> +	}
> +
> +	if (rc)
> +		goto err;
> +	if (!is_default_rule)
> +		list_add_tail(&r->next, &p->rules[op].rules);
> +	else
> +		free_rule(r);
> +
> +	return rc;
> +err:
> +	free_rule(r);
> +	return rc;
> +}
> +
> +/**
> + * free_parsed_policy - free a parsed policy structure.
> + * @p: Supplies the parsed policy.
> + */
> +void free_parsed_policy(struct ipe_parsed_policy *p)
> +{
> +	size_t i =3D 0;
> +	struct ipe_rule *pp, *t;
> +
> +	if (IS_ERR_OR_NULL(p))
> +		return;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(p->rules); ++i)
> +		list_for_each_entry_safe(pp, t, &p->rules[i].rules, next) {
> +			list_del(&pp->next);
> +			free_rule(pp);
> +		}
> +
> +	kfree(p->name);
> +	kfree(p);
> +}
> +
> +/**
> + * validate_policy - validate a parsed policy.
> + * @p: Supplies the fully parsed policy.
> + *
> + * Given a policy structure that was just parsed, validate that all
> + * necessary fields are present, initialized correctly.
> + *
> + * A parsed policy can be in an invalid state for use (a default was
> + * undefined) by just parsing the policy.
> + *
> + * Return:
> + * * 0		- OK
> + * * -EBADMSG	- Policy is invalid
> + */
> +static int validate_policy(const struct ipe_parsed_policy *p)
> +{
> +	size_t i =3D 0;
> +
> +	if (p->global_default_action !=3D IPE_ACTION_INVALID)
> +		return 0;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(p->rules); ++i) {
> +		if (p->rules[i].default_action =3D=3D IPE_ACTION_INVALID)
> +			return -EBADMSG;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * parse_policy - Given a string, parse the string into an IPE policy.
> + * @p: partially filled ipe_policy structure to populate with the result=
.
> + *     it must have text and textlen set.
> + *
> + * Return:
> + * * 0		- OK
> + * * -EBADMSG	- Policy is invalid
> + * * -ENOMEM	- Out of Memory
> + */
> +int parse_policy(struct ipe_policy *p)
> +{
> +	int rc =3D 0;
> +	size_t len;
> +	char *policy =3D NULL, *dup =3D NULL;
> +	char *line =3D NULL;
> +	bool header_parsed =3D false;
> +	struct ipe_parsed_policy *pp =3D NULL;
> +
> +	if (!p->textlen)
> +		return -EBADMSG;
> +
> +	policy =3D kmemdup_nul(p->text, p->textlen, GFP_KERNEL);
> +	if (!policy)
> +		return -ENOMEM;
> +	dup =3D policy;
> +
> +	pp =3D new_parsed_policy();
> +	if (IS_ERR(pp)) {
> +		rc =3D PTR_ERR(pp);
> +		goto out;
> +	}
> +
> +	while ((line =3D strsep(&policy, IPE_LINE_DELIM)) !=3D NULL) {
> +		remove_comment(line);
> +		len =3D remove_trailing_spaces(line);
> +		if (!len)
> +			continue;
> +
> +		if (!header_parsed) {
> +			rc =3D parse_header(line, pp);
> +			if (rc)
> +				goto err;
> +			header_parsed =3D true;
> +		} else {
> +			rc =3D parse_rule(line, pp);
> +			if (rc)
> +				goto err;
> +		}
> +	}
> +
> +	if (!header_parsed || validate_policy(pp)) {
> +		rc =3D -EBADMSG;
> +		goto err;
> +	}
> +
> +	p->parsed =3D pp;
> +
> +out:
> +	kfree(dup);
> +	return rc;
> +err:
> +	free_parsed_policy(pp);
> +	goto out;
> +}
> diff --git a/security/ipe/policy_parser.h b/security/ipe/policy_parser.h
> new file mode 100644
> index 000000000000..2b744103d06a
> --- /dev/null
> +++ b/security/ipe/policy_parser.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) Microsoft Corporation. All rights reserved.

The year is missing.

> + */
> +#ifndef _IPE_POLICY_PARSER_H
> +#define _IPE_POLICY_PARSER_H
> +
> +int parse_policy(struct ipe_policy *p);
> +void free_parsed_policy(struct ipe_parsed_policy *p);
> +
> +#endif /* _IPE_POLICY_PARSER_H */

BR, Jarkko

