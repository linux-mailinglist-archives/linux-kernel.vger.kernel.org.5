Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F3D7DD7ED
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 22:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346433AbjJaVuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 17:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344894AbjJaVuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 17:50:06 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C60E10D
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 14:50:04 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32df66c691dso3831049f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 14:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698789002; x=1699393802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKyb1hV1vtUSZDqLnTgdX5n0+OXLN+juvNSKnK7I5Q0=;
        b=jL8rQp6Hvy65dLFqx+xznsHESedyRmcvA2n1x0ncCVQdD7MSGLoIfrdq6fHf1KDpmi
         IuRjwikhb21FUxfCHgo4Lj37v7cGTTNwJ+SEKFIqubZvIOZlIqoctl8l26oeKOJj07G5
         EiUqdCVHil2ZiwXiNEtJl3nIxUSS23wpoEA95gnGSSfhp430RDXVT3oY6Zmq28FUZYQM
         1m4EwfA9Xs+tCgVqTlVpstM+VBBHpZXondUMBGs6ZWDmm8m2j1GKXJ4vxOCzx5v/X20u
         qTRghWjifGdpMQtCsETf+nGTKErxBuyNFfEpjsk2/nWS7gt5NMwjis+7ckw41DOrF3LB
         T6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698789002; x=1699393802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GKyb1hV1vtUSZDqLnTgdX5n0+OXLN+juvNSKnK7I5Q0=;
        b=Ofs97hYxWbnC5jKKw8ee11LMEDNf2emddFDfl7I5jIEVOuvWJYdApU2FA/jGRnqewZ
         4NNsbST7YN/6yGCmFKL2XvoDRVh4qQ0Dv6Kqp0K4oJs2JIYxPZ4SiFP9VCFiC0dkwk2t
         cNYPz87ixB3V+tbyZA7dTXChKIsh3H78XTBwYjKhhkkFgVhpLm9gZWwZLaZNmsnLlB9O
         MQ+84vgxzLlECh7HSmhcWPWKNa7Fyv2T0un8JIqn7w6n03egm8BGXe/QuxKaKDipiEsn
         Lw/e7Nc8tUqImHCDl/VKvLCbCBTF1D8jnfxzSWZZP/biBP0OKvZR/5TS3F856naLTUQX
         1hpw==
X-Gm-Message-State: AOJu0Yyrt42Pmqlz46zfCwLD8IZgFg1MEvX6VySnKBK07+ophAQFv0gX
        +NYeTgPClvbay8wMSCm1mTdSbwprrjmFUBILlyTffQ==
X-Google-Smtp-Source: AGHT+IFryCasodoGUQr+d/4GX14lqOug/C63+v0x+SVaHw1GimgEBCDcf3pc/kFUY3kFJsdoKLmo/dqwwMQDTEbCNHk=
X-Received: by 2002:a5d:4fc9:0:b0:31f:9b4f:1910 with SMTP id
 h9-20020a5d4fc9000000b0031f9b4f1910mr9964196wrw.63.1698789002364; Tue, 31 Oct
 2023 14:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <20231031-tcp-ao-fix-label-in-compound-statement-warning-v1-1-c9731d115f17@kernel.org>
In-Reply-To: <20231031-tcp-ao-fix-label-in-compound-statement-warning-v1-1-c9731d115f17@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 31 Oct 2023 14:49:51 -0700
Message-ID: <CAKwvOd=CsF8B2i6f6d95J=n3zAZ7P2+bddBGBt0st=Q-f-OniA@mail.gmail.com>
Subject: Re: [PATCH net] tcp: Fix -Wc23-extensions in tcp_options_write()
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, trix@redhat.com,
        0x7f454c46@gmail.com, fruggeri@arista.com, noureddine@arista.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 1:23=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> Clang warns (or errors with CONFIG_WERROR=3Dy) when CONFIG_TCP_AO is set:
>
>   net/ipv4/tcp_output.c:663:2: error: label at end of compound statement =
is a C23 extension [-Werror,-Wc23-extensions]
>     663 |         }
>         |         ^
>   1 error generated.
>
> On earlier releases (such as clang-11, the current minimum supported
> version for building the kernel) that do not support C23, this was a
> hard error unconditionally:
>
>   net/ipv4/tcp_output.c:663:2: error: expected statement
>           }
>           ^
>   1 error generated.
>
> Add a semicolon after the label to create an empty statement, which
> resolves the warning or error for all compilers.
>
> Closes: https://github.com/ClangBuiltLinux/linux/issues/1953
> Fixes: 1e03d32bea8e ("net/tcp: Add TCP-AO sign to outgoing packets")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Well, at least ISO fixed that in C23...I found it annoying. One day we
might have nice things.  Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  net/ipv4/tcp_output.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index f558c054cf6e..6064895daece 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -658,7 +658,7 @@ static void tcp_options_write(struct tcphdr *th, stru=
ct tcp_sock *tp,
>                         memset(ptr, TCPOPT_NOP, sizeof(*ptr));
>                         ptr++;
>                 }
> -out_ao:
> +out_ao:;
>  #endif
>         }
>         if (unlikely(opts->mss)) {
>
> ---
> base-commit: 55c900477f5b3897d9038446f72a281cae0efd86
> change-id: 20231031-tcp-ao-fix-label-in-compound-statement-warning-ebd6c9=
978498
>
> Best regards,
> --
> Nathan Chancellor <nathan@kernel.org>
>


--=20
Thanks,
~Nick Desaulniers
