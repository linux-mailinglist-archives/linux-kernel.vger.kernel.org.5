Return-Path: <linux-kernel+bounces-7446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F0481A802
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E89D285BF2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 21:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE2748CEA;
	Wed, 20 Dec 2023 21:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XzKlIcom"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E89495C1
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 21:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6da69dd6e9fso56559a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 13:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703107346; x=1703712146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3VHqz+1uAHbjTXZDnnnEds/IZqX4fT/13PsTUYV409Y=;
        b=XzKlIcomAhMbjsO7H2os6izXPj6otkabBrYe8+0JsGKn6rb1SlxtqwO6C5Vh0V9vqF
         6hruB5V4YEsAxd7amUn1ffvMw3/0ECd/nGk7lROfGscXF+TNFftHYxIdto6/XXwAju/q
         Smcw0/C87lCmPrU8huQ0OMq+1JTluL+sQdp/w1BmL1Ew/IDCbsfl0kCYR6D62fcMwLU6
         Z3BN60kv3cNLbqNysREfSzaCaM27zmJG+WS/t7SXe+b7ObSFyeQKDpNA1hPVEG+OU005
         4oGI/UG+YZTUQOBZrwY4rAIj+8VCvRrnUZj2EO4XnZZatP4wfmZM/aawZMktecsFqAax
         kvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703107346; x=1703712146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3VHqz+1uAHbjTXZDnnnEds/IZqX4fT/13PsTUYV409Y=;
        b=iv89wa1kfXNO3ZKZGbu6X3op2mRhBgxyGiZqxFBGSClhw0vlSVt/DUNfXo1e+kFLMS
         42bi+zjqFRm6dVKIi0gCR/2j/rPz0nUA64s5Pv8lJB2UVO+GeoIi2Fl0nAClbmbykEq8
         nwUwWsJNNPRIFyxYXBnG38T7DpwtIFb4pNpkXFrSU6SCChsejf653Wpjb4AvK9mlSqS0
         ESHr+gkJ1GBZw538xMPqbefth0R5m+UIMVOjR/wYRx53HXTbupcADe3w+TXPx+clA4X8
         Yl3ydNMU9avcXFQ7M4g/I5uqMRwp/BaKIgl6z82F2WS15dm8MWT1v3ML/qK8Mwl860gr
         WSqA==
X-Gm-Message-State: AOJu0YydPCZXoRvZ6v9P4vwKEza0Ik63gkhV0Ov9cBn4FOiOKSox+OYv
	IdH/ApwSWPZdQevxl+WCB6FvSAIhKdQSMOhwM65VT3pbBO/Of84=
X-Google-Smtp-Source: AGHT+IHif2WSEyYJf7fzuoYeNkXdqZ6Q6XFj1yFiR04bJHlsEcW/zVvklaHHRu1wFpHlKglOerBOLqND8quLjJRcCGc=
X-Received: by 2002:a9d:5a12:0:b0:6da:531d:9af2 with SMTP id
 v18-20020a9d5a12000000b006da531d9af2mr6178255oth.10.1703107346574; Wed, 20
 Dec 2023 13:22:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230921061641.273654-1-mic@digikod.net> <20230921061641.273654-4-mic@digikod.net>
In-Reply-To: <20230921061641.273654-4-mic@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 20 Dec 2023 16:22:15 -0500
Message-ID: <CAHC9VhQTvFp+i=j7t+55EnG44xg=Pmvkh=Oq=e7ddJWDZXLeSA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 3/7] landlock: Log ruleset creation and release
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Ben Scarlato <akhna@google.com>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@google.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Shervin Oloumi <enlightened@google.com>, 
	audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2023 at 2:17=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> Add audit support for ruleset/domain creation and release. Ruleset and
> domain IDs are generated from the same 64-bit counter to avoid confusing
> them. There is no need to hide the sequentiality to users that are
> already allowed to read logs.  In the future, if these IDs were to be
> viewable by unprivileged users, then we'll need to scramble them.
>
> Add a new AUDIT_LANDLOCK record type.

When adding new audit records we generally ask people to include
examples taken from their testing to the commit description.

> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> ---
>  include/uapi/linux/audit.h   |   1 +
>  security/landlock/Makefile   |   2 +
>  security/landlock/audit.c    | 119 +++++++++++++++++++++++++++++++++++
>  security/landlock/audit.h    |  35 +++++++++++
>  security/landlock/ruleset.c  |   6 ++
>  security/landlock/ruleset.h  |  10 +++
>  security/landlock/syscalls.c |   8 +++
>  7 files changed, 181 insertions(+)
>  create mode 100644 security/landlock/audit.c
>  create mode 100644 security/landlock/audit.h

...

> diff --git a/security/landlock/audit.c b/security/landlock/audit.c
> new file mode 100644
> index 000000000000..f58bd529784a
> --- /dev/null
> +++ b/security/landlock/audit.c
> @@ -0,0 +1,119 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Landlock LSM - Audit helpers
> + *
> + * Copyright =C2=A9 2023 Microsoft Corporation
> + */
> +
> +#include <linux/atomic.h>
> +#include <linux/audit.h>
> +#include <linux/lsm_audit.h>
> +
> +#include "audit.h"
> +#include "cred.h"
> +
> +atomic64_t ruleset_and_domain_counter =3D ATOMIC64_INIT(0);
> +
> +#define BIT_INDEX(bit) HWEIGHT(bit - 1)
> +
> +static void log_accesses(struct audit_buffer *const ab,
> +                        const access_mask_t accesses)
> +{
> +       const char *const desc[] =3D {
> +               [BIT_INDEX(LANDLOCK_ACCESS_FS_EXECUTE)] =3D "execute",
> +               [BIT_INDEX(LANDLOCK_ACCESS_FS_WRITE_FILE)] =3D "write_fil=
e",
> +               [BIT_INDEX(LANDLOCK_ACCESS_FS_READ_FILE)] =3D "read_file"=
,
> +               [BIT_INDEX(LANDLOCK_ACCESS_FS_READ_DIR)] =3D "read_dir",
> +               [BIT_INDEX(LANDLOCK_ACCESS_FS_REMOVE_DIR)] =3D "remove_di=
r",
> +               [BIT_INDEX(LANDLOCK_ACCESS_FS_REMOVE_FILE)] =3D "remove_f=
ile",
> +               [BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_CHAR)] =3D "make_char"=
,
> +               [BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_DIR)] =3D "make_dir",
> +               [BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_REG)] =3D "make_reg",
> +               [BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_SOCK)] =3D "make_sock"=
,
> +               [BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_FIFO)] =3D "make_fifo"=
,
> +               [BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_BLOCK)] =3D "make_bloc=
k",
> +               [BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_SYM)] =3D "make_sym",
> +               [BIT_INDEX(LANDLOCK_ACCESS_FS_REFER)] =3D "refer",
> +               [BIT_INDEX(LANDLOCK_ACCESS_FS_TRUNCATE)] =3D "truncate",
> +       };
> +       const unsigned long access_mask =3D accesses;
> +       unsigned long access_bit;
> +       bool is_first =3D true;
> +
> +       BUILD_BUG_ON(ARRAY_SIZE(desc) !=3D LANDLOCK_NUM_ACCESS_FS);
> +
> +       for_each_set_bit(access_bit, &access_mask, ARRAY_SIZE(desc)) {
> +               audit_log_format(ab, "%s%s", is_first ? "" : ",",
> +                                desc[access_bit]);
> +               is_first =3D false;
> +       }
> +}
> +
> +/* Inspired by dump_common_audit_data(). */
> +static void log_task(struct audit_buffer *const ab)
> +{
> +       /* 16 bytes (TASK_COMM_LEN) */
> +       char comm[sizeof(current->comm)];
> +
> +       /*
> +        * Uses task_pid_nr() instead of task_tgid_nr() because of how
> +        * credentials and Landlock work.
> +        */
> +       audit_log_format(ab, "tid=3D%d comm=3D", task_pid_nr(current));
> +       audit_log_untrustedstring(ab,
> +                                 memcpy(comm, current->comm, sizeof(comm=
)));
> +}

Depending on how log_task() is used, it may be redundant with respect
to the existing SYSCALL record.  Yes, there is already redundancy with
the AVC record, but that is a legacy problem and not something we can
easily fix, but given that the Landlock records are new we have an
opportunity to do things properly :)

> +void landlock_log_create_ruleset(struct landlock_ruleset *const ruleset)
> +{
> +       struct audit_buffer *ab;
> +
> +       WARN_ON_ONCE(ruleset->id);
> +
> +       ab =3D audit_log_start(audit_context(), GFP_ATOMIC, AUDIT_LANDLOC=
K);
> +       if (!ab)
> +               /* audit_log_lost() call */
> +               return;
> +
> +       ruleset->id =3D atomic64_inc_return(&ruleset_and_domain_counter);
> +       log_task(ab);
> +       audit_log_format(ab,
> +                        " op=3Dcreate-ruleset ruleset=3D%llu handled_acc=
ess_fs=3D",
> +                        ruleset->id);

"handled_access_fs" seems a bit long for a field name, is there any
reason why it couldn't simply be "access_fs" or something similar?

> +       log_accesses(ab, ruleset->fs_access_masks[ruleset->num_layers - 1=
]);
> +       audit_log_end(ab);
> +}
> +
> +/*
> + * This is useful to know when a domain or a ruleset will never show aga=
in in
> + * the audit log.
> + */
> +void landlock_log_release_ruleset(const struct landlock_ruleset *const r=
uleset)
> +{
> +       struct audit_buffer *ab;
> +       const char *name;
> +       u64 id;
> +
> +       ab =3D audit_log_start(audit_context(), GFP_ATOMIC, AUDIT_LANDLOC=
K);
> +       if (!ab)
> +               /* audit_log_lost() call */
> +               return;
> +
> +       /* It should either be a domain or a ruleset. */
> +       if (ruleset->hierarchy) {
> +               name =3D "domain";

Perhaps I missed it, but I didn't see an audit record with
"op=3Dcreate-domain", is there one?  If there is no audit record for
creating a Landlock domain, why do we care about releasing a Landlock
domain?

[NOTE: I see that domain creation is audited in patch 4, I would
suggest reworking the patchset so the ruleset auditing is in one
patch, domain auditing another ... or just squash the two patches.
Either approach would be preferable to this approach.]

> +               id =3D ruleset->hierarchy->id;
> +               WARN_ON_ONCE(ruleset->id);
> +       } else {
> +               name =3D "ruleset";
> +               id =3D ruleset->id;
> +       }
> +       WARN_ON_ONCE(!id);
> +
> +       /*
> +        * Because this might be called by kernel threads, logging
> +        * related task information with log_task() would be useless.
> +        */
> +       audit_log_format(ab, "op=3Drelease-%s %s=3D%llu", name, name, id)=
;

This starts to get a little tricky.  The general guidance is that for
a given audit record type, e.g. AUDIT_LANDLOCK, there should be no
change in presence or ordering of fields, yet in
landlock_log_create_ruleset() we log the permission information and
here in landlock_log_release_ruleset() we do not.  The easy fix is to
record the permission information here as well, or simply use a
"handled_access_fs=3D?" placeholder.  Something to keep in mind as you
move forward.

> +       audit_log_end(ab);
> +}

--
paul-moore.com

