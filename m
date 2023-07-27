Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2188765C01
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 21:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbjG0TUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 15:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjG0TUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 15:20:14 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5E1F3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 12:20:13 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f58444a410so674e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 12:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690485612; x=1691090412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWa8Bstqe+PKwfvvskX3BhBIL8nUC+d+rJDV9BvUQGc=;
        b=cXDtGlq1/SL6cs7e3G0edW1fcqOngTdgH0ZmgQRxYXSzgenYddUrawOd8aV1euePnR
         uBL+1IhcXy+LpjrnNhDwQ7gcRMThtStbyqGGZbvmNrHuczWhrsx/Z2cGPQGg8mVJlw8v
         bzCa11nFNH+7vn7Wk5PshPg0+wIgSxAn+/6D0q6+g0+M3nGGjToyWorz2ov/b6YHicC3
         kfx7qqLnkM4O8RHqYW8BQkBd9dw1uVR+shTspJk7xub24xRIrLw9EqO5FqdAy1X2H9WK
         hy7lAlL/W9Qw8kbdlO81xqd5vgculaW3D48Sm+qJaVA6AIdkbb8+nz6HqOjeYkVIoKFF
         UtXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690485612; x=1691090412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NWa8Bstqe+PKwfvvskX3BhBIL8nUC+d+rJDV9BvUQGc=;
        b=j9yVCAp+I6/VCrZAg3C7Uz+xQSxhgxKiIP5pPrWCNVLxyMEKfx9nMNMEtaILtjWMMb
         IozF5Mz13PxNkwcyGc+fbmnf7nUixwn6TRIA5WNYskzoed7g51kytCl9XMKZ8dviKCZj
         u5l96SXA7LpWUm7R0yzT4CIm82pPAQSGRp6CF6ZMi1RpSsqZzDB4FtyhK1Baooon+YNM
         Wuz3D4BIIuaS8Tkd4VShcqMO/aVHAMHZQJN2MW8YJDrLGlg3AMigRXWpXWEVNg2uKQBu
         rhrmmh0ECTSydlu9oKN8Hy/lNR53EH7bnrh6mBJ8sZJm6yV0EV0pmXrX6he8ueEluZmB
         5OpA==
X-Gm-Message-State: ABy/qLYtxJsG3oijp8ManBH1td7SdTvF0AMEKHhEMaFIUOfa4DrYb/2y
        dKkD6hVjHQEIvHb6jxZitkDmoG1XEQ3/70l0KfE3c5ycHRhDWS/05jMb6z3j
X-Google-Smtp-Source: APBJJlED1SfLnWR0xjG24DvcpV8ETwQoqYPH/QOhH3Ffh+4FGOdk8jwd4DlFSrw8wIZ1iez9Q693fCLBaQkrM8A5F2k=
X-Received: by 2002:a05:600c:8509:b0:3f7:3e85:36a with SMTP id
 gw9-20020a05600c850900b003f73e85036amr19144wmb.7.1690485169747; Thu, 27 Jul
 2023 12:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <ZMK9C+iq3y8POOGp@casper.infradead.org> <0000000000004ccc7906017c79e0@google.com>
 <ZMK9arq/gzFEqUOs@casper.infradead.org>
In-Reply-To: <ZMK9arq/gzFEqUOs@casper.infradead.org>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Thu, 27 Jul 2023 21:12:36 +0200
Message-ID: <CANp29Y6YgrQ4pX+JXY1SBtmFYc2ThyHUA6GAEVMh5hqu6Q0FdA@mail.gmail.com>
Subject: Re: [syzbot] [mm?] WARNING: suspicious RCU usage in mas_walk (2)
To:     Matthew Wilcox <willy@infradead.org>
Cc:     syzbot <syzbot+8645fe63c4d22c8d27b8@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, liam.howlett@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 8:54=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Thu, Jul 27, 2023 at 11:53:02AM -0700, syzbot wrote:
> > > On Tue, Jul 25, 2023 at 11:57:22PM -0700, syzbot wrote:
> > >> syzbot has bisected this issue to:
> > >>
> > >> commit a52f58b34afe095ebc5823684eb264404dad6f7b
> > >> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> > >> Date:   Mon Jul 24 18:54:10 2023 +0000
> > >>
> > >>     mm: handle faults that merely update the accessed bit under the =
VMA lock
> > >>
> > >> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D17835=
85ea80000
> > >> start commit:   [unknown]
> > >> git tree:       linux-next
> > >
> > > #syz test linux-next a52f58b34afe095ebc5823684eb264404dad6f7b
> >
> > "linux-next" does not look like a valid git repo address.
>
> Well, now, that's your fault, isn't it?  You're abbreviating the git
> tree in the report, but then refusing to accept the abbreviation in
> the response.

Good point.
There's an issue about this
(https://github.com/google/syzkaller/issues/2265), I've added it to my
backlog.

--=20
Aleksandr
