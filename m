Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E00D7FC9E5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 23:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjK1Wud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 17:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK1Wuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 17:50:32 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD91719A4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 14:50:38 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-42033328ad0so33848721cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 14:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701211838; x=1701816638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dCerhjjG9KrYi0TXMgF4xJvZ7AQK4ONjRJhrC9AuZik=;
        b=SDn0Lz4Zx0o9l2XkQP0XKmwmFDlTmHaDCTD5x0qdN/sTaQ3Y/lJv8Ff7k9fi8b0cnV
         X2O65KSloS0sB9E4E7G95iSaoSwD+hD1v6iix54nGZlqoyijw8cdxzbAPU2Nk+OFVXl/
         8dHRFpOzdc9X0xbNry2XPYUDF/4Ec42YvcghfKK1mHTPGBwCX0cLjfRpuJspxTy+vd02
         PJzFKkf+d+4JbYq4yikWJneP+mNltRecirfSjOxS/jiZBYry3+90ylg0/HIPQ8h/cWii
         2rwARbyJKrA+9KV/lF6jK0mls5cSDaSAm7W8Nv+++5Gy475nlEr6RCJx5CJh1FMdLkte
         Vr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701211838; x=1701816638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dCerhjjG9KrYi0TXMgF4xJvZ7AQK4ONjRJhrC9AuZik=;
        b=OElIrfEuYb4Z//Vjl4ZmOVTEbvRGGgrtBcuz0NmyB+/MzattEqrRZU9mwGGZeEp3nu
         b7L5uaRcuhsLS+LvvsqLTzJ0dmkCj2NMiL0pMv+CQal5nzf6+2n0UffdHuiqKFLfigz3
         rE4ufuE7KMi9w16Hd2amPpaLtSovrNCzaz2Blm/VvxjY2ZtqWBQat1YK4RSH/NKKK5qd
         uiLcN/j+wDJCtKH97WcULJ98eo6TBtwvShz9cC5uB7nm4AzJIaj5sqYsF8wPF4o++Zuh
         loMtFMa4dJcmXCLKstkOXeEoEhRtxHrHcyreZsyXi02I7RQtmHTcXCvz+mFE1EU0WdxZ
         /KvQ==
X-Gm-Message-State: AOJu0YxKgq1/Hj5RSoMpwwQQwPLpOU8r+2jC2kvjKXD9I6nQOHNozWlx
        0gOp+oVhbN6Dj4SXAw8XfndgKYR1D81HbnPtxEP/FQ==
X-Google-Smtp-Source: AGHT+IFxEAQBwk403dZeGueHLhec0OT/vzBcOBPxuj+Prssp33QGReImzhYCBhKzogO690G6BVR/8UVJbn/fn+bRF6c=
X-Received: by 2002:a05:622a:10f:b0:423:78b4:d136 with SMTP id
 u15-20020a05622a010f00b0042378b4d136mr24659151qtw.54.1701211837930; Tue, 28
 Nov 2023 14:50:37 -0800 (PST)
MIME-Version: 1.0
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
 <20231128204938.1453583-7-pasha.tatashin@soleen.com> <d99e0d4a-94a9-482b-b5b5-833cba518b86@arm.com>
In-Reply-To: <d99e0d4a-94a9-482b-b5b5-833cba518b86@arm.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 28 Nov 2023 17:50:01 -0500
Message-ID: <CA+CK2bDswtrqiOMt3+0LBb0+7nJY9aBpzZdsmrWRzy9WxBqKEg@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 5:34=E2=80=AFPM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 2023-11-28 8:49 pm, Pasha Tatashin wrote:
> > Convert iommu/dma-iommu.c to use the new page allocation functions
> > provided in iommu-pages.h.
>
> These have nothing to do with IOMMU pagetables, they are DMA buffers and
> they belong to whoever called the corresponding dma_alloc_* function.

Hi Robin,

This is true, however, we want to account and observe the pages
allocated by IOMMU subsystem for DMA buffers, as they are essentially
unmovable locked pages. Should we separate IOMMU memory from KVM
memory all together and add another field to /proc/meminfo, something
like "iommu -> iommu pagetable and dma memory", or do we want to
export DMA memory separately from IOMMU page tables?

Since, I included DMA memory, I specifically removed mentioning of
IOMMU page tables in the most of places, and only report it as IOMMU
memory. However, since it is still bundled together with SecPageTables
it can be confusing.

Pasha
