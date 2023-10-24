Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E917D4F25
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 13:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbjJXLpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 07:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbjJXLpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 07:45:18 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DFE10C0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 04:45:14 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9be3b66f254so616452666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 04:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1698147913; x=1698752713; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=FCKEM37FEKxAp8yEqlco8GPnQf1xX5ZBdasFIuffA9g=;
        b=T0B4vtnyjBrbAqPGvbHer4VssNmEPjr4cxuplh3mpbK/1hvo18VuDq+vLVHT0jvpOJ
         eJQFwNwpcxCv3j8Iib6q8O+w1/fYbQY73rq5kQwTJYRfK5OBEUfxqXAKr7ZJellqprZb
         tdpMdKNMQWK+7Y682YV6H8WDc9mV9V0U/Z1vD+C/90o7XUDT+BwpknJhzjZcOvZt/4oa
         UoTust5dsoY0Pgdxhp4QSMoOtqwB41RMx0xOiHMQoQkI0vw6isyNdD6t3+W4JtoDSe/n
         C1WARrBOhH5XE0O1VX1XlwMCTWG70YID4tMnlTSXxpMXqaYk/THvNQCSbL86vW2VbqWy
         GtJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698147913; x=1698752713;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCKEM37FEKxAp8yEqlco8GPnQf1xX5ZBdasFIuffA9g=;
        b=P4ISH1SOgfAT0KdZbyvw6Kvq5gTPX8lzqO/1BB0B39/0P0J58BdKAkjt1atHELW3lZ
         LiN4AlMvmRSJD/kAIZc87CSMNNY0/FbHaRbAw1lq8WGXw4SGgNn28bZJfdVk1ZrqnLDH
         jaV0ux7Y5Eg6Q9V+b6BzH4MPtjK2I78S7eud74Z2EEh0jEWpKzpQbU4hL6uN88javCUX
         uwZ/wkdeOa7Tz5biq29l08xwVYvmovHV20AFjJx57dX8okBc+3fNtzG6pRfz/HKICPZq
         qgLwoSrAn3k6q0YX3rQcZrau+eumS01iwZjv7LJ4TGGwH4m89YIByUh8jE+dusfWKLn3
         encg==
X-Gm-Message-State: AOJu0YyWcGsqVE6fcyfSotJtcwi52e5Ry987lVzTKJlEObX5kbglhlND
        dMIbla02yGcrgeoBdjk8TMULMg==
X-Google-Smtp-Source: AGHT+IFUueyAdpQ6doppKxn1Ji8Dk8R6RwdnkhbK2rxReEs2hdalFEjCHuZM5oO7Y3ivYfpkSrV6qg==
X-Received: by 2002:a17:907:841:b0:9be:16ba:19ab with SMTP id ww1-20020a170907084100b009be16ba19abmr8865005ejb.29.1698147913081;
        Tue, 24 Oct 2023 04:45:13 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:e9])
        by smtp.gmail.com with ESMTPSA id d13-20020a1709064c4d00b009a5f1d15642sm8070595ejw.158.2023.10.24.04.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 04:45:12 -0700 (PDT)
References: <20231019101625.412936-1-jakub@cloudflare.com>
 <1697720122.49851-2-xuanzhuo@linux.alibaba.com>
 <87il6x2rj6.fsf@cloudflare.com>
 <1698114697.434748-1-xuanzhuo@linux.alibaba.com>
 <87edhk2z03.fsf@cloudflare.com>
 <1698144808.8577316-1-xuanzhuo@linux.alibaba.com>
User-agent: mu4e 1.6.10; emacs 28.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Caleb Raitto <caraitto@google.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 1/2] virtio_pci: Don't make an extra copy of cpu
 affinity mask
Date:   Tue, 24 Oct 2023 13:26:49 +0200
In-reply-to: <1698144808.8577316-1-xuanzhuo@linux.alibaba.com>
Message-ID: <87a5s82qig.fsf@cloudflare.com>
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

On Tue, Oct 24, 2023 at 06:53 PM +08, Xuan Zhuo wrote:
> On Tue, 24 Oct 2023 10:17:19 +0200, Jakub Sitnicki <jakub@cloudflare.com> wrote:
>> On Tue, Oct 24, 2023 at 10:31 AM +08, Xuan Zhuo wrote:
>> > On Mon, 23 Oct 2023 18:52:45 +0200, Jakub Sitnicki <jakub@cloudflare.com> wrote:
>> >> On Thu, Oct 19, 2023 at 08:55 PM +08, Xuan Zhuo wrote:
>> >> > On Thu, 19 Oct 2023 12:16:24 +0200, Jakub Sitnicki <jakub@cloudflare.com> wrote:
>> >> >> Since commit 19e226e8cc5d ("virtio: Make vp_set_vq_affinity() take a
>> >> >> mask.") it is actually not needed to have a local copy of the cpu mask.
>> >> >
>> >> >
>> >> > Could you give more info to prove this?
>> >
>> >
>> > Actually, my question is that can we pass a val on the stack(or temp value) to
>> > the irq_set_affinity_hint()?
>> >
>> > Such as the virtio-net uses zalloc_cpumask_var to alloc a cpu_mask, and
>> > that will be released.
>> >
>> >
>> >
>> > 	int __irq_apply_affinity_hint(unsigned int irq, const struct cpumask *m,
>> > 				      bool setaffinity)
>> > 	{
>> > 		unsigned long flags;
>> > 		struct irq_desc *desc = irq_get_desc_lock(irq, &flags, IRQ_GET_DESC_CHECK_GLOBAL);
>> >
>> > 		if (!desc)
>> > 			return -EINVAL;
>> > ->		desc->affinity_hint = m;
>> > 		irq_put_desc_unlock(desc, flags);
>> > 		if (m && setaffinity)
>> > 			__irq_set_affinity(irq, m, false);
>> > 		return 0;
>> > 	}
>> > 	EXPORT_SYMBOL_GPL(__irq_apply_affinity_hint);
>> >
>> > The above code directly refers the mask pointer. If the mask is a temp value, I
>> > think that is a bug.
>>
>> You are completely right. irq_set_affinity_hint stores the mask pointer.
>> irq_affinity_hint_proc_show later dereferences it when user reads out
>> /proc/irq/*/affinity_hint.
>>
>> I have failed to notice that. That's why we need cpumask_copy to stay.
>>
>> My patch is buggy. Please disregard.
>>
>> I will send a v2 to only migrate from deprecated irq_set_affinity_hint.
>>
>> > And I notice that many places directly pass the temp value to this API.
>> > And I am a little confused. ^_^ Or I missed something.
>>
>> There seem two be two gropus of callers:
>>
>> 1. Those that use get_cpu_mask/cpumask_of/cpumask_of_node to produce a
>>    cpumask pointer which is a preallocated constant.
>>
>>    $ weggli 'irq_set_affinity_hint(_, $func(_));' ~/src/linux
>>
>> 2. Those that pass a pointer to memory somewhere.
>>
>>    $ weggli 'irq_set_affinity_hint(_, $mask);' ~/src/linux
>>
>> (weggli tool can be found at https://github.com/weggli-rs/weggli)
>>
>> I've looked over the callers from group #2 but I couldn't find any
>> passing a pointer memory on stack :-)
>
> Pls check stmmac_request_irq_multi_msi()

Good catch. That one looks buggy.

I should also checked for callers that take an address of a var/field:

  $ weggli 'irq_set_affinity_hint(_, &$mask);' ~/src/linux
