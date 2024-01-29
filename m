Return-Path: <linux-kernel+bounces-43148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CA2840C68
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36E01285182
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1330B157054;
	Mon, 29 Jan 2024 16:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="JdFo6k4n"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAD115704B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 16:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706547173; cv=none; b=Z0bBDqvs1ho4XOt4CfMnSc+wWRDImEwYI5izTj53zaoE9A+CqP7NB/7dx0qwuwP8fWMmtKFLi7YMHyd5RSDk0ZtE34o2HVx4+uBNAstN6RjMshg3zikXIYmqSgq76vNXON+ofq689RQvHQ/KSnKSWx6+GFOQbodB49izxVKpjEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706547173; c=relaxed/simple;
	bh=tNx0bVBnJxItBJ/LbcaY2I3try0BCc3gyB6Ux2dJpxQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oxyukT2VK29UlC6rbK9Bvflx0NiwALRyT8fTYAtFVglV4Uwyk1XERumqG5zsuQ0ZiW9RZjsJQ5OQSasJSE/RhjZ4pE55yV1CB6iRkO/EP7tTIHGkdvRn55ZTC1ekFrvAMYVtMcU7eVX1dwm3TbJZDVrrI0Uxhw7vJvlIkGbc5bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=JdFo6k4n; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5EDC83FD96
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 16:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1706547168;
	bh=Hj89ZZQX3ZdKnHTpVh+K+VIK2Y4dhKlLE4jhHB2GPL4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type;
	b=JdFo6k4n8tZ0sTdDNfpcXWy0e5jAefUTTPY5L3e3LQo2XHZ5hBj+ne3NdhSccNFTN
	 UkrwTDbJvLOgAPS4cyAgJupqmHkCbSHCZFPUW/Z3IYJTK1TJJNv+eje/N/fK9NwasX
	 E6WBmgonYZSrM93mXasBAk3NwVW9RlnVBxHWxzg03DxIkkJ5x7olzORwC471ZlaCs9
	 cEYnP/gZocuTN5a1NwmVPQGkIAy/TSfUIumtsc2qRoLcsPUIcFqcZsrxA2jGPI6fsw
	 mCwl9awWXxrOOgcOERKwfuMnESxeAatTAHHQmsKDJ5dS131Ivr5F1PiAWeKzvhOMfn
	 VEGepWPfv7tYw==
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-55f07d8f61fso545162a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 08:52:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706547167; x=1707151967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hj89ZZQX3ZdKnHTpVh+K+VIK2Y4dhKlLE4jhHB2GPL4=;
        b=JnTCrL8LG3LMsULuN5s/6YNxXi4nN7NlovnJlQCMWURFKBGkYeVblzl/ffI54QZ4oY
         BDbuqWJ/ZHGxjaW1mCVlxyN15byOv8o1vl/TESkDr1wf5aidEUfr/KGzOwpNjGnSu++m
         Tr3212kLhuhYuyr88ZLy41csx4nDgheBbJBZ9NHXH/V6lGwy16JhWQ84ENnkgQBOrBEF
         6A8AHcI0brij6jlKz5097H7WuRRq32mBuukbPhvD2FvrLXKvlc0Oa5TSA66bxF9szpgg
         9t/0Cm+LiapnSNScLyQhuv9pEkYCNsh6AgLcSD1u+EfmNQl+2IS+JmT/LLEWVUGZSwIp
         VOKQ==
X-Gm-Message-State: AOJu0Yz6MC6PnED2k58Co6R+3rxkd3ES5nl3vuHhyu+Fytjf9j4pWEQd
	ULWw7fvv62PShxsz45zkt5G0UiOdYQi2saxUDkz2W1bjSk5liqXy9+V4oy7cObLD7jmuWnO5GX6
	UgBhCLZZGPxJUEwxYQH6+HFlbeNuot9rG3bJhRaRJSodr84ZeApQ2RSVPz7sYUsWjbnj5tv9y3T
	QN1Uje7Yq52Q==
X-Received: by 2002:a05:6402:1cbc:b0:55e:f33c:8744 with SMTP id cz28-20020a0564021cbc00b0055ef33c8744mr1941926edb.41.1706547167745;
        Mon, 29 Jan 2024 08:52:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEhGqbgBtNxq0ql9XKUHbIEMA/ryS6jF4kGkClbNBu/BtwxqVXa/rdoK8fOlMR41AVoUgGeA==
X-Received: by 2002:a05:6402:1cbc:b0:55e:f33c:8744 with SMTP id cz28-20020a0564021cbc00b0055ef33c8744mr1941911edb.41.1706547167438;
        Mon, 29 Jan 2024 08:52:47 -0800 (PST)
Received: from amikhalitsyn (ip5b404829.dynamic.kabel-deutschland.de. [91.64.72.41])
        by smtp.gmail.com with ESMTPSA id f19-20020a056402195300b0055e96290001sm3020260edz.27.2024.01.29.08.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 08:52:47 -0800 (PST)
Date: Mon, 29 Jan 2024 17:52:46 +0100
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: Christian Brauner <brauner@kernel.org>
Cc: mszeredi@redhat.com, stgraber@stgraber.org,
 linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, Miklos
 Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, Bernd
 Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/9] fuse: basic support for idmapped mounts
Message-Id: <20240129175246.d329155abb7c299f58783d7f@canonical.com>
In-Reply-To: <20240121-pfeffer-erkranken-f32c63956aac@brauner>
References: <20240108120824.122178-1-aleksandr.mikhalitsyn@canonical.com>
	<20240121-pfeffer-erkranken-f32c63956aac@brauner>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 21 Jan 2024 18:50:57 +0100
Christian Brauner <brauner@kernel.org> wrote:

> On Mon, Jan 08, 2024 at 01:08:15PM +0100, Alexander Mikhalitsyn wrote:
> > Dear friends,
> > 
> > This patch series aimed to provide support for idmapped mounts
> > for fuse. We already have idmapped mounts support for almost all
> > widely-used filesystems:
> > * local (ext4, btrfs, xfs, fat, vfat, ntfs3, squashfs, f2fs, erofs, ZFS (out-of-tree))
> > * network (ceph)
> > 
> > Git tree (based on https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git/log/?h=for-next):
> > v1: https://github.com/mihalicyn/linux/commits/fuse_idmapped_mounts.v1
> > current: https://github.com/mihalicyn/linux/commits/fuse_idmapped_mounts
> 
> Great work!
> 
> > Things to discuss:
> > - we enable idmapped mounts support only if "default_permissions" mode is enabled,
> > because otherwise, we would need to deal with UID/GID mappings on the userspace side OR
> > provide the userspace with idmapped req->in.h.uid/req->in.h.gid values which is not
> > something that we probably want to do. Idmapped mounts philosophy is not about faking
> > caller uid/gid.
> 
> Having VFS idmaps but then outsourcing permission checking to userspace
> is conceptually strange so requiring default_permissions is the correct
> thing to do. 
> 
> > - We have a small offlist discussion with Christian about adding fs_type->allow_idmap
> > hook. Christian pointed out that it would be nice to have a superblock flag instead like
> > SB_I_NOIDMAP and we can set this flag during mount time if we see that the filesystem does not
> > support idmappings. But, unfortunately, I didn't succeed here because the kernel will
> > know if the filesystem supports idmapping or not after FUSE_INIT request, but FUSE_INIT request
> > is being sent at the end of the mounting process, so the mount and superblock will exist and
> > visible by the userspace in that time. It seems like setting SB_I_NOIDMAP flag, in this
> > case, is too late as a user may do the trick by creating an idmapped mount while it wasn't
> > restricted by SB_I_NOIDMAP. Alternatively, we can introduce a "positive" version SB_I_ALLOWIDMAP
> 
> I see.
> 
> > and a "weak" version of FS_ALLOW_IDMAP like FS_MAY_ALLOW_IDMAP. So if FS_MAY_ALLOW_IDMAP is set,
> > then SB_I_ALLOWIDMAP has to be set on the superblock to allow the creation of an idmapped mount.
> > But that's a matter of our discussion.
> 
> I dislike making adding a struct super_block method. Because it means that we
> call into the filesystem from generic mount code and specifically with the
> namespace semaphore held. If there's ever any network filesystem that e.g.,
> calls to a hung server it will lockup the whole system.So I'm opposed to
> calling into the filesystem here at all. It's also ugly because this is really
> a vfs level change. The only involvement should be whether the filesystem type
> can actually support this ideally.

That's a very interesting point about holding a semaphore. Thanks!

> 
> I think we should handle this within FUSE. So we allow the creation of idmapped
> mounts just based on FS_ALLOW_IDMAP. And if the server doesn't support the
> FUSE_OWNER_UID_GID_EXT then we simply refuse all creation requests originating
> from an idmapped mount. Either we return EOPNOSUPP or we return EOVERFLOW to
> indicate that we can't represent the owner correctly because the server is
> missing the required extension.

Ok, that's effectively the same approach that we already have in cephfs:
https://github.com/torvalds/linux/blob/41bccc98fb7931d63d03f326a746ac4d429c1dd3/fs/ceph/mds_client.c#L3059

I personally comfortable with this too.

It's interesting to hear what Miklos thinks about it.

Kind regards,
Alex

> 
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 3f37ba6a7a10..0726da21150a 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -606,8 +606,16 @@ static int get_create_ext(struct mnt_idmap *idmap,
>                 err = get_security_context(dentry, mode, &ext);
>         if (!err && fc->create_supp_group)
>                 err = get_create_supp_group(dir, &ext);
> -       if (!err && fc->owner_uid_gid_ext)
> -               err = get_owner_uid_gid(idmap, fc, &ext);
> +       if (!err) {
> +               /*
> +                * If the server doesn't support FUSE_OWNER_UID_GID_EXT and
> +                * this is a creation request from an idmapped mount refuse it.
> +                */
> +               if (fc->owner_uid_gid_ext)
> +                       err = get_owner_uid_gid(idmap, fc, &ext);
> +               else if (idmap != &nop_mnt_idmap)
> +                       err = -EOPNOTSUPP;
> +       }
> 
>         if (!err && ext.size) {
>                 WARN_ON(args->in_numargs >= ARRAY_SIZE(args->in_args));


-- 
Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

