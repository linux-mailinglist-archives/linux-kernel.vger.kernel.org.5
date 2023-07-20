Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68E875B777
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 21:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjGTTIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 15:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjGTTHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 15:07:55 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E13173A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 12:07:52 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-40371070eb7so63501cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 12:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689880071; x=1690484871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4XG/fB8WpES5L9ZA04wwj/o6tX3jA1gLNRCsTQHJyI=;
        b=lHLZY3Ewd8Ty/3BcHCByP7EV4tgjVjwB9NSqtCgVqzs95PgXPyLDBRvrA7C2uJBnGP
         lnOwzsq3sqNxj9jEUP2/aVqPJFk4I9QWp/z+Uq+fI+Q/Xyh2zcO8BYvF+8gNYwhis8GX
         BcjfAYa+Wcnti46YaH3C+G45A79yR7/YR7di4XdREX7pbNR7g8dpW59GmEYKhigkvZqz
         wL+MHGGVgKLRUShoM6vlJaxdJqkMF673n+jvCweu6jJrujfqJzsmD+J9ZPlDlzbJr/zU
         g4nMAhm5+VYavMaJC1CbD3XFAMMGqv8i6cTVzbOBmhRKKID7TIERIAvYG/wyX6RgT2yn
         PQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689880071; x=1690484871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4XG/fB8WpES5L9ZA04wwj/o6tX3jA1gLNRCsTQHJyI=;
        b=bT5+rI/aeUyRptu5kkBVqO7tZWgyvM+J7Zh1tB1Eo82eMcpXuHZD1e2TiD5vh8L2PG
         Ii3vtSNz1GeC7RDTZhe/U4ndGurpBS8qFAz7OnZUda8DYVY0xp1aGKm0qIc+pUha1zJ7
         PZpj2HEM5bgnmRum+8l/KfYz5sb80PevT/nlw6lm3NMXNLGbnvtck+/5r5trw5SiQ14u
         3XQ/gbUr1J2MNssqqCLQg3qCysKwP3Pk0Z6H416m76iqKzv2ubr3IYDak2RykeUAJvui
         Gtor3+V/p2ZWMov/gz9NP5KHdPya0m/pdoRHWG5CZjUTLdBDBplANMBIIB5zVFmpGAf4
         rn/A==
X-Gm-Message-State: ABy/qLb/mtWg6pPZqrTRSEzeS3mlv+alhESnECJerLBpUWBUiGGGRrK+
        Q1ujSfMaeHIXVI5Xg1f0tz0TbFulcZ5nlY6QlPRXDw==
X-Google-Smtp-Source: APBJJlEur6cHnlzJHXbLUn2GBZ0Ah3NwAqthv5DSX4rSx/tBDaSx89c7j31E72vgVfMeFIXZvzcYQK3D0t4u03+tbqk=
X-Received: by 2002:a05:622a:1a87:b0:3f9:56c:1129 with SMTP id
 s7-20020a05622a1a8700b003f9056c1129mr31665qtc.5.1689880071131; Thu, 20 Jul
 2023 12:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230720-upstream-net-next-20230720-mptcp-fix-rcv-buffer-auto-tuning-v1-1-175ef12b8380@tessares.net>
In-Reply-To: <20230720-upstream-net-next-20230720-mptcp-fix-rcv-buffer-auto-tuning-v1-1-175ef12b8380@tessares.net>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 20 Jul 2023 21:07:39 +0200
Message-ID: <CANn89iL-tLZwjYPqmXx9-DbSHV9=epEK9iahqjwu=nsyW_tVrg@mail.gmail.com>
Subject: Re: [PATCH net-next] mptcp: fix rcv buffer auto-tuning
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Mat Martineau <martineau@kernel.org>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, Jul 20, 2023 at 8:48=E2=80=AFPM Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> From: Paolo Abeni <pabeni@redhat.com>
>
> The MPTCP code uses the assumption that the tcp_win_from_space() helper
> does not use any TCP-specific field, and thus works correctly operating
> on an MPTCP socket.
>
> The commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
> broke such assumption, and as a consequence most MPTCP connections stall
> on zero-window event due to auto-tuning changing the rcv buffer size
> quite randomly.
>
> Address the issue syncing again the MPTCP auto-tuning code with the TCP
> one. To achieve that, factor out the windows size logic in socket
> independent helpers, and reuse them in mptcp_rcv_space_adjust(). The
> MPTCP level scaling_ratio is selected as the minimum one from the all
> the subflows, as a worst-case estimate.
>
> Fixes: dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>  include/net/tcp.h    | 20 +++++++++++++++-----
>  net/mptcp/protocol.c | 15 +++++++--------
>  net/mptcp/protocol.h |  8 +++++++-
>  net/mptcp/subflow.c  |  2 +-
>  4 files changed, 30 insertions(+), 15 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index c5fb90079920..794642fbd724 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1430,22 +1430,32 @@ void tcp_select_initial_window(const struct sock =
*sk, int __space,
>                                __u32 *window_clamp, int wscale_ok,
>                                __u8 *rcv_wscale, __u32 init_rcv_wnd);
>
> -static inline int tcp_win_from_space(const struct sock *sk, int space)
> +static inline int __tcp_win_from_space(u8 scaling_ratio, int space)
>  {
> -       s64 scaled_space =3D (s64)space * tcp_sk(sk)->scaling_ratio;
> +       s64 scaled_space =3D (s64)space * scaling_ratio;
>
>         return scaled_space >> TCP_RMEM_TO_WIN_SCALE;
>  }
>
> -/* inverse of tcp_win_from_space() */
> -static inline int tcp_space_from_win(const struct sock *sk, int win)
> +static inline int tcp_win_from_space(const struct sock *sk, int space)

Maybe in a follow up patch we could change the prototype of this helper
to avoid future mis use :)

static inline int tcp_win_from_space(const struct tcp_sock *tp, int space)
{
}

Reviewed-by: Eric Dumazet <edumazet@google.com>


> +{
> +       return __tcp_win_from_space(tcp_sk(sk)->scaling_ratio, space);
> +}
> +
> +/* inverse of __tcp_win_from_space() */
> +static inline int __tcp_space_from_win(u8 scaling_ratio, int win)
>  {
>         u64 val =3D (u64)win << TCP_RMEM_TO_WIN_SCALE;
>
> -       do_div(val, tcp_sk(sk)->scaling_ratio);
> +       do_div(val, scaling_ratio);
>         return val;
>  }
>
> +static inline int tcp_space_from_win(const struct sock *sk, int win

Same remark here.

Thanks for the fix !
