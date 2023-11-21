Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095BB7F3851
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 22:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjKUVax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 16:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjKUVav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 16:30:51 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D57DB9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 13:30:48 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-548c6efc020so4549a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 13:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700602246; x=1701207046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RXRXOHrIRmnNFfmvROVe8lKDFwRW7hSZ8Iy3oG731k4=;
        b=xb0FA/oFXLl0fObHs2uSbLZBLLuKviwN+4DhjwkpEhM/jFYxSwnXYudySJUHkbOb8f
         6jKIO8fT4iVADL0p99BzvqvOcMv1uHhG0T92n7bMnMofnt5zW/tT+Sd5jqj8puddXdZB
         3IleEXKtd6LhDv2VRdrq8D3LjKJ0r0ImAkvx2oP+vLZaXumXlB7tyh8rnrZMoFLqSkfu
         BgvRH8xhzVK92fNHO75AQDDza2oJLDb1uOSz+DOn9b8HjV3/svPnI+xRshoqFSYTVCN6
         Z24PRnNGQcKCK8yejhYmvpNoYtAu9IL3xoFDM8X5cOe2+6eQbgIEHv4wULviuNUxG/uo
         I2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700602246; x=1701207046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RXRXOHrIRmnNFfmvROVe8lKDFwRW7hSZ8Iy3oG731k4=;
        b=JsXCH1vwFbolN5SdCQPq6A18H/iNqrfLMQBFfCGPBAyUiv5HDEXnD3HqD61EEPyFF+
         nOK/qGYxhY+cdYUY/wyYk9veAy0L88INXJwP6C3M808O3uGKqN17ba9WauDPYfeCbiXA
         HtzyLTCVF2GQS6+QxJ+GEB7YgeeOe8TN2x7zEptnLU+fpUfgYNdWdXJFsrsF4/HxWhTB
         I4GQLa1cWzVAWYLl17yV+ow8wUAlcG9qsV5SBsJ1gohP0a3MHLjIgCa2BOVm+IzFRF7x
         pqwlIEVDxy8y64Vv8Jq4c5SQ4y52LBDb5tcS9ooHuVejEC6OPlLnl9ldxq0Xy9S/LsyR
         OxJg==
X-Gm-Message-State: AOJu0YzxWBUnB1PnLSTn8r4tKPOCCimHsas9AQNooP13yLomrCDgz80J
        EzFlpa3mpa06ap6rcYMMfXf+n6s/KLTCQfkM27wD
X-Google-Smtp-Source: AGHT+IHOtAA86g7jwkpaavoDBRqXKPir59yYYqgAnqkDI3hxqIE8E0l3kuP8HHpkUDJfRxjrgyK41yk/p5NeVcpEmRU=
X-Received: by 2002:a05:6402:27cd:b0:547:e5b:6e17 with SMTP id
 c13-20020a05640227cd00b005470e5b6e17mr56442ede.2.1700602246100; Tue, 21 Nov
 2023 13:30:46 -0800 (PST)
MIME-Version: 1.0
References: <20231117-maintainers-v1-1-85f2a7422ed9@google.com> <CA+icZUXFGp-yoWUHhbowz6YJyoULCgtjSZ-fTpRg8YvVD9V5gg@mail.gmail.com>
In-Reply-To: <CA+icZUXFGp-yoWUHhbowz6YJyoULCgtjSZ-fTpRg8YvVD9V5gg@mail.gmail.com>
From:   Bill Wendling <morbo@google.com>
Date:   Tue, 21 Nov 2023 13:30:27 -0800
Message-ID: <CAGG=3QUTLTiD=4aj62YXUvLy0jCufMY_-+G-dYrtqN8i=tcqmA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: refresh LLVM support
To:     sedat.dilek@gmail.com
Cc:     ndesaulniers@google.com, Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Justin Stitt <justinstitt@google.com>,
        Tom Rix <trix@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>, llvm@lists.linux.dev,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 2:58=E2=80=AFAM Sedat Dilek <sedat.dilek@gmail.com>=
 wrote:
>
> On Fri, Nov 17, 2023 at 8:24=E2=80=AFPM <ndesaulniers@google.com> wrote:
> >
> > As discussed at the ClangBuiltLinux '23 meetup (co-located with Linux P=
lumbers
> > Conf '23), I'll be taking a step back from kernel work to focus on my g=
rowing
> > family and helping Google figure out its libc story. So I think it's ti=
me to
> > formally hand over the reigns to my co-maintainer Nathan.
> >
>
> Hi Nick,
>
> WoW (C)lang(B)uilt(L)inux baby coming soon - your best patch well done!
> (  "Catherine Beatrix Luana" might be a good first-name (my
> Suggested-by when it's female) ).
>
I vote for Ada Grace or Emmy Sophia, in honor of some amazing women
mathematicians. (I'm trying to get my friends' children to become
mathematicians!)

-bw
