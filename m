Return-Path: <linux-kernel+bounces-133252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD54089A141
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 223FD1F21057
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4124171088;
	Fri,  5 Apr 2024 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jF2z9vwO"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB6D16FF28;
	Fri,  5 Apr 2024 15:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712331066; cv=none; b=f+0ep+FragkyICuCtoAwWhkT1FyK5Wunb3VY7fBfP5L7S1BfsvBT4vnKeWCj49G2qyq6JFaTBriEac1jsmW4/yzfeHIkUPaehkjZ5IYGVOk7uBfHRe+CzB+P47bAq36xmCK24CKbv/YervBws2QoT4XHHf7jhykbZWaSYBSr89g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712331066; c=relaxed/simple;
	bh=OmBDj9D+APUbsGvbX6dUYImvskRi1ucHlYilfQNJ3bc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QdQ8GvtUUQX9aR+w48Xt0mrrnCOlYSYTft2+m4sYGbwPxeEa+ZCW0NWacF1OmSp5Uu0TeO0eXH8V2Rjz0QAbU3JiwMY0A5M6F2PDnXLGrBwWNl1IalDWT4S3e3kp8Ff+cxVDdYurqmm7G1SRQhbtPn8Lydu/Hlanrt5BMtscMpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jF2z9vwO; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d718efedb2so40103651fa.0;
        Fri, 05 Apr 2024 08:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712331063; x=1712935863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i09Ox1kzeWOoRohLwAbOxB5THTw3/XjFiafn5EMnjkc=;
        b=jF2z9vwO5ROQZKoOujIeqKGaUjyhOpxwUEvHnlv2kl1JwUv9YV7WSoc/YbL3azYdty
         G3yOVkfopF2RrSZnnVcuvLkIR52tSs8nrQ8xFkeN9jUUrq5d/F1llgip19D/2xyLpZ4C
         Vl+p6VhZuMppK/CgbSd4N+BKEQ5Ry/oPdZPvYw/iXeKzr8V1kpxoJaUVtPc3sgKGlL+x
         2ufk/rsdLffv8VmODhZUC2VDfJa+eaLYBw3rmrrhNxdadXuR1cN/PwGxUm99zNxTBGS8
         HeZ4wEolSY6C0hCZ7zD85kpXOZISz4dTvk7zGDvajBq2Fls2TX8gpATbJiyfbPzmrx4e
         dPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712331063; x=1712935863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i09Ox1kzeWOoRohLwAbOxB5THTw3/XjFiafn5EMnjkc=;
        b=pBQi9W9+lg/n2Y2dO5TdczLIYzQyTlqIrCb8PRQx1GmqYrMCK+f80u6Da65hJI6q3T
         ZMX3SuDoD+Mytmj5qD4GuydC7Z66mvTB/t9YySWyO79Y4A/aJoyfhDli9/AP2UqCJVby
         3Pu/0e4Az9UBXwezBOSfqwQ8R79OMUzvGeziwN1sDtlh9k5Kc0WvArLkkZGoD3If2tuv
         PPiBl5E3duj/A8TqytJF5UAnrN+aMUzfO5PxNEKWz6M0lCI7DVPTgYUCRQR9CUF89+05
         gvsy5A/2AISAVV4M8BgHo28hO4u5QHOjrMLgJWS5FAkPRjRHcDTi+Nmq5UYXX7vcYq+R
         O4RA==
X-Forwarded-Encrypted: i=1; AJvYcCXaYXZv3L1t63oKh2IR7CeXUDUOoO7anuhr6W7Is0kEmZAMJ8v71DUhCNaA7iQpATQnp4xH4QH+x2ZUSIDIRjTFRd3IN+krTlAl/6wXGnPHOfD+TntqfImmF34JbtAzaTYLQwArFiDZ4+1HGypwaxmgZH9O+xGue6iM8qAwd868z/q/cEMh
X-Gm-Message-State: AOJu0Yxuq1Vt+V0T4W8DuTP9GHMS+QXPXXWZ29BpusZQhp7YI0Iq8sSl
	uGy5Z1NwYbk0XINp3Sp8fUvtrRZy9Ic0hlyZwEgYAMpEAqs+Yk/1T/0IlbdqBrxyBCVLhlM6m6i
	yI+PLrpO+h4KTLhSc9ke14hney7I=
X-Google-Smtp-Source: AGHT+IFLBis/9E8GWORZZLVYrPz1nC95SbSjOxJ7yJKpuoofG+lkM0npryhc2Yfe4J+rrk4DK2IHdCpJzzizXjPrttc=
X-Received: by 2002:a2e:9f41:0:b0:2d8:39cf:5368 with SMTP id
 v1-20020a2e9f41000000b002d839cf5368mr1820026ljk.29.1712331062254; Fri, 05 Apr
 2024 08:31:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405093834.63666-1-surban@surban.net> <20240405102551.114999-1-surban@surban.net>
In-Reply-To: <20240405102551.114999-1-surban@surban.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 5 Apr 2024 11:30:49 -0400
Message-ID: <CABBYNZJfbgDoHr=ZBqf3Rckz7=34Lyq4RRyKbNfpi2qSO6PfqA@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: keep LE flow credits when recvbuf full
To: Sebastian Urban <surban@surban.net>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sebastian,

On Fri, Apr 5, 2024 at 6:26=E2=80=AFAM Sebastian Urban <surban@surban.net> =
wrote:
>
> Previously LE flow credits were returned to the
> sender even if the socket's receive buffer was
> full. This meant that no back-pressure
> was applied to the sender, thus it continued to
> send data, resulting in data loss without any
> error being reported.
>
> This is fixed by stopping the return of LE flow
> credits when the receive buffer of an L2CAP socket
> is full. Returning of the credits is resumed, once
> the receive buffer is half-empty.
>
> Already received data is temporary stored within
> l2cap_pinfo, since Bluetooth LE provides no
> retransmission mechanism once the data has been
> acked by the physical layer.
>
> Signed-off-by: Sebastian Urban <surban@surban.net>
> ---
>  include/net/bluetooth/l2cap.h |  7 ++++-
>  net/bluetooth/l2cap_core.c    | 38 ++++++++++++++++++++++---
>  net/bluetooth/l2cap_sock.c    | 53 ++++++++++++++++++++++++++---------
>  3 files changed, 79 insertions(+), 19 deletions(-)
>
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.=
h
> index 92d7197f9a56..230c14ea944c 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -682,10 +682,15 @@ struct l2cap_user {
>  /* ----- L2CAP socket info ----- */
>  #define l2cap_pi(sk) ((struct l2cap_pinfo *) sk)
>
> +struct l2cap_rx_busy {
> +       struct list_head        list;
> +       struct sk_buff          *skb;
> +};

In theory we only really to queue 1 skb at most, since we would stop
giving credits, or perhaps this is because we had given enough credits
for MTU + 1, so the +1 segment could result in a second SDU/skb to be
completed while waiting the user space process to start reading again?

>  struct l2cap_pinfo {
>         struct bt_sock          bt;
>         struct l2cap_chan       *chan;
> -       struct sk_buff          *rx_busy_skb;
> +       struct list_head        rx_busy;
>  };
>
>  enum {
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index ab5a9d42fae7..c78af7fad255 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -63,6 +63,8 @@ static void l2cap_retrans_timeout(struct work_struct *w=
ork);
>  static void l2cap_monitor_timeout(struct work_struct *work);
>  static void l2cap_ack_timeout(struct work_struct *work);
>
> +static void l2cap_chan_le_send_credits(struct l2cap_chan *chan);

We probably need to change the way send_credits calculates the number
of credits to be restored, it needs to consider the actual available
buffer size at the socket rather then assuming we always shall have
space for MTU + 1, that way the remote side would always have the
exact information of how much buffer space is left. That said perhaps
we need a way to inform when user space reads then we need to call
into send_credits again.

>  static inline u8 bdaddr_type(u8 link_type, u8 bdaddr_type)
>  {
>         if (link_type =3D=3D LE_LINK) {
> @@ -5714,17 +5716,34 @@ static int l2cap_resegment(struct l2cap_chan *cha=
n)
>         return 0;
>  }
>
> -void l2cap_chan_busy(struct l2cap_chan *chan, int busy)
> +static void l2cap_chan_busy_ertm(struct l2cap_chan *chan, int busy)
>  {
>         u8 event;
>
> -       if (chan->mode !=3D L2CAP_MODE_ERTM)
> -               return;
> -
>         event =3D busy ? L2CAP_EV_LOCAL_BUSY_DETECTED : L2CAP_EV_LOCAL_BU=
SY_CLEAR;
>         l2cap_tx(chan, NULL, NULL, event);
>  }
>
> +static void l2cap_chan_busy_le(struct l2cap_chan *chan, int busy)
> +{
> +       if (busy) {
> +               set_bit(CONN_LOCAL_BUSY, &chan->conn_state);
> +       } else {
> +               clear_bit(CONN_LOCAL_BUSY, &chan->conn_state);
> +               l2cap_chan_le_send_credits(chan);
> +       }
> +}
> +
> +void l2cap_chan_busy(struct l2cap_chan *chan, int busy)
> +{
> +       if (chan->mode =3D=3D L2CAP_MODE_ERTM) {
> +               l2cap_chan_busy_ertm(chan, busy);
> +       } else if (chan->mode =3D=3D L2CAP_MODE_LE_FLOWCTL ||
> +                  chan->mode =3D=3D L2CAP_MODE_EXT_FLOWCTL) {
> +               l2cap_chan_busy_le(chan, busy);
> +       }
> +}
> +
>  static int l2cap_rx_queued_iframes(struct l2cap_chan *chan)
>  {
>         int err =3D 0;
> @@ -6514,6 +6533,11 @@ static void l2cap_chan_le_send_credits(struct l2ca=
p_chan *chan)
>         struct l2cap_le_credits pkt;
>         u16 return_credits;
>
> +       if (test_bit(CONN_LOCAL_BUSY, &chan->conn_state)) {
> +               BT_DBG("busy chan %p not returning credits to sender", ch=
an);
> +               return;
> +       }
> +
>         return_credits =3D (chan->imtu / chan->mps) + 1;
>
>         if (chan->rx_credits >=3D return_credits)
> @@ -6542,6 +6566,12 @@ static int l2cap_ecred_recv(struct l2cap_chan *cha=
n, struct sk_buff *skb)
>         /* Wait recv to confirm reception before updating the credits */
>         err =3D chan->ops->recv(chan, skb);
>
> +       if (err < 0) {
> +               BT_ERR("Queueing received LE L2CAP data failed");
> +               l2cap_send_disconn_req(chan, ECONNRESET);
> +               return err;
> +       }
> +
>         /* Update credits whenever an SDU is received */
>         l2cap_chan_le_send_credits(chan);
>
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index ee7a41d6994f..3b0fb6e0b61b 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -1177,7 +1177,9 @@ static int l2cap_sock_recvmsg(struct socket *sock, =
struct msghdr *msg,
>         else
>                 err =3D bt_sock_recvmsg(sock, msg, len, flags);
>
> -       if (pi->chan->mode !=3D L2CAP_MODE_ERTM)
> +       if (pi->chan->mode !=3D L2CAP_MODE_ERTM &&
> +           pi->chan->mode !=3D L2CAP_MODE_LE_FLOWCTL &&
> +           pi->chan->mode !=3D L2CAP_MODE_EXT_FLOWCTL)
>                 return err;
>
>         /* Attempt to put pending rx data in the socket buffer */
> @@ -1187,11 +1189,15 @@ static int l2cap_sock_recvmsg(struct socket *sock=
, struct msghdr *msg,
>         if (!test_bit(CONN_LOCAL_BUSY, &pi->chan->conn_state))
>                 goto done;
>
> -       if (pi->rx_busy_skb) {
> -               if (!__sock_queue_rcv_skb(sk, pi->rx_busy_skb))
> -                       pi->rx_busy_skb =3D NULL;
> -               else
> +       while (!list_empty(&pi->rx_busy)) {
> +               struct l2cap_rx_busy *rx_busy =3D
> +                       list_first_entry(&pi->rx_busy,
> +                                        struct l2cap_rx_busy,
> +                                        list);
> +               if (__sock_queue_rcv_skb(sk, rx_busy->skb) < 0)
>                         goto done;
> +               list_del(&rx_busy->list);
> +               kfree(rx_busy);

I see now, this is trying to dequeue packets if the socket is read,
which in case we turn the send_credits function to calculate the
credits based on the socket buffer size that would not be necessary
but then we would need to call into send_credits here.

>         }
>
>         /* Restore data flow when half of the receive buffer is
> @@ -1459,17 +1465,20 @@ static struct l2cap_chan *l2cap_sock_new_connecti=
on_cb(struct l2cap_chan *chan)
>  static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *s=
kb)
>  {
>         struct sock *sk =3D chan->data;
> +       struct l2cap_pinfo *pi =3D l2cap_pi(sk);
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
> @@ -1480,17 +1489,28 @@ static int l2cap_sock_recv_cb(struct l2cap_chan *=
chan, struct sk_buff *skb)
>
>         err =3D __sock_queue_rcv_skb(sk, skb);
>
> -       /* For ERTM, handle one skb that doesn't fit into the recv
> +       /* For ERTM and LE, handle a skb that doesn't fit into the recv
>          * buffer.  This is important to do because the data frames
>          * have already been acked, so the skb cannot be discarded.
>          *
>          * Notify the l2cap core that the buffer is full, so the
>          * LOCAL_BUSY state is entered and no more frames are
>          * acked and reassembled until there is buffer space
> -        * available.
> +        * available. In the case of LE this blocks returning of flow
> +        * credits.
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
> @@ -1716,6 +1736,8 @@ static const struct l2cap_ops l2cap_chan_ops =3D {
>
>  static void l2cap_sock_destruct(struct sock *sk)
>  {
> +       struct l2cap_rx_busy *rx_busy, *next;
> +
>         BT_DBG("sk %p", sk);
>
>         if (l2cap_pi(sk)->chan) {
> @@ -1723,9 +1745,10 @@ static void l2cap_sock_destruct(struct sock *sk)
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
> @@ -1830,6 +1853,8 @@ static struct sock *l2cap_sock_alloc(struct net *ne=
t, struct socket *sock,
>         sk->sk_destruct =3D l2cap_sock_destruct;
>         sk->sk_sndtimeo =3D L2CAP_CONN_TIMEOUT;
>
> +       INIT_LIST_HEAD(&l2cap_pi(sk)->rx_busy);
> +
>         chan =3D l2cap_chan_create();
>         if (!chan) {
>                 sk_free(sk);
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz

