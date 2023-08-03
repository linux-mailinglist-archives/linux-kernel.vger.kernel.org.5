Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9023C76F30A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 20:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjHCSxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 14:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234324AbjHCSxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 14:53:08 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5448A2D5A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 11:53:00 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9338e4695so20503701fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 11:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691088778; x=1691693578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16O8o09yKlIrWJqVGKmGPXtBxRWH/JyAAhiz2PZ5hMc=;
        b=GzW5xwJ4SS3NFZxvIos1RPhdVI40cJHjHyRgQFOtkhHPZz7b+nSGci357csx/1V2IB
         WF/FvNJGDDyqO/t3E1XggUbY9hOBM9OuzEOLda5rk/HOZdxPZ99UbIg5nx5kFScVSxEb
         lv/ICaBqhOvyMSyCpzHn100B4O3Xlrt3LZcr3JiV5+wHKHd6ztj7RzCygsqmrZhY6dvv
         pyM5Kdh2l7+Ba4qn5QYe8t68ZnsyC56FMznLyFS9c8erDQnQz5aNcCsr0vgMF5pStmOr
         xfMftZnQ/q87+szHwrXALvSxxMSMtils8s1jU3ZbaDbZn4DP4akZAjg2dSLbWbGm8Iig
         vblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691088778; x=1691693578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=16O8o09yKlIrWJqVGKmGPXtBxRWH/JyAAhiz2PZ5hMc=;
        b=f5IPbZY4ppmqGv3cpfM6Rw63nAAsed7F4Z9BAgpH3mqJVGYPNv2VWdep2jG22FyavC
         sHepNGzaDhPFqgSFyONsOwWo70EbA5mgmMPGCTx9q0jaCqinZpHeWv/z0AjRnhvmGdq6
         iH6Fl7StBi3mn2GvH7Hy/HBWwVLJYJYo2C4sWzs0aJZzzYb4Ecb7sYE/64by+AgHmA1z
         Yc54XHGX59ZyZnFNsEkOiTpRjdmWwK37pk+cuCqsorWoarVkNME5uMHrZD1nQ9/9I7Bz
         nczeSDHVVoj1vb3cmBPpYvLm420gF2WS+BmExM7qtmxobSx/CyvQ8nns0mJSa9pV5QOf
         QrvQ==
X-Gm-Message-State: ABy/qLbZU37JoV8pRHL5d/uHDI+aalvu0hUkC0v4D0/j9JxNqH0kMJwy
        c6T3QfV0sezBuYmBudElWZ5ZHlA1SddExPbLbadV7w==
X-Google-Smtp-Source: APBJJlG/Kp8wtYMBiWPpzTFP8Ihv2XMSuxMuJWKmxLJB/63skudYdK57L9Kzc8xr7IwRqG5q3hKp0UuZwpqXbfioyZs=
X-Received: by 2002:a2e:9316:0:b0:2b6:c236:b040 with SMTP id
 e22-20020a2e9316000000b002b6c236b040mr7662784ljh.12.1691088778226; Thu, 03
 Aug 2023 11:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230726153223.821757-1-yosryahmed@google.com>
 <20230726153223.821757-2-yosryahmed@google.com> <ZMkXDuwD8RFRKnNQ@dhcp22.suse.cz>
 <CAJD7tkbb8AWR-duWb+at-S9MMz48b0JqnM+b5ok83TzvXvPb+A@mail.gmail.com>
 <CAJD7tkbZi16w4mYngVK8qA84FMijmHvwzMjHfrJiCsV=WjixOA@mail.gmail.com>
 <ZMoIYLwITUZzXp4C@dhcp22.suse.cz> <CAJD7tkY4hTTCfqSGa_XexbH=WSTJ4WXWeMXSU+6KW8qfr7agfQ@mail.gmail.com>
 <CAJD7tkb17x=qwoO37uxyYXLEUVp15BQKR+Xfh7Sg9Hx-wTQ_=w@mail.gmail.com> <ZMu/+ysmksCZqcem@dhcp22.suse.cz>
In-Reply-To: <ZMu/+ysmksCZqcem@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 3 Aug 2023 11:52:21 -0700
Message-ID: <CAJD7tkZ2u0db3UP3K+2ag12VCRhzjJVrwipsyMV2fb9jdfwCzg@mail.gmail.com>
Subject: Re: [PATCH v3] mm: memcg: use rstat for non-hierarchical stats
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 7:55=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrote=
:
>
> On Wed 02-08-23 15:02:55, Yosry Ahmed wrote:
> [...]
> > Let me know if the testing is satisfactory for you. I can send an
> > updated commit log accordingly with a summary of this conversation.
>
> Yes this should be sufficient as it exercises all the CPUs so the
> overhead in flushing should be visible if this was a real deal. I would
> have gone with kernel build test as that has a broader code coverage but
> this artificial test should give some red flags as well. So good enough.
> Amending the changelog with this would be helpful as well so that future
> us and others will know what kind of testing has been done.
>
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks! I sent a v4 with your Ack and an amended changelog that
describes the testing done and points to the script attached here.

>
> >
> > > > --
> > > > Michal Hocko
> > > > SUSE Labs
>
> > #!/bin/bash
> >
> > NR_CPUS=3D$(getconf _NPROCESSORS_ONLN)
> > NR_CGROUPS=3D$(( NR_CPUS * 2 ))
> > TEST_MB=3D50
> > TOTAL_MB=3D$((TEST_MB * NR_CGROUPS))
> > TMPFS=3D$(mktemp -d)
> > ROOT=3D"/sys/fs/cgroup/"
> > ZRAM_DEV=3D"/mnt/devtmpfs/zram0"
> >
> > cleanup() {
> >   umount $TMPFS
> >   rm -rf $TMPFS
> >   for i in $(seq $NR_CGROUPS); do
> >     cgroup=3D"$ROOT/cg$i"
> >     rmdir $cgroup
> >   done
> >   swapoff $ZRAM_DEV
> >   echo 1 > "/sys/block/zram0/reset"
> > }
> > trap cleanup INT QUIT EXIT
> >
> > # Setup zram
> > echo $((TOTAL_MB << 20)) > "/sys/block/zram0/disksize"
> > mkswap $ZRAM_DEV
> > swapon $ZRAM_DEV
> > echo "Setup zram done"
> >
> > # Create cgroups, set limits
> > echo "+memory" > "$ROOT/cgroup.subtree_control"
> > for i in $(seq $NR_CGROUPS); do
> >   cgroup=3D"$ROOT/cg$i"
> >   mkdir $cgroup
> >   echo $(( (TEST_MB << 20) / 4)) > "$cgroup/memory.max"
> > done
> > echo "Setup cgroups done"
> >
> > # Start workers to allocate tmpfs memory
> > mount -t tmpfs none $TMPFS
> > for i in $(seq $NR_CGROUPS); do
> >   cgroup=3D"$ROOT/cg$i"
> >   f=3D"$TMPFS/tmp$i"
> >   (echo 0 > "$cgroup/cgroup.procs" &&
> >     dd if=3D/dev/zero of=3D$f bs=3D1M count=3D$TEST_MB status=3Dnone &&
> >     cat $f > /dev/null)&
> > done
> >
> > # Wait for workers
> > wait
>
>
> --
> Michal Hocko
> SUSE Labs
