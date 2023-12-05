Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2937805B7F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442458AbjLEPli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346346AbjLEPlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:41:36 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F273BF;
        Tue,  5 Dec 2023 07:41:42 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-54c7744a93fso4416060a12.2;
        Tue, 05 Dec 2023 07:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701790901; x=1702395701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAoKJ4psFcjVNbAUMsdpr7K2aFVGd9hI1XgWuDzw694=;
        b=atX1eiCgNB3WTAo7Y7k4/qLTLvOhAMsxGaa5SN5GdM/HE/jDnTIh+3A5BXiuYijoqZ
         9BBQwkRiwh92nyS2Q/J/Z5rl1JFFKo+83F4fKcCQs/oIBwUEvZyjP+xUSJmmkN8jM9Xr
         zcIurxarm3iRdN5SL3OpkaY8kADpIA37w6CqjVmrUq33PILTkntxd1H/p7i6QNkL9nfx
         f6+8hz1tV5tVSoqQh81BnCDY3emkmYpmex8RTnzkI36XX1l+CTBjebhFK15t4KNSTE2B
         5RILBs5LuEZk16ZZguBklj5l8V5P3TE+HVv6oncBho7Qw+1eVl8cFHGJ0N3gu6TL3GTj
         Tz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701790901; x=1702395701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dAoKJ4psFcjVNbAUMsdpr7K2aFVGd9hI1XgWuDzw694=;
        b=Mdpf+Uv2+yPGEfFfhTwmCUQEAui09YAYTH0hPAH6KGTudB+Maq/3wdK4YEdoEGD+KT
         aKDCWrBnjM5gkhOE7qz2/rDGdR0ePfHlSJC3XSZg52TtS/3wMXKFb/DpI2XCTQzU1WSo
         YMEMtKzQ5WNbvsH6+n8nnwdRZOcLDKKmy8iSlnGTBqsEm75mDQBchzD8oTuIx6BUiK03
         WiF+F4clMnAe7ZtJ/28fut1jyGVX7BbwZzidiDWQ6BGVe/nImoeRdYtJpJeOWJBmluAj
         abzD60Z4B1/bpm8RFBPUgMXWsQG7Po3X5NiTjCryMy5dJKzRdGKJcbb7GL5yFNLKlZEm
         H4LQ==
X-Gm-Message-State: AOJu0YzAN6PROZ/YjLkXVRg7qETw3W03CZOmAPmCtPK+b70TwAPGJeo5
        2WVcjh64NpdMw/kwz5EcxXxCoLIjuMlp8QDOnoc=
X-Google-Smtp-Source: AGHT+IFvLDxUTjJzbdwumJSp5LkZc8AHSFgJ97zk7pTSy9rQCh4aUfX+yyZdXl8wOadp6BFbyKQzkAKuDXs3aKp15s8=
X-Received: by 2002:a50:d5cd:0:b0:54c:4837:9a9e with SMTP id
 g13-20020a50d5cd000000b0054c48379a9emr4921654edj.69.1701790900478; Tue, 05
 Dec 2023 07:41:40 -0800 (PST)
MIME-Version: 1.0
References: <20230322224403.35742-1-robdclark@gmail.com> <b9fb81f1-ac9e-cf3f-5cf4-f2d972d3ed3d@amd.com>
 <CAF6AEGvMwZCLntfYeH3Vg_Z7kYynqdVrinp+pmcbREksK1WGMA@mail.gmail.com>
 <e2fa296b-9b71-a41b-d37d-33f0fac2cd4e@amd.com> <CAF6AEGvdVca_mnZVo9He9oKVfYp84e_kOPWaxX+K5aV4Es9kcQ@mail.gmail.com>
 <CAF6AEGt2D6Ei6OkUK5osz+jWzmkX8tmB1KGi305HaNd=bnQSoA@mail.gmail.com> <69d66b9e-5810-4844-a53f-08b7fd8eeccf@amd.com>
In-Reply-To: <69d66b9e-5810-4844-a53f-08b7fd8eeccf@amd.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 5 Dec 2023 07:41:28 -0800
Message-ID: <CAF6AEGuSexYVL2RF4yVCJptfJgN9vvTgzGWn3CminbsYvctTaw@mail.gmail.com>
Subject: Re: [RFC] drm/scheduler: Unwrap job dependencies
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Luben Tuikov <luben.tuikov@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>
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

On Mon, Dec 4, 2023 at 10:46=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 04.12.23 um 22:54 schrieb Rob Clark:
> > On Thu, Mar 23, 2023 at 2:30=E2=80=AFPM Rob Clark <robdclark@gmail.com>=
 wrote:
> >> [SNIP]
> > So, this patch turns out to blow up spectacularly with dma_fence
> > refcnt underflows when I enable DRIVER_SYNCOBJ_TIMELINE .. I think,
> > because it starts unwrapping fence chains, possibly in parallel with
> > fence signaling on the retire path.  Is it supposed to be permissible
> > to unwrap a fence chain concurrently?
>
> The DMA-fence chain object and helper functions were designed so that
> concurrent accesses to all elements are always possible.
>
> See dma_fence_chain_walk() and dma_fence_chain_get_prev() for example.
> dma_fence_chain_walk() starts with a reference to the current fence (the
> anchor of the walk) and tries to grab an up to date reference on the
> previous fence in the chain. Only after that reference is successfully
> acquired we drop the reference to the anchor where we started.
>
> Same for dma_fence_array_first(), dma_fence_array_next(). Here we hold a
> reference to the array which in turn holds references to each fence
> inside the array until it is destroyed itself.
>
> When this blows up we have somehow mixed up the references somewhere.

That's what it looked like to me, but wanted to make sure I wasn't
overlooking something subtle.  And in this case, the fence actually
should be the syncobj timeline point fence, not the fence chain.
Virtgpu has essentially the same logic (there we really do want to
unwrap fences so we can pass host fences back to host rather than
waiting in guest), I'm not sure if it would blow up in the same way.

BR,
-R

> Regards,
> Christian.
>
> >
> > BR,
> > -R
