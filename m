Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7CC7FE1A6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 22:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbjK2VSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 16:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjK2VSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 16:18:44 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CA4D66;
        Wed, 29 Nov 2023 13:18:51 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1f9ef233912so95684fac.2;
        Wed, 29 Nov 2023 13:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701292730; x=1701897530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WS8gBGQpXQrZRMsSNBag3Tt7HvnBrgRu9OXK2ug1d00=;
        b=QjsUzCp58+8LDzYbBeTYjv6otvQK9j3U8rINdDBS+sLKdXstbd65tzhGv0zWO5yqJP
         dtiTZw4rAImo6cVVu5iUATjjoPwRDa0HOhMU49fzHS1rpQpOT83zNRiLM/cRPctOaTsW
         a/NMWn1wEPY9LHa0SWgT9aVT0QKQaL68VZnGK1kVx0y5SNO6OrQjSWOifWn/Vh8zcJGr
         MSnjoS9TOGy31XYnGezVdAZDwcW8mi4elcl1POBfBMnojPX2DzEmGfTXEVy6YXlO7gdC
         eA2MPNnFQ8zMd8IKUksn+ab2etZWjRqSKZBiKQQVHLd4BNkAj7sO0Z27WTjPlcK+PuBv
         OuSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701292730; x=1701897530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WS8gBGQpXQrZRMsSNBag3Tt7HvnBrgRu9OXK2ug1d00=;
        b=YJ5PJY4AvZqmysvb++1DeQ9Bvj4nGhbTIWWxJhNiBwrKF4514UBbPPcOkeGbmXZ6oF
         T9fu1nojOU0S1QpLAdp/Q4aSrL0konhhvp86ySVzPZOMwPvklcVWcH4yE0CVCeVz/OxV
         +C+BLJIh9YYh9XbDmSvel3mnD6e5E4Bjjn2nGbZA8MUchMbsq9v32sHqqOfGrRmTHToi
         32kGveLsZ6W56l0d/PR+9o3bratwGfYfJtTDm8nTAwucvCHKgLUE3NGwdzoBNzWo5gZi
         1tzl/+gyrBYOGZKRn7NqNOBO+rwopcFCHq9UYImPnwnRDWUOIl3Jig1MR6jX/hr7tKva
         H8Ug==
X-Gm-Message-State: AOJu0YzWjH46sPvLqPhVqyALbn8No8OTqXO8f/EOobbsWOrfN8aLYkIb
        USzC9IE6kK/0/w6SO3SeleZm9jddD7s6kTapfx2cI9nz
X-Google-Smtp-Source: AGHT+IHoa2uzgpSCk5/ua6lNSfqbjchnHD4WUwl8N9K8d67JpoJqLMPCK5zWvuA0I1GukMTG2oUufTYweHYHVEnlxdM=
X-Received: by 2002:a05:6871:810:b0:1fa:79c:ad71 with SMTP id
 q16-20020a056871081000b001fa079cad71mr17816587oap.39.1701292730655; Wed, 29
 Nov 2023 13:18:50 -0800 (PST)
MIME-Version: 1.0
References: <20231122160556.24948-1-Ramesh.Errabolu@amd.com> <c5ae3f32-0779-4583-8fe6-92f5dea5ede6@amd.com>
In-Reply-To: <c5ae3f32-0779-4583-8fe6-92f5dea5ede6@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 29 Nov 2023 16:18:39 -0500
Message-ID: <CADnq5_OJbURbVzXVypohp7gCjE+ckHkEnDD67H7KTDJZt_e3HA@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] Re: [PATCH] dma-buf: Correct the documentation of
 name and exp_name symbols
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Ramesh Errabolu <Ramesh.Errabolu@amd.com>,
        amd-gfx@lists.freedesktop.org, sumit.semwal@linaro.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 1:58=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 22.11.23 um 17:05 schrieb Ramesh Errabolu:
> > Fix the documentation of struct dma_buf members name and exp_name
> > as to how these members are to be used and accessed.
> >
> > Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Please apply this to drm-misc.

Alex

>
> > ---
> >   include/linux/dma-buf.h | 11 +++++++----
> >   1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> > index 3f31baa3293f..8ff4add71f88 100644
> > --- a/include/linux/dma-buf.h
> > +++ b/include/linux/dma-buf.h
> > @@ -343,16 +343,19 @@ struct dma_buf {
> >       /**
> >        * @exp_name:
> >        *
> > -      * Name of the exporter; useful for debugging. See the
> > -      * DMA_BUF_SET_NAME IOCTL.
> > +      * Name of the exporter; useful for debugging. Must not be NULL
> >        */
> >       const char *exp_name;
> >
> >       /**
> >        * @name:
> >        *
> > -      * Userspace-provided name; useful for accounting and debugging,
> > -      * protected by dma_resv_lock() on @resv and @name_lock for read =
access.
> > +      * Userspace-provided name. Default value is NULL. If not NULL,
> > +      * length cannot be longer than DMA_BUF_NAME_LEN, including NIL
> > +      * char. Useful for accounting and debugging. Read/Write accesses
> > +      * are protected by @name_lock
> > +      *
> > +      * See the IOCTLs DMA_BUF_SET_NAME or DMA_BUF_SET_NAME_A/B
> >        */
> >       const char *name;
> >
>
> _______________________________________________
> Linaro-mm-sig mailing list -- linaro-mm-sig@lists.linaro.org
> To unsubscribe send an email to linaro-mm-sig-leave@lists.linaro.org
