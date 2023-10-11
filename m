Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8E37C5DB9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 21:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbjJKTho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 15:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbjJKThn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 15:37:43 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555F194
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 12:37:41 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bfea381255so2158591fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 12:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697053059; x=1697657859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+nxnVpiM3o14l/Rgg417z4BoDoY7palXmupEnQUxLo=;
        b=dkoK30QIascnQGsPTJ9vdyocB240dmqozB87OJeDdGRRfRsnMYa3QbFDcqrhELJsQz
         egjAprSCsWciIUx8Oceti1iewgvOa8vQbB3kbSv2j8/43EVEs6QqV7+YWcDQmQiOd2T/
         Cr3PdkMrqlSZTnj5oumlP2asYwMazm2GH8YMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697053059; x=1697657859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5+nxnVpiM3o14l/Rgg417z4BoDoY7palXmupEnQUxLo=;
        b=Ara9qaZMhBPX6KyjdibbwTLS2QfHSn9fntc9JlxFXdvhRSJqq5G7sswBbivcbuvLXs
         BI3yxM+oIGRfgpqTEWT6qdhwnsjF/EEX+IU3j7uEdnLTwZXm1BBV90/leoLMcA4CA0XK
         aZEd0Mue8QllJGqDK0R2MDLXIV+nbaO22erJ4QGikaN4qxPPrPx2TamHBCBDo3s+D5E2
         rdh+4u51cH4pg8DjxlQv40Hsc9il7HjqMcZVdLF9vFkXQbLzlfjwVVHgdYALn+nA6Jvo
         A9iqzGwqHWRW3Ymh7NHzDDlStifxf3XMOP0ecm9RHb7v3gouRr1nefAU5bTgJ4woE8lP
         KZYA==
X-Gm-Message-State: AOJu0YybPLVxRpSo2AVshqDzY3AvY+Zh3gXvoDrooS/6SAv2S6RnZED/
        IUSMnvUfu+gjNBVFSd5mbB/8JDuRiUSbxLI2Vms=
X-Google-Smtp-Source: AGHT+IH7dG0f+uP8pb0fR0CTvFYLeuTTNIPXIUTTWV6PzYV7vWZriRhUTVScp7VZNv6hWSz2JxzzJA==
X-Received: by 2002:a05:6512:3b9d:b0:506:9c0a:17cc with SMTP id g29-20020a0565123b9d00b005069c0a17ccmr9585404lfv.33.1697053059443;
        Wed, 11 Oct 2023 12:37:39 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id n30-20020ac2491e000000b004fb7359ab83sm2398797lfi.80.2023.10.11.12.37.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 12:37:37 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-505748580ceso299937e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 12:37:37 -0700 (PDT)
X-Received: by 2002:a05:6512:2022:b0:502:a4f4:ced9 with SMTP id
 s2-20020a056512202200b00502a4f4ced9mr17060350lfs.62.1697053057281; Wed, 11
 Oct 2023 12:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <20231010164234.140750-1-ubizjak@gmail.com> <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com> <F48A9D34-3627-4372-B555-B58CBFC3F241@vmware.com>
In-Reply-To: <F48A9D34-3627-4372-B555-B58CBFC3F241@vmware.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Oct 2023 12:37:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjF4gzCZKh-zN-sY0WpX1kCo+s9gYE9sOcSv0QieH1dwQ@mail.gmail.com>
Message-ID: <CAHk-=wjF4gzCZKh-zN-sY0WpX1kCo+s9gYE9sOcSv0QieH1dwQ@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Nadav Amit <namit@vmware.com>
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023 at 00:42, Nadav Amit <namit@vmware.com> wrote:
>
> You are correct. Having said that, for =E2=80=9Ccurrent" we may be able t=
o do something
> better, as regardless to preemption =E2=80=9Ccurrent" remains the same, a=
nd
> this_cpu_read_stable() does miss some opportunities to avoid reloading th=
e
> value from memory.

It would be lovely to generate even better code, but that
this_cpu_read_stable() thing is the best we've come up with. It
intentionally has *no* memory inputs or anything else that might make
gcc think "I need to re-do this".

For example, instead of using "m" as a memory input, it very
intentionally uses "p", to make it clear that that it just uses the
_pointer_, not the memory location itself.

That's obviously a lie - it actually does access memory - but it's a
lie exactly because of the reason you mention: even when the memory
location changes due to preemption (or explicit scheduling), it always
changes back to the the value we care about.

So gcc _should_ be able to CSE it in all situations, but it's entirely
possible that gcc then decides to re-generate the value for whatever
reason. It's a cheap op, so it's ok to regen, of course, but the
intent is basically to let the compiler re-use the value as much as
possible.

But it *is* probably better to regenerate the value than it would be
to spill and re-load it, and from the cases I've seen, this all tends
to work fairly well.

                 Linus
