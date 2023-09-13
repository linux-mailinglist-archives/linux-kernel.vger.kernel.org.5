Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0ABB79E06D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 09:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238423AbjIMHGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 03:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238362AbjIMHGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 03:06:00 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADB61738
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 00:05:55 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99c93638322so133034966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 00:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694588754; x=1695193554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ARucV4SPV6o29NZnTlh9kC1XvI7Cu6efHFTCveAgcl0=;
        b=NUbMkY9togY3+BvTooXA+5xbDdE1THV4l0FnLyfjVR7CCbUR0E5Urqff75nzD5fko+
         qxnDsAozS9g8JNqO5r5YoC2YQGCJ8qtdhvr7nd0hS+/c2j3A3Tqa12w8pwdKcJAqtqG0
         6Lwf3sRRf4wvTnT67/JBlCokT2XNHATZNdthiU5e4QvZ1JfwXHOsqM9GOw1e7m2XHWn+
         gB6vigffTRphZ6k2zaXFhsUrLzRdkbVdxg7enX8aUXfHn1YbY1S9dR7/NuzbREu85aEA
         BdkNc8q/CAD5lrFUyPb3MN1UhKT3klB7WoPPbnsZKocoMoP3Td7lK8MlP0TJAZ67bkxO
         lrBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694588754; x=1695193554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ARucV4SPV6o29NZnTlh9kC1XvI7Cu6efHFTCveAgcl0=;
        b=Iw5gorsmxDypEk2o8zsQOv1ZctoxNBUkWwCmnpb/0NypYCRF9VYczh3vPY07WoHjAf
         nYzhcZ0vKs5SKczi5qeJFBQtR0du54EIworPzdlkqr/XeERBOW6XMgrUI+S0+jBAeML+
         TkdEZfs9NtGUNvlfNjZKDwW/YWO068tg5Hu8ZyBQIJ0tbzpPmoGDkiNzDDBI9wyFiYVY
         ZAX4/D0BK1ItfL4Igz3Ljy7PkViLIdya380kcsAOeXyaK03kpPkRote667y5Mql26Ai0
         ZhZdijsvBziiE7aVpyQsoz7oS4B2HXBOlgooGTLOxalf4+RJy0pnZPn67cANU3uefy8L
         vT2A==
X-Gm-Message-State: AOJu0YxNs6Uta6fEe9LoOzFOqhayaoZ25EQ7Pq54XGvJOEtJ/CZHYFUQ
        tnQUrTBPuUWaQH3RwgVhGw5boincAjcjeQ5ieeI=
X-Google-Smtp-Source: AGHT+IHkJKnf5Vb1twD6bjQNQC3iEYctJfsdYHtpo6SstTdYPYDzfAgiSTsnLIEfHqr1m0kJedNPsdPs7MHhH7vSrJo=
X-Received: by 2002:a17:907:75d7:b0:9a5:a543:2744 with SMTP id
 jl23-20020a17090775d700b009a5a5432744mr2313726ejc.33.1694588754097; Wed, 13
 Sep 2023 00:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230909153125.30032-1-dakr@redhat.com> <20230909153125.30032-7-dakr@redhat.com>
 <a9ef04d2-2525-65c0-2eda-45ca9a95a3a0@linux.intel.com> <20230913090311.5eeb026a@collabora.com>
In-Reply-To: <20230913090311.5eeb026a@collabora.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Wed, 13 Sep 2023 17:05:42 +1000
Message-ID: <CAPM=9tyf4m6gtUQ0BCraf0gB06_pxXV8gpQQsvWjeJnczmJkQQ@mail.gmail.com>
Subject: Re: [PATCH drm-misc-next v3 6/7] drm/gpuvm: generalize
 dma_resv/extobj handling and GEM validation
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Danilo Krummrich <dakr@redhat.com>, daniel@ffwll.ch,
        matthew.brost@intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, christian.koenig@amd.com,
        faith.ekstrand@collabora.com, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sept 2023 at 17:03, Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> On Tue, 12 Sep 2023 18:20:32 +0200
> Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com> wrote:
>
> > > +/**
> > > + * get_next_vm_bo_from_list() - get the next vm_bo element
> > > + * @__gpuvm: The GPU VM
> > > + * @__list_name: The name of the list we're iterating on
> > > + * @__local_list: A pointer to the local list used to store already =
iterated items
> > > + * @__prev_vm_bo: The previous element we got from drm_gpuvm_get_nex=
t_cached_vm_bo()
> > > + *
> > > + * This helper is here to provide lockless list iteration. Lockless =
as in, the
> > > + * iterator releases the lock immediately after picking the first el=
ement from
> > > + * the list, so list insertion deletion can happen concurrently.
> >
> > Are the list spinlocks needed for that async state update from within
> > the dma-fence critical section we've discussed previously?
>
> Any driver calling _[un]link() from its drm_gpu_scheduler::run_job()
> hook will be in this situation (Panthor at the moment, PowerVR soon). I
> get that Xe and Nouveau don't need that because they update the VM
> state early (in the ioctl path), but I keep thinking this will hurt us
> if we don't think it through from the beginning, because once you've
> set this logic to depend only on resv locks, it will be pretty hard to
> get back to a solution which lets synchronous VM_BINDs take precedence
> on asynchronous request, and, with vkQueueBindSparse() passing external
> deps (plus the fact the VM_BIND queue might be pretty deep), it can
> take a long time to get your synchronous VM_BIND executed...

btw what is the use case for this? do we have actual vulkan
applications we know will have problems here?

it feels like a bit of premature optimisation, but maybe we have use cases.

Dave.
