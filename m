Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229FE77822F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 22:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbjHJUch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 16:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235818AbjHJUce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 16:32:34 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373F6273E;
        Thu, 10 Aug 2023 13:32:33 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-cfcebc33d04so1171046276.2;
        Thu, 10 Aug 2023 13:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691699552; x=1692304352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CQxc+u3iDxJSVgZCdGW3SzvXU4ZeOvwOFjH9+bbTsE=;
        b=XpLkysDnToJy60fvr/s1/B4LQ+H77qzmt5uSyGnhBBdQnKPjgS6klvC05J/J5wVbAX
         xFsON3rDR1tGkgyCzqq83JnKbfmZH/Gn72GGlrdmv/lZDs40zUpHK7umaAP2Q/hSktmi
         ThiN38qVmHsUBK4c46+45ooHdVfYlbl7rfZ2BcWJZmuE8mDDWOdKjC7caNs71sDEicqD
         ukzdj10EGTlrGSIySNUdcEsEq24zv0W0Ri1KzoDZvEH7reUL42OCMVKh/aDLBIDxKnb9
         wBFN0ayc0P9Nkbq9OZ18jixwADbI962KrQ1NT2eZ3hf+SQ5RzxZ3AbxA/3CG5RpGMQH7
         qmdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691699552; x=1692304352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CQxc+u3iDxJSVgZCdGW3SzvXU4ZeOvwOFjH9+bbTsE=;
        b=WD95H1OlpE3aKISx5INyZYN/nk7I/lIoxNiPAVeVxO7s7RRdWqqyMUKybi9h9SKCzH
         2teibLUsPWd0MRe3ssox4QUZacGI3hoZM3bmKdu4qiOEEbiiXh7Ef1NKiZaBQFqGvhN1
         fIGgL9bNgFkASrLv370liZ6/lRZPTZCZrWpCTJSXrsksVSTZ4Z717xMwkiIKA6zV8kZT
         UT3KSOuc+hA8us01T4H7MrNO87pOhU/xoxvije1fEiG3JHXWTtN6VCQogcCJvB7UJx+y
         dycX+SLk0xyqgps0YaV2ug5law3hXJrKdRa3MQkE0BgbX249lsYEoRGV03VUdGmp3GNU
         hmIg==
X-Gm-Message-State: AOJu0Yx+WANb4OMf5W/7p8F/PKCei/Bs+g7Kkdw4h3IN1B8UNzKzdXxR
        20yGzvAOIcZeCI4deWnz4WcQWXMY0xFJnIFA2ik=
X-Google-Smtp-Source: AGHT+IGGR3RayPDzwnEdFC4HezL6qMRNC0H7IXe0gS86Y8feFO3JM4vwWzMY3bnnDx47jLG+faYskC80S4KOJMZ0orc=
X-Received: by 2002:a25:ab61:0:b0:d0a:353b:b939 with SMTP id
 u88-20020a25ab61000000b00d0a353bb939mr3788102ybi.52.1691699552440; Thu, 10
 Aug 2023 13:32:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230628171108.1150742-1-gary@garyguo.net> <CANiq72miVic=P+qSobuUqXoCuKW30_tT_buD8MyEsyVb_uoj6w@mail.gmail.com>
 <20230809230249.01ffc009.gary@garyguo.net> <CANiq72nWArGsvWVVknPdAVYUbWqJKfwOAVCRUmLnuAHAHP+rSQ@mail.gmail.com>
 <2023081043-cake-catwalk-1ba8@gregkh> <CANiq72=-NffQz9jMxoznoRGkeQz+1oTb6__r3c1z+BzOsWxfRw@mail.gmail.com>
 <2023081037-undertone-empathy-2ab6@gregkh>
In-Reply-To: <2023081037-undertone-empathy-2ab6@gregkh>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 10 Aug 2023 22:32:21 +0200
Message-ID: <CANiq72n03HZuduebASJ=Yk6m-e75humB7gonQC46vhcN8kSUug@mail.gmail.com>
Subject: Re: [PATCH] rust: macros: add `paste!` proc macro
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 5:46=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> If he, as the copyright owner, wants to take the code and do anything
> else with it, under any other license, they can.  There's nothing
> preventing them from doing that, a dual license is not needed (as long
> as you don't take any changes that anyone else made under a different
> license.)

Yeah, definitely. I imagine some developers have their reasons, e.g.
they may prefer to have the same one everywhere so that people reading
the code anywhere know it is more permissively licensed elsewhere (and
that dual license is popular for Rust projects).

> Which is one of the main reasons dual license isn't really needed, if
> the author wants the code to go somewhere else also, they are free to do
> so as they own the copyright.
>
> So please think carefully about mixing licenses like this, it's almost
> never needed, and keeping the files with multiple licenses is a major
> pain to handle over time.
>
> good luck!

Let's keep things simple then. I will replace it with `GPL-2.0` since
Gary was OK with that one too.

Thanks!

Cheers,
Miguel
