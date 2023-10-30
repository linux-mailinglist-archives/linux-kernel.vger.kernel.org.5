Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCE97DB4CE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 09:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjJ3IHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 04:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjJ3IHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 04:07:03 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78562A2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 01:07:01 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53de8fc1ad8so6624241a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 01:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698653220; x=1699258020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftAuK3Ih7QOxL8862x7jyZ5j0w7pae+djeHxMc9FKUc=;
        b=NBS3/z6KpKfYovs82P2bAYSHMej3yJGDhCFGVpNRMdOyn/g9BpH69pDJnZzCa8mT5m
         gmaDQmVvcEzhQb6dW5qHoC2IcyH+MScRznz06ixLLUzCuMVi1YtcMOa2jJgzBXMi1yg3
         GGLSeHH2tCQlIK6GTfIJddElZVjXB8NHNrbdd/fpbAuloXFuvTo3HqKwV1iuD0aTyLsc
         s6c2C8iGzmW6NYJHr4jdkfIX1zmlQeaS1prTRunXiGKtRmzsSyx86lpSP+gv0b+HlrA1
         4DJXcGwGouh2pGlCLNTtGqCCsYMMYNv2/bJyD0BKTzfxKGrWVQ51uSp9v308Uqwo++qg
         INTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698653220; x=1699258020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftAuK3Ih7QOxL8862x7jyZ5j0w7pae+djeHxMc9FKUc=;
        b=oCmFA9z+mBgAcK5QQ8Lbtjx5WWUH33BpSrD2zs3BzBq7DcBD4FRSrO6ZH/yofpSm9T
         yJ8yQ2HIH4rDi9akXakZ1Z39XHNbgn50w+aUlVJo0gYmlKfl1iEHk6KwB0uNYRIxSyi3
         anBJWN7jQyQcWMxqR8VnKBK69lJa/bh/DCS5YoO2M3qoRmM1HcbEo8P5/CphEehtvUPv
         lkbKdQOrgbpdtlZZwHsOKjR9NhRnfxvCzNFVYkaqGDXgdU0uRtEM/o2NsFHOPKcoZ2+s
         DPe45hXCVe5gE4BIxP+LToqCR5udyzJibaKwygN+GPbDLNqe2kknVNpoK+zeF5BzAP2A
         Yf3g==
X-Gm-Message-State: AOJu0YwCiUK/XvcAetAF1ig8Xe8X96EK8l2VmGPy5TQi6dPnkc+55IFE
        0PP1gsyXVKuEAUmltylu94U7ImVG5Lc6Crak91hAyI2osOU=
X-Google-Smtp-Source: AGHT+IFAf0wbpuTM0t3o6Xp6gWDftYLA2GK8uXX1fD0vcCcnak82CF5rcMzm0K1d02ypWZ2jKhR1kvfROp0PyDGuGUE=
X-Received: by 2002:a05:6402:350:b0:53e:1825:be81 with SMTP id
 r16-20020a056402035000b0053e1825be81mr6584572edw.21.1698653219379; Mon, 30
 Oct 2023 01:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231026160100.195099-1-brgerst@gmail.com> <a094c7da294a4827994af72249262593@AcuMS.aculab.com>
In-Reply-To: <a094c7da294a4827994af72249262593@AcuMS.aculab.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Mon, 30 Oct 2023 09:06:48 +0100
Message-ID: <CAFULd4ZBGzceGbRaVLuMJ+qkoUpMv-rdBZB_D=Mni5RAWzgQBQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] x86-64: Stack protector and percpu improvements
To:     David Laight <David.Laight@aculab.com>
Cc:     Brian Gerst <brgerst@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29, 2023 at 10:42=E2=80=AFPM David Laight <David.Laight@aculab.=
com> wrote:
>
> From: Brian Gerst
> > Sent: 26 October 2023 17:01
> >
> > Currently, x86-64 uses an unusual percpu layout, where the percpu secti=
on
> > is linked at absolute address 0.  The reason behind this is that older =
GCC
> > versions placed the stack protector (if enabled) at a fixed offset from=
 the
> > GS segment base.  Since the GS segement is also used for percpu variabl=
es,
> > this forced the current layout.
> >
> > GCC since version 8.1 supports a configurable location for the stack
> > protector value, which allows removal of the restriction on how the per=
cpu
> > section is linked.  This allows the percpu section to be linked
> > normally, like most other architectures.  In turn, this allows removal
> > of code that was needed to support the zero-based percpu section.
>
> I didn't think the minimum gcc version was anything like 8.1.
> I'm using 7.5.0 and I don't think that is the oldest version.

Please see previous discussion regarding modernizing stack protector
on x86_64 [1]

[1] https://lore.kernel.org/lkml/20211113124035.9180-1-brgerst@gmail.com/

and x86_32 [2]

[2] https://lore.kernel.org/lkml/cover.1601925251.git.luto@kernel.org/

The conclusion in [2] is:

"I'm all in favour of simply requiring GCC-8.1 to build a more secure
x86_64 kernel. Gives people an incentive to not use ancient compilers.

And if you do want to use your ancient compiler, we'll still build, you
just don't get to have stackprotector."

and in [1]:

"Ack.  We did this for 32-bit and got few complaints. Let=E2=80=99s finish =
the job."

Uros.
