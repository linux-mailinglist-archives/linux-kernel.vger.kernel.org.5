Return-Path: <linux-kernel+bounces-142919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B61268A320A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BF79282364
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF94D14E2D9;
	Fri, 12 Apr 2024 15:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0Vx0AOl"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9EB14D6F5;
	Fri, 12 Apr 2024 15:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934818; cv=none; b=G1vqYy0RR6i7CT7a5FJav1UaccVpAZtnnmNriHvHtnhTRN8WYOBq/jVM5VLcFB/V9FbN4d++ZnYzZsArV/o8KSpGQGqyvh8GIrfyvoFWBaIbqCkmd3RjXHb3LvgHSRi/3cuHAZFLPo38oNmA4bc2tKT00lPFCK2lw90Jxs7tzm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934818; c=relaxed/simple;
	bh=EYtkPvt5rIZgNbaUo5mvA5zPA1D10VYmYNfdrZbw4sI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=PXMCygo5Q90vp9Ls5VUj/8KeRqTIvCqblcE/mBKtLogUc+g3LWRLzyHt7qv9AW5Qnab0DBBb3WIzXPlLoxxK5xY+RDrCg7N4vIBgqiwRVtGxTvHECFnpsEsUR8kEj/sWX13GNqouNp+/b6Xm+Mixe8kCiD6+8w/XSG6JJK0rdy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0Vx0AOl; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78d70890182so88339885a.0;
        Fri, 12 Apr 2024 08:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712934815; x=1713539615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XpfD6u8jtZPH354BgVW6JCHeTIS8N0DJrzcBwnJFIJQ=;
        b=b0Vx0AOleg/HaN5ufOmGPU8Ev9qY9YOo8Y0hHTzRhu/5b8VQ0BIKD9usXF8d5OWbwK
         iXpLOLPwJVqyWDC4phxXt0Lb8ctKvAz/PDRVeYYLj2FU0aM+t+qVX0qAJqKKVRSR/S3D
         48pXxj+3i9US7LjWR+vOLWZ4oe7M2ktWi5YdFqkdPkzPL7LAyNvDt3LVbNB+x8nSsgEm
         7UvQZ6lLC0RkmH4WqQA5uFixZnkzUJyG6vBm+Pc8VV0e31zajDujU06GVHKzjeh6zrs+
         Wu4zeMIZQvsfL3pfZJSeXH5Ku0H3NYrq1HNAu3khBCkEmY/7NWTUQBoIn0Dhhe+BTVrS
         dX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712934815; x=1713539615;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XpfD6u8jtZPH354BgVW6JCHeTIS8N0DJrzcBwnJFIJQ=;
        b=PACIqVafbaoU4+nUZziO21qRiysXvODa08Dy3tOxPAiNGQyp8YlGTEwxE8jTt/yg9Z
         +5hrMPRVse5IYlTKwaV1ICCtwOHzWvvlGDEvEHFoS12BU6xKGDSS7Panx2TsMUlRDUE0
         HU3+6tl3yUrZDNQHB6uucuc+0SpZejAu9BO8tHxh1d9wQxkR4ibkE/RZLws7kJnmpaJj
         VWApjCSSzfWVgr4wxBvcZTjQnQjN7NEUY0jxNv6GDU+szqpUDhYG8AuIZ4dRuscdtthE
         6eYo1xA3/XZjU4YsxR+b1u6qy2rulYUzoqvxjSdt72W0hn0L89yE4yAWgOKy0p3gM5/5
         kHEA==
X-Forwarded-Encrypted: i=1; AJvYcCWJk5UuNjo5aNCm73WEwNk+vC+7kbWYQG/2zwabOroK5KEhf4c+EJz/vhLMaHaqChydrsVrM/KEKjhBN95FsXJTnSGfNRJIUb7ObOJoHrESMBzrwRMKxM7mkEEcrIeD90Wg1cz7
X-Gm-Message-State: AOJu0Yymfp5bYl5BPqkyx1lKNxgfkCbAqIxLmesLt1zANXzb7LVAMVCZ
	milTvUqwPexGwg3JAfqjdDRVWeQIJk27xSdSUeuPIy7do5UvLDD2mZ3Y6A==
X-Google-Smtp-Source: AGHT+IE4pkAtBZInQBOBmh07ahKbsjMG3RcYg42WT0ls6T6f8ANhbYG4GCoPno+8JVlUtqA7CTFHow==
X-Received: by 2002:a05:620a:298c:b0:78e:d1fc:5121 with SMTP id r12-20020a05620a298c00b0078ed1fc5121mr2391998qkp.0.1712934815376;
        Fri, 12 Apr 2024 08:13:35 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id z14-20020a05620a100e00b0078d60595ff8sm2481662qkj.59.2024.04.12.08.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 08:13:35 -0700 (PDT)
Date: Fri, 12 Apr 2024 11:13:34 -0400
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
Message-ID: <66194f9ecacea_38e253294ed@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240412065841.2148691-1-lei.chen@smartx.com>
References: <20240412065841.2148691-1-lei.chen@smartx.com>
Subject: Re: [PATCH net-next v3] net:tun: limit printing rate when illegal
 packet received by tun dev
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
> Fixes: ef3db4a59542 (\"tun: avoid BUG, dump packet on GSO errors\")

Nit: no escaped parentheses in the Fixes string.

Since there is this small issue, another: target is tun, not net:tun

> Signed-off-by: Lei Chen <lei.chen@smartx.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
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
> ---
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



