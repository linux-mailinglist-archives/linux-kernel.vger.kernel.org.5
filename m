Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA72773007
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 22:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjHGUAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 16:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjHGUAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 16:00:38 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D5DE66
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 13:00:37 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-79a2216a2d1so1328405241.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 13:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691438436; x=1692043236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVQdRv1Yvag9pZf4ApwFuqYgv2RsqMJxrynRlvroKKI=;
        b=OfneyUN/2lerRgrz+LIZo4dK4kbguaa6/Vk3KCO8tPslYWmyMT0iw2hGT3DjJhMtPW
         +cXO8gED1UB4/QDs8B+gSQJuG1LuSkgcEaoY/W7Ir/NnGfS2aCUxUhElndRMvxe26+PY
         p+J0HeEO1KC3C7NxI/hNU6L2oH8zZi6exeqbHDfvIaPihhCrnGPQN060l+N9kzB4f+po
         t8XcRQGm1ccOtyq9pheseBUNMDq8R4jUTaVP1VOm3H6wT2OIryggbq/jcM/xZHErj187
         1Bv5P4B/bFGSl3cNjovdYXeuzQVfuoC+abgfQn7/2S4Gce3GZ/C4+6pol3Jq/NzEZE/5
         F9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691438436; x=1692043236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mVQdRv1Yvag9pZf4ApwFuqYgv2RsqMJxrynRlvroKKI=;
        b=fmVQOWkLvz0UvPwq/QBZr5aNGMsqY/i5iEd7Q3qD8vAZ9GhzQTikx9m7glsgDkdMaN
         8Zhi4VKisnbgqVZwwadebxjX/yi8vdWi3g0rPlf9u+bOEn51MpxQhEfwtM3dRIQgdk+J
         cJaHX1qC/R7VwBE5Ol8O8+NtoLjoirDDC/Ayz1j7MnYIB+Q2qDskqgKdtqjdUyATjobE
         ObFpcXrtuF7dRuTiFpuOxT+kHtuc9PDkosGUpT4C3E8ucRQyZ4XhvCKsk9FGEDxFvONr
         FjxZv2Fss5XPTnTRRN6lixVLG9eHYxNV/q6Dum0tXv3lF6jvtC+8J5DldTt0fgNhsqUs
         SqpA==
X-Gm-Message-State: AOJu0YyFmZEkDPP/Yj6YD28j7Gs6mXpZVUQ6xwUPeuSlbjjRZTm18qPV
        rqJNZ7MJ64OZ4EkK0jIHCGn+0ioTsh3iUINC6NM7Ng==
X-Google-Smtp-Source: AGHT+IEjizJJCB4nnVxo3w+/QZ+ihPBzKEyUWREcezwYPLVdOJJlDAIz2ug7nc/eYnPsuXNuBnjo8muQh7/Fjn3MnQs=
X-Received: by 2002:a67:e3b7:0:b0:444:eedd:1aea with SMTP id
 j23-20020a67e3b7000000b00444eedd1aeamr4591925vsm.17.1691438436080; Mon, 07
 Aug 2023 13:00:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230807183308.9015-1-me@manjusaka.me>
In-Reply-To: <20230807183308.9015-1-me@manjusaka.me>
From:   Neal Cardwell <ncardwell@google.com>
Date:   Mon, 7 Aug 2023 16:00:18 -0400
Message-ID: <CADVnQyn3UMa3Qx6cC1Rx97xLjQdG0eKsiF7oY9UR=b9vU4R-yA@mail.gmail.com>
Subject: Re: [PATCH] tracepoint: add new `tcp:tcp_ca_event_set` trace event
To:     Manjusaka <me@manjusaka.me>
Cc:     edumazet@google.com, mhiramat@kernel.org, rostedt@goodmis.org,
        davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 2:33=E2=80=AFPM Manjusaka <me@manjusaka.me> wrote:
>
> In normal use case, the tcp_ca_event would be changed in high frequency.
>
> It's a good indicator to represent the network quanlity.
>
> So I propose to add a `tcp:tcp_ca_event_set` trace event
> like `tcp:tcp_cong_state_set` to help the people to
> trace the TCP connection status
>
> Signed-off-by: Manjusaka <me@manjusaka.me>
> ---
>  include/net/tcp.h          |  9 ++------
>  include/trace/events/tcp.h | 45 ++++++++++++++++++++++++++++++++++++++
>  net/ipv4/tcp_cong.c        | 10 +++++++++
>  3 files changed, 57 insertions(+), 7 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 0ca972ebd3dd..a68c5b61889c 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1154,13 +1154,8 @@ static inline bool tcp_ca_needs_ecn(const struct s=
ock *sk)
>         return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ECN;
>  }
>
> -static inline void tcp_ca_event(struct sock *sk, const enum tcp_ca_event=
 event)
> -{
> -       const struct inet_connection_sock *icsk =3D inet_csk(sk);
> -
> -       if (icsk->icsk_ca_ops->cwnd_event)
> -               icsk->icsk_ca_ops->cwnd_event(sk, event);
> -}
> +/* from tcp_cong.c */
> +void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event);
>
>  /* From tcp_cong.c */
>  void tcp_set_ca_state(struct sock *sk, const u8 ca_state);
> diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
> index bf06db8d2046..38415c5f1d52 100644
> --- a/include/trace/events/tcp.h
> +++ b/include/trace/events/tcp.h
> @@ -416,6 +416,51 @@ TRACE_EVENT(tcp_cong_state_set,
>                   __entry->cong_state)
>  );
>
> +TRACE_EVENT(tcp_ca_event_set,

Regarding the proposed name, "tcp_ca_event_set"... including "set" in
the name is confusing, since the tcp_ca_event() function is not really
setting anything. :-)

The trace_tcp_cong_state_set() call you are using as a model has "set"
in the name because the function it is tracing, tcp_set_ca_state(),
has "set" in the name. :-)

Would it work to use something like:
  TRACE_EVENT(tcp_ca_event,

thanks,
neal
