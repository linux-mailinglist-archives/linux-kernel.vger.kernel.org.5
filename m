Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D855B75C632
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 13:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjGUL5n convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 21 Jul 2023 07:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjGUL5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 07:57:42 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83FA2130;
        Fri, 21 Jul 2023 04:57:35 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id CD5D824DD54;
        Fri, 21 Jul 2023 19:57:25 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 21 Jul
 2023 19:57:25 +0800
Received: from [192.168.60.102] (180.164.60.184) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 21 Jul
 2023 19:57:25 +0800
Message-ID: <a8c51143-01cb-a95f-bfbd-16827325934e@starfivetech.com>
Date:   Fri, 21 Jul 2023 19:57:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6/9] drm/verisilicon: Add drm crtc funcs
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <linaro-mm-sig@lists.linaro.org>
CC:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Emil Renner Berthing" <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        <christian.koenig@amd.com>, Bjorn Andersson <andersson@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>, Jagan Teki <jagan@edgeble.ai>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        "Shengyang Chen" <shengyang.chen@starfivetech.com>,
        Changhuang Liang <changhuang.liang@starfivetech.com>
References: <20230602074043.33872-1-keith.zhao@starfivetech.com>
 <20230602074043.33872-7-keith.zhao@starfivetech.com>
 <07cc89a5-5200-72e6-f078-694c5820a99a@suse.de>
From:   Keith Zhao <keith.zhao@starfivetech.com>
In-Reply-To: <07cc89a5-5200-72e6-f078-694c5820a99a@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS065.cuchost.com (172.16.6.25) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/30 19:55, Thomas Zimmermann wrote:
> Hi
> 
> Am 02.06.23 um 09:40 schrieb Keith Zhao:
>> Add crtc driver which implements crtc related operation functions.
>>
>> Signed-off-by: Keith Zhao <keith.zhao@starfivetech.com>
>> ---
>>   drivers/gpu/drm/verisilicon/Makefile  |   1 +
>>   drivers/gpu/drm/verisilicon/vs_crtc.c | 388 ++++++++++++++++++++++++++
>>   drivers/gpu/drm/verisilicon/vs_crtc.h |  74 +++++
>>   drivers/gpu/drm/verisilicon/vs_type.h |  72 +++++
>>   4 files changed, 535 insertions(+)
>>   create mode 100644 drivers/gpu/drm/verisilicon/vs_crtc.c
>>   create mode 100644 drivers/gpu/drm/verisilicon/vs_crtc.h
>>   create mode 100644 drivers/gpu/drm/verisilicon/vs_type.h
>>
>> diff --git a/drivers/gpu/drm/verisilicon/Makefile b/drivers/gpu/drm/verisilicon/Makefile
>> index 38254dc5d98d..bae5fbab9bbb 100644
>> --- a/drivers/gpu/drm/verisilicon/Makefile
>> +++ b/drivers/gpu/drm/verisilicon/Makefile
>> @@ -1,6 +1,7 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>     vs_drm-objs := vs_drv.o \
>> +        vs_crtc.o \
>>           vs_fb.o \
>>           vs_gem.o
>>   diff --git a/drivers/gpu/drm/verisilicon/vs_crtc.c b/drivers/gpu/drm/verisilicon/vs_crtc.c
>> new file mode 100644
>> index 000000000000..a9e742d7bd1a
>> --- /dev/null
>> +++ b/drivers/gpu/drm/verisilicon/vs_crtc.c
>> @@ -0,0 +1,388 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2023 VeriSilicon Holdings Co., Ltd.
>> + *
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/debugfs.h>
>> +#include <linux/media-bus-format.h>
>> +
>> +#include <drm/drm_atomic_helper.h>
>> +#include <drm/drm_atomic.h>
>> +#include <drm/drm_crtc.h>
>> +#include <drm/drm_gem_atomic_helper.h>
>> +#include <drm/drm_vblank.h>
>> +#include <drm/vs_drm.h>
>> +
>> +#include "vs_crtc.h"
>> +
>> +void vs_crtc_destroy(struct drm_crtc *crtc)
>> +{
>> +    struct vs_crtc *vs_crtc = to_vs_crtc(crtc);
>> +
>> +    drm_crtc_cleanup(crtc);
>> +    kfree(vs_crtc);
>> +}
>> +
>> +static void vs_crtc_reset(struct drm_crtc *crtc)
>> +{
>> +    struct vs_crtc_state *state;
>> +
>> +    if (crtc->state) {
>> +        __drm_atomic_helper_crtc_destroy_state(crtc->state);
>> +
>> +        state = to_vs_crtc_state(crtc->state);
>> +        kfree(state);
>> +        crtc->state = NULL;
>> +    }
>> +
>> +    state = kzalloc(sizeof(*state), GFP_KERNEL);
>> +    if (!state)
>> +        return;
>> +
>> +    __drm_atomic_helper_crtc_reset(crtc, &state->base);
>> +
>> +    state->sync_mode = VS_SINGLE_DC;
>> +    state->output_fmt = MEDIA_BUS_FMT_RBG888_1X24;
>> +    state->encoder_type = DRM_MODE_ENCODER_NONE;
>> +}
>> +
>> +static struct drm_crtc_state *
>> +vs_crtc_atomic_duplicate_state(struct drm_crtc *crtc)
>> +{
>> +    struct vs_crtc_state *ori_state;
>> +    struct vs_crtc_state *state;
>> +
>> +    if (WARN_ON(!crtc->state))
>> +        return NULL;
> 
> I'd leave this check out. IIRC, crtc->state not supposed to be NULL here. Rather let it crash.
> 
>> +
>> +    ori_state = to_vs_crtc_state(crtc->state);
>> +    state = kzalloc(sizeof(*state), GFP_KERNEL);
>> +    if (!state)
>> +        return NULL;
>> +
>> +    __drm_atomic_helper_crtc_duplicate_state(crtc, &state->base);
>> +
>> +    state->sync_mode = ori_state->sync_mode;
>> +    state->output_fmt = ori_state->output_fmt;
>> +    state->encoder_type = ori_state->encoder_type;
>> +    state->bg_color = ori_state->bg_color;
>> +    state->bpp = ori_state->bpp;
>> +    state->sync_enable = ori_state->sync_enable;
>> +    state->dither_enable = ori_state->dither_enable;
>> +    state->underflow = ori_state->underflow;
>> +
>> +    return &state->base;
>> +}
>> +
>> +static void vs_crtc_atomic_destroy_state(struct drm_crtc *crtc,
>> +                     struct drm_crtc_state *state)
>> +{
>> +    __drm_atomic_helper_crtc_destroy_state(state);
>> +    kfree(to_vs_crtc_state(state));
>> +}
>> +
>> +static int vs_crtc_atomic_set_property(struct drm_crtc *crtc,
>> +                       struct drm_crtc_state *state,
>> +                       struct drm_property *property,
>> +                       uint64_t val)
>> +{
>> +    struct vs_crtc *vs_crtc = to_vs_crtc(crtc);
>> +    struct vs_crtc_state *vs_crtc_state = to_vs_crtc_state(state);
>> +
>> +    if (property == vs_crtc->sync_mode)
>> +        vs_crtc_state->sync_mode = val;
>> +    else if (property == vs_crtc->mmu_prefetch)
>> +        vs_crtc_state->mmu_prefetch = val;
>> +    else if (property == vs_crtc->bg_color)
>> +        vs_crtc_state->bg_color = val;
>> +    else if (property == vs_crtc->panel_sync)
>> +        vs_crtc_state->sync_enable = val;
>> +    else if (property == vs_crtc->dither)
>> +        vs_crtc_state->dither_enable = val;
>> +    else
>> +        return -EINVAL;
>> +
>> +    return 0;
>> +}
>> +
>> +static int vs_crtc_atomic_get_property(struct drm_crtc *crtc,
>> +                       const struct drm_crtc_state *state,
>> +                       struct drm_property *property,
>> +                       uint64_t *val)
>> +{
>> +    struct vs_crtc *vs_crtc = to_vs_crtc(crtc);
>> +    const struct vs_crtc_state *vs_crtc_state =
>> +        container_of(state, const struct vs_crtc_state, base);
>> +
>> +    if (property == vs_crtc->sync_mode)
>> +        *val = vs_crtc_state->sync_mode;
>> +    else if (property == vs_crtc->mmu_prefetch)
>> +        *val = vs_crtc_state->mmu_prefetch;
>> +    else if (property == vs_crtc->bg_color)
>> +        *val = vs_crtc_state->bg_color;
>> +    else if (property == vs_crtc->panel_sync)
>> +        *val = vs_crtc_state->sync_enable;
>> +    else if (property == vs_crtc->dither)
>> +        *val = vs_crtc_state->dither_enable;
>> +    else
>> +        return -EINVAL;
>> +
>> +    return 0;
>> +}
>> +
>> +static int vs_crtc_late_register(struct drm_crtc *crtc)
>> +{
>> +    return 0;
>> +}
>> +
>> +static int vs_crtc_enable_vblank(struct drm_crtc *crtc)
>> +{
>> +    struct vs_crtc *vs_crtc = to_vs_crtc(crtc);
>> +
>> +    vs_crtc->funcs->enable_vblank(vs_crtc->dev, true);
>> +
>> +    return 0;
>> +}
>> +
>> +static void vs_crtc_disable_vblank(struct drm_crtc *crtc)
>> +{
>> +    struct vs_crtc *vs_crtc = to_vs_crtc(crtc);
>> +
>> +    vs_crtc->funcs->enable_vblank(vs_crtc->dev, false);
>> +}
>> +
>> +static const struct drm_crtc_funcs vs_crtc_funcs = {
>> +    .set_config        = drm_atomic_helper_set_config,
>> +    .destroy        = vs_crtc_destroy,
>> +    .page_flip        = drm_atomic_helper_page_flip,
>> +    .reset            = vs_crtc_reset,
>> +    .atomic_duplicate_state = vs_crtc_atomic_duplicate_state,
>> +    .atomic_destroy_state    = vs_crtc_atomic_destroy_state,
>> +    .atomic_set_property    = vs_crtc_atomic_set_property,
>> +    .atomic_get_property    = vs_crtc_atomic_get_property,
>> +    .late_register        = vs_crtc_late_register,
>> +    .enable_vblank        = vs_crtc_enable_vblank,
>> +    .disable_vblank        = vs_crtc_disable_vblank,
>> +};
>> +
>> +static u8 cal_pixel_bits(u32 bus_format)
>> +{
>> +    u8 bpp;
>> +
>> +    switch (bus_format) {
>> +    case MEDIA_BUS_FMT_RGB565_1X16:
>> +    case MEDIA_BUS_FMT_UYVY8_1X16:
>> +        bpp = 16;
>> +        break;
>> +    case MEDIA_BUS_FMT_RGB666_1X18:
>> +    case MEDIA_BUS_FMT_RGB666_1X24_CPADHI:
>> +        bpp = 18;
>> +        break;
>> +    case MEDIA_BUS_FMT_UYVY10_1X20:
>> +        bpp = 20;
>> +        break;
>> +    case MEDIA_BUS_FMT_BGR888_1X24:
>> +    case MEDIA_BUS_FMT_UYYVYY8_0_5X24:
>> +    case MEDIA_BUS_FMT_YUV8_1X24:
>> +        bpp = 24;
>> +        break;
>> +    case MEDIA_BUS_FMT_RGB101010_1X30:
>> +    case MEDIA_BUS_FMT_UYYVYY10_0_5X30:
>> +    case MEDIA_BUS_FMT_YUV10_1X30:
>> +        bpp = 30;
>> +        break;
>> +    default:
>> +        bpp = 24;
>> +        break;
>> +    }
>> +
>> +    return bpp;
>> +}
>> +
>> +static bool vs_crtc_mode_fixup(struct drm_crtc *crtc,
>> +                   const struct drm_display_mode *mode,
>> +                   struct drm_display_mode *adjusted_mode)
>> +{
>> +    struct vs_crtc *vs_crtc = to_vs_crtc(crtc);
>> +
>> +    return vs_crtc->funcs->mode_fixup(vs_crtc->dev, mode, adjusted_mode);
>> +}
>> +
>> +static void vs_crtc_atomic_enable(struct drm_crtc *crtc,
>> +                  struct drm_atomic_state *state)
>> +{
>> +    struct vs_crtc *vs_crtc = to_vs_crtc(crtc);
>> +    struct vs_crtc_state *vs_crtc_state = to_vs_crtc_state(crtc->state);
>> +
>> +    vs_crtc_state->bpp = cal_pixel_bits(vs_crtc_state->output_fmt);
>> +
>> +    vs_crtc->funcs->enable(vs_crtc->dev, crtc);
>> +    drm_crtc_vblank_on(crtc);
>> +}
>> +
>> +static void vs_crtc_atomic_disable(struct drm_crtc *crtc,
>> +                   struct drm_atomic_state *state)
>> +{
>> +    struct vs_crtc *vs_crtc = to_vs_crtc(crtc);
>> +
>> +    drm_crtc_vblank_off(crtc);
>> +
>> +    vs_crtc->funcs->disable(vs_crtc->dev, crtc);
>> +
>> +    if (crtc->state->event && !crtc->state->active) {
>> +        spin_lock_irq(&crtc->dev->event_lock);
>> +        drm_crtc_send_vblank_event(crtc, crtc->state->event);
>> +        spin_unlock_irq(&crtc->dev->event_lock);
>> +
>> +        crtc->state->event = NULL;
>> +    }
>> +}
>> +
>> +static void vs_crtc_atomic_begin(struct drm_crtc *crtc,
>> +                 struct drm_atomic_state *state)
>> +{
>> +    struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
>> +                                      crtc);
>> +
>> +    struct vs_crtc *vs_crtc = to_vs_crtc(crtc);
>> +    struct device *dev = vs_crtc->dev;
>> +    struct drm_property_blob *blob = crtc->state->gamma_lut;
>> +    struct drm_color_lut *lut;
>> +
>> +    if (crtc_state->color_mgmt_changed) {
>> +        if (blob && blob->length) {
>> +            lut = blob->data;
>> +            vs_crtc->funcs->set_gamma(dev, crtc, lut,
>> +                          blob->length / sizeof(*lut));
>> +            vs_crtc->funcs->enable_gamma(dev, crtc, true);
>> +        } else {
>> +            vs_crtc->funcs->enable_gamma(dev, crtc, false);
>> +        }
>> +    }
>> +}
>> +
>> +static void vs_crtc_atomic_flush(struct drm_crtc *crtc,
>> +                 struct drm_atomic_state *state)
>> +{
>> +    struct vs_crtc *vs_crtc = to_vs_crtc(crtc);
>> +    struct drm_pending_vblank_event *event = crtc->state->event;
>> +
>> +    vs_crtc->funcs->commit(vs_crtc->dev);
>> +
>> +    if (event) {
>> +        WARN_ON(drm_crtc_vblank_get(crtc) != 0);
>> +
>> +        spin_lock_irq(&crtc->dev->event_lock);
>> +        drm_crtc_arm_vblank_event(crtc, event);
>> +        spin_unlock_irq(&crtc->dev->event_lock);
>> +        crtc->state->event = NULL;
>> +    }
>> +}
>> +
>> +static const struct drm_crtc_helper_funcs vs_crtc_helper_funcs = {
>> +    .mode_fixup = vs_crtc_mode_fixup,
>> +    .atomic_enable    = vs_crtc_atomic_enable,
>> +    .atomic_disable = vs_crtc_atomic_disable,
>> +    .atomic_begin    = vs_crtc_atomic_begin,
>> +    .atomic_flush    = vs_crtc_atomic_flush,
>> +};
>> +
>> +static const struct drm_prop_enum_list vs_sync_mode_enum_list[] = {
>> +    { VS_SINGLE_DC,            "single dc mode" },
>> +    { VS_MULTI_DC_PRIMARY,        "primary dc for multi dc mode" },
>> +    { VS_MULTI_DC_SECONDARY,    "secondary dc for multi dc mode" },
>> +};
>> +
>> +struct vs_crtc *vs_crtc_create(struct drm_device *drm_dev,
>> +                   struct vs_dc_info *info)
>> +{
>> +    struct vs_crtc *crtc;
>> +    int ret;
>> +
>> +    if (!info)
>> +        return NULL;
>> +
>> +    crtc = kzalloc(sizeof(*crtc), GFP_KERNEL);
>> +    if (!crtc)
>> +        return NULL;
>> +
>> +    ret = drm_crtc_init_with_planes(drm_dev, &crtc->base,
>> +                    NULL, NULL, &vs_crtc_funcs,
>> +                    info->name ? info->name : NULL);
>> +    if (ret)
>> +        goto err_free_crtc;
>> +
>> +    drm_crtc_helper_add(&crtc->base, &vs_crtc_helper_funcs);
>> +
>> +    /* Set up the crtc properties */
>> +    if (info->pipe_sync) {
>> +        crtc->sync_mode = drm_property_create_enum(drm_dev, 0,
>> +                               "SYNC_MODE",
>> +                                vs_sync_mode_enum_list,
>> +                                ARRAY_SIZE(vs_sync_mode_enum_list));
>> +
>> +        if (!crtc->sync_mode)
>> +            goto err_cleanup_crts;
>> +
>> +        drm_object_attach_property(&crtc->base.base,
>> +                       crtc->sync_mode,
>> +                       VS_SINGLE_DC);
>> +    }
>> +
>> +    if (info->gamma_size) {
>> +        ret = drm_mode_crtc_set_gamma_size(&crtc->base,
>> +                           info->gamma_size);
>> +        if (ret)
>> +            goto err_cleanup_crts;
>> +
>> +        drm_crtc_enable_color_mgmt(&crtc->base, 0, false,
>> +                       info->gamma_size);
>> +    }
>> +
>> +    if (info->background) {
>> +        crtc->bg_color = drm_property_create_range(drm_dev, 0,
>> +                               "BG_COLOR", 0, 0xffffffff);
>> +
>> +        if (!crtc->bg_color)
>> +            goto err_cleanup_crts;
>> +
>> +        drm_object_attach_property(&crtc->base.base, crtc->bg_color, 0);
>> +    }
>> +
>> +    if (info->panel_sync) {
>> +        crtc->panel_sync = drm_property_create_bool(drm_dev, 0, "SYNC_ENABLED");
>> +
>> +        if (!crtc->panel_sync)
>> +            goto err_cleanup_crts;
>> +
>> +        drm_object_attach_property(&crtc->base.base, crtc->panel_sync, 0);
>> +    }
>> +
>> +    crtc->dither = drm_property_create_bool(drm_dev, 0, "DITHER_ENABLED");
>> +    if (!crtc->dither)
>> +        goto err_cleanup_crts;
>> +
>> +    drm_object_attach_property(&crtc->base.base, crtc->dither, 0);
>> +
>> +    crtc->max_bpc = info->max_bpc;
>> +    crtc->color_formats = info->color_formats;
>> +    return crtc;
>> +
>> +err_cleanup_crts:
>> +    drm_crtc_cleanup(&crtc->base);
>> +
>> +err_free_crtc:
>> +    kfree(crtc);
>> +    return NULL;
>> +}
>> +
>> +void vs_crtc_handle_vblank(struct drm_crtc *crtc, bool underflow)
>> +{
>> +    struct vs_crtc_state *vs_crtc_state = to_vs_crtc_state(crtc->state);
>> +
>> +    drm_crtc_handle_vblank(crtc);
>> +
>> +    vs_crtc_state->underflow = underflow;
>> +}
>> diff --git a/drivers/gpu/drm/verisilicon/vs_crtc.h b/drivers/gpu/drm/verisilicon/vs_crtc.h
>> new file mode 100644
>> index 000000000000..33b3b14249ce
>> --- /dev/null
>> +++ b/drivers/gpu/drm/verisilicon/vs_crtc.h
>> @@ -0,0 +1,74 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (C) 2023 VeriSilicon Holdings Co., Ltd.
>> + */
>> +
>> +#ifndef __VS_CRTC_H__
>> +#define __VS_CRTC_H__
>> +
>> +#include <drm/drm_crtc.h>
>> +#include <drm/drm_crtc_helper.h>
>> +
>> +#include "vs_type.h"
>> +
>> +struct vs_crtc_funcs {
>> +    void (*enable)(struct device *dev, struct drm_crtc *crtc);
>> +    void (*disable)(struct device *dev, struct drm_crtc *crtc);
>> +    bool (*mode_fixup)(struct device *dev,
>> +               const struct drm_display_mode *mode,
>> +               struct drm_display_mode *adjusted_mode);
>> +    void (*set_gamma)(struct device *dev, struct drm_crtc *crtc,
>> +              struct drm_color_lut *lut, unsigned int size);
>> +    void (*enable_gamma)(struct device *dev, struct drm_crtc *crtc,
>> +                 bool enable);
>> +    void (*enable_vblank)(struct device *dev, bool enable);
>> +    void (*commit)(struct device *dev);
>> +};
> 
> Why is this here? You are reproducing our interface with an internal interface. I know where this leads to: you have multiple chipset revisions and each has its own implemenation of these internal interfaces.
> 
> That will absolutely come back to haunt you in the long rung: the more chip revisions you support, the more obscure these internal interfaces and implentations become. And you won't be able to change these callbacks, as that affects all revisions. We've seen this with a few drivers. It will become unmaintainable.
> 
> A better approach is to treat DRM's atomic callback funcs and atomic helper funcs as your interface for each chip revision. So for each model, you implement a separate modesetting pipeline. When you add a new chip revision, you copy the previous chip's code into a new file and adopt it. If you find comon code among individual revisions, you can put it into a shared helper.  With this design, each chip revision stands on its own.
> 
> I suggest to study the mgag200 driver. It detects the chip revision very early and builds a chip-specific modesetting pipline. Although each chip is handled separately, a lot of shared code is in helpers. So the size of the driver remains small.
> 
hi Thomas:
I'm trying to understand what you're thinking

1. Different chip ids should have their own independent drm_dev, and should not be supported based on a same drm_dev.
2. diff chip id , for example dc8200 , dc9000,

struct vs_crtc_funcs {
	void (*enable)(struct device *dev, struct drm_crtc *crtc);
	void (*disable)(struct device *dev, struct drm_crtc *crtc);
	bool (*mode_fixup)(struct device *dev,
			   const struct drm_display_mode *mode,
			   struct drm_display_mode *adjusted_mode);
	void (*set_gamma)(struct device *dev, struct drm_crtc *crtc,
			  struct drm_color_lut *lut, unsigned int size);
	void (*enable_gamma)(struct device *dev, struct drm_crtc *crtc,
			     bool enable);
	void (*enable_vblank)(struct device *dev, bool enable);
	void (*commit)(struct device *dev);
};

static const struct vs_crtc_funcs vs_dc8200_crtc_funcs = {...}
static const struct vs_crtc_funcs vs_dc9200_crtc_funcs = {...}

struct vs_drm_private {
	struct drm_device base;
	struct device *dma_dev;
	struct iommu_domain *domain;
	unsigned int pitch_alignment;

	const struct vs_crtc_funcs *funcs;
};
for dc8200 vs_drm_bind  to make  funcs= &vs_dc8200_crtc_funcs 
for dc9000 vs_drm_bind  to make  funcs= &vs_dc9200_crtc_funcs 

so when run dc8200 modesetting pipline
I get drm_dev , get the funcs points ,  then I can call dc8200 internal interfaces . 

Welcome to correct my thoughts.
thanks
>> +
>> +struct vs_crtc_state {
>> +    struct drm_crtc_state base;
>> +
>> +    u32 sync_mode;
>> +    u32 output_fmt;
>> +    u32 bg_color;
>> +    u8 encoder_type;
>> +    u8 mmu_prefetch;
>> +    u8 bpp;
>> +    bool sync_enable;
>> +    bool dither_enable;
>> +    bool underflow;
>> +};
>> +
>> +struct vs_crtc {
>> +    struct drm_crtc base;
>> +    struct device *dev;
> 
> That's stored in base.dev already.
> 
>> +    struct drm_pending_vblank_event *event;
> 
> That's in drm_crtc_state.event already.
> 
>> +    unsigned int max_bpc;
>> +    unsigned int color_formats; /* supported color format */
> 
> These come from a vs_dc_info. Why not just store a pointer to the info instead?
> 
>> +
>> +    struct drm_property *sync_mode;
>> +    struct drm_property *mmu_prefetch;
>> +    struct drm_property *bg_color;
>> +    struct drm_property *panel_sync;
>> +    struct drm_property *dither;
>> +
>> +    const struct vs_crtc_funcs *funcs;
> 
> Please, see my rant why that's not a good idea.
> 
>> +};
>> +
>> +void vs_crtc_destroy(struct drm_crtc *crtc);
>> +
>> +struct vs_crtc *vs_crtc_create(struct drm_device *drm_dev,
>> +                   struct vs_dc_info *info);
>> +void vs_crtc_handle_vblank(struct drm_crtc *crtc, bool underflow);
>> +
>> +static inline struct vs_crtc *to_vs_crtc(struct drm_crtc *crtc)
>> +{
>> +    return container_of(crtc, struct vs_crtc, base);
>> +}
>> +
>> +static inline struct vs_crtc_state *
>> +to_vs_crtc_state(struct drm_crtc_state *state)
>> +{
>> +    return container_of(state, struct vs_crtc_state, base);
>> +}
>> +#endif /* __VS_CRTC_H__ */
>> diff --git a/drivers/gpu/drm/verisilicon/vs_type.h b/drivers/gpu/drm/verisilicon/vs_type.h
>> new file mode 100644
>> index 000000000000..6f8db65a703d
>> --- /dev/null
>> +++ b/drivers/gpu/drm/verisilicon/vs_type.h
>> @@ -0,0 +1,72 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (C) 2023 VeriSilicon Holdings Co., Ltd.
>> + */
>> +
>> +#ifndef __VS_TYPE_H__
>> +#define __VS_TYPE_H__
>> +
>> +#include <linux/version.h>
> 
> Why?
> 

hi Thomas , 

this line should be deleted. 
Historical reasons It has been compatible with multiple kernel versions

 

> Best regards
> Thomas
> 
>> +
>> +#include <drm/drm_plane.h>
>> +#include <drm/drm_plane_helper.h>
>> +
>> +struct vs_plane_info {
>> +    const char *name;
>> +    u8 id;
>> +    enum drm_plane_type type;
>> +    unsigned int num_formats;
>> +    const u32 *formats;
>> +    u8 num_modifiers;
>> +    const u64 *modifiers;
>> +    unsigned int min_width;
>> +    unsigned int min_height;
>> +    unsigned int max_width;
>> +    unsigned int max_height;
>> +    unsigned int rotation;
>> +    unsigned int blend_mode;
>> +    unsigned int color_encoding;
>> +
>> +    /* 0 means no de-gamma LUT */
>> +    unsigned int degamma_size;
>> +
>> +    int min_scale; /* 16.16 fixed point */
>> +    int max_scale; /* 16.16 fixed point */
>> +
>> +    /* default zorder value,
>> +     * and 255 means unsupported zorder capability
>> +     */
>> +    u8     zpos;
>> +
>> +    bool watermark;
>> +    bool color_mgmt;
>> +    bool roi;
>> +};
>> +
>> +struct vs_dc_info {
>> +    const char *name;
>> +
>> +    u8 panel_num;
>> +
>> +    /* planes */
>> +    u8 plane_num;
>> +    const struct vs_plane_info *planes;
>> +
>> +    u8 layer_num;
>> +    unsigned int max_bpc;
>> +    unsigned int color_formats;
>> +
>> +    /* 0 means no gamma LUT */
>> +    u16 gamma_size;
>> +    u8 gamma_bits;
>> +
>> +    u16 pitch_alignment;
>> +
>> +    bool pipe_sync;
>> +    bool mmu_prefetch;
>> +    bool background;
>> +    bool panel_sync;
>> +    bool cap_dec;
>> +};
>> +
>> +#endif /* __VS_TYPE_H__ */
> 
