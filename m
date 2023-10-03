Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0535E7B755A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238219AbjJCXmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238024AbjJCXmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:42:14 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88259DC
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 16:42:05 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d77ad095f13so1594558276.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 16:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1696376525; x=1696981325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SjA75N+ejDLC45VlzVptLHxzNWXM0z0YjaVzLTZEJk=;
        b=cauXbrqDMYfBfIJdCkh//lgXTor8mD4MEg+eoTrnZG+HoNVuoSflTy46Zjd6p0zRb7
         cmQXkgJLQqV55dTMe3O66wgOqHtWHbRdo2ImyrT2gMxb7/tob+KHH7xoMvB/Jd1Jy65E
         Xi76UuJ0KvjM1ysIHgrA+F+bc3HbSg19CiB6xGbceG8eQegggEUTrM3oZSZ1nEgjaMuq
         8zwoLrnwTwXlL0GTgTxpJ/CjdEBaomlOQn8ZTrfpSpdDHGRlkUSSoc2Ofbv6bdM/T/iG
         jWFByrdJ+E1btZYv7b+0OedJAWnKdMrAx0+fv8P//ZFqS7ovjwdJfgknTyG58i1ZfZEQ
         1Gyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696376525; x=1696981325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7SjA75N+ejDLC45VlzVptLHxzNWXM0z0YjaVzLTZEJk=;
        b=tOostW5JM1aJelqVp4OQdXTTgA4/OOQkbDa2j93sMawlrNNUA3xvbwxFV/65na8LVr
         1zGlEvcpEs1U2AffdkrABUgZD8c9SdYJPzBjWVanJdS4jGyOxX34u65dAgQMvcci6htr
         XSwhdjXzzhXuCP6z28+uHaaCiUyDdgx+jnpKFWrAce50+MAmXc5kwJdBo6dZj8AK/61/
         Dtnxu0HOpshtE6HuRYYHzOYroNj+9tDs4l4Bd027CFXqFOcuiyXfOgydI+zj7PBqA63s
         ozOtR0rm0YSqA9g/RiUkLfKEEcoK+0xUFENOrXnZPaYCXi0FKJ3dTSGK0h18kTHkGbJU
         V+gg==
X-Gm-Message-State: AOJu0YycwMo/K8TYofS3P3kR1rjS6dlJwM4OxGwLx6QaPGCB0wdhlyJ2
        /9coVB9ajWqNz30FO2iI0hFXUPZiI718I7S4y6a5
X-Google-Smtp-Source: AGHT+IFn4aOITO9vhhWDdp9FdrjvDiH+io1tqL2nOtLDQ8d4YyHKQ8ObGVLtyHCRY1krbvWLxeBkhLZh3u09ydowjVY=
X-Received: by 2002:a25:ab0b:0:b0:d7a:ea5b:a45 with SMTP id
 u11-20020a25ab0b000000b00d7aea5b0a45mr667291ybi.57.1696376524736; Tue, 03 Oct
 2023 16:42:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230928110300.32891-1-jlayton@kernel.org> <20230928110413.33032-1-jlayton@kernel.org>
 <20230928110413.33032-83-jlayton@kernel.org>
In-Reply-To: <20230928110413.33032-83-jlayton@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 3 Oct 2023 19:41:54 -0400
Message-ID: <CAHC9VhTsk5GyetM3ekBDv1f-QQVqWWgZmMWqpg8hqdyCOySHEQ@mail.gmail.com>
Subject: Re: [PATCH 84/87] security: convert to new inode {a,m}time accessors
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 7:22=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  security/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/security/inode.c b/security/inode.c
> index 3aa75fffa8c9..9e7cde913667 100644
> --- a/security/inode.c
> +++ b/security/inode.c
> @@ -145,7 +145,7 @@ static struct dentry *securityfs_create_dentry(const =
char *name, umode_t mode,
>
>         inode->i_ino =3D get_next_ino();
>         inode->i_mode =3D mode;
> -       inode->i_atime =3D inode->i_mtime =3D inode_set_ctime_current(ino=
de);
> +       simple_inode_init_ts(inode);
>         inode->i_private =3D data;
>         if (S_ISDIR(mode)) {
>                 inode->i_op =3D &simple_dir_inode_operations;
> --
> 2.41.0

--=20
paul-moore.com
