Return-Path: <linux-kernel+bounces-23863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1E182B2E7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B57B1F26DD8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA134F8B4;
	Thu, 11 Jan 2024 16:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K56N9zw2"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323DE487BF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 16:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-557bbcaa4c0so10902a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 08:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704990388; x=1705595188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K30QLyCbHCL75IsyofqnBHA8mjC9PVkRkBbAX6BkpK0=;
        b=K56N9zw2RDj3lCyryyCKgmAdYOxn1ZqayPiOdpCfBB8N6EYYd6lejGumKg/Wv10lvh
         8HfA4zd0EI3xqkYxC27QyW8NUsl6o4Jckk7TR3WrBN5Te8IVOGAF0g/KKXSJX17aVDpO
         5Audfjxq2nC+Bqz6WNPxLY6oWC0iHyiROwz1vh54dpVJt+V9k6CWDD4oNjhWwk605hnQ
         eU+jEznaumA8qzAXHLrY94V5Hs3+fSIkxaG8XWJnbMljKPNH1NriUPl6hWh5YqVDa3UE
         BhsI5uPUNUwLjTeiFpAn70owliUFnPMoiHYSBud0/Ks10N1aGUnVZpgHXorJ6A8Ch8uQ
         c79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704990388; x=1705595188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K30QLyCbHCL75IsyofqnBHA8mjC9PVkRkBbAX6BkpK0=;
        b=iV7d9gQF8E6agjXEe0fxbwiLLSD1X13nJY4836eCeI/EBuWy2+WOidwUdB0ZQlRqy5
         LmzSgXHi2nX5Lo2rbCmlMmAtqE3rjlRxqE97SLReD+yE339IrNxVDV/XY/vtG2KECNcs
         7MDdrAaTufobFa8XI8Ff+w3LWeFjX1nd/K7zZ4kFHgr1tjZAE+9BtIqZfM/7j0sLAtR8
         k32uHX/qrg+Bdhg2Zog0KrZ/kIlBdKuRFRMysxWCwuD0lcUD+czAXi9rEJhzwp+59Yvk
         BoMC9z4PZkgXou8vApWQX4sWeHwRDlrOtWjagW1envZd+fDK7B/RCmizxyVogtGGsO4T
         QkMQ==
X-Gm-Message-State: AOJu0YwCk3x8YJB9O3fIElJ3A3DEU0GjA46/L/cHaGT2is0dUzXNe6tW
	mUPK5nUxTSr/zLb1cjI/lZAYyjBC3Cjfycma/teBDgliYjo/yGO0BSJ/pfQde55h
X-Google-Smtp-Source: AGHT+IGG/epSnevZ3tibTtsyj6ljbUTjIpunG+bc1R+QOl/x0GDHrqpNq3C6hvaHo8gUIsrVp/EukS3BSyyLaI9hNG4=
X-Received: by 2002:aa7:c411:0:b0:558:b501:1d2a with SMTP id
 j17-20020aa7c411000000b00558b5011d2amr49800edq.6.1704990388229; Thu, 11 Jan
 2024 08:26:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111154138.7605-1-n.zhandarovich@fintech.ru>
In-Reply-To: <20240111154138.7605-1-n.zhandarovich@fintech.ru>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Jan 2024 17:26:17 +0100
Message-ID: <CANn89iJaxTFGNFqmCJSQfr9nwHUPK6DBnK1oZ1sJ2Gm6eqebag@mail.gmail.com>
Subject: Re: [PATCH net] wireguard: receive: annotate data-race around receiving_counter.counter
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, wireguard@lists.zx2c4.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot <syzkaller@googlegroups.com>, 
	syzbot+d1de830e4ecdaac83d89@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 4:41=E2=80=AFPM Nikita Zhandarovich
<n.zhandarovich@fintech.ru> wrote:
>
> Syzkaller with KCSAN identified a data-race issue [1] when accessing
> keypair->receiving_counter.counter.
>
> This patch uses READ_ONCE() and WRITE_ONCE() annotations to fix the
> problem.
>
> [1]
> BUG: KCSAN: data-race in wg_packet_decrypt_worker / wg_packet_rx_poll
>
> write to 0xffff888107765888 of 8 bytes by interrupt on cpu 0:
>  counter_validate drivers/net/wireguard/receive.c:321 [inline]
>  wg_packet_rx_poll+0x3ac/0xf00 drivers/net/wireguard/receive.c:461
>  __napi_poll+0x60/0x3b0 net/core/dev.c:6536
>  napi_poll net/core/dev.c:6605 [inline]
>  net_rx_action+0x32b/0x750 net/core/dev.c:6738
>  __do_softirq+0xc4/0x279 kernel/softirq.c:553
>  do_softirq+0x5e/0x90 kernel/softirq.c:454
>  __local_bh_enable_ip+0x64/0x70 kernel/softirq.c:381
>  __raw_spin_unlock_bh include/linux/spinlock_api_smp.h:167 [inline]
>  _raw_spin_unlock_bh+0x36/0x40 kernel/locking/spinlock.c:210
>  spin_unlock_bh include/linux/spinlock.h:396 [inline]
>  ptr_ring_consume_bh include/linux/ptr_ring.h:367 [inline]
>  wg_packet_decrypt_worker+0x6c5/0x700 drivers/net/wireguard/receive.c:499
>  process_one_work kernel/workqueue.c:2633 [inline]
>  ...
>
> read to 0xffff888107765888 of 8 bytes by task 3196 on cpu 1:
>  decrypt_packet drivers/net/wireguard/receive.c:252 [inline]
>  wg_packet_decrypt_worker+0x220/0x700 drivers/net/wireguard/receive.c:501
>  process_one_work kernel/workqueue.c:2633 [inline]
>  process_scheduled_works+0x5b8/0xa30 kernel/workqueue.c:2706
>  worker_thread+0x525/0x730 kernel/workqueue.c:2787
>  ...
>
> Fixes: a9e90d9931f3 ("wireguard: noise: separate receive counter from sen=
d counter")
> Reported-by: syzbot+d1de830e4ecdaac83d89@syzkaller.appspotmail.com
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> ---
>  drivers/net/wireguard/receive.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireguard/receive.c b/drivers/net/wireguard/rece=
ive.c
> index a176653c8861..d91383afb6e2 100644
> --- a/drivers/net/wireguard/receive.c
> +++ b/drivers/net/wireguard/receive.c
> @@ -251,7 +251,7 @@ static bool decrypt_packet(struct sk_buff *skb, struc=
t noise_keypair *keypair)
>
>         if (unlikely(!READ_ONCE(keypair->receiving.is_valid) ||
>                   wg_birthdate_has_expired(keypair->receiving.birthdate, =
REJECT_AFTER_TIME) ||
> -                 keypair->receiving_counter.counter >=3D REJECT_AFTER_ME=
SSAGES)) {
> +                 READ_ONCE(keypair->receiving_counter.counter) >=3D REJE=
CT_AFTER_MESSAGES)) {
>                 WRITE_ONCE(keypair->receiving.is_valid, false);
>                 return false;
>         }
> @@ -318,7 +318,7 @@ static bool counter_validate(struct noise_replay_coun=
ter *counter, u64 their_cou
>                 for (i =3D 1; i <=3D top; ++i)
>                         counter->backtrack[(i + index_current) &
>                                 ((COUNTER_BITS_TOTAL / BITS_PER_LONG) - 1=
)] =3D 0;
> -               counter->counter =3D their_counter;
> +               WRITE_ONCE(counter->counter, their_counter);
>         }
>
>         index &=3D (COUNTER_BITS_TOTAL / BITS_PER_LONG) - 1;

It seems you forgot to add this as well ?

diff --git a/drivers/net/wireguard/receive.c b/drivers/net/wireguard/receiv=
e.c
index a176653c88616b1bc871fe52fcea778b5e189f69..a1493c94cea042165f8523a4dac=
573800a6d03c4
100644
--- a/drivers/net/wireguard/receive.c
+++ b/drivers/net/wireguard/receive.c
@@ -463,7 +463,7 @@ int wg_packet_rx_poll(struct napi_struct *napi, int bud=
get)
                        net_dbg_ratelimited("%s: Packet has invalid
nonce %llu (max %llu)\n",
                                            peer->device->dev->name,
                                            PACKET_CB(skb)->nonce,
-                                           keypair->receiving_counter.coun=
ter);
+
READ_ONCE(keypair->receiving_counter.counter));
                        goto next;
                }

Thanks.

