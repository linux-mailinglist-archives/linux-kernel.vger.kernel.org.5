Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DFA80CE13
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 15:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344562AbjLKOQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 09:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344621AbjLKOPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 09:15:51 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4934C1F;
        Mon, 11 Dec 2023 06:00:25 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5e180547bdeso1458317b3.1;
        Mon, 11 Dec 2023 06:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702303225; x=1702908025; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LNTv7V3EOxu8et+zxKRKRD7xOGYn8t55trHPfKfBcwo=;
        b=IZ+Q1ocQvf0EqoQJMZXvl9CRIrLkCY6CYBMV5lgvT66wedCAAJppYZb3DjQlMCmbu8
         J8jjzu0nmdf6uK8Q8RO7RP+4qjVTNZKM9QCgDjDeUjCBkPnXxcY4VZjackjUhy0kWNZW
         yERJ+A9HEmCayllSlY142FulW0EGKwmUB9bPw95ZnDTF3XWsdH33enaRUa2kUktPFwTo
         HxIS3aawvm2IIHF1d5Mf38J/Yl1fgIqYDsIoZuIiU3HOwKUjyTo37ypqvmDPKIwzMLzN
         tXaY+QnrYDbrh/phk6+Y3ekSI+ao6CtT8w6pKMv8fZOPKH7vwoWNhv5i0Fngg1DpYJJF
         EkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702303225; x=1702908025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNTv7V3EOxu8et+zxKRKRD7xOGYn8t55trHPfKfBcwo=;
        b=N+qzxX8CAPXo2FDt41QceFBuxHpL2V++3+o1fK/RPGPS4ty30uUaEwNtGI7wLpCYMp
         DryWHj8R3soNjkz3S6EdIqz2OKK0zeA6pg+B5QiDYED2+bmyx2ttnSGINtf0MzTv3pLq
         /8BSfgZY5pHcgV6GvOFFmyj5MOKkj97qdLMzVdEUCnAC4LMRlLENTIrmqRx38IdoE0/Q
         MAcD3D44BkkCblJUIpcC4yO5mwbkmCfQHdFg8k4cIyZLdiMSwJpsbvSPhTv9nLUJa5N3
         br5Hm/nxlnf22UnACSUaAUeBAteYb3G+rEcNTGeeh+nsDAlXjCZLRxlaJvu0GvxExtvT
         vzgg==
X-Gm-Message-State: AOJu0YytMVsS83ZiByk2VA+DCcjGFaljHlCM3/gssarfegmNHS7g45wE
        2uc2dLBKXNAE+Jj2xgtaQBg=
X-Google-Smtp-Source: AGHT+IGLhyIF/d5QvpkeI4/4kwHQ1QkLNBHHxOYgnuqRp9V6jzQy+pH/7dtnS4EyBFrob/ltOoRX4g==
X-Received: by 2002:a5b:784:0:b0:d9a:d8bd:7b9c with SMTP id b4-20020a5b0784000000b00d9ad8bd7b9cmr2783952ybq.11.1702303224510;
        Mon, 11 Dec 2023 06:00:24 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:f798:e824:429f:84b0])
        by smtp.gmail.com with ESMTPSA id k18-20020a258c12000000b00d9cbf2aabc6sm2514846ybl.14.2023.12.11.06.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 06:00:23 -0800 (PST)
Date:   Mon, 11 Dec 2023 06:00:22 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
        leon@kernel.org, cai.huoqing@linux.dev,
        ssengar@linux.microsoft.com, vkuznets@redhat.com,
        tglx@linutronix.de, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, schakrabarti@microsoft.com,
        paulros@microsoft.com
Subject: Re: [PATCH V5 net-next] net: mana: Assigning IRQ affinity on HT cores
Message-ID: <ZXcV9pXmg+GE2BCF@yury-ThinkPad>
References: <1702029754-6520-1-git-send-email-schakrabarti@linux.microsoft.com>
 <ZXMiOwK3sOJNXHxd@yury-ThinkPad>
 <ZXOQb+3R0YAT/rAm@yury-ThinkPad>
 <20231211065323.GB4977@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211065323.GB4977@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2023 at 10:53:23PM -0800, Souradeep Chakrabarti wrote:
> On Fri, Dec 08, 2023 at 01:53:51PM -0800, Yury Norov wrote:
> > Few more nits
> > 
> > On Fri, Dec 08, 2023 at 06:03:40AM -0800, Yury Norov wrote:
> > > On Fri, Dec 08, 2023 at 02:02:34AM -0800, Souradeep Chakrabarti wrote:
> > > > Existing MANA design assigns IRQ to every CPU, including sibling
> > > > hyper-threads. This may cause multiple IRQs to be active simultaneously
> > > > in the same core and may reduce the network performance with RSS.
> > > 
> > > Can you add an IRQ distribution diagram to compare before/after
> > > behavior, similarly to what I did in the other email?
> > > 
> > > > Improve the performance by assigning IRQ to non sibling CPUs in local
> > > > NUMA node. The performance improvement we are getting using ntttcp with
> > > > following patch is around 15 percent with existing design and approximately
> > > > 11 percent, when trying to assign one IRQ in each core across NUMA nodes,
> > > > if enough cores are present.
> > > 
> > > How did you measure it? In the other email you said you used perf, can
> > > you show your procedure in details?
> > > 
> > > > Suggested-by: Yury Norov <yury.norov@gmali.com>
> > > > Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> > > > ---
> > > 
> > > [...]
> > > 
> > > >  .../net/ethernet/microsoft/mana/gdma_main.c   | 92 +++++++++++++++++--
> > > >  1 file changed, 83 insertions(+), 9 deletions(-)
> > > > 
> > > > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > > index 6367de0c2c2e..18e8908c5d29 100644
> > > > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > > @@ -1243,15 +1243,56 @@ void mana_gd_free_res_map(struct gdma_resource *r)
> > > >  	r->size = 0;
> > > >  }
> > > >  
> > > > +static int irq_setup(int *irqs, int nvec, int start_numa_node)
> > > > +{
> > > > +	int w, cnt, cpu, err = 0, i = 0;
> > > > +	int next_node = start_numa_node;
> > > 
> > > What for this?
> > > 
> > > > +	const struct cpumask *next, *prev = cpu_none_mask;
> > > > +	cpumask_var_t curr, cpus;
> > > > +
> > > > +	if (!zalloc_cpumask_var(&curr, GFP_KERNEL)) {
> > 
> > alloc_cpumask_var() here and below, because you initialize them by
> > copying
> I have used zalloc here as prev gets initialized after the first hop, before that
> it may contain unwanted values, which may impact cpumask_andnot(curr, next, prev).
> Regarding curr I will change it to alloc_cpumask_var().
> Please let me know if that sounds right.

What? prev is initialized at declaration:
        
        const struct cpumask *next, *prev = cpu_none_mask;

