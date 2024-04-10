Return-Path: <linux-kernel+bounces-138768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 411BB89FA1D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 648B31C20E1A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C572816F0F1;
	Wed, 10 Apr 2024 14:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/BRYPec"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4843416DEB0;
	Wed, 10 Apr 2024 14:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712759898; cv=none; b=Jb1aQfwCt270zEmSbTXFwi7PQxKU+9QnHDkJhTe9d7LD3hjyUrtH5WXx+Sf+FNhbdZliJH6AEDpR3Q8wd1CtG7sz6ZKKd5FGe0ABzvgwMlK8G/lgu/hFDI5Rb4YTmx9zbwXCA0/U7i4mz5c4vmrAQie2O2eKLMcBI78RkFMNpVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712759898; c=relaxed/simple;
	bh=wFcZwqHsADHRCMHJ/KFOO+Z7n2k3CN3Ny9TCE50tsd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j9PK8Fxnw1cCNS9whBOyRe+AjgV86WlnUuZHcU5cBL+MeBw4lQazxnF8mQEFLVl7IHObPgCewtXfYcAyxRM2mTr74xjFLPcItdfclyBSt5Zh2OlVHVcbpsn1Ht1FZ2OxthJJBLYyAQeVVsm/PlPbw6LSZwk7sGPnGByowv31viA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/BRYPec; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-516dc51bb72so5358234e87.1;
        Wed, 10 Apr 2024 07:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712759894; x=1713364694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISlJ6Fbh6/GICMt/MlYjn77tHCTLHMY0dNbTUXKyVXg=;
        b=f/BRYPecqlQVwYpdukDsDxWaqD1W1e3mgkqH6ESh4pm11TLzFjF1ncuYbflf246Nqx
         LA5VTMHvTR3OqQwnXw7DwdRQvmgYQcIPIGAjU3GBFMU4WT3Ua5Extdyp2a1cXHoZ9qX4
         RtkiS68FqXnMdiYw8EHBSdMR8P9zIHxRvr1xVsanR0JTpt5UfAbmiGC1iPdytD4y7Glz
         Zxf+5jdaNnjgrwAEUQO7qt00/gAHBCRW8sFBX3i89e+XLd3xjPl3p8xxr/jxLi1CIfDs
         DXrIlbRiYvgoDoaaFaNtUG9nnL4N+c3BUYRyQLzNsaXG5WNkcFEGNYcgvRkWlu9fvqfu
         Pa/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712759894; x=1713364694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISlJ6Fbh6/GICMt/MlYjn77tHCTLHMY0dNbTUXKyVXg=;
        b=QaDdTeIbamFax/ohSVByiCD91BNpddtH5s1vvyV3WqYUrtLmqR1HiH8zy3mJ2Q+I4Q
         iaTpQNNa9Usfy18prWUoyVmWOarfc300VBhdPnt0mhuIH/XBR8BREi3YVpB4wq+20C3i
         QX2XIju3pdZuT97mCTZF07OZqkiSuULmHCe283LxVgqUEMigktgRdiYq6eaCSC6gAreU
         nviLBt0anQ7+FvrTewtff9mxg+vE7zDrxV79YMfcL0UUWkw7Zx/F0BrKHOSjJ+szcmwg
         7vbsXmfPXoy950dsNvd1tcQ5wwNaYQWbWBbYPVlQyOrhoUhjydEccuqohhhMGcW08xal
         Bqzw==
X-Forwarded-Encrypted: i=1; AJvYcCUi8jp4UVFEfRVTu3GXaJ2Gru1XOhvL1lzyDUdY5X1o6vMlGU3CTDVX21TJjVvB+DVe0CHSkcGJ/LhINql09+7QP+EbbvcQcl+bfjqRHLgXuzpIs3OaX4I70Ni2OpV49OrvoQm5aH3gmlgW7L8upoDP3+eYvjAHPQi1FDl9BUxAKDGvdK82
X-Gm-Message-State: AOJu0YxPbLYGkNS4GWMFWqKD7nt6ZlLOcHlGoS8ZvuTcA3n+GnGeyET3
	ygfm61bI3S2aBl5xqJhdNp2fDK6+HJE7hsgxNGmP4p3KMxokIXwW4+/FK9N42d+HmZ3eJCNEz3/
	Ze9OA4VeiPtIbPd5zTAcnYWNE6Dc=
X-Google-Smtp-Source: AGHT+IGWGS4rj3XSI8fnjqgwf1tHRNVj2QvXhIhqgplbxkqcyhCUKv7vbyjVFGIQUn154wDiompc3VYjZTfCsrYapA8=
X-Received: by 2002:a2e:a987:0:b0:2d8:6065:e2b2 with SMTP id
 x7-20020a2ea987000000b002d86065e2b2mr2174536ljq.46.1712759893979; Wed, 10 Apr
 2024 07:38:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408125806.12682-1-surban@surban.net>
In-Reply-To: <20240408125806.12682-1-surban@surban.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 10 Apr 2024 10:38:01 -0400
Message-ID: <CABBYNZL06-WHSArwMqkRYx190x_i+Fzp4OYd=uY0bnOGKyTnKA@mail.gmail.com>
Subject: Re: [PATCH v5] Bluetooth: compute LE flow credits based on recvbuf space
To: Sebastian Urban <surban@surban.net>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sebastian,

On Mon, Apr 8, 2024 at 9:13=E2=80=AFAM Sebastian Urban <surban@surban.net> =
wrote:
>
> Previously LE flow credits were returned to the
> sender even if the socket's receive buffer was
> full. This meant that no back-pressure
> was applied to the sender, thus it continued to
> send data, resulting in data loss without any
> error being reported. Furthermore, the amount
> of credits was essentially fixed to a small amount,
> leading to reduced performance.
>
> This is fixed by computing the number of returned
> LE flow credits based on the available space in the
> receive buffer of an L2CAP socket. Consequently,
> if the receive buffer is full, no credits are returned
> until the buffer is read and thus cleared by user-space.
>
> Since the computation of available
> receive buffer space can only be performed
> approximately, i.e. sk_buff overhead is ignored,
> and the receive buffer size may be changed by
> user-space after flow credits have been sent,
> superfluous received data is temporary stored within
> l2cap_pinfo. This is necessary because Bluetooth LE
> provides no retransmission mechanism once the
> data has been acked by the physical layer.
>
> Signed-off-by: Sebastian Urban <surban@surban.net>
> ---
>  include/net/bluetooth/l2cap.h | 10 +++++-
>  net/bluetooth/l2cap_core.c    | 51 ++++++++++++++++++++++----
>  net/bluetooth/l2cap_sock.c    | 67 +++++++++++++++++++++++++----------
>  3 files changed, 103 insertions(+), 25 deletions(-)
>
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.=
h
> index 3f4057ced971..bc6ff40ebc9f 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -547,6 +547,8 @@ struct l2cap_chan {
>
>         __u16           tx_credits;
>         __u16           rx_credits;
> +       int             rx_avail;
> +       int             rx_staged;

I'd probably use size_t for these above, and put some comments of what
they refer to e.g. rx_staged is what has been received already, right?
Couldn't we use chan->sdu->len instead?

>
>         __u8            tx_state;
>         __u8            rx_state;
> @@ -682,10 +684,15 @@ struct l2cap_user {
>  /* ----- L2CAP socket info ----- */
>  #define l2cap_pi(sk) ((struct l2cap_pinfo *) sk)
>
> +struct l2cap_rx_busy {
> +       struct list_head        list;
> +       struct sk_buff          *skb;
> +};
> +
>  struct l2cap_pinfo {
>         struct bt_sock          bt;
>         struct l2cap_chan       *chan;
> -       struct sk_buff          *rx_busy_skb;
> +       struct list_head        rx_busy;
>  };
>
>  enum {
> @@ -944,6 +951,7 @@ int l2cap_chan_reconfigure(struct l2cap_chan *chan, _=
_u16 mtu);
>  int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t =
len,
>                     const struct sockcm_cookie *sockc);
>  void l2cap_chan_busy(struct l2cap_chan *chan, int busy);
> +void l2cap_chan_rx_avail(struct l2cap_chan *chan, int rx_avail);
>  int l2cap_chan_check_security(struct l2cap_chan *chan, bool initiator);
>  void l2cap_chan_set_defaults(struct l2cap_chan *chan);
>  int l2cap_ertm_init(struct l2cap_chan *chan);
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index b0970462a689..7bad232d40ba 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -454,6 +454,9 @@ struct l2cap_chan *l2cap_chan_create(void)
>         /* Set default lock nesting level */
>         atomic_set(&chan->nesting, L2CAP_NESTING_NORMAL);
>
> +       /* Available receive buffer space is initially unknown */
> +       chan->rx_avail =3D -1;
> +
>         write_lock(&chan_list_lock);
>         list_add(&chan->global_l, &chan_list);
>         write_unlock(&chan_list_lock);
> @@ -535,6 +538,26 @@ void l2cap_chan_set_defaults(struct l2cap_chan *chan=
)
>  }
>  EXPORT_SYMBOL_GPL(l2cap_chan_set_defaults);
>
> +static __u16 l2cap_le_rx_credits(struct l2cap_chan *chan)
> +{
> +       if (chan->mps =3D=3D 0)
> +               return 0;
> +
> +       /* If we don't know the available space in the receiver buffer, g=
ive
> +        * enough credits for a full packet.
> +        */
> +       if (chan->rx_avail =3D=3D -1)
> +               return (chan->imtu / chan->mps) + 1;
> +
> +       /* If we know how much space is available in the receive buffer, =
give
> +        * out as many credits as would fill the buffer.
> +        */
> +       if (chan->rx_avail <=3D chan->rx_staged)
> +               return 0;

Missing space.

> +       return min_t(int, U16_MAX,
> +                    (chan->rx_avail - chan->rx_staged) / chan->mps);

We probably need to use DIV_ROUND_UP since the division can return 0
or is that intentional since that means we cannot store another full
mps? I think I'd give it a credit since this may impact the throughput
if we are not given credits when just a few bytes would be necessary
and in any case we would store the extra bytes in the rx_busy list if
that is over the rx_avail.

> +}
> +
>  static void l2cap_le_flowctl_init(struct l2cap_chan *chan, u16 tx_credit=
s)
>  {
>         chan->sdu =3D NULL;
> @@ -543,8 +566,7 @@ static void l2cap_le_flowctl_init(struct l2cap_chan *=
chan, u16 tx_credits)
>         chan->tx_credits =3D tx_credits;
>         /* Derive MPS from connection MTU to stop HCI fragmentation */
>         chan->mps =3D min_t(u16, chan->imtu, chan->conn->mtu - L2CAP_HDR_=
SIZE);
> -       /* Give enough credits for a full packet */
> -       chan->rx_credits =3D (chan->imtu / chan->mps) + 1;
> +       chan->rx_credits =3D l2cap_le_rx_credits(chan);
>
>         skb_queue_head_init(&chan->tx_q);
>  }
> @@ -556,7 +578,7 @@ static void l2cap_ecred_init(struct l2cap_chan *chan,=
 u16 tx_credits)
>         /* L2CAP implementations shall support a minimum MPS of 64 octets=
 */
>         if (chan->mps < L2CAP_ECRED_MIN_MPS) {
>                 chan->mps =3D L2CAP_ECRED_MIN_MPS;
> -               chan->rx_credits =3D (chan->imtu / chan->mps) + 1;
> +               chan->rx_credits =3D l2cap_le_rx_credits(chan);
>         }
>  }
>
> @@ -6520,9 +6542,7 @@ static void l2cap_chan_le_send_credits(struct l2cap=
_chan *chan)
>  {
>         struct l2cap_conn *conn =3D chan->conn;
>         struct l2cap_le_credits pkt;
> -       u16 return_credits;
> -
> -       return_credits =3D (chan->imtu / chan->mps) + 1;
> +       u16 return_credits =3D l2cap_le_rx_credits(chan);
>
>         if (chan->rx_credits >=3D return_credits)
>                 return;
> @@ -6541,6 +6561,16 @@ static void l2cap_chan_le_send_credits(struct l2ca=
p_chan *chan)
>         l2cap_send_cmd(conn, chan->ident, L2CAP_LE_CREDITS, sizeof(pkt), =
&pkt);
>  }
>
> +void l2cap_chan_rx_avail(struct l2cap_chan *chan, int rx_avail)
> +{
> +       BT_DBG("chan %p has %d bytes avail for rx", chan, rx_avail);

We should probably check if the value has changed though, or this
shall only be called when the buffer changes?

> +       chan->rx_avail =3D rx_avail;
> +
> +       if (chan->state =3D=3D BT_CONNECTED)
> +               l2cap_chan_le_send_credits(chan);
> +}
> +
>  static int l2cap_ecred_recv(struct l2cap_chan *chan, struct sk_buff *skb=
)
>  {
>         int err;
> @@ -6550,6 +6580,14 @@ static int l2cap_ecred_recv(struct l2cap_chan *cha=
n, struct sk_buff *skb)
>         /* Wait recv to confirm reception before updating the credits */
>         err =3D chan->ops->recv(chan, skb);
>
> +       chan->rx_staged =3D 0;
> +
> +       if (err < 0 && chan->rx_avail !=3D -1) {
> +               BT_ERR("Queueing received LE L2CAP data failed");
> +               l2cap_send_disconn_req(chan, ECONNRESET);
> +               return err;
> +       }
> +
>         /* Update credits whenever an SDU is received */
>         l2cap_chan_le_send_credits(chan);
>
> @@ -6571,6 +6609,7 @@ static int l2cap_ecred_data_rcv(struct l2cap_chan *=
chan, struct sk_buff *skb)
>                 return -ENOBUFS;
>         }
>
> +       chan->rx_staged +=3D skb->len;
>         chan->rx_credits--;
>         BT_DBG("rx_credits %u -> %u", chan->rx_credits + 1, chan->rx_cred=
its);
>
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 7846a068bf60..46603605cb69 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -1157,6 +1157,7 @@ static int l2cap_sock_recvmsg(struct socket *sock, =
struct msghdr *msg,
>  {
>         struct sock *sk =3D sock->sk;
>         struct l2cap_pinfo *pi =3D l2cap_pi(sk);
> +       int avail;
>         int err;
>
>         if (unlikely(flags & MSG_ERRQUEUE))
> @@ -1192,28 +1193,34 @@ static int l2cap_sock_recvmsg(struct socket *sock=
, struct msghdr *msg,
>         else
>                 err =3D bt_sock_recvmsg(sock, msg, len, flags);
>
> -       if (pi->chan->mode !=3D L2CAP_MODE_ERTM)
> +       if (pi->chan->mode !=3D L2CAP_MODE_ERTM &&
> +           pi->chan->mode !=3D L2CAP_MODE_LE_FLOWCTL &&
> +           pi->chan->mode !=3D L2CAP_MODE_EXT_FLOWCTL)
>                 return err;
>
> -       /* Attempt to put pending rx data in the socket buffer */
> -
>         lock_sock(sk);
>
> -       if (!test_bit(CONN_LOCAL_BUSY, &pi->chan->conn_state))
> -               goto done;
> +       avail =3D max(0, sk->sk_rcvbuf - atomic_read(&sk->sk_rmem_alloc))=
;
> +       l2cap_chan_rx_avail(pi->chan, avail);
>
> -       if (pi->rx_busy_skb) {
> -               if (!__sock_queue_rcv_skb(sk, pi->rx_busy_skb))
> -                       pi->rx_busy_skb =3D NULL;
> -               else
> +       /* Attempt to put pending rx data in the socket buffer */
> +       while (!list_empty(&pi->rx_busy)) {
> +               struct l2cap_rx_busy *rx_busy =3D
> +                       list_first_entry(&pi->rx_busy,
> +                                        struct l2cap_rx_busy,
> +                                        list);
> +               if (__sock_queue_rcv_skb(sk, rx_busy->skb) < 0)
>                         goto done;
> +               list_del(&rx_busy->list);
> +               kfree(rx_busy);
>         }
>
>         /* Restore data flow when half of the receive buffer is
>          * available.  This avoids resending large numbers of
>          * frames.
>          */
> -       if (atomic_read(&sk->sk_rmem_alloc) <=3D sk->sk_rcvbuf >> 1)
> +       if (test_bit(CONN_LOCAL_BUSY, &pi->chan->conn_state) &&
> +           atomic_read(&sk->sk_rmem_alloc) <=3D sk->sk_rcvbuf >> 1)
>                 l2cap_chan_busy(pi->chan, 0);
>
>  done:
> @@ -1474,17 +1481,21 @@ static struct l2cap_chan *l2cap_sock_new_connecti=
on_cb(struct l2cap_chan *chan)
>  static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *s=
kb)
>  {
>         struct sock *sk =3D chan->data;
> +       struct l2cap_pinfo *pi =3D l2cap_pi(sk);
> +       int avail;
>         int err;
>
>         lock_sock(sk);
>
> -       if (l2cap_pi(sk)->rx_busy_skb) {
> +       if (chan->mode =3D=3D L2CAP_MODE_ERTM && !list_empty(&pi->rx_busy=
)) {
>                 err =3D -ENOMEM;
>                 goto done;
>         }
>
>         if (chan->mode !=3D L2CAP_MODE_ERTM &&
> -           chan->mode !=3D L2CAP_MODE_STREAMING) {
> +           chan->mode !=3D L2CAP_MODE_STREAMING &&
> +           chan->mode !=3D L2CAP_MODE_LE_FLOWCTL &&
> +           chan->mode !=3D L2CAP_MODE_EXT_FLOWCTL) {
>                 /* Even if no filter is attached, we could potentially
>                  * get errors from security modules, etc.
>                  */
> @@ -1495,7 +1506,10 @@ static int l2cap_sock_recv_cb(struct l2cap_chan *c=
han, struct sk_buff *skb)
>
>         err =3D __sock_queue_rcv_skb(sk, skb);
>
> -       /* For ERTM, handle one skb that doesn't fit into the recv
> +       avail =3D max(0, sk->sk_rcvbuf - atomic_read(&sk->sk_rmem_alloc))=
;
> +       l2cap_chan_rx_avail(chan, avail);
> +
> +       /* For ERTM and LE, handle a skb that doesn't fit into the recv
>          * buffer.  This is important to do because the data frames
>          * have already been acked, so the skb cannot be discarded.
>          *
> @@ -1504,8 +1518,18 @@ static int l2cap_sock_recv_cb(struct l2cap_chan *c=
han, struct sk_buff *skb)
>          * acked and reassembled until there is buffer space
>          * available.
>          */
> -       if (err < 0 && chan->mode =3D=3D L2CAP_MODE_ERTM) {
> -               l2cap_pi(sk)->rx_busy_skb =3D skb;
> +       if (err < 0 &&
> +           (chan->mode =3D=3D L2CAP_MODE_ERTM ||
> +            chan->mode =3D=3D L2CAP_MODE_LE_FLOWCTL ||
> +            chan->mode =3D=3D L2CAP_MODE_EXT_FLOWCTL)) {
> +               struct l2cap_rx_busy *rx_busy =3D
> +                       kmalloc(sizeof(*rx_busy), GFP_KERNEL);
> +               if (!rx_busy) {
> +                       err =3D -ENOMEM;
> +                       goto done;
> +               }
> +               rx_busy->skb =3D skb;
> +               list_add_tail(&rx_busy->list, &pi->rx_busy);
>                 l2cap_chan_busy(chan, 1);
>                 err =3D 0;
>         }
> @@ -1731,6 +1755,8 @@ static const struct l2cap_ops l2cap_chan_ops =3D {
>
>  static void l2cap_sock_destruct(struct sock *sk)
>  {
> +       struct l2cap_rx_busy *rx_busy, *next;
> +
>         BT_DBG("sk %p", sk);
>
>         if (l2cap_pi(sk)->chan) {
> @@ -1738,9 +1764,10 @@ static void l2cap_sock_destruct(struct sock *sk)
>                 l2cap_chan_put(l2cap_pi(sk)->chan);
>         }
>
> -       if (l2cap_pi(sk)->rx_busy_skb) {
> -               kfree_skb(l2cap_pi(sk)->rx_busy_skb);
> -               l2cap_pi(sk)->rx_busy_skb =3D NULL;
> +       list_for_each_entry_safe(rx_busy, next, &l2cap_pi(sk)->rx_busy, l=
ist) {
> +               kfree_skb(rx_busy->skb);
> +               list_del(&rx_busy->list);
> +               kfree(rx_busy);
>         }
>
>         skb_queue_purge(&sk->sk_receive_queue);
> @@ -1845,6 +1872,8 @@ static struct sock *l2cap_sock_alloc(struct net *ne=
t, struct socket *sock,
>         sk->sk_destruct =3D l2cap_sock_destruct;
>         sk->sk_sndtimeo =3D L2CAP_CONN_TIMEOUT;
>
> +       INIT_LIST_HEAD(&l2cap_pi(sk)->rx_busy);
> +
>         chan =3D l2cap_chan_create();
>         if (!chan) {
>                 sk_free(sk);
> @@ -1853,6 +1882,8 @@ static struct sock *l2cap_sock_alloc(struct net *ne=
t, struct socket *sock,
>
>         l2cap_chan_hold(chan);
>
> +       l2cap_chan_rx_avail(chan, sk->sk_rcvbuf);
> +
>         l2cap_pi(sk)->chan =3D chan;
>
>         return sk;
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz

