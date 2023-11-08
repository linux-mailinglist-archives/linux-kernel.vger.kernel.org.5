Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B3E7E4F37
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 03:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbjKHC61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 21:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbjKHC60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 21:58:26 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B1210EC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 18:58:24 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-66fbcaf03c6so41940986d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 18:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699412303; x=1700017103; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WmDd3a7XDaEOynqO0NdlMTkWs1KZhBdEsZhUk0mMIQE=;
        b=gozgtdngxtn+MbVy0gkYYAOmxHWu3c0oKNXdvpW09Ur/8p8kE0cwBMEsKuVPNO63Ue
         kW6kvff5n0seipXtUAATcm+Ep8LystjwIutFo9K4nflNDBOfFmxR+m7WFEXju/vudOuG
         LclB2+GgiOG7hmAQwSSYIa9RrHHavVvNg7Bi0/KGm2leSM5s5wIhy0MjHNdjOB2g98K3
         P5pToxapDKjKUoQ2bXGVHNPyjNEBAdc7IsgBeKnPUlHYel2gL5Ce25LHzg6sNb55GxTF
         IBT0Eb6ERUe7BUzqG9GRlyrym6Svffv8Ag3mjvGP7nplq9QS8wXuXokWYiyiHILm9HAp
         kQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699412303; x=1700017103;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WmDd3a7XDaEOynqO0NdlMTkWs1KZhBdEsZhUk0mMIQE=;
        b=i/1WJoabejURqujmlX+qxL1hKVGeCdNXtUhESZrYGJ5m6U+oTkwRNPy48EaAeysHKr
         qhJ3q9OvbH7Ct/SQvZheEPFBlsDXtnCRI5AmmR82y1iUbG/B4NLmIOFpTxBYHqXpyza9
         5f1nVg9taAI6NDu24jh+OkgAbg03DabbkGsqSMrKm3SUnnCETTnidXwFyk77irfxzJa1
         lUL5FkcJK/ZXzyvlPbfu2PW5pg7EQT3xlsCXuQFA1N0NWlyqbMgf8tMGHSMR5z0byEuh
         QgYX/5R9Dq+G53iClnOQGfSssEveD8NQUywaWJxml4AvanhOQJjxgY0s7YS/gGw/ExiS
         ByhA==
X-Gm-Message-State: AOJu0YxcI1Ty0rZPbICdvsye6fNObtdlx5mxVKBlzxVy7/vj4SQKX8yi
        eyNcugspbqhgewEfqsOfXOR2
X-Google-Smtp-Source: AGHT+IEn+yudFEwDIL+DtxHIKeAQ7qYkzHdoISAe2kEAYnAEgQ/fq5NVbk9MaBpXm92ECYZTvdhL1g==
X-Received: by 2002:ad4:5969:0:b0:672:ab2:d9ec with SMTP id eq9-20020ad45969000000b006720ab2d9ecmr693217qvb.28.1699412303363;
        Tue, 07 Nov 2023 18:58:23 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id mh21-20020a056214565500b00641899958efsm579705qvb.130.2023.11.07.18.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 18:58:22 -0800 (PST)
Date:   Tue, 07 Nov 2023 21:58:22 -0500
Message-ID: <4ab327f80c4f98dffa5736a1acba3e0d.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-man@vger.kernel.org, linux-security-module@vger.kernel.org,
        Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew House <mattlloydhouse@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 4/6] add statmount(2) syscall
References: <20231025140205.3586473-5-mszeredi@redhat.com>
In-Reply-To: <20231025140205.3586473-5-mszeredi@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 25, 2023 Miklos Szeredi <mszeredi@redhat.com> wrote:
> 
> Add a way to query attributes of a single mount instead of having to parse
> the complete /proc/$PID/mountinfo, which might be huge.
> 
> Lookup the mount the new 64bit mount ID.  If a mount needs to be queried
> based on path, then statx(2) can be used to first query the mount ID
> belonging to the path.
> 
> Design is based on a suggestion by Linus:
> 
>   "So I'd suggest something that is very much like "statfsat()", which gets
>    a buffer and a length, and returns an extended "struct statfs" *AND*
>    just a string description at the end."
> 
> The interface closely mimics that of statx.
> 
> Handle ASCII attributes by appending after the end of the structure (as per
> above suggestion).  Pointers to strings are stored in u64 members to make
> the structure the same regardless of pointer size.  Strings are nul
> terminated.
> 
> Link: https://lore.kernel.org/all/CAHk-=wh5YifP7hzKSbwJj94+DZ2czjrZsczy6GBimiogZws=rg@mail.gmail.com/
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> Reviewed-by: Ian Kent <raven@themaw.net>
> ---
>  fs/namespace.c             | 277 +++++++++++++++++++++++++++++++++++++
>  include/linux/syscalls.h   |   5 +
>  include/uapi/linux/mount.h |  56 ++++++++
>  3 files changed, 338 insertions(+)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 7a33ea391a02..a980c250a3a6 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c

...

> +static int do_statmount(struct stmt_state *s)
> +{
> +	struct statmnt *sm = &s->sm;
> +	struct mount *m = real_mount(s->mnt);
> +	size_t copysize = min_t(size_t, s->bufsize, sizeof(*sm));
> +	int err;
> +
> +	err = security_sb_statfs(s->mnt->mnt_root);
> +	if (err)
> +		return err;
> +
> +	if (!capable(CAP_SYS_ADMIN) &&
> +	    !is_path_reachable(m, m->mnt.mnt_root, &s->root))
> +		return -EPERM;

In order to be consistent with our typical access control ordering,
please move the security_sb_statfs() call down to here, after the
capability checks.

> +	stmt_numeric(s, STMT_SB_BASIC, stmt_sb_basic);
> +	stmt_numeric(s, STMT_MNT_BASIC, stmt_mnt_basic);
> +	stmt_numeric(s, STMT_PROPAGATE_FROM, stmt_propagate_from);
> +	stmt_string(s, STMT_FS_TYPE, stmt_fs_type, &sm->fs_type);
> +	stmt_string(s, STMT_MNT_ROOT, stmt_mnt_root, &sm->mnt_root);
> +	stmt_string(s, STMT_MNT_POINT, stmt_mnt_point, &sm->mnt_point);
> +
> +	if (s->err)
> +		return s->err;
> +
> +	/* Return the number of bytes copied to the buffer */
> +	sm->size = copysize + s->pos;
> +
> +	if (copy_to_user(s->buf, sm, copysize))
> +		return -EFAULT;
> +
> +	return 0;
> +}

--
paul-moore.com
