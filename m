Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53ECF7FC538
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 21:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345633AbjK1UXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 15:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK1UXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 15:23:21 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F2093
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:23:27 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-da077db5145so5441350276.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701203006; x=1701807806; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+BgGK1++XliXcG/Z+XxDuJiyYM8L9NZn4eXTDAvgifM=;
        b=NxCFv1NhjDcDSdXkDsNDR3Hg5AnTCUONzhHtRFk7ngfbEiXu2qNZL3gWsT2saO/hJe
         GY5+zwbM+TKvgTeQ2sk8Qki8MvYsWzs5P6nO/YxjrsMG6B0OuxTuy9XsXibozrpO1tpl
         t+ccqtKd4nrIGeQYB9wolzQGFq3nbeEuUUZhO33CZ1IfwGOH4iwzHnUPeRAAzb1B0QW6
         iY0IV0leEycu6XQ7L1h7PJexmPm8PH7g/6QjDytHCvvu+qwVFaCa50VqjmBSY/Qc/6g8
         lCAeLSa3mtPLak7QaCLEfd1PqgE9WmO0DXF6HVIHydBVKoBkfR5/PfOgiY4P6UzZ9oG/
         1eNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701203006; x=1701807806;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+BgGK1++XliXcG/Z+XxDuJiyYM8L9NZn4eXTDAvgifM=;
        b=LjlpiO2mH+o2HwaXYdzCLIUVUVzaQE+xiLryF+Wg7wc2ihhFZTTo3l0rcB9a97Cqf0
         30QY3OFxRwGh5e/KkVR8z4ZFwd4W5Xej7ff/iHKnd+fNGzOK2SKM9gCfzDly1ODlp5cK
         B5zjpV7+Ss9ncNuOzn7c+LclyiAA3riV6ukc9HjbU7T2rda4Vu59G2t9V7N+tB6y9Vnk
         UhELncWbtRDkrTq8jOUVgIzZ4kPayct2HBGJJ3sU4hqMVi+r/ZRqG8RC6L6mf7M20jvp
         iOJpIQr951keUxj9PWvZzEhCtDybQ9O1Rh95rctOF6KiR9ZVRTx36UicEuGD+CQE5pQj
         5VcA==
X-Gm-Message-State: AOJu0YwoF3jIl+aRmotMl8nPvXqkdO5/QX+mc/znLXuG8vZyhK+1yx4J
        hqnWaAc6xD8S65dp9jKP1IE4ycId4bc9nusxhi7Ugw==
X-Google-Smtp-Source: AGHT+IGRR3a00Cm6C/lv/hPoUxNlxzYknoMQMsEif8NrRDggNWIJ+B4cGq8BM6UVHSeuOzusp+ADAt3UPwLtQi1Qr5c=
X-Received: by 2002:a25:fc22:0:b0:d9a:618a:d727 with SMTP id
 v34-20020a25fc22000000b00d9a618ad727mr14689953ybd.41.1701203006568; Tue, 28
 Nov 2023 12:23:26 -0800 (PST)
MIME-Version: 1.0
References: <CAA8EJpozZkEswnioKjRCqBg4fcjVHFwGivoFNTNHVwyocKprQw@mail.gmail.com>
 <20231127160658.2164612-1-mwalle@kernel.org> <CAA8EJpphwXoKnzDkY3cBqzsDZwdw+nze-Ev2toPBJm-2VJvY_g@mail.gmail.com>
 <dce76a6e1321a6374ad39125bead56b3@kernel.org> <CAA8EJpr9PDgSrTpP2-joQ09fxmJKZB1B+ESbDbMjkLNiqZ1m3A@mail.gmail.com>
 <14D9F495-425D-47FA-AD0D-F7299285936F@walle.cc>
In-Reply-To: <14D9F495-425D-47FA-AD0D-F7299285936F@walle.cc>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 28 Nov 2023 22:23:15 +0200
Message-ID: <CAA8EJpoYkH-0onMmNRk1iO5YeLN+5hpZMsfvtNo-7p6y2mjZwg@mail.gmail.com>
Subject: Re: [RFC PATCH 03/10] drm/mipi-dsi: add API for manual control over
 the DSI link power state
To:     Michael Walle <michael@walle.cc>
Cc:     Michael Walle <mwalle@kernel.org>,
        Laurent.pinchart@ideasonboard.com, andrzej.hajda@intel.com,
        dave.stevenson@raspberrypi.com, dianders@chromium.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        jernej.skrabec@gmail.com, jonas@kwiboo.se,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, marex@denx.de,
        marijn.suijten@somainline.org, mripard@kernel.org,
        neil.armstrong@linaro.org, quic_abhinavk@quicinc.com,
        quic_jesszhan@quicinc.com, rfoss@kernel.org, sean@poorly.run,
        tzimmermann@suse.de, tony@atomide.com,
        alexander.stein@ew.tq-group.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2023 at 21:50, Michael Walle <michael@walle.cc> wrote:
>
> >> >> > DSI device lifetime has three different stages:
> >> >> > 1. before the DSI link being powered up and clocking,
> >> >> > 2. when the DSI link is in LP state (for the purpose of this question,
> >> >> > this is the time between the DSI link being powered up and the video
> >> >> > stream start)
> >> >> > 3. when the DSI link is in HS state (while streaming the video).
> >> >>
> >> >> It's not clear to me what (2) is. What is the state of the clock and
> >> >> data lanes?
> >> >
> >> > Clk an Data0 should be in the LP mode, ready for LP Data Transfer.
> >>
> >> Then this is somehow missing
> >> https://docs.kernel.org/gpu/drm-kms-helpers.html#mipi-dsi-bridge-operation
> >>
> >>    A DSI host should keep the PHY powered down until the pre_enable
> >> operation
> >>    is called. All lanes are in an undefined idle state up to this point,
> >> and
> >>    it must not be assumed that it is LP-11. pre_enable should initialise
> >> the
> >>    PHY, set the data lanes to LP-11, and the clock lane to either LP-11
> >> or HS
> >>    depending on the mode_flag MIPI_DSI_CLOCK_NON_CONTINUOUS.
> >>
> >> So I don't think these three states are sufficient, see below, that
> >> there
> >> should be at least four.
> >
> >Which one is #4?
>
> enabled clock lane (HS mode), data lanes in LP-11

What is the purpose of such a mode?

>
> -michael
>
> >>
> >> >
> >> > I don't think we support ULPS currently.
> >> >
> >> >
> >> >>
> >> >> I'm facing similar issues with the tc358775 bridge. This bridge needs
> >> >> to release its reset while both clock and data lanes are in LP-11
> >> >> mode.
> >> >> But then it needs to be configured (via I2C) while the clock lane is
> >> >> in enabled (HS mode), but the data lanes are still in LP-11 mode.
> >> >>
> >> >> To me it looks like there is a fouth case then:
> >> >> 1. unpowered
> >> >> 2. DSI clock and data are in LP-11
> >> >> 3. DSI clock is in HS and data are in LP-11
> >> >> 4. DSI clock is in HS and data is in HS
> >> >>
> >> >> (And of course the bridge needs continuous clock mode).
> >> >>
> >> >> > Different DSI bridges have different requirements with respect to the
> >> >> > code being executed at stages 1 and 2. For example several DSI-to-eDP
> >> >> > bridges (ps8640, tc358767 require for the link to be quiet during
> >> >> > reset time.
> >> >> > The DSI-controlled bridges and DSI panels need to send some commands
> >> >> > in stage 2, before starting up video
> >> >> >
> >> >> > In the DRM subsystem stage 3 naturally maps to the
> >> >> > drm_bridge_funcs::enable, stage 1 also naturally maps to the
> >> >> > drm_bridge_funcs::pre_enable. Stage 2 doesn't have its own place in
> >> >> > the DRM call chain.
> >> >> > Earlier we attempted to solve that using the pre_enable_prev_first,
> >> >> > which remapped pre-enable callback execution order. However it has led
> >> >> > us to the two issues. First, at the DSI host driver we do not know
> >> >> > whether the panel / bridge were updated to use pre_enable_prev_first
> >> >> > or not. Second, if the bridge has to perform steps during both stages
> >> >> > 1 and 2, it can not do that.
> >> >> >
> >> >> > I'm trying to find a way to express the difference between stages 1
> >> >> > and 2 in the generic code, so that we do not to worry about particular
> >> >> > DSI host and DSI bridge / panel peculiarities when implementing the
> >> >> > DSI host and/or DSI panel driver.
> >> >>
> >> >> For now, I have a rather hacky ".dsi_lp11_notify" callback in
> >> >> drm_bridge_funcs which is supposed to be called by the DSI host while
> >> >> the
> >> >> clock and data lanes are in LP-11 mode. But that is rather an RFC and
> >> >> me
> >> >> needing something to get the driver for this bridge working. Because
> >> >> it's
> >> >> badly broken. FWIW, you can find my work-in-progress patches at
> >> >> https://github.com/mwalle/linux/tree/feature-tc358775-fixes
> >> >>
> >> >> -michael
> >> >>
> >> >
> >> >
> >> > --
> >> > With best wishes
> >> > Dmitry
> >
> >
> >
>


-- 
With best wishes
Dmitry
