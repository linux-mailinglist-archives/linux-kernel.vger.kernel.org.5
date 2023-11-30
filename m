Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592157FF500
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345262AbjK3QY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjK3QY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:24:57 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEAE1AD
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:25:02 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-67a8a6d104bso2434806d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701361502; x=1701966302; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=my1t1P8SWkl8MqywnACtSrV/Cg5hc9HpmKaWspyD2aI=;
        b=SZefqgFj32s4qtb9X58GmfKu6VPnBZbBp4dKl7lndPedb7zUoXcNhgdzJyPVoPs+JP
         0Jfc/HvWYzdSSkR7ou6ICZeGvuaFGHLnQ8pwGXL9hBWlziQyi9Kozxtw0cASAf55YJuV
         83LVNHC3uyyshK7ahaC/qLnewkjSESm/HT36g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701361502; x=1701966302;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=my1t1P8SWkl8MqywnACtSrV/Cg5hc9HpmKaWspyD2aI=;
        b=o1ER2g6qJeeWCe7zkUDN+vnQZ6ziiUK+q/vC5FYuJ2w5IMYDmzvPQLZTDy/5dFkwiw
         Ns0tbTGbK7OwsGYS7ohghMqNWhedg8ubgvGfL/prE+B2eGophoi9aUhdtH6OQo7yAQpA
         oAL6jkM+a6IyOfBgUx84i8ehpFlkzMH6GpE4plBktQiIPDUZ1z2o4qBL61taJFBkaMPq
         DtQX4egMVV3yKxBZc5qUneB1bRYMTf5MpOIYgel60t8DAfUzP41XLEvEFHBR2yuLwbZ0
         8bqzfGWMoNAHBkO28puAtu46U/ieAYKy6jNVneCMO8g6Zuvd47/RrB8+qd5ZPLrjGV/4
         ljpg==
X-Gm-Message-State: AOJu0YxkHl0kG1PbNxB3dhPxu+4J1QWpP4VIqSFVQHNGAI810aexAHT6
        FdjrsnuqjZUT87K2NQ9AtCkUfA==
X-Google-Smtp-Source: AGHT+IFawe0Afhp7iXVnLrDiPGhZ2DR+S4GaJyZefC4rp8NXx7yyA8UAxN/lcHVi7V5Lj1egodPtCA==
X-Received: by 2002:ad4:5249:0:b0:67a:33b5:594c with SMTP id s9-20020ad45249000000b0067a33b5594cmr16998574qvq.13.1701361501693;
        Thu, 30 Nov 2023 08:25:01 -0800 (PST)
Received: from google.com (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id b18-20020a0c9b12000000b0065b13180892sm641645qve.16.2023.11.30.08.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 08:25:01 -0800 (PST)
Date:   Thu, 30 Nov 2023 16:24:59 +0000
From:   Paz Zcharya <pazz@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     Subrata Banik <subratabanik@google.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        intel-gfx@lists.freedesktop.org,
        Marcin Wojtas <mwojtas@chromium.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Sean Paul <seanpaul@chromium.org>, matthew.auld@intel.com,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Drew Davenport <ddavenport@chromium.org>,
        David Airlie <airlied@gmail.com>,
        Nirmoy Das <nirmoy.das@intel.com>
Subject: Re: [Intel-gfx] [PATCH] drm/i915/display: Fix phys_base to be
 relative not absolute
Message-ID: <ZWi3WzM6kYRotWrd@google.com>
References: <20231105172718.18673-1-pazz@chromium.org>
 <ZVQ3d8FFqxsy0OX7@intel.com>
 <ZVfw3ghfBLdHB7uk@google.com>
 <8dd6f4da-dcc9-4ea3-8395-bf048b0dbc93@intel.com>
 <6f08cfee-a60b-4f6e-b69a-20517c563259@intel.com>
 <ZWVizpRkf5iJ2LnQ@google.com>
 <51baffb9-2249-4080-a245-eb1e03c02b9b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51baffb9-2249-4080-a245-eb1e03c02b9b@intel.com>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 12:12:08PM +0100, Andrzej Hajda wrote:
> On 28.11.2023 04:47, Paz Zcharya wrote:
> > 
> > On Mon, Nov 27, 2023 at 8:20 PM Paz Zcharya <pazz@chromium.org> wrote:
> > > 
> > > On 21.11.2023 13:06, Andrzej Hajda wrote:
> > > 
> > > > The simplest approach would be then do the same as in case of DGFX:
> > > >           gen8_pte_t __iomem *gte = to_gt(i915)->ggtt->gsm;
> > > >           gen8_pte_t pte;
> > > > 
> > > >           gte += base / I915_GTT_PAGE_SIZE;
> > > > 
> > > >           pte = ioread64(gte);
> > > >           phys_base = pte & I915_GTT_PAGE_MASK;
> > > > 
> > > > Regards
> > > > Andrzej
> > 
> > Hey Andrzej,
> > 
> > On a second thought, what do you think about something like
> > 
> > +               gen8_pte_t __iomem *gte = to_gt(i915)->ggtt->gsm;
> > +               gen8_pte_t pte;
> > +               gte += base / I915_GTT_PAGE_SIZE;
> > +               pte = ioread64(gte);
> > +               pte = pte & I915_GTT_PAGE_MASK;
> > +               phys_base = pte - i915->mm.stolen_region->region.start;
> > 
> > The only difference is the last line.
> 
> Bingo :) It seems to be generic algorithm to get phys_base for all
> platforms:
> - on older platforms stolen_region points to system memory which starts at
> 0,
> - on DG2 it uses lmem region which starts at 0 as well,
> - on MTL stolen_region points to stolen-local which starts at 0x800000.
> 
> So this whole "if (IS_DGFX(i915)) {...} else {...}" could be replaced
> with sth generic.
> 1. Find pte.
> 2. if(IS_DGFX(i915) && pte & GEN12_GGTT_PTE_LM) mem =
> i915->mm.regions[INTEL_REGION_LMEM_0] else mem = i915->mm.stolen_region
> 3. phys_base = (pte & I915_GTT_PAGE_MASK) - mem->region.start;
> 
> Regards
> Andrzej
> 
> 

Hey Andrzej,

I uploaded https://patchwork.freedesktop.org/series/127130/ based on
algorithm. Please take a look and let me know if you'd like me to change
anything.

Really appreciate all of your help!


Best,
Paz

