Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FC27EFBFA
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 00:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346294AbjKQXB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 18:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKQXB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 18:01:56 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FC4D5D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 15:01:53 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-7789a4c01easo158539285a.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 15:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700262113; x=1700866913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fVbP8CyiBZehwmNjDxKXZZtGdp94/xgeZ0x/AluKOVY=;
        b=jBERjtnFnYP+S/cXwh6gwJWuxTWSAX67nuaxmdm/76f4sF0uWucMimCTu1ifpNET4Q
         rvw4KfhdmlLzJ4hz0k8Ya3ryy/pWjRmjmabUcbFF7NnFxH5P9DdxQ8bmJbkFNiIRNvfS
         Dkbq/7z8VoqnD0TvZiGHO7tPcPVyP0MpFDlFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700262113; x=1700866913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVbP8CyiBZehwmNjDxKXZZtGdp94/xgeZ0x/AluKOVY=;
        b=LVTLy8YQJFMo1HVvMpCpE9kqcAQxt6RH7leTwIo0aB04x1jhHQbB9TA4Wz3sU04JKV
         r/JBnxIaOoo61BBrLLmjHiunP8LhiISCafq8jcJdvFVS7y+SLLCERkt5btt5T+9cR3sE
         Clt3Jp2Yt0edSDkjNPR73F0gsBwOdXleraZVIIhU88qAWOdpQcST6TpkaYgismJfdTcc
         dMgA8joG68hK2RU8V+kvu0N8nmbHNmWzMY+wrnAgMgWr2TQOLnomfxulgYm5gb38k8DG
         YyiasOB+V/0xaqbEVLeMEb0p05n5grR5PVtr/WDKkhpE+ggz396fgPaAfa1n974C0fec
         pUmA==
X-Gm-Message-State: AOJu0YzSHw8p6eL8GQYnbBoGoY6+meLkFlGGf451xOa81ICL4Et2xbuR
        R9aseJZ1W6gQwme1RFthBPI0/g==
X-Google-Smtp-Source: AGHT+IGo/j+JjI7nVgbEx1Oh0K7fiN+Cgcz8UA9x0+i23g0mH+S4fJxvJq/lN51n2QT7YE/f9oL0bA==
X-Received: by 2002:a05:620a:4541:b0:778:9148:3c2c with SMTP id u1-20020a05620a454100b0077891483c2cmr1044309qkp.18.1700262112282;
        Fri, 17 Nov 2023 15:01:52 -0800 (PST)
Received: from google.com (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id rr7-20020a05620a678700b0076cc0a6e127sm936543qkn.116.2023.11.17.15.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 15:01:51 -0800 (PST)
Date:   Fri, 17 Nov 2023 23:01:50 +0000
From:   Paz Zcharya <pazz@chromium.org>
To:     Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     matthew.auld@intel.com, Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Subrata Banik <subratabanik@google.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Sean Paul <seanpaul@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Marcin Wojtas <mwojtas@chromium.org>,
        Drew Davenport <ddavenport@chromium.org>,
        David Airlie <airlied@gmail.com>,
        intel-gfx@lists.freedesktop.org, Nirmoy Das <nirmoy.das@intel.com>
Subject: Re: [Intel-gfx] [PATCH] drm/i915/display: Fix phys_base to be
 relative not absolute
Message-ID: <ZVfw3ghfBLdHB7uk@google.com>
References: <20231105172718.18673-1-pazz@chromium.org>
 <ZVQ3d8FFqxsy0OX7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVQ3d8FFqxsy0OX7@intel.com>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 10:13:59PM -0500, Rodrigo Vivi wrote:
> On Sun, Nov 05, 2023 at 05:27:03PM +0000, Paz Zcharya wrote:
> > Fix the value of variable `phys_base` to be the relative offset in
> > stolen memory, and not the absolute offset of the GSM.
> 
> to me it looks like the other way around. phys_base is the physical
> base address for the frame_buffer. Setting it to zero doesn't seem
> to make that relative. And also doesn't look right.
>
> > 
> > Currently, the value of `phys_base` is set to "Surface Base Address,"
> > which in the case of Meter Lake is 0xfc00_0000.
> 
> I don't believe this is a fixed value. IIRC this comes from the register
> set by video bios, where the idea is to reuse the fb that was used so
> far.
> 
> With this in mind I don't understand how that could overflow. Maybe
> the size of the stolen is not right? maybe the size? maybe different
> memory region?
>

Hi Rodrigo, thanks for the great comments.

Apologies for using a wrong/confusing terminology. I think 'phys_base'
is supposed to be the offset in the GEM BO, where base (or
"Surface Base Address") is supposed to be the GTT offset.

Other than what I wrote before, I noticed that the function 'i915_vma_pin'
which calls to 'i915_gem_gtt_reserve' is the one that binds the right
address space in the GTT for that stolen region.

I see that in the function 'i915_vma_insert' (full call stack below),
where if (flags & PIN_OFFSET_FIXED), then when calling 'i915_gem_gtt_reserve'
we add an offset.

Specifically in MeteorLake, and specifically when using GOP driver, this
offset is equal to 0xfc00_0000. But as you mentioned, this is not strict.

The if statement always renders true because in the function
'initial_plane_vma' we always set
pinctl = PIN_GLOBAL | PIN_OFFSET_FIXED | base;
where pinctl == flags (see file 'intel_plane_initial.c' line 145).

Call stack:
drm_mm_reserve_node
i915_gem_gtt_reserve
	i915_vma_insert
i915_vma_pin_ww
i915_vma_pin
initial_plane_vma
intel_alloc_initial_plane_obj
intel_find_initial_plane_obj

Therefore, I believe the variable 'phys_base' in the
function 'initial_plane_vma,' should be the the offset in the GEM BO
and not the GTT offset, and because the base is added later on
in the function 'i915_gem_gtt_reserve', this value should not be
equal to base and be 0.

Hope it makes more sense.

> > This causes the
> > function `i915_gem_object_create_region_at` to fail in line 128, when
> > it attempts to verify that the range does not overflow:
> > 
> > if (range_overflows(offset, size, resource_size(&mem->region)))
> >       return ERR_PTR(-EINVAL);
> > 
> > where:
> >   offset = 0xfc000000
> >   size = 0x8ca000
> >   mem->region.end + 1 = 0x4400000
> >   mem->region.start = 0x800000
> >   resource_size(&mem->region) = 0x3c00000
> > 
> > call stack:
> >   i915_gem_object_create_region_at
> >   initial_plane_vma
> >   intel_alloc_initial_plane_obj
> >   intel_find_initial_plane_obj
> >   intel_crtc_initial_plane_config
> > 
> > Looking at the flow coming next, we see that `phys_base` is only used
> > once, in function `_i915_gem_object_stolen_init`, in the context of
> > the offset *in* the stolen memory. Combining that with an
> > examinination of the history of the file seems to indicate the
> > current value set is invalid.
> > 
> > call stack (functions using `phys_base`)
> >   _i915_gem_object_stolen_init
> >   __i915_gem_object_create_region
> >   i915_gem_object_create_region_at
> >   initial_plane_vma
> >   intel_alloc_initial_plane_obj
> >   intel_find_initial_plane_obj
> >   intel_crtc_initial_plane_config
> > 
> > [drm:_i915_gem_object_stolen_init] creating preallocated stolen
> > object: stolen_offset=0x0000000000000000, size=0x00000000008ca000
> > 
> > Signed-off-by: Paz Zcharya <pazz@chromium.org>
> > ---
> > 
> >  drivers/gpu/drm/i915/display/intel_plane_initial.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/display/intel_plane_initial.c b/drivers/gpu/drm/i915/display/intel_plane_initial.c
> > index a55c09cbd0e4..e696cb13756a 100644
> > --- a/drivers/gpu/drm/i915/display/intel_plane_initial.c
> > +++ b/drivers/gpu/drm/i915/display/intel_plane_initial.c
> > @@ -90,7 +90,7 @@ initial_plane_vma(struct drm_i915_private *i915,
> >  			"Using phys_base=%pa, based on initial plane programming\n",
> >  			&phys_base);
> >  	} else {
> > -		phys_base = base;
> > +		phys_base = 0;
> >  		mem = i915->mm.stolen_region;
> >  	}
> >  
> > -- 
> > 2.42.0.869.gea05f2083d-goog
> > 
