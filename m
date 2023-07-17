Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD724756954
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjGQQhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjGQQhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:37:48 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872F810D9;
        Mon, 17 Jul 2023 09:37:45 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-cacc3f97ee9so4964354276.3;
        Mon, 17 Jul 2023 09:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689611864; x=1692203864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UL6KW5+gybIAFU9OV8j1FwwnDc/hkxXa1lifpKYtdgE=;
        b=MjoIbiINGtKKIKKm0lU5Uh8fjAQYl2Lx5eMtnvxJUs3qndHkSpP/10T9Uqnb4fsPj/
         LQQkoT14prY+mXAHRp5ub9uCSrHP7lQMZrHZtGk1q9G+cLOOG0n/N1iwIGv5YjbkdQVQ
         As1mw99QmS1j3Zbr0z5fdMK/9kfNDoQNGoCxkTf8xZFVDvizwLrqL6NEa2Xmp4KNhJBJ
         +/tCdOJejdwzjvX5hDsL9EHL71p9w7AKPqTxyqSAQNUwDIYngjIAN1ghED+j1NVi2liy
         vXrKCmPhzjbMPdMP/tRaaRLBzKzdW12W7ZFbAjsfmy9K19Kko3FnND23QBLFWp8Edb2N
         4h/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689611864; x=1692203864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UL6KW5+gybIAFU9OV8j1FwwnDc/hkxXa1lifpKYtdgE=;
        b=VVWTcIb+2PVyXthkBiUV1l2zqw1KiftGT6H2VGGGeTzesWMtX2vwtlhcDM0FFGKpgk
         OswqW2pNYuC1uZC6iznZNRvNXM9f3CBy2iKgDlncaEMzHnQ3rAqQExMBo5nn5ZbjUGGJ
         pkmRCt5b1ZtOKpd8c72LXfQpAOXGaj0ZYeVyO+LOdnfrXMYIrOKsBmNrSbZ509lQmSeG
         j/1NuZZ8VlYtVM17XLywVLoDtuqManEA7CeRl5RcU/IOHoJdYXmDkXwZsq+Fm2Lnjn+1
         969rQJRbUx6a+EU93imHpeCs1CXKCN9nUWQq5UpbpBMAETB8gwat0dEWHIwJE2adR3Dy
         xUlw==
X-Gm-Message-State: ABy/qLZvnFjWYJbyyNvJYRlJNou/i1Xv7pLxI6LgUL7nsf4cTgFaQiC2
        5XGr0Tn6a/tTWuADo0CjmKfqhvYWanPEI8fcSQY=
X-Google-Smtp-Source: APBJJlH9v5gHA0xDJSPiVWjEvjePgyAcmjr23TYFOV+VMN4migenzSYy+kDRbnhFmxXbBQyx/9DiI2/gru0pULFrS1o=
X-Received: by 2002:a25:cb8f:0:b0:c62:2320:2598 with SMTP id
 b137-20020a25cb8f000000b00c6223202598mr12908227ybg.62.1689611864596; Mon, 17
 Jul 2023 09:37:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230717151624.3470714-1-carlos.bilbao@amd.com> <20230717151624.3470714-2-carlos.bilbao@amd.com>
In-Reply-To: <20230717151624.3470714-2-carlos.bilbao@amd.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 17 Jul 2023 18:37:33 +0200
Message-ID: <CANiq72k+uB4Px=_kGNEiduc0AewC05XO2zTqC3+ABa0hcxui9w@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] docs: Move rustdoc output, cross-reference it
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     corbet@lwn.net, ojeda@kernel.org, jani.nikula@linux.intel.com,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, konstantin@linuxfoundation.org,
        Akira Yokosawa <akiyks@gmail.com>,
        rust-for-linux <rust-for-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 5:16=E2=80=AFPM Carlos Bilbao <carlos.bilbao@amd.co=
m> wrote:
>
> +# Where to place rustdoc generated documentation
> +RUSTDOC_OUTPUT =3D $(objtree)/Documentation/output/rust/rustdoc

I think we may be able to get away with just `:=3D` instead of `=3D`.

Also, I assume this is intended to be overridable by the user, right?
i.e. that is why you wrote the identifier as uppercase.

In addition, I thought about basing it on `BUILDDIR` from the Doc's
`Makefile`, but that probably needs moving that one so that we can
access it here (in the case where we are not building as part of
`htmldocs`), and thus maybe it is not worth it.

(Cc'ing the rust-for-linux list, by the way)

Cheers,
Miguel
