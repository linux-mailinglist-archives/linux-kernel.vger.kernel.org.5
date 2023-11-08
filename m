Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2617E4F3A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 03:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343896AbjKHC63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 21:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235032AbjKHC61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 21:58:27 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA5910FE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 18:58:25 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-7788f513872so413282785a.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 18:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699412304; x=1700017104; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nzWNvEllLOWjoieBIl2eE6QMomxBf/8hz+/afBXKkOM=;
        b=BkG4zlNOe3dcnPJl63CCIj8LfPp3BOObHbuKDqblU1ZkP8hUf0HZ1/MtZ7wz16iwD3
         BQKZNtBj7B+tTyarMlj+XXP4gtx1vfya1ulFtbvbk7NfyJ4B+tncXfLj1lvaSgJRt+3P
         tMpu9wMww9kzk9mBb1DKFqRuDWSpMdUbAAJry1k1i08FbuyvpsVw9PbXNex4qOfFMbuK
         uNypEmpVrerySWiaqj1E2HssadRmlpcfZ2Z1M10gdxpZMQvinPckqW4UdVy0Kvbb9HTi
         qvVsHTX0wQQj7iAkZNi5Do7gBd5uo1aNglnXokLS/jyHuKDpRTF720VIuE0Z+W0cdPJH
         Iy5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699412304; x=1700017104;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nzWNvEllLOWjoieBIl2eE6QMomxBf/8hz+/afBXKkOM=;
        b=f4/UZu6KhGaUrifF8d8Xj1qZ9SUu2ru5FzVZ+NIexMWnNc7msX6ctEAUuLL5rKgjk7
         PTGjXVVmJqSCd1080t+wY7C+vmvtP24hNZJbHxblKsyJVDki4JmmlX+Qj8ZG0jXqvkSD
         VyB+7Q6c2CtZQ9T3me2VgQVAFyYKQolR9f5mPxsNDssSIAShzLLLX2quXUQ9crQvCoo0
         9ZcJ8vLMsQqvd8Dpl8AdGvX9RZr9D5Cmsa9GxAxzFAYu+mdjrQTZD5r8EwIN7iQs1suk
         bgF81d0ImmMyua5FLDxCTDvQ71HOYevjMwI9ZQ7wvxwvdui/FZdAarCg+0/b1WMgXv5a
         DCdQ==
X-Gm-Message-State: AOJu0YzfQHoD2MpdP9dYDgSgiK0ErvT9P4Se6Mb9dEN7pLjM/r8WaOib
        tK9pSknvQNxwLMwXDMEOGeVQ
X-Google-Smtp-Source: AGHT+IEKdmc2nsSq+Is+TUp8xhak7RVs7LNnJraNn4pxrM3/s0fMxmipRfQfJN5klC8msfrNiHUbNw==
X-Received: by 2002:a05:620a:4591:b0:773:a9f7:eaf1 with SMTP id bp17-20020a05620a459100b00773a9f7eaf1mr528210qkb.21.1699412304264;
        Tue, 07 Nov 2023 18:58:24 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id r12-20020a05620a298c00b0077407e3d68asm559832qkp.111.2023.11.07.18.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 18:58:23 -0800 (PST)
Date:   Tue, 07 Nov 2023 21:58:23 -0500
Message-ID: <b25f34cd259322582cd1b927a9e50235.paul@paul-moore.com>
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
Subject: Re: [PATCH v4 5/6] add listmount(2) syscall
References: <20231025140205.3586473-6-mszeredi@redhat.com>
In-Reply-To: <20231025140205.3586473-6-mszeredi@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 25, 2023 Miklos Szeredi <mszeredi@redhat.com> wrote:
> 
> Add way to query the children of a particular mount.  This is a more
> flexible way to iterate the mount tree than having to parse the complete
> /proc/self/mountinfo.
> 
> Allow listing either
> 
>  - immediate child mounts only, or
> 
>  - recursively all descendant mounts (depth first).
> 
> Lookup the mount by the new 64bit mount ID.  If a mount needs to be queried
> based on path, then statx(2) can be used to first query the mount ID
> belonging to the path.
> 
> Return an array of new (64bit) mount ID's.  Without privileges only mounts
> are listed which are reachable from the task's root.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> Reviewed-by: Ian Kent <raven@themaw.net>
> ---
>  fs/namespace.c             | 93 ++++++++++++++++++++++++++++++++++++++
>  include/linux/syscalls.h   |  3 ++
>  include/uapi/linux/mount.h |  9 ++++
>  3 files changed, 105 insertions(+)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index a980c250a3a6..0afe2344bba6 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -4958,6 +4958,99 @@ SYSCALL_DEFINE4(statmount, const struct __mount_arg __user *, req,
>  	return ret;
>  }
>  
> +static struct mount *listmnt_first(struct mount *root)
> +{
> +	return list_first_entry_or_null(&root->mnt_mounts, struct mount, mnt_child);
> +}
> +
> +static struct mount *listmnt_next(struct mount *curr, struct mount *root, bool recurse)
> +{
> +	if (recurse)
> +		return next_mnt(curr, root);
> +	if (!list_is_head(curr->mnt_child.next, &root->mnt_mounts))
> +		return list_next_entry(curr, mnt_child);
> +	return NULL;
> +}
> +
> +static long do_listmount(struct vfsmount *mnt, u64 __user *buf, size_t bufsize,
> +			 const struct path *root, unsigned int flags)
> +{
> +	struct mount *r, *m = real_mount(mnt);
> +	struct path rootmnt = {
> +		.mnt = root->mnt,
> +		.dentry = root->mnt->mnt_root
> +	};
> +	long ctr = 0;
> +	bool reachable_only = true;
> +	bool recurse = flags & LISTMOUNT_RECURSIVE;
> +	int err;
> +
> +	err = security_sb_statfs(mnt->mnt_root);
> +	if (err)
> +		return err;
> +
> +	if (flags & LISTMOUNT_UNREACHABLE) {
> +		if (!capable(CAP_SYS_ADMIN))
> +			return -EPERM;
> +		reachable_only = false;
> +	}

Similar to my comment in patch 4/6, please move the LSM call after the
capability check.

> +	if (reachable_only && !is_path_reachable(m, mnt->mnt_root, &rootmnt))
> +		return capable(CAP_SYS_ADMIN) ? 0 : -EPERM;
> +
> +	for (r = listmnt_first(m); r; r = listmnt_next(r, m, recurse)) {
> +		if (reachable_only &&
> +		    !is_path_reachable(r, r->mnt.mnt_root, root))
> +			continue;
> +
> +		if (ctr >= bufsize)
> +			return -EOVERFLOW;
> +		if (put_user(r->mnt_id_unique, buf + ctr))
> +			return -EFAULT;
> +		ctr++;
> +		if (ctr < 0)
> +			return -ERANGE;
> +	}
> +	return ctr;
> +}

--
paul-moore.com
