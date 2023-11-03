Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADBEF7E0714
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 17:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345731AbjKCQ5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 12:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344556AbjKCQ5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 12:57:33 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318331BF
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 09:57:30 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4084095722aso16946015e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 09:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699030648; x=1699635448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lIsbDHPwaa1oft7g9fsOhHYzHACUbAbiF4uUBUfwbY=;
        b=Evq6DIQOxByYYO7QSeQTHoS2dTq9/w30oya392LbIXOsFK0eq705Jn5vlK1hLfoMs5
         CLU+mfUe6kT+aex+6nBXfVWVC7XbUFhyJkNleGfEAetrfcBkwnP7TZfyI6lWMrEXUyXA
         AT4w2uwPdUK/1dHuK0FpQeo6Ux0t3O0KXmfWFXdX1GTrmWcYgP+Yhlbct8e+C/NCkZkp
         iC6rMbEkPis4KEhwr9+rz8qCVO4OPIfXtXzOGthVDD+O7g02bPrGJbD9h0xDh1qfKSXX
         7CTTMyTGViepzjAmWe3ulyUxQAOxzq4KF7BPIXhW/XrEeJglH5qpjKAwUPUuLeSxFj9b
         297Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699030648; x=1699635448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0lIsbDHPwaa1oft7g9fsOhHYzHACUbAbiF4uUBUfwbY=;
        b=X/9U51JRlmpbqlB8pltgLqbBAbROWskE6JbS6qF6TJhi42HMGXApNyusBDcjxl1hxK
         ezC7/nEDiW4Tg5OPW9LSCOK7cE0RmbufP+lVIHKBj16YdrzyWcz0EzOcrOR5aE2uIe/x
         rVh5dNtJp22DaRP4ZSiGVjVVSH36emBXVgSckGtT43YZG3phvApXBpgN3i0ElpWLngwS
         YQ6nkPLiVCP6F1EUYxGxTJUNfiabmIL5/SiDoFBpnUHVMtOVP+om4lzlO68YLFje/W+s
         F6V+vng31jllQYQLW4ROdiLPbmlbBZq0emVdfuVKptB4yP2yjEKrdXaaC+EQ0JcukNiS
         fQzA==
X-Gm-Message-State: AOJu0YzhIHXdaeNIfI1UmVeZpZFMfHBy/HIUxAzU1Gn9i3jCqoq0UEIu
        xiwdAYQBWecuKrQ2h5zGtfkYISCnRmUcrwmUPScpmw==
X-Google-Smtp-Source: AGHT+IHsyB2RMiwtGQtmp5D41evpEcLf0w+GRDtt6AMs5gXHG7mDc80QXHpPVY9wrU1VMaW7Ifo9PRPl2ELGlTdes+M=
X-Received: by 2002:a05:6000:12c5:b0:32d:9755:44f1 with SMTP id
 l5-20020a05600012c500b0032d975544f1mr17649157wrx.32.1699030648342; Fri, 03
 Nov 2023 09:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <20231031-tcp-ao-fix-label-in-compound-statement-warning-v1-1-c9731d115f17@kernel.org>
 <ZUStrQCqBjBBB6dc@infradead.org>
In-Reply-To: <ZUStrQCqBjBBB6dc@infradead.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 3 Nov 2023 09:57:17 -0700
Message-ID: <CAKwvOd=voKM+kPWa=toFfWDvq2gOw7Q0yyjq7ragxmPS7U5HBQ@mail.gmail.com>
Subject: Re: [PATCH net] tcp: Fix -Wc23-extensions in tcp_options_write()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Nathan Chancellor <nathan@kernel.org>, edumazet@google.com,
        davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, trix@redhat.com, 0x7f454c46@gmail.com,
        fruggeri@arista.com, noureddine@arista.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev,
        Thorsten Leemhuis <regressions@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 3, 2023 at 1:22=E2=80=AFAM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> On Tue, Oct 31, 2023 at 01:23:35PM -0700, Nathan Chancellor wrote:
> > Clang warns (or errors with CONFIG_WERROR=3Dy) when CONFIG_TCP_AO is se=
t:
> >
> >   net/ipv4/tcp_output.c:663:2: error: label at end of compound statemen=
t is a C23 extension [-Werror,-Wc23-extensions]
> >     663 |         }
> >         |         ^
> >   1 error generated.
> >
> > On earlier releases (such as clang-11, the current minimum supported
> > version for building the kernel) that do not support C23, this was a
> > hard error unconditionally:
> >
> >   net/ipv4/tcp_output.c:663:2: error: expected statement
> >           }
> >           ^
> >   1 error generated.
> >
> > Add a semicolon after the label to create an empty statement, which
> > resolves the warning or error for all compilers.
>
> Can you please just split the A0 handlig into a separate helper, which
> shuld make the whole thing a lot cleaner?

Just a note; mainline is currently red over this for us since
1e03d32bea8e spent all of ~3 days in linux-next before getting merged
into mainline.

Whatever the fix is, it would be great to get it into mainline ASAP.

--=20
Thanks,
~Nick Desaulniers
