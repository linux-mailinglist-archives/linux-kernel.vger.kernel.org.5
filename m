Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C737717D7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 03:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjHGBdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 21:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHGBdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 21:33:44 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F049310FC;
        Sun,  6 Aug 2023 18:33:42 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-56c96982829so2838994eaf.0;
        Sun, 06 Aug 2023 18:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691372022; x=1691976822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPLgc57AKRSEGsO5ypQE1ZoTGMdbNRmqzxfZLlDZrWA=;
        b=dmpvcRzlDhoHCdII+nrgQHOnO+AdCM+ptjfKY+U0rCNmWZ911W7iOWCNfl7s960HZi
         NoqJkbcEHe1l900jFLL6IXSxLpjrZEROdNgMzt2kNY2QkJRE8YlW2mGvwAn7my4sddB9
         frTc0FDKkPpCGDA522H6MY55O7/9UNNB2HzulLL0sLqFZXe9C6vVQhiD3lI4KVYRJXuX
         F0dXkBZviAM96JiqHCJO+JU5Q7FjpKyO64Drz/DumQLSMwS4EqqVf3eMrUqjp9d1MfWY
         pB1noDh0EzVl0GFGPlqNp1PVwKLuhfUSfRzhrJZec4VAd16BE+OtS6vfOeJjJmVPqyff
         PVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691372022; x=1691976822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YPLgc57AKRSEGsO5ypQE1ZoTGMdbNRmqzxfZLlDZrWA=;
        b=dpMfhxZoQdpihvu+B/y6JutGEWR6uxwfUL9S2MSNvLfNcY1ubDkNOz2XwPYgnVdPac
         asg/M5pCvaoe8SNDqk14KpCM/FKcCasrdnwIDFVGlX4ijHZ7fFbRdRgiFloPuAQ4TlDp
         j/7jHbI3rKEISrGAYktIbsCmy8N5z1dkV83i0Ee8m5tF4T7f61yFnQHRyYwgPn23m8nh
         9XP0z8yYOxw+XS3KI5BWHIWd3YHAol4mXrd9XvaAdhw9CEXrzl/4a7dXZpjTSvgT7M6c
         Qhx3QzKGEYZNqblgrb/OVQVmKs+UiLhu5eLGyZOLN6/WYyqhYdtlcdVj8YXAFzyHxHco
         3UkQ==
X-Gm-Message-State: AOJu0YwYAX8vFqiwmMn2KxYp8bvc4yoqVKm/1IipMfMAHxr13ds0K8Cy
        0x29DzMQHsiixrO4KxchYr9K3LakEBmUfRqOInHbG+9vqGM=
X-Google-Smtp-Source: AGHT+IEm7SjWpS5e8NKI7vRK8O2qVdSyhva73lN1sA+fByRDiS3cOE/Eqs8Wpuf6EvwsBuRnCFfsKZ0XhkkB2KgbgVw=
X-Received: by 2002:a4a:654b:0:b0:56d:2cbf:2315 with SMTP id
 z11-20020a4a654b000000b0056d2cbf2315mr6521680oog.9.1691372022186; Sun, 06 Aug
 2023 18:33:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230801060432.1307717-1-yunlong.xing@unisoc.com>
 <202308040103.1514A8C3CB@keescook> <CA+3AYtRYNQKuM9-99LvZYZqraLokKV4bjuvYKyEPB3MG7+VevA@mail.gmail.com>
 <202308040948.ABF3EBDAEF@keescook>
In-Reply-To: <202308040948.ABF3EBDAEF@keescook>
From:   yunlong xing <yunlongxing23@gmail.com>
Date:   Mon, 7 Aug 2023 09:33:31 +0800
Message-ID: <CA+3AYtQ58=YvW7s=zLsnp9O9N3NrnpcOd0Qhvh-DJ0-7FGVckw@mail.gmail.com>
Subject: Re: [PATCH 1/1] pstore/ram: Check member of buffers during the
 initialization phase of the pstore
To:     Kees Cook <keescook@chromium.org>
Cc:     Yunlong Xing <yunlong.xing@unisoc.com>, tony.luck@intel.com,
        gpiccoli@igalia.com, joel@joelfernandes.org, enlin.mu@unisoc.com,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        enlinmu@gmail.com, enlin.mu@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 5, 2023 at 12:53=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Fri, Aug 04, 2023 at 04:59:07PM +0800, yunlong xing wrote:
> > On Fri, Aug 4, 2023 at 4:10=E2=80=AFPM Kees Cook <keescook@chromium.org=
> wrote:
> > >
> > > On Tue, Aug 01, 2023 at 02:04:32PM +0800, Yunlong Xing wrote:
> > > > From: Enlin Mu <enlin.mu@unisoc.com>
> > > >
> > > > The commit 30696378f68a("pstore/ram: Do not treat empty buffers as =
valid")
> > > > would introduce the following issue:
> > > >
> > > > When finding the buffer_size is zero, it would return directly.Howe=
ver, at
> > > > the same time, if the buffer's start is a illegal value, the others=
 would
> > > > panic if access the buffer.
> > >
> > > Which "others" do you mean?
> >
> > About =E2=80=9Cothers", You can refer to the following panic call stack=
:
> >  sysdump_panic_event+0x720/0xd38
> >  atomic_notifier_call_chain+0x58/0xc0
> >  panic+0x1c4/0x6e4
> >  die+0x3c0/0x428
> >  bug_handler+0x4c/0x9c
> >  brk_handler+0x98/0x14c
> >  do_debug_exception+0x114/0x2ec
> >  el1_dbg+0x18/0xbc
> >  usercopy_abort+0x90/0x94
> >  __check_object_size+0x17c/0x2c4
> >  persistent_ram_update_user+0x50/0x220
> >  persistent_ram_write_user+0x354/0x428
> >  ramoops_pstore_write_user+0x34/0x50
> >  write_pmsg+0x14c/0x26c
>
> I see -- the "start" is corrupted and out of bounds, which leads to
> these accesses.
>
> >  do_iter_write+0x1cc/0x2cc
> >  vfs_writev+0xf4/0x168
> >  do_writev+0xa4/0x200
> >  __arm64_sys_writev+0x20/0x2c
> >  el0_svc_common+0xc8/0x22c
> >  el0_svc_handler+0x1c/0x28
> >  el0_svc+0x8/0x100
> > >
> > > > To avoid these happenning, check if the members are legal during th=
e
> > > > initialization phase of the pstore.
> > > >
> > > > Fixes: 30696378f68a ("pstore/ram: Do not treat empty buffers as val=
id")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Enlin Mu <enlin.mu@unisoc.com>
> > > > ---
> > > >  fs/pstore/ram_core.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
> > > > index 85aaf0fc6d7d..eb6df190d752 100644
> > > > --- a/fs/pstore/ram_core.c
> > > > +++ b/fs/pstore/ram_core.c
> > > > @@ -519,7 +519,7 @@ static int persistent_ram_post_init(struct pers=
istent_ram_zone *prz, u32 sig,
> > > >       sig ^=3D PERSISTENT_RAM_SIG;
> > > >
> > > >       if (prz->buffer->sig =3D=3D sig) {
> > > > -             if (buffer_size(prz) =3D=3D 0) {
> > > > +             if (buffer_size(prz) =3D=3D 0 && buffer_start(prz) =
=3D=3D 0) {
> > > >                       pr_debug("found existing empty buffer\n");
> > > >                       return 0;
> > > >               }
> > >
> > > And in the case of "buffer_size(prz) =3D=3D 0" but "buffer_start(prz)=
 !=3D 0",
> > > this will be caught by:
> > >
> > >                 if (buffer_size(prz) > prz->buffer_size ||
> > >                     buffer_start(prz) > buffer_size(prz)) {
> > >                         pr_info("found existing invalid buffer, size =
%zu, start %zu\n",
> > >                                 buffer_size(prz), buffer_start(prz));
> > >                         zap =3D true;
> > >                 }
> > >
> > > i.e. it will be detected and zapped back to a sane state.
> > No,This code has no chance of execution because there was a return 0 be=
fore it
>
> Right, I meant the behavior with your patch -- with your patch the case
> of "size =3D=3D 0 && start !=3D 0" would be caught by the above check ("s=
tart > size")
> and zapped back to sanity. (Which is the correct result.)
>
> > >
> > > That sounds correct to me, though I wonder if reporting it as an
> > > "invalid buffer" is inaccurate? Perhaps we should have a separate cas=
e:
> > >
> > >                 if (buffer_size(prz) =3D=3D 0) {
> > >                         if (buffer_start(prz) =3D=3D 0)
> > >                                 pr_debug("found existing empty buffer=
\n");
> > >                         else {
> > >                                 pr_debug("found existing empty buffer=
 with non-zero start\n");
> > >                                 zap =3D true;
> > >                         }
> > >                 } else if ...
> > >
> > > What do you think?
> > Good, I gree it. For me, it should not return directly while finding
> > the buffer_size is zero, We need Check others case.
>
> Right. The only question I have is: how did the "start" get corrupted,
> and is that a notable condition? Right now we don't (info-level) log
> a size=3D=3D0 prz since that's an expected state for a regular initialize=
d
> prz. So maybe your patch is correct as-is since we'd want to report the
> "found existing invalid buffer" case.

From the last reboot to this initialization, the ddr was not stable
enough, resulting in
a jump in the start value.I hope to add error handling mechanisms to
avoid abnormal
data being used.
Thanks!
>
> > So does the modification method you mentioned require me to resubmit a
> > patch or do you need to modify and merge it
>
> I think I'll update the commit log and take this as-is. If the logging
> becomes too noisy, we can adjust the case later.
>
> Thanks!
>
> --
> Kees Cook
