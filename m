Return-Path: <linux-kernel+bounces-14626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF42B821FD6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EB142837C0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E82415482;
	Tue,  2 Jan 2024 17:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0A0QduQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E92314F90;
	Tue,  2 Jan 2024 17:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ccae380df2so80705361fa.1;
        Tue, 02 Jan 2024 09:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704214967; x=1704819767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZEwBLvF9Y4d17YjjhcYaJhtR01Ccq3K8z+Azpj8cnk=;
        b=a0A0QduQ8t11AevTlgCVXyKae/N2D6XVbx9z4VrY5KLGcr9clw6b72Va4iciYGMnun
         Y5dKpSTkbeHho8MVAX3caoClUAJ2pmPLs4amr8GxriZgheYYaWRQeo6jT69LFxKMTtyG
         cYku7GGnhIcp9vVuasXTvH7zAjgBSr0Aa0y1SLIxO096Qk5ki+dLmOOyHvlGiSVJjroE
         w8VOx+3ZCb9sRLAf8nxTJZqGxSyZ1w0/aFNqSHPXchnPRYyChQKXSeTH089KouUC/Fq4
         fe5UGZ7iRD1XVA7dN7Et8kjZwiIgwoENpoMSw32EdYApi5ds7YexzwNDqZkoGzOxAd2Z
         o51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704214967; x=1704819767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZEwBLvF9Y4d17YjjhcYaJhtR01Ccq3K8z+Azpj8cnk=;
        b=ixKQrM7+BCzrVkNkXl3CYp/cvNdmEg49aN3fQxUHi4J1JGMSYAFNaUQN3V8++z99Us
         bdDNTxq7llTYzLh9qmJOU6eEeAbdMGLyH0YNbRbvj3SadtOWihS7aXR+Xt/FE5MbQbrm
         xZdjD60yDyo0DvlD0daDPipujV+1R3nECvcqhY7pI4lnU/ePnCNQgNxNBk1zw8YRJbKx
         z3Ha3Vr+m2HqKS0zcO+DJIVKQEHTyhJ7KHpVzttNeN3sTlPAkAd4OF3AtVAKVVcrkknp
         QzVLNaq+s+6eXTZ24AIx8CpqqJ0b1opT8VJb/pnqWqxQAwjDM4l5XkMdq025z4cpp9mj
         GjYA==
X-Gm-Message-State: AOJu0YwQUO/MNHiyu0gDnIMakxgJn0Ld4kaPitHKJ/+QtikS+HNWdQ14
	ZQutbPCmktJKRndVf2PVHANj5FZMTrst2hgdYjQ=
X-Google-Smtp-Source: AGHT+IGR5JYf+PhoFPpqNMfs+VSndcb7wZR4OaFLnp65FSCY+hlGwXaK3FmAJZU2ihMtkbtoA+lNb/hjxr7Q4iuAZ1Q=
X-Received: by 2002:a2e:9b95:0:b0:2cc:d45a:48d8 with SMTP id
 z21-20020a2e9b95000000b002ccd45a48d8mr4051382lji.43.1704214967331; Tue, 02
 Jan 2024 09:02:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231226073957.328124-1-20373622@buaa.edu.cn>
In-Reply-To: <20231226073957.328124-1-20373622@buaa.edu.cn>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 2 Jan 2024 12:02:35 -0500
Message-ID: <CABBYNZJoH9WZ8cadJG9H63T5FvG0KS0uSNKrZFP4XvOPWy+APw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: rfcomm: Fix null-ptr-deref in
To: Yuxuan Hu <20373622@buaa.edu.cn>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, sy2239101@buaa.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yuxuan,

On Tue, Dec 26, 2023 at 2:40=E2=80=AFAM Yuxuan Hu <20373622@buaa.edu.cn> wr=
ote:
>
> During our fuzz testing of the connection and disconnection process at th=
e
> RFCOMM layer,we discovered this bug.By comparing the packetsfrom a normal
> connection and disconnection process with the testcase that triggered a
> KASAN report, we analyzed the cause of this bug as follows:
>
> 1. In the packets captured during a normal connection, the host sends a
> `Read Encryption Key Size` type of `HCI_CMD` packet(Command Opcode: 0x140=
8)
> to the controller to inquire the length of encryption key.After receiving
> this packet, the controller immediately replies with a Command Complete
> packet (Event Code: 0x0e) to return the Encryption Key Size.
>
> 2. In our fuzz test case, the timing of the controller's response to this
> packet was delayed to an unexpected point: after the RFCOMM and L2CAP
> layers had disconnected but before the HCI layer had disconnected.
>
> 3. After receiving the Encryption Key Size Response at the time described
> in point 2, the host still called the rfcomm_check_security function.
> However, by this time `struct l2cap_conn *conn =3D l2cap_pi(sk)->chan->co=
nn;`
> had already been released, and when the function executed
> `return hci_conn_security(conn->hcon, d->sec_level, auth_type, d->out);`,
> specifically when accessing `conn->hcon`, a null-ptr-deref error occurred=
.
>
> Adding a check for whether `conn` is a null pointer to fix this bug.
>
> Signed-off-by: Yuxuan Hu <20373622@buaa.edu.cn>
> ---
>  net/bluetooth/rfcomm/core.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> index 053ef8f25fae..5ffa197fdb48 100644
> --- a/net/bluetooth/rfcomm/core.c
> +++ b/net/bluetooth/rfcomm/core.c
> @@ -228,6 +228,9 @@ static int rfcomm_check_security(struct rfcomm_dlc *d=
)
>                 auth_type =3D HCI_AT_NO_BONDING;
>                 break;
>         }
> +
> +       if (!conn)
> +               return 0;

This shall probably be handled earlier, perhaps on rfcomm_process_rx
if we can check that had been disconnected, that way we drop packets
that we know don't have any effect since later we do call
rfcomm_session_close e.g:

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 053ef8f25fae..1d34d8497033 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1941,7 +1941,7 @@ static struct rfcomm_session
*rfcomm_process_rx(struct rfcomm_session *s)
        /* Get data directly from socket receive queue without copying it. =
*/
        while ((skb =3D skb_dequeue(&sk->sk_receive_queue))) {
                skb_orphan(skb);
-               if (!skb_linearize(skb)) {
+               if (!skb_linearize(skb) && sk->sk_state !=3D BT_CLOSED) {
                        s =3D rfcomm_recv_frame(s, skb);
                        if (!s)
                                break;

--=20
Luiz Augusto von Dentz

