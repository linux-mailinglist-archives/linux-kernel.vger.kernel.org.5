Return-Path: <linux-kernel+bounces-20872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC288286BA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F06F1F2629C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FBE38FA8;
	Tue,  9 Jan 2024 13:00:06 +0000 (UTC)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9383C472;
	Tue,  9 Jan 2024 13:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50ea98440a7so2795000e87.1;
        Tue, 09 Jan 2024 05:00:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704805201; x=1705410001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNmjIaAbcALLd+bsCOP1V7vdnlcujSxw1SsRLFESGSg=;
        b=fm2b8ujAnOIqSHwaHCs/F5ByLYj7UMo6N00j1W1eBiQOBgJ8Q1PyZHjHLGK/0Q9PmK
         XZF/Ofbcc5fbebyzC/c8q3Poxqi6vOVbN0h3b/2VRO7T50RNiku1HOhPlBSQJAjMbE1R
         l6yTwGuRAjs5Day90TRE8pKDaLr3TOJIEJUj0Z3gB7H9jDOBW5rNrifpW8JEwnVZa8Yu
         sv5ZMYK/kO5/pgC3rBGqEx5AdyWtHY/4rhkAEL4ivLC/ouEZufycjW26H9RDm1MfcPrV
         t8+1IN8gUz7Ge4/h9ePRBctCjVTrK7rnQdDH+sDuNs94vpU68C3KHmziejU14xvZm2nb
         JV5w==
X-Gm-Message-State: AOJu0Yz16idUYCpCv3Fuwk3nEh2dByJWA3HMii6yS2StUnYpKCkGI60N
	7XnQ6dLei6yTTWd917HaTWI3gpldEQmA39Mp
X-Google-Smtp-Source: AGHT+IHnZzr66ZAgY2A5g5eRNVWYnweEXa7BVg+uCuquw5IHT3R5juxdinamC73ucUZVjJRaxt6U8Q==
X-Received: by 2002:a05:6512:1296:b0:50e:9355:a24b with SMTP id u22-20020a056512129600b0050e9355a24bmr1844402lfs.22.1704805200971;
        Tue, 09 Jan 2024 05:00:00 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id y9-20020a1709063a8900b00a2ac199ff67sm1027216ejd.170.2024.01.09.05.00.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 05:00:00 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so328375966b.2;
        Tue, 09 Jan 2024 05:00:00 -0800 (PST)
X-Received: by 2002:a17:907:1c8d:b0:a2a:fc9b:c05c with SMTP id
 nb13-20020a1709071c8d00b00a2afc9bc05cmr458805ejc.18.1704805200498; Tue, 09
 Jan 2024 05:00:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1570781.1704797483@warthog.procyon.org.uk>
In-Reply-To: <1570781.1704797483@warthog.procyon.org.uk>
From: Marc Dionne <marc.dionne@auristor.com>
Date: Tue, 9 Jan 2024 08:59:48 -0400
X-Gmail-Original-Message-ID: <CAB9dFdteL97Z8GAry9TwmcOfw0+PQDzL_u14PwwAEq5uUHaUkQ@mail.gmail.com>
Message-ID: <CAB9dFdteL97Z8GAry9TwmcOfw0+PQDzL_u14PwwAEq5uUHaUkQ@mail.gmail.com>
Subject: Re: [PATCH net] rxrpc: Fix use of Don't Fragment flag
To: David Howells <dhowells@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 6:51=E2=80=AFAM David Howells <dhowells@redhat.com> =
wrote:
>
> rxrpc normally has the Don't Fragment flag set on the UDP packets it
> transmits, except when it has decided that DATA packets aren't getting
> through - in which case it turns it off just for the DATA transmissions.
> This can be a problem, however, for RESPONSE packets that convey
> authentication and crypto data from the client to the server as ticket ma=
y
> be larger than can fit in the MTU.
>
> In such a case, rxrpc gets itself into an infinite loop as the sendmsg
> returns an error (EMSGSIZE), which causes rxkad_send_response() to return
> -EAGAIN - and the CHALLENGE packet is put back on the Rx queue to retry,
> leading to the I/O thread endlessly attempting to perform the transmissio=
n.
>
> Fix this by disabling DF on RESPONSE packets for now.  The use of DF and
> best data MTU determination needs reconsidering at some point in the
> future.
>
> Reported-by: Marc Dionne <marc.dionne@auristor.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Eric Dumazet <edumazet@google.com>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: linux-afs@lists.infradead.org
> cc: netdev@vger.kernel.org
> ---
>  net/rxrpc/ar-internal.h  |    1 +
>  net/rxrpc/local_object.c |   13 ++++++++++++-
>  net/rxrpc/output.c       |    6 ++----
>  net/rxrpc/rxkad.c        |    2 ++
>  4 files changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
> index e8e14c6f904d..e8b43408136a 100644
> --- a/net/rxrpc/ar-internal.h
> +++ b/net/rxrpc/ar-internal.h
> @@ -1076,6 +1076,7 @@ void rxrpc_send_version_request(struct rxrpc_local =
*local,
>  /*
>   * local_object.c
>   */
> +void rxrpc_local_dont_fragment(const struct rxrpc_local *local, bool set=
);
>  struct rxrpc_local *rxrpc_lookup_local(struct net *, const struct sockad=
dr_rxrpc *);
>  struct rxrpc_local *rxrpc_get_local(struct rxrpc_local *, enum rxrpc_loc=
al_trace);
>  struct rxrpc_local *rxrpc_get_local_maybe(struct rxrpc_local *, enum rxr=
pc_local_trace);
> diff --git a/net/rxrpc/local_object.c b/net/rxrpc/local_object.c
> index c553a30e9c83..7a3150482e37 100644
> --- a/net/rxrpc/local_object.c
> +++ b/net/rxrpc/local_object.c
> @@ -36,6 +36,17 @@ static void rxrpc_encap_err_rcv(struct sock *sk, struc=
t sk_buff *skb, int err,
>                 return ipv6_icmp_error(sk, skb, err, port, info, payload)=
;
>  }
>
> +/*
> + * Set or clear the Don't Fragment flag on a socket.
> + */
> +void rxrpc_local_dont_fragment(const struct rxrpc_local *local, bool set=
)
> +{
> +       if (set)
> +               ip_sock_set_mtu_discover(local->socket->sk, IP_PMTUDISC_D=
ONT);
> +       else
> +               ip_sock_set_mtu_discover(local->socket->sk, IP_PMTUDISC_D=
O);
> +}

Shouldn't those be reversed - don't fragment should be IP_PMTUDISC_DO?

Also, and this is probably already an issue with current code, I don't
think this is effective if the socket is V6, which it will be in most
cases.

> +
>  /*
>   * Compare a local to an address.  Return -ve, 0 or +ve to indicate less=
 than,
>   * same or greater than.
> @@ -203,7 +214,7 @@ static int rxrpc_open_socket(struct rxrpc_local *loca=
l, struct net *net)
>                 ip_sock_set_recverr(usk);
>
>                 /* we want to set the don't fragment bit */
> -               ip_sock_set_mtu_discover(usk, IP_PMTUDISC_DO);
> +               rxrpc_local_dont_fragment(local, true);
>
>                 /* We want receive timestamps. */
>                 sock_enable_timestamps(usk);
> diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
> index 5e53429c6922..a0906145e829 100644
> --- a/net/rxrpc/output.c
> +++ b/net/rxrpc/output.c
> @@ -494,14 +494,12 @@ int rxrpc_send_data_packet(struct rxrpc_call *call,=
 struct rxrpc_txbuf *txb)
>         switch (conn->local->srx.transport.family) {
>         case AF_INET6:
>         case AF_INET:
> -               ip_sock_set_mtu_discover(conn->local->socket->sk,
> -                                        IP_PMTUDISC_DONT);
> +               rxrpc_local_dont_fragment(conn->local, false);
>                 rxrpc_inc_stat(call->rxnet, stat_tx_data_send_frag);
>                 ret =3D do_udp_sendmsg(conn->local->socket, &msg, len);
>                 conn->peer->last_tx_at =3D ktime_get_seconds();
>
> -               ip_sock_set_mtu_discover(conn->local->socket->sk,
> -                                        IP_PMTUDISC_DO);
> +               rxrpc_local_dont_fragment(conn->local, true);
>                 break;
>
>         default:
> diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
> index 1bf571a66e02..b52dedcebce0 100644
> --- a/net/rxrpc/rxkad.c
> +++ b/net/rxrpc/rxkad.c
> @@ -724,7 +724,9 @@ static int rxkad_send_response(struct rxrpc_connectio=
n *conn,
>         serial =3D atomic_inc_return(&conn->serial);
>         whdr.serial =3D htonl(serial);
>
> +       rxrpc_local_dont_fragment(conn->local, false);
>         ret =3D kernel_sendmsg(conn->local->socket, &msg, iov, 3, len);
> +       rxrpc_local_dont_fragment(conn->local, true);
>         if (ret < 0) {
>                 trace_rxrpc_tx_fail(conn->debug_id, serial, ret,
>                                     rxrpc_tx_point_rxkad_response);

Marc

