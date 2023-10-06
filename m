Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1CE7BB1FA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 09:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjJFHJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 03:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjJFHJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 03:09:44 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8E2F2;
        Fri,  6 Oct 2023 00:09:42 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99de884ad25so320935666b.3;
        Fri, 06 Oct 2023 00:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696576181; x=1697180981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=V5ladE5tkTaw6kg06jFlVzHqN5oLjCVd34OCxyKLMKo=;
        b=Wkfpe55GrPAvLwktd4peSsGxo8mvBHJBkOxUeMIMg6OWyLIqp7l+vIhpO8iBcMoP1K
         1OO5Ty+22T9tU9mDDFSi0XaB+oaIdaeLSM7rRj2wGHmAn520zEAZmcJc2dyephNj+JMY
         A12M0ZhJKfE/H4EXOKZw5Qiez3sx10z6DZgXIoi2h+HItuEMkifC5KOuxuHp9mkztsJd
         nNbc1ZPMFClPWrNWnOfJHG0d0rQ58yC3tjM/IC7M/Tpxd4AvjMRLlyDwrzV7QK8MRYbx
         xeCsvwashLlXpiGQjrAQTxqyrDft8y1ebveN2EaeEqdmFt7EtCrBJfAVEOl9Vl/I0ctb
         STwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696576181; x=1697180981;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5ladE5tkTaw6kg06jFlVzHqN5oLjCVd34OCxyKLMKo=;
        b=UQxF0lsFqns816LKH7CWRuez/eTQ8CS7Y4b4xfRkSw6VGvqqm+HWQl7hNu+7BTLFBW
         w92FHB11AQa+NVBic0DJ6uxi6k2+LOjXEQ0p3LDsCMTyDMSjKLnk26dlXmUj8E8XpGwV
         S+wOMbBHCRKwjolf40ocjb04o1pwZLKoVK8ARCJtZj1tZzSKN76nTRh3jhshL+bYUUMj
         2OPUM7/d2ytLKmbLp5SlZ7Th3dEnR6bjOB700AtJVnLaMyLD8j1vKaUjr0BbQqfo2hPd
         ZWTrAgrzBDRWY98Kok1pg9i2qPnzbpLCAPGlXPUKEEeU6dF1MK4s0bADdQbxTc6/5Jxg
         W52g==
X-Gm-Message-State: AOJu0YzSVt04aBn82zZQNVWkg5eUYamGk9OwivN2evdWd8rPM2Cx8CVJ
        kdz8jE7OQn/5TFyi4q/zsWQdZ25avbLLhuPk
X-Google-Smtp-Source: AGHT+IEhkKlWhY9En4mCZRCfskhgcjCs7rAtjGq2BhW+LxJgq8JJ78L9ycc/ObnygNJjxQHecLZ7+A==
X-Received: by 2002:a05:6512:282b:b0:505:7371:ec83 with SMTP id cf43-20020a056512282b00b005057371ec83mr7661985lfb.48.1696576169648;
        Fri, 06 Oct 2023 00:09:29 -0700 (PDT)
Received: from akanner-r14. ([77.222.24.57])
        by smtp.gmail.com with ESMTPSA id r26-20020ac25a5a000000b00502c6dc612fsm184811lfn.219.2023.10.06.00.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 00:09:28 -0700 (PDT)
Message-ID: <651fb2a8.c20a0220.8d6c3.0fd9@mx.google.com>
X-Google-Original-Message-ID: <ZR+yfWLkv4rrr0i6@akanner-r14.>
Date:   Fri, 6 Oct 2023 10:09:20 +0300
From:   Andrew Kanner <andrew.kanner@gmail.com>
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+fae676d3cf469331fc89@syzkaller.appspotmail.com,
        syzbot+b132693e925cbbd89e26@syzkaller.appspotmail.com,
        bjorn@kernel.org, magnus.karlsson@intel.com,
        maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, aleksander.lobakin@intel.com,
        xuanzhuo@linux.alibaba.com, ast@kernel.org, hawk@kernel.org,
        john.fastabend@gmail.com, daniel@iogearbox.net
Subject: Re: [PATCH bpf v3] net/xdp: fix zero-size allocation warning in
 xskq_create()
References: <20231005193548.515-1-andrew.kanner@gmail.com>
 <7aa47549-5a95-22d7-1d03-ffdd251cec6d@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7aa47549-5a95-22d7-1d03-ffdd251cec6d@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 06:00:46PM -0700, Martin KaFai Lau wrote:
[...]
> > diff --git a/net/xdp/xsk_queue.c b/net/xdp/xsk_queue.c
> > index f8905400ee07..c7e8bbb12752 100644
> > --- a/net/xdp/xsk_queue.c
> > +++ b/net/xdp/xsk_queue.c
> > @@ -34,6 +34,11 @@ struct xsk_queue *xskq_create(u32 nentries, bool umem_queue)
> >   	q->ring_mask = nentries - 1;
> >   	size = xskq_get_ring_size(q, umem_queue);
> > +	if (unlikely(size == SIZE_MAX)) {
> 
> What if "size" is SIZE_MAX-1? Would it still overflow the PAGE_ALIGN below?
> 
> > +		kfree(q);
> > +		return NULL;
> > +	}
> > +
> >   	size = PAGE_ALIGN(size);
> >   	q->ring = vmalloc_user(size);
> 

I asked myself the same question before v1. E.g. thinking about the
check: (size > SIZE_MAX - PAGE_SIZE + 1)

But xskq_create() is called after the check for
!is_power_of_2(entries) in xsk_init_queue(). So I tried the same
reproducer and divided the (nentries) value by 2 in a loop - it hits
either SIZE_MAX case or the normal cases without overflow (sometimes
throwing vmalloc error complaining about size which exceed total pages
in my arm setup).

So I can't see a way size will be SIZE_MAX-1, etc. Correct me if I'm
wrong, please.

PS: In the output below the first 2 values of (nentries) hit SIZE_MAX
case, the rest hit the normal case, vmalloc_user() is complaining
about 1 allocation:

0x20000000
0x10000000
0x8000000
[   41.759195][ T2807] pre PAGE_ALIGN size = 2147483968 (0x80000140), PAGE_SIZE = 4096 (0x1000)
[   41.759621][ T2807] repro-iter: vmalloc error: size 2147487744, exceeds total pages, mode:0xdc0(GFP_KERNEL|__GFP_ZERO), nodemask=(null),cpuset=/,mems_allowed=0
[...]
0x4000000
0x2000000
0x1000000
0x800000
0x400000
0x200000
0x100000
0x80000
0x40000
0x20000
0x10000
0x8000
0x4000
0x2000
0x1000
0x800
0x400
0x200
0x100
0x80
0x40
0x20
0x10
0x8
0x4
0x2

-- 
Andrew Kanner
