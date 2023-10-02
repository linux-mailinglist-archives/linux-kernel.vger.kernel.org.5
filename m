Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11257B5AFA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 21:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238589AbjJBTNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 15:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238726AbjJBTNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 15:13:07 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B81B0
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 12:13:04 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-664bd97692dso745346d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 12:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696273984; x=1696878784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UrdshLJ6yY4TrRO+7HKqgHBt/I+RLSjFGYVl7KEYqTI=;
        b=V5rIdH3ABQqrWkOcHPHfk4puVfhnzUPZfwFbZDn+fRkjIss08Om0Vok5ClfLFkLj9L
         MPsLqndLZEY0PBXsyRSohdb9EdVIHtO3Et6E8InO8V2U/VaUzgcR9fSm9ZWq49lyJj5P
         0XOF3qSDOItqY8P51toknL5em6vD3gKWSE2c8JhvqrnUsblh4byV2tWaHYB+WrPrBVnQ
         ihcegEmZtLT5ate82ZbfUqTakN0ejz8WACcbefFTItNoIUsedYeHoOivF4ryjVrT2xoF
         odbGl1ECUipomhK71avc0fHHVAVYaMA2eUC9UVhfCEmphVKPvBh/wPegJUnaTKrpJDl7
         szxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696273984; x=1696878784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UrdshLJ6yY4TrRO+7HKqgHBt/I+RLSjFGYVl7KEYqTI=;
        b=J8JJSj8hyrskVKs8JTB/PMYa9BwJsAI1HMrBvOYMY3AJueLd5feb03AsQwEQmmelGC
         UG6IiZk/2dpeOQcCjhHWMPYN47xQpZWOMPuUonxgLH4U4dLgzdI2W1jad4Nw5j8COctE
         nTL+ypdQIaM0D2gD9eggPKgZWmlkHpR+IM4Rn3yRf6c0lqef5YdWnh2ezfvNbm5OcCsl
         I+6fzYKMDjSE+e1AakbUsePNK6kEWvmgDSAsreWynwLhktFbRDXIS4hHrihZuf+hd6nA
         VG4Yy1ZaGnI4VGBzXaj2x3iFgrb8Xo9vEJC54GbqqaY6Rw4n1lBFHFdGHaMuEQf/zxIx
         J56g==
X-Gm-Message-State: AOJu0YwZf8ujQgwN3EZC83HKK27DQ/S2o3ySbBqG+3Aoiu+u8jEbJ4iF
        byPMBY5urvQPJsGyXcfW5piIOjpECsFwfW6XJieyEA==
X-Google-Smtp-Source: AGHT+IH1wn5ECQeHv7HdplVxaqOth1RWCOBlGsjk711xwfVqBlnsjjZuBUv1oJq5F0LPcPyQSrvzzHrEmFhKsEkZkSQ=
X-Received: by 2002:a0c:b541:0:b0:655:ea8d:666d with SMTP id
 w1-20020a0cb541000000b00655ea8d666dmr11587167qvd.44.1696273983581; Mon, 02
 Oct 2023 12:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230808030357.1213829-1-kolyshkin@gmail.com>
In-Reply-To: <20230808030357.1213829-1-kolyshkin@gmail.com>
From:   enh <enh@google.com>
Date:   Mon, 2 Oct 2023 12:12:48 -0700
Message-ID: <CAJgzZooaa7m01KMnL+jHPLCX-Gqtps0ZqxhU7q6ai3OXdNzAgA@mail.gmail.com>
Subject: Re: [PATCH] sched/headers: move struct sched_param out of uapi
To:     Kir Kolyshkin <kolyshkin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, libc-alpha@sourceware.org,
        musl@lists.openwall.com, linux-api@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>
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

On Mon, Aug 7, 2023 at 8:04=E2=80=AFPM Kir Kolyshkin via Libc-alpha
<libc-alpha@sourceware.org> wrote:
>
> Both glibc and musl define struct sched_param in sched.h, while kernel
> has it in uapi/linux/sched/types.h, making it cumbersome to use
> sched_getattr(2) or sched_setattr(2) from userspace.
>
> For example, something like this:
>
>         #include <sched.h>
>         #include <linux/sched/types.h>
>
>         struct sched_attr sa;
>
> will result in "error: redefinition of =E2=80=98struct sched_param=E2=80=
=99" (note the
> code doesn't need sched_param at all -- it needs struct sched_attr
> plus some stuff from sched.h).

note that `struct sched_attr` is still pretty problematic for
userspace because it keeps changing. i (Android's bionic libc
maintainer) get pretty frequent complaints about the lack of a wrapper
for this in libc, but that doesn't seem plausible if it keeps
changing. worse than that, we do find projects copy & pasting `struct
sched_attr` (ltp, for example), which causes problems when bionic --
which uses the latest released uapi headers directly -- and those
projects' duplicates don't match.

it would be helpful (or at least "less problematic") if each new
variant was called sched_attr_v1, sched_attr_v2 etc.

ironically, the end result of the requests for `struct sched_attr` to
be in <sched.h> and to have wrappers for the syscalls is that i'm
seriously considering _removing_ `struct sched_attr` from our uapi
headers [because when i said we use them "directly", they do actually
go through a python script] on the assumption that "everyone just
carries around the specific version they want, and no-one has to worry
about ABI differences" is less problematic than the current situation.

(to be clear: personally i've only seen source incompatibility.
although one _could_ pass `struct sched_attr` across library
boundaries and have ABI incompatibility, i haven't yet seen that.
unless you count "that's the reason why there's no libc wrapper for
this syscall, despite it being by far my most-demanded syscall
wrapper".)

> The situation is, glibc is not going to provide a wrapper for
> sched_{get,set}attr, thus the need to include linux/sched_types.h
> directly, which leads to the above problem.
>
> Thus, the userspace is left with a few sub-par choices when it wants to
> use e.g. sched_setattr(2), such as maintaining a copy of struct
> sched_attr definition, or using some other ugly tricks.
>
> OTOH, struct sched_param is well known, defined in POSIX, and it won't
> be ever changed (as that would break backward compatibility).
>
> So, while struct sched_param is indeed part of the kernel uapi,
> exposing it the way it's done now creates an issue, and hiding it
> (like this patch does) fixes that issue, hopefully without creating
> another one: common userspace software rely on libc headers, and as
> for "special" software (like libc), it looks like glibc and musl
> do not rely on kernel headers for struct sched_param definition
> (but let's Cc their mailing lists in case it's otherwise).

getting back to your actual point about `struct sched_param`, yes,
this sgtm too. bionic has the exact same <sched.h> vs
<linux/sched/types.h> duplication.

> The alternative to this patch would be to move struct sched_attr to,
> say, linux/sched.h, or linux/sched/attr.h (the new file).

as long as everyone promises never to change `struct sched_param`,
that would be my personal preference --- my _ideal_ is that i never
define anything that's uapi and get it "direct" from the [very lightly
modified] upstream uapi headers instead.

> Oh, and here is the previous attempt to fix the issue:
> https://lore.kernel.org/all/20200528135552.GA87103@google.com/
> While I support Linus arguments, the issue is still here
> and needs to be fixed.
>
> Cc: libc-alpha@sourceware.org
> Cc: musl@lists.openwall.com
> Cc: linux-api@vger.kernel.org
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Christian Brauner <brauner@kernel.org>
> Fixes: e2d1e2aec572 ("sched/headers: Move various ABI definitions to <uap=
i/linux/sched/types.h>")
> Signed-off-by: Kir Kolyshkin <kolyshkin@gmail.com>
> ---
>  include/linux/sched.h            | 5 ++++-
>  include/uapi/linux/sched/types.h | 4 ----
>  2 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 609bde814cb0..3167e97a6b04 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -63,7 +63,6 @@ struct robust_list_head;
>  struct root_domain;
>  struct rq;
>  struct sched_attr;
> -struct sched_param;
>  struct seq_file;
>  struct sighand_struct;
>  struct signal_struct;
> @@ -370,6 +369,10 @@ extern struct root_domain def_root_domain;
>  extern struct mutex sched_domains_mutex;
>  #endif
>
> +struct sched_param {
> +       int sched_priority;
> +};
> +
>  struct sched_info {
>  #ifdef CONFIG_SCHED_INFO
>         /* Cumulative counters: */
> diff --git a/include/uapi/linux/sched/types.h b/include/uapi/linux/sched/=
types.h
> index f2c4589d4dbf..90662385689b 100644
> --- a/include/uapi/linux/sched/types.h
> +++ b/include/uapi/linux/sched/types.h
> @@ -4,10 +4,6 @@
>
>  #include <linux/types.h>
>
> -struct sched_param {
> -       int sched_priority;
> -};
> -
>  #define SCHED_ATTR_SIZE_VER0   48      /* sizeof first published struct =
*/
>  #define SCHED_ATTR_SIZE_VER1   56      /* add: util_{min,max} */
>
> --
> 2.41.0
>
