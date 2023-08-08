Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60EF0774AE4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbjHHUhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235273AbjHHUhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:37:20 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318F3FEDA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 13:05:15 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d075a831636so6466769276.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 13:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691525114; x=1692129914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ai1runGTSkAj0e1hf+aJdNHxxj+ZHvJ6gp6VwW8HVhY=;
        b=tH/47qSqfscDniRHVEd1T6nL3p+hNXSPx+nI8tvZQ8wqJ0bdTFHSoUnCBFDed2hXdw
         eSKqh1/PZT+O5402fd6RaSatzRKmlG7aW2VTqRr9GlA+dgUAJprynq9OoZH/NajFjdqN
         1yVlSZv5va4HsoEbZH/GbrSaSc2C74LDNS3ss/dLrOTYV77wP6Sz+DulKJQMPwjsD2GC
         c5Mdc+AtLlScwYISqPfzhcklfsdXnDaE1APtLtkDbp2k2DMK5BdyT39xeX8PyMJbRtcb
         PhqxkbfHYXf6dXLDVCWLiIb8K2rIm0wgnemorfgjDz2r1PXQLSDAiKpSwDXVVKVrRSNH
         6K6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691525114; x=1692129914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ai1runGTSkAj0e1hf+aJdNHxxj+ZHvJ6gp6VwW8HVhY=;
        b=LuosKdOSm3x/E56AZGvEIedWa2ifwpxlgEcm7GS+/Lb9Xd5biPLOauvT0OshaLe9ST
         sGrnhaxEyHV3Vt31voOQv01YkdcL16Ay4Os2/deR1igtABnVhlVb+6trONgbJgv72D3E
         3KDlCOZlykO2c8jfY83y1uXZ9FpTmRibCOHKEYXGlOmLcudJu88K1062nG9R8fchdPhm
         9KTrtz7I+nE8KGGEMsvwaSZP9dEWud88HW8qfY7MCXAcO/g1mtnkmCGXYykZFWnMP2/i
         +PZjOH6kYYgZG3WOlCfqsh2C6KlOA9z+KGvyz2SEzlwPu/wms9zmuWpm/eZPaoU3Q/o4
         rcuw==
X-Gm-Message-State: AOJu0Ywv8A5sR4gxO8fBr7qdwdW52kJqcPMt/VHidbO551pr4Pgg0mZz
        EuysOl7uAgSIFozGwHCoAhwNCn0uZyBVLjkQh+SJ5g==
X-Google-Smtp-Source: AGHT+IHMyBZiua6UK/2hg9jnhu/TA3P9gTqw5QtXRY5vi2IGBb7uQS986tpjmWRhOkhHpQuDwC6WbBTftnxdJjoUhDo=
X-Received: by 2002:a25:504d:0:b0:d36:8d9d:d616 with SMTP id
 e74-20020a25504d000000b00d368d9dd616mr631529ybb.35.1691525114376; Tue, 08 Aug
 2023 13:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230808-virt-to-phys-mips-v1-1-af6fcd45ed31@linaro.org>
 <CACRpkdYisteBTk9DOeCZiCeH5hJW87O-m+zsWAU7uwg7ud=ZYw@mail.gmail.com> <d025d95e-b12e-4502-b3fe-dc03d5ec831d@app.fastmail.com>
In-Reply-To: <d025d95e-b12e-4502-b3fe-dc03d5ec831d@app.fastmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 8 Aug 2023 22:05:02 +0200
Message-ID: <CACRpkdbjmg=_9wsKoiBmv9U-HMTDvV9LgFnRWXD1g-ZPH5Estw@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Drop virt_to_phys define to self
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Baoquan He <bhe@redhat.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 3:46=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Aug 8, 2023, at 15:12, Linus Walleij wrote:

> > Normally you would do this so as to override the default virt_to_phys()
> > from include/asm-generic/io.h, but we do not seem to be using it here?
>
> Correct. In linux-next, we have converted arch/sh to use
> include/asm-generic/io.h, so arch/mips is now the last one
> to not use it.
>
> I see that Jiaxun Yang posted a patch for this in May and it looked
> like it should finally work [1], but there seems to still be something
> missing.

Oh that's a nice patch!

> For the moment, I'd suggest we leave the #define in place
> here in order to finish the patch that starts using the
> asm-generic header, and then we can look into using more
> of the generic code.

Sure, no point in causing stir with Jiaxun's work, let's drop
this patch.

Yours,
Linus Walleij
