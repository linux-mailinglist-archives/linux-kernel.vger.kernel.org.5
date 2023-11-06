Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1319A7E2923
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbjKFPxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 10:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjKFPxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:53:10 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D77107
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 07:53:07 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-54357417e81so17965a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 07:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699285986; x=1699890786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6syFkOkzLnfb93pqUdkybgBOtg/N3wCP/cuWLdw+Zf4=;
        b=ocnPkCEUOEW4KJlh0Jk9QzF+I8rHG9jY3pEa4otP6Og5xA2KT6hWQ1QBh3SmUqazJg
         +sR+TfSQ42QHKvpAswwQ1TQcbvxuKJOYConM4Uun9lCiNy7xVCgQiZYlo4HgOYpMuGEN
         O/N4bprG6hNVdnOgotjyxvwE2L79tinCB9Odeei8Ewj4IxpFIsgw1BjrkdZMRlk1PafW
         lm18SveRDU5iHRe70v37WOW6RIxcm1kaCZ/SN2inDbB8PN1mF7mCBHgGLEaTM3ANZa4T
         M5fp2smFwic7z76a8kMelstOm4TFpTSjYg8Mx/BIY93d+Qb5bR9YR7u5jOlUQGqDjGrY
         AbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699285986; x=1699890786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6syFkOkzLnfb93pqUdkybgBOtg/N3wCP/cuWLdw+Zf4=;
        b=dApYhdvamOknLGPAYyy2Eb66TI7QkwmHkQSQoDaUe54UPKV0b/1UDRpPX2sRAKi5sm
         mWujbNNYSgXxBt+/Z3JjkfUJI1lfULuiebsKIcFt+4oL+SAbuIhShrChCDUQKAndCkQ2
         INrdFrjAhzNqSmJxbOWZshAV7ES2YG8aNmAquFPFO0sLI09dhNI1+GRd8Vr7dDKW38Y0
         zaq2LOTXdiQNJWjhXCb1TXk49Qqhp28+1QEPtqcY2EBL+EG7qixiZ3YjOIvg6iwH0OeA
         OkjE91Btgu0mpE3ti0vvn3zlZTm5PFHVesC4PvKjS7F5hTzLjCz0dXHnAzcQam8Qp/zn
         gIyA==
X-Gm-Message-State: AOJu0Yx1raB0Y1W1p1A96Agnlra6xZAbjEiyNJrY2augQdOe+m+a22nx
        NUrZGORb/2AjbNSPTpUbNzP+co3XTouKGEJNAygYqw==
X-Google-Smtp-Source: AGHT+IEpYdcYOXsn5hs+ijdf301SEE6NJW2pTTs2hdWOXzeGxp8BhkVC5mqmhfLbIBT4urwWKe2HlDI01ut3Z0gY5g0=
X-Received: by 2002:a05:6402:f0d:b0:544:4762:608 with SMTP id
 i13-20020a0564020f0d00b0054447620608mr211814eda.2.1699285985971; Mon, 06 Nov
 2023 07:53:05 -0800 (PST)
MIME-Version: 1.0
References: <20231106-tcp-ao-fix-label-in-compound-statement-warning-v2-1-91eff6e1648c@kernel.org>
In-Reply-To: <20231106-tcp-ao-fix-label-in-compound-statement-warning-v2-1-91eff6e1648c@kernel.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 6 Nov 2023 16:52:52 +0100
Message-ID: <CANn89i+GF=4QuVMevE7Ur2Zi0nDjBujMHWJayURR9fbcr+McnA@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: Fix -Wc23-extensions in tcp_options_write()
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, ndesaulniers@google.com, trix@redhat.com,
        0x7f454c46@gmail.com, noureddine@arista.com, hch@infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 6, 2023 at 4:36=E2=80=AFPM Nathan Chancellor <nathan@kernel.org=
> wrote:
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
> While adding a semicolon after the label would resolve this, it is more
> in line with the kernel as a whole to refactor this block into a
> standalone function, which means the goto a label construct can just be
> replaced with a simple return. Do so to resolve the warning.
>
> Closes: https://github.com/ClangBuiltLinux/linux/issues/1953
> Fixes: 1e03d32bea8e ("net/tcp: Add TCP-AO sign to outgoing packets")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> Please let me know if this function should have a different name. I
> think I got all the changes of the function shuffle correct but some
> testing would be appreciated.
>
> Changes in v2:
> - Break out problematic block into its own function so that goto can be
>   replaced with a simple return, instead of the simple semicolon
>   approach of v1 (Christoph)
> - Link to v1: https://lore.kernel.org/r/20231031-tcp-ao-fix-label-in-comp=
ound-statement-warning-v1-1-c9731d115f17@kernel.org
> ---
>  net/ipv4/tcp_output.c | 69 ++++++++++++++++++++++++++++-----------------=
------
>  1 file changed, 38 insertions(+), 31 deletions(-)
>
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 0d8dd5b7e2e5..3f8dc74fbf40 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -601,6 +601,43 @@ static void bpf_skops_write_hdr_opt(struct sock *sk,=
 struct sk_buff *skb,
>  }
>  #endif
>
> +static void process_tcp_ao_options(struct tcp_sock *tp,
> +                                  const struct tcp_request_sock *tcprsk,
> +                                  struct tcp_out_options *opts,
> +                                  struct tcp_out_options *opts,

ptr has a different type than in the caller, this is a bit confusing

I would use

static __be32 * process_tcp_ao_options(struct tcp_sock *tp, const
struct tcp_request_sock *tcprsk,
                  struct tcp_out_options *opts,struct tcp_key *key, __be32 =
*ptr)

> +{
> +#ifdef CONFIG_TCP_AO
> +       u8 maclen =3D tcp_ao_maclen(key->ao_key);
> +
> +       if (tcprsk) {
> +               u8 aolen =3D maclen + sizeof(struct tcp_ao_hdr);
> +
> +               *(*ptr)++ =3D htonl((TCPOPT_AO << 24) | (aolen << 16) |
> +                                 (tcprsk->ao_keyid << 8) |
> +                                 (tcprsk->ao_rcv_next));


                 *ptr++ =3D ...

(and in all other *ptr uses in this helper)

> +       } else {
> +               struct tcp_ao_key *rnext_key;
> +               struct tcp_ao_info *ao_info;
> +
> +               ao_info =3D rcu_dereference_check(tp->ao_info,
> +                       lockdep_sock_is_held(&tp->inet_conn.icsk_inet.sk)=
);
> +               rnext_key =3D READ_ONCE(ao_info->rnext_key);
> +               if (WARN_ON_ONCE(!rnext_key))
> +                       return;
> +               *(*ptr)++ =3D htonl((TCPOPT_AO << 24) |
> +                                 (tcp_ao_len(key->ao_key) << 16) |
> +                                 (key->ao_key->sndid << 8) |
> +                                 (rnext_key->rcvid));
> +       }
> +       opts->hash_location =3D (__u8 *)(*ptr);
> +       *ptr +=3D maclen / sizeof(**ptr);
> +       if (unlikely(maclen % sizeof(**ptr))) {
> +               memset(*ptr, TCPOPT_NOP, sizeof(**ptr));
> +               (*ptr)++;
> +       }
> +#endif

    return ptr;
+}
> +
>  /* Write previously computed TCP options to the packet.
>   *
>   * Beware: Something in the Internet is very sensitive to the ordering o=
f
> @@ -629,37 +666,7 @@ static void tcp_options_write(struct tcphdr *th, str=
uct tcp_sock *tp,
>                 opts->hash_location =3D (__u8 *)ptr;
>                 ptr +=3D 4;
>         } else if (tcp_key_is_ao(key)) {
> -#ifdef CONFIG_TCP_AO
> -               u8 maclen =3D tcp_ao_maclen(key->ao_key);
> -
> -               if (tcprsk) {
> -                       u8 aolen =3D maclen + sizeof(struct tcp_ao_hdr);
> -
> -                       *ptr++ =3D htonl((TCPOPT_AO << 24) | (aolen << 16=
) |
> -                                      (tcprsk->ao_keyid << 8) |
> -                                      (tcprsk->ao_rcv_next));
> -               } else {
> -                       struct tcp_ao_key *rnext_key;
> -                       struct tcp_ao_info *ao_info;
> -
> -                       ao_info =3D rcu_dereference_check(tp->ao_info,
> -                               lockdep_sock_is_held(&tp->inet_conn.icsk_=
inet.sk));
> -                       rnext_key =3D READ_ONCE(ao_info->rnext_key);
> -                       if (WARN_ON_ONCE(!rnext_key))
> -                               goto out_ao;
> -                       *ptr++ =3D htonl((TCPOPT_AO << 24) |
> -                                      (tcp_ao_len(key->ao_key) << 16) |
> -                                      (key->ao_key->sndid << 8) |
> -                                      (rnext_key->rcvid));
> -               }
> -               opts->hash_location =3D (__u8 *)ptr;
> -               ptr +=3D maclen / sizeof(*ptr);
> -               if (unlikely(maclen % sizeof(*ptr))) {
> -                       memset(ptr, TCPOPT_NOP, sizeof(*ptr));
> -                       ptr++;
> -               }
> -out_ao:
> -#endif
> +               process_tcp_ao_options(tp, tcprsk, opts, key, &ptr);

ptr =3D process_tcp_ao_options(tp, tcprsk, opts, key, ptr);


>         }
>         if (unlikely(opts->mss)) {
>                 *ptr++ =3D htonl((TCPOPT_MSS << 24) |
>
> ---
> base-commit: c1ed833e0b3b7b9edc82b97b73b2a8a10ceab241
> change-id: 20231031-tcp-ao-fix-label-in-compound-statement-warning-ebd6c9=
978498
>
> Best regards,
> --
> Nathan Chancellor <nathan@kernel.org>
>
