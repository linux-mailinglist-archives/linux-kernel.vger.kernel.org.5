Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F4B7ADAC2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 16:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbjIYO5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 10:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbjIYO5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 10:57:31 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D7910A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 07:57:24 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1d651ab1d77so4434643fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 07:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695653844; x=1696258644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O40XcCcHAsas1mpr+dRj0K7q2EqizN+rIJm4VTmzi9I=;
        b=LBRxj4FxcWd+K67ovqub4xUoBtrJxfrfsjtGSEa8d4aWiVYgwCwTBSgdNWqwfLe4fY
         XLKasar2KPI9/Yss041xPIScgRkGin2X5Mjd3+M3N0GM8mySxU1eSm6j4Cb1MnMT0Od2
         2OF2Rcw0NCgGOMFHd4pM8Gd+XyKmx3616och3AVuWJy8S8rhwtG3BIbVcYM5uLhUA2hT
         y7XuOg0ITNW3MnUQISt8bRkcj0FXwZkh1ORZr4gmYlvSh7bS0upUfDA3E9sW88HTQKb1
         RTQw2GSg9FyPU4jEEMMcDLpmbrMEtxeOCeJIY/FuOG0Gmb/y5Dvcfm49z3FZQ1Ri/3jd
         YmwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695653844; x=1696258644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O40XcCcHAsas1mpr+dRj0K7q2EqizN+rIJm4VTmzi9I=;
        b=Lk4SDq2sxYLgBWW4L4nnfmuFrvtPJIFzySQS1kH/d/VhwPVnh/JEbjqe2JcvE2KyG2
         oJaNq9Mk0NOHZl1oAV+jkqpQlkxgGqdRJr7HF8Ssl00VlCTlNVeeVOPAm2CuhxVT84Us
         Eb3AF46AezzVH1TzB0Wvs4QNLbPIOENVSXBj2lHfFGls/9OE0FcQCEISM26RmCPgatRc
         J1Du1t/M1n3tCvg/kO6rJxiW+kmUYKQOiaOe4TVxFf/IM8ncbmArcgRjLZYugZsfr1hB
         g0YlrmTqC29xtYFkvh7LXF9jsET0Z3cGCYQh+4y1xdnF47BaunPvF0hdcdnUNJkTvVL4
         sKzg==
X-Gm-Message-State: AOJu0YzKhV142oIKm1du4RpgBBvWNNIrX0SzFaS+9gZ7EHHGfMvnZF6E
        n1AUu9nr83Z2Ivf9PIi+jTqkYnUarf6JFNeCwYI=
X-Google-Smtp-Source: AGHT+IHtQ8tD5jMMf7FdzdQNLk/vrGJ5JR+DLT3ZdercsudZfqftPCuTp8AJyh/nAdLzwxhcqc/z3nXbLRi1ydLwj6g=
X-Received: by 2002:a05:6870:c596:b0:1dc:6f48:5046 with SMTP id
 ba22-20020a056870c59600b001dc6f485046mr9200798oab.5.1695653843745; Mon, 25
 Sep 2023 07:57:23 -0700 (PDT)
MIME-Version: 1.0
References: <1694753689-29782-1-git-send-email-quic_rsr@quicinc.com>
 <19ce2cd9abfd3bdf3ea91f9bceb43206e4740c2e.camel@redhat.com> <ZQ3pbVHRXMiLfUCf@ideak-desk.fi.intel.com>
In-Reply-To: <ZQ3pbVHRXMiLfUCf@ideak-desk.fi.intel.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 25 Sep 2023 10:57:12 -0400
Message-ID: <CADnq5_NQnQoheKv39DiuLjKY3Z83WpesrFRUO4FMdrn=YPhnSQ@mail.gmail.com>
Subject: Re: [PATCH v1] drm/dp/mst: fix missing modeset unlock for MST port detect
To:     imre.deak@intel.com
Cc:     Lyude Paul <lyude@redhat.com>, Jani Nikula <jani.nikula@intel.com>,
        Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Wayne Lin <Wayne.Lin@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Ramya SR <quic_rsr@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 3:22=E2=80=AFPM Imre Deak <imre.deak@intel.com> wro=
te:
>
> On Fri, Sep 22, 2023 at 03:02:23PM -0400, Lyude Paul wrote:
> >
> > Oh! wow thank you for catching this:
> >
> > Reviewed-by: Lyude Paul <lyude@redhat.com>
> >
> > I will go and push this to drm-misc-next in just a moment
> >
> > On Fri, 2023-09-15 at 10:24 +0530, Ramya SR wrote:
> > > Modeset mutex unlock is missing in drm_dp_mst_detect_port function.
> > > This will lead to deadlock if calling the function multiple times in
> > > an atomic operation, for example, getting imultiple MST ports status
> > > for a DP MST bonding scenario.
> > >
> > > Signed-off-by: Ramya SR <quic_rsr@quicinc.com>
> > > ---
> > >  drivers/gpu/drm/display/drm_dp_mst_topology.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/=
gpu/drm/display/drm_dp_mst_topology.c
> > > index ed96cfc..d6512c4 100644
> > > --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> > > +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> > > @@ -4154,7 +4154,7 @@ drm_dp_mst_detect_port(struct drm_connector *co=
nnector,
> > >
> > >     ret =3D drm_modeset_lock(&mgr->base.lock, ctx);
> > >     if (ret)
> > > -           goto out;
> > > +           goto fail;
> > >
> > >     ret =3D connector_status_disconnected;
> > >
> > > @@ -4181,6 +4181,8 @@ drm_dp_mst_detect_port(struct drm_connector *co=
nnector,
> > >             break;
> > >     }
> > >  out:
> > > +   drm_modeset_unlock(&mgr->base.lock);
>
> Isn't this supposed to be unlocked only by drm_helper_probe_detect_ctx()
> / drm_helper_probe_detect() ?

Maybe adding a comment to that effect would be helpful for the future.

Alex

>
> > > +fail:
> > >     drm_dp_mst_topology_put_port(port);
> > >     return ret;
> > >  }
> >
> > --
> > Cheers,
> >  Lyude Paul (she/her)
> >  Software Engineer at Red Hat
> >
