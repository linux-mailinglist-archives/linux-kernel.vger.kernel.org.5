Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7449806185
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 23:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346469AbjLEWPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 17:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjLEWPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 17:15:01 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F011BD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 14:15:07 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3331752d2b9so104216f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 14:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701814506; x=1702419306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DD0DNj25uBQ/C17oozD5v/SE0XLXNTxkbhUNY2hqqrE=;
        b=ldrO/XOwjHG4NlObybD1T3211udZtIX/tDNFD/piT/AP0GDM1xWEGR0fa/dHGc8aM5
         JVDo6gwVV08L8Lr7x3ZAogx3GCdZO9WKx+viltHtZeoC83twY1YdyuBXzJbsLYPPb3wi
         ss4uAibjvdpjfj2WMCR7/ZfqIPoHSfyinM6Dej8SZ4daIfadWQ0oefYHDokFSiHylgRv
         qHr/UgQYR+Zy7EcKlcf/TbmttJKHj0RVZZV/a3s7H0s69JFO6IbrTsx/ajZudQ0+EbNx
         dkhBCD0ViB5JNduxBU+Hw8xjBliYME728gTgNdlma/6qiZEwMiuxTD3DeQbA8KxtZeAN
         As3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701814506; x=1702419306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DD0DNj25uBQ/C17oozD5v/SE0XLXNTxkbhUNY2hqqrE=;
        b=ndxnrym1/UVzYbachTusvnIlLnO6R4Gdg/fthbHCeHf4nlMtJIBnGuq0BUSkxRQZv3
         7k2IyBupvAW+VyVlKj9vR3wMgzwKO+RWCCLpXzBGUhtvI42+nyCElj/F36UyeWWYVFOe
         BGB6Eo0owAfidfR7CKtGq4TrKiyb9mxCUlHwd8uss0BEoV8qF4Fd8MW1lTgVhXj44oeY
         3O/hTVJYo/iTOht5oOz7/AwBQO6IDwp0mAr4LZttpf1h7c+evOr7+8TuaFThGZqoVR+G
         kMoyj+IIQr3OMDT8woiXJ9jZ2ZGD9rbZZRiGwHxBU18RtKNIEKUB6oxYODZkJ3nhw9K+
         1m/Q==
X-Gm-Message-State: AOJu0YykwabmnamsCB1xdeob9ArXPDcyor8cPz2giYTVJTse4rrdpBi5
        vatJSPeWvQM8vKPD8TYzilbD09KPf1GunSgFYStVsg==
X-Google-Smtp-Source: AGHT+IEIuFKrkoFvYNzPlxheppKvhm+ftQtjTc7AwFMq9skdDpEb1ZX2PjA9ALQOqeclZUUHHQS+hx4qWH0scPlWAGg=
X-Received: by 2002:adf:f18f:0:b0:32f:7c6c:aa14 with SMTP id
 h15-20020adff18f000000b0032f7c6caa14mr6218857wro.37.1701814506175; Tue, 05
 Dec 2023 14:15:06 -0800 (PST)
MIME-Version: 1.0
References: <20231205-libstringheader-v1-1-7f9c573053a7@gmail.com>
 <20231205213807.GE1674809@ZenIV> <CAKwvOd=2VASkaLvjU+7kkbvhu2CimYn5KUGJBDRePyUhtrNK2Q@mail.gmail.com>
 <2023120608-ivy-snowdrop-890d@gregkh>
In-Reply-To: <2023120608-ivy-snowdrop-890d@gregkh>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 5 Dec 2023 14:14:55 -0800
Message-ID: <CAKwvOdmFJ=ZGN8ZScS5oQpXnAL0wwtTDCeNNGpBKZXzQ4kRAVA@mail.gmail.com>
Subject: Re: [PATCH] lib/string: shrink lib/string.i via IWYU
To:     Greg KH <greg@kroah.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, tanzirh@google.com,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick DeSaulniers <nnn@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 5, 2023 at 1:59=E2=80=AFPM Greg KH <greg@kroah.com> wrote:
>
> On Tue, Dec 05, 2023 at 01:51:10PM -0800, Nick Desaulniers wrote:
> > On Tue, Dec 5, 2023 at 1:38=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk=
> wrote:
> > >
> > > It also breeds includes of asm/*.h, by the look of the output, which =
is
> > > not a good thing in general ;-/  E.g. #include <asm/uaccess.h> *anywh=
ere*
> > > outside of linux/uaccess.h is a bad idea.
> >
> > It's not clear to me when it's ok to #include <asm/*.h>.  Is there a
> > convention here that I'm missing?
>
> General rule, NEVER include asm/*.h, there should be a include/*.h
> instead that works.  So much so that checkpatch.pl should catch this,
> right?

ah, shoot, I was showing Tanzir how to use `b4` for patch development,
and forgot to check this.  Indeed it does.

I can see how the check works (scripts/checkpatch.pl L5881).  Decoding
that will probably help us improve the tooling.

>
> But of course, it doesn't always hold true, there are a few minor
> exceptions, but they are rare.

$ grep -r \\#include lib | grep asm

shows quite a few exceptions, and just in lib/.

For example, lib/math/int_log.c includes asm/bug.h.  Is that a case
where lib/math/int_log.c should be #include 'ing linux/bug.h rather
than asm/bug.h?
--=20
Thanks,
~Nick Desaulniers
