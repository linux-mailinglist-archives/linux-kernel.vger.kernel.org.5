Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925857FCA79
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 00:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346128AbjK1XHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 18:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjK1XHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 18:07:06 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7F01990
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 15:07:11 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-77dc2981a58so56019985a.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 15:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701212831; x=1701817631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JKGceIQmjzcsQC3Q07PKAqpPD6bs9odge0wDr5u7PKU=;
        b=CaqKA3PoGGnmvX5xVfYre9aCmnshD3tGmVgam2E9dghmSfuPp1SVHKmQMBNqTQC2OT
         UdR46T34ZF1NVVZcnot7ZTkR9YLlfsOclcH24Glj+MFqDyKjeBK1Ts+rFI3D72/srQth
         XUwZ/qTSrX8+v/CsslG/JxeAla8T5sIuGF18FSFmWsGsv0Ybkt561jwCZESesCCtWKPR
         W7wervRHTBY/d3XLyYGAwHlv1M6jciDFhSOC7osTihEqu9fy6uv98EqkgCvOoElfVPZl
         MUOl4BEV4gCbaJ8gBr7he7HcgwarNA/B8yx+X8fobvnA3J5ZpQGgVIbwM7C0hbFqeEeb
         od7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701212831; x=1701817631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JKGceIQmjzcsQC3Q07PKAqpPD6bs9odge0wDr5u7PKU=;
        b=E7awnMNjWEhyhdQV1roVLOUhnqtgjLHeqgDfPcOGHhLc7RQB4PySy73j7sjsx9Q/Ne
         36ubhlXm4yTl5ZKy5FD5un8CiPQbl8H5pzQt5EDXz3PsKfYZPj0xAfDijYIdPcI+I07/
         nshWwxfjP0kk/R+C0ca4X7q8Z8Qrgm+1gieyhFzrkwr1WkW2wXVmmIEnxD3u/8hYmtH9
         v+z+DhTc3YS3bEsQrUDDznXLWqgMGr0sJkwTUd3pchGumCz5wITlX3KxgN0lLBfIXU2I
         TTObWecPd+hbfq7vyVK002NraaYVHdvQxbC7wJJX+WPgk+pv7r/U9Gf/r1XZK5AoegtI
         04bw==
X-Gm-Message-State: AOJu0Yymedhgnd5zLCT46fYaERVVDdC2dlyqL+ODKrbZSsxwr/tV0hGh
        C1meFy1C+MBd61nka4VrtOpfiAImK19HDWqUKg4ybw==
X-Google-Smtp-Source: AGHT+IHAHLSOITMZygZZbwHqs8Pcv2cxmXIEpgUbJ5bxgMm59HnXI3xdTgQIpiDfVoUOALVinCHvTAH42dtkODtq5L8=
X-Received: by 2002:a05:622a:241:b0:423:8287:dc68 with SMTP id
 c1-20020a05622a024100b004238287dc68mr17998278qtx.52.1701212830897; Tue, 28
 Nov 2023 15:07:10 -0800 (PST)
MIME-Version: 1.0
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
 <20231128204938.1453583-7-pasha.tatashin@soleen.com> <d99e0d4a-94a9-482b-b5b5-833cba518b86@arm.com>
 <CA+CK2bDswtrqiOMt3+0LBb0+7nJY9aBpzZdsmrWRzy9WxBqKEg@mail.gmail.com> <79c397ee-b71b-470e-9184-401b4b96a0d2@arm.com>
In-Reply-To: <79c397ee-b71b-470e-9184-401b4b96a0d2@arm.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 28 Nov 2023 18:06:34 -0500
Message-ID: <CA+CK2bDyKP6RT1ZWLKXBcRrfSuONo9LPicskc9+ek=FX_KhwYg@mail.gmail.com>
Subject: Re: [PATCH 06/16] iommu/dma: use page allocation function provided by iommu-pages.h
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     akpm@linux-foundation.org, alex.williamson@redhat.com,
        alim.akhtar@samsung.com, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, baolu.lu@linux.intel.com,
        bhelgaas@google.com, cgroups@vger.kernel.org, corbet@lwn.net,
        david@redhat.com, dwmw2@infradead.org, hannes@cmpxchg.org,
        heiko@sntech.de, iommu@lists.linux.dev, jasowang@redhat.com,
        jernej.skrabec@gmail.com, jgg@ziepe.ca, jonathanh@nvidia.com,
        joro@8bytes.org, kevin.tian@intel.com,
        krzysztof.kozlowski@linaro.org, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-rockchip@lists.infradead.org,
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 5:59=E2=80=AFPM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 2023-11-28 10:50 pm, Pasha Tatashin wrote:
> > On Tue, Nov 28, 2023 at 5:34=E2=80=AFPM Robin Murphy <robin.murphy@arm.=
com> wrote:
> >>
> >> On 2023-11-28 8:49 pm, Pasha Tatashin wrote:
> >>> Convert iommu/dma-iommu.c to use the new page allocation functions
> >>> provided in iommu-pages.h.
> >>
> >> These have nothing to do with IOMMU pagetables, they are DMA buffers a=
nd
> >> they belong to whoever called the corresponding dma_alloc_* function.
> >
> > Hi Robin,
> >
> > This is true, however, we want to account and observe the pages
> > allocated by IOMMU subsystem for DMA buffers, as they are essentially
> > unmovable locked pages. Should we separate IOMMU memory from KVM
> > memory all together and add another field to /proc/meminfo, something
> > like "iommu -> iommu pagetable and dma memory", or do we want to
> > export DMA memory separately from IOMMU page tables?
>
> These are not allocated by "the IOMMU subsystem", they are allocated by
> the DMA API. Even if you want to claim that a driver pinning memory via
> iommu_dma_ops is somehow different from the same driver pinning the same
> amount of memory via dma-direct when iommu.passthrough=3D1, it's still
> nonsense because you're failing to account the pages which iommu_dma_ops
> gets from CMA, dma_common_alloc_pages(), dynamic SWIOTLB, the various
> pools, and so on.
>
> Thanks,
> Robin.
>
> > Since, I included DMA memory, I specifically removed mentioning of
> > IOMMU page tables in the most of places, and only report it as IOMMU
> > memory. However, since it is still bundled together with SecPageTables
> > it can be confusing.
> >
> > Pasha
