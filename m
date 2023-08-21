Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB6F783670
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 01:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjHUXlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 19:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbjHUXlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 19:41:07 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A8013E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 16:41:05 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1c26bb27feeso2553436fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 16:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692661265; x=1693266065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4t4twQrN4/XcfFQME5R5NFMMXoes4soP1FcV6+5sgL8=;
        b=aZLu3Z/X/lPkIfBJo/wLHF1VjiCrHhX+WDNJCcZP2QHQaxfu2I1sQH23aaZ0neGODP
         4aBGqDtnH+lhGB6jCf5GlCha2SbPS+q5i4NUJ2K/tQP0lHEABqUTHjGF+0wCH2AeaszQ
         TJAo5UIYlYCif6o+MRAi6x3WbbO2cM9MU553k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692661265; x=1693266065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4t4twQrN4/XcfFQME5R5NFMMXoes4soP1FcV6+5sgL8=;
        b=bGBJPR/rKgJojaOAPAzAXx4v7Vk/ZGNVAnrY2s6B9hQMuZ4PuQE33pLVdkqy29TVmg
         VqNTG9aEnUOmzUi0WIMnPt5DAaGCF2Mk6SN0LYbcjJGk9gUBw0WKimfPfP66Gn+TYgMP
         xXCTnzwNrMG2sh6EjaH6xnnAm+LjTKo+JxqJLnWtzYKj1bXPbTpfESJloBaUOMN+XSts
         hE6DBkfliwcu9FWMMUmIixXrHhRIdqYGJ7ID6+vf50ybJWiVHr/O7z+pzbWtwSGQrmmB
         gVm1bbS9b28apILpDNJx4tq1IcG7QjBxIRZW6CADYXK7+JLfRA9WlX4XPJPUuQrf5mA6
         VFNg==
X-Gm-Message-State: AOJu0YzfL29uHqaq9BzNzNK0f5r5qWjwP0dEYw+7iBvECGhP9qwN7Fy2
        9O2mHZ0sQPhcVLMGBJInVeEnAOeYPeQME0RiMSUG1w==
X-Google-Smtp-Source: AGHT+IEf18sZL6oHJdiN3d4/TG4j0/AnxyO9TCU6xdEjynSCXn4yzhdTyDeQYC2UL7FF5v0+p5nKka2B/7P8tOZ0G6w=
X-Received: by 2002:a05:6870:ec90:b0:1c4:e139:331 with SMTP id
 eo16-20020a056870ec9000b001c4e1390331mr9670539oab.55.1692661265110; Mon, 21
 Aug 2023 16:41:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230811210735.159529-1-utkarsh.h.patel@intel.com>
 <20230811210735.159529-4-utkarsh.h.patel@intel.com> <ZN+nXGr3S0OL3Edn@chromium.org>
 <MWHPR11MB0048AF9CAA00D2A57C8CC533A91EA@MWHPR11MB0048.namprd11.prod.outlook.com>
In-Reply-To: <MWHPR11MB0048AF9CAA00D2A57C8CC533A91EA@MWHPR11MB0048.namprd11.prod.outlook.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Mon, 21 Aug 2023 16:40:53 -0700
Message-ID: <CACeCKaeEggChrqkN=izTySLRb75w0qkM1Xbnkyo3ZKVkGnZRTw@mail.gmail.com>
Subject: Re: [PATCH 3/4] platform/chrome: cros_ec_typec: Add Displayport
 Alternatemode 2.1 Support
To:     "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "bleung@chromium.org" <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Utkarsh,

On Mon, Aug 21, 2023 at 10:34=E2=80=AFAM Patel, Utkarsh H
<utkarsh.h.patel@intel.com> wrote:
>
> Hi Prashant,
>
> Thank you for the review and feedback.
>
> > -----Original Message-----
> > From: Prashant Malani <pmalani@chromium.org>
>>
> > I don't understand why the conf VDO is being recreated here. cable_vdo
> > should already contain the necessary bits. Just use the cable_vdo that =
you get
> > from cros_typec_get_cable_vdo(); it will have all the bits set correctl=
y already
> > (the EC should be doing that).
> >
> > The "if" condition should also be unnecessary.
> >
> > You are already doing something similar in the other patch for "active =
retimer
> > cable support" [1]
>
> "if" condition is necessary because there are cables (LRD Gen3) with DPSI=
D but does not support DPAM 2.1 and in that case we need to check TBTSID of=
 the cable and use the cable properties e.g. SPEED and Type.

Ok, then grab the two VDOs distinctly (cable_dp_vdo and cable_tbt_vdo).
Also, the explanation you gave above seems like a good candidate for a comm=
ent
above the "if" block.

> Since that information is already available in pd_ctrl, we are leveraging=
 it.  I will remove the part where it's checking retimer cable as DP2.1 is =
anyway not supported.

As mentioned in earlier patches related to this, we want to avoid
using EC-specific data structures
as much as possible moving forward, especially if the information can
be gleaned from the
available DiscSVID VDOs. So, please use the required cable VDO
(whether it is DP or TBT SID).

>
> >
> > > +
> > > +   port->state.data =3D &dp21_data;
> > > +
> > > +   return typec_mux_set(port->mux, &port->state);
> >
> > Note that now you have reversed the order in which the muxes are set (w=
hich
> > leads to subtle timing issues with Burnside Bridge and other similar re=
timers).
> > So please don't do this.
>
> Are you suggesting to add same order here?

Specifically, breaking out a separate function for DP 2.1 and then
embedding that
in the overall enable_dp() function makes things unnecessarily complex.

Just craft the VDOs onew time, within enable_dp(), and then use the existin=
g
locations where cros_retimer_set and typec_mux_set() are called.

This will become more clear once you rebase this commit on top of the chang=
es
in [1]

Effectively cros_typec_enable_dp() should handle all DP cases, without need=
ing
a special function broken out for DP 2.1

> > This entire feature isn't necessary. Regardless of whether dp2.1 is sup=
ported
> > or not, the port driver just needs to forward the cable_vdo it receives=
 faithfully
> > to the mux driver, which can deal with internal details (based on wheth=
er *it*
> > supports DP 2.1 or not).
>
> I am Okay with that.
> We thought we can avoid unnecessary check for the cable_vdo for DP altern=
ate mode on platform where DP2.1 is not supported.

The optimization is miniscule enough to not be worth it the added code
verbosity.
