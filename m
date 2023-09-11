Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9888E79AEB1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354137AbjIKVwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243944AbjIKS3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 14:29:33 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A039198
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 11:29:29 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4009fdc224dso14315e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 11:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694456967; x=1695061767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sVbKwjvYsKayRQfQqnfoMhqs1+0fnsR+3Q13ar61kcQ=;
        b=4HX7022e45BIAinXcJeURoZv3iGREnhIjTiEsieHHHJZphMJzLupEXqNTFv1f1WFvA
         K8O1UI0VTjNroGhxdaMv8q7Z/d2Bv8OItMbtshCdIuh2h5vfgIaNjpfDl7p9hHBtvo4d
         RFt4EOx/999TyLvYeVtUbsJYDr/BpEltA867IZUs9nQ+qs48tGTM7uH6vdSWBQllMYxS
         BeqFYAZARYVdH2CGaAocdwl0Ren8Ght0Oq5VUL3fj5bC7xTvJ46tmc2c/BQMMx7m/hMd
         5e0iNKHw/ZhwBzDwC/Bfszio2H0tXDZixk2gSJhEqYJZ+stKYkYCary0YaodWuzNthvJ
         FBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694456967; x=1695061767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sVbKwjvYsKayRQfQqnfoMhqs1+0fnsR+3Q13ar61kcQ=;
        b=srl2FWpklyLS/tZ4ibD8pdYIOoWFk5tBkMcUCIpanByMyfbp1DivqD1NG2UX+ZVD1+
         d2f+xeq+kp6IojFKfBDje027Si9uPtUYsP/acCW5EBIkIQWyKJ9w8lff0KmhPVwMnqhg
         BBRF4uQQGOek+6ib63LE1mkbG4zT6pG/snzdR4y3NUlBdKJQWJDZnHvBVjdtfBRv/o0F
         tlKvJruoLV5huZbOe3HZnsrnrHgdFJI1c1ZwwHpQXD7PTYi/1DS2ajzow5DC1PnxxLHu
         VMbwc5ilcBnczvTzlu8BuAg8Djn49+Vrlop6pbrLIIBis1rdIrNeTySty2HaDEX9FylG
         FDWA==
X-Gm-Message-State: AOJu0YyqDqAR2sCi+BVoE157lnRXBhmJ+Qjv/S6jbmpK/hRMwAW21aUV
        YeBi/V5c6g1m90u7VMpbHvjsHK8/p81DFNndknIl
X-Google-Smtp-Source: AGHT+IEip61urvwgkKVc4TSjTz4WJ07S5AZ9xWSZrK/2bf3DpFU4C+CemgJRrVeWgKwkbH4wpHkmoqEHFh/enFx67/Q=
X-Received: by 2002:a05:600c:5122:b0:400:c6de:6a20 with SMTP id
 o34-20020a05600c512200b00400c6de6a20mr18298wms.3.1694456967402; Mon, 11 Sep
 2023 11:29:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230911023038.30649-1-yong.wu@mediatek.com> <20230911023038.30649-4-yong.wu@mediatek.com>
 <803846bc-fd1d-d2ec-2855-456af22c82f8@amd.com>
In-Reply-To: <803846bc-fd1d-d2ec-2855-456af22c82f8@amd.com>
From:   John Stultz <jstultz@google.com>
Date:   Mon, 11 Sep 2023 11:29:15 -0700
Message-ID: <CANDhNCrQyiFZ+8DnG0iyKBXC0H1698K1a9d2AxOq4whDsZBn+Q@mail.gmail.com>
Subject: Re: [PATCH 3/9] dma-heap: Provide accessors so that in-kernel drivers
 can allocate dmabufs from specific heaps
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Yong Wu <yong.wu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Brian Starkey <Brian.Starkey@arm.com>, tjmercier@google.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, jianjiao.zeng@mediatek.com,
        kuohong.wang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 3:14=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
> Am 11.09.23 um 04:30 schrieb Yong Wu:
> > From: John Stultz <jstultz@google.com>
> >
> > This allows drivers who don't want to create their own
> > DMA-BUF exporter to be able to allocate DMA-BUFs directly
> > from existing DMA-BUF Heaps.
> >
> > There is some concern that the premise of DMA-BUF heaps is
> > that userland knows better about what type of heap memory
> > is needed for a pipeline, so it would likely be best for
> > drivers to import and fill DMA-BUFs allocated by userland
> > instead of allocating one themselves, but this is still
> > up for debate.
>
> The main design goal of having DMA-heaps in the first place is to avoid
> per driver allocation and this is not necessary because userland know
> better what type of memory it wants.
>
> The background is rather that we generally want to decouple allocation
> from having a device driver connection so that we have better chance
> that multiple devices can work with the same memory.

Yep, very much agreed, and this is what the comment above is trying to desc=
ribe.

Ideally user-allocated buffers would be used to ensure driver's don't
create buffers with constraints that limit which devices the buffers
might later be shared with.

However, this patch was created as a hold-over from the old ION logic
to help vendors transition to dmabuf heaps, as vendors had situations
where they still wanted to export dmabufs that were not to be
generally shared and folks wanted to avoid duplication of logic
already in existing heaps.  At the time, I never pushed it upstream as
there were no upstream users.  But I think if there is now a potential
upstream user, it's worth having the discussion to better understand
the need.

So I think this patch is a little confusing in this series, as I don't
see much of it actually being used here (though forgive me if I'm
missing it).

Instead, It seems it get used in a separate patch series here:
  https://lore.kernel.org/all/20230911125936.10648-1-yunfei.dong@mediatek.c=
om/

Yong, I appreciate you sending this out! But maybe if the secure heap
submission doesn't depend on this functionality, I might suggest
moving this patch (or at least the majority of it) to be part of the
vcodec series instead?  That way reviewers will have more context for
how the code being added is used?

thanks
-john
