Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271A07A5A1D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 08:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjISGoU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 19 Sep 2023 02:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjISGoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 02:44:18 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B6A115;
        Mon, 18 Sep 2023 23:44:12 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-d7b91422da8so5028689276.2;
        Mon, 18 Sep 2023 23:44:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695105851; x=1695710651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kAmWc6PGNbz/v7P4Pzb+X6jxKjTax8yaPXnsgZKZYbo=;
        b=SSHXJn+MLNZwZdH8jlFn1yYGZd0JEdL5pG20q020iO3z2q4dCLi27ZsSTHWp7d5qnY
         OD3FxO812XCgS9k2YTAFk0YlTLGxmg9eF2d8IR0xVZbYdh3wS5v06FJdkWX1dqF64aEO
         jgYjUoWgEfJtZBmwHj99L8fQUgg8ODQrIzoL0HesmcQVaJ+GPWbzVk/bfbjPWeASwCz9
         APdOY0eBJPU9Vn7EMh1aYjNnOLqSYZyWTDWERA16+s5dxdXzLH3+oubhqb+dXsVVDXkP
         meqneunQwKV/zV81pMviiyTQQBcn5j1+lVK65SF+z/NPt+1wDz6EE/TQtGKZbbOi9xuf
         hiQQ==
X-Gm-Message-State: AOJu0YxChQSV1Dn3xRS/g4/tb2UCQpn8x7hvOXw+jHbVjngwRbjRmQ/b
        MEVXGaSUP5c+bRyvmj28q2Nk4U+7J7Jg0A==
X-Google-Smtp-Source: AGHT+IEcxHY4M/YxU2pZZWjmfn/XpUMrWsX/IfE0zhicBNCaVyWag5fY9lpN0cnS5N6glbdRHj+0BA==
X-Received: by 2002:a25:d744:0:b0:d06:f99e:6345 with SMTP id o65-20020a25d744000000b00d06f99e6345mr8570277ybg.22.1695105851437;
        Mon, 18 Sep 2023 23:44:11 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id l198-20020a2525cf000000b00d801440ed1dsm2733080ybl.23.2023.09.18.23.44.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 23:44:10 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-59c2ca01f27so29323687b3.2;
        Mon, 18 Sep 2023 23:44:10 -0700 (PDT)
X-Received: by 2002:a81:d352:0:b0:59b:cfe1:bcf1 with SMTP id
 d18-20020a81d352000000b0059bcfe1bcf1mr10748173ywl.44.1695105850445; Mon, 18
 Sep 2023 23:44:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1695031668.git.geert@linux-m68k.org> <d91725ff1ed5d4b6ba42474e2ebfeebe711cba23.1695031668.git.geert@linux-m68k.org>
 <87h6nqlxli.fsf@mail.lhotse>
In-Reply-To: <87h6nqlxli.fsf@mail.lhotse>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Sep 2023 08:43:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW6=wnOjT7qG4tHvc5X4JAJkkHMnVDsQ-dKM6i3FKyWWw@mail.gmail.com>
Message-ID: <CAMuHMdW6=wnOjT7qG4tHvc5X4JAJkkHMnVDsQ-dKM6i3FKyWWw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] powerpc: Replace GPL 2.0+ README.legal boilerplate
 with SPDX
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
        linux-spdx@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Tue, Sep 19, 2023 at 4:13 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
> > Upstream Linux never had a "README.legal" file, but it was present
> > in early source releases of Linux/m68k.  It contained a simple copyright
> > notice and a link to a version of the "COPYING" file that predated the
> > addition of the "only valid GPL version is v2" clause.
> >
> > Get rid of the references to non-existent files by replacing the
> > boilerplate with SPDX license identifiers.
> >
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> LGTM.
>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

Can you please take it through the PPC tree?
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
