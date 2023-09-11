Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676C579C3E7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 05:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242422AbjILDR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 23:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242374AbjILDRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 23:17:11 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E6813EDEB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 17:08:46 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-41501ffb771so24494701cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 17:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694477198; x=1695081998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9FHti0UeaT45a62FC88dUwVtXoyU66QnGu8MY083Gc=;
        b=n7LVDPTy8UPzGF4v+yA5z2PZL/BvqnAYfaj/hP6QJ0KF4rLTfXqknIBBWlPQxJKuNM
         c3fQAY32AwKuGfEEmE5HMrMpgBv2efw4ksbWe+PUyINlrgdMF8fiXApmLOdt0wQ1Y1Lo
         8sJH6DwujBd6u7P7c7H/4bYAEvy+3w1hWDzbeNkFP7jUCc6CHl5rSjsr1ZSwrsZKnKNS
         he6Yvcp5AoyPySfLBJ/yDXuKgwL5emNpa+thD7hK/0splE++6oUhnTUJ7mfNm0IE1FrY
         oUwtylv82Ffe8S1Nm0fYpr9KD3Dv+xAopNwBq6M1B4/6bLRrhYwSIr9tOghmCX477i6S
         O53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694477198; x=1695081998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e9FHti0UeaT45a62FC88dUwVtXoyU66QnGu8MY083Gc=;
        b=Y6GK9Ie4YTUMUaRJga0yAQB9gd4qgdem4nvI6IBNwJ/uMVBhbkpLr855khOrEw0Lx1
         25m7UlCNS1dRpLQXFZniraaJuf/qMb+vRBY31ib8yTAidGTdk1MvmvuMTsyCce17Og2L
         TTF1OII2M2Qe/imLmJ6vkYxunQUVMz8038V0OCSgSj6Uhp19MGIroc1P82Ng2fOwyQxr
         PysADDhOdLKqLUcxMWUq1kBVSV5E4RzjYq5A8fb5Q86qzbDMJW+RRXjyGn0ppzUKaCR+
         +Uu41bfDDEp1WxB/BCnH3DB/Bm4AChGLmzC/9UxySCTddtzJXaec9jbpQyiYUlR3yUBR
         WIAw==
X-Gm-Message-State: AOJu0YxQLa/j1qBKqKTCaovFSFILlOfXolpgzT6H0vs3mGQgwETLfuZE
        A7P8qwbqhCwzkfJTtv7vCDsYugd2swbCprQU0B6jQG1G7Fb5jXUL8SnncQ==
X-Google-Smtp-Source: AGHT+IGFOM/4w9EDJt7MB2VEaaVKgVLAWXiT0CbJ/s1mQvZfpoxvSUlNkizqXQqtn0mkteVDRyeHoSWnwX1ZfV5oYr4=
X-Received: by 2002:a25:ce03:0:b0:d09:f934:f2fe with SMTP id
 x3-20020a25ce03000000b00d09f934f2femr9212180ybe.18.1694476292641; Mon, 11 Sep
 2023 16:51:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230911023038.30649-1-yong.wu@mediatek.com> <20230911023038.30649-2-yong.wu@mediatek.com>
 <46532644-a38b-98d5-13a1-8b51b9276a1d@amd.com>
In-Reply-To: <46532644-a38b-98d5-13a1-8b51b9276a1d@amd.com>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Mon, 11 Sep 2023 16:51:20 -0700
Message-ID: <CABdmKX0-x53hjkKeSw1oDu2yFTKEXc1z_TFg0EMyWF2aBNbk2w@mail.gmail.com>
Subject: Re: [PATCH 1/9] dma-buf: heaps: Deduplicate docs and adopt common format
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Yong Wu <yong.wu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <jstultz@google.com>,
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 2:36=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> m 11.09.23 um 04:30 schrieb Yong Wu:
> > From: "T.J. Mercier" <tjmercier@google.com>
> >
> > The docs for dma_heap_get_name were incorrect, and since they were
> > duplicated in the implementation file they were wrong there too.
> >
> > The docs formatting was inconsistent so I tried to make it more
> > consistent across functions since I'm already in here doing cleanup.
> >
> > Remove multiple unused includes.
> >
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > [Yong: Just add a comment for "priv" to mute build warning]
> > ---
> >   drivers/dma-buf/dma-heap.c | 29 +++++++----------------------
> >   include/linux/dma-heap.h   | 11 +++++------
> >   2 files changed, 12 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> > index 84ae708fafe7..51030f6c9d6e 100644
> > --- a/drivers/dma-buf/dma-heap.c
> > +++ b/drivers/dma-buf/dma-heap.c
> > @@ -7,17 +7,15 @@
> >    */
> >
> >   #include <linux/cdev.h>
> > -#include <linux/debugfs.h>
> >   #include <linux/device.h>
> >   #include <linux/dma-buf.h>
> > +#include <linux/dma-heap.h>
> >   #include <linux/err.h>
> > -#include <linux/xarray.h>
> >   #include <linux/list.h>
> > -#include <linux/slab.h>
> >   #include <linux/nospec.h>
> > -#include <linux/uaccess.h>
> >   #include <linux/syscalls.h>
> > -#include <linux/dma-heap.h>
> > +#include <linux/uaccess.h>
> > +#include <linux/xarray.h>
> >   #include <uapi/linux/dma-heap.h>
> >
> >   #define DEVNAME "dma_heap"
> > @@ -28,9 +26,10 @@
> >    * struct dma_heap - represents a dmabuf heap in the system
> >    * @name:           used for debugging/device-node name
> >    * @ops:            ops struct for this heap
> > - * @heap_devt                heap device node
> > - * @list             list head connecting to list of heaps
> > - * @heap_cdev                heap char device
> > + * @priv:            private data for this heap
> > + * @heap_devt:               heap device node
> > + * @list:            list head connecting to list of heaps
> > + * @heap_cdev:               heap char device
> >    *
> >    * Represents a heap of memory from which buffers can be made.
> >    */
> > @@ -192,25 +191,11 @@ static const struct file_operations dma_heap_fops=
 =3D {
> >   #endif
> >   };
> >
> > -/**
> > - * dma_heap_get_drvdata() - get per-subdriver data for the heap
> > - * @heap: DMA-Heap to retrieve private data for
> > - *
> > - * Returns:
> > - * The per-subdriver data for the heap.
> > - */
>
> Kernel documentation is usually kept on the implementation and not the
> definition.
>
> So I strongly suggest to remove the documentation from the header
> instead and if there is any additional information in there add it here.
>
> Regards,
> Christian.
>
Ok thanks for looking. I'll move all the function docs over to the
implementation.
