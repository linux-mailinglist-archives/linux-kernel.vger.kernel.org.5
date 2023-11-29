Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0B97FE06A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 20:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbjK2Tpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 14:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjK2Tpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 14:45:39 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D2B10C9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 11:45:44 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c9bf8964c3so2426051fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 11:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701287143; x=1701891943; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fNNsoM3smwE3RnQXjosvlH5YCUc/qVQE7cVYHj28TpE=;
        b=LXdK4D//aEMP9BGxDDgf86iGwwP755ud2a5fDDm/H2p6QdLjemMKdW6OURufzQsPsY
         0eLaXgTBlg6Ro0WFppwNRmOJLM1GDxyvkcB5TIzwaa1UbSsi7lsRSu+qu1QqrpGx2WuC
         PMdM6kTA5x1LLeGlJbl22YhycJKkzgKrJu76H5g6PWBs4oxqQRSTNqluBFW5+ez9Jziz
         4aIESjCEFR56CJFlo89lMbSGxS5kd6/vIt4XU6zdtPKVphOyJms1zwcJv0kWIeUQ3+tq
         DwWxhQoRd48Vb+sQo8NASWDsRlac17f1RpzDbTnO7V3cede7ZgbiDEwo9K3QOihi0Ay/
         uOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701287143; x=1701891943;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fNNsoM3smwE3RnQXjosvlH5YCUc/qVQE7cVYHj28TpE=;
        b=rJUiHYLogIoNkdSt3/13VVeONmsl8UoaCWpVa27qF5B/wk+FHxrsgnQRGTuzvvm3EP
         jFkBWNyALCktjjCVG227GHe5EjltZgu3sq0VoqrfaE4aDGYx7N7HJItTY+/UuQPW5sWx
         H7mi4WkxPSTEGTMlapICasI71Xu8IlOk9y7a4/sqLnyEq9kO5rvkYfwsFsZOrK8psuK2
         Rtj53q8ZW11LhBGWmHbIFbaMymZ2JnrgBW9XbY8uPBtfTVe4h7t9NY6ov3ksRXFSsVw1
         D88JZ6NOXiYTN9VzSrbpf1819xfhkuNJmbqCKRiiZJsHY+X2xJexiPgMiFusf7FGfDuy
         5PMA==
X-Gm-Message-State: AOJu0YwTlJOPFU1dcWr4ZdhEYaNMOwyC84aiSTKdYVMM75gjCWYy/MT0
        2JkRey6ZyXeAiYlSqpwajHKkmFfwZKHw3h/mYM04yg==
X-Google-Smtp-Source: AGHT+IHo1CBmTuUhAhmoXR/KJsiUOGXe0H72uTjo3bJ8/f4ydzGN+L/1B0mI7eNNH55dLwJ3p7aHezZlyWQqax7aj9w=
X-Received: by 2002:a2e:9b59:0:b0:2c6:ece6:5b65 with SMTP id
 o25-20020a2e9b59000000b002c6ece65b65mr12569535ljj.10.1701287142874; Wed, 29
 Nov 2023 11:45:42 -0800 (PST)
MIME-Version: 1.0
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
 <20231128204938.1453583-9-pasha.tatashin@soleen.com> <1c6156de-c6c7-43a7-8c34-8239abee3978@arm.com>
 <CA+CK2bCOtwZxTUS60PHOQ3szXdCzau7OpopgFEbbC6a9Frxafg@mail.gmail.com>
 <20231128235037.GC1312390@ziepe.ca> <52de3aca-41b1-471e-8f87-1a77de547510@arm.com>
In-Reply-To: <52de3aca-41b1-471e-8f87-1a77de547510@arm.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 29 Nov 2023 14:45:03 -0500
Message-ID: <CA+CK2bCcfS1Fo8RvTeGXj_ejPRX9--sh5Jz8nzhkZnut4juDmg@mail.gmail.com>
Subject: Re: [PATCH 08/16] iommu/fsl: use page allocation function provided by iommu-pages.h
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, akpm@linux-foundation.org,
        alex.williamson@redhat.com, alim.akhtar@samsung.com,
        alyssa@rosenzweig.io, asahi@lists.linux.dev,
        baolu.lu@linux.intel.com, bhelgaas@google.com,
        cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com,
        dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de,
        iommu@lists.linux.dev, jasowang@redhat.com,
        jernej.skrabec@gmail.com, jonathanh@nvidia.com, joro@8bytes.org,
        kevin.tian@intel.com, krzysztof.kozlowski@linaro.org,
        kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, lizefan.x@bytedance.com,
        marcan@marcan.st, mhiramat@kernel.org, mst@redhat.com,
        m.szyprowski@samsung.com, netdev@vger.kernel.org,
        paulmck@kernel.org, rdunlap@infradead.org, samuel@sholland.org,
        suravee.suthikulpanit@amd.com, sven@svenpeter.dev,
        thierry.reding@gmail.com, tj@kernel.org, tomas.mudrunka@gmail.com,
        vdumpa@nvidia.com, virtualization@lists.linux.dev, wens@csie.org,
        will@kernel.org, yu-cheng.yu@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> We can separate the metric into two:
> >> iommu pagetable only
> >> iommu everything
> >>
> >> or into three:
> >> iommu pagetable only
> >> iommu dma
> >> iommu everything
> >>
> >> What do you think?
> >
> > I think I said this at LPC - if you want to have fine grained
> > accounting of memory by owner you need to go talk to the cgroup people
> > and come up with something generic. Adding ever open coded finer
> > category breakdowns just for iommu doesn't make alot of sense.
> >
> > You can make some argument that the pagetable memory should be counted
> > because kvm counts it's shadow memory, but I wouldn't go into further
> > detail than that with hand coded counters..
>
> Right, pagetable memory is interesting since it's something that any
> random kernel user can indirectly allocate via iommu_domain_alloc() and
> iommu_map(), and some of those users may even be doing so on behalf of
> userspace. I have no objection to accounting and potentially applying
> limits to *that*.

Yes, in the next version, I will separate pagetable only from the
rest, for the limits.

> Beyond that, though, there is nothing special about "the IOMMU
> subsystem". The amount of memory an IOMMU driver needs to allocate for
> itself in order to function is not of interest beyond curiosity, it just
> is what it is; limiting it would only break the IOMMU, and if a user

Agree about the amount of memory IOMMU allocates for itself, but that
should be small, if it is not, we have to at least show where the
memory is used.

> thinks it's "too much", the only actionable thing that might help is to
> physically remove devices from the system. Similar for DMA buffers; it
> might be intriguing to account those, but it's not really an actionable
> metric - in the overwhelming majority of cases you can't simply tell a
> driver to allocate less than what it needs. And that is of course
> assuming if we were to account *all* DMA buffers, since whether they
> happen to have an IOMMU translation or not is irrelevant (we'd have
> already accounted the pagetables as pagetables if so).

DMA mappings should be observable (do not have to be limited). At the
very least, it can help with explaining the kernel memory overhead
anomalies on production systems.

> I bet "the networking subsystem" also consumes significant memory on the

It does, and GPU drivers also may consume a significant amount of memory.

> same kind of big systems where IOMMU pagetables would be of any concern.
> I believe some of the some of the "serious" NICs can easily run up
> hundreds of megabytes if not gigabytes worth of queues, SKB pools, etc.
> - would you propose accounting those too?

Yes. Any kind of kernel memory that is proportional to the workload
should be accountable. Someone is using those resources compared to
the idling system, and that someone should be charged.

Pasha
