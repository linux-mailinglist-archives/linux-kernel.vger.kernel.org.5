Return-Path: <linux-kernel+bounces-140246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D278A101C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38B78B20D14
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421AA1487C1;
	Thu, 11 Apr 2024 10:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="fjH9UUUv"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DC31474B0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831430; cv=none; b=hsOyNDKKuQg9vAq2RpUcEIlF32Gf2K5pakjO8aot+vRVghGEQEa7oon7W5txqcv1pDVP7L5kYCzB3lh9Qmi1d8XCZlXUr++LYd01F66/J+2ssLTu/Lkb4T9QXRtgMcJpGsKdWAvAJckRO8Wy4ak9aQXc74T2USEhEGqJtGHWvvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831430; c=relaxed/simple;
	bh=50uxhrWSQLt8YR5X0zgVM0tqAIGHTy5nv3Z8FfXt19I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SdEII8AwKcu9hUHrdjnIHR9DD8QiFxffRFm5pP21Kx3UKGvRpg2vU1XctbA6q7APbwweLCOiV00MBzfhEhNhhvih9wZrYWU2WZJhyl4DbRogL10Uf9phCMOSPSvFfY/KWhAKthffwEPBvz2JG3EFE+3dPELr+i0iLyj8uNnm3tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=fjH9UUUv; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-61816fc256dso40845367b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 03:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1712831427; x=1713436227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2A2qtHjer/NwHLO+R/j6J4SvBNvk66wxcNgM9Na8jo=;
        b=fjH9UUUvGwB7ffUplXKEX8fHliizAaUU61YD76+0eg2Y/RH5D57GwCXIPBlZhQ4aOV
         LyV+9nxJIHiw6sjF/Iin0t9apeCQRuImaX6dCjyBBoMH3o6hckEmSSo4yl7y3IdJTizD
         ggpG0cMSJI0SeSUdJ0MmjG3c9n9EKbflCUtnibAsBpma4C0MMGMaeoOVtvQJbd/LtHJp
         cr/fReCYgNW3ur3RtnHUAB32vsJPQznsXufpo4mlT0YhET0uLu04dFBdifNKqk4iaVLq
         HGdNToLdP8RGBfKkORKfM6gSGsOqs3RerkFQ5BtXyUeAbYDojLDJL/07Bp7Pfh5y93Qx
         23Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712831427; x=1713436227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2A2qtHjer/NwHLO+R/j6J4SvBNvk66wxcNgM9Na8jo=;
        b=NeShWO7SSt0pcbN4d5tCLnQ4j5fGqAcREFe7+mrZhI7p54CPm9hhDmOYL5Jm/g1FE7
         gPCNaHY7NOAAApHB4QV73ifbSyBPschVXM1yGNrsNhZi6+UI1N8aS2MRtnDEGswXoQAr
         mb8nyn78m/4URWaFsw+b6ne/AOQoG/+X8p9FloWp0k+G7y0ZBUHgXQMeSz2jQ+sA5W9a
         jPivS0tsZVrAHo9RNAVTJSwcbaUTH5F7kv0YRk2cVZA8IC9Ig+dY4/UDgDYCSA9H0tgc
         ZGw52AIK/+l0qCUXRqoe66Yz628MJwb2CvmOi6GRiVGd2SDzN7puWFJgfg35HfavItRB
         QFgg==
X-Forwarded-Encrypted: i=1; AJvYcCVITot7wQv0f0q0pSKxiGpN/z/Fkr0nxmr1om2tba54L7CgesfdE5FHgspEUMFXCpZVwKpgGJUTjA4VCY9RPGZ3hD5u/Os6DwuLHdVv
X-Gm-Message-State: AOJu0YwowMBzGGBf1dhHbkuumax6T8PHkx44KKAoJRawofFasVixJ9Zj
	2S+kO4m736OWfh5+GSg+vGzAlbCUTFKUMlhFkRWriHE0acUFa0mPJyd7vyzO2CWrTzBVENacwDI
	N/24wbmLU2sMZYb7ho0AXWbV/rM/shhDSfSMKWA==
X-Google-Smtp-Source: AGHT+IHb0GZNvwMcbZzb2flBPEIMO1uB/CHJs2V2e/2fw1ihcJnOo0o3gXVwUEL9e79yPEvJFoZHl1TVQUUFrP373Bg=
X-Received: by 2002:a0d:d80f:0:b0:615:35e1:e512 with SMTP id
 a15-20020a0dd80f000000b0061535e1e512mr5524397ywe.0.1712831425508; Thu, 11 Apr
 2024 03:30:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410042245.2044516-1-lei.chen@smartx.com> <6616ac464484f_2a98a52941f@willemb.c.googlers.com.notmuch>
In-Reply-To: <6616ac464484f_2a98a52941f@willemb.c.googlers.com.notmuch>
From: Lei Chen <lei.chen@smartx.com>
Date: Thu, 11 Apr 2024 18:30:13 +0800
Message-ID: <CAKcXpBxd9uu=eH9AsupqwQXiedBjTtOm_Uts-cHqXfstCv-YUg@mail.gmail.com>
Subject: Re: [PATCH v2] net:tun: limit printing rate when illegal packet
 received by tun dev
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 11:12=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> For a next patch, include the target branch: [PATCH net-next v2]
>
> Lei Chen wrote:
> > vhost_worker will call tun call backs to receive packets. If too many
> > illegal packets arrives, tun_do_read will keep dumping packet contents.
> > When console is enabled, it will costs much more cpu time to dump
> > packet and soft lockup will be detected.
> >
> > net_ratelimit mechanism can be used to limit the dumping rate.
> >
> > PID: 33036    TASK: ffff949da6f20000  CPU: 23   COMMAND: "vhost-32980"
> >  #0 [fffffe00003fce50] crash_nmi_callback at ffffffff89249253
> >  #1 [fffffe00003fce58] nmi_handle at ffffffff89225fa3
> >  #2 [fffffe00003fceb0] default_do_nmi at ffffffff8922642e
> >  #3 [fffffe00003fced0] do_nmi at ffffffff8922660d
> >  #4 [fffffe00003fcef0] end_repeat_nmi at ffffffff89c01663
> >     [exception RIP: io_serial_in+20]
> >     RIP: ffffffff89792594  RSP: ffffa655314979e8  RFLAGS: 00000002
> >     RAX: ffffffff89792500  RBX: ffffffff8af428a0  RCX: 0000000000000000
> >     RDX: 00000000000003fd  RSI: 0000000000000005  RDI: ffffffff8af428a0
> >     RBP: 0000000000002710   R8: 0000000000000004   R9: 000000000000000f
> >     R10: 0000000000000000  R11: ffffffff8acbf64f  R12: 0000000000000020
> >     R13: ffffffff8acbf698  R14: 0000000000000058  R15: 0000000000000000
> >     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
> >  #5 [ffffa655314979e8] io_serial_in at ffffffff89792594
> >  #6 [ffffa655314979e8] wait_for_xmitr at ffffffff89793470
> >  #7 [ffffa65531497a08] serial8250_console_putchar at ffffffff897934f6
> >  #8 [ffffa65531497a20] uart_console_write at ffffffff8978b605
> >  #9 [ffffa65531497a48] serial8250_console_write at ffffffff89796558
> >  #10 [ffffa65531497ac8] console_unlock at ffffffff89316124
> >  #11 [ffffa65531497b10] vprintk_emit at ffffffff89317c07
> >  #12 [ffffa65531497b68] printk at ffffffff89318306
> >  #13 [ffffa65531497bc8] print_hex_dump at ffffffff89650765
> >  #14 [ffffa65531497ca8] tun_do_read at ffffffffc0b06c27 [tun]
> >  #15 [ffffa65531497d38] tun_recvmsg at ffffffffc0b06e34 [tun]
> >  #16 [ffffa65531497d68] handle_rx at ffffffffc0c5d682 [vhost_net]
> >  #17 [ffffa65531497ed0] vhost_worker at ffffffffc0c644dc [vhost]
> >  #18 [ffffa65531497f10] kthread at ffffffff892d2e72
> >  #19 [ffffa65531497f50] ret_from_fork at ffffffff89c0022f
> >
> > Signed-off-by: Lei Chen <lei.chen@smartx.com>
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> >
> > ---
> > Changes from v1:
> > https://lore.kernel.org/all/20240409062407.1952728-1-lei.chen@smartx.co=
m/
> >  1. Use net_ratelimit instead of raw __ratelimit.
> >  2. Use netdev_err instead of pr_err to print more info abort net dev.
> >  3. Adjust git commit message to make git am happy.
> >
> >  drivers/net/tun.c | 18 ++++++++++--------
> >  1 file changed, 10 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > index 0b3f21cba552..ca9b4bc89de7 100644
> > --- a/drivers/net/tun.c
> > +++ b/drivers/net/tun.c
> > @@ -2125,14 +2125,16 @@ static ssize_t tun_put_user(struct tun_struct *=
tun,
> >                                           tun_is_little_endian(tun), tr=
ue,
> >                                           vlan_hlen)) {
> >                       struct skb_shared_info *sinfo =3D skb_shinfo(skb)=
;
> > -                     pr_err("unexpected GSO type: "
> > -                            "0x%x, gso_size %d, hdr_len %d\n",
> > -                            sinfo->gso_type, tun16_to_cpu(tun, gso.gso=
_size),
> > -                            tun16_to_cpu(tun, gso.hdr_len));
> > -                     print_hex_dump(KERN_ERR, "tun: ",
> > -                                    DUMP_PREFIX_NONE,
> > -                                    16, 1, skb->head,
> > -                                    min((int)tun16_to_cpu(tun, gso.hdr=
_len), 64), true);
> > +
> > +                     if (net_ratelimit()) {
> > +                             netdev_err(tun->dev, "unexpected GSO type=
: 0x%x, gso_size %d, hdr_len %d\n",
> > +                                    sinfo->gso_type, tun16_to_cpu(tun,=
 gso.gso_size),
> > +                                    tun16_to_cpu(tun, gso.hdr_len));
> > +                             print_hex_dump(KERN_ERR, "tun: ",
> > +                                            DUMP_PREFIX_NONE,
> > +                                            16, 1, skb->head,
> > +                                            min((int)tun16_to_cpu(tun,=
 gso.hdr_len), 64), true);
> > +                     }
> >                       WARN_ON_ONCE(1);
> >                       return -EINVAL;
> >               }
> >
> > base-commit: fec50db7033ea478773b159e0e2efb135270e3b7
> > prerequisite-patch-id: 8952e320c0272899e153c953db09446879ed0d87
> > prerequisite-patch-id: 2f1e3234a4ac0bf421df2061505612538f128672
>
> Where does this footer come from? Should not be present.
>
Thanks for your review. This footer comes from "git format-patch --base=3Da=
uto",
I will remake the patch with "--base" options removed.

