Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148EC7FB949
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 12:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344527AbjK1LT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 06:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344124AbjK1LT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 06:19:28 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2136D6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 03:19:34 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-462bf380db8so1824781137.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 03:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701170374; x=1701775174; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bCnoZKgpcEhOGCM5lZjXBdwz27cftHLpr/W77wEAkbk=;
        b=QLTkKrhsbZKx7TkYKjao9rP3Z48bnx4LI+O1SmR/pn94fMqJiB9R1+Y28+9lH8m0XC
         8xyuTkVdIKG0ceIMqE+JGSpNWqnpPTyL3abpsLt4z0pouBikoPRr6ngYY2eUDBV5bavu
         hE0t2TwEpf6wmhbAvjltDh2kckliCHlH/t2n8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701170374; x=1701775174;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bCnoZKgpcEhOGCM5lZjXBdwz27cftHLpr/W77wEAkbk=;
        b=Z2ZHFrfuAPH79oHVlzKkPWYj9HJqwEBPj+Qkzhp55VmbcGDbb6Fm8oYTNUIfTHqfdc
         CBJM2EY9T2wDkTilR2M9tSaF35m7vS7K+6aZFbBuqBJ0yjpCdyDFoMwoet2XSLH3rQtH
         7Kgxy4hBJQxR4PbL8dI2oxiuv3Fp8zp0qXUnfEraEZqdecdyd7cqvomI430yfxDZFjZV
         gPeryCxuRgv3Ul/f6xaQaoPIEw3hZ0l2PCinlEmK/GWNNZyI3UFsMBf7Kv8DQQg094X4
         itLVNuQoACbKKe5b91AAYgMeY6us/J5F6gDqPHEvwWhkK0tVT6QnrH9OJjLvSrxHNo3z
         tNJQ==
X-Gm-Message-State: AOJu0YzGfSXnjYXMilz/A2UiQ/BeRcpW1B5DQlaZRq++LcY+dXbrpDfD
        tQ6NE3+9t8mhSRUNE3fc+GZCeQ==
X-Google-Smtp-Source: AGHT+IH87Ag0JlT90Hx66H+qK+YLeNQoRQwoQQDAx90SCLVYeMakySpUwE7/cgjUOuOsUEPWnqz5xw==
X-Received: by 2002:a05:6102:34f5:b0:45f:bab9:4414 with SMTP id bi21-20020a05610234f500b0045fbab94414mr16425679vsb.24.1701170373973;
        Tue, 28 Nov 2023 03:19:33 -0800 (PST)
Received: from google.com (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id dw12-20020a0562140a0c00b0067a1c7d8e98sm3852798qvb.41.2023.11.28.03.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 03:19:33 -0800 (PST)
Date:   Tue, 28 Nov 2023 11:19:32 +0000
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
Message-ID: <ZWXMxLPIwXgwbEkz@google.com>
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

Good stuff!! I'll work on this revision and resubmit.

Thank you so much Andrzej!

