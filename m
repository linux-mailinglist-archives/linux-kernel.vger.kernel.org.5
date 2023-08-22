Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5403A78448C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236876AbjHVOlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234889AbjHVOlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:41:23 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE1510B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:41:22 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f13c41c957so1609906e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1692715280; x=1693320080;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DjPSXU9vRFZmzcE0RnI7FKpj3y4XibRxN7JQdeXEp4M=;
        b=U8lomFMdmh65X/Z05DVugAI/HIW2IZ6SA+VXKoHhtWkeaJ4IWbZlj8hRRlolIc9PVq
         ex/kzt5kWAX6N7iAyuwdPzdGy8F714BPwcduqQg8KsJ5MVwFZBkNMCfS958BGWNOQfz3
         azTD7cTawpFksFrO9XajyOMn16GCyFNqpZYCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692715280; x=1693320080;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DjPSXU9vRFZmzcE0RnI7FKpj3y4XibRxN7JQdeXEp4M=;
        b=FcszKmvDeNXPT+rScfK9dKsMQSRZ6VDse3RqtdoJ//ecyKfr+XXg5KZY9952hOO0bN
         c2Imv1mmApAUjkzN0WRUR6++387OB/7icjUWK/VcSbNN/NLxRkaqDdBKT3dlbxCOSyqK
         aPya2HfTm67rF/WYpq6SiBIMNmt/6ENt3KF657WkLvgyXywV0ak1hGolS6iCImsjTsvg
         +wCQcLwVy0ObxHXk8wBxGxuzsLnxqcKtPJhkm5PNpGHjorkN++wEWDjnV/H79qJWPRjx
         ofto+XVLD1ngaUJ4sf4EN+JSgkRnexpeSVb+8h+rdSp1aB3AG6j5drnChn2MCB+LCL+j
         IcLg==
X-Gm-Message-State: AOJu0YzTiYON5q0zQ0sF1d9nZAR8f6wdhU047QJvUO/4SADZVgWKcpvj
        HyQ0PWQiMLBwortfyP1qa3jeTw==
X-Google-Smtp-Source: AGHT+IGWAYDi69QV43DfY/Bg0MVqNhkMQYtcGEEfawQ6qCRP6mHqo370ttAQV/MSmDAFTYOpZIboWA==
X-Received: by 2002:a19:c512:0:b0:4fd:d0f7:5b90 with SMTP id w18-20020a19c512000000b004fdd0f75b90mr6247947lfe.4.1692715280130;
        Tue, 22 Aug 2023 07:41:20 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id d19-20020a056402517300b005272523b162sm7603460ede.69.2023.08.22.07.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 07:41:19 -0700 (PDT)
Date:   Tue, 22 Aug 2023 16:41:17 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Emma Anholt <emma@anholt.net>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH RFC 00/13] drm/connector: Create HDMI Connector
 infrastructure
Message-ID: <ZOTJDXQMc0+h8nWt@phenom.ffwll.local>
Mail-Followup-To: Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Emma Anholt <emma@anholt.net>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20230814-kms-hdmi-connector-state-v1-0-048054df3654@kernel.org>
 <ZOTDKHxn2bOg+Xmg@phenom.ffwll.local>
 <sh3f7nuks7cww43ajz2iwrgzkxbqpk7752iu4pj4vtwaiv76x4@itnf6f2mnbgn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sh3f7nuks7cww43ajz2iwrgzkxbqpk7752iu4pj4vtwaiv76x4@itnf6f2mnbgn>
X-Operating-System: Linux phenom 6.3.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 04:35:55PM +0200, Maxime Ripard wrote:
> Hi,
> 
> On Tue, Aug 22, 2023 at 04:16:08PM +0200, Daniel Vetter wrote:
> > On Mon, Aug 14, 2023 at 03:56:12PM +0200, Maxime Ripard wrote:
> > > Here's a series that creates a subclass of drm_connector specifically
> > > targeted at HDMI controllers.
> > > 
> > > The idea behind this series came from a recent discussion on IRC during
> > > which we discussed infoframes generation of i915 vs everything else. 
> > > 
> > > Infoframes generation code still requires some decent boilerplate, with
> > > each driver doing some variation of it.
> > > 
> > > In parallel, while working on vc4, we ended up converting a lot of i915
> > > logic (mostly around format / bpc selection, and scrambler setup) to
> > > apply on top of a driver that relies only on helpers.
> > > 
> > > While currently sitting in the vc4 driver, none of that logic actually
> > > relies on any driver or hardware-specific behaviour.
> > > 
> > > The only missing piec to make it shareable are a bunch of extra
> > > variables stored in a state (current bpc, format, RGB range selection,
> > > etc.).
> > > 
> > > Thus, I decided to create some generic subclass of drm_connector to
> > > address HDMI connectors, with a bunch of helpers that will take care of
> > > all the "HDMI Spec" related code. Scrambler setup is missing at the
> > > moment but can easily be plugged in.
> > > 
> > > Last week, Hans Verkuil also expressed interest in retrieving the
> > > infoframes generated from userspace to create an infoframe-decode tool.
> > > This series thus leverages the infoframe generation code to expose it
> > > through debugfs.
> > > 
> > > This entire series is only build-tested at the moment. Let me know what
> > > you think,
> >
> > I think the idea overall makes sense, we we probably need it to roll out
> > actual hdmi support to all the hdmi drivers we have. But there's the
> > eternal issue of "C sucks at multiple inheritance".
> > 
> > Which means if you have a driver that subclasses drm_connector already for
> > it's driver needs it defacto cannot, or only under some serious pains, use
> > this.
> 
> That's what vc4 is doing, and it went fine I think? it was mostly a
> matter of subclassing drm_hdmi_connector instead of drm_connector, and
> adjusting the various pointers and accessors here and there.
> 
> It does create a fairly big diffstat, but nothing too painful.

Yeah it's the massive churn that's the pain for refactoring existing
bigger drivers.

Plus what do you do when you both need a hdmi connector and a dp connector
(or a writeback connector).

> > Which is kinda why in practice we tend to not subclass, but stuff
> > subclass fields into a name sub-structure. So essentially struct
> > drm_connector.hdmi and struct drm_connector_state.hdmi instead of
> > drm_hdmi_connector and drm_hdmi_connector_state. The helper functions to
> > set it all up would all still be the same roughly. It's less typesafe but
> > I think the gain in practical use (like you could make i915 use the
> > helpers probably, which with this approach here is practically
> > impossible).
> 
> Ack.
> 
> > The only other nit is that we probably want to put some of the hdmi
> > properties into struct drm_mode_config because there's no reason to have
> > per-connector valid values.
> 
> What property would you want to move?

The rgb broadcast property looked very much like it's connector invariant.
Just the one I noticed, I didn't check all the others.

> > Also, it might be really good if you can find a co-conspirator who also
> > wants to use this in their driver, then with some i915 extracting we'd
> > have three, which should ensure the helper api is solid.
> 
> I can convert sunxi (old) HDMI driver if needed. I'm not sure how
> helpful it would be since it doesn't support bpc > 8, but it could be a
> nice showcase still for "simple" HDMI controllers.

Yeah that might be good. Or perhaps poke Rob Clark whether msm is
interested and someone could do a conversion for dpu5 or so?

Cheers, Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
