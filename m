Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C5578D299
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 05:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241836AbjH3Dsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 23:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241827AbjH3DsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 23:48:21 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF451BB
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 20:48:18 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-64c1d487e72so32084746d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 20:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693367296; x=1693972096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3e5h4zGrTEJTR79h27ndC59DREjDD3wdrcEpAoNPexk=;
        b=VnjteoODFfu+8NWAK0qu08ydE5EftOBl+dlijaiIt/7JzPsh7YFdbo/Hj6fm/yX6vt
         0tA4wmR3k/dA/ric3p8Tyn4cIvE938uAJTHPN288mZhqLyGi7HZRYmQoD4ZsZK5H1fp2
         2C3TFbFSR5f0jkQQlWUCAlkTDIJFG7mLnYzSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693367296; x=1693972096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3e5h4zGrTEJTR79h27ndC59DREjDD3wdrcEpAoNPexk=;
        b=StW2Rj33q6eMyL1qElVar0gWgPpajtQHpvba8KtCEMzJK9L2Pszp3abTcQBkEhvnAt
         nX+lEP1Lf9DRcqmlVx2gsbq7akmFcJTT+RPLKQsiuRy/D4fgOkj5EtrAwMcvvWWdt/Nf
         q8N0CDEnekVNIH3NXHkdU3Qx/+dz/ScLD1jkDU5CeXGSogsWkpuBQYh589Hrji0ynY2B
         kGQmLEcRGC6nIuduT2cOe6X44ZHA/lbkKQlDmNvVhmrHYqyNfbQbAFMYGcin7N9Zb6Vr
         CqhF3sALhjGId77YBT2G+RAy70pEs7Z4BtUqFQ4eau/NebVganf1x0jQruhByJzRYLQc
         RJgQ==
X-Gm-Message-State: AOJu0YzlI7907Stj3HBQKejGj0FYPe/YnJPq3Ijw8O2ojdWqOtXc9eMT
        aN8s+h6vEE0RVxh4YHyLeNyXVWIFcJXYqtXtMt3pHA==
X-Google-Smtp-Source: AGHT+IG4poDljOPo6LVLm7d3Cb0agquYGX6XDgMeBB3gkj3uphR86Z3xeH/w7DMVY6sgH7MvGmu8/w==
X-Received: by 2002:ad4:4312:0:b0:649:634d:aeb4 with SMTP id c18-20020ad44312000000b00649634daeb4mr829948qvs.3.1693367296286;
        Tue, 29 Aug 2023 20:48:16 -0700 (PDT)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com. [209.85.219.49])
        by smtp.gmail.com with ESMTPSA id q19-20020ae9e413000000b00767d8e12ce3sm3376013qkc.49.2023.08.29.20.48.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 20:48:16 -0700 (PDT)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-64f42fcd809so32090916d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 20:48:15 -0700 (PDT)
X-Received: by 2002:a05:6214:588e:b0:651:5b77:1ab5 with SMTP id
 md14-20020a056214588e00b006515b771ab5mr1076827qvb.22.1693367295092; Tue, 29
 Aug 2023 20:48:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230828075420.2009568-1-anle.pan@nxp.com> <CAAFQd5Cn3xQroyYtC+m+pk1jOE5i3H+FGr-y8zqhaf0Yo5p-1Q@mail.gmail.com>
 <deb735ce-7de1-e59a-9de4-1365b374b417@arm.com> <20230829150442.GA3929@lst.de>
In-Reply-To: <20230829150442.GA3929@lst.de>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 30 Aug 2023 12:47:57 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CiHXvsJugSi+hXY9ESsmxUzBzmbhF6G48iVsOcL5eMtQ@mail.gmail.com>
Message-ID: <CAAFQd5CiHXvsJugSi+hXY9ESsmxUzBzmbhF6G48iVsOcL5eMtQ@mail.gmail.com>
Subject: Re: [PATCH] media: videobuf2-dma-sg: limit the sg segment size
To:     Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>, Anle Pan <anle.pan@nxp.com>,
        m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        hui.fang@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 12:04=E2=80=AFAM Christoph Hellwig <hch@lst.de> wro=
te:
>
> On Tue, Aug 29, 2023 at 12:14:44PM +0100, Robin Murphy wrote:
> > dma_get_max_seg_size() represents a capability of the device itself, na=
mely
> > the largest contiguous range it can be programmed to access in a single=
 DMA
> > descriptor/register/whatever.
>
> Yes.  In a way it's a bit odd that it ended up in a field in
> struct device, as the feature might actually be different for different
> DMA engines or features in a device.  If I was to redesign it from
> scratch I'd just pass it to dma_map_sg.
>
> >> Generally looking at videobuf2-dma-sg, I feel like we would benefit
> >> from some kind of dma_alloc_table_from_pages() that simply takes the
> >> struct dev pointer and does everything necessary.
> >
> > Possibly; this code already looks lifted from drm_prime_pages_to_sg(), =
and
> > if it's needed here then presumably vb2_dma_sg_get_userptr() also needs=
 it,
> > at the very least.
>
> Yes, there's tons of them.  But I'd feel really bad adding even more
> struct scatterlist based APIs given how bad of a data structure that is.

Do we see anything replacing it widely anywhere on the short-middle
term horizon? I think we could possibly migrate vb2 to use that new
thing internally and just provide some compatibility X to scatterlist
conversion function for the drivers.
