Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338CA767C3E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 06:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbjG2E7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 00:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjG2E72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 00:59:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634FF198A;
        Fri, 28 Jul 2023 21:59:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E13B96023F;
        Sat, 29 Jul 2023 04:59:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA1DC433C7;
        Sat, 29 Jul 2023 04:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690606766;
        bh=1Ur5WWz50txmArZ9Udrci40H6uV4ULFsoRrsTTx7BQM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m09bPiQdk48SHRRtHOABRonBiS8Yo84AdUXzAdTSTzWcgSYWbI994VSxJU/2naEU+
         B6GRADS6jiwcKMM3f41Dpk8NHS9Kv7xmzHGIIRc2OxyE8B9EFq5cKGgEplMBAbR+w9
         4DDuEkZdLRgpnfOOU5nkpOqTMDSD2YgVbOPrSxlgkMwR1Z0JfhDXG1kMJKNDT8XzEj
         CBwoiJFDBnUrL/jE1aI0s/Z0aYHxJXSYTt85Wx9mBK13q8ulvimHXxzwhvzHBfV3MM
         QQcPh2Tw8tA1P78uBEePui/SU29HtYpOMnqFXDj9Tqr9hbiwzNhJ4xjdyuBqAJC2pf
         EX7PFOiYfO6cg==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-51d95aed33aso3480601a12.3;
        Fri, 28 Jul 2023 21:59:26 -0700 (PDT)
X-Gm-Message-State: ABy/qLb5/ALjyXg4X5R+Y4gv1oHBc1vSpyV6aYNwQ7vr1jLtblcSitmX
        Y1l+jedhId2HMRRmnwmnpRm4+olKGH3ord7gqz0=
X-Google-Smtp-Source: APBJJlGZC9PeCYnchy1vv+5vC4S+d9uy0sw0bQ92baG1/mvdm+JoFIpM5iNoklvh3sAOuozu4ZQ5ZqqIvmr5t2QmRZo=
X-Received: by 2002:a05:6402:6c6:b0:51d:b89d:9818 with SMTP id
 n6-20020a05640206c600b0051db89d9818mr2990354edy.12.1690606764506; Fri, 28 Jul
 2023 21:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230726145740.1765323-1-arnd@kernel.org>
In-Reply-To: <20230726145740.1765323-1-arnd@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 29 Jul 2023 12:59:13 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTC0BTOyWH4Zod1oRQaUpS9dE-6=otfpGOPcCcffrHohQ@mail.gmail.com>
Message-ID: <CAJF2gTTC0BTOyWH4Zod1oRQaUpS9dE-6=otfpGOPcCcffrHohQ@mail.gmail.com>
Subject: Re: [PATCH] csky: fix old style declaration in module.c
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx Arnd,

Reviewed-by: Guo Ren <guoren@kernel.org>

You could directly put it in your next tree. If you need me to do
that, please don't hesitate to let me know.

On Wed, Jul 26, 2023 at 10:57=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wr=
ote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> With W=3D1, gcc warns about the inline keyword in the wrong place:
>
> arch/csky/kernel/module.c:43:1: warning: 'inline' is not at beginning of =
declaration [-Wold-style-declaration]
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/csky/kernel/module.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/csky/kernel/module.c b/arch/csky/kernel/module.c
> index f11b3e5733448..0b56a8cd12a3d 100644
> --- a/arch/csky/kernel/module.c
> +++ b/arch/csky/kernel/module.c
> @@ -40,7 +40,7 @@ static void jsri_2_lrw_jsr(uint32_t *location)
>         }
>  }
>  #else
> -static void inline jsri_2_lrw_jsr(uint32_t *location)
> +static inline void jsri_2_lrw_jsr(uint32_t *location)
>  {
>         return;
>  }
> --
> 2.39.2
>


--=20
Best Regards
 Guo Ren
