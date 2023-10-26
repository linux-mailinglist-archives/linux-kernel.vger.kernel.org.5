Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D067D8802
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 20:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjJZSGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 14:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjJZSGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 14:06:45 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BED1A5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 11:06:43 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53f6ccea1eeso2041888a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 11:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698343601; x=1698948401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdc7Sx5CtpbfN0J2PRPL/2aEjI/F3L5Qic5K6HYlIhg=;
        b=UGAzPXi3ss4NJz9Wu0DLCF/1oofPOyd/axiccupoMtKCgWS3SRmUBO2E+RMBKA8QLl
         aGifXO2Xatw0i77Y6ASwRnM9bHMCkPooAjVYsmtfVKVaihLcC74GIsgZrApA6mCbIJtW
         0Gf/uy5OiNqtIZDeqcOX3N6obTmBaNXR4GKbhTEV5DGXEVb3HlvdMR/pVvvus+XfJwyu
         7zgPGpC1LaKdJTwWod1dov1bC341ivrm4iwqlkTXtfe1dKpk9R5vy+MA6Fp5vO+DLyVt
         03XVNZe3TbV5nSwKG6WyDT3QfDhJ7+SFC7Ei8FGtB5Xo2CZKVtjQvDKp4048Uw7Wlp9o
         OXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698343601; x=1698948401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cdc7Sx5CtpbfN0J2PRPL/2aEjI/F3L5Qic5K6HYlIhg=;
        b=SJXsXzYh0IT/PDU698WxT5aykyZqO+sWPm6plvFoGoFlSfMAS6x6wv15ZlhLiZNSsH
         smToWxcpJMXxWPfc1MO2Z/qGNZKfr8I4eweb3IEPAnuhycb8fJczNNXI793IJOC2DVvK
         i11SbmXJkirjuqSmkCg/yR7Mr1K6kHnO3OHIBqXsce22Vcu2oUmiACGmeyfJoGwCdsDz
         Ss83NsWxeQaifexuNDc6ZfBFaCb/Q6rLphLXORCZwWsrkq+Slveg2bw5Gz0m2YWpOrbt
         CC5eoKbohf7JcnAkW9G9dEd4n6VxM3chtWffyIL5d4VW0mysL92xxOcsdNyHIv12+V4k
         VNfg==
X-Gm-Message-State: AOJu0Yx1+uOyWxPqHsFBYnlitYgUjj4KnLu3iJfeBSCwjmCOHm1jXugW
        0lHqwQNFVvk5QObvli5ZghjrfuW983oP+BdsPE0=
X-Google-Smtp-Source: AGHT+IEv0cxmiZNPFriCLmpg591ygLV4YfOgfyDvqMhQh5oDlOac5UZQ7kckP/GjH87wG2P0trLrC3sayuymYyJzdgM=
X-Received: by 2002:aa7:d806:0:b0:522:38cb:d8cb with SMTP id
 v6-20020aa7d806000000b0052238cbd8cbmr491141edq.20.1698343601134; Thu, 26 Oct
 2023 11:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <20231026160100.195099-1-brgerst@gmail.com> <20231026160100.195099-3-brgerst@gmail.com>
In-Reply-To: <20231026160100.195099-3-brgerst@gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Thu, 26 Oct 2023 20:06:30 +0200
Message-ID: <CAFULd4af7Y=PZEo_WSWU7xjT6rP6iPtndLAc_puz6QqXnGjk4Q@mail.gmail.com>
Subject: Re: [PATCH v2 02/11] x86/stackprotector/64: Remove stack protector
 test script
To:     Brian Gerst <brgerst@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>,
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

On Thu, Oct 26, 2023 at 6:01=E2=80=AFPM Brian Gerst <brgerst@gmail.com> wro=
te:
>
> This test for the stack protector was added in 2006 to make sure the
> compiler had the PR28281 patch applied.  With GCC 5.1 being the minimum
> supported compiler now, it is no longer necessary.
>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>

Reviewed-by: Uros Bizjak <ubizjak@gmail.com>

> ---
>  arch/x86/Kconfig                          | 2 +-
>  scripts/gcc-x86_64-has-stack-protector.sh | 4 ----
>  2 files changed, 1 insertion(+), 5 deletions(-)
>  delete mode 100755 scripts/gcc-x86_64-has-stack-protector.sh
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 039872be1630..92144c6f26d2 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -410,7 +410,7 @@ config PGTABLE_LEVELS
>
>  config CC_HAS_SANE_STACKPROTECTOR
>         bool
> -       default $(success,$(srctree)/scripts/gcc-x86_64-has-stack-protect=
or.sh $(CC) $(CLANG_FLAGS)) if 64BIT
> +       default y if 64BIT
>         default $(cc-option,-mstack-protector-guard-reg=3Dfs -mstack-prot=
ector-guard-symbol=3D__stack_chk_guard)
>         help
>           We have to make sure stack protector is unconditionally disable=
d if
> diff --git a/scripts/gcc-x86_64-has-stack-protector.sh b/scripts/gcc-x86_=
64-has-stack-protector.sh
> deleted file mode 100755
> index 75e4e22b986a..000000000000
> --- a/scripts/gcc-x86_64-has-stack-protector.sh
> +++ /dev/null
> @@ -1,4 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0
> -
> -echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -c -m64 -O0=
 -mcmodel=3Dkernel -fno-PIE -fstack-protector - -o - 2> /dev/null | grep -q=
 "%gs"
> --
> 2.41.0
>
