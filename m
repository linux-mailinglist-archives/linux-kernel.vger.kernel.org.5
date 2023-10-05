Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1552F7B9F83
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbjJEOZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjJEOW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:22:56 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A0A27B0D
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 06:35:28 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d8198ca891fso1094783276.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 06:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1696512927; x=1697117727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBt77iv+i6yUV6sl6438k+nP1DNpZDLg/0Q4EcZ/2kY=;
        b=tocAmFF79bgN1NtDUPmMPH+qjf7RMA3Fx8BYewELiJSodBUdmb+sUIKA9LNqhNAR2T
         s7u2yBKUykrifgsbFHGwkTsmeIe53Bt4KFPVXXzAPYezB+Gbv9uN46gs14iy1w1oJ5AB
         pEBYsBiU8rocwXF6cTbuzlE/GO4nTqX4C57PWvbfUKp0mY0k62183PFYeqPaAthZ4xqT
         HEDJBMuDjAg/jrmOLLqC3kAa3SfY8Xws2Cs2JfCkXbSDlmP6PWuvPaRbDcMiFjl6QdRM
         BfaqDLy8wxVz+Zp1ELBS5TzBikqZ94IcFLnOyHcWDgkU5KAu43rN0KQqDbPies6Cqvdj
         5Raw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696512927; x=1697117727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tBt77iv+i6yUV6sl6438k+nP1DNpZDLg/0Q4EcZ/2kY=;
        b=ShmmG2iF9SYmoaubuoQLREWI+MQoIxEeqdjjTx5rFJ5sDRVmq4YA1CUXHplz0zFdIU
         ecO81chZCas70/xm+Z0SO+lbJAoeqNMCyaxqd3oS45L8omCpPIna2lawtJWCkYgjxNIG
         +3SXp4hO+U3DYYzT6S7szzq28kQxm1oyLwEoNcGb7Bi41LcLRcGR+RkFyH4zI5qHbyEs
         fxE2oM7jWjaFpTuWV12zfaNrregUsBrPqQBnkDtwqJNphyAmZGVtKqcHcy+Aa3Glueqt
         tr3wiZpyBbmitoY2w5XS6IH4tOwp1ZtzJiX5BnAOYsrxR/NrFvshz0XZG0hRxakJliEy
         MLWg==
X-Gm-Message-State: AOJu0YwWTrHsK6RJfN0gDipfrwdzM0osHyKLUbT5VxIyrjxMgM3ZOH5W
        cMxXHr2UQ4Cqi4uaEi92muhT9YPDleDtp28VJfYo4oSa9TTXVR4/
X-Google-Smtp-Source: AGHT+IEilDB2SWaF2YfLIJ5wnpnhZFHNJl9unsnwBv7BHZq2V2+NiDoG7LsGUJMOOgZULV9uQUbjcpAGKVo6jsKQVDU=
X-Received: by 2002:a25:3210:0:b0:d93:97e8:97ac with SMTP id
 y16-20020a253210000000b00d9397e897acmr264008yby.38.1696512927631; Thu, 05 Oct
 2023 06:35:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230921131201.157767-1-lma@semihalf.com> <20230922063410.23626-1-lma@semihalf.com>
 <CADmiTCTHn+XaNqkAZjLmaYUy+6bsb5chue97g3n0bKP7Lcf9_w@mail.gmail.com>
In-Reply-To: <CADmiTCTHn+XaNqkAZjLmaYUy+6bsb5chue97g3n0bKP7Lcf9_w@mail.gmail.com>
From:   Lukasz Majczak <lma@semihalf.com>
Date:   Thu, 5 Oct 2023 15:35:16 +0200
Message-ID: <CAFJ_xboEqNFyG6+F0EkXq32X0Y8pPEWYFw9+7JJye42SrrOkWw@mail.gmail.com>
Subject: Re: [PATCH v3] drm/dp_mst: Fix NULL deref in get_mst_branch_device_by_guid_helper()
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     =?UTF-8?Q?Rados=C5=82aw_Biernacki?= <rad@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>, upstream@semihalf.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 26 wrz 2023 o 16:01 Rados=C5=82aw Biernacki <rad@chromium.org> napisa=
=C5=82(a):
>
> On Fri, Sep 22, 2023 at 8:34=E2=80=AFAM Lukasz Majczak <lma@semihalf.com>=
 wrote:
> >
> > As drm_dp_get_mst_branch_device_by_guid() is called from
> > drm_dp_get_mst_branch_device_by_guid(), mstb parameter has to be checke=
d,
> > otherwise NULL dereference may occur in the call to
> > the memcpy() and cause following:
> >
> > [12579.365869] BUG: kernel NULL pointer dereference, address: 000000000=
0000049
> > [12579.365878] #PF: supervisor read access in kernel mode
> > [12579.365880] #PF: error_code(0x0000) - not-present page
> > [12579.365882] PGD 0 P4D 0
> > [12579.365887] Oops: 0000 [#1] PREEMPT SMP NOPTI
> > ...
> > [12579.365895] Workqueue: events_long drm_dp_mst_up_req_work
> > [12579.365899] RIP: 0010:memcmp+0xb/0x29
> > [12579.365921] Call Trace:
> > [12579.365927] get_mst_branch_device_by_guid_helper+0x22/0x64
> > [12579.365930] drm_dp_mst_up_req_work+0x137/0x416
> > [12579.365933] process_one_work+0x1d0/0x419
> > [12579.365935] worker_thread+0x11a/0x289
> > [12579.365938] kthread+0x13e/0x14f
> > [12579.365941] ? process_one_work+0x419/0x419
> > [12579.365943] ? kthread_blkcg+0x31/0x31
> > [12579.365946] ret_from_fork+0x1f/0x30
> >
> > As get_mst_branch_device_by_guid_helper() is recursive, moving conditio=
n
> > to the first line allow to remove a similar one for step over of NULL e=
lements
> > inside a loop.
> >
> > Fixes: 5e93b8208d3c ("drm/dp/mst: move GUID storage from mgr, port to o=
nly mst branch")
> > Cc: <stable@vger.kernel.org> # 4.14+
> > Signed-off-by: Lukasz Majczak <lma@semihalf.com>
> > ---
> >
> > v2->v3:
> > * Fixed patch description.
> >
> >  drivers/gpu/drm/display/drm_dp_mst_topology.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gp=
u/drm/display/drm_dp_mst_topology.c
> > index ed96cfcfa304..8c929ef72c72 100644
> > --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> > +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> > @@ -2574,14 +2574,14 @@ static struct drm_dp_mst_branch *get_mst_branch=
_device_by_guid_helper(
> >         struct drm_dp_mst_branch *found_mstb;
> >         struct drm_dp_mst_port *port;
> >
> > +       if (!mstb)
> > +               return NULL;
> > +
> >         if (memcmp(mstb->guid, guid, 16) =3D=3D 0)
> >                 return mstb;
> >
> >
> >         list_for_each_entry(port, &mstb->ports, next) {
> > -               if (!port->mstb)
> > -                       continue;
> > -
> >                 found_mstb =3D get_mst_branch_device_by_guid_helper(por=
t->mstb, guid);
> >
> >                 if (found_mstb)
> > --
> > 2.42.0.515.g380fc7ccd1-goog
> >
>
> Reviewed-by: Radoslaw Biernacki <rad@chromium.org>

Hi,

Is there anything more I should do with this patch?

Thanks,
Lukasz
