Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD597C4114
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 22:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjJJUXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 16:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJJUXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 16:23:31 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7EB8E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 13:23:30 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53808d5b774so10873495a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 13:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696969409; x=1697574209; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9K/39pYVDB63ZN/U40w9C502En4aUTJoZoW8PKDMTc=;
        b=RoEmv0VXe20h981NDuvT4ZuoSNe7IMYJLp0GP4o1wgwErn9pPxGpTfqV3ZGOQvHw7a
         iwzIiXFw82+mrHyRpC2jHAIoplEjqAJo0mY1Y6PaWrQXLJv6zC76RVLkk3z6niu+N7Fk
         dCXvJTQDV0uTnP5xneHfE8+qG1yPsa+NGF6q+bygsW+EEdtsSdYDWZs1nH6IPYudLGGX
         bJbDlAgtpm7XVAGP1Ffe9W8hNqaRJ4WcsQbydzjXUUKyRqJzVPSubEQe6IHToDBo+wM+
         aRXZQ1rifHx+NXY3qDWEUfDkoZJIZNV7jGH38qKiNmilo1zKBf7uPgF2xgvIHKJd8cQC
         uU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696969409; x=1697574209;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q9K/39pYVDB63ZN/U40w9C502En4aUTJoZoW8PKDMTc=;
        b=iUrqoGLqhof1rQr3/lXaSXWmOHFq7Qg4c4U2682qzM/B7PumKPx5zImCl8851nPILe
         QJsICn1euY+FI7+gZmnaw1874EZ1bMqciMN5lGEus+OlGjvYwR8X7SaAg0OSUvhJl+FX
         Q2NbeDy/8zhUH0AzdrkL4Z6ORMvt56SDLQMAT9/TLiz4+G6h6xBaOptikTxLUwOyLiW4
         W6SIhRVU3dXvkP2QSFr3O63ne2tULZ9SSuaeqN/JPdCf3vqsngMKwtPHkjgnxEVQ7MAk
         /4c3y1yKPOWsHfahFc5Y+GLsRx/a1GSt0Kt9leHqnNxvIOjBrksPs1QFdaFL3qk7M0uD
         HXcA==
X-Gm-Message-State: AOJu0YyWctLCgVPwJFHeulnIeUC/a/WJV6UB02hhAT+IFElXgMgrxiDx
        rfbMILmiK4yYef2b+44BKlJf7J2IIsZMCGuv1S0=
X-Google-Smtp-Source: AGHT+IGllDkDZOXntggqqiPf3dVIEhRfn/puLAvLIPz+t1Q0k06Gc6OysEHoI/3TNpo+v9866aIG21AyO2mZjaS6mW4=
X-Received: by 2002:a17:906:7398:b0:9b1:aa5d:5d1f with SMTP id
 f24-20020a170906739800b009b1aa5d5d1fmr15193521ejl.73.1696969408945; Tue, 10
 Oct 2023 13:23:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230820215320.4187-1-dakr@redhat.com> <20230820215320.4187-3-dakr@redhat.com>
 <0c50ff22-0f11-1e27-c32e-694ce2b1e6c5@shipmail.org> <ZO864yp3UyVEfEjz@pollux>
 <88c45fe6-0942-707c-9ea7-8486c177fcd7@shipmail.org> <ZO9Zq2RhbX8EeHrn@pollux>
 <736b6b6d-9e04-a27d-7d60-0c45d696b304@shipmail.org> <ZPB26A0/oLHTmyqk@cassiopeiae>
 <a8f28d62-daec-927a-a33d-5be3eec6a1ed@shipmail.org> <ZPDk/lao1JlBNGoJ@cassiopeiae>
 <8a8253ae-0b85-df90-b480-64eeebfafc6d@shipmail.org>
In-Reply-To: <8a8253ae-0b85-df90-b480-64eeebfafc6d@shipmail.org>
From:   Dave Airlie <airlied@gmail.com>
Date:   Wed, 11 Oct 2023 06:23:16 +1000
Message-ID: <CAPM=9tz3o-m+8VJJ6hxWhykat0kpp1UE7dBJE3X91aHHo1Y2VA@mail.gmail.com>
Subject: Re: [PATCH drm-misc-next 2/3] drm/gpuva_mgr: generalize
 dma_resv/extobj handling and GEM validation
To:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Cc:     Danilo Krummrich <dakr@redhat.com>, daniel@ffwll.ch,
        matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
        sarah.walker@imgtec.com, donald.robson@imgtec.com,
        boris.brezillon@collabora.com, christian.koenig@amd.com,
        faith.ekstrand@collabora.com, bskeggs@redhat.com,
        Liam.Howlett@oracle.com, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I think we're then optimizing for different scenarios. Our compute
> driver will use mostly external objects only, and if shared, I don't
> forsee them bound to many VMs. What saves us currently here is that in
> compute mode we only really traverse the extobj list after a preempt
> fence wait, or when a vm is using a new context for the first time. So
> vm's extobj list is pretty large. Each bo's vma list will typically be
> pretty small.

Can I ask why we are optimising for this userspace, this seems
incredibly broken.

We've has this sort of problem in the past with Intel letting the tail
wag the horse, does anyone remember optimising relocations for a
userspace that didn't actually need to use relocations?

We need to ask why this userspace is doing this, can we get some
pointers to it? compute driver should have no reason to use mostly
external objects, the OpenCL and level0 APIs should be good enough to
figure this out.

Dave.
