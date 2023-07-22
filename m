Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9257B75DD4D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 17:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjGVPwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 11:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGVPv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 11:51:59 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84DE1A7;
        Sat, 22 Jul 2023 08:51:58 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-bd61dd9a346so2925351276.2;
        Sat, 22 Jul 2023 08:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690041118; x=1690645918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCi1Uz5o7zeVrFMLJ/4tgvXXXKZHZ4kvnCTkqRPWjWA=;
        b=AOL3KXHdbXZMFcjTHwc6CCED5VEqhzTh4nbizMd7FgDA1zALz3PvEWgSwMKoaAhg/E
         8ea5/DnMTu1CBpSXbBpUmA6MNnky/bPsaD/vE6Nh6vRNgYta0atW/N18fR4rv6iXVvWY
         6HrgBGEwSZdbtBmz3NbYCuUfORAJ4sPIXkXcPlGIxNSV5na4JdOImlrzv0R/a8woaWqb
         ZCeT14KmIN6MYia0WVSbjYApmeCuiXUYDb8qLs5ALA0dhC69NAQDqODLoaMI59sLfW5v
         9Dfm67dXjr0G9pbEhEataEP3nCRxDNxYeEuUGxg3KGjVT1YKa0t/2bKwCQUqhz5XiQPB
         6OKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690041118; x=1690645918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GCi1Uz5o7zeVrFMLJ/4tgvXXXKZHZ4kvnCTkqRPWjWA=;
        b=c/G+loJXo5+QIYl6t3Xc1PvUKE4849/qxmctbzUiJZTaBxSqBiea1c1dKdlHMwpNq7
         tWvBeZDRJDjdgz76AP7VjKk+B9q+71M6+GQlaBN0Sz+xi950FyFDkUf6fvsR1E8nxCik
         87+y0YZXsBMmIEPe+OKn+g7IytXdCNNQevDJqT8awlXqpK+R7fYmCgyHLSKvKGN0oM8O
         W7XP+2odf7J+4+jabhi+pOKrNQRwQswVGXPmS3R8H2EeVhvK/NNVCC1l5gs8hDtJp3P9
         otcBXU8seMAwMRzJTbLSP2ygRdueLb+kgmSeaDOleguDkc/quN2E1KPymgP3EJEh9GuQ
         hE+w==
X-Gm-Message-State: ABy/qLZd1ReP3JFI5RdHHvpGBSfDdX+6CWGlRlvlcRm6UE7N91ZJEM+Q
        o0+iG967CYIINex+xVPa00esYoMLMqVN2u1hwRI=
X-Google-Smtp-Source: APBJJlFGtjGwoVBX6T4RZLs+O9K/oMEKrvNEmTfDepBNpMwxth6UkVuiRcQi79TO2WtMS7kRWnjdz58tBZhbRYxqTWo=
X-Received: by 2002:a25:fc05:0:b0:c41:a05d:5da7 with SMTP id
 v5-20020a25fc05000000b00c41a05d5da7mr4021208ybd.5.1690041117961; Sat, 22 Jul
 2023 08:51:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230718055235.1050223-1-ojeda@kernel.org> <CAK7LNAQ-hjW_19fjA+E-bQCrXcVPdN4-GvzAnEnYzna5KRVXew@mail.gmail.com>
 <CANiq72kZjOGvRKoRxtgG=2DhJnMJK9TCQtTmeef_B=nLcLQD6g@mail.gmail.com> <CAK7LNASqumGb0xvSa8n4Heasz9BKxgk4mvzNXsfFhZE1G+Bxbg@mail.gmail.com>
In-Reply-To: <CAK7LNASqumGb0xvSa8n4Heasz9BKxgk4mvzNXsfFhZE1G+Bxbg@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 22 Jul 2023 17:51:46 +0200
Message-ID: <CANiq72kD2wxXy2ri8sBhVJ4y-JJiq+kYt_MRZwuwB9uGkX-_jQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: rust: avoid creating temporary files
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        linux-kbuild@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Raphael Nestler <raphael.nestler@gmail.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 8:35=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> Maybe, the following was a breakage.
>
> commit 295d8398c67e314d99bb070f38883f83fe94a97a
> Author: Masahiro Yamada <masahiroy@kernel.org>
> Date:   Sat Jan 7 18:18:15 2023 +0900
>
>     kbuild: specify output names separately for each emission type from r=
ustc
>
> Before that, rust_common_cmd had --out-dir.

That's right, good catch!

> BTW, do we also need to fix scripts/Makefile.host
> in case the external module Makefile creates host programs?

Indeed, we need it too. [1] would fix it (tested it with a trivial
out-of-tree Rust hostprog).

Do you want me to send it separately? i.e. to avoid losing the
`Tested-by`s etc. that we already got for this one, which is the
important one since that actually has users.

The hostprogs fix is not really critical for stable, since it is
unlikely there are users at all (we just got the first in-tree real
user in the Rust+KUnit integration coming into 6.6), but I guess it
does not hurt for the same reason.

Thanks!

Cheers,
Miguel

[1]

diff --git a/scripts/Makefile.host b/scripts/Makefile.host
index 7aea9005e497..54adf2e2ec51 100644
--- a/scripts/Makefile.host
+++ b/scripts/Makefile.host
@@ -86,7 +86,7 @@ hostc_flags    =3D -Wp,-MMD,$(depfile) \
 hostcxx_flags  =3D -Wp,-MMD,$(depfile) \
                  $(KBUILD_HOSTCXXFLAGS) $(HOST_EXTRACXXFLAGS) \
                  $(HOSTCXXFLAGS_$(target-stem).o)
-hostrust_flags =3D --emit=3Ddep-info=3D$(depfile) \
+hostrust_flags =3D --out-dir $(dir $@) --emit=3Ddep-info=3D$(depfile) \
                  $(KBUILD_HOSTRUSTFLAGS) $(HOST_EXTRARUSTFLAGS) \
                  $(HOSTRUSTFLAGS_$(target-stem))
