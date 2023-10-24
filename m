Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF9D7D4A97
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbjJXIl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjJXIl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:41:57 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9622120
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 01:41:51 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9c53e8b7cf4so594626766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 01:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1698136910; x=1698741710; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=C8xvYkCmZq71kHKyYg3Cr3ZgYB4uayEvhz+bKkQ5m20=;
        b=QoenimhWbnbJuWoW227n0zYz1P32PpFNKaOHSACsEgorJge2e5CLrNMsUDWicWxWtG
         B+7vY0fmztDbPI4TRts/0Fh+TNAnhVym7KEZOjJA38d+cKMaQHEXw6JdC+0BOmMe56tB
         Pz9K0pRnnwvpQb9x5UFAWXO8tIOS7tGQLcZHkevz43YxGaTAhykF0l9G/XmaoGQR47kf
         jghG7dMpEPhUD7HtfJUFeUWgOBW1rqHtx/BEwI8VlyBLc9Z1TegltPaXGJFHobRAoJEW
         QOBFotJ7lsIJOWtwUp1kiIfEC/wifUiDeOTTgcZrEiWFNXlWHOsOGtABAs+82u7dcfB9
         qqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698136910; x=1698741710;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8xvYkCmZq71kHKyYg3Cr3ZgYB4uayEvhz+bKkQ5m20=;
        b=DtKgGk1iC+gC75stYyqwaNmGNvee7W5RNNkm8mY1DwDc6a2fzDRtrkoHMbFEJnaaWu
         /u8IjSm2TX+xA7edyasQsa5qW01CyQhvUPI7DXD0QI0Fi6eT1MqOkijYWSvjUIXB1gUf
         isVStIXt9lWNa5+S9skqpkG6/cIIHb055NCyFyAAGAndH9Acxc3mca8p9tbs8iluQYMM
         mhtL6JdMPdb88QjQ6JgmQdtkAcAl/hc/xtS/41AshUtj7PgLT7iQ+chdLKUQ8+oYXzhs
         3BIKC1e9lrjgN0rSK1ShrK/9f0bS1kValCeUrZNYTmDPGZ3Rw3ocZGsUdsYTREeXa7Rn
         wudw==
X-Gm-Message-State: AOJu0YyYbBTEQPiwTjZUzVdMol0NDi4jZ/hhdVMddUnqE1z3E/W4Ocj/
        wIJdGxsSWUrNi3ky7CtDcTeOSQ==
X-Google-Smtp-Source: AGHT+IHtw+iPFosKDroEJ1nbhV/VjCXM79Rhv9j65atjsILQTwGUacYmMeR1TiFi+DRbxlo0l8nW+A==
X-Received: by 2002:a17:907:320a:b0:9ad:e4e1:1476 with SMTP id xg10-20020a170907320a00b009ade4e11476mr7191910ejb.77.1698136910181;
        Tue, 24 Oct 2023 01:41:50 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:e9])
        by smtp.gmail.com with ESMTPSA id t7-20020a1709066bc700b009b9f87b34b6sm7864739ejs.189.2023.10.24.01.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 01:41:49 -0700 (PDT)
References: <20231019101625.412936-1-jakub@cloudflare.com>
 <1697720122.49851-2-xuanzhuo@linux.alibaba.com>
 <87il6x2rj6.fsf@cloudflare.com>
 <1698114697.434748-1-xuanzhuo@linux.alibaba.com>
User-agent: mu4e 1.6.10; emacs 28.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Caleb Raitto <caraitto@google.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 1/2] virtio_pci: Don't make an extra copy of cpu
 affinity mask
Date:   Tue, 24 Oct 2023 10:17:19 +0200
In-reply-to: <1698114697.434748-1-xuanzhuo@linux.alibaba.com>
Message-ID: <87edhk2z03.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 10:31 AM +08, Xuan Zhuo wrote:
> On Mon, 23 Oct 2023 18:52:45 +0200, Jakub Sitnicki <jakub@cloudflare.com> wrote:
>> On Thu, Oct 19, 2023 at 08:55 PM +08, Xuan Zhuo wrote:
>> > On Thu, 19 Oct 2023 12:16:24 +0200, Jakub Sitnicki <jakub@cloudflare.com> wrote:
>> >> Since commit 19e226e8cc5d ("virtio: Make vp_set_vq_affinity() take a
>> >> mask.") it is actually not needed to have a local copy of the cpu mask.
>> >
>> >
>> > Could you give more info to prove this?
>
>
> Actually, my question is that can we pass a val on the stack(or temp value) to
> the irq_set_affinity_hint()?
>
> Such as the virtio-net uses zalloc_cpumask_var to alloc a cpu_mask, and
> that will be released.
>
>
>
> 	int __irq_apply_affinity_hint(unsigned int irq, const struct cpumask *m,
> 				      bool setaffinity)
> 	{
> 		unsigned long flags;
> 		struct irq_desc *desc = irq_get_desc_lock(irq, &flags, IRQ_GET_DESC_CHECK_GLOBAL);
>
> 		if (!desc)
> 			return -EINVAL;
> ->		desc->affinity_hint = m;
> 		irq_put_desc_unlock(desc, flags);
> 		if (m && setaffinity)
> 			__irq_set_affinity(irq, m, false);
> 		return 0;
> 	}
> 	EXPORT_SYMBOL_GPL(__irq_apply_affinity_hint);
>
> The above code directly refers the mask pointer. If the mask is a temp value, I
> think that is a bug.

You are completely right. irq_set_affinity_hint stores the mask pointer.
irq_affinity_hint_proc_show later dereferences it when user reads out
/proc/irq/*/affinity_hint.

I have failed to notice that. That's why we need cpumask_copy to stay.

My patch is buggy. Please disregard.

I will send a v2 to only migrate from deprecated irq_set_affinity_hint.

> And I notice that many places directly pass the temp value to this API.
> And I am a little confused. ^_^ Or I missed something.

There seem two be two gropus of callers:

1. Those that use get_cpu_mask/cpumask_of/cpumask_of_node to produce a
   cpumask pointer which is a preallocated constant.

   $ weggli 'irq_set_affinity_hint(_, $func(_));' ~/src/linux

2. Those that pass a pointer to memory somewhere.

   $ weggli 'irq_set_affinity_hint(_, $mask);' ~/src/linux

(weggli tool can be found at https://github.com/weggli-rs/weggli)

I've looked over the callers from group #2 but I couldn't find any
passing a pointer memory on stack :-)

Thanks for pointing this out.

[...]
