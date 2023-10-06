Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34B47BC2E6
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 01:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbjJFXYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 19:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbjJFXYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 19:24:17 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B00393;
        Fri,  6 Oct 2023 16:24:16 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-536b39daec1so4647337a12.2;
        Fri, 06 Oct 2023 16:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696634654; x=1697239454; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hPaXNBZLQrXq61kgT1VtVRZp5hOGTGuxGwxK2C9WNE4=;
        b=iVqqtZeRsgB5REbjUpRx2q+IFE4l1xa0KxH/D7yVsLmIeExUcYqVoZIJbmqUoSOh+t
         wWFE0XhgO0ibRpQfaXI0oHyr052p71thwoeSzGjrFVERG/yJcZ2RNrf2d12FgKr5jFOS
         IaK8pndDf45XTEZzUzKjkBMItBpW+nWL1XIWrORYpRO3cKYEaQYCeG8jyhNW+hi9FlLt
         UtZ7HpnIXwiJvqSWXhNFdWQxHbqb8zwClii5gfT+6nhznDN9l+LxeESZ1Qw6dRt9Ygdj
         hryC9dzqa9QAp9iGDM4Uj4qjJ/AKW/OIWXVEqwU02V0WvApBV/ptCszPYijrap6v/eA3
         GFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696634654; x=1697239454;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPaXNBZLQrXq61kgT1VtVRZp5hOGTGuxGwxK2C9WNE4=;
        b=sUxFJrl21lEMhxhUrbyFJazPEo3/52mr6ELDM84ZTxvLXTTS5K+5C38BwzO2vbP1Po
         6x4PKAueO7xmgLK0P3MOhq3f4s6B0i9YukzFfa1SJPqwujZ/Gjsy3ee+z1gXP+J5ztkK
         rNliOuXdX04h0wRXbkzE2CQ8+Gy1s5lWWtRV6XCt3YdH7sgWTA5HusWeIhePUVDayLw1
         EGvt95GIHw8T+kCQUWwXnKym0vd3Ei0gbifFlgCBw2vhMh0B7j1HfIoZXoEeNTq+gxCY
         nmhNvrclZnrsPOWa2geRNk6O3E2EGVq/cNZ3AesAste5Gzqss1xS0Cuzk0H4iL4KvG7x
         EHdA==
X-Gm-Message-State: AOJu0YxBJSHVCuK0I0UL+TNFk7SNm9U/Ksf+WOnfntYNd1BXnJ6DS0ku
        4TZbK4+rnMLMuUmFpkXPg9aAgexbJqmZmg==
X-Google-Smtp-Source: AGHT+IFfto7EAMEg7VApspqL6vAy9RqJg0LXgxG7jOvdtW7oM72tB4A8+dN9tWoFUCe051xP4IEYnA==
X-Received: by 2002:aa7:d492:0:b0:533:39da:6ffb with SMTP id b18-20020aa7d492000000b0053339da6ffbmr8401911edr.14.1696634654420;
        Fri, 06 Oct 2023 16:24:14 -0700 (PDT)
Received: from akanner-r14. ([77.222.24.57])
        by smtp.gmail.com with ESMTPSA id l25-20020aa7c319000000b0053441519ed5sm3152155edq.88.2023.10.06.16.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 16:24:13 -0700 (PDT)
Message-ID: <6520971d.a70a0220.758e3.8cf7@mx.google.com>
X-Google-Original-Message-ID: <ZSCXFdDLDycRAPxQ@akanner-r14.>
Date:   Sat, 7 Oct 2023 02:24:05 +0300
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
 <651fb2a8.c20a0220.8d6c3.0fd9@mx.google.com>
 <57c35480-983d-2056-1d72-f6e555069b83@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57c35480-983d-2056-1d72-f6e555069b83@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 10:37:44AM -0700, Martin KaFai Lau wrote:
[...] 
> > > What if "size" is SIZE_MAX-1? Would it still overflow the PAGE_ALIGN below?
> > > 
> > > > +		kfree(q);
> > > > +		return NULL;
> > > > +	}
> > > > +
> > > >    	size = PAGE_ALIGN(size);
> > > >    	q->ring = vmalloc_user(size);
> > > 
> > 
> > I asked myself the same question before v1. E.g. thinking about the
> > check: (size > SIZE_MAX - PAGE_SIZE + 1)
> > 
> > But xskq_create() is called after the check for
> > !is_power_of_2(entries) in xsk_init_queue(). So I tried the same
> > reproducer and divided the (nentries) value by 2 in a loop - it hits
> > either SIZE_MAX case or the normal cases without overflow (sometimes
> > throwing vmalloc error complaining about size which exceed total pages
> > in my arm setup).
> > 
> > So I can't see a way size will be SIZE_MAX-1, etc. Correct me if I'm
> > wrong, please.
> > 
> > PS: In the output below the first 2 values of (nentries) hit SIZE_MAX
> 
> Thanks for the explanation, so iiuc it means it will overflow the
> struct_size() first because of the is_power_of_2(nentries) requirement?
> Could you help adding some comment to explain? Thanks.
>

The overflow happens because there's no upper limit for nentries
(userspace input). Let me add more context, e.g. from net/xdp/xsk.c:

static int xsk_setsockopt(struct socket *sock, int level, int optname,
                          sockptr_t optval, unsigned int optlen)
{
[...]
                if (copy_from_sockptr(&entries, optval, sizeof(entries)))
                        return -EFAULT;
[...]
                err = xsk_init_queue(entries, q, false);
[...]
}

'entries' is passed to xsk_init_queue() and there're 2 checks: for 0
and is_power_of_2() only, no upper bound check:

static int xsk_init_queue(u32 entries, struct xsk_queue **queue,
                          bool umem_queue)
{
        struct xsk_queue *q;

        if (entries == 0 || *queue || !is_power_of_2(entries))
                return -EINVAL;

        q = xskq_create(entries, umem_queue);
        if (!q)
                return -ENOMEM;
[...]
}

The 'entries' value is next passed to struct_size() in
net/xdp/xsk_queue.c. If it's large enough - SIZE_MAX will be returned.

I'm not sure if some appropriate limit for the size of XDP_RX_RING /
XDP_TX_RING and XDP_UMEM_FILL_RING / XDP_UMEM_COMPLETION_RING rings
should be used. But anyway, vmalloc() will tell if it's not ok with
the requested allocation size.

-- 
Andrew Kanner
