Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BED27B5015
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 12:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236439AbjJBKUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 06:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236377AbjJBKUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 06:20:32 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FABFB7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 03:20:23 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c60128d3f6so249535ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 03:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696242022; x=1696846822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wfxsi3rUolUe3A835MzACItI/kOFGspetH8wi1i5DIY=;
        b=t+A6Q3GjLqa3ktvOEDZI/N8bX93R7AOBdbS0LRtBIL/NOnvlsOqYY/4zzKyQaBhM3N
         UNOkvtVaAGSFOCMDFwLu0cFs04KtaptSXvZujHBgWZ33gw4e6tzz8+80NcG8qDXD7ybK
         BXQk7WwrVAJM3FRx09Vs5oMAT/OHSqTxVZ27Li6vgInssxPJsj7iU/7v92Ol+4508OqN
         bFBTHeYvi18vNg3I5KcFRPSq6CcQGuPuUlonC4hCLU+gF1cKF9UExxvQgiWZrZeobIg7
         p1TfSCCkzhpKIGCHJg9lG4I3pg04kDBRJGZlRYGuD72E3SjDMncTYxl9eIWkGqHfkAYW
         SpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696242022; x=1696846822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wfxsi3rUolUe3A835MzACItI/kOFGspetH8wi1i5DIY=;
        b=c4G7+0vejIph/ljWdW7RVK5ikyz04xeqqYsGTRYB9xk54qkfq1YdiQe2sGPJLkYWvW
         t4CJVBfgm8BhHcjK9vMHXn23OzXLqfu5j0u2ijXBvBc+IyIa118KyafzoB7I0uwdt+W6
         voLQE1CiDDwGvwAQJnlbTWu1BnrKkfv3TRL5P88YH9jYfatXN0LlGpHpjeAlKjI7WHbP
         MNATvujZ+KhDg6dbCiQ8gliiX0uVJ3RnD8Iri1fD3jkmioZtH0RVdv3DsWJzzxz0EUYN
         Lj6LspzUPADaG9VRCuIzoYdQ7YO65rynb7A8a8hPSBOe9uO/bw4H4kwUPz7IT+gQalz+
         QUrg==
X-Gm-Message-State: AOJu0YwP0g+A/wQY6aGCbLVB7xQb7evbYIa1GWzl8xQi2ZXpFYDj01Sz
        TT7u2vGpLbmVPHTvD8tid6JOgEB1Ii0LN8XX+aGZzQ==
X-Google-Smtp-Source: AGHT+IHchCZRUpV6NwJgG6ccmDwgmfcXhM/2BrSTDVL+h1R5tsrVPd96BpWJkqeGytkLXa67Y+jBbWituyuUs4ujeqc=
X-Received: by 2002:a17:902:e549:b0:1c3:90e3:a75b with SMTP id
 n9-20020a170902e54900b001c390e3a75bmr169411plf.15.1696242022265; Mon, 02 Oct
 2023 03:20:22 -0700 (PDT)
MIME-Version: 1.0
References: <2023092939-lagoon-punctual-e312@gregkh> <20230929230534.45142-2-twuufnxlz@gmail.com>
 <2023093049-next-confusion-b812@gregkh> <20230930-quotable-feeble-2bd6513ca643@spud>
In-Reply-To: <20230930-quotable-feeble-2bd6513ca643@spud>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Mon, 2 Oct 2023 12:20:10 +0200
Message-ID: <CANp29Y79=Y76i72wHWfOJqU1tg8Z6vpbmwBRr=wcet7t5xdX5A@mail.gmail.com>
Subject: Re: [PATCH] Test for riscv fixes
To:     Conor Dooley <conor@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Edward AD <twuufnxlz@gmail.com>, alex@ghiti.fr,
        alexghiti@rivosinc.com, aou@eecs.berkeley.edu, guoren@kernel.org,
        jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        liushixin2@huawei.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com,
        syzbot+8d2757d62d403b2d9275@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2023 at 10:24=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Sat, Sep 30, 2023 at 08:13:56AM +0200, Greg KH wrote:
> > On Sat, Sep 30, 2023 at 07:05:35AM +0800, Edward AD wrote:
> > > On Fri, 29 Sep 2023 08:04:57 +0200 Greg KH wrote:
> > > > Where are you getting your odd cc: list from?  This has nothing to =
do
> > > > with serial drivers...
> > > https://lore.kernel.org/all/0000000000000170df0605ccf91a@google.com/r=
aw
> >
> > I do not understand this answer.
>
> AIUI, the original report from syzbot "blamed" the serial maintainers.
> Not too sure how it determined that though, given the contents.
>

blame is too strong a word for that auto-inferred hint :)

Yes, the actual problem was in a totally different place, but FWIW
here's how it happened:

Statistically, stacktrace.c and a number of other generic locations
are rather unlikely to actually contain the bug (they can, but the
chances are that it's deeper in the call stack), so syzbot, while
traversing the stack trace, skipped all frames until

[<ffffffff80fa0c7e>] fn_show_state+0x1a/0x22 drivers/tty/vt/keyboard.c:614
[<ffffffff80fa1152>] k_spec drivers/tty/vt/keyboard.c:667 [inline]
[<ffffffff80fa1152>] k_spec+0xce/0x102 drivers/tty/vt/keyboard.c:656
[<ffffffff80fa306c>] kbd_keycode drivers/tty/vt/keyboard.c:1524 [inline]
[<ffffffff80fa306c>] kbd_event+0x5fa/0xa5e drivers/tty/vt/keyboard.c:1543

Per MAINTAINERS, these locations belonged to "TTY LAYER AND SERIAL
DRIVERS". Therefore serial in Cc.

The automation actually attributes a lot of reports correctly, but,
unfortunately, there are also tricky cases like this.

--=20
Aleksandr
