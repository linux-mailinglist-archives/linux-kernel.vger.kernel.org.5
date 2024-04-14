Return-Path: <linux-kernel+bounces-144265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A2F8A43C9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6136F1F21F9B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3F01350DD;
	Sun, 14 Apr 2024 16:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzBC/AUy"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9715B1E493;
	Sun, 14 Apr 2024 16:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713111996; cv=none; b=tzqDnR8yUU4vIGKPJ/pNidSqpV1kNbq/Ms6TWY1UY6oUAYCAj3uhnGcEoYqH+xKAGWOjJzRlNlQRqA41lOitjV+MKePGWSnhlRLteuOaE+GQh2tjuU2pgaceaQEXpFMZ1JR4GkZTCenA5Kp7EcFM/ECfA8qydIaHE+bXdxYlR60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713111996; c=relaxed/simple;
	bh=X7Ay1dngUjs9o5Wo1TBSWBfNjtLII11epB+o6IEEeMQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ZqkTQ3ESmfJEEKvKS9fcGjfdm8ohVO//I2ljFqYb3kNRoDV48Bzr1igLIkm7GHO5yJ6xxzJ7WScytvLJ0Ai35GnAIEaDG3VRD/dMrM6nmLBjRy2USkFXPtTFXUbGOP1VJwlM2yXJx+cpKoVrYSu1hJW//pVUyYU9vrGtvo/bLUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UzBC/AUy; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-69935d567a0so11468506d6.1;
        Sun, 14 Apr 2024 09:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713111993; x=1713716793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YxydSn1uWkfjxcuoBNp/4R/jm//blhzs50MovQ47n10=;
        b=UzBC/AUys3g9k5YjRgxYSe/7Hszn6t3u+gNpI8MQg3rgFJeIWlHXB8F7j27xZnDlsd
         3OO/Lf/o5i8f9Q65ZcWUVlGLdfdX/uWyJfkwQl5WEmz5/wm/9Y1oyg55E0dWAIItwU1U
         f9cg6oldNKlO4nY3gGZMdumApwYIu0IM7OApepVLSqsDAPfYpEu8ur6vtivHRve/HnLA
         dovKJ2kTvQYZbLXc+8yWoC5JrFAf5xvQ2WU20HjIHKR3p970+sKiwGqQNISnvl9I5ZuU
         vjD7lYpxlQf/gpXy1cRXvc+ycN9DQ3z+acMIGZCOetNKmmAIAEISK7WioCoabg3gbUAc
         tRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713111993; x=1713716793;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YxydSn1uWkfjxcuoBNp/4R/jm//blhzs50MovQ47n10=;
        b=Y2aFAJZAS/zIJTmn2vJRXuHpInpQm+mMNiVphre6BvY/BIxHgaSO15UQoRvo/e0T4X
         hqO7yghPg7P1HG10RRtrkPCoudlU8dp9dAjhFHABtaSrue29BpW0kRLZ8KRI7qaH0mcC
         vcyKj1fyChPWp2N7I0lK+84vLDYHBWZmw47nfyf7bgTzyMDSF7fitJ4S18FD29u1H8XA
         dgyd1CGwvk1rwPyY+PV+hnv8qeC02g6Laz5Ns2Ku/LWVqfHaerNPzvHNU11wiztP2XE4
         nNuDucJ4zHFjHnt5HaB+UlJ99lN6QcE0eJgVt5JSLAPR2VfjwBOddsRRbRPbZ2SCXrNL
         DAeg==
X-Forwarded-Encrypted: i=1; AJvYcCW2jlt/ocMjGKzMV7mtuyCkDG6l8MUwM+rNbt3VuXAd5Q2DKsWG3Zo5gQ46Xs9XYAAUBslajy60zZVnF5rKNdyv3nHznEr5/RuEK9UBaCBKepmzE7hTWaJILhjt15OXlAW4Yyrl
X-Gm-Message-State: AOJu0Yzr2zXlpva2s0KBFsh2nEawnQYyYB/Tl+FHRrSKxZmwVDaPrVZZ
	ffM32XI124VyYvd+IVM3JKxPiUB1OGUDN/27L2WEM4LVbWTsyGu9
X-Google-Smtp-Source: AGHT+IFvQU+J/Y/pDu8XRR2w90ai85+h/cuVkxVC4wUE6qEKssGMmvrMlfo9m6TGQduE8IN0quS5sQ==
X-Received: by 2002:a05:6214:bc3:b0:699:4a50:c5c0 with SMTP id ff3-20020a0562140bc300b006994a50c5c0mr7130461qvb.18.1713111993398;
        Sun, 14 Apr 2024 09:26:33 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id h19-20020a0cab13000000b006913aa64629sm5124874qvb.22.2024.04.14.09.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 09:26:33 -0700 (PDT)
Date: Sun, 14 Apr 2024 12:26:32 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Lei Chen <lei.chen@smartx.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Lei Chen <lei.chen@smartx.com>, 
 Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <661c03b8c6cae_3e7732294f8@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240414081806.2173098-1-lei.chen@smartx.com>
References: <20240414081806.2173098-1-lei.chen@smartx.com>
Subject: Re: [PATCH net-next v4] tun: limit printing rate when illegal packet
 received by tun dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Lei Chen wrote:
> vhost_worker will call tun call backs to receive packets. If too many
> illegal packets arrives, tun_do_read will keep dumping packet contents.
> When console is enabled, it will costs much more cpu time to dump
> packet and soft lockup will be detected.
> 
> net_ratelimit mechanism can be used to limit the dumping rate.
> 
> PID: 33036    TASK: ffff949da6f20000  CPU: 23   COMMAND: "vhost-32980"
>  #0 [fffffe00003fce50] crash_nmi_callback at ffffffff89249253
>  #1 [fffffe00003fce58] nmi_handle at ffffffff89225fa3
>  #2 [fffffe00003fceb0] default_do_nmi at ffffffff8922642e
>  #3 [fffffe00003fced0] do_nmi at ffffffff8922660d
>  #4 [fffffe00003fcef0] end_repeat_nmi at ffffffff89c01663
>     [exception RIP: io_serial_in+20]
>     RIP: ffffffff89792594  RSP: ffffa655314979e8  RFLAGS: 00000002
>     RAX: ffffffff89792500  RBX: ffffffff8af428a0  RCX: 0000000000000000
>     RDX: 00000000000003fd  RSI: 0000000000000005  RDI: ffffffff8af428a0
>     RBP: 0000000000002710   R8: 0000000000000004   R9: 000000000000000f
>     R10: 0000000000000000  R11: ffffffff8acbf64f  R12: 0000000000000020
>     R13: ffffffff8acbf698  R14: 0000000000000058  R15: 0000000000000000
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>  #5 [ffffa655314979e8] io_serial_in at ffffffff89792594
>  #6 [ffffa655314979e8] wait_for_xmitr at ffffffff89793470
>  #7 [ffffa65531497a08] serial8250_console_putchar at ffffffff897934f6
>  #8 [ffffa65531497a20] uart_console_write at ffffffff8978b605
>  #9 [ffffa65531497a48] serial8250_console_write at ffffffff89796558
>  #10 [ffffa65531497ac8] console_unlock at ffffffff89316124
>  #11 [ffffa65531497b10] vprintk_emit at ffffffff89317c07
>  #12 [ffffa65531497b68] printk at ffffffff89318306
>  #13 [ffffa65531497bc8] print_hex_dump at ffffffff89650765
>  #14 [ffffa65531497ca8] tun_do_read at ffffffffc0b06c27 [tun]
>  #15 [ffffa65531497d38] tun_recvmsg at ffffffffc0b06e34 [tun]
>  #16 [ffffa65531497d68] handle_rx at ffffffffc0c5d682 [vhost_net]
>  #17 [ffffa65531497ed0] vhost_worker at ffffffffc0c644dc [vhost]
>  #18 [ffffa65531497f10] kthread at ffffffff892d2e72
>  #19 [ffffa65531497f50] ret_from_fork at ffffffff89c0022f
> 
> Fixes: ef3db4a59542 ("tun: avoid BUG, dump packet on GSO errors")
> Signed-off-by: Lei Chen <lei.chen@smartx.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---
> Changes from v3:
> https://lore.kernel.org/all/20240412065841.2148691-1-lei.chen@smartx.com/
>  1. Change patch target from net tun to tun.
>  2. Move change log below the seperator "---".
>  3. Remove escaped parentheses in the Fixes string.
> 
> Changes from v2:
> https://lore.kernel.org/netdev/20240410042245.2044516-1-lei.chen@smartx.com/
>  1. Add net-dev to patch subject-prefix.
>  2. Add fix tag.
> 
> Changes from v1:
> https://lore.kernel.org/all/20240409062407.1952728-1-lei.chen@smartx.com/
>  1. Use net_ratelimit instead of raw __ratelimit.
>  2. Use netdev_err instead of pr_err to print more info abort net dev.
>  3. Adjust git commit message to make git am happy.
>  drivers/net/tun.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 0b3f21cba552..ca9b4bc89de7 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -2125,14 +2125,16 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>  					    tun_is_little_endian(tun), true,
>  					    vlan_hlen)) {
>  			struct skb_shared_info *sinfo = skb_shinfo(skb);
> -			pr_err("unexpected GSO type: "
> -			       "0x%x, gso_size %d, hdr_len %d\n",
> -			       sinfo->gso_type, tun16_to_cpu(tun, gso.gso_size),
> -			       tun16_to_cpu(tun, gso.hdr_len));
> -			print_hex_dump(KERN_ERR, "tun: ",
> -				       DUMP_PREFIX_NONE,
> -				       16, 1, skb->head,
> -				       min((int)tun16_to_cpu(tun, gso.hdr_len), 64), true);
> +
> +			if (net_ratelimit()) {
> +				netdev_err(tun->dev, "unexpected GSO type: 0x%x, gso_size %d, hdr_len %d\n",
> +				       sinfo->gso_type, tun16_to_cpu(tun, gso.gso_size),
> +				       tun16_to_cpu(tun, gso.hdr_len));

Indentation. checkpatch or patchwork will also show this.

> +				print_hex_dump(KERN_ERR, "tun: ",
> +					       DUMP_PREFIX_NONE,
> +					       16, 1, skb->head,
> +					       min((int)tun16_to_cpu(tun, gso.hdr_len), 64), true);
> +			}
>  			WARN_ON_ONCE(1);
>  			return -EINVAL;
>  		}
> -- 
> 2.44.0
> 



