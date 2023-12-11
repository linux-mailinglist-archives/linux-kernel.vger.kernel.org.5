Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F27A80BEAC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 02:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjLKBHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 20:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjLKBHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 20:07:32 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AD9D0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 17:07:38 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-466029f2d3eso1007214137.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 17:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702256857; x=1702861657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAr82kwugtzbxXQbspSiybQChUgC2XA6qNuMpS37s/E=;
        b=gjPirvrjZdgPyt6RyJVdLSWyYqvktLe+55nilnBZKAVQ0aJUoNooiaVdC238HQ5ESE
         2NfwY7CL9ePu1HHnUpLQWk/qfklxv5Sb0RmTdMfX8JFhwAYT/VvLqsFsz5H4w2gJpiw0
         A6vOn59O0Fjsx9KB2tQKxPlpxVYC/aa37cQKB3LwJxOWLvekL7dyEqQ+BAtXTcaPVy1c
         +ErPfYCt84f4caWVDjcUEAq0LZIj5OMQgpTk464EBkpRpMzLPircEP3b+TkRHPV4zlpR
         xMD+kA+blbJIC07xWBW5m3QCBwr2KTSPqDUp8Sm9xayQXfhJlfHO1YEEh2szUT80DzqW
         z/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702256857; x=1702861657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VAr82kwugtzbxXQbspSiybQChUgC2XA6qNuMpS37s/E=;
        b=XvALgLKh8NnqQ2E/jYEINzno7VuWXKb7lHjDk4I7xza+yFCH21UgfOgz5zk6AVZ3uR
         iQ95W+Om6bfUQf5eVHIZk7ehBSxMoujYzzjfbd8oaI54YG1OhFB5w+akZU06HnuvXzIa
         hf+lYiVinSGjIiMKu+wXGajuwgcnnLToxgxv7e2eBNm4H2EQ2TQSxtMtfuWroLFbVwR1
         ONwB+F+MaFOF1wAbzBCBGsegMzR6ieS8mmmWIZiaYUo8/5mZci5frbMP+HyDRfYky7Yc
         +3psIqOrktJiVbKKDNbHrl34DFCfdbdhQgx8bZ+dd9iMKnKT9jEAUcgC6cxu2OB0FRkF
         PBPQ==
X-Gm-Message-State: AOJu0Yz0ft6JXPY6hi+8ZQfMgeoQOZw2ac1j9kY32BF0ZpiePZER0sAq
        aNvSgzXZmOse7IkfKLS++Wdwgz5vCaQmDUinNMk=
X-Google-Smtp-Source: AGHT+IGkPH3SE6E+TABP5Ms8zK+Py/f+bzaFM2kAnDmJCjVieDd/pJjFBB/A5qN++FVVgnhF3phi08C6kC99w61gemI=
X-Received: by 2002:a67:ba0a:0:b0:464:77f2:55f with SMTP id
 l10-20020a67ba0a000000b0046477f2055fmr2286225vsn.49.1702256857438; Sun, 10
 Dec 2023 17:07:37 -0800 (PST)
MIME-Version: 1.0
References: <CAK8ByeK8dGcbxfXghw6=LrhSWLmO0a4XuB8C0nsUc812aoU0Pw@mail.gmail.com>
 <cover.1701993656.git.jim.cromie@gmail.com> <5351f56289add68eee2aa5288f82a313c2b9f664.1701993656.git.jim.cromie@gmail.com>
 <CAK8Bye+3RbUESCTso8ZVAojd9WDoqH1SbC+WF-ALi+cwsKLp9g@mail.gmail.com>
In-Reply-To: <CAK8Bye+3RbUESCTso8ZVAojd9WDoqH1SbC+WF-ALi+cwsKLp9g@mail.gmail.com>
From:   jim.cromie@gmail.com
Date:   Sun, 10 Dec 2023 18:07:11 -0700
Message-ID: <CAJfuBxxYDzL5jkJb6A=sk4qibw4KPrhOvatfBikVqRYx=6WAMA@mail.gmail.com>
Subject: Re: [re: PATCH v2 00/15 - 08/11] dyndbg: split multi-query strings
 with %
To:     =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        bleung@google.com, contact@emersion.fr, daniel@ffwll.ch,
        dianders@chromium.org, groeck@google.com, jbaron@akamai.com,
        john.ogness@linutronix.de, keescook@chromium.org, pmladek@suse.com,
        ppaalanen@gmail.com, rostedt@goodmis.org, seanpaul@chromium.org,
        sergey.senozhatsky@gmail.com, upstream@semihalf.com,
        vincent.whitchurch@axis.com, yanivt@google.com,
        gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 8, 2023 at 5:32=E2=80=AFPM =C5=81ukasz Bartosik <lb@semihalf.co=
m> wrote:
>
> pt., 8 gru 2023 o 01:15 Jim Cromie <jim.cromie@gmail.com> napisa=C5=82(a)=
:
> >

> >   vng -v --user root -p 4 \
> >       -a dynamic_debug.verbose=3D3 \
> >       -a \*.dyndbg=3Dclass,DRM_UT_CORE,+pfmlt_%class,DRM_UT_KMS,+pfm%cl=
ass,DRM_UT_ATOMIC,+pf
> >
> > ':' would be a more natural multi-cmd separator, but is reserved
> > for +T:<trace_buf> to designate separate tracebuf instances.
> >
> > If '%' is distasteful, the backup plan is ",_,", since that would
> > never appear in a useful <format "$foo"> cmd.
> >
>
> What if we use a different character for passing trace instance name
> to the T flag, for example "-", +T-trace_buf
> and then use ":" instead of "%" as a separator ?
>

*** entering the Bikeshed ***

One of the nice constraints of the flags-val is that it always starts with =
+/-/=3D
the 1st char of flags is the only place they would appear unquoted.
using '-' again dilutes that specialness.

the whole +T:named_stream. syntax has a mnemonic value,
it seems to explain itself (but I'm weird)

WRT to ':' vs '%' as multi-cmd separator, what do we lose in each trade ?
ultimately it invalidates a query containing those chars. IOW

  # impossible query when cmd-splitting on %
  echo format "search for %s because %d" +p > /proc/dynamic_debug/control

  # impossible when splitting on :
  echo format "my_label: " +p > /proc/dynamic_debug/control

NB: only format would see an arg with either : or %, since theyre
*never* in filenames, functions or module (or class) names.

Of the 2, % is even more unlikely to wind up in a name,
colon already appears in host:path and urls,
and in some class-name systems
(tho not planned for "class" keyword)

the ability to search for colon-terminated labels seems more useful
than searching for a particular set of printf format specifiers,
which btw cant have colons between them.
