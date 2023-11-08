Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F0E7E5EFF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 21:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjKHULH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 15:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjKHULF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 15:11:05 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA007211B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 12:11:02 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d84c24a810dso105148276.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 12:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699474262; x=1700079062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WdQXlJuW20JcGlaQadU7ZgL5w1/h84E2psVd7Y2aHT4=;
        b=MZfSCdNv2PsxTeE75RiHAs/7KpUpwUrLsoi1dFjiDdIrDZhH70j9DCrJDUPEBr9IhX
         k7gZMoJE1XPHOhvol4wxo7YxFnOFUVUxI7qgdvUuovss16SEqcZsK0viE5E7insB/olb
         w2Ub/lJ8oeIEY8g2whWPsIFTchDQ2wo4Jx5VTOcRvECQdoHjLBNq2i/UrNUdBt/tLuvi
         ncdkEFM88s27g6Bhd6EfrJ3NhwxK9AfPzT0C1NE8B9ITcgSEup4zX1OHLwsJ6r6fWWDp
         VaLgVrHdENifBIUAvZtoUKQQYsi/x5aYeJhCWMpHuqbNiRms6pcmmrq5kaKKWigrfSRD
         e7zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699474262; x=1700079062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WdQXlJuW20JcGlaQadU7ZgL5w1/h84E2psVd7Y2aHT4=;
        b=JnmJ9/L6pWJQQxMmUAiRNK/J8CIbgbL0Ku+voiAuqhGKYyQO9g1ZyiaagKyUVXG6fF
         XZTL6kzP1gPNoy8B+2GI9vbTNs9a3r+dQkMT/igzhC8IQXWzOmt8pEFkz3Tw0546uh1O
         3EBINIusBc/sHpXpeN+LPzpdsDNflrnZwnfD33cLLlBa/3fIKdA01H4Gu24RSt7EkyzW
         kyb4zBBXbkaLZhnET1klR1/HzaQxqeajAqJLXkB+HFnvAex+ol/v8NU3LwQEIggD2sKu
         ey2TT0SyjT58l/fx238l+upDpRxnqwL85KtJLezqLSvzlBfMKNfRL1eYYLrnEtFCRhq6
         XueQ==
X-Gm-Message-State: AOJu0YyRK8/QqpledW+myh+DJiIy5dTWWTt8p+VkW6gNCmx8G45/Lmvk
        Y7HKb9W5LBIQ/57+2Di2GrsEoUsbYIq+jb2PsM+l
X-Google-Smtp-Source: AGHT+IGx24XRQweoz1EaCe+kSiqvIrqmyKZE1dlffO9Wgq6HodmUotEUsJYVWiUyZ7p7+YFh1nttrYhrBU0rClZtQF0=
X-Received: by 2002:a25:680c:0:b0:d9c:aa29:6180 with SMTP id
 d12-20020a25680c000000b00d9caa296180mr2811921ybc.46.1699474262093; Wed, 08
 Nov 2023 12:11:02 -0800 (PST)
MIME-Version: 1.0
References: <20231025140205.3586473-5-mszeredi@redhat.com> <4ab327f80c4f98dffa5736a1acba3e0d.paul@paul-moore.com>
 <20231108-zwerge-unheil-b3f48a84038d@brauner>
In-Reply-To: <20231108-zwerge-unheil-b3f48a84038d@brauner>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 8 Nov 2023 15:10:50 -0500
Message-ID: <CAHC9VhSLGyFRSbeZXE7z61Y2aDJi_1Dedjw0ioFOckRCs0CRaA@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] add statmount(2) syscall
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew House <mattlloydhouse@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 8, 2023 at 2:58=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
> > > +static int do_statmount(struct stmt_state *s)
> > > +{
> > > +   struct statmnt *sm =3D &s->sm;
> > > +   struct mount *m =3D real_mount(s->mnt);
> > > +   size_t copysize =3D min_t(size_t, s->bufsize, sizeof(*sm));
> > > +   int err;
> > > +
> > > +   err =3D security_sb_statfs(s->mnt->mnt_root);
> > > +   if (err)
> > > +           return err;
> > > +
> > > +   if (!capable(CAP_SYS_ADMIN) &&
> > > +       !is_path_reachable(m, m->mnt.mnt_root, &s->root))
> > > +           return -EPERM;
> >
> > In order to be consistent with our typical access control ordering,
> > please move the security_sb_statfs() call down to here, after the
> > capability checks.
>
> I've moved the security_sb_statfs() calls accordingly.

Okay, good.  Did I miss a comment or a patch where that happened?  I
looked over the patchset and comments yesterday and didn't recall
seeing anything about shuffling the access control checks.

--=20
paul-moore.com
