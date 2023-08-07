Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600A1772B4B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjHGQl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjHGQl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:41:57 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6020C9E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:41:56 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6bcbb0c40b1so3593499a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691426515; x=1692031315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFf6/4I+/bBlEwSARy/+YTAUPS77qELMgK5GKsW+qM4=;
        b=nsEM/gIqPu5vX7INGjfXu83Wdfe4yvOJ+qvtzPAOIVfgIbdaPIthYW40rZhr9bZ+tL
         Eo7bXoqd6B/PqjKsLy4Mbhc5orWSI6AnaHEAdoE4ryc1ShWRt10X59JOwQ2YmGJDqtlv
         z6qyGPpwKK+fouHxSlx84AKUOADb2DiHRbkDpI2ETMjhUNxccj43KEOzazCMxRfKjzSH
         MsgqRg+hAxfE/8T/7rvL2GA8lM8J25omat+mXFcs4onYX1j/pw1xVdUKKAhkO1RgbZqy
         APVcDiJt/ScxMJczGlik/yJXbekbZXJvKUOHPYiRi1Q0DeMvIiRVTvIY6qOD6C0nrg5n
         gpWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691426515; x=1692031315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RFf6/4I+/bBlEwSARy/+YTAUPS77qELMgK5GKsW+qM4=;
        b=hlew30pepXcMeH8bHsH1+GR1VAWW0lPoPoZXr1A1lh4gxmUz606kLqUohkAJmvDJP/
         caoOM3psRtqc7zs5arMLPrqbB0jtTKU6Rl2w36R3lPkjdeZXhu2uDU5aCJksXg6U8dpd
         6691ZcGxyn7qV6OIYPOhaORTzZra6YxW1UjzeKaV6nHjamX5PruHiUN64EsnLrAH/TcC
         wgrFRgzl9aH2f7wr2bs02F4mvVLMTz1WAp7TK7+OmslhHHqTQHOgfWBXur6aN2gC+zLS
         bGHXnTHHiXdbufFOd6HOe86QiVufad7SACnlIlmk7WjMg5RiIO/NpyUeLO2Zv3P/hbe9
         a7zg==
X-Gm-Message-State: AOJu0YywSZfFduKnOPo5Mge+3qKSOXnrM3nkt0AFi3D6L6oydhpUmpNf
        ugyePNeqf51yvhTAGUVroHNT2th3th6F+KkIq6E=
X-Google-Smtp-Source: AGHT+IEFq3RD5atcVKPg/ax1n0Rg2FEB0tR36eeDThJdnA8hchvwUJr/dSVJwoe11m3iVs63cy/hOj1dKYgqnE9fjl8=
X-Received: by 2002:a05:6870:c18d:b0:1be:d49b:a3c5 with SMTP id
 h13-20020a056870c18d00b001bed49ba3c5mr11828163oad.29.1691426513821; Mon, 07
 Aug 2023 09:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230801023915.4756-1-sunran001@208suo.com> <DM6PR12MB261918C00FCDF3E4BBBC1C57E40AA@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB261918C00FCDF3E4BBBC1C57E40AA@DM6PR12MB2619.namprd12.prod.outlook.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 12:41:43 -0400
Message-ID: <CADnq5_NkbVgAuz3dNA0OLna9FKJqYwikMpHksdaGAQPep+q1RQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Clean up errors in vega20_hwmgr.h
To:     "Quan, Evan" <Evan.Quan@amd.com>
Cc:     Ran Sun <sunran001@208suo.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Tue, Aug 1, 2023 at 5:25=E2=80=AFAM Quan, Evan <Evan.Quan@amd.com> wrote=
:
>
> [AMD Official Use Only - General]
>
> Reviewed-by: Evan Quan <evan.quan@amd.com>
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ran
> > Sun
> > Sent: Tuesday, August 1, 2023 10:39 AM
> > To: Deucher, Alexander <Alexander.Deucher@amd.com>; airlied@gmail.com;
> > daniel@ffwll.ch
> > Cc: Ran Sun <sunran001@208suo.com>; dri-devel@lists.freedesktop.org;
> > amd-gfx@lists.freedesktop.org; linux-kernel@vger.kernel.org
> > Subject: [PATCH] drm/amd/pm: Clean up errors in vega20_hwmgr.h
> >
> > Fix the following errors reported by checkpatch:
> >
> > ERROR: open brace '{' following enum go on the same line
> >
> > Signed-off-by: Ran Sun <sunran001@208suo.com>
> > ---
> >  drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.h | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.h
> > b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.h
> > index 075c0094da9c..1ba9b5fe2a5d 100644
> > --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.h
> > +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.h
> > @@ -385,8 +385,7 @@ struct vega20_odn_data {
> >       struct vega20_odn_temp_table    odn_temp_table;
> >  };
> >
> > -enum OD8_FEATURE_ID
> > -{
> > +enum OD8_FEATURE_ID {
> >       OD8_GFXCLK_LIMITS               =3D 1 << 0,
> >       OD8_GFXCLK_CURVE                =3D 1 << 1,
> >       OD8_UCLK_MAX                    =3D 1 << 2,
> > @@ -399,8 +398,7 @@ enum OD8_FEATURE_ID
> >       OD8_FAN_ZERO_RPM_CONTROL        =3D 1 << 9
> >  };
> >
> > -enum OD8_SETTING_ID
> > -{
> > +enum OD8_SETTING_ID {
> >       OD8_SETTING_GFXCLK_FMIN =3D 0,
> >       OD8_SETTING_GFXCLK_FMAX,
> >       OD8_SETTING_GFXCLK_FREQ1,
> > --
> > 2.17.1
>
