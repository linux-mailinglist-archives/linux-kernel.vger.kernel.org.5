Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C734379D6AF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237014AbjILQro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbjILQrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:47:43 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7B910DF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:47:39 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-414c54b2551so2491cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694537258; x=1695142058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ehpX9BfbgXqCF1Af060UpK2vzcF1TCiYWjhg7jpBIUc=;
        b=ZJobHiEWJ0lG2SEIxjt1bva0/GeHJarFtj2T7VIZg9cbskO0fsqEAQN9NjIylQBnDT
         v+dINflkKciOaLDONovhw8dyM66tTlX6Dar1V109VDh53CoUvjaPoWqJnlZ4LN+cXMOF
         AQvU3wZFhU1HMalGa+wd0KOAefUlhSb4yy5xumRB8qATZRTR0XSSQlZgKOt9yrui0ZIv
         wI1pFEiu4l4yfWKYoCBPqfXdxw0JC4TBLv2B9Ns2Kfqs3snljPYVRw8TK9UymfIahj2N
         5AOWUTKXOthsOqTHESDEWURQfqx1f8XoYY3hKhyKXBrX+2pf3eU2yBMS01FleIdh0cXY
         9A9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694537258; x=1695142058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ehpX9BfbgXqCF1Af060UpK2vzcF1TCiYWjhg7jpBIUc=;
        b=lAvEHw4l1rlLHm+cdDRIguEUHvcybNN7pNajCLtPHPAjeplhE6ueCJq++caIerAb57
         o3k9I5J0C9DoK/y4mx/pz6yckKreKRDk0v27/SfF/roGLAqrRgXkBE/kdR+bbB7qA9OC
         4ToHSuFlPQ3raUVsFQ8mxIydCb5F9v8Zf4YkFNGFiR+JtgcRbnUVhIQQJbdSOyRfg9Wq
         uchXCwnA30DlwWh7PFj50KDGlvEG4eLWKfN0Bv6dKn7R3/oidmzmwYQ1qiaBkcvqqHNb
         aSkmOZlRLiwj7CoSk9cxNwdMSOz8legugp2sFoQuf2/MQ8wPLmSFstFviOVJjIq7/ttj
         GgUA==
X-Gm-Message-State: AOJu0YzjwkdW6MPN+HnEokks36QI0xSD4Q1JoFuIZQWsE9aUvHZaRtU+
        SWWHmao7Pq6XpdJIbqBktzpJCFLU//zyZcntxDJgJ/gRVY7KDys1riM=
X-Google-Smtp-Source: AGHT+IHrFS/MetB2D+JOJ0HUgvg8gUnck+Q9wc9iuyNolmRRJE8aemLtKvlVcHy0jPsuNqyP2Mtur4zcnXnmrqwibNw=
X-Received: by 2002:ac8:7dd5:0:b0:3de:1aaa:42f5 with SMTP id
 c21-20020ac87dd5000000b003de1aaa42f5mr255229qte.15.1694537258084; Tue, 12 Sep
 2023 09:47:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230911210346.301750-1-dima@arista.com> <20230911210346.301750-7-dima@arista.com>
In-Reply-To: <20230911210346.301750-7-dima@arista.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 12 Sep 2023 18:47:26 +0200
Message-ID: <CANn89iKnv4AZQBfHMHsUQTKhkK1zC5qqeHUdEQcbDJWgK64dAg@mail.gmail.com>
Subject: Re: [PATCH v11 net-next 06/23] net/tcp: Add TCP-AO sign to outgoing packets
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
> Using precalculated traffic keys, sign TCP segments as prescribed by
> RFC5925. Per RFC, TCP header options are included in sign calculation:
> "The TCP header, by default including options, and where the TCP
> checksum and TCP-AO MAC fields are set to zero, all in network-
> byte order." (5.1.3)
>
> tcp_ao_hash_header() has exclude_options parameter to optionally exclude
> TCP header from hash calculation, as described in RFC5925 (9.1), this is
> needed for interaction with middleboxes that may change "some TCP
> options". This is wired up to AO key flags and setsockopt() later.
>
> Similarly to TCP-MD5 hash TCP segment fragments.
>
> From this moment a user can start sending TCP-AO signed segments with
> one of crypto ahash algorithms from supported by Linux kernel. It can
> have a user-specified MAC length, to either save TCP option header space
> or provide higher protection using a longer signature.
> The inbound segments are not yet verified, TCP-AO option is ignored and
> they are accepted.
>
> Co-developed-by: Francesco Ruggeri <fruggeri@arista.com>
> Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
> Co-developed-by: Salam Noureddine <noureddine@arista.com>
> Signed-off-by: Salam Noureddine <noureddine@arista.com>
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> Acked-by: David Ahern <dsahern@kernel.org>
> ---
>  include/net/tcp.h     |   4 +
>  include/net/tcp_ao.h  |  13 ++++
>  net/ipv4/tcp_ao.c     | 165 ++++++++++++++++++++++++++++++++++++++++++
>  net/ipv4/tcp_ipv4.c   |   1 +
>  net/ipv4/tcp_output.c | 111 +++++++++++++++++++++++++---
>  net/ipv6/tcp_ao.c     |  28 +++++++
>  net/ipv6/tcp_ipv6.c   |   2 +
>  7 files changed, 315 insertions(+), 9 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 45df08b5ad28..9d6da2e19dd9 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -185,6 +185,7 @@ void tcp_time_wait(struct sock *sk, int state, int ti=
meo);
>  #define TCPOPT_SACK             5       /* SACK Block */
>  #define TCPOPT_TIMESTAMP       8       /* Better RTT estimations/PAWS */
>  #define TCPOPT_MD5SIG          19      /* MD5 Signature (RFC2385) */
> +#define TCPOPT_AO              29      /* Authentication Option (RFC5925=
) */
>  #define TCPOPT_MPTCP           30      /* Multipath TCP (RFC6824) */
>  #define TCPOPT_FASTOPEN                34      /* Fast open (RFC7413) */
>  #define TCPOPT_EXP             254     /* Experimental */
> @@ -2158,6 +2159,9 @@ struct tcp_sock_af_ops {
>         int (*ao_calc_key_sk)(struct tcp_ao_key *mkt, u8 *key,
>                               const struct sock *sk,
>                               __be32 sisn, __be32 disn, bool send);
> +       int (*calc_ao_hash)(char *location, struct tcp_ao_key *ao,
> +                           const struct sock *sk, const struct sk_buff *=
skb,
> +                           const u8 *tkey, int hash_offset, u32 sne);
>  #endif
>  };
>
> diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
> index 7e0ce45d9934..cd85d292f78e 100644
> --- a/include/net/tcp_ao.h
> +++ b/include/net/tcp_ao.h
> @@ -111,6 +111,10 @@ struct tcp6_ao_context {
>
>  struct tcp_sigpool;
>
> +int tcp_ao_hash_skb(unsigned short int family,
> +                   char *ao_hash, struct tcp_ao_key *key,
> +                   const struct sock *sk, const struct sk_buff *skb,
> +                   const u8 *tkey, int hash_offset, u32 sne);
>  int tcp_parse_ao(struct sock *sk, int cmd, unsigned short int family,
>                  sockptr_t optval, int optlen);
>  int tcp_ao_calc_traffic_key(struct tcp_ao_key *mkt, u8 *key, void *ctx,
> @@ -126,12 +130,21 @@ struct tcp_ao_key *tcp_v4_ao_lookup(const struct so=
ck *sk, struct sock *addr_sk,
>  int tcp_v4_ao_calc_key_sk(struct tcp_ao_key *mkt, u8 *key,
>                           const struct sock *sk,
>                           __be32 sisn, __be32 disn, bool send);
> +int tcp_v4_ao_hash_skb(char *ao_hash, struct tcp_ao_key *key,
> +                      const struct sock *sk, const struct sk_buff *skb,
> +                      const u8 *tkey, int hash_offset, u32 sne);
>  /* ipv6 specific functions */
> +int tcp_v6_ao_hash_pseudoheader(struct tcp_sigpool *hp,
> +                               const struct in6_addr *daddr,
> +                               const struct in6_addr *saddr, int nbytes)=
;
>  int tcp_v6_ao_calc_key_sk(struct tcp_ao_key *mkt, u8 *key,
>                           const struct sock *sk, __be32 sisn,
>                           __be32 disn, bool send);
>  struct tcp_ao_key *tcp_v6_ao_lookup(const struct sock *sk,
>                                     struct sock *addr_sk, int sndid, int =
rcvid);
> +int tcp_v6_ao_hash_skb(char *ao_hash, struct tcp_ao_key *key,
> +                      const struct sock *sk, const struct sk_buff *skb,
> +                      const u8 *tkey, int hash_offset, u32 sne);
>  int tcp_v6_parse_ao(struct sock *sk, int cmd, sockptr_t optval, int optl=
en);
>  void tcp_ao_finish_connect(struct sock *sk, struct sk_buff *skb);
>  void tcp_ao_connect_init(struct sock *sk);
> diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
> index fc7a6aa1936e..d10daee79fe6 100644
> --- a/net/ipv4/tcp_ao.c
> +++ b/net/ipv4/tcp_ao.c
> @@ -262,6 +262,171 @@ static int tcp_ao_calc_key_sk(struct tcp_ao_key *mk=
t, u8 *key,
>                 return -EOPNOTSUPP;
>  }
>
> +static int tcp_v4_ao_hash_pseudoheader(struct tcp_sigpool *hp,
> +                                      __be32 daddr, __be32 saddr,
> +                                      int nbytes)
> +{
> +       struct tcp4_pseudohdr *bp;
> +       struct scatterlist sg;
> +
> +       bp =3D hp->scratch;
> +       bp->saddr =3D saddr;
> +       bp->daddr =3D daddr;
> +       bp->pad =3D 0;
> +       bp->protocol =3D IPPROTO_TCP;
> +       bp->len =3D cpu_to_be16(nbytes);
> +
> +       sg_init_one(&sg, bp, sizeof(*bp));
> +       ahash_request_set_crypt(hp->req, &sg, NULL, sizeof(*bp));
> +       return crypto_ahash_update(hp->req);
> +}
> +
> +static int tcp_ao_hash_pseudoheader(unsigned short int family,
> +                                   const struct sock *sk,
> +                                   const struct sk_buff *skb,
> +                                   struct tcp_sigpool *hp, int nbytes)
> +{
> +       const struct tcphdr *th =3D tcp_hdr(skb);
> +
> +       /* TODO: Can we rely on checksum being zero to mean outbound pkt?=
 */
> +       if (!th->check) {
> +               if (family =3D=3D AF_INET)
> +                       return tcp_v4_ao_hash_pseudoheader(hp, sk->sk_dad=
dr,
> +                                       sk->sk_rcv_saddr, skb->len);
> +#if IS_ENABLED(CONFIG_IPV6)
> +               else if (family =3D=3D AF_INET6)
> +                       return tcp_v6_ao_hash_pseudoheader(hp, &sk->sk_v6=
_daddr,
> +                                       &sk->sk_v6_rcv_saddr, skb->len);
> +#endif
> +               else
> +                       return -EAFNOSUPPORT;
> +       }
> +
> +       if (family =3D=3D AF_INET) {
> +               const struct iphdr *iph =3D ip_hdr(skb);
> +
> +               return tcp_v4_ao_hash_pseudoheader(hp, iph->daddr,
> +                               iph->saddr, skb->len);
> +#if IS_ENABLED(CONFIG_IPV6)
> +       } else if (family =3D=3D AF_INET6) {
> +               const struct ipv6hdr *iph =3D ipv6_hdr(skb);
> +
> +               return tcp_v6_ao_hash_pseudoheader(hp, &iph->daddr,
> +                               &iph->saddr, skb->len);
> +#endif
> +       }
> +       return -EAFNOSUPPORT;
> +}
> +
> +/* tcp_ao_hash_sne(struct tcp_sigpool *hp)
> + * @hp - used for hashing
> + * @sne - sne value
> + */
> +static int tcp_ao_hash_sne(struct tcp_sigpool *hp, u32 sne)
> +{
> +       struct scatterlist sg;
> +       __be32 *bp;
> +
> +       bp =3D (__be32 *)hp->scratch;
> +       *bp =3D htonl(sne);
> +
> +       sg_init_one(&sg, bp, sizeof(*bp));
> +       ahash_request_set_crypt(hp->req, &sg, NULL, sizeof(*bp));
> +       return crypto_ahash_update(hp->req);
> +}
> +
> +static int tcp_ao_hash_header(struct tcp_sigpool *hp,
> +                             const struct tcphdr *th,
> +                             bool exclude_options, u8 *hash,
> +                             int hash_offset, int hash_len)
> +{
> +       int err, len =3D th->doff << 2;
> +       struct scatterlist sg;
> +       u8 *hdr =3D hp->scratch;
> +
> +       /* We are not allowed to change tcphdr, make a local copy */
> +       if (exclude_options) {
> +               len =3D sizeof(*th) + sizeof(struct tcp_ao_hdr) + hash_le=
n;
> +               memcpy(hdr, th, sizeof(*th));
> +               memcpy(hdr + sizeof(*th),
> +                      (u8 *)th + hash_offset - sizeof(struct tcp_ao_hdr)=
,
> +                      sizeof(struct tcp_ao_hdr));
> +               memset(hdr + sizeof(*th) + sizeof(struct tcp_ao_hdr),
> +                      0, hash_len);
> +               ((struct tcphdr *)hdr)->check =3D 0;
> +       } else {
> +               len =3D th->doff << 2;
> +               memcpy(hdr, th, len);
> +               /* zero out tcp-ao hash */
> +               ((struct tcphdr *)hdr)->check =3D 0;
> +               memset(hdr + hash_offset, 0, hash_len);
> +       }
> +
> +       sg_init_one(&sg, hdr, len);
> +       ahash_request_set_crypt(hp->req, &sg, NULL, len);
> +       err =3D crypto_ahash_update(hp->req);
> +       WARN_ON_ONCE(err !=3D 0);
> +       return err;
> +}
> +
> +int tcp_ao_hash_skb(unsigned short int family,
> +                   char *ao_hash, struct tcp_ao_key *key,
> +                   const struct sock *sk, const struct sk_buff *skb,
> +                   const u8 *tkey, int hash_offset, u32 sne)
> +{
> +       const struct tcphdr *th =3D tcp_hdr(skb);
> +       int tkey_len =3D tcp_ao_digest_size(key);
> +       struct tcp_sigpool hp;
> +       void *hash_buf =3D NULL;
> +
> +       hash_buf =3D kmalloc(tkey_len, GFP_ATOMIC);
> +       if (!hash_buf)
> +               goto clear_hash_noput;
> +
> +       if (tcp_sigpool_start(key->tcp_sigpool_id, &hp))
> +               goto clear_hash_noput;
> +
> +       if (crypto_ahash_setkey(crypto_ahash_reqtfm(hp.req), tkey, tkey_l=
en))
> +               goto clear_hash;
> +
> +       /* For now use sha1 by default. Depends on alg in tcp_ao_key */
> +       if (crypto_ahash_init(hp.req))
> +               goto clear_hash;
> +
> +       if (tcp_ao_hash_sne(&hp, sne))
> +               goto clear_hash;
> +       if (tcp_ao_hash_pseudoheader(family, sk, skb, &hp, skb->len))
> +               goto clear_hash;
> +       if (tcp_ao_hash_header(&hp, th, false,
> +                              ao_hash, hash_offset, tcp_ao_maclen(key)))
> +               goto clear_hash;
> +       if (tcp_sigpool_hash_skb_data(&hp, skb, th->doff << 2))
> +               goto clear_hash;
> +       ahash_request_set_crypt(hp.req, NULL, hash_buf, 0);
> +       if (crypto_ahash_final(hp.req))
> +               goto clear_hash;
> +
> +       memcpy(ao_hash, hash_buf, tcp_ao_maclen(key));
> +       tcp_sigpool_end(&hp);
> +       kfree(hash_buf);
> +       return 0;
> +
> +clear_hash:
> +       tcp_sigpool_end(&hp);
> +clear_hash_noput:
> +       memset(ao_hash, 0, tcp_ao_maclen(key));
> +       kfree(hash_buf);
> +       return 1;
> +}
> +
> +int tcp_v4_ao_hash_skb(char *ao_hash, struct tcp_ao_key *key,
> +                      const struct sock *sk, const struct sk_buff *skb,
> +                      const u8 *tkey, int hash_offset, u32 sne)
> +{
> +       return tcp_ao_hash_skb(AF_INET, ao_hash, key, sk, skb,
> +                              tkey, hash_offset, sne);
> +}
> +
>  struct tcp_ao_key *tcp_v4_ao_lookup(const struct sock *sk, struct sock *=
addr_sk,
>                                     int sndid, int rcvid)
>  {
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index d63970b3d375..ed26676735a5 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -2284,6 +2284,7 @@ static const struct tcp_sock_af_ops tcp_sock_ipv4_s=
pecific =3D {
>  #endif
>  #ifdef CONFIG_TCP_AO
>         .ao_lookup              =3D tcp_v4_ao_lookup,
> +       .calc_ao_hash           =3D tcp_v4_ao_hash_skb,
>         .ao_parse               =3D tcp_v4_parse_ao,
>         .ao_calc_key_sk         =3D tcp_v4_ao_calc_key_sk,
>  #endif
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 705eeb623269..01424b82845a 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -423,6 +423,7 @@ static inline bool tcp_urg_mode(const struct tcp_sock=
 *tp)
>  #define OPTION_FAST_OPEN_COOKIE        BIT(8)
>  #define OPTION_SMC             BIT(9)
>  #define OPTION_MPTCP           BIT(10)
> +#define OPTION_AO              BIT(11)
>
>  static void smc_options_write(__be32 *ptr, u16 *options)
>  {
> @@ -615,7 +616,8 @@ static void bpf_skops_write_hdr_opt(struct sock *sk, =
struct sk_buff *skb,
>   * (but it may well be that other scenarios fail similarly).
>   */
>  static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
> -                             struct tcp_out_options *opts)
> +                             struct tcp_out_options *opts,
> +                             struct tcp_ao_key *ao_key)
>  {
>         __be32 *ptr =3D (__be32 *)(th + 1);
>         u16 options =3D opts->options;    /* mungable copy */
> @@ -627,7 +629,33 @@ static void tcp_options_write(struct tcphdr *th, str=
uct tcp_sock *tp,
>                 opts->hash_location =3D (__u8 *)ptr;
>                 ptr +=3D 4;
>         }
> +#ifdef CONFIG_TCP_AO
> +       if (unlikely(OPTION_AO & options)) {
> +               struct tcp_ao_key *rnext_key;
> +               struct tcp_ao_info *ao_info;
> +               u8 maclen;
>
> +               if (WARN_ON_ONCE(!ao_key))
> +                       goto out_ao;
> +               ao_info =3D rcu_dereference_check(tp->ao_info,
> +                               lockdep_sock_is_held(&tp->inet_conn.icsk_=
inet.sk));
> +               rnext_key =3D READ_ONCE(ao_info->rnext_key);
> +               if (WARN_ON_ONCE(!rnext_key))
> +                       goto out_ao;
> +               maclen =3D tcp_ao_maclen(ao_key);
> +               *ptr++ =3D htonl((TCPOPT_AO << 24) |
> +                               (tcp_ao_len(ao_key) << 16) |
> +                               (ao_key->sndid << 8) |
> +                               (rnext_key->rcvid));
> +               opts->hash_location =3D (__u8 *)ptr;
> +               ptr +=3D maclen / sizeof(*ptr);
> +               if (unlikely(maclen % sizeof(*ptr))) {
> +                       memset(ptr, TCPOPT_NOP, sizeof(*ptr));
> +                       ptr++;
> +               }
> +       }
> +out_ao:
> +#endif
>         if (unlikely(opts->mss)) {
>                 *ptr++ =3D htonl((TCPOPT_MSS << 24) |
>                                (TCPOLEN_MSS << 16) |
> @@ -768,7 +796,8 @@ static void mptcp_set_option_cond(const struct reques=
t_sock *req,
>   */
>  static unsigned int tcp_syn_options(struct sock *sk, struct sk_buff *skb=
,
>                                 struct tcp_out_options *opts,
> -                               struct tcp_md5sig_key **md5)
> +                               struct tcp_md5sig_key **md5,
> +                               struct tcp_ao_key *ao_key)
>  {
>         struct tcp_sock *tp =3D tcp_sk(sk);
>         unsigned int remaining =3D MAX_TCP_OPTION_SPACE;
> @@ -785,6 +814,12 @@ static unsigned int tcp_syn_options(struct sock *sk,=
 struct sk_buff *skb,
>                 }
>         }
>  #endif
> +#ifdef CONFIG_TCP_AO
> +       if (ao_key) {
> +               opts->options |=3D OPTION_AO;
> +               remaining -=3D tcp_ao_len(ao_key);
> +       }
> +#endif
>
>         /* We always get an MSS option.  The option bytes which will be s=
een in
>          * normal data packets should timestamps be used, must be in the =
MSS
> @@ -922,7 +957,8 @@ static unsigned int tcp_synack_options(const struct s=
ock *sk,
>   */
>  static unsigned int tcp_established_options(struct sock *sk, struct sk_b=
uff *skb,
>                                         struct tcp_out_options *opts,
> -                                       struct tcp_md5sig_key **md5)
> +                                       struct tcp_md5sig_key **md5,
> +                                       struct tcp_ao_key *ao_key)
>  {
>         struct tcp_sock *tp =3D tcp_sk(sk);
>         unsigned int size =3D 0;
> @@ -941,6 +977,12 @@ static unsigned int tcp_established_options(struct s=
ock *sk, struct sk_buff *skb
>                 }
>         }
>  #endif
> +#ifdef CONFIG_TCP_AO
> +       if (ao_key) {
> +               opts->options |=3D OPTION_AO;
> +               size +=3D tcp_ao_len(ao_key);
> +       }
> +#endif
>
>         if (likely(tp->rx_opt.tstamp_ok)) {
>                 opts->options |=3D OPTION_TS;
> @@ -1245,6 +1287,7 @@ static int __tcp_transmit_skb(struct sock *sk, stru=
ct sk_buff *skb,
>                               int clone_it, gfp_t gfp_mask, u32 rcv_nxt)
>  {
>         const struct inet_connection_sock *icsk =3D inet_csk(sk);
> +       struct tcp_ao_key *ao_key =3D NULL;
>         struct inet_sock *inet;
>         struct tcp_sock *tp;
>         struct tcp_skb_cb *tcb;
> @@ -1252,6 +1295,9 @@ static int __tcp_transmit_skb(struct sock *sk, stru=
ct sk_buff *skb,
>         unsigned int tcp_options_size, tcp_header_size;
>         struct sk_buff *oskb =3D NULL;
>         struct tcp_md5sig_key *md5;
> +#ifdef CONFIG_TCP_AO
> +       struct tcp_ao_info *ao;
> +#endif
>         struct tcphdr *th;
>         u64 prior_wstamp;
>         int err;
> @@ -1283,11 +1329,17 @@ static int __tcp_transmit_skb(struct sock *sk, st=
ruct sk_buff *skb,
>         tcb =3D TCP_SKB_CB(skb);
>         memset(&opts, 0, sizeof(opts));
>
> +#ifdef CONFIG_TCP_AO
> +       ao =3D rcu_dereference_protected(tcp_sk(sk)->ao_info,
> +                                      lockdep_sock_is_held(sk));
> +       if (ao)
> +               ao_key =3D READ_ONCE(ao->current_key);
> +#endif
>         if (unlikely(tcb->tcp_flags & TCPHDR_SYN)) {
> -               tcp_options_size =3D tcp_syn_options(sk, skb, &opts, &md5=
);
> +               tcp_options_size =3D tcp_syn_options(sk, skb, &opts, &md5=
, ao_key);
>         } else {
>                 tcp_options_size =3D tcp_established_options(sk, skb, &op=
ts,
> -                                                          &md5);
> +                                                          &md5, ao_key);
>                 /* Force a PSH flag on all (GSO) packets to expedite GRO =
flush
>                  * at receiver : This slightly improve GRO performance.
>                  * Note that we do not force the PSH flag for non GSO pac=
kets,
> @@ -1368,7 +1420,7 @@ static int __tcp_transmit_skb(struct sock *sk, stru=
ct sk_buff *skb,
>                 th->window      =3D htons(min(tp->rcv_wnd, 65535U));
>         }
>
> -       tcp_options_write(th, tp, &opts);
> +       tcp_options_write(th, tp, &opts, ao_key);
>
>  #ifdef CONFIG_TCP_MD5SIG
>         /* Calculate the MD5 hash, as we have all we need now */
> @@ -1378,6 +1430,34 @@ static int __tcp_transmit_skb(struct sock *sk, str=
uct sk_buff *skb,
>                                                md5, sk, skb);
>         }
>  #endif
> +#ifdef CONFIG_TCP_AO
> +       if (ao) {
> +               u8 *traffic_key;
> +               void *tkey_buf =3D NULL;
> +               __be32 disn;
> +
> +               sk_gso_disable(sk);

Why is this needed here in a fast path ? This should happen once.

It seems you copied MD5 old logic, I think we should do better.


> +               if (unlikely(tcb->tcp_flags & TCPHDR_SYN)) {
> +                       if (tcb->tcp_flags & TCPHDR_ACK)
> +                               disn =3D ao->risn;
> +                       else
> +                               disn =3D 0;
> +
> +                       tkey_buf =3D kmalloc(tcp_ao_digest_size(ao_key), =
GFP_ATOMIC);
> +                       if (!tkey_buf)
> +                               return -ENOMEM;

This leaks an skb.

> +                       traffic_key =3D tkey_buf;
> +                       tp->af_specific->ao_calc_key_sk(ao_key, traffic_k=
ey,
> +                                                       sk, ao->lisn, dis=
n, true);
> +               } else {
> +                       traffic_key =3D snd_other_key(ao_key);
> +               }
> +               tp->af_specific->calc_ao_hash(opts.hash_location, ao_key,=
 sk, skb,
> +                                             traffic_key,
> +                                             opts.hash_location - (u8 *)=
th, 0);
> +               kfree(tkey_buf);
> +       }
> +#endif
>
>         /* BPF prog is the last one writing header option */
>         bpf_skops_write_hdr_opt(sk, skb, NULL, NULL, 0, &opts);
> @@ -1825,10 +1905,14 @@ unsigned int tcp_current_mss(struct sock *sk)
>  {
>         const struct tcp_sock *tp =3D tcp_sk(sk);
>         const struct dst_entry *dst =3D __sk_dst_get(sk);
> +       struct tcp_ao_key *ao_key =3D NULL;
>         u32 mss_now;
>         unsigned int header_len;
>         struct tcp_out_options opts;
>         struct tcp_md5sig_key *md5;
> +#ifdef CONFIG_TCP_AO
> +       struct tcp_ao_info *ao_info;
> +#endif
>
>         mss_now =3D tp->mss_cache;
>
> @@ -1837,8 +1921,17 @@ unsigned int tcp_current_mss(struct sock *sk)
>                 if (mtu !=3D inet_csk(sk)->icsk_pmtu_cookie)
>                         mss_now =3D tcp_sync_mss(sk, mtu);
>         }
> -
> -       header_len =3D tcp_established_options(sk, NULL, &opts, &md5) +
> +#ifdef CONFIG_TCP_AO
> +       ao_info =3D rcu_dereference_check(tp->ao_info, lockdep_sock_is_he=
ld(sk));
> +       if (ao_info)
> +               /* TODO: verify if we can access current_key or we need t=
o pass
> +                * it from every caller of tcp_current_mss instead. The r=
eason
> +                * is that the current_key pointer can change asynchronou=
sly
> +                * from the rx path.
> +                */
> +               ao_key =3D READ_ONCE(ao_info->current_key);
> +#endif
> +       header_len =3D tcp_established_options(sk, NULL, &opts, &md5, ao_=
key) +
>                      sizeof(struct tcphdr);

Adding yet another argument in TCP fast path routines is very unfortunate..=
.

Could we merge md5/ao_key, and have a field giving the type ?
