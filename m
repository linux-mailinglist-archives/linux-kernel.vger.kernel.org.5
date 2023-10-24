Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A391B7D4F5A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 14:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbjJXMCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 08:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbjJXMCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 08:02:45 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F54D7F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 05:02:43 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9ba1eb73c27so690213066b.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 05:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1698148961; x=1698753761; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=vUX3/J/qlNzLrWL3mFobCRPHJJns33eg8PeRo1zgZcc=;
        b=KZP3jyle+p4sPgclkPBwzH5rD4Z/ad5EV9AlvXoP6wGaeCVqon9viihASp2ALS2cN2
         tBUtFnPQ+Xez8qiwH3KU0tMqB3DUN8oXG2d/9ltyKKQSjWwFAGVXYMXxGrhSJKcXf/zE
         2jsyzJClhvCk9PbW61FK2+CKMrCp6AbtSNPqQKepkfly7zzvkbPVSAvUPFzaxQoiwMf3
         fdj/XWZclnl81wQ4uvASQir5EMiNyqssu52GpNNSjOX/0H+Run4rX182l8UM4HeHmIyO
         tIAUdZ3GRIR+9+zh435BQHXDIobqPtm47e2fzCtGE1Z/7el4CB73vqBeAeSZ3YPAOTIs
         Tq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698148961; x=1698753761;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUX3/J/qlNzLrWL3mFobCRPHJJns33eg8PeRo1zgZcc=;
        b=XlKXFFNcDImq2X3cPuIW/7p7fmd7MxHEDHOP2m4A7R3wD2AiYrT+ldZHuMea9xUvih
         Q1wjbSFVqOXbLA0tJgLswgccZ6Dad81weFZLrDo4HRRJZS70gQVOw/l0NyR98+QkIQaK
         4ENXM/MAHDAEteQkNb4BD97E4wjXvNLfCRER8DPXqH7i2yrpIUgUG8x+tBFA4l7IqMBX
         sY2fizHBJMwmJKrCQr53F56akqHp9FZsD53H2SCX5jG4IbNS2ye+1Oskk8LJxn0vNTmc
         7KDW3RWc/xJdPlSF6S7rdDSRIfuxP/LpXPcQ2LG64hopdJGBjxYrfvO/3TCxOvLq31nu
         EFRQ==
X-Gm-Message-State: AOJu0YxAhRl1wlzA9wBtT6WAk5lN7CiUdCrRDy5OdJeyg/eDZaIMag+D
        hbI0e4YbCeHjygAy8OyHBHDzKDno1N1nUDSM8Pqnpg==
X-Google-Smtp-Source: AGHT+IHQlQp6SYqGcwivXMQJdIDTmbhdyz84sLTrVeXzyLB/BwkNn6E/Xytz51NfRzcDQJk4SzIHUA==
X-Received: by 2002:a17:906:da84:b0:9a5:d657:47e1 with SMTP id xh4-20020a170906da8400b009a5d65747e1mr9250857ejb.43.1698148961496;
        Tue, 24 Oct 2023 05:02:41 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:e9])
        by smtp.gmail.com with ESMTPSA id e6-20020a170906080600b009c70b392051sm8195883ejd.100.2023.10.24.05.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 05:02:40 -0700 (PDT)
References: <20231019101625.412936-1-jakub@cloudflare.com>
 <1697720122.49851-2-xuanzhuo@linux.alibaba.com>
 <87il6x2rj6.fsf@cloudflare.com>
 <1698114697.434748-1-xuanzhuo@linux.alibaba.com>
 <87edhk2z03.fsf@cloudflare.com>
 <1698144808.8577316-1-xuanzhuo@linux.alibaba.com>
 <87a5s82qig.fsf@cloudflare.com>
 <1698147983.0338666-1-xuanzhuo@linux.alibaba.com>
User-agent: mu4e 1.6.10; emacs 28.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Caleb Raitto <caraitto@google.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 1/2] virtio_pci: Don't make an extra copy of cpu
 affinity mask
Date:   Tue, 24 Oct 2023 13:55:02 +0200
In-reply-to: <1698147983.0338666-1-xuanzhuo@linux.alibaba.com>
Message-ID: <875y2w2ppc.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 07:46 PM +08, Xuan Zhuo wrote:
> On Tue, 24 Oct 2023 13:26:49 +0200, Jakub Sitnicki <jakub@cloudflare.com> wrote:
>> On Tue, Oct 24, 2023 at 06:53 PM +08, Xuan Zhuo wrote:
>> > On Tue, 24 Oct 2023 10:17:19 +0200, Jakub Sitnicki <jakub@cloudflare.com> wrote:
>> >> On Tue, Oct 24, 2023 at 10:31 AM +08, Xuan Zhuo wrote:
>> >> > On Mon, 23 Oct 2023 18:52:45 +0200, Jakub Sitnicki <jakub@cloudflare.com> wrote:
>> >> >> On Thu, Oct 19, 2023 at 08:55 PM +08, Xuan Zhuo wrote:
>> >> >> > On Thu, 19 Oct 2023 12:16:24 +0200, Jakub Sitnicki <jakub@cloudflare.com> wrote:
>> >> >> >> Since commit 19e226e8cc5d ("virtio: Make vp_set_vq_affinity() take a
>> >> >> >> mask.") it is actually not needed to have a local copy of the cpu mask.
>> >> >> >
>> >> >> >
>> >> >> > Could you give more info to prove this?
>> >> >
>> >> >
>> >> > Actually, my question is that can we pass a val on the stack(or temp value) to
>> >> > the irq_set_affinity_hint()?
>> >> >
>> >> > Such as the virtio-net uses zalloc_cpumask_var to alloc a cpu_mask, and
>> >> > that will be released.
>> >> >
>> >> >
>> >> >
>> >> > 	int __irq_apply_affinity_hint(unsigned int irq, const struct cpumask *m,
>> >> > 				      bool setaffinity)
>> >> > 	{
>> >> > 		unsigned long flags;
>> >> > 		struct irq_desc *desc = irq_get_desc_lock(irq, &flags, IRQ_GET_DESC_CHECK_GLOBAL);
>> >> >
>> >> > 		if (!desc)
>> >> > 			return -EINVAL;
>> >> > ->		desc->affinity_hint = m;
>> >> > 		irq_put_desc_unlock(desc, flags);
>> >> > 		if (m && setaffinity)
>> >> > 			__irq_set_affinity(irq, m, false);
>> >> > 		return 0;
>> >> > 	}
>> >> > 	EXPORT_SYMBOL_GPL(__irq_apply_affinity_hint);
>> >> >
>> >> > The above code directly refers the mask pointer. If the mask is a temp value, I
>> >> > think that is a bug.
>> >>
>> >> You are completely right. irq_set_affinity_hint stores the mask pointer.
>> >> irq_affinity_hint_proc_show later dereferences it when user reads out
>> >> /proc/irq/*/affinity_hint.
>> >>
>> >> I have failed to notice that. That's why we need cpumask_copy to stay.
>> >>
>> >> My patch is buggy. Please disregard.
>> >>
>> >> I will send a v2 to only migrate from deprecated irq_set_affinity_hint.
>> >>
>> >> > And I notice that many places directly pass the temp value to this API.
>> >> > And I am a little confused. ^_^ Or I missed something.
>> >>
>> >> There seem two be two gropus of callers:
>> >>
>> >> 1. Those that use get_cpu_mask/cpumask_of/cpumask_of_node to produce a
>> >>    cpumask pointer which is a preallocated constant.
>> >>
>> >>    $ weggli 'irq_set_affinity_hint(_, $func(_));' ~/src/linux
>> >>
>> >> 2. Those that pass a pointer to memory somewhere.
>> >>
>> >>    $ weggli 'irq_set_affinity_hint(_, $mask);' ~/src/linux
>> >>
>> >> (weggli tool can be found at https://github.com/weggli-rs/weggli)
>> >>
>> >> I've looked over the callers from group #2 but I couldn't find any
>> >> passing a pointer memory on stack :-)
>> >
>> > Pls check stmmac_request_irq_multi_msi()
>>
>> Good catch. That one looks buggy.
>>
>> I should also checked for callers that take an address of a var/field:
>>
>>   $ weggli 'irq_set_affinity_hint(_, &$mask);' ~/src/linux
>
> Do you find more?

No, just the one you pointed out. Unless I missed something.

I ran an improved query. Shows everything but the non-interesting cases:

$ weggli '{
	NOT: irq_set_affinity_hint(_, NULL);
	NOT: irq_set_affinity_hint(_, get_cpu_mask(_));
	NOT: irq_set_affinity_hint(_, cpumask_of(_));
	irq_set_affinity_hint(_, _);
}' ~/src/linux

And repeated it for irq_set_affinity_and_hint and irq_update_affinity.

The calls where it was not obvious at first sight that we're passing a
pointer to some heap memory, turned out to use a temporary variable to
either store address to heap memory or return value from cpumask_of*().

