Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014FA7DE40D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343579AbjKAPpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKAPpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:45:16 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571F5E4
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 08:45:10 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id af79cd13be357-7789923612dso476579785a.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 08:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698853509; x=1699458309; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gIfqH98KQfCzIopKfr9kAVM80xJQ3s0Sgl61/jXKJYs=;
        b=RY9L4PF2yOe9yxBoAfJguZg4Ce+e4LGyQn8lhkSQR+lxjbKm8LDxp1fojb6lChCENh
         3OUXvIsFfJ3D8U900hjS1wcSK6SWcTTRdt5XsSYCS5YTz0eYeXDhIy1x1DARfAg2Mtap
         K//g5Fxbg/1HcfzEKoGqWdV0BTJAPElEiDhN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698853509; x=1699458309;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gIfqH98KQfCzIopKfr9kAVM80xJQ3s0Sgl61/jXKJYs=;
        b=WoiuUWq59NllEQmNOueHo1oE4IY5dVtGAOFkaxPsA0PqxStbCI5HfCu7QXzy0e1Ras
         aP4Kogi/HXUnxGYx71cIIWgC8yHgqQ/1b6wKpiH67B7aVsv0CRfeYhS7wRNVOBwtMXld
         mIITqm1XWBwPvaQCsB88mARhJ3ST5G0hUEI+WDgdCWKdDTuhnQ2MkGfsaTx+1SMuS/az
         xm8h6szIo6y6D9Z9s+NHE4T+8iUtIqsP1T3oAAsjQmlwgvE2BHIE8ZhL5QANPiPcOcZo
         pLOxlccfMp4Fi2w0W/u8inXJKAIJ3TvJx5NZJyJtZNpSFfBXPawgdzHxW1Hd6vTGzs3t
         ZV0g==
X-Gm-Message-State: AOJu0YxFNuXZz/XN0+Kzbz+odmOdBi+YO76/Y9/F3bv6oYCrvkxp5Kjo
        vB+Q/x6tCkclHyzljgJBpKeDMA==
X-Google-Smtp-Source: AGHT+IGM+2P898z+SZcGBovYltLuISbCjX5nlXQKdkNDMk9cYXHlOihGD1Vz7JjUGF9bFecCgFXw8Q==
X-Received: by 2002:a05:6214:248f:b0:66d:33c1:3750 with SMTP id gi15-20020a056214248f00b0066d33c13750mr17261948qvb.49.1698853509327;
        Wed, 01 Nov 2023 08:45:09 -0700 (PDT)
Received: from google.com (129.177.85.34.bc.googleusercontent.com. [34.85.177.129])
        by smtp.gmail.com with ESMTPSA id s7-20020ad45007000000b0065afe284b3csm1569209qvo.125.2023.11.01.08.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 08:45:08 -0700 (PDT)
Date:   Wed, 1 Nov 2023 15:45:07 +0000
From:   Paz Zcharya <pazz@chromium.org>
To:     "Hogander, Jouni" <jouni.hogander@intel.com>
Cc:     "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        "tvrtko.ursulin@linux.intel.com" <tvrtko.ursulin@linux.intel.com>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "navaremanasi@chromium.org" <navaremanasi@chromium.org>,
        "Almahallawy, Khaled" <khaled.almahallawy@intel.com>,
        "Banik, Subrata" <subratabanik@google.com>,
        "Kandpal, Suraj" <suraj.kandpal@intel.com>,
        "Coelho, Luciano" <luciano.coelho@intel.com>,
        "Roper, Matthew D" <matthew.d.roper@intel.com>,
        "ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Hajda, Andrzej" <andrzej.hajda@intel.com>,
        "ddavenport@chromium.org" <ddavenport@chromium.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Lisovskiy, Stanislav" <stanislav.lisovskiy@intel.com>,
        "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>,
        "Shankar, Uma" <uma.shankar@intel.com>,
        "Souza, Jose" <jose.souza@intel.com>,
        "Kahola, Mika" <mika.kahola@intel.com>,
        "airlied@gmail.com" <airlied@gmail.com>
Subject: Re: [PATCH] drm/i915/display: Only fail fastset on PSR2
Message-ID: <ZUJsUf9f0OA2e6fP@google.com>
References: <20231031232245.1331194-1-pazz@google.com>
 <4cff3a2f0b286fe166a6c1fe0434d34489c34f6a.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4cff3a2f0b286fe166a6c1fe0434d34489c34f6a.camel@intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 06:26:47AM +0000, Hogander, Jouni wrote:
> On Tue, 2023-10-31 at 23:21 +0000, Paz Zcharya wrote:
> > Currently, i915 fails fastset if both the sink and the source support
> > any version of PSR and regardless of the configuration setting of the
> > driver (i.e., i915.enable_psr kernel argument). However, the
> > implementation of PSR1 enable sequence is already seamless
> > and works smoothly with fastset. Accordingly, do not fail fastset
> > if PSR2 is not enabled.
> 
> Thank you for the patch. Check similar patch I sent some time ago to
> trybot:
> 
> https://patchwork.freedesktop.org/series/125392/
> 

I missed this patch. I apologize!
This is great work and exactly what we (Google ChromeOS) need.
I think your patch is better than mine, so let's abort my patch
and continue the discussion at series/125392.

By the way, we have verified your patch on two Meteor Lake devices
running ChromeOS and it works smoothly (no flickering or modesets).
I'll comment on the other patch as well.

> If we want to temporarily do this only for psr1 I think you could check
> what I've done in drivers/gpu/drm/i915/display/intel_display.c in my
> patch and modify your patch accordingly. Otherwise e.g. our IGT
> testcases which are toggling PSR enable/disable/psr1/psr2 are to my
> understanding performing full modeset and possible issues are not
> revealed.
> 
> After modifying drivers/gpu/drm/i915/display/intel_display.c you can
> also verify it is really seamless and smooth by toggling different PSR
> states via /sys/kernel/debug/dri/0/i915_edp_psr_debug. That interface
> is performing atomic commit when PSR mode is changed.
> 
> BR,
> 
> Jouni Högander
> > 
> > Signed-off-by: Paz Zcharya <pazz@google.com>
> > ---
> > 
> >  drivers/gpu/drm/i915/display/intel_dp.c  | 4 ++--
> >  drivers/gpu/drm/i915/display/intel_psr.c | 2 +-
> >  drivers/gpu/drm/i915/display/intel_psr.h | 1 +
> >  3 files changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/display/intel_dp.c
> > b/drivers/gpu/drm/i915/display/intel_dp.c
> > index e0e4cb529284..a1af96e31518 100644
> > --- a/drivers/gpu/drm/i915/display/intel_dp.c
> > +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> > @@ -2584,8 +2584,8 @@ bool intel_dp_initial_fastset_check(struct
> > intel_encoder *encoder,
> >                 fastset = false;
> >         }
> >  
> > -       if (CAN_PSR(intel_dp)) {
> > -               drm_dbg_kms(&i915->drm, "[ENCODER:%d:%s] Forcing full
> > modeset to compute PSR state\n",
> > +       if (CAN_PSR(intel_dp) && psr2_global_enabled(intel_dp)) {
> > +               drm_dbg_kms(&i915->drm, "[ENCODER:%d:%s] Forcing full
> > modeset due to PSR2\n",
> >                             encoder->base.base.id, encoder-
> > >base.name);
> >                 crtc_state->uapi.mode_changed = true;
> >                 fastset = false;
> > diff --git a/drivers/gpu/drm/i915/display/intel_psr.c
> > b/drivers/gpu/drm/i915/display/intel_psr.c
> > index 97d5eef10130..388bc3246db9 100644
> > --- a/drivers/gpu/drm/i915/display/intel_psr.c
> > +++ b/drivers/gpu/drm/i915/display/intel_psr.c
> > @@ -187,7 +187,7 @@ static bool psr_global_enabled(struct intel_dp
> > *intel_dp)
> >         }
> >  }
> >  
> > -static bool psr2_global_enabled(struct intel_dp *intel_dp)
> > +bool psr2_global_enabled(struct intel_dp *intel_dp)
> >  {
> >         struct drm_i915_private *i915 = dp_to_i915(intel_dp);
> >  
> > diff --git a/drivers/gpu/drm/i915/display/intel_psr.h
> > b/drivers/gpu/drm/i915/display/intel_psr.h
> > index 0b95e8aa615f..6f3c36389cd3 100644
> > --- a/drivers/gpu/drm/i915/display/intel_psr.h
> > +++ b/drivers/gpu/drm/i915/display/intel_psr.h
> > @@ -21,6 +21,7 @@ struct intel_encoder;
> >  struct intel_plane;
> >  struct intel_plane_state;
> >  
> > +bool psr2_global_enabled(struct intel_dp *intel_dp);
> >  void intel_psr_init_dpcd(struct intel_dp *intel_dp);
> >  void intel_psr_pre_plane_update(struct intel_atomic_state *state,
> >                                 struct intel_crtc *crtc);
> 

.
