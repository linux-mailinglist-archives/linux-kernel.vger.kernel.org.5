Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D664A75FC41
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjGXQeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjGXQen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:34:43 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4991E53
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 09:34:41 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3a5ad21a1f9so923732b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 09:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690216481; x=1690821281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0f7dDULSRSGbAiEBcGCpBzTqX0S4cgJ92lbxxwD/4M=;
        b=G0xhoaWqCsA49wfGwRvWd3+cpyYiXn3zFV4GCVj2lRlGOBDB+NohaPhagTznarEdVf
         eBGN9YqI39qIUwiWiMicV/0u7Y8NkEONBFzjlZiuRyrZPbP/9CKN0poTBNP/4Y586IjX
         HBIEM/KZbHmUU0K2FsYMz66CvUJW5//bEsmJDTm56Qu/E3dBZUUa63FHP7vDhixLaEqg
         3VCsV9xvoJiQVrixrKfi19YCtZPg+GFuK3Y6MVUbtNZzecL+mvpvlcskhUTkNSjwcpeV
         43zdG2u2rNa40fvxl6Wg7IXxc8KEYozgxXQjOzHqJ/khKKQEDXx8yb+5ycpSSYfhCtAT
         4fzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690216481; x=1690821281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L0f7dDULSRSGbAiEBcGCpBzTqX0S4cgJ92lbxxwD/4M=;
        b=Ihz5gtkKdf+5TwrNynPF84R/xebj7OjhQ4ygtrmUkLmqeedszaIHWdEaz3iha1ZD5D
         ZIEW+/IiL8OA3qqWMEtplUYoVkQXYHNvzccyErVWWoth9uSmcg6x/SbniZQynuac81pN
         2bPrEI6aBUSLAlj5eWjArAk36jXEHfWZUSwtUk5DFrf3bm1yx/4KWcth9xY/zpuIJdbi
         KItZ4O5CtMZBvvKpJUpwvBERIY7KQ/FGuv1j963x8jgA2m/A4pCmfDXI8LRkkKMQblaw
         jvi+IG0TGIRaMHD0xrOSra4vgnEotjoYnM8j1IQj8IzwTMKk8WpPQonEVT1pcb7eaAbN
         Vr7A==
X-Gm-Message-State: ABy/qLaC3Px9TzgiDtse3KrFnd/1AdnXt5a2A4BJ28XdIteltPcwu27y
        9z/rZ+1Z/kL1MXV8nJph1OBYZDOBZATl1mOk/bsEjw==
X-Google-Smtp-Source: APBJJlGInXVc1E3RZtNYMrgrV6W2iOsxT5eyUGh4CvVW3/7lGpA554jXtto0liwDdfIS0p99YwAyost0u5cLer3B2e0=
X-Received: by 2002:a05:6808:1389:b0:3a4:8a13:98a1 with SMTP id
 c9-20020a056808138900b003a48a1398a1mr14481780oiw.49.1690216480904; Mon, 24
 Jul 2023 09:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <20221124094845.1907443-1-debug@rivosinc.com> <20230720001852.GA572618@google.com>
 <CAJF2gTRFvSvEvQeDugdp73o7w4ArdtQ99JScEbLkaLnFcftVcA@mail.gmail.com>
In-Reply-To: <CAJF2gTRFvSvEvQeDugdp73o7w4ArdtQ99JScEbLkaLnFcftVcA@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 24 Jul 2023 09:34:04 -0700
Message-ID: <CABCJKueNhc8qCbZbHJqdCB+PHHy0u5ETP4uWfpWBRaOMX6U6hA@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: VMAP_STACK overflow detection thread-safe
To:     Guo Ren <guoren@kernel.org>
Cc:     Deepak Gupta <debug@rivosinc.com>, palmer@dabbelt.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Jisheng Zhang <jszhang@kernel.org>
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

On Thu, Jul 20, 2023 at 8:06=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote:
>
> On Thu, Jul 20, 2023 at 8:19=E2=80=AFAM Sami Tolvanen <samitolvanen@googl=
e.com> wrote:
> >
> > Are you planning on resending this patch? I see it didn't gain much
> > traction last time, but this looks like a much cleaner solution for
> > selecting the overflow stack than having a `shadow_stack` and calling
> > to C to compute the per-CPU offset. The asm_per_cpu macro also would
> > come in handy when implementing CONFIG_SHADOW_CALL_STACK, which we'd
> > like to have on RISC-V too.
> I remember we ended up with an atomic lock mechanism instead of percpu
> offset, so what's the benefit of percpu style in overflow_stack path?

The benefit is not needing a separate temporary stack and locks just
to compute the per-CPU offset. With CONFIG_SHADOW_CALL_STACK, we would
also need a "shadow" shadow call stack in this case before calling to
C code, at which point computing the offsets directly in assembly is
just significantly cleaner and without concurrency issues.

Sami
