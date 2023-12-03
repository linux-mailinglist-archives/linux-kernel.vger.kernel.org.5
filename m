Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108E0802622
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 19:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjLCSKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 13:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCSKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 13:10:37 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE2EE7
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 10:10:43 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-58d1b767b2bso2518083eaf.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 10:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701627042; x=1702231842; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hNWrRac9X2HwvORQ757NwocfD1vnHP+xf8IZ/qHDI6Y=;
        b=unYOaL6GmKGiXQQvTG3eiOK0jsCalp+D5BcbGe2XQfAv756BIqOvNo9m6J6D6JfFMA
         vutdEKQ3i9xcZH5u9N6By923F1m316v9Qu2vZQatBhQYznZx8JonJVbqs6Olhp4IUrMC
         C2R4zsXgNBHWbf9v5LrAN4s0yuKaoKdZKkyAFA781CRekh74nE5X/EGbRZy0Qtvj7sSv
         93CayLV8+tBjrJG3g4u5o+LfJtvgoW7yk60NjjQ+NfWa2Sb84LKnt9JLcg9l+9CwyC+W
         krdu/Pusa3JpopTeJMffBIFcLWOAUEEOeZ8IN8zI6WbnsbDTqSstsoCEMTRAJamAMVPl
         PBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701627042; x=1702231842;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hNWrRac9X2HwvORQ757NwocfD1vnHP+xf8IZ/qHDI6Y=;
        b=pONJOKRbzXwsc/6EI3KX5pBE04v3SqGoZxXR60QIS0I2SLMyALqCSg8es8r0huImKA
         bj+bENS0U4zrPu9kcFJAgJLahQL6K4G5Zs7isb9o9qVxMtjwJ4mvgekinLcovp6eUg1A
         LQ96Hj/NlYrFpDQc5DSV/Zl0mQVGx2T8v+uPt72bZKmlwHAyNYVSg7VwIQFUUjZEEdL9
         K7s6PNZzziiudnjW3hIsURVGFac4usfyyq2qKc5TVwpR+ZiD6lgygB7tXku2A5r/guh5
         RGs6ZscNzZG10OhFqbi2mw0fDe6Lbf8/vxqlp4oUIa2LTsmTr77DDMHaIMsKzbHzqMVL
         TiTQ==
X-Gm-Message-State: AOJu0Yymw35wmRkOHvaEQ6XgTrYeGEJ+NBf+UYfHQ+JPoFOCuiHIPiHm
        Rq01odW7Wlm3QZGFNngojGvgfm8YsjFFSM5R11nPhQ==
X-Google-Smtp-Source: AGHT+IHb3Z+Gg112hSwn2ALLmEQLugH9ogYS6oGgilydDX+dwhOwywfw0uwnNsBepyMljqTdUfek1dtr5E8c4G2RWMA=
X-Received: by 2002:a05:6358:9214:b0:169:49f7:cb1c with SMTP id
 d20-20020a056358921400b0016949f7cb1cmr3149078rwb.8.1701627042402; Sun, 03 Dec
 2023 10:10:42 -0800 (PST)
MIME-Version: 1.0
References: <20231027-solid-fill-v7-0-780188bfa7b2@quicinc.com>
 <170155324921.2215646.4829699354481827834.b4-ty@linaro.org> <OiX1EToyQ0JBECS-Vs6IOw1vqLTt42PYkTlTCBhsPUi-VXC2UoLjkRfEW-OFucxsTqz93Q3IIXZZ3Lw_Lqs1dFt4YbuFSUGrKfDPnnKDCbw=@emersion.fr>
In-Reply-To: <OiX1EToyQ0JBECS-Vs6IOw1vqLTt42PYkTlTCBhsPUi-VXC2UoLjkRfEW-OFucxsTqz93Q3IIXZZ3Lw_Lqs1dFt4YbuFSUGrKfDPnnKDCbw=@emersion.fr>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sun, 3 Dec 2023 20:10:31 +0200
Message-ID: <CAA8EJpom-guy0p_u2kLhXgLZnJaVXCXaHAUGhv2EH=xyrHtL6A@mail.gmail.com>
Subject: Re: (subset) [PATCH RFC v7 00/10] Support for Solid Fill Planes
To:     Simon Ser <contact@emersion.fr>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        quic_abhinavk@quicinc.com, ppaalanen@gmail.com,
        laurent.pinchart@ideasonboard.com, sebastian.wick@redhat.com,
        ville.syrjala@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        wayland-devel@lists.freedesktop.org,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Sebastian Wick <sebastian@sebastianwick.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Dec 2023 at 14:15, Simon Ser <contact@emersion.fr> wrote:
>
> On Saturday, December 2nd, 2023 at 22:41, Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
>
> > On Fri, 27 Oct 2023 15:32:50 -0700, Jessica Zhang wrote:
> >
> > > Some drivers support hardware that have optimizations for solid fill
> > > planes. This series aims to expose these capabilities to userspace as
> > > some compositors have a solid fill flag (ex. SOLID_COLOR in the Android
> > > hardware composer HAL) that can be set by apps like the Android Gears
> > > test app.
> > >
> > > In order to expose this capability to userspace, this series will:
> > >
> > > [...]
> >
> >
> > Applied to drm-misc-next, thanks!
>
> Where are the IGT and userspace for this uAPI addition?

Indeed. I checked that there are uABI acks/reviews, but I didn't check
these requirements. Frankly speaking, I thought that they were handled
already, before giving the ack. How should we proceed? Should I land a
revert?

-- 
With best wishes
Dmitry
