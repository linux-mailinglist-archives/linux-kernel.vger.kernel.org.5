Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1AE7FCE35
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 06:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjK2FPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 00:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjK2FPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 00:15:06 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D1619AD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 21:15:12 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5488bf9e193so8536834a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 21:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701234911; x=1701839711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Q9CRtsR/lkt7Cw/fHi7bDvZN/itsXqjiup0ZTmySxA=;
        b=L359onms5pDPnjKtib/Hql+KfzbmJaAPDw8jKdzmgXS/GopwU5yWTRAaZtmRUaCPif
         MimvL6slmeJLUjv+L0E5Hi0joO4XbXPmYBDdqseQK0OPLJPW4BYX7S8d9sIwFYaEYGbK
         eBnYtYel4vqDIZxoabxzSqwii+/tX/69BRsc1OY2VfyT2lV070fEnb71SeUqIOX316qi
         AcaaNQS60htuUleJ69SmkcAGpZjf3YHtWSwAFuP53Jqy/7TsqiFfrXbGr31jndKPj3FK
         tGJXsjzquzoLDYanLwTfwx0UPIibpfeSAtCQ2++mORd8+VuWelJyMlAEmq5yCwC9Neen
         cZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701234911; x=1701839711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Q9CRtsR/lkt7Cw/fHi7bDvZN/itsXqjiup0ZTmySxA=;
        b=gAc5GLG/KUOBLGKJ86oe3PhtdDKQtzvEvdP0//t3TdsmHl9YZUmEuH9Zyj5u1PF+an
         +sQzXT0pwXzgr602kelsp6NJxfNOo7I92rTx+JqBmepANxGzLSh/CBtvVkgqs3e3rLr0
         6ju4WAvWZacofeZDo4AeJyUEf+0Bha8b95MKk3xSn8GNFFRkhdwiEw85JuOZwiTKIMWx
         xXlfg4cr0bMumPZkqsqhz64DJh4meVKU2H19Sz3LsOievXCtN+KrFcZGunKyGIwM5gkl
         9ZAhhxhHxxcD7f6TupavAt89+zqF76E2iMAiAdWvlcxiQ3jmGjaljbfhnsVjsuIEkIdo
         ptdA==
X-Gm-Message-State: AOJu0Yw8zRfoci4wN7x7GxzYP/P9k+IXQ40GfFokQfb3wXTpDuYiKQ2I
        RXW9/2VQfLbJyUY4SnXlXLboQwaA/DeqzJS8+kA=
X-Google-Smtp-Source: AGHT+IF8BQbzvC8JUMcPZoTIvdOo/gY/kUL91mdf8zioqThU2TU+yw6ExoLa9toWLp2NMd4yrs5b7C6bb/cyNxAjx+o=
X-Received: by 2002:a17:906:5299:b0:a00:8706:c82e with SMTP id
 c25-20020a170906529900b00a008706c82emr13477614ejm.18.1701234910430; Tue, 28
 Nov 2023 21:15:10 -0800 (PST)
MIME-Version: 1.0
References: <20231128125025.4449-1-weixi.zhu@huawei.com> <9308a79d-e312-4e6d-98fe-75dc6d0fbeda@amd.com>
In-Reply-To: <9308a79d-e312-4e6d-98fe-75dc6d0fbeda@amd.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Wed, 29 Nov 2023 15:14:58 +1000
Message-ID: <CAPM=9tx-d-Au_bjX0vYxv6OwqiSjmbbMC7ebWpTsQgFNddWDuw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Supporting GMEM (generalized memory management)
 for external memory devices
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Weixi Zhu <weixi.zhu@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        weixi.zhu@openeuler.sh, mgorman@suse.de, jglisse@redhat.com,
        rcampbell@nvidia.com, jhubbard@nvidia.com, apopple@nvidia.com,
        mhairgrove@nvidia.com, ziy@nvidia.com, alexander.deucher@amd.com,
        Xinhui.Pan@amd.com, amd-gfx@lists.freedesktop.org,
        Felix.Kuehling@amd.com, ogabbay@kernel.org,
        dri-devel@lists.freedesktop.org, jgg@nvidia.com, leonro@nvidia.com,
        zhenyuw@linux.intel.com, zhi.a.wang@intel.com,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        tvrtko.ursulin@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2023 at 23:07, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
>
> Am 28.11.23 um 13:50 schrieb Weixi Zhu:
> > The problem:
> >
> > Accelerator driver developers are forced to reinvent external MM subsys=
tems
> > case by case, because Linux core MM only considers host memory resource=
s.
> > These reinvented MM subsystems have similar orders of magnitude of LoC =
as
> > Linux MM (80K), e.g. Nvidia-UVM has 70K, AMD GPU has 14K and Huawei NPU=
 has
> > 30K. Meanwhile, more and more vendors are implementing their own
> > accelerators, e.g. Microsoft's Maia 100. At the same time,
> > application-level developers suffer from poor programmability -- they m=
ust
> > consider parallel address spaces and be careful about the limited devic=
e
> > DRAM capacity. This can be alleviated if a malloc()-ed virtual address =
can
> > be shared by the accelerator, or the abundant host DRAM can further
> > transparently backup the device local memory.
> >
> > These external MM systems share similar mechanisms except for the
> > hardware-dependent part, so reinventing them is effectively introducing
> > redundant code (14K~70K for each case). Such developing/maintaining is =
not
> > cheap. Furthermore, to share a malloc()-ed virtual address, device driv=
ers
> > need to deeply interact with Linux MM via low-level MM APIs, e.g. MMU
> > notifiers/HMM. This raises the bar for driver development, since develo=
pers
> > must understand how Linux MM works. Further, it creates code maintenanc=
e
> > problems -- any changes to Linux MM potentially require coordinated cha=
nges
> > to accelerator drivers using low-level MM APIs.
> >
> > Putting a cache-coherent bus between host and device will not make thes=
e
> > external MM subsystems disappear. For example, a throughput-oriented
> > accelerator will not tolerate executing heavy memory access workload wi=
th
> > a host MMU/IOMMU via a remote bus. Therefore, devices will still have
> > their own MMU and pick a simpler page table format for lower address
> > translation overhead, requiring external MM subsystems.
> >
> > --------------------
> >
> > What GMEM (Generalized Memory Management [1]) does:
> >
> > GMEM extends Linux MM to share its machine-independent MM code. Only
> > high-level interface is provided for device drivers. This prevents
> > accelerator drivers from reinventing the wheel, but relies on drivers t=
o
> > implement their hardware-dependent functions declared by GMEM. GMEM's k=
ey
> > interface include gm_dev_create(), gm_as_create(), gm_as_attach() and
> > gm_dev_register_physmem(). Here briefly describe how a device driver
> > utilizes them:
> > 1. At boot time, call gm_dev_create() and registers the implementation =
of
> >     hardware-dependent functions as declared in struct gm_mmu.
> >       - If the device has local DRAM, call gm_dev_register_physmem() to
> >         register available physical addresses.
> > 2. When a device context is initialized (e.g. triggered by ioctl), chec=
k if
> >     the current CPU process has been attached to a gmem address space
> >     (struct gm_as). If not, call gm_as_create() and point current->mm->=
gm_as
> >     to it.
> > 3. Call gm_as_attach() to attach the device context to a gmem address s=
pace.
> > 4. Invoke gm_dev_fault() to resolve a page fault or prepare data before
> >     device computation happens.
> >
> > GMEM has changed the following assumptions in Linux MM:
> >    1. An mm_struct not only handle a single CPU context, but may also h=
andle
> >       external memory contexts encapsulated as gm_context listed in
> >       mm->gm_as. An external memory context can include a few or all of=
 the
> >       following parts: an external MMU (that requires TLB invalidation)=
, an
> >       external page table (that requires PTE manipulation) and external=
 DRAM
> >       (that requires physical memory management).
>
> Well that is pretty much exactly what AMD has already proposed with KFD
> and was rejected for rather good reasons.

> >
> > MMU functions
> > The MMU functions peer_map() and peer_unmap() overlap other functions,
> > leaving a question if the MMU functions should be decoupled as more bas=
ic
> > operations. Decoupling them could potentially prevent device drivers
> > coalescing these basic steps within a single host-device communication
> > operation, while coupling them makes it more difficult for device drive=
rs
> > to utilize GMEM interface.
>
> Well to be honest all of this sounds like history to me. We have already
> seen the same basic approach in KFD, HMM and to some extend in TTM as wel=
l.
>
> And all of them more or less failed. Why should this here be different?


Any info we have on why this has failed to work in the past would be
useful to provide. This is one of those cases where we may not have
documented the bad ideas to stop future developers from thinking they
are bad.

I do think we would want more common code in this area, but I would
think we'd have it more on the driver infrastructure side, than in the
core mm.

Dave.
