Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF7879D6B1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237064AbjILQr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237058AbjILQrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:47:55 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E346B10EB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:47:51 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-414c54b2551so2671cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694537271; x=1695142071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vid4Q5WdrCjtRvV0k//R+ixoDMHvNh7id2xUYkks+Zs=;
        b=mG2uzijTz7+4Y/BVP0oL3tt93i1nODRvFT93aGXR/ST+TDWpEjOvpsfh1j5vqJo3yD
         tCJprtGtBg8PfzJDHUrd8OS7oWz+L6t/DWCqknppCdKjlKmZkvrqSJdRJBBUG1bG7YSi
         yWteg8hq1uKxv5gKRu9Hy30ssUip2Z3nhFdGMdLngEyZE5Oeyr4fGTEqy30tMtsHhkIn
         orKmJGbGTSFbIQ+OdBPgGNJSu9YLEG/d+coVD2RpKddEzpqb5IMaZ03mBTk9OLMT9+F0
         Rd9oBLckJWhsMD9dhiwyjtzKIgyeWRMXvn2sG5ZRvVC3jA9rQfUu/Ps79tW36TCAFwXk
         51+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694537271; x=1695142071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vid4Q5WdrCjtRvV0k//R+ixoDMHvNh7id2xUYkks+Zs=;
        b=m1s2qJUAiG1kdg1JKgqp8wSS5fa0So9UDB6sW2A7LmDYuCWDIJZ7Otz+gkoOjhqQPv
         ND11oLNdjU++qo3fYJU/SEg8Vax5JnO2XpzBls+Hs8zF6GbpWUxwM6xWl3h56AAAtZV1
         BaPiy7mTEaTWOfFXeFQE3V5xtYdvQGQKFNVNcKhSGpZT0bZZ1iamCa3kknQ6BJjauGU+
         e5jPo7lWK6KdxJkwEpM+FPY6kmi0Pv38brC8oMfrv0szmi9HlRmD8gFyXFWY72GZXOO1
         +bKBPe/q0/50QTWNzWKrtzOKsFEfkQTmeCfDdD1ObUldFh4KiKrzsTxMxaY8lOePELCV
         XETw==
X-Gm-Message-State: AOJu0YxBZr3jIqbnLZ/gAupbMMfUvgi2EB6Gmsw/V6yLzOa5PF59w36Q
        67+IFFw9RSxuzD7w9kTI/XsPkl4twppc+VV1jNUb1Oj19M1jfXXK/Y8=
X-Google-Smtp-Source: AGHT+IE2yuJcF7vhKNuB0+IL8Tpogc2b8hZX8KMHRHTaRnnHK0jI7C9Zpy7SztKsCTduWqfNm85s/slFKJ857xvV3dY=
X-Received: by 2002:a05:622a:152:b0:3f6:97b4:1a4d with SMTP id
 v18-20020a05622a015200b003f697b41a4dmr233375qtw.23.1694537270750; Tue, 12 Sep
 2023 09:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230911210346.301750-1-dima@arista.com> <20230911210346.301750-12-dima@arista.com>
In-Reply-To: <20230911210346.301750-12-dima@arista.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 12 Sep 2023 18:47:39 +0200
Message-ID: <CANn89i+gs2oNDWL-w+ZUfNAYZ3GXf6RqN3wyr+4YqiQm7jq+1w@mail.gmail.com>
Subject: Re: [PATCH v11 net-next 11/23] net/tcp: Sign SYN-ACK segments with TCP-AO
To:     Dmitry Safonov <dima@arista.com>
Cc:     David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Bob Gilligan <gilligan@arista.com>,
        Dan Carpenter <error27@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Donald Cassidy <dcassidy@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        "Gaillardetz, Dominik" <dgaillar@ciena.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ivan Delalande <colona@arista.com>,
        Leonard Crestez <cdleonard@gmail.com>,
        "Nassiri, Mohammad" <mnassiri@ciena.com>,
        Salam Noureddine <noureddine@arista.com>,
        Simon Horman <simon.horman@corigine.com>,
        "Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 11:04=E2=80=AFPM Dmitry Safonov <dima@arista.com> w=
rote:
>
> Similarly to RST segments, wire SYN-ACKs to TCP-AO.
> tcp_rsk_used_ao() is handy here to check if the request socket used AO
> and needs a signature on the outgoing segments.
>
> Co-developed-by: Francesco Ruggeri <fruggeri@arista.com>
> Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
> Co-developed-by: Salam Noureddine <noureddine@arista.com>
> Signed-off-by: Salam Noureddine <noureddine@arista.com>
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> Acked-by: David Ahern <dsahern@kernel.org>
> ---
>  include/net/tcp.h     |  3 +++
>  include/net/tcp_ao.h  |  6 +++++
>  net/ipv4/tcp_ao.c     | 22 +++++++++++++++++
>  net/ipv4/tcp_ipv4.c   |  1 +
>  net/ipv4/tcp_output.c | 57 ++++++++++++++++++++++++++++++++++++++-----
>  net/ipv6/tcp_ao.c     | 22 +++++++++++++++++
>  net/ipv6/tcp_ipv6.c   |  1 +
>  7 files changed, 106 insertions(+), 6 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 5daa2e98e6a3..56f4180443c7 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2179,6 +2179,9 @@ struct tcp_request_sock_ops {
>                                         struct request_sock *req,
>                                         int sndid, int rcvid);
>         int (*ao_calc_key)(struct tcp_ao_key *mkt, u8 *key, struct reques=
t_sock *sk);
> +       int (*ao_synack_hash)(char *ao_hash, struct tcp_ao_key *mkt,
> +                             struct request_sock *req, const struct sk_b=
uff *skb,
> +                             int hash_offset, u32 sne);
>  #endif
>  #ifdef CONFIG_SYN_COOKIES
>         __u32 (*cookie_init_seq)(const struct sk_buff *skb,
> diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
> index d26d98f1b048..c922d2e31d08 100644
> --- a/include/net/tcp_ao.h
> +++ b/include/net/tcp_ao.h
> @@ -144,6 +144,9 @@ int tcp_ao_prepare_reset(const struct sock *sk, struc=
t sk_buff *skb,
>  int tcp_v4_parse_ao(struct sock *sk, int cmd, sockptr_t optval, int optl=
en);
>  struct tcp_ao_key *tcp_v4_ao_lookup(const struct sock *sk, struct sock *=
addr_sk,
>                                     int sndid, int rcvid);
> +int tcp_v4_ao_synack_hash(char *ao_hash, struct tcp_ao_key *mkt,
> +                         struct request_sock *req, const struct sk_buff =
*skb,
> +                         int hash_offset, u32 sne);
>  int tcp_v4_ao_calc_key_sk(struct tcp_ao_key *mkt, u8 *key,
>                           const struct sock *sk,
>                           __be32 sisn, __be32 disn, bool send);
> @@ -178,6 +181,9 @@ int tcp_v6_ao_hash_skb(char *ao_hash, struct tcp_ao_k=
ey *key,
>                        const struct sock *sk, const struct sk_buff *skb,
>                        const u8 *tkey, int hash_offset, u32 sne);
>  int tcp_v6_parse_ao(struct sock *sk, int cmd, sockptr_t optval, int optl=
en);
> +int tcp_v6_ao_synack_hash(char *ao_hash, struct tcp_ao_key *ao_key,
> +                         struct request_sock *req, const struct sk_buff =
*skb,
> +                         int hash_offset, u32 sne);
>  void tcp_ao_finish_connect(struct sock *sk, struct sk_buff *skb);
>  void tcp_ao_connect_init(struct sock *sk);
>  void tcp_ao_syncookie(struct sock *sk, const struct sk_buff *skb,
> diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
> index b114f3d901a0..0d8ea381300b 100644
> --- a/net/ipv4/tcp_ao.c
> +++ b/net/ipv4/tcp_ao.c
> @@ -568,6 +568,28 @@ int tcp_v4_ao_hash_skb(char *ao_hash, struct tcp_ao_=
key *key,
>                                tkey, hash_offset, sne);
>  }
>
> +int tcp_v4_ao_synack_hash(char *ao_hash, struct tcp_ao_key *ao_key,
> +                         struct request_sock *req, const struct sk_buff =
*skb,
> +                         int hash_offset, u32 sne)
> +{
> +       void *hash_buf =3D NULL;
> +       int err;
> +
> +       hash_buf =3D kmalloc(tcp_ao_digest_size(ao_key), GFP_ATOMIC);
> +       if (!hash_buf)
> +               return -ENOMEM;
> +
> +       err =3D tcp_v4_ao_calc_key_rsk(ao_key, hash_buf, req);
> +       if (err)
> +               goto out;
> +
> +       err =3D tcp_ao_hash_skb(AF_INET, ao_hash, ao_key, req_to_sk(req),=
 skb,
> +                             hash_buf, hash_offset, sne);
> +out:
> +       kfree(hash_buf);
> +       return err;
> +}
> +
>  struct tcp_ao_key *tcp_v4_ao_lookup_rsk(const struct sock *sk,
>                                         struct request_sock *req,
>                                         int sndid, int rcvid)
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 9a4ffcc965f3..c40da33d988b 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -1675,6 +1675,7 @@ const struct tcp_request_sock_ops tcp_request_sock_=
ipv4_ops =3D {
>  #ifdef CONFIG_TCP_AO
>         .ao_lookup      =3D       tcp_v4_ao_lookup_rsk,
>         .ao_calc_key    =3D       tcp_v4_ao_calc_key_rsk,
> +       .ao_synack_hash =3D       tcp_v4_ao_synack_hash,
>  #endif
>  #ifdef CONFIG_SYN_COOKIES
>         .cookie_init_seq =3D      cookie_v4_init_sequence,
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 44c97e6ddd50..c9d6decef443 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -900,6 +900,7 @@ static unsigned int tcp_synack_options(const struct s=
ock *sk,
>                                        unsigned int mss, struct sk_buff *=
skb,
>                                        struct tcp_out_options *opts,
>                                        const struct tcp_md5sig_key *md5,
> +                                      const struct tcp_ao_key *ao,
>                                        struct tcp_fastopen_cookie *foc,
>                                        enum tcp_synack_type synack_type,
>                                        struct sk_buff *syn_skb)
> @@ -921,6 +922,14 @@ static unsigned int tcp_synack_options(const struct =
sock *sk,
>                         ireq->tstamp_ok &=3D !ireq->sack_ok;
>         }
>  #endif
> +#ifdef CONFIG_TCP_AO
> +       if (ao) {
> +               opts->options |=3D OPTION_AO;
> +               remaining -=3D tcp_ao_len(ao);
> +               ireq->tstamp_ok &=3D !ireq->sack_ok;
> +       }
> +#endif
> +       WARN_ON_ONCE(md5 && ao);
>
>         /* We always send an MSS option. */
>         opts->mss =3D mss;
> @@ -3727,6 +3736,7 @@ struct sk_buff *tcp_make_synack(const struct sock *=
sk, struct dst_entry *dst,
>         struct inet_request_sock *ireq =3D inet_rsk(req);
>         const struct tcp_sock *tp =3D tcp_sk(sk);
>         struct tcp_md5sig_key *md5 =3D NULL;
> +       struct tcp_ao_key *ao_key =3D NULL;
>         struct tcp_out_options opts;
>         struct sk_buff *skb;
>         int tcp_header_size;
> @@ -3777,16 +3787,43 @@ struct sk_buff *tcp_make_synack(const struct sock=
 *sk, struct dst_entry *dst,
>                         tcp_rsk(req)->snt_synack =3D tcp_skb_timestamp_us=
(skb);
>         }
>
> -#ifdef CONFIG_TCP_MD5SIG
> +#if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
>         rcu_read_lock();
> -       md5 =3D tcp_rsk(req)->af_specific->req_md5_lookup(sk, req_to_sk(r=
eq));
>  #endif
> +       if (tcp_rsk_used_ao(req)) {
> +#ifdef CONFIG_TCP_AO
> +               u8 maclen =3D tcp_rsk(req)->maclen;
> +               u8 keyid =3D tcp_rsk(req)->ao_keyid;
> +
> +               ao_key =3D tcp_sk(sk)->af_specific->ao_lookup(sk, req_to_=
sk(req),
> +                                                           keyid, -1);
> +               /* If there is no matching key - avoid sending anything,
> +                * especially usigned segments. It could try harder and l=
ookup
> +                * for another peer-matching key, but the peer has reques=
ted
> +                * ao_keyid (RFC5925 RNextKeyID), so let's keep it simple=
 here.
> +                */
> +               if (unlikely(!ao_key || tcp_ao_maclen(ao_key) !=3D maclen=
)) {
> +                       rcu_read_unlock();
> +                       skb_dst_drop(skb);

This does look necessary ? kfree_skb(skb) should also skb_dst_drop(skb);


> +                       kfree_skb(skb);
> +                       net_warn_ratelimited("TCP-AO: the keyid %u with m=
aclen %u|%u from SYN packet is not present - not sending SYNACK\n",
> +                                            keyid, maclen,
> +                                            ao_key ? tcp_ao_maclen(ao_ke=
y) : 0);

dereferencing ao_key after rcu_read_unlock() is a bug.


> +                       return NULL;
> +               }
> +#endif
> +       } else {
> +#ifdef CONFIG_TCP_MD5SIG
> +               md5 =3D tcp_rsk(req)->af_specific->req_md5_lookup(sk,
> +                                                               req_to_sk=
(req));
> +#endif
> +       }
>         skb_set_hash(skb, READ_ONCE(tcp_rsk(req)->txhash), PKT_HASH_TYPE_=
L4);
>         /* bpf program will be interested in the tcp_flags */
>         TCP_SKB_CB(skb)->tcp_flags =3D TCPHDR_SYN | TCPHDR_ACK;
>         tcp_header_size =3D tcp_synack_options(sk, req, mss, skb, &opts, =
md5,
> -                                            foc, synack_type,
> -                                            syn_skb) + sizeof(*th);
> +                                            ao_key, foc, synack_type, sy=
n_skb)
> +                                       + sizeof(*th);
>
>         skb_push(skb, tcp_header_size);
>         skb_reset_transport_header(skb);
> @@ -3806,7 +3843,7 @@ struct sk_buff *tcp_make_synack(const struct sock *=
sk, struct dst_entry *dst,
>
>         /* RFC1323: The window in SYN & SYN/ACK segments is never scaled.=
 */
>         th->window =3D htons(min(req->rsk_rcv_wnd, 65535U));
> -       tcp_options_write(th, NULL, NULL, &opts, NULL);
> +       tcp_options_write(th, NULL, tcp_rsk(req), &opts, ao_key);
>         th->doff =3D (tcp_header_size >> 2);
>         TCP_INC_STATS(sock_net(sk), TCP_MIB_OUTSEGS);
>
> @@ -3814,7 +3851,15 @@ struct sk_buff *tcp_make_synack(const struct sock =
*sk, struct dst_entry *dst,
>         /* Okay, we have all we need - do the md5 hash if needed */
>         if (md5)
>                 tcp_rsk(req)->af_specific->calc_md5_hash(opts.hash_locati=
on,
> -                                              md5, req_to_sk(req), skb);
> +                                       md5, req_to_sk(req), skb);
> +#endif
> +#ifdef CONFIG_TCP_AO
> +       if (ao_key)
> +               tcp_rsk(req)->af_specific->ao_synack_hash(opts.hash_locat=
ion,
> +                                       ao_key, req, skb,
> +                                       opts.hash_location - (u8 *)th, 0)=
;
> +#endif
> +#if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
>         rcu_read_unlock();
>  #endif
>
> diff --git a/net/ipv6/tcp_ao.c b/net/ipv6/tcp_ao.c
> index c9a6fa84f6ce..99753e12c08c 100644
> --- a/net/ipv6/tcp_ao.c
> +++ b/net/ipv6/tcp_ao.c
> @@ -144,3 +144,25 @@ int tcp_v6_parse_ao(struct sock *sk, int cmd,
>  {
>         return tcp_parse_ao(sk, cmd, AF_INET6, optval, optlen);
>  }
> +
> +int tcp_v6_ao_synack_hash(char *ao_hash, struct tcp_ao_key *ao_key,
> +                         struct request_sock *req, const struct sk_buff =
*skb,
> +                         int hash_offset, u32 sne)
> +{
> +       void *hash_buf =3D NULL;
> +       int err;
> +
> +       hash_buf =3D kmalloc(tcp_ao_digest_size(ao_key), GFP_ATOMIC);
> +       if (!hash_buf)
> +               return -ENOMEM;
> +
> +       err =3D tcp_v6_ao_calc_key_rsk(ao_key, hash_buf, req);
> +       if (err)
> +               goto out;
> +
> +       err =3D tcp_ao_hash_skb(AF_INET6, ao_hash, ao_key, req_to_sk(req)=
, skb,
> +                             hash_buf, hash_offset, sne);
> +out:
> +       kfree(hash_buf);
> +       return err;
> +}
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index c060cd964f91..f57617d2921a 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -845,6 +845,7 @@ const struct tcp_request_sock_ops tcp_request_sock_ip=
v6_ops =3D {
>  #ifdef CONFIG_TCP_AO
>         .ao_lookup      =3D       tcp_v6_ao_lookup_rsk,
>         .ao_calc_key    =3D       tcp_v6_ao_calc_key_rsk,
> +       .ao_synack_hash =3D       tcp_v6_ao_synack_hash,
>  #endif
>  #ifdef CONFIG_SYN_COOKIES
>         .cookie_init_seq =3D      cookie_v6_init_sequence,
> --
> 2.41.0
>
