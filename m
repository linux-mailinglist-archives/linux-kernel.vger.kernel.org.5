Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3B97FAF79
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 02:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbjK1BUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 20:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjK1BUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 20:20:44 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5B21B6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 17:20:48 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-41ea8debcdaso25777141cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 17:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701134448; x=1701739248; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GzX49nF8SiWuVdK7w0akp5E0dTX8yBNhts9C+qDJdRw=;
        b=L0t5+hMpHMdTFUCr7AeNlWs8D4gPSduhDQbZYRu+dCK86qw1oX9f12o/n/ldtNoczN
         g2ZSsFXxbYBrL6DN/jUJgoF4TkpSdHwNgJSwzGWOlLISdYbkG/vihfBYQHvGLthIJdYj
         iK7rqzyXduvSGK+sjLZhmQ/1L7MAGfbI3aG7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701134448; x=1701739248;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GzX49nF8SiWuVdK7w0akp5E0dTX8yBNhts9C+qDJdRw=;
        b=Rr84cVHPlR9YclttvUFkiRApJs/4QhUxO/cQjpZ3A0SUdVe379sYWOiRm4YcPxjBIU
         QHfocJMKNp+0EsUH3LKAiIR1wlZvPIGO3+rVRwWj0FNezmvcKvKUrN+4zA71mDTiKGyW
         rK0TUuDcm3zw59A0wQu9BBD1XVQ//4F7xFiSOy8tnsqCuH7lb1HQOy+QIKT63ANY40MY
         D/koG2Ns6e1qSDmlwqr0R7f/5MU+yig+p/lLWfOqSe55shxL/7jrXE0VyrZ8zDzT/bAc
         afcBJ+ONBVhgfDKIPWG1pSWIXnjTDg2OE1bZfVhm/rYumU5atyAfCeoaBDPTPjAMXF/b
         eaWA==
X-Gm-Message-State: AOJu0YzZNfg4WoWLB2brurf4spkjFVbQUzMKuzcD0x9+93oBF9ajhJER
        R9oHQSNZ3N89yCB/nxVxMKrtyQ==
X-Google-Smtp-Source: AGHT+IFamZIO8hF8tkJZE9Bgro1qMB3ojDtG/Q6kH5rdkqNuliozgB+d17Mc6UL4xmrPk8OrBk4jNg==
X-Received: by 2002:a05:622a:6a89:b0:423:a31f:665a with SMTP id ih9-20020a05622a6a8900b00423a31f665amr7867879qtb.13.1701134448093;
        Mon, 27 Nov 2023 17:20:48 -0800 (PST)
Received: from google.com (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id z25-20020ac86b99000000b003f6ac526568sm4179813qts.39.2023.11.27.17.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 17:20:47 -0800 (PST)
Date:   Tue, 28 Nov 2023 01:20:46 +0000
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
Message-ID: <ZWVAbpzBq9wN2WFy@google.com>
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

On Wed, Nov 22, 2023 at 02:26:55PM +0100, Andrzej Hajda wrote:
> 
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
> >          gen8_pte_t __iomem *gte = to_gt(i915)->ggtt->gsm;
> >          gen8_pte_t pte;
> > 
> >          gte += base / I915_GTT_PAGE_SIZE;
> > 
> >          pte = ioread64(gte);
> >          phys_base = pte & I915_GTT_PAGE_MASK;
> > 
> > Regards
> > Andrzej
Hey Andrzej,

Sorry for the late response. I was OOO :)
I tried using the code you mentioned. It translates (in the very specific
case of MTL + GOP driver) to phys_base == 0080_0000h. Unfortunately, it
results in a corrupted screen -- the framebuffer is filled with zeros.

It seems like `i915_vma_pin_ww` already reserves and binds the GEM BO to the
correct address space independently of the value of `phys_base`.
The only thing `phys_base` affects is the value of `stolen->start`
https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/i915/gem/i915_gem_stolen.c#L747

So it seems to me that the maybe `phys_base` is named incorrectly and that it
does not reflect the physical address, but the start offset of
i915->mm.stolen_region.

I'm happy to run more tests / debug further.
Do you have more ideas of things to try?


Many thanks,
Paz
