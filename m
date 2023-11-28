Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285137FB0AB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 04:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbjK1DrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 22:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbjK1DrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 22:47:22 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D881AA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 19:47:28 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3b2f507c03cso3034993b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 19:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701143248; x=1701748048; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GVpyKgOAQAjrhknJpFAGo50iMbjyJYlCx/CCVK+Isf8=;
        b=bRtRBrFHi3susyfdoAMcowQvXiJJB1xFpZcbRjw/6Zgm97Wvozk9iifSVdzRQSLm9m
         dYbuCmzHezAHPCe9Fh2L1p6CUUnUP7YotIzFQDPNXe+jw2vkpDYEOEv2PeoSSNGGWsem
         uMifwHq0ERpYgM+xF2kMYe80Ph0HWHsOzbPvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701143248; x=1701748048;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GVpyKgOAQAjrhknJpFAGo50iMbjyJYlCx/CCVK+Isf8=;
        b=eceMV3w4RzMKjnU+wmiE4YmceKb72DNNMs6qQfbCjY4LKW2Xa4aWXsNapyiyVKtpr3
         uD6yQ0SJjv5btjteLVH33iF8R6t0M5/hhsRuUchqMG7GmDiEXoRJOlkyJyqkteM1lSvq
         XzgBRi0wcbrD4Hh9MmLsrjgp6MhJ8OoLLETCEIS7JUm0xY+Xgvlk0e//JH0RJ14/7l22
         Ho9al2QrwZVxw6/OHQwKSrv+JWa/X5NGLMCQ3yrgzH3NwWzYv/glD9Kgj8+lqro7v2+f
         0Hc0yLXdozDPA7tdsZq/luFvWx+L9e49oH9U6OlctLV4oBCQWXLtSEOKRwf+6/yjA3Zw
         GM7Q==
X-Gm-Message-State: AOJu0YykEa7W42hhYX0XOAKPRUhgN3YonYkrvhXrqB9wImIM3DTN7/tF
        0MNQxaif7o1h2vzMWncUFgVQRA==
X-Google-Smtp-Source: AGHT+IEBjnPiJn6iWJLu7YX98L4ojQv3g8KXQa8fjJb4ZSIU2ly5q9i5nliKZY6K4o7RjmpmG+uNzQ==
X-Received: by 2002:a05:6358:724c:b0:16d:fb29:d78 with SMTP id i12-20020a056358724c00b0016dfb290d78mr13055265rwa.2.1701143248083;
        Mon, 27 Nov 2023 19:47:28 -0800 (PST)
Received: from google.com (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id q2-20020ac84502000000b00423829b6d91sm4242296qtn.8.2023.11.27.19.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 19:47:27 -0800 (PST)
Date:   Tue, 28 Nov 2023 03:47:26 +0000
From:   Paz Zcharya <pazz@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Subrata Banik <subratabanik@google.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Sean Paul <seanpaul@chromium.org>,
        matthew.auld@intel.com, Daniel Vetter <daniel@ffwll.ch>,
        Marcin Wojtas <mwojtas@chromium.org>,
        Drew Davenport <ddavenport@chromium.org>,
        David Airlie <airlied@gmail.com>,
        Nirmoy Das <nirmoy.das@intel.com>
Subject: Re: [Intel-gfx] [PATCH] drm/i915/display: Fix phys_base to be
 relative not absolute
Message-ID: <ZWVizpRkf5iJ2LnQ@google.com>
References: <20231105172718.18673-1-pazz@chromium.org>
 <ZVQ3d8FFqxsy0OX7@intel.com>
 <ZVfw3ghfBLdHB7uk@google.com>
 <8dd6f4da-dcc9-4ea3-8395-bf048b0dbc93@intel.com>
 <6f08cfee-a60b-4f6e-b69a-20517c563259@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f08cfee-a60b-4f6e-b69a-20517c563259@intel.com>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Nov 27, 2023 at 8:20 PM Paz Zcharya <pazz@chromium.org> wrote:
>
> On 21.11.2023 13:06, Andrzej Hajda wrote:
> > On 18.11.2023 00:01, Paz Zcharya wrote:
> > > On Tue, Nov 14, 2023 at 10:13:59PM -0500, Rodrigo Vivi wrote:
> > > > On Sun, Nov 05, 2023 at 05:27:03PM +0000, Paz Zcharya wrote:
> > >
> > > Hi Rodrigo, thanks for the great comments.
> > >
> > > Apologies for using a wrong/confusing terminology. I think 'phys_base'
> > > is supposed to be the offset in the GEM BO, where base (or
> > > "Surface Base Address") is supposed to be the GTT offset.
> >
> > Since base is taken from PLANE_SURF register it should be resolvable via
> > GGTT to physical address pointing to actual framebuffer.
> > I couldn't find anything in the specs.
>
> It was quite cryptic. I meant I have not found anything about assumption
> from commit history that for iGPU there should be 1:1 mapping, this is why
> there was an assignment "phys_base = base". Possibly the assumption is not
> valid anymore for MTL(?).
> Without the assumption we need to check GGTT to determine phys address.
>
> > The simplest approach would be then do the same as in case of DGFX:
> >          gen8_pte_t __iomem *gte = to_gt(i915)->ggtt->gsm;
> >          gen8_pte_t pte;
> >
> >          gte += base / I915_GTT_PAGE_SIZE;
> >
> >          pte = ioread64(gte);
> >          phys_base = pte & I915_GTT_PAGE_MASK;
> >
> > Regards
> > Andrzej

Hey Andrzej,

On a second thought, what do you think about something like

+               gen8_pte_t __iomem *gte = to_gt(i915)->ggtt->gsm;
+               gen8_pte_t pte;
+               gte += base / I915_GTT_PAGE_SIZE;
+               pte = ioread64(gte);
+               pte = pte & I915_GTT_PAGE_MASK;
+               phys_base = pte - i915->mm.stolen_region->region.start;

The only difference is the last line.

Based on what I wrote before, I think `phys_base` is named incorrectly and
that it does not reflect the physical address, but the start offset of
i915->mm.stolen_region. So if we offset the start value of the stolen
region, this code looks correct to me (and it also works on my
MeteorLake device).

What do you think?


Many thanks,
Paz

