Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1FA805BFD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442518AbjLEPjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442485AbjLEPjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:39:14 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30003BF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 07:39:16 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-db4422fff15so3522277276.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 07:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1701790755; x=1702395555; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dSRudhrkUva4fqMShfFkXTOV2VXsRdToC6I5p0S8ZG8=;
        b=giPei3X4PXM0ldVuXOCfutDItJRQTrnDh03QIgaCGPZWsPkQeg2W40EU3m7Sam8OIs
         RFNTR67whJmjHmJx2GBa4Yt721PX4aK4HZg9jDEntFD8I4H3vx5RmHoLuEPblcKyVY6U
         7QYmdo6lLbffeKlozA1O/Pi6/Oi35cRbecEAEvp/LBTlC2uNv1vkhWHeW080/NjlrZpL
         8/DVhr+SkeliMWJOYwWfAHgMmpaVFmLte1cjvWJpnI/VjnW9NBvQU9vIBLwsYTDOM0wm
         o0f3a4qGR71K4qnmXVu7m8uLRAqgeigbDDy235N6UB9aXQ5hoFP/1VMXlyaQvJD8EPsK
         DVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701790755; x=1702395555;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dSRudhrkUva4fqMShfFkXTOV2VXsRdToC6I5p0S8ZG8=;
        b=qohF8dQc+IYzLYVf1qq10gr3b+sEYlGZzOPOMtFEjabchWDlUzDIS3eM6OH315xLs/
         IgyZmet8lMO1lCPOgElTEGDPRCdSRQznSMqQE6h1sBLN/uAXwuxOlHPvorAuSqWmv9V/
         Q+igQ6Uy07StSerQoQrsmIRkWwu12+1FxnLpWtPpr75ht6Lg1BaPCWrz+X7rGRHS2Lau
         MxlOdpEuxC9RFPP8Q1XsLndaSZJHnLAJqsS5dTFT4CTUHZBctJOn1+1D+EjIUUaltzrb
         dEkpEL0uB6vfG0UsvPtq0CZSLhn95Lmac4eTuhCll1RAIvtAuKeYwnDEtigFl3LUZnn7
         IRIQ==
X-Gm-Message-State: AOJu0YxvA6o+5OzE5/xKv30ZMnHKi0lrj/VF+5+jaunNOXAuxA1fM7Kd
        kVn5WCb1rO+D0yc1ozp39AsBbdUu42MROJTSHCcMTA==
X-Google-Smtp-Source: AGHT+IFiDeprUJe0T1fJ+u/ddjNYBP85Sz/UOzEBgtnKv9hrfEf9+nKOd0wRhl2w0WqTgvMcfHhZPkmVHDzQbK0w4KY=
X-Received: by 2002:a25:f811:0:b0:db7:dad0:76e1 with SMTP id
 u17-20020a25f811000000b00db7dad076e1mr3567546ybd.125.1701790755220; Tue, 05
 Dec 2023 07:39:15 -0800 (PST)
MIME-Version: 1.0
References: <20231205105341.4100896-1-dario.binacchi@amarulasolutions.com> <20231205105341.4100896-3-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20231205105341.4100896-3-dario.binacchi@amarulasolutions.com>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 5 Dec 2023 15:39:00 +0000
Message-ID: <CAPY8ntAALKiTEG6qyFO=qVqSLUW9x8AMfPMc_TUwC3z8tJ7Kzw@mail.gmail.com>
Subject: Re: [PATCH v4 02/10] drm/bridge: Fix a use case in the bridge disable logic
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dario

On Tue, 5 Dec 2023 at 10:54, Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
>
> The patch fixes the code for finding the next bridge with the
> "pre_enable_prev_first" flag set to false. In case this condition is
> not verified, i. e. there is no subsequent bridge with the flag set to
> false, the whole bridge list is traversed, invalidating the "next"
> variable.
>
> The use of a new iteration variable (i. e. "iter") ensures that the value
> of the "next" variable is not invalidated.

We already have https://patchwork.freedesktop.org/patch/529288/ that
has been reviewed (but not applied) to resolve this. What does this
version do differently and why?

  Dave

> Fixes: 4fb912e5e190 ("drm/bridge: Introduce pre_enable_prev_first to alter bridge init order")
> Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
>
> (no changes since v1)
>
>  drivers/gpu/drm/drm_bridge.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index f66bf4925dd8..2e5781bf192e 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -662,7 +662,7 @@ void drm_atomic_bridge_chain_post_disable(struct drm_bridge *bridge,
>                                           struct drm_atomic_state *old_state)
>  {
>         struct drm_encoder *encoder;
> -       struct drm_bridge *next, *limit;
> +       struct drm_bridge *iter, *next, *limit;
>
>         if (!bridge)
>                 return;
> @@ -680,14 +680,15 @@ void drm_atomic_bridge_chain_post_disable(struct drm_bridge *bridge,
>                                  * was enabled first, so disabled last
>                                  */
>                                 limit = next;
> +                               iter = next;
>
>                                 /* Find the next bridge that has NOT requested
>                                  * prev to be enabled first / disabled last
>                                  */
> -                               list_for_each_entry_from(next, &encoder->bridge_chain,
> +                               list_for_each_entry_from(iter, &encoder->bridge_chain,
>                                                          chain_node) {
> -                                       if (!next->pre_enable_prev_first) {
> -                                               next = list_prev_entry(next, chain_node);
> +                                       if (!iter->pre_enable_prev_first) {
> +                                               next = list_prev_entry(iter, chain_node);
>                                                 limit = next;
>                                                 break;
>                                         }
> --
> 2.43.0
>
