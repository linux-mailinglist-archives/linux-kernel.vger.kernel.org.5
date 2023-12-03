Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7E1802891
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 23:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbjLCWt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 17:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbjLCWt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 17:49:58 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD7DD3
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 14:50:04 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50be4f03b06so1497004e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 14:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701643803; x=1702248603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUjrVen9mMyOXvuD97x+HXHU4fi1qdA0K8Q1bYahYVw=;
        b=hcyNPfAUOuZ/doFHAQj09JlzSYMO2YhxGj+C9CxM8kv6T5oQu/I4piDHLp5BBUReE5
         Ie29qN+/6r4z9sbfMn7CEjfjtxyo1+DVSRDVkbj3lh9s5CLk3iG7liciTRREhgzuK97L
         rABTzDnqrW8OG4XMyR8x6QGqUm2N093N2Ytay5zeQV/Yh4oWOisvQ0iFbBVaE7aBy+ov
         4T5phPCTMW2tpMFnnWSPtTtnKM9/2KqpBHQsA/Rrzs0vQIZERTHnfQG64/zqthvgjLTM
         d1+js42Ns+ASlzPTCuiT2g0Ftf6tyjoUgtDet4kslk62laE5mQpiCdIEj9i7HrTFXHfs
         ny5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701643803; x=1702248603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AUjrVen9mMyOXvuD97x+HXHU4fi1qdA0K8Q1bYahYVw=;
        b=MP2fh2o/4xv1lIPNxs3hI9Q9mCC4V0RNOR6QvaiWLkWyxfZ6knlSIsD/hrnuZj3B4N
         72AQB4ixt4MYfW3Pk8ig9z5Sd4r1LtItFighzCXzjekZ3B1YHX0QMuZHfcnTs02NXuUo
         HhUxy9PsZVlyUD1AH3qtJoKpTXjrQoKDRXXqqo/4Du0OnujZ6J2xsQybQnFh6hOPqGXz
         lRWsjMLqVuAMeH2UribL27bLdnS7PE4ZcjoXW6X1xBnZzOncINWvxc814qPCz4j9XGSg
         pTJFllQDuJbb9lKYAvz+jjdaFwj9x8Q48QeZbJnE4toOV/qpQY0bzAZ6/A2RPkKobop/
         FRfQ==
X-Gm-Message-State: AOJu0YyJllq/35ttNrGkI0i7e0Wvi0qfGqbAAj+ekEc0eHo+G6dpuz9L
        PR3hWvOUtqV/k0MQ/hEqJPzsgBKy0jTYDrE/T/w=
X-Google-Smtp-Source: AGHT+IE0cyE2sa90FdsdccHWJ4J8vEOpxirpRgK0g2vxyQwS7I3thVkpnRxuk5J/PmE/AswzBdDl/kGopsQ5AYbw4lE=
X-Received: by 2002:a05:6512:3b85:b0:50b:d764:291a with SMTP id
 g5-20020a0565123b8500b0050bd764291amr2118575lfv.178.1701643802715; Sun, 03
 Dec 2023 14:50:02 -0800 (PST)
MIME-Version: 1.0
References: <20231203221151.794615-1-ubizjak@gmail.com> <CAHk-=wiS6nyWNjaTW_XL1ec3+-=tOszj+_sWGfPv9RG5WX5isQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiS6nyWNjaTW_XL1ec3+-=tOszj+_sWGfPv9RG5WX5isQ@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Sun, 3 Dec 2023 23:49:51 +0100
Message-ID: <CAFULd4amFXV1WB0O64BihiLCtmZw5B65Rf=7dTtni5fnvBoPWQ@mail.gmail.com>
Subject: Re: [PATCH -tip 1/3] x86/percpu: Fix "const_pcpu_hot" version
 generation failure
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
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

On Sun, Dec 3, 2023 at 11:19=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, 4 Dec 2023 at 07:12, Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > +/*
> > + * The generic per-cpu infrastrucutre is not suitable for
> > + * reading const-qualified variables.
> > + */
> > +#define this_cpu_read_const(pcp)       ({ BUG(); (typeof(pcp))0; })
>
> NAK. Absolutely not.
>
> No way in hell is it acceptable to make this a run-time BUG. If it
> doesn't work, it needs to be a compile failure. End of story.

Thanks - BUILD_BUG() also works here and is indeed more appropriate:

/**
 * BUILD_BUG - break compile if used.
 *
 * If you have some code that you expect the compiler to eliminate at
 * build time, you should use BUILD_BUG to detect if it is
 * unexpectedly used.
 */

v2 is in testing.

Thanks,
Uros.
