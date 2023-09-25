Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9147ADF3C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 20:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbjIYSrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 14:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbjIYSrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 14:47:05 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD47911B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 11:46:58 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-41513d2cca7so70971cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 11:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695667618; x=1696272418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIe77vdqpeQpP4qLU2XoNxMwUlYUlcq3Ovdt56o2n9g=;
        b=IX3s4sxaz7OcP4jU5K9TFCJcYBbTaTK8DC5DVjpz7OFfhqVPQlFgRLfqEKUsd/fpqa
         K5biH5/2HQMAhlku0vFz3IjBUA7DXNFFNV1MoJw3ax9qbHLPThSPQ6Qe+4Ad71yD2QYe
         yj+tHqNMAp3BS6jdV0srKehUAJl0qNe9SAqBRCJ9qMhTdcudX39NuFlRFIYff9NSoIdS
         RD2YTeomljUlL3tTlcr93Q+NhmMeWQZj/ls/iH/UjLzuXXwUgr/cfUxIAlRVliZJJa/w
         u7TcMUJ6jF2NwsjW2Qri9gM9J0qAhh9OkyPvHVPT7TaG5HvADasNqUOyP+0lU3J+o4WX
         y4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695667618; x=1696272418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cIe77vdqpeQpP4qLU2XoNxMwUlYUlcq3Ovdt56o2n9g=;
        b=Pd6qVWG02hsyVIcNbcqd5xsScVieH8gLSiHvn1CyaCl2aYm4qREioaVaD5PUZpCaXs
         XiAM3nSFxRvnMZOjT24omsH2JrjBjpCOUPYAHqLjReE4odabZimtC0pF1I5z23AlJhBj
         nt+oCDrEEPaBBVXX/hh06ApugZp5I29EOEVqEgphaAJ2pASE1isj0EFaRT++ktk1dmsW
         /UW6p8MTf/4xBah58asQpBYihmtZatty/oavfWdMdnauOzHEVDbP1pjXNPKvyMMhr6hY
         HknVV9Ot+gBSZY57/TyFhDq6ejCeW6w80Gq/c0fn1I1O0/YRM9VjlYPr8zfEy4IrRgd5
         bpfQ==
X-Gm-Message-State: AOJu0Yy35eSx2/AmeVe+VXg0smQ3OeSiQSKR2Jop//vxE1y6X8zb1FqC
        6SXljj/czx3iw5eHcvsPwh/9Khr/CSCPHA2onKMBEg==
X-Google-Smtp-Source: AGHT+IFe4dMCVmru5710X8d/0Eg9d2426abCEsKgiWdK9mammCqEryHqv8UCuq8gM7WyIzzoRi1K4C+CGABxXZ+qVQY=
X-Received: by 2002:ac8:5a46:0:b0:410:88dc:21b with SMTP id
 o6-20020ac85a46000000b0041088dc021bmr52357qta.26.1695667617738; Mon, 25 Sep
 2023 11:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230922044241.322832-1-cmllamas@google.com> <20230922175138.230331-1-cmllamas@google.com>
 <CAH5fLgivUrTGxFjmnN2XYv5_hL==A+UfmJibC0vzy4Bw1AMxAQ@mail.gmail.com>
In-Reply-To: <CAH5fLgivUrTGxFjmnN2XYv5_hL==A+UfmJibC0vzy4Bw1AMxAQ@mail.gmail.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Mon, 25 Sep 2023 11:46:46 -0700
Message-ID: <CAHRSSEyEyne+agwcfFWNnEUY-FtqDRB5PkqFihY9tgh_-bMHCA@mail.gmail.com>
Subject: Re: [PATCH v2] binder: fix memory leaks of spam and pending work
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     Carlos Llamas <cmllamas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Li Li <dualli@google.com>, Hang Lu <hangl@codeaurora.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        syzkaller-bugs@googlegroups.com, stable@vger.kernel.org,
        syzbot+7f10c1653e35933c0f1e@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 11:51=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> On Fri, Sep 22, 2023 at 7:51=E2=80=AFPM Carlos Llamas <cmllamas@google.co=
m> wrote:
> >
> > A transaction complete work is allocated and queued for each
> > transaction. Under certain conditions the work->type might be marked as
> > BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT to notify userspace about
> > potential spamming threads or as BINDER_WORK_TRANSACTION_PENDING when
> > the target is currently frozen.
> >
> > However, these work types are not being handled in binder_release_work(=
)
> > so they will leak during a cleanup. This was reported by syzkaller with
> > the following kmemleak dump:
> >
> > BUG: memory leak
> > unreferenced object 0xffff88810e2d6de0 (size 32):
> >   comm "syz-executor338", pid 5046, jiffies 4294968230 (age 13.590s)
> >   hex dump (first 32 bytes):
> >     e0 6d 2d 0e 81 88 ff ff e0 6d 2d 0e 81 88 ff ff  .m-......m-.....
> >     04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >   backtrace:
> >     [<ffffffff81573b75>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1114
> >     [<ffffffff83d41873>] kmalloc include/linux/slab.h:599 [inline]
> >     [<ffffffff83d41873>] kzalloc include/linux/slab.h:720 [inline]
> >     [<ffffffff83d41873>] binder_transaction+0x573/0x4050 drivers/androi=
d/binder.c:3152
> >     [<ffffffff83d45a05>] binder_thread_write+0x6b5/0x1860 drivers/andro=
id/binder.c:4010
> >     [<ffffffff83d486dc>] binder_ioctl_write_read drivers/android/binder=
.c:5066 [inline]
> >     [<ffffffff83d486dc>] binder_ioctl+0x1b2c/0x3cf0 drivers/android/bin=
der.c:5352
> >     [<ffffffff816b25f2>] vfs_ioctl fs/ioctl.c:51 [inline]
> >     [<ffffffff816b25f2>] __do_sys_ioctl fs/ioctl.c:871 [inline]
> >     [<ffffffff816b25f2>] __se_sys_ioctl fs/ioctl.c:857 [inline]
> >     [<ffffffff816b25f2>] __x64_sys_ioctl+0xf2/0x140 fs/ioctl.c:857
> >     [<ffffffff84b30008>] do_syscall_x64 arch/x86/entry/common.c:50 [inl=
ine]
> >     [<ffffffff84b30008>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.=
c:80
> >     [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >
> > Fix the leaks by kfreeing these work types in binder_release_work() and
> > handle them as a BINDER_WORK_TRANSACTION_COMPLETE cleanup.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 0567461a7a6e ("binder: return pending info for frozen async txns=
")
> > Fixes: a7dc1e6f99df ("binder: tell userspace to dump current backtrace =
when detected oneway spamming")
> > Reported-by: syzbot+7f10c1653e35933c0f1e@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D7f10c1653e35933c0f1e
> > Suggested-by: Alice Ryhl <aliceryhl@google.com>
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Acked-by: Todd Kjos <tkjos@google.com>
