Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64FC07D74BF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 21:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjJYTt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 15:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjJYTt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 15:49:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B60186;
        Wed, 25 Oct 2023 12:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698263396; x=1729799396;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=6bjyCn+5RGDR80Oxqpw3WAaYkuJ8eyFL07jKhBVi4rA=;
  b=F7H5vgnLjZNnfCybWZh1/7tlYQk9jNN26dixy1wTEEmU3ufBTh8EhRrX
   DfHuTA2a7LauCeVXN7tOLGO3Gv1q3DCHDsJfpEIj+LhnYJ3lWVUB5NU8B
   m4mxPX3UCYJV+xBwlnmqyCVgVxrVuA+UzvFGO/Mkg5O5RhFA/NqieRykR
   YnGtCxX+MflOcaXdAncw9FhEQdWEBGF3l3bOF3Cu/WNUQ5ALkQClMBfDx
   vZPuquFmAA6z236R0mldplDC7vcpEmcaoq3Tcba7VUWiXb3KNwq8LzpcI
   4ehPuW+o5EV0dWwcR0wO+EWTgoo5nvZHMsgxO1anoaT4DakgiYoDZGW6n
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="377752950"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="377752950"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 12:49:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="735494248"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="735494248"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga006.jf.intel.com with SMTP; 25 Oct 2023 12:49:47 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 25 Oct 2023 22:49:46 +0300
Date:   Wed, 25 Oct 2023 22:49:46 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Keith Zhao <keith.zhao@starfivetech.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        Conor Dooley <conor+dt@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Emil Renner Berthing <kernel@esmil.dk>,
        christian.koenig@amd.com, Thomas Zimmermann <tzimmermann@suse.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Jagan Teki <jagan@edgeble.ai>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Shengyang Chen <shengyang.chen@starfivetech.com>,
        Changhuang Liang <changhuang.liang@starfivetech.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH v2 5/6] drm/vs: Add KMS crtc&plane
Message-ID: <ZTlxWiX7-vKeLQsc@intel.com>
References: <20231025103957.3776-1-keith.zhao@starfivetech.com>
 <20231025103957.3776-6-keith.zhao@starfivetech.com>
 <6db09f77-31e8-4f2e-a987-e3745d0e8c24@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6db09f77-31e8-4f2e-a987-e3745d0e8c24@linaro.org>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 10:28:56PM +0300, Dmitry Baryshkov wrote:
> On 25/10/2023 13:39, Keith Zhao wrote:
> > add 2 crtcs and 8 planes in vs-drm
> > 
> > Signed-off-by: Keith Zhao <keith.zhao@starfivetech.com>
> > ---
> >   drivers/gpu/drm/verisilicon/Makefile   |    8 +-
> >   drivers/gpu/drm/verisilicon/vs_crtc.c  |  257 ++++
> >   drivers/gpu/drm/verisilicon/vs_crtc.h  |   43 +
> >   drivers/gpu/drm/verisilicon/vs_dc.c    | 1002 ++++++++++++
> >   drivers/gpu/drm/verisilicon/vs_dc.h    |   80 +
> >   drivers/gpu/drm/verisilicon/vs_dc_hw.c | 1959 ++++++++++++++++++++++++
> >   drivers/gpu/drm/verisilicon/vs_dc_hw.h |  492 ++++++
> >   drivers/gpu/drm/verisilicon/vs_drv.c   |    2 +
> >   drivers/gpu/drm/verisilicon/vs_plane.c |  526 +++++++
> >   drivers/gpu/drm/verisilicon/vs_plane.h |   58 +
> >   drivers/gpu/drm/verisilicon/vs_type.h  |   69 +
> >   11 files changed, 4494 insertions(+), 2 deletions(-)
> >   create mode 100644 drivers/gpu/drm/verisilicon/vs_crtc.c
> >   create mode 100644 drivers/gpu/drm/verisilicon/vs_crtc.h
> >   create mode 100644 drivers/gpu/drm/verisilicon/vs_dc.c
> >   create mode 100644 drivers/gpu/drm/verisilicon/vs_dc.h
> >   create mode 100644 drivers/gpu/drm/verisilicon/vs_dc_hw.c
> >   create mode 100644 drivers/gpu/drm/verisilicon/vs_dc_hw.h
> >   create mode 100644 drivers/gpu/drm/verisilicon/vs_plane.c
> >   create mode 100644 drivers/gpu/drm/verisilicon/vs_plane.h
> >   create mode 100644 drivers/gpu/drm/verisilicon/vs_type.h
> > 
> > diff --git a/drivers/gpu/drm/verisilicon/Makefile b/drivers/gpu/drm/verisilicon/Makefile
> > index 7d3be305b..1d48016ca 100644
> > --- a/drivers/gpu/drm/verisilicon/Makefile
> > +++ b/drivers/gpu/drm/verisilicon/Makefile
> > @@ -1,7 +1,11 @@
> >   # SPDX-License-Identifier: GPL-2.0
> >   
> > -vs_drm-objs := vs_drv.o \
> > -		vs_modeset.o
> > +vs_drm-objs := vs_dc_hw.o \
> > +		vs_dc.o \
> > +		vs_crtc.o \
> > +		vs_drv.o \
> > +		vs_modeset.o \
> > +		vs_plane.o
> >   
> >   obj-$(CONFIG_DRM_VERISILICON) += vs_drm.o
> >   
> > diff --git a/drivers/gpu/drm/verisilicon/vs_crtc.c b/drivers/gpu/drm/verisilicon/vs_crtc.c
> > new file mode 100644
> > index 000000000..8a658ea77
> > --- /dev/null
> > +++ b/drivers/gpu/drm/verisilicon/vs_crtc.c
> > @@ -0,0 +1,257 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2023 VeriSilicon Holdings Co., Ltd.
> > + *
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/debugfs.h>
> > +#include <linux/media-bus-format.h>
> > +
> > +#include <drm/drm_atomic_helper.h>
> > +#include <drm/drm_atomic.h>
> > +#include <drm/drm_crtc.h>
> > +#include <drm/drm_gem_atomic_helper.h>
> > +#include <drm/drm_vblank.h>
> > +#include <drm/vs_drm.h>
> > +
> > +#include "vs_crtc.h"
> > +#include "vs_dc.h"
> > +#include "vs_drv.h"
> > +
> > +static void vs_crtc_reset(struct drm_crtc *crtc)
> > +{
> > +	struct vs_crtc_state *state;
> > +
> > +	if (crtc->state) {
> > +		__drm_atomic_helper_crtc_destroy_state(crtc->state);
> > +
> > +		state = to_vs_crtc_state(crtc->state);
> > +		kfree(state);
> > +		crtc->state = NULL;
> > +	}
> 
> You can call your crtc_destroy_state function directly here.
> 
> > +
> > +	state = kzalloc(sizeof(*state), GFP_KERNEL);
> > +	if (!state)
> > +		return;
> > +
> > +	__drm_atomic_helper_crtc_reset(crtc, &state->base);
> > +}
> > +
> > +static struct drm_crtc_state *
> > +vs_crtc_atomic_duplicate_state(struct drm_crtc *crtc)
> > +{
> > +	struct vs_crtc_state *ori_state;
> 
> It might be a matter of taste, but it is usually old_state.
> 
> > +	struct vs_crtc_state *state;
> > +
> > +	if (!crtc->state)
> > +		return NULL;
> > +
> > +	ori_state = to_vs_crtc_state(crtc->state);
> > +	state = kzalloc(sizeof(*state), GFP_KERNEL);
> > +	if (!state)
> > +		return NULL;
> > +
> > +	__drm_atomic_helper_crtc_duplicate_state(crtc, &state->base);
> > +
> > +	state->output_fmt = ori_state->output_fmt;
> > +	state->encoder_type = ori_state->encoder_type;
> > +	state->bpp = ori_state->bpp;
> > +	state->underflow = ori_state->underflow;
> 
> Can you use kmemdup instead?
> 
> > +
> > +	return &state->base;
> > +}
> > +
> > +static void vs_crtc_atomic_destroy_state(struct drm_crtc *crtc,
> > +					 struct drm_crtc_state *state)
> > +{
> > +	__drm_atomic_helper_crtc_destroy_state(state);
> > +	kfree(to_vs_crtc_state(state));
> > +}
> > +
> > +static int vs_crtc_enable_vblank(struct drm_crtc *crtc)
> > +{
> > +	struct vs_crtc *vs_crtc = to_vs_crtc(crtc);
> > +	struct vs_dc *dc = dev_get_drvdata(vs_crtc->dev);
> > +
> > +	vs_dc_enable_vblank(dc, true);
> > +
> > +	return 0;
> > +}
> > +
> > +static void vs_crtc_disable_vblank(struct drm_crtc *crtc)
> > +{
> > +	struct vs_crtc *vs_crtc = to_vs_crtc(crtc);
> > +	struct vs_dc *dc = dev_get_drvdata(vs_crtc->dev);
> > +
> > +	vs_dc_enable_vblank(dc, false);
> > +}
> > +
> > +static const struct drm_crtc_funcs vs_crtc_funcs = {
> > +	.set_config		= drm_atomic_helper_set_config,
> > +	.page_flip		= drm_atomic_helper_page_flip,
> 
> destroy is required, see drm_mode_config_cleanup()
> 
> > +	.reset			= vs_crtc_reset,
> > +	.atomic_duplicate_state = vs_crtc_atomic_duplicate_state,
> > +	.atomic_destroy_state	= vs_crtc_atomic_destroy_state,
> 
> please consider adding atomic_print_state to output driver-specific bits.
> 
> > +	.enable_vblank		= vs_crtc_enable_vblank,
> > +	.disable_vblank		= vs_crtc_disable_vblank,
> > +};
> > +
> > +static u8 cal_pixel_bits(u32 bus_format)
> 
> This looks like a generic helper code, which can go to a common place.
> 
> > +{
> > +	u8 bpp;
> > +
> > +	switch (bus_format) {
> > +	case MEDIA_BUS_FMT_RGB565_1X16:
> > +	case MEDIA_BUS_FMT_UYVY8_1X16:
> > +		bpp = 16;
> > +		break;
> > +	case MEDIA_BUS_FMT_RGB666_1X18:
> > +	case MEDIA_BUS_FMT_RGB666_1X24_CPADHI:
> > +		bpp = 18;
> > +		break;
> > +	case MEDIA_BUS_FMT_UYVY10_1X20:
> > +		bpp = 20;
> > +		break;
> > +	case MEDIA_BUS_FMT_BGR888_1X24:
> > +	case MEDIA_BUS_FMT_UYYVYY8_0_5X24:
> > +	case MEDIA_BUS_FMT_YUV8_1X24:
> > +		bpp = 24;
> > +		break;
> > +	case MEDIA_BUS_FMT_RGB101010_1X30:
> > +	case MEDIA_BUS_FMT_UYYVYY10_0_5X30:
> > +	case MEDIA_BUS_FMT_YUV10_1X30:
> > +		bpp = 30;
> > +		break;
> > +	default:
> > +		bpp = 24;
> > +		break;
> > +	}
> > +
> > +	return bpp;
> > +}
> > +
> > +static void vs_crtc_atomic_enable(struct drm_crtc *crtc,
> > +				  struct drm_atomic_state *state)
> > +{
> > +	struct vs_crtc *vs_crtc = to_vs_crtc(crtc);
> > +	struct vs_dc *dc = dev_get_drvdata(vs_crtc->dev);
> > +	struct vs_crtc_state *vs_crtc_state = to_vs_crtc_state(crtc->state);
> > +
> > +	vs_crtc_state->bpp = cal_pixel_bits(vs_crtc_state->output_fmt);
> > +
> > +	vs_dc_enable(dc, crtc);
> > +	drm_crtc_vblank_on(crtc);
> > +}
> > +
> > +static void vs_crtc_atomic_disable(struct drm_crtc *crtc,
> > +				   struct drm_atomic_state *state)
> > +{
> > +	struct vs_crtc *vs_crtc = to_vs_crtc(crtc);
> > +	struct vs_dc *dc = dev_get_drvdata(vs_crtc->dev);
> > +
> > +	drm_crtc_vblank_off(crtc);
> > +
> > +	vs_dc_disable(dc, crtc);
> > +
> > +	if (crtc->state->event && !crtc->state->active) {
> > +		spin_lock_irq(&crtc->dev->event_lock);
> > +		drm_crtc_send_vblank_event(crtc, crtc->state->event);
> > +		spin_unlock_irq(&crtc->dev->event_lock);
> > +
> > +		crtc->state->event = NULL;
> 
> I think even should be cleared within the lock.

event_lock doesn't protect anything in the crtc state.

But the bigger problem in this code is the prevalent crtc->state
usage. That should pretty much never be done, especially in anything
that can get called from the actual commit phase where you no longer
have the locks held. Instead one should almost always use the
get_{new,old}_state() stuff, or the old/new/oldnew state iterators.

> 
> > +	}
> > +}
> > +
> > +static void vs_crtc_atomic_begin(struct drm_crtc *crtc,
> > +				 struct drm_atomic_state *state)
> > +{
> > +	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
> > +									  crtc);
> > +
> > +	struct vs_crtc *vs_crtc = to_vs_crtc(crtc);
> > +	struct device *dev = vs_crtc->dev;
> > +	struct drm_property_blob *blob = crtc->state->gamma_lut;

Eg. here you are using drm_atomic_get_new_crtc_state() correctly, but
then proceed to directly access crtc->state anyway.

> > +	struct drm_color_lut *lut;
> > +	struct vs_dc *dc = dev_get_drvdata(dev);
> > +
> > +	if (crtc_state->color_mgmt_changed) {
> > +		if (blob && blob->length) {
> > +			lut = blob->data;
> > +			vs_dc_set_gamma(dc, crtc, lut,
> > +					blob->length / sizeof(*lut));
> > +			vs_dc_enable_gamma(dc, crtc, true);
> > +		} else {
> > +			vs_dc_enable_gamma(dc, crtc, false);
> > +		}
> > +	}
> > +}

-- 
Ville Syrjälä
Intel
