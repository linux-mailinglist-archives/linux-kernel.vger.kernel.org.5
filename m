Return-Path: <linux-kernel+bounces-138858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3419C89FB41
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B36CB1F2C198
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF83316E879;
	Wed, 10 Apr 2024 15:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRH0rJEh"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557D516D9D6;
	Wed, 10 Apr 2024 15:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712761930; cv=none; b=rg7nMqQJFr+E86qzPsRiuKqUevbIqGVmcpovyI2B/w4HJjIcT0skxzXpxtLa15pbvuonEx1i0Ho35qgNIOONxsR4wX+E2oCzZCgaEHIpMgtoQHseyz2Nh2ZYaLcQ+FwGl99X9vHzIN6YBk7d5FIcUr5D4pNNqGxqgCcHhClvEqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712761930; c=relaxed/simple;
	bh=PnLlpX0dYoTh3H+VJ66VFsqkSeqUQJ+av22z2WeY/Vw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Fme7KYhi5BIy5PAI16W+BQuRdHaKwDDCQgkhRC7xut6Cy3H5ASFU/FJbgefyElUhEaLkH8ZioapXVBmHlck+a1GmFNzlJTqn3IiMpeF63/zRYGSgesz6z2ySksZmLGAB6iChXREGM/tmeZ9gVnZH+RAu3Eie+bWamiMe1lEagUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRH0rJEh; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-78d5e80bc42so325571585a.0;
        Wed, 10 Apr 2024 08:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712761927; x=1713366727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0buxD5ergyhlwM/bRZhq0kApiLYLTYaqWVCh0lur+7o=;
        b=KRH0rJEhqlmQ90CUCQF/L7ZUhbfpufi04WSvIQucnf4vb88pn3dKlcgLWUFeky97XP
         QRIGJ4JMZ4YwK8NRQTSNbC9SQlYRqxONgWhTucdoIc+QurWaaWy1eqLcBC9yR2zbiZ54
         uXFkBGP1X+bUc9ae90RwpP63Kj/+4pdpKPM5AUWgkufseRq7tf5naZP99BFlAF7bkN+W
         URsZedJ/fZlEIFYWmIIVXuk1gs+B4XzX1/Kn13IRQne3iDtRG8bIL3neo1JMDLRkhYRz
         ZKIZB++pQ+DPF5uGEEp/prf/MAIxeUHYB/DswHChaLA0C0F98XmG+ly6CvWLa2nRsikR
         wfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712761927; x=1713366727;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0buxD5ergyhlwM/bRZhq0kApiLYLTYaqWVCh0lur+7o=;
        b=B4HHI1dMnb6+l+T+0ZBqTxrVZMaAYaAlxDNJ/s44D5SheADHC0/Ua7CqsPE8JidmDF
         D7otlvPBmgnzREdc5lfBylQ2YdzpW5lgFn25U/ED7hSIfZUQ9yxc3VHlQo5DR1mMR1k+
         p9GMj7ZA0mCHfUv3uiynzK/bIs6jPd8kAXin4nR08dvl/eNNvMVI2t7KQcIIinsNlSa5
         gXTsASD+eEQC9fF/5JW5eQ00QYzlBsGeIMqrMt8oRIWNSXp3DDTZ1j5ckItSZuh5tPa8
         uTY5Zl3Ci4vgYJzDC5N76TB+4nfvIur8qRJNNUdYoSPNWlSetX9pEn+6ZWRdqi+zYWdU
         YpLw==
X-Forwarded-Encrypted: i=1; AJvYcCUzfnquCbfq9s+ixeD6AtmwqMdZOocQKcHNibsJmtY+ai7pGzXz+Fnprjhg7uvzKimONFJdH/BXVTq/T09ZZ/bNItHy8GI7qYcrGiJ2dsXbhbIfVpy4V+D2BnsGXnDXIo+7+6Lv
X-Gm-Message-State: AOJu0YwJTab4H0DcqqkJI7jUEEHdC6nRr9NNU1+LSsAi11IR2N+a8Dls
	qCod4gTl6A+vgatENAqTt3+zTNedseh+skQUxaQdIiXEjtfFH/M9
X-Google-Smtp-Source: AGHT+IHJoIt77ZZ/Sf8A2EyQW5gFaUj6YT0Erl2mWhULF1CQepi/9pSvO8uF7i1PtRhlCiuN+Gm9uw==
X-Received: by 2002:a05:6214:c26:b0:698:f66f:bdf3 with SMTP id a6-20020a0562140c2600b00698f66fbdf3mr2930121qvd.28.1712761927259;
        Wed, 10 Apr 2024 08:12:07 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id f4-20020ad45584000000b0069937049aadsm5178528qvx.88.2024.04.10.08.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 08:12:06 -0700 (PDT)
Date: Wed, 10 Apr 2024 11:12:06 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Lei Chen <lei.chen@smartx.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Lei Chen <lei.chen@smartx.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <6616ac464484f_2a98a52941f@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240410042245.2044516-1-lei.chen@smartx.com>
References: <20240410042245.2044516-1-lei.chen@smartx.com>
Subject: Re: [PATCH v2] net:tun: limit printing rate when illegal packet
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

For a next patch, include the target branch: [PATCH net-next v2]

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
> Signed-off-by: Lei Chen <lei.chen@smartx.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
> 
> ---
> Changes from v1:
> https://lore.kernel.org/all/20240409062407.1952728-1-lei.chen@smartx.com/
>  1. Use net_ratelimit instead of raw __ratelimit.
>  2. Use netdev_err instead of pr_err to print more info abort net dev.
>  3. Adjust git commit message to make git am happy.
> 
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
> 
> base-commit: fec50db7033ea478773b159e0e2efb135270e3b7
> prerequisite-patch-id: 8952e320c0272899e153c953db09446879ed0d87
> prerequisite-patch-id: 2f1e3234a4ac0bf421df2061505612538f128672

Where does this footer come from? Should not be present.

> -- 
> 2.44.0
> 



