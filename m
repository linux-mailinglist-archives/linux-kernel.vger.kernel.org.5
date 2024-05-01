Return-Path: <linux-kernel+bounces-165342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 501188B8B7F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F24D22833EA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557D212EBED;
	Wed,  1 May 2024 13:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3IRu0op"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF3412DDB0;
	Wed,  1 May 2024 13:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714571809; cv=none; b=q29/LmCoyoCkDV0yyC+Zf3wBH1VTOOCXlvzlWKp4dQ00dKAZQ9ewDuS7Gl0eU4A5sxxmI1FEmDnQ9sTeF+P5PRtAgwRBxBKd0QiQPlOmNvPpjHxWFRkMs8CrO6tMwxqNCTzLAvFcM+uTfy7+bTw5BLerE3WTYG1Tt6z+C5mwq2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714571809; c=relaxed/simple;
	bh=I9/sonkekUKP61+tVuNej9l/6SsNnlJ9LSTUd/rfZkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tihdZYRJ7xhvgaO+/I5VVZK7iYN0ZoUUHJ7qFsMCsO48TOuAtMHzkd4/qlUzCOy8EP3nog/u6x0FVxcaiKN8a9CcmFiNXLZVcqcz8cSYQRDp4xmip+SmoFCF6n2/BNfLbBiJ/iID9eTV0ZM8E6ubS/x9SW/o74nPkzWc4WBQZTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3IRu0op; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d8a24f8a3cso84067781fa.1;
        Wed, 01 May 2024 06:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714571806; x=1715176606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5o9h7CyRbSM2Z9iwT1O8fzqhTixZGuq1fIXQDnNM8w=;
        b=l3IRu0opfmLIEF0/N0hfjbthorxTNwYVHI0tMcBx5t0Q4x9RBJTSWqtFf0BO+jH6gv
         Cdpnx1pBDNbn4M0CGMjVbVvm4OiG97oC655FB1F98wQ/mUPyjdECB9KIjUeZbEAATca2
         WDCxPsEi3O+dyY3DlEe9KzHZCoIKi4UE3dyOT3CD7AoQFs9iATbLbBbuCcXkGtoR/rza
         kmUftA0TRD4iwiDXi2zVDSLoZ+OtjyYJr6sPODRm0sCasCdAw5bwvjOME/RkvQbTaZoe
         5nhYR2/99+6BmG9kDq+SgBdM/qItlHaMNS4APbiDqaaRLB6mkkOhlLf3qepXMwmgaeHx
         cdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714571806; x=1715176606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5o9h7CyRbSM2Z9iwT1O8fzqhTixZGuq1fIXQDnNM8w=;
        b=GRNYSPA0gMY0pwFOL1zoMHdD9RN0Jn8t9AOl7VK5jh2k+joJ7eA3GyszuvMX77Q6DT
         8hFoDIWl4cFg+JnPQzgKCHCm6L1EP7PrF/6s+ItUhmTTdTbfRKY176pdcRHbZsPKMEQs
         Tsks0ZMsul5cJava0B452tsNHSi9uQQS+bKM/ZpXlIiCbQPHf0JP5Wumk7A0ybOQMRD/
         obZcQTUmMKKIV6Hw7YYGKTuJ8Ct4xv2me8uT0m/bLwSUhG8a13S37ouRZLAvJbIgitPR
         XuGMneDX6wQhTOzRcVqMRtprdnyKDrhWFzfJKoTvyDqOw3q0RAOa+5JCIb5vFuiY/ffz
         Ep5w==
X-Forwarded-Encrypted: i=1; AJvYcCV/6N+DL4g15Y7Gc9/BTLFUUh6tEi/jhW/e0SlH7d6Os+ty5e5A/O7ZAY5j5HwXAnzmsRNqbqBWtqyKQ1j5VZNOU/n9a8M5Aw7jT/FvTmt7OwsHXe0jRdbNxryu1lRUXJCIZ4q8GE3Bhy35uT7sBoXw8ygqF6UXKNcJ+Y8TI2Ne2Rrc4fe7
X-Gm-Message-State: AOJu0YyfasAsYlGPmgpIVu7XfRupZou2j5kt961VBrlM6drVcVtBOE7c
	UGIS987tB5uAkw1poRlGt4iOt/uEiFiqJLFhSmoVZcBqTezOiVgFCBGbjWQlUmBtsfopTuDXZ21
	7IwRgXEvrpu1GS/EdAESqMbTjalw=
X-Google-Smtp-Source: AGHT+IHoQehqIewmZifCGqAVdkRxxmL0qOniySl3Wx2R1Sn96ExPTHU1An7TaQB+mkp1g5ni35R2tcirbbEWteY2Sik=
X-Received: by 2002:a05:651c:1a07:b0:2dd:c9fc:c472 with SMTP id
 by7-20020a05651c1a0700b002ddc9fcc472mr2102817ljb.26.1714571804965; Wed, 01
 May 2024 06:56:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501042936.2579739-1-iam@sung-woo.kim>
In-Reply-To: <20240501042936.2579739-1-iam@sung-woo.kim>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 1 May 2024 09:56:32 -0400
Message-ID: <CABBYNZK-KtTg4XrwK0_FaTXT_=TfS5yD1=TF2a=Mq2ojRDs=Ag@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: L2CAP: Fix div-by-zero in l2cap_le_flowctl_init()
To: Sungwoo Kim <iam@sung-woo.kim>
Cc: daveti@purdue.edu, benquike@gmail.com, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sungwoo,

On Wed, May 1, 2024 at 12:32=E2=80=AFAM Sungwoo Kim <iam@sung-woo.kim> wrot=
e:
>
> Hi Luiz, could you review this patch?
>
> This patch prevents a div-by-zero error and potential int overflow by
> adding a range check for MTU in hci_cc_le_read_buffer_size() and
> hci_cc_le_read_buffer_size_v2().
> Also, hci_connect_le() will refuse to allocate hcon if the MTU is not in
> the valid range.
>
> Bug description:
>
> l2cap_le_flowctl_init() can cause both div-by-zero and an integer overflo=
w.
>
> l2cap_le_flowctl_init()
>   chan->mps =3D min_t(u16, chan->imtu, chan->conn->mtu - L2CAP_HDR_SIZE);
>   chan->rx_credits =3D (chan->imtu / chan->mps) + 1;  <- div-by-zero
>
> Here, chan->conn->mtu could be less than or equal to L2CAP_HDR_SIZE (4).
> If mtu is 4, it causes div-by-zero. If mtu is less than 4, it causes an
> integer overflow.
>
> How mtu could have such low value:
>
> hci_cc_le_read_buffer_size()
>   hdev->le_mtu =3D __le16_to_cpu(rp->le_mtu);
>
> l2cap_conn_add()
>   conn->mtu =3D hcon->hdev->le_mtu;
>
> As shown, mtu is an input from an HCI device. So, any HCI device can
> set mtu value to any value, such as lower than 4.
> According to the spec v5.4 7.8.2 LE Read Buffer Size command, the value
> should be fall in [0x001b, 0xffff].
>
> Thank you,
> Sungwoo.
>
> divide error: 0000 [#1] PREEMPT SMP KASAN NOPTI
> CPU: 0 PID: 67 Comm: kworker/u5:0 Tainted: G        W          6.9.0-rc5+=
 #20
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/0=
1/2014
> Workqueue: hci0 hci_rx_work
> RIP: 0010:l2cap_le_flowctl_init+0x19e/0x3f0 net/bluetooth/l2cap_core.c:54=
7
> Code: e8 17 17 0c 00 66 41 89 9f 84 00 00 00 bf 01 00 00 00 41 b8 02 00 0=
0 00 4c 89 fe 4c 89 e2 89 d9 e8 27 17 0c 00 44 89 f0 31 d2 <66> f7 f3 89 c3=
 ff c3 4d 8d b7 88 00 00 00 4c 89 f0 48 c1 e8 03 42
> RSP: 0018:ffff88810bc0f858 EFLAGS: 00010246
> RAX: 00000000000002a0 RBX: 0000000000000000 RCX: dffffc0000000000
> RDX: 0000000000000000 RSI: ffff88810bc0f7c0 RDI: ffffc90002dcb66f
> RBP: ffff88810bc0f880 R08: aa69db2dda70ff01 R09: 0000ffaaaaaaaaaa
> R10: 0084000000ffaaaa R11: 0000000000000000 R12: ffff88810d65a084
> R13: dffffc0000000000 R14: 00000000000002a0 R15: ffff88810d65a000
> FS:  0000000000000000(0000) GS:ffff88811ac00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000100 CR3: 0000000103268003 CR4: 0000000000770ef0
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  l2cap_le_connect_req net/bluetooth/l2cap_core.c:4902 [inline]
>  l2cap_le_sig_cmd net/bluetooth/l2cap_core.c:5420 [inline]
>  l2cap_le_sig_channel net/bluetooth/l2cap_core.c:5486 [inline]
>  l2cap_recv_frame+0xe59d/0x11710 net/bluetooth/l2cap_core.c:6809
>  l2cap_recv_acldata+0x544/0x10a0 net/bluetooth/l2cap_core.c:7506
>  hci_acldata_packet net/bluetooth/hci_core.c:3939 [inline]
>  hci_rx_work+0x5e5/0xb20 net/bluetooth/hci_core.c:4176
>  process_one_work kernel/workqueue.c:3254 [inline]
>  process_scheduled_works+0x90f/0x1530 kernel/workqueue.c:3335
>  worker_thread+0x926/0xe70 kernel/workqueue.c:3416
>  kthread+0x2e3/0x380 kernel/kthread.c:388
>  ret_from_fork+0x5c/0x90 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
>
> Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
> ---
> v1 -> v2:
> - Reply with an error code if a given MTU is not valid.
> - Refuse hcon allocation if MTU is not still valid.
>
>  include/net/bluetooth/hci.h | 6 ++++++
>  net/bluetooth/hci_conn.c    | 4 ++++
>  net/bluetooth/hci_event.c   | 6 ++++++
>  3 files changed, 16 insertions(+)
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 5c12761cb..a7bc07e9c 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -1666,6 +1666,12 @@ struct hci_cp_le_set_event_mask {
>         __u8     mask[8];
>  } __packed;
>
> +/* BLUETOOTH CORE SPECIFICATION Version 5.4 | Vol 4, Part E
> + * 7.8.2 LE Read Buffer Size command
> + */
> +#define HCI_MIN_LE_MTU 0x001b
> +#define HCI_MAX_LE_MTU 0xFFFF

Don't think we really need the MAX value here since it is that same as
the maximum field can assume so doing x > MAX is sort of useless as it
loops around if that happens.

>  #define HCI_OP_LE_READ_BUFFER_SIZE     0x2002
>  struct hci_rp_le_read_buffer_size {
>         __u8     status;
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 05346250f..0b86a7452 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -1277,6 +1277,10 @@ struct hci_conn *hci_connect_le(struct hci_dev *hd=
ev, bdaddr_t *dst,
>                 return ERR_PTR(-EOPNOTSUPP);
>         }
>
> +       /* Check the mtu is valid */
> +       if (hdev->le_mtu < HCI_MIN_LE_MTU || HCI_MAX_LE_MTU < hdev->le_mt=
u)
> +               return ERR_PTR(-ECONNREFUSED);
> +

That probably needs to be done on hci_conn_add if we want to capture
both incoming and outgoing.

>         /* Since the controller supports only one LE connection attempt a=
t a
>          * time, we return -EBUSY if there is any connection attempt runn=
ing.
>          */
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 4a27e4a17..a8563cbe2 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1263,6 +1263,9 @@ static u8 hci_cc_le_read_buffer_size(struct hci_dev=
 *hdev, void *data,
>
>         BT_DBG("%s le mtu %d:%d", hdev->name, hdev->le_mtu, hdev->le_pkts=
);
>
> +       if (hdev->le_mtu < HCI_MIN_LE_MTU || HCI_MAX_LE_MTU < hdev->le_mt=
u)
> +               return HCI_ERROR_INVALID_PARAMETERS;

Value 0x00 means 'No dedicated LE Buffer exists. Use the
HCI_Read_Buffer_Size command.' so it is not invalid to return it.

>         return rp->status;
>  }
>
> @@ -3821,6 +3824,9 @@ static u8 hci_cc_le_read_buffer_size_v2(struct hci_=
dev *hdev, void *data,
>         BT_DBG("%s acl mtu %d:%d iso mtu %d:%d", hdev->name, hdev->acl_mt=
u,
>                hdev->acl_pkts, hdev->iso_mtu, hdev->iso_pkts);
>
> +       if (hdev->le_mtu < HCI_MIN_LE_MTU || HCI_MAX_LE_MTU < hdev->le_mt=
u)
> +               return HCI_ERROR_INVALID_PARAMETERS;

Ditto, this should really be:

if (hdev->le_mtu && hdev->le_mtu < HCI_MIN_LE_MTU)

>         return rp->status;
>  }
>
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz

