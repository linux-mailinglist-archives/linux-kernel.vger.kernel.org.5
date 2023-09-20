Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F937A8366
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbjITN37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbjITN35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:29:57 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1461CA9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 06:29:52 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3a88ef953adso4661471b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 06:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695216591; x=1695821391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVWGEgGSEjp4k+KXLV/K8fcEJkhuenia706z3qiQLdM=;
        b=eQktvelMBKCBPeIsFmsVWmQlhWSryO/oLtoKAH5UuHqZ/oqP+kPgYK/UZENKB9+CIP
         PHuUml02gsDgK108Sa/XEpXnIFDsby9f8Phir/sR8YKUUz500nYSwd6Jn6NBoAVkO6nY
         FkoFVelFmXF5sDdYe8CFgmxhz0mJ1Vug3buRQeYPpVvRX4r8hg+Zmy9nevkZEyBT9dOR
         q8NRFZnuokkX1iTHRLWJwMuqPdQNgZMBMt6QGB5WIslZlZyHwyfeO8YFKigxlNXeMw8C
         Btnz91TVscXnlQC6oPsJT8sfm1sC7Tpg3i9lzppoZwPtuMINrFnhPW5gjNDieW9Lf7+a
         QMtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695216591; x=1695821391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVWGEgGSEjp4k+KXLV/K8fcEJkhuenia706z3qiQLdM=;
        b=BCKsD/iIRU9qHLX/Lp+qEcA2pFojccGWvlro5saIFsXlUCN5DI54SCTAwD+c+BDvfO
         A6KmvsvJgGIM/2bdgzAUhJyCEfb/YZLb6OWKy4L0/J4bH4jhx12fWuF+0u8c8uRIPqnB
         9+YyqOlpVB40Uj3tw8dbUKgODrQSnj7kRBvrINy34f5fZB0V16JmGtnBWwvaX8XAKwh1
         CW7F3hYkbwVavT0cHrtuiCsiLrZiphqq2SBIPT1hhnWK4oLg8wFZh6fEq4LVj7OQOOaF
         VEVodbo7GMiXElR1+aJFGttdD5fisQqg7zlpzYYs7ABHd3RoGxKOySVwSJuzkwo3U7JY
         byXw==
X-Gm-Message-State: AOJu0YzP6ijVpLxfKTBk7bRCHs/v1qivNCu8Gfghbyz430ieSntBVUkI
        MOK1QHjDhh7bh7sOXNFruq1HI+qdA0aBH+OtAo4=
X-Google-Smtp-Source: AGHT+IF/BUd8MrJluzuOw7ioQsv1V6pvR5BavSSty4c1W5OmAuN4YZx6qQ/56UFJNwajEHtJFgc8XNtg6sya/8m/39A=
X-Received: by 2002:a05:6870:4248:b0:1d6:6941:d1d0 with SMTP id
 v8-20020a056870424800b001d66941d1d0mr2513289oac.49.1695216591341; Wed, 20 Sep
 2023 06:29:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230919093318.16407-1-swarupkotikalapudi@gmail.com> <e1294905-b867-4141-87ff-2b7202476e59@infradead.org>
In-Reply-To: <e1294905-b867-4141-87ff-2b7202476e59@infradead.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 20 Sep 2023 09:29:40 -0400
Message-ID: <CADnq5_Oy=f9aQDX0VE7vE0brU3sLe08zWDukcRPBEyfhdUKUHw@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: amd: display: fix kernel-doc warnings
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>,
        harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
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

Applied.  Thanks!

On Tue, Sep 19, 2023 at 5:54=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Hi,
>
> On 9/19/23 02:33, Swarup Laxman Kotiaklapudi wrote:
> > Fix kernel-doc warnings discovered in AMD gpu display driver.
> > Fixes these warnings:
> > ./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:110: warning:
> > Function parameter or member 'overlap_only'
> > not described in 'mpcc_blnd_cfg'.
> >
> > ./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:110: warning:
> > Function parameter or member 'bottom_gain_mode'
> > not described in 'mpcc_blnd_cfg'.
> >
> > ./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:110: warning:
> > Function parameter or member 'background_color_bpc'
> > not described in 'mpcc_blnd_cfg'.
> >
> > ./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:110:
> > warning: Function parameter or member 'top_gain'
> > not described in 'mpcc_blnd_cfg'.
> >
> > ./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:110:
> > warning: Function parameter or member 'bottom_inside_gain'
> > not described in 'mpcc_blnd_cfg'.
> >
> > ./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:110:
> > warning: Function parameter or member 'bottom_outside_gain'
> > not described in 'mpcc_blnd_cfg'.
> >
> > Signed-off-by: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com=
>
>
> Thanks for fixing these kernel-doc warnings.
>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>
>
> > ---
> >  drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h b/drivers/gpu/=
drm/amd/display/dc/inc/hw/mpc.h
> > index 8d86159d9de0..61a2406dcc53 100644
> > --- a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
> > +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
> > @@ -91,6 +91,12 @@ enum mpcc_alpha_blend_mode {
> >   * @global_gain: used when blend mode considers both pixel alpha and p=
lane
> >   * alpha value and assumes the global alpha value.
> >   * @global_alpha: plane alpha value
> > + * @overlap_only: whether overlapping of different planes is allowed
> > + * @bottom_gain_mode: blend mode for bottom gain setting
> > + * @background_color_bpc: background color for bpc
> > + * @top_gain: top gain setting
> > + * @bottom_inside_gain: blend mode for bottom inside
> > + * @bottom_outside_gain:  blend mode for bottom outside
> >   */
> >  struct mpcc_blnd_cfg {
> >       struct tg_color black_color;    /* background color */
>
> --
> ~Randy
