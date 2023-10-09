Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729847BDC38
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376440AbjJIMfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346571AbjJIMfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:35:43 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEAF8F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 05:35:40 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-4527d65354bso1898774137.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 05:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696854939; x=1697459739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wOKyQdcpzYH1S2DyazYIOAoD7VFJ1kfohupYEjtWCjA=;
        b=Vq2buXPKPs+lTz5qet9MIBDSqx8oLhBQNKhUg3SCYZgF5x0V7hjcYID0zbJW7EADgT
         dmcgkyfuNm5I5WGA10uvMX1selKUEt6bW2CFPYvpvn7VavYnZTw3VWHpmtqHAYcOds77
         /e19jyyn1U+Ct2zsVfCF6jsU3WDlr0HQ2FtmplRKtXkl5Oxc50ODakHt2VMy+611dSMi
         xUyMlNLKXfDzXoWpGtnm6RVpf/v+DT5qy+m2ud2akIv9XmU9k6xknWYwj3SgiH2k6j2g
         +ffGxAS0Cx8ppKNDLYmZbonfbEDGDhII10eLX9nIhgWvTKysWvdJpyXGYuTIRXVdw4sC
         5xwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696854939; x=1697459739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wOKyQdcpzYH1S2DyazYIOAoD7VFJ1kfohupYEjtWCjA=;
        b=XG+/Joe6fRrzEB5SPiKagxrgD8REQBfAT3YXqlCvd4/0jUo5mhZbLbsY+YrSaH3jrA
         XmVZq9YSZFpyJCaGaRPeAgogXqIaQGrAFxJmgHbDtMl9ovz/30AjwNO1h272vzN0YaJk
         FtSe+oBphXjPMPGz+sKDrI3TjcOgsNJ54UQx0fqxXvi7zFyL2XzwiyzJ+AOJDuynEQ6g
         kZV4116BclWLPgc/h2YJj2R+CT3bUbiRnb6y5nvJQ70BXTtr9ry2yGUhWETndbpFDLvP
         vQKdYcRt1hM7+5wadq2+PrPxpH4F41tICMeqiPF3z7UedKNULDe91wLBTB4QFPf8Z4k0
         kivA==
X-Gm-Message-State: AOJu0YyakkSJVGfMKvc+0Cz9Na+NLikdhO/8mQgFMIONMnEe1Sma661F
        iC9Wke0PzGpSpiHS5Mn51StSsUSLN6B30F+VbO3fAg==
X-Google-Smtp-Source: AGHT+IEpyX0LBMZJRB6KI2ixkBt1XvV/E8Mxkh2tyDV96XdcIEKorle9qeJ5tkvEALrBkBNrzqtoEjdoTJvMRmuLNJg=
X-Received: by 2002:a05:6102:7c2:b0:44e:98d8:c62e with SMTP id
 y2-20020a05610207c200b0044e98d8c62emr12922722vsg.33.1696854939344; Mon, 09
 Oct 2023 05:35:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694625260.git.andreyknvl@google.com> <CA+fCnZckOM0ycja3-=08=B3jwoWrYgn1w91eT=b6no9EN0UWLw@mail.gmail.com>
In-Reply-To: <CA+fCnZckOM0ycja3-=08=B3jwoWrYgn1w91eT=b6no9EN0UWLw@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 9 Oct 2023 14:35:03 +0200
Message-ID: <CANpmjNNoBuNCf5+ETLOgMbjjYFT0ssfb4yyYL21XRrOgMc_mfg@mail.gmail.com>
Subject: Re: [PATCH v2 00/19] stackdepot: allow evicting stack traces
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        andrey.konovalov@linux.dev
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

On Thu, 5 Oct 2023 at 22:36, Andrey Konovalov <andreyknvl@gmail.com> wrote:
>
> On Wed, Sep 13, 2023 at 7:14=E2=80=AFPM <andrey.konovalov@linux.dev> wrot=
e:
> >
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > Currently, the stack depot grows indefinitely until it reaches its
> > capacity. Once that happens, the stack depot stops saving new stack
> > traces.
> >
> > This creates a problem for using the stack depot for in-field testing
> > and in production.
> >
> > For such uses, an ideal stack trace storage should:
> >
> > 1. Allow saving fresh stack traces on systems with a large uptime while
> >    limiting the amount of memory used to store the traces;
> > 2. Have a low performance impact.
> >
> > Implementing #1 in the stack depot is impossible with the current
> > keep-forever approach. This series targets to address that. Issue #2 is
> > left to be addressed in a future series.
> >
> > This series changes the stack depot implementation to allow evicting
> > unneeded stack traces from the stack depot. The users of the stack depo=
t
> > can do that via new stack_depot_save_flags(STACK_DEPOT_FLAG_GET) and
> > stack_depot_put APIs.
> >
> > Internal changes to the stack depot code include:
> >
> > 1. Storing stack traces in fixed-frame-sized slots; the slot size is
> >    controlled via CONFIG_STACKDEPOT_MAX_FRAMES (vs precisely-sized
> >    slots in the current implementation);
> > 2. Keeping available slots in a freelist (vs keeping an offset to the n=
ext
> >    free slot);
> > 3. Using a read/write lock for synchronization (vs a lock-free approach
> >    combined with a spinlock).
> >
> > This series also integrates the eviction functionality in the tag-based
> > KASAN modes.
> >
> > Despite wasting some space on rounding up the size of each stack record=
,
> > with CONFIG_STACKDEPOT_MAX_FRAMES=3D32, the tag-based KASAN modes end u=
p
> > consuming ~5% less memory in stack depot during boot (with the default
> > stack ring size of 32k entries). The reason for this is the eviction of
> > irrelevant stack traces from the stack depot, which frees up space for
> > other stack traces.
> >
> > For other tools that heavily rely on the stack depot, like Generic KASA=
N
> > and KMSAN, this change leads to the stack depot capacity being reached
> > sooner than before. However, as these tools are mainly used in fuzzing
> > scenarios where the kernel is frequently rebooted, this outcome should
> > be acceptable.
> >
> > There is no measurable boot time performance impact of these changes fo=
r
> > KASAN on x86-64. I haven't done any tests for arm64 modes (the stack
> > depot without performance optimizations is not suitable for intended us=
e
> > of those anyway), but I expect a similar result. Obtaining and copying
> > stack trace frames when saving them into stack depot is what takes the
> > most time.
> >
> > This series does not yet provide a way to configure the maximum size of
> > the stack depot externally (e.g. via a command-line parameter). This wi=
ll
> > be added in a separate series, possibly together with the performance
> > improvement changes.
>
> Hi Marco and Alex,
>
> Could you PTAL at the not-yet-reviewed patches in this series when you
> get a chance?

There'll be a v3 with a few smaller still-pending fixes, right? I
think I looked at it a while back and the rest that I didn't comment
on looked fine, just waiting for v3.

Feel free to send a v3 by end of week. I'll try to have another look
today/tomorrow just in case I missed something, but if there are no
more comments please send v3 later in the week.
