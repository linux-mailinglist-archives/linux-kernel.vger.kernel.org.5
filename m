Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4035B7AA4FB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbjIUW1N convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 21 Sep 2023 18:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbjIUW0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:26:48 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77CCA5D66
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:59:36 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3ae0b0e9a68so407815b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:59:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695319176; x=1695923976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=40XOX8q82CJYYuN+M1nPVewiZW/zHKq9qHFf150I6MI=;
        b=c64RpOIXcJpJ4ejw1kJKiDTbSlFuiM2O6aUnrbeY8ji1W2WdYFYOnWlve1MUHYwuWs
         WIyPuJrYPng1FrULP2ykUT8DS2b/ByD3aiV6BvBmOhgmxYHJTeZjniGClURudHjeHhp7
         fvMC6G5MJmivNSe+3he6BHO0Fjd2lKbgEZih0A51GIw6VbkGNk8zXDKIwM49qV8mG6P4
         JXXmzX0kfdWhLFTuY45JOmNAitTUhwgr3OEgG/c0Iazdr2eRFPwY/pZTIjfy7bmQsdUn
         SaMQdq3MSzJ+AJw0hdl7x7hya/rpmKJPkHrXivEpzYz/yYxnKOgLSeSv7RFQZChRaprd
         fF2g==
X-Gm-Message-State: AOJu0YzRuaw9YJSbeoWvPnWOGwcZLtJkhYzR1KiFWaWNni7LqRmPWgJP
        53TKrl6tRjmUYm4RlEdWvno4IsEB4XD7boG+
X-Google-Smtp-Source: AGHT+IFKxp+XLcp9YzZD6qCaAz9LwP/mitE8+k11qL/Mt5GSJaLwPdafh/zW1D26d0Ok0x9coqmmFQ==
X-Received: by 2002:a0d:fb41:0:b0:59c:961:ead with SMTP id l62-20020a0dfb41000000b0059c09610eadmr4461562ywf.41.1695287239562;
        Thu, 21 Sep 2023 02:07:19 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id s123-20020a0de981000000b0059b4e981fe6sm222736ywe.102.2023.09.21.02.07.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 02:07:19 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-59c0442a359so8880877b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 02:07:18 -0700 (PDT)
X-Received: by 2002:a81:9e10:0:b0:579:effb:ae1c with SMTP id
 m16-20020a819e10000000b00579effbae1cmr5117090ywj.26.1695287238501; Thu, 21
 Sep 2023 02:07:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230914195138.1518065-1-javierm@redhat.com> <f5620d32-2705-498b-a65c-7dc663340a6d@suse.de>
 <87wmwo3q50.fsf@minerva.mail-host-address-is-not-set> <552hpgr7qzbjxuyei3n5m7rsn7ekwbdgzv25oe5vy6qb35gf23@q4etussk5jwl>
 <CAMuHMdUGVgj6V+N865QZaAusqD7O2f1askE544Z4MF0h4zBERg@mail.gmail.com>
 <2p53aei56tlr7k6w5oawlwpmv2k7agpbb6wfwpxcg3rqyueyrx@2as7tijrgnh4>
 <CAMuHMdV9Q=F6D=FgBYazjxGL8HY1cRLJUxdfdvr8=6fwgn+EHQ@mail.gmail.com> <yz2wo76us5bsshdsyiybanpsxa2izqwuj6ts3b76lnfo74ypgz@kx5vqwi6cjap>
In-Reply-To: <yz2wo76us5bsshdsyiybanpsxa2izqwuj6ts3b76lnfo74ypgz@kx5vqwi6cjap>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 21 Sep 2023 11:07:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUHm1msGCvOsArurvCZLPi4Pjr4RE8XR5mTQEiVQ1OMxA@mail.gmail.com>
Message-ID: <CAMuHMdUHm1msGCvOsArurvCZLPi4Pjr4RE8XR5mTQEiVQ1OMxA@mail.gmail.com>
Subject: Re: [PATCH] drm/ssd130x: Drop _helper prefix from struct
 drm_*_helper_funcs callbacks
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Thu, Sep 21, 2023 at 10:51 AM Maxime Ripard <mripard@kernel.org> wrote:
> On Thu, Sep 21, 2023 at 10:46:05AM +0200, Geert Uytterhoeven wrote:
> > On Thu, Sep 21, 2023 at 10:12 AM Maxime Ripard <mripard@kernel.org> wrote:
> > > On Thu, Sep 21, 2023 at 09:57:22AM +0200, Geert Uytterhoeven wrote:
> > > > On Thu, Sep 21, 2023 at 9:44 AM Maxime Ripard <mripard@kernel.org> wrote:
> > > > > On Mon, Sep 18, 2023 at 09:19:07AM +0200, Javier Martinez Canillas wrote:
> > > > > > Thomas Zimmermann <tzimmermann@suse.de> writes:
> > > > > > > Am 14.09.23 um 21:51 schrieb Javier Martinez Canillas:
> > > > > > >> The driver uses a naming convention where functions for struct drm_*_funcs
> > > > > > >> callbacks are named ssd130x_$object_$operation, while the callbacks for
> > > > > > >> struct drm_*_helper_funcs are named ssd130x_$object_helper_$operation.
> > > > > > >>
> > > > > > >> The idea is that this helper_ prefix in the function names denote that are
> > > > > > >> for struct drm_*_helper_funcs callbacks. This convention was copied from
> > > > > > >> other drivers, when ssd130x was written but Maxime pointed out that is the
> > > > > > >> exception rather than the norm.
> > > > > > >
> > > > > > > I guess you found this in my code. I want to point out that I use the
> > > > > > > _helper infix to signal that these are callback for
> > > > > > > drm_primary_plane_helper_funcs and *not* drm_primary_plane_funcs. The
> > > > > > > naming is intentional.
> > > > > >
> > > > > > Yes, that's what tried to say in the commit message and indeed I got the
> > > > > > convention from drivers in drivers/gpu/drm/tiny. In fact I believe these
> > > > > > function names are since first iteration of the driver, when was meant to
> > > > > > be a tiny driver.
> > > > > >
> > > > > > According to Maxime it's the exception rather than the rule and suggested
> > > > > > to change it, I don't really have a strong opinion on either naming TBH.
> > > > >
> > > > > Maybe that's just me, but the helper in the name indeed throws me off. In my
> > > > > mind, it's supposed to be used only for helpers, not functions implementing the
> > > > > helpers hooks.
> > > >
> > > > With several callbacks using the same (field) name, it is very helpful
> > > > to name the actual implementation by combining the struct type name
> > > > and the field name.
> > >
> > > I can't think of any (at least for a given object). Which one do you have in
> > > mind?
> >
> > E.g. atomic_check():
> >
> >     drm_crtc_helper_funcs.atomic_check()
> >     drm_encoder_helper_funcs.atomic_check()
> >     drm_connector_helper_funcs.atomic_check()
> >     drm_plane_helper_funcs.atomic_check()
>
> Right, but that's between objects, not between drm_$OBJECT_funcs and
> drm_$OBJECT_helper_funcs. So conflicts for a single given driver is unlikely,
> and can be solved by using, say, $DRIVER_crtc_atomic_check and
> $DRIVER_plane_atomic_check.

IC. There are indeed no such conflicts (except between
drm_encoder_slave_funcs and drm_encoder_helper_funcs, which I guess
doesn't count).

Thanks, this helps a lot to explain why there is no need to have
"helper" in the name of the callbacks.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
