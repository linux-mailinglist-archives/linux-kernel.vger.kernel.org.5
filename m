Return-Path: <linux-kernel+bounces-139849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B218A0866
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A98B282557
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FC213CABF;
	Thu, 11 Apr 2024 06:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hdisWQP0"
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACA913CAAC;
	Thu, 11 Apr 2024 06:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712816621; cv=none; b=k3DvflMovpfb3hTiMgYvK/Gxzn/EZ0RkrqM4bT2n69W2QgIJ9HlVrHmraKg9feN2uqjSMOQma9I1B/oYEXqD0PSHsPataYIQ/cgy0VSC5jFd4CMxWDfiuJWfa7g/C6fLfGvfmBaWJXRnlyxsQMwmRd1uOt4mSuA5jvviHvG9mXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712816621; c=relaxed/simple;
	bh=PI/yoly0ja/wD+mrJaF2beuTcjYkBhuye/nuL5dosq0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=hpbX3mwbh9DQdT2AtHf8WgVuDVZib15lclEsT7B5Bt3ru4B+nmqwy5kVcCXk4x+xOaunTiMTTwwyhpxfcV6/EVhrTHBcG/0yLRAs9Q4Vtd4h30NV8PmDjKtXb1V3yn+zPpyRvJuqgspSf3s7+efOlTP/IGa2xYdCVMhpQ/H6iH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=fail (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hdisWQP0 reason="signature verification failed"; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-5ce6b5e3c4eso4319853a12.2;
        Wed, 10 Apr 2024 23:23:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712816619; x=1713421419;
        h=content-transfer-encoding:list-id:precedence:user-agent
         :content-disposition:mime-version:dkim-signature:dkim-filter
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3FitmIA2UZfLX12w+GgNlpA8LypqXtGt2xvta/9soZ4=;
        b=f1atEv6UClB/rz9d4HGixRsbaO+djrTgeOHXuKIw91qigtl4xDkKJtvQtIDcgnrgaO
         yxPae+qxtqfN+GHEuqw9r0NIuXczRhIJV0CSMHBpYhsdDcyxCAe58fSMIE2l3hLHMbAc
         +ioDtLCE2TKCL2CUjD70YsKz8gn57aXPj97NE/lxO5T5laad6hU+t6dXfUCx9yBNwNSc
         eOfR6pUMkYZAh5wZUK5xV9UJZ7PPjdMbVT99LMRJFoYMw4PZerdRkudiP8SBfNecf9K7
         ym6W8d677VAd1/n10oS0vp2konSoVQuXxTRYuRLFIbq5D0A2vJXJkkbbtkuRy9FvX8P2
         lRqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/YKfWfxw+Y6grFqAJ6oNjghiXcnFoG7ECiJStPcez/AmJG3C2xAWtnmsxIaukzS0JCJm4CKTmSdrmYLbdcBB3xS31TxnxUZ2E2XjPiquncdnL1FGAb2LMasNc5UKwawxViRQ0
X-Gm-Message-State: AOJu0YwNWlwtS4/pUKSKjFWhrvvDgmV1gIPb4kq3NrC4P2q12wFsuOy7
	cLXrpo0RDlFtkdy9yYGP0LTf96LRWtVsF/zAMqEgtj2n953X9ukr
X-Google-Smtp-Source: AGHT+IE2eVIH19guaxz2Hz8Fmdd9CEks2//rtuIXdj1sjEU2s+j0olymAQfdw69z/Mjvv5vn3Z9xsg==
X-Received: by 2002:a05:6a21:8805:b0:1a3:648e:dacf with SMTP id ta5-20020a056a21880500b001a3648edacfmr5878496pzc.35.1712816618691;
        Wed, 10 Apr 2024 23:23:38 -0700 (PDT)
Received: from localhost.localdomain ([240e:604:203:6020:615f:9a36:c815:b2d5])
        by smtp.gmail.com with ESMTPSA id z13-20020a170903018d00b001e22860c32asm525758plg.143.2024.04.10.23.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 23:23:38 -0700 (PDT)
From: dracoding <dracodingfly@gmail.com>
To: eric.dumazet@gmail.com
Cc: edumazet@google.com,
	herbert@gondor.apana.org.au,
	jpiotrowski@linux.microsoft.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	seh@panix.com
Subject: Re: kernel BUG at net/core/skbuff.c:4219
Date: Thu, 11 Apr 2024 14:23:21 +0800
Message-Id: <20221021100022.GA31916@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <194f6b02-8ee7-b5d7-58f3-6a83b5ff275d@gmail.com>
References: <20221011165611.GA8735@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net> <194f6b02-8ee7-b5d7-58f3-6a83b5ff275d@gmail.com>
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18]) by smtp.lore.kernel.org (Postfix) with ESMTP id 01ADEC433FE for <netdev@archiver.kernel.org>; Fri, 21 Oct 2022 10:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id S230090AbiJUKAZ (ORCPT <rfc822;netdev@archiver.kernel.org>); Fri, 21 Oct 2022 06:00:25 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182]) by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0D35108243; Fri, 21 Oct 2022 03:00:22 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1112) id 8718020FEB47; Fri, 21 Oct 2022 03:00:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8718020FEB47
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com; s=default; t=1666346422; bh=cYIKrJC5k/BBGSDjkeleD8TAE2cOUtwAK2AhJ6I3N70=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From; b=hdisWQP0XbRm7V//OZw98Klj2Eptp2S5qfDXKyYQnxfJI5B8/vRPoF9cO8Hfj+f87 b3mxQXv2+IFnljFKLraeHSY7JBrEaJoF5pzCGPtFa0Urct+UD6tp3RbcwqnJmeQZK+ szLD6Gn/ErNJVla2zTQVr2cJfGQFx5VsM4DhYrZw=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
Content-Transfer-Encoding: 8bit

From: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>

> On Tue, Oct 11, 2022 at 10:57:05AM -0700, Eric Dumazet wrote:
> > 
> > On 10/11/22 09:56, Jeremi Piotrowski wrote:
> > >Hi,
> > >
> > >One of our Flatcar users has been hitting the kernel BUG in the subject line
> > >for the past year (https://github.com/flatcar/Flatcar/issues/378). This was
> > >first reported when on 5.10.25, but has been happening across kernel updates,
> > >most recently with 5.15.63. The nodes where this happens are AWS EC2 instances,
> > >using ENA and calico networking in eBPF mode with VXLAN encapsulation. When
> > >GRO/GSO is enabled, the host hits this bug and prints the following stacktrace:
> > 
> > 
> > I suspect eBPF code lowers gso_size ?
> > 
> > gso stack is not able to arbitrarily segment a GRO packet after
> > gso_size being changed.
> > 
> > 
> 
> This was a good hint, see Tomas' response for some more observations.
> 
> This appears to still be happening with Calico v3.23 which started passing
> BPF_F_ADJ_ROOM_FIXED_GSO to bpf_skb_adjust_room() on the decap (rx) path.
> BPF_F_ADJ_ROOM_FIXED_GSO is not passed on the encap (tx) path. It is enough to
> disable GRO to stop the BUG from being hit though, so there must be more going
> on here ? (since the rx path does not change gso_size any longer).
>

Hi,

I encountered a similar error. The calico version is v3.24.5.
It was crash at BUG_ON(skb_headlen(list_skb) > len) with the following stacktrace.
But i don't konw how to reproduce it.

    [exception RIP: skb_segment+3016]
    RIP: ffffffffb97df2a8  RSP: ffffa3f2cce08728  RFLAGS: 00010293
    RAX: 000000000000007d  RBX: 00000000fffff7b3  RCX: 0000000000000011
    RDX: 0000000000000000  RSI: ffff895ea32c76c0  RDI: 00000000000008c1
    RBP: ffffa3f2cce087f8   R8: 000000000000088f   R9: 0000000000000011
    R10: 000000000000090c  R11: ffff895e47e68000  R12: ffff895eb2022f00
    R13: 000000000000004b  R14: ffff895ecdaf2000  R15: ffff895eb2023f00
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #9 [ffffa3f2cce08720] skb_segment at ffffffffb97ded63
#10 [ffffa3f2cce08800] tcp_gso_segment at ffffffffb98d0320
#11 [ffffa3f2cce08860] tcp4_gso_segment at ffffffffb98d07a3
#12 [ffffa3f2cce08880] inet_gso_segment at ffffffffb98e6de0
#13 [ffffa3f2cce088e0] skb_mac_gso_segment at ffffffffb97f3741
#14 [ffffa3f2cce08918] skb_udp_tunnel_segment at ffffffffb98daa59
#15 [ffffa3f2cce08980] udp4_ufo_fragment at ffffffffb98db471
#16 [ffffa3f2cce089b0] inet_gso_segment at ffffffffb98e6de0
#17 [ffffa3f2cce08a10] skb_mac_gso_segment at ffffffffb97f3741
#18 [ffffa3f2cce08a48] __skb_gso_segment at ffffffffb97f388e
#19 [ffffa3f2cce08a78] validate_xmit_skb at ffffffffb97f3d6e
#20 [ffffa3f2cce08ab8] __dev_queue_xmit at ffffffffb97f4614
#21 [ffffa3f2cce08b50] dev_queue_xmit at ffffffffb97f5030
#22 [ffffa3f2cce08b60] __bpf_redirect at ffffffffb98199a8
#23 [ffffa3f2cce08b88] skb_do_redirect at ffffffffb98205cd
#24 [ffffa3f2cce08bb8] __netif_receive_skb_core at ffffffffb97f6585
#25 [ffffa3f2cce08c68] __netif_receive_skb_list_core at ffffffffb97f6c0a
#26 [ffffa3f2cce08ce8] netif_receive_skb_list_internal at ffffffffb97f6f6a
#27 [ffffa3f2cce08d60] gro_normal_list at ffffffffb97f717e
#28 [ffffa3f2cce08d80] gro_normal_one at ffffffffb97f721c
#29 [ffffa3f2cce08db8] napi_gro_complete at ffffffffb97f72ac
#30 [ffffa3f2cce08de0] napi_gro_flush at ffffffffb97f73c1
#31 [ffffa3f2cce08e30] napi_complete_done at ffffffffb97f7d1e
#32 [ffffa3f2cce08e60] ice_napi_poll at ffffffffc0477dd6 [ice]
#33 [ffffa3f2cce08ec0] __napi_poll at ffffffffb97f823e
#34 [ffffa3f2cce08ef0] net_rx_action at ffffffffb97f86f1
#35 [ffffa3f2cce08f70] __softirqentry_text_start at ffffffffb9e000dd
#36 [ffffa3f2cce08fd8] irq_exit_rcu at ffffffffb9096074
#37 [ffffa3f2cce08ff0] common_interrupt at ffffffffb9a3272a

the gso_size is 75 which may subtract 50(the vxlan head length) by bpf_skb_adjust_room?。
the frag_list has one element which head_frag is 1. the skb_shared_info struct is as following.

struct skb_shared_info {
    nr_frags = 17 '\021', 
    gso_size = 75, 
    gso_segs = 0, 
    frag_list = 0xffff895eb2022f00, 
    gso_type = 1035, 
    destructor_arg = 0x2d656c6261747372, 
    frags = {{
        bv_page = 0xfffff80e86d4d180, 
        bv_len = 125, 
        bv_offset = 2306
      },
    ....
    }
}

If anyone has any suggestions excepth disabling GRO/GSO. The BPF_F_ADJ_ROOM_FIXED_GSO flag 
can be enabled on the encap path? I‘d love to provide more information if you need.

fred

