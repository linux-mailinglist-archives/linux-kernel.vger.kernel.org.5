Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E757E8F6F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 11:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjKLKEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 05:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjKLKD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 05:03:58 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021292D61;
        Sun, 12 Nov 2023 02:03:56 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2800bdf888dso2583376a91.1;
        Sun, 12 Nov 2023 02:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699783435; x=1700388235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s63k/oeUAOEiHqZXShqq4HE+liPGc+BR6jSLnDlt2us=;
        b=Yfs7L+Inx0WxENft2+lAnp2FmtsrIgU90g3TcxG25rUK8D5fLhMLcdfwiImKej4Xpr
         hfJmvjABEwdqtJVEyUqKuNJZ6eHKZTpg/pB12BmmHt/cLtoExroK00677vgSTq1Li4sw
         EPu+UR1a5j212F80oDL9nvRz0ACrhO6/XJ5JK1b7eAw/YQqQrhFJVnV0U+Eg4PPB+rcm
         kUmHjdcDmazgRsG0T+2VAlCvIuZ8EWMgOsXY5HGNKkVe3nZe2F+7Bxr3REHEErIp64US
         3V5CL8Mj95gUFKlPQL8tX+ZwYGjl6YyH1Fj+OlEvDvsSVtLFGZVBiPpDdZ/bPcy0iLYk
         0XNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699783435; x=1700388235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s63k/oeUAOEiHqZXShqq4HE+liPGc+BR6jSLnDlt2us=;
        b=MWN5Ota4BELEg0EEYwZHz3bAsBk+Gl+ZmmC6SoynmjvgfyIYMX43Ue+QHbg0rJWntW
         urHklodnBKDwLsu29ATZd+cwGluAOT1rTklTcp+EfOemA5JfIhjyPkh2EhqsBUwn+59/
         dIenrIOTf+7BqxRxVoIhCXcfeM91J/LWLvtMJ4+JYB5BAzB/LRL59IwCCzlOMMQhuSmX
         mJoyv2KuJcVX9PqIGs3QZCCrGAvwE65iHejppQwmdPr0gWsBX8IQGzsNhJXNvhB1kh1a
         jSPjsaj/OsCEfEVsHskdudDhYSf8MdSsKlwqtxvAecj49dn4tqU0U9X2rFO1CfioBtxX
         vaqw==
X-Gm-Message-State: AOJu0Yw/MeOS2zhLQ3V+Q6tQkLwzLqAxWlkur60GvjSZY69ChXRh2FNM
        oAOCGIvjBdjwe3kWOrx4qN72kb9Jy+CZz7G2V560/eMXVnjdtg==
X-Google-Smtp-Source: AGHT+IGjG5z/b7bhhJVnHm+C5wcylDhXbqxvoXWFwkHP0FCBrX04Rsqs1cPU5fFZGyv6mzEcoeIsosmaaPjliF60KOI=
X-Received: by 2002:a17:90b:4c51:b0:280:a002:be85 with SMTP id
 np17-20020a17090b4c5100b00280a002be85mr5987800pjb.20.1699783435348; Sun, 12
 Nov 2023 02:03:55 -0800 (PST)
MIME-Version: 1.0
References: <20231111125126.11665-1-yjnworkstation@gmail.com>
 <20231111132431.GA3717@1wt.eu> <CAHk-=whTZDjeH2FJqBozjAF44sh4XVNQrt2xdQn_Ujt=Be6=dw@mail.gmail.com>
In-Reply-To: <CAHk-=whTZDjeH2FJqBozjAF44sh4XVNQrt2xdQn_Ujt=Be6=dw@mail.gmail.com>
From:   Jasper Niebuhr <yjnworkstation@gmail.com>
Date:   Sun, 12 Nov 2023 11:03:43 +0100
Message-ID: <CAMjCObv9Z+Ood9QFA_jSQ2roSEE6C_ip=KeyoChmtyi97UoU7g@mail.gmail.com>
Subject: Re: [PATCH] exitz syscall
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Willy Tarreau <w@1wt.eu>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        "tytso@mit.edu" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2023 at 2:24=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, 11 Nov 2023 at 05:24, Willy Tarreau <w@1wt.eu> wrote:
> >
> > IMHO it does not make sense to add a syscall for this, please have a
> > look at prctl(2) instead, which is already used for similar settings.

First of all, I had a look and now absolutely agree with this.

> Honestly, I don't think it makes any sense at all.
>
> If the key manager people can't be bothered to keep track of their
> keys, the kernel certainly shouldn't be bothered with this kind of
> huge hammer.
>
> It looks like an active DoS attack to me, by anybody who just creates
> a huge process and then sits there giggling as the machine comes to a
> complete halt, with the kernel busy zeroing pointless crap.

Fair point.

Do you think it could make sense to enable zeroing on exit only for
ranges of memory (base + len) with a config dictating the max amount
of bytes (or pages or whatever) that a single process is allowed to
flag for zeroing? This way the DoS issue is effectively solved and the
config could always be set to 0 (by default I guess), which would
effectively leave any common system unchanged. The users that actually
want to use this feature could then decide on their own how much it is
worth to them and how big of a task they want the kernel to perform at
max on exit.

> Do it in user space. And if your user space randomly crashes, you have
> other problems - but you can try to use ptrace to catch even that case
> if you care.
>
>           Linus

Unfortunately, ptrace is something many, including me, disable on
systems that are meant to be as secure as possible.

Kind Regards,
Jasper
