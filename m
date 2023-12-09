Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F60680B105
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 01:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574883AbjLIAcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 19:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLIAcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 19:32:10 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81664171F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 16:32:15 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-54f4b31494fso2652984a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 16:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1702081934; x=1702686734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1zT0rCjQnlmdumiyzNm0Bt66rnvFVXBVNpL6Z+0PSGU=;
        b=Xndo2N/gbFNiGTtK1y4uXddtpuNIFZbrZAO56XYKi1zVNWoTcO1q0uze++KqzM/gAH
         gvK6JPY0NsZW35A675Ttz/P9LfdffVF3L8jpxl5smCQfnLj+P9xSRr1hk2u2/Ko5tOW2
         aR4xG7jvCT7mqSJbfzWCl03tMYk+ARa0l4HKXUziXcZ8P/9LT8Z1rS7BYLJxrApX8NIH
         6aA722XzJb4ADBX3/pgLRucfKYjtM6tWUFnADiy6HmsFgqbXerAFHTB+JIHYC5HCIbX3
         qYhTutNvESdZRTKEOOuoOzv3gdwQbe1SO8mCrwBYR5gONxBWHOCntSylh0QCIpOkRxn3
         AUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702081934; x=1702686734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1zT0rCjQnlmdumiyzNm0Bt66rnvFVXBVNpL6Z+0PSGU=;
        b=DmiFfy9fSqTQTnhlfzyNLElfUMWlTz10FF2efczpR5IA7C6noyhh7JqbcHaNclJKj6
         8UzStyJuKFGkUD7VBhHStwad7wAatbHkY2L7E5erWyLzB3qahy/Ohigw75dDd8dA+l24
         EYLyRM6flteiTwBhqXd22PINfswihLiBia9Iq7wNZTIn3w30oEsbdTA1h+Q5ik0WeRPZ
         xL3g/9kFvKv+EkaaPOyhymmukyFI/JFgUN0MmNCXUrLS9MZoaG3Tte0ieUzS8qWmGWgf
         8ll2g+hbhTUMgG09hdKllI3ypZGwonHdK2gmvOnpY9jvnlHrqeP8NPDnDj10VZ5h9rMt
         TDfQ==
X-Gm-Message-State: AOJu0Yys3T5J6SaIC7R9g2yjoS5QSUa9ARAL1c+05lV/iVc4fPmi7K3s
        WyoFWsHrvQ23YrP5P4j1PeZMnyhnu/4k99QGMnLz
X-Google-Smtp-Source: AGHT+IHHb4/CFDSdSGL8ku4sXTz/Zuz2NMj3PRlJS7BVAcYDz1wSEC/dafG8SMRguuuWdu5DWmvagPzV0dmMARmwM9Y=
X-Received: by 2002:a50:ccd3:0:b0:54c:6d4c:62cb with SMTP id
 b19-20020a50ccd3000000b0054c6d4c62cbmr899546edj.15.1702081933364; Fri, 08 Dec
 2023 16:32:13 -0800 (PST)
MIME-Version: 1.0
References: <CAK8ByeK8dGcbxfXghw6=LrhSWLmO0a4XuB8C0nsUc812aoU0Pw@mail.gmail.com>
 <cover.1701993656.git.jim.cromie@gmail.com> <5351f56289add68eee2aa5288f82a313c2b9f664.1701993656.git.jim.cromie@gmail.com>
In-Reply-To: <5351f56289add68eee2aa5288f82a313c2b9f664.1701993656.git.jim.cromie@gmail.com>
From:   =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Date:   Sat, 9 Dec 2023 01:32:02 +0100
Message-ID: <CAK8Bye+3RbUESCTso8ZVAojd9WDoqH1SbC+WF-ALi+cwsKLp9g@mail.gmail.com>
Subject: Re: [re: PATCH v2 00/15 - 08/11] dyndbg: split multi-query strings
 with %
To:     Jim Cromie <jim.cromie@gmail.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 8 gru 2023 o 01:15 Jim Cromie <jim.cromie@gmail.com> napisa=C5=82(a):
>
> Multi-query strings have long allowed:
>
>   modprobe drm dyndbg=3D"class DRM_UT_CORE +p; class DRM_UT_KMS +p"
>   modprobe drm dyndbg=3D<<EOX
>      class DRM_UT_CORE +pmf
>      class DRM_UT_KMS  +pmf
>   EOX
>
> More recently, the need for quoting was avoided by treating a comma
> like a space/token-terminator:
>
>   modprobe drm dyndbg=3Dclass,DRM_UT_CORE,+p\;class,DRM_UT_KMS,+p
>
> But that leaves unfinished business; that semi-colon needs escaping,
> and thats not robust to further string interpolation.  In particular,
> it fails when passed to vng (virtme-ng).
>
> So this patch adds '%' to the existing ';' and '\n' multi-cmd
> separators, which is more shell-friendly, and avoids quoting and
> escaping hassles.
>
>   modprobe drm dyndbg=3Dclass,DRM_UT_CORE,+p%class,DRM_UT_KMS,+p
>
> NOTE: it does alter/break this (ill conceived) search:
>
> [root@v6 lx]# ddcmd format %s +p
> [   38.170998] dyndbg: read 13 bytes from userspace
> [   38.171542] dyndbg: query 0: <format > on module: <*>
> [   38.172011] dyndbg: bad flag-op f, at start of format
> [   38.172487] dyndbg: flags parse failed
> [   38.172839] dyndbg: query 1: <s +p> on module: <*>
> [   38.173285] dyndbg: expecting pairs of match-spec <value>
> [   38.173791] dyndbg: query parse failed
> [   38.174141] dyndbg: processed 2 queries, with 0 matches, 2 errs
> bash: echo: write error: Invalid argument
>
> In trade for that minor format selection limitation, we get to do:
>
>   vng -v --user root -p 4 \
>       -a dynamic_debug.verbose=3D3 \
>       -a drm.debug=3D0x15 \
>       -a i915.dyndbg=3Dclass,DRM_UT_CORE,+pfmlt_%class,DRM_UT_KMS,+pfml
>   modprobe drm
>   modprobe i915
>
> NOTES/TLDR:
>
> In this example, using both drm.debug & drm.dyndbg is mostly for
> testing.  Using drm.debug is preferred, because the drivers all
> explicitly depend on that input/control-point, so settings there are
> propagated to drivers.
>
> But more to the point, drm.dyndbg explicitly limits the query to drm.
> In fact, you could pass a module wildcard in the above, and achieve
> the same thing:
>
>   vng -v --user root -p 4 \
>       -a dynamic_debug.verbose=3D3 \
>       -a \*.dyndbg=3Dclass,DRM_UT_CORE,+pfmlt_%class,DRM_UT_KMS,+pfm%clas=
s,DRM_UT_ATOMIC,+pf
>
> ':' would be a more natural multi-cmd separator, but is reserved
> for +T:<trace_buf> to designate separate tracebuf instances.
>
> If '%' is distasteful, the backup plan is ",_,", since that would
> never appear in a useful <format "$foo"> cmd.
>

What if we use a different character for passing trace instance name
to the T flag, for example "-", +T-trace_buf
and then use ":" instead of "%" as a separator ?



> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
>  lib/dynamic_debug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index c974f6e19ca1..0ca3ba9e2032 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -963,7 +963,7 @@ static int ddebug_exec_queries(char *query, const cha=
r *modname)
>         int i, errs =3D 0, exitcode =3D 0, rc, nfound =3D 0;
>
>         for (i =3D 0; query; query =3D split) {
> -               split =3D strpbrk(query, ";\n");
> +               split =3D strpbrk(query, "%;\n");
>                 if (split)
>                         *split++ =3D '\0';
>
> --
> 2.43.0
>
