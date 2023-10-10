Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F497C039B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 20:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbjJJSlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 14:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234123AbjJJSlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 14:41:45 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092A7AC
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 11:41:42 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53627feca49so9986268a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 11:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696963300; x=1697568100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrDykPNOztjeY31ZVQWWVQc0urUqz95uIAKgkC/bOGw=;
        b=Xc7OFsVuUNszyKaK9wtr1cV08zFDz/2ZgSdlY6I554X/ZZg/J6JWCKHcsTwCWikNwt
         h3blVrhuMjWz9QzyTpuHu+fF4a81XxPpz0lVUF4pob0kEQ40Jm/78vg0dP9guGufCfkU
         ltgLuhqkMlEcTxHUXx8lgIw03CfHZGwf9ExLzy/irwqxLJDGOs3xXifLuHkb8TN9W2H5
         aXcyogJ3Lo7Dw4ovDB0qokceJX5PxrRRVi3QelEk0gn5bm48aZwX7jUjhofs/Jifybpu
         Dqmznxd+F3g1+mG+prkVwHR5MufjennhyQagf16SU0oHfeJ5tDmmHiUXAQzdlDg5uNBE
         qoyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696963300; x=1697568100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VrDykPNOztjeY31ZVQWWVQc0urUqz95uIAKgkC/bOGw=;
        b=kuLagZ6X1weAwMZta+J4WDo1qBqb57YeCje912tou6jRnwQGVGwt7Hk/LlfKfnGukP
         seQjswO8TfgMf+765BC5A5HtRFuK8wd3cmYD9MYZq/06/74Z4G8+8DRm9E/CK7ViC5N6
         v3ygvkZRSgQWPLQkGm3oFjym+t0hC8waJaQwGyD9h3ZIO4JsFmWnu5T+mCxM640h9mF0
         ecHYkkSOGRlMXbzw9tnQUHA7rSKNp+C0KmWh2aVAWnkCORfoosbBSxAlWTTRlOV//XOn
         dWn7FMy9kTRngrhH/VJnqwFFyHrfPl6Sc1s2rqWLW2FMhXyZUaGVI4KcTpWe2uYICLMZ
         9vnw==
X-Gm-Message-State: AOJu0YzYnBKJF6ehaPwo9xDNgSlrOBeREVv8E+fQg8/JMHlng0jRz/Bp
        sNAxzrw/hZIdX983gnDBg1Nh2uxpm+7KbCMVeFM=
X-Google-Smtp-Source: AGHT+IHgr9nynCS/ucqavDyQ3SYRMfgb3QOx1xUZ1hm5wRiKVquIatGYzXl9/X49jc+z424OFoYDuEjaadgYJjevFsc=
X-Received: by 2002:a05:6402:217:b0:533:4c15:c337 with SMTP id
 t23-20020a056402021700b005334c15c337mr16681534edv.16.1696963300188; Tue, 10
 Oct 2023 11:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <20231010164234.140750-1-ubizjak@gmail.com> <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com> <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
In-Reply-To: <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Tue, 10 Oct 2023 20:41:29 +0200
Message-ID: <CAFULd4Y8NSArDqH=VMy8F97eNosUUGxrBMEyHH=MytjUBSCmjg@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Nadav Amit <namit@vmware.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 8:38=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 10 Oct 2023 at 11:22, Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > Please note that besides propagation of the addition into address, the
> > patch also exposes memory load to the compiler, with the anticipation
> > that the compiler CSEs the load from this_cpu_off from eventual
> > multiple addresses. For this to work, we have to get rid of the asms.
>
> I actually checked that the inline asm gets combined, the same way the
> this_cpu_read_stable cases do (which we use for 'current').

Yes, but does it CSE the load from multiple addresses?

Uros.
