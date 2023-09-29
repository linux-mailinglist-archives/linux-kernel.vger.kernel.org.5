Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF547B3194
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 13:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbjI2Lk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 07:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbjI2Lkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 07:40:55 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E8CC0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 04:40:53 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c6052422acso123105ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 04:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695987653; x=1696592453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZOPZ+xP375DoQjjQBBJV+szQfuC4HZOIDj9VYeNHuY=;
        b=YF/GfaxEe3HFNFr/FWwHlzRqbrJi/LypZ73hiSBhh4KSJieUdqtWdqaLc2ZUpj657U
         kYtHPo0bp8YcE6Fcv9L2j30NBtLWU1J5pvW2EhMI+dmJqJ0f8+I1MJ7q7aAcgTtREL3S
         mXtVrU3ypb20+V5LUO77gSyTLlOEM//5sYs+dnk7yXbCJz9/b9CM1LZ6xWh/+BRXqzSR
         LUdqTrtEmlFTpZD6WSxu24Mwe+q33NMLwFXEw6ixrqaRvqa7msZeKNwAuDOArEvtAPzx
         XLQNT8FX0zDAF85zK2SbOoSm5wfEkbW5MGJjcnuuC2i4tydMwQA64uZyPRimOW9IGXgl
         Z8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695987653; x=1696592453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZOPZ+xP375DoQjjQBBJV+szQfuC4HZOIDj9VYeNHuY=;
        b=Xu1+YQJJ3p85iKnKe5hwdKCdk8z3879kZHti8IF/cjY7zqu3GT44SbwiRw24YWM/la
         Dr13pt93SY+Qw3wEP5R9jwmuWn2DMzE9WV6A4LhLWogN/DirxVkrp9+A0QgFHocFxVKO
         Um5dwBetpoqeXxY2WgSbiZRnPpzPHOct3t0LRG+zig2MXkf2qaZM4TWtmdcyZ7DxdqEP
         PKlhKhNwKJeBP4bN7/ePjRaN/ZZ4Dut4XwAX3uhYYp3MCcKkUE8TJzs3NBTxQfmlCliE
         kxysD+EPq9pOynCRx8VdUxis/skBIxCcyughfp9QJp5SK+6PPiqRr/IyQbzglboC/jxW
         uLWQ==
X-Gm-Message-State: AOJu0YzYp8k2wcn0Gm+XxgDZS7HFvC2dtN1BsyestGX2/IkulTQi+qVe
        Mw+HH6N0yM4zPs9Ar9Wiun716Vr2Y5XNv/v7a5vkeYkAaa5yT4Gfp2o=
X-Google-Smtp-Source: AGHT+IF7Rhuo4hSmvyBubR6o6fBOm+n3EBxZ2Rz7vj6cnrETmCgaWx69H+tOyl1OZ6rOLVnj9DFbd7K5QsJrJwx7NlQ=
X-Received: by 2002:a17:903:32d0:b0:1bc:29c3:5895 with SMTP id
 i16-20020a17090332d000b001bc29c35895mr964124plr.0.1695987653000; Fri, 29 Sep
 2023 04:40:53 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000a8df0406061b76e6@google.com> <f8891c2f-38f9-f741-66ad-8c5fbe1e365f@ghiti.fr>
In-Reply-To: <f8891c2f-38f9-f741-66ad-8c5fbe1e365f@ghiti.fr>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Fri, 29 Sep 2023 13:40:41 +0200
Message-ID: <CANp29Y7wO0OrrDCauTK_O2Rf=vrqVwrUGmHy-hanSKvWexJpyQ@mail.gmail.com>
Subject: Re: [syzbot] riscv/fixes test error: BUG: got no coverage: (3)
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     syzbot <syzbot+2ecff9714d050e3c3a88@syzkaller.appspotmail.com>,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 12:56=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> wr=
ote:
>
> On 24/09/2023 16:14, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    b06fab003ae1 riscv: kselftests: Fix mm build by removin=
g t..
> > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/lin=
ux.git fixes
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D16388918680=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D89f0a88d4bc=
7f0f4
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D2ecff9714d050=
e3c3a88
> > compiler:       riscv64-linux-gnu-gcc (Debian 12.2.0-13) 12.2.0, GNU ld=
 (GNU Binutils for Debian) 2.40
> > userspace arch: riscv64
> >
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets=
/a741b348759c/non_bootable_disk-b06fab00.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/d751d3ead63f/vmli=
nux-b06fab00.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/d72380bd99cc=
/Image-b06fab00.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+2ecff9714d050e3c3a88@syzkaller.appspotmail.com
> >
> > executing program
> > executing program
> > executing program
> > executing program
> > 1970/01/01 00:05:53 SYZFATAL: BUG: got no coverage:
>
>
> Not sure how to debug that, any idea what's wrong here?

The error message means that KCOV did not return any kernel coverage
to syzkaller when it should have returned at least something.

It was recorded on syzbot only once ~ a week ago and, since then,
syzbot has been able to build and boot newer kernel revisions. So the
report is no longer really worth investigating. Let's invalidate it.

#syz invalid

>
>
> > loop exited with status 11
> >
> >
