Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FB77A9B7A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjIUTBt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 21 Sep 2023 15:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjIUTBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:01:19 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2245C198D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:34:33 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3ab2a0391c0so818627b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:34:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695321272; x=1695926072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6wRswdA+hUPT84SfQuestnzzAlGgjNnTThx2x+1h1rI=;
        b=lu3oiCoZiTWnD9usJVgaOS9EjL0Lr53zvAFRFaxhZ/DxVnGTBnpFwGCNooXofwT8N2
         /FulyFz1YRRA7CrKZAaXkYnda5k6fO4Yg3dOnlJ/vC/DIvR3cj7Md1zISwxtojSUQ+sC
         1rPfu3j4v5xIbOfR/UWb9UOSNDRn0d3SSfTnbjg8hwS184foKrSGPD+9+eiairfuM6lk
         alqO9E3jN+tbnWdRL1NA5cfVf+0ZKTfMCVYHQXm5RNwWtZPsG4bbHFOPSfl4b/P5XS+F
         Hd1SYmi1x4nSj/DjjRvaoo877gKBt73DXliThH6b1bD9SXRfxnriPiVk72rAJENPAmZu
         Cijw==
X-Gm-Message-State: AOJu0YwSJc4EGFr+3xCJVTDCjSMSy01ZBvM3ph9Qa+JyZlAntvOkavFN
        LVmZhjVxshgYVptfb/rRHsXIQ4uTuG/K2921
X-Google-Smtp-Source: AGHT+IFwoZnnslTYO054SzzpiqR7BuA6WqZg/m2a4TzWwxAOQhvccsfczi9xAJRV6/Tw2tH6yme/ow==
X-Received: by 2002:a25:e64d:0:b0:d80:1161:5ec1 with SMTP id d74-20020a25e64d000000b00d8011615ec1mr4397007ybh.20.1695285979175;
        Thu, 21 Sep 2023 01:46:19 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id f34-20020a25b0a2000000b00d7e339ada01sm245629ybj.20.2023.09.21.01.46.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 01:46:18 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-59be6605e1dso8577297b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 01:46:18 -0700 (PDT)
X-Received: by 2002:a81:5dd7:0:b0:59b:ce0b:7829 with SMTP id
 r206-20020a815dd7000000b0059bce0b7829mr4365474ywb.35.1695285978536; Thu, 21
 Sep 2023 01:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230914195138.1518065-1-javierm@redhat.com> <f5620d32-2705-498b-a65c-7dc663340a6d@suse.de>
 <87wmwo3q50.fsf@minerva.mail-host-address-is-not-set> <552hpgr7qzbjxuyei3n5m7rsn7ekwbdgzv25oe5vy6qb35gf23@q4etussk5jwl>
 <CAMuHMdUGVgj6V+N865QZaAusqD7O2f1askE544Z4MF0h4zBERg@mail.gmail.com> <2p53aei56tlr7k6w5oawlwpmv2k7agpbb6wfwpxcg3rqyueyrx@2as7tijrgnh4>
In-Reply-To: <2p53aei56tlr7k6w5oawlwpmv2k7agpbb6wfwpxcg3rqyueyrx@2as7tijrgnh4>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 21 Sep 2023 10:46:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV9Q=F6D=FgBYazjxGL8HY1cRLJUxdfdvr8=6fwgn+EHQ@mail.gmail.com>
Message-ID: <CAMuHMdV9Q=F6D=FgBYazjxGL8HY1cRLJUxdfdvr8=6fwgn+EHQ@mail.gmail.com>
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

On Thu, Sep 21, 2023 at 10:12 AM Maxime Ripard <mripard@kernel.org> wrote:
> On Thu, Sep 21, 2023 at 09:57:22AM +0200, Geert Uytterhoeven wrote:
> > On Thu, Sep 21, 2023 at 9:44 AM Maxime Ripard <mripard@kernel.org> wrote:
> > > On Mon, Sep 18, 2023 at 09:19:07AM +0200, Javier Martinez Canillas wrote:
> > > > Thomas Zimmermann <tzimmermann@suse.de> writes:
> > > > > Am 14.09.23 um 21:51 schrieb Javier Martinez Canillas:
> > > > >> The driver uses a naming convention where functions for struct drm_*_funcs
> > > > >> callbacks are named ssd130x_$object_$operation, while the callbacks for
> > > > >> struct drm_*_helper_funcs are named ssd130x_$object_helper_$operation.
> > > > >>
> > > > >> The idea is that this helper_ prefix in the function names denote that are
> > > > >> for struct drm_*_helper_funcs callbacks. This convention was copied from
> > > > >> other drivers, when ssd130x was written but Maxime pointed out that is the
> > > > >> exception rather than the norm.
> > > > >
> > > > > I guess you found this in my code. I want to point out that I use the
> > > > > _helper infix to signal that these are callback for
> > > > > drm_primary_plane_helper_funcs and *not* drm_primary_plane_funcs. The
> > > > > naming is intentional.
> > > >
> > > > Yes, that's what tried to say in the commit message and indeed I got the
> > > > convention from drivers in drivers/gpu/drm/tiny. In fact I believe these
> > > > function names are since first iteration of the driver, when was meant to
> > > > be a tiny driver.
> > > >
> > > > According to Maxime it's the exception rather than the rule and suggested
> > > > to change it, I don't really have a strong opinion on either naming TBH.
> > >
> > > Maybe that's just me, but the helper in the name indeed throws me off. In my
> > > mind, it's supposed to be used only for helpers, not functions implementing the
> > > helpers hooks.
> >
> > With several callbacks using the same (field) name, it is very helpful
> > to name the actual implementation by combining the struct type name
> > and the field name.
>
> I can't think of any (at least for a given object). Which one do you have in
> mind?

E.g. atomic_check():

    drm_crtc_helper_funcs.atomic_check()
    drm_encoder_helper_funcs.atomic_check()
    drm_connector_helper_funcs.atomic_check()
    drm_plane_helper_funcs.atomic_check()

Interestingly, drm_mode_config_helper_funcs does not have an
atomic_check() callback, but drm_mode_config_funcs has.

> > Anything else confuses the casual reader. Perhaps the real question is whether
> > the structures should have "helper" in their name in the first place?
>
> Those structures are meant for functions used by the helpers, they are not
> helper functions.

That might be how they started, but to me it looks like all these helpers
are no longer helpers, but part of the core...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
