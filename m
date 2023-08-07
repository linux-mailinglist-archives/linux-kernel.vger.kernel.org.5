Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC94772B4E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjHGQmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjHGQmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:42:43 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D989592
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:42:41 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1bf54f415afso2644674fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691426561; x=1692031361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ra/F8bxJt2uHIFJpeC0EOCovKfShoRIUredcDAUE+ZI=;
        b=Gun2NGjjwowkJ026ZgXPE+fYKi6Lu7M5wpQIvnaaU+IBKVqjxfNcoHyi6WcUSgq1cE
         Cze9o7vM05EXgghmDqBtbX7cBtkpynu5AwuqBlRHTMUZKQf1OVKO2lMaZ3hmbRSFzWQc
         EKG6kpgFlu4FXJCxPqMR60JRneZMfzEI87WH4m9/XMU/yEbyX4feWet3bDZVzcr6ZLqH
         TdMcJ5dVZzEs/35p9mI0oJ8MfNSnncpthS1bSh2d836Yl1ObA7aIMr/TM2eANH1rrX2f
         eWoPe/KyJQ5HmypqPncLeWw3AuPvZ1KSrCh5YUQk6/yuNRJ6ZOPIJ8S/tPAqEM9xHEP7
         IJGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691426561; x=1692031361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ra/F8bxJt2uHIFJpeC0EOCovKfShoRIUredcDAUE+ZI=;
        b=BForTj9cvlxXJnecTL191L8i0UEaZAT0EUVi36M6v3fWOF8tydc8IeoJrQIOQZFgsO
         75jBTyEt72c4N0J5koMEPv6cz64039XgDZYA7gMRJxSskLg7kAe7qTmah6jmUadqWJV7
         JyFxE0H/omyfpzpdSTrvhlIVJS/IAOuz6GSxAki48b55oG3ERyuRb2f+25NbLkX1h5ux
         NcGMMRyIh0vMWjRBWIbtojVg48w9t1My6dXwDX2PYA7rHxRxnedj7O+4xR4mP8GFv8S0
         FpjrWlwbGg1FCTtbKwMflw0ksXJ7XUcP5EkoaZcbzZ52W5WLPpH/HX79tsfmfB1XpB8u
         QwCg==
X-Gm-Message-State: AOJu0YwbMOP9o2xnHp1a6xdUhRrX90B2RACRlvAg+IJ6zrmxX+LYS1rk
        ++lwAhB30bhZYlwjTfY5hKA+n1pYBkSBQpdF8ak=
X-Google-Smtp-Source: AGHT+IF5F8ATbbx0BFgLWbu0SNtonAC9iGdpaFGrRGFiubeRgOfSTci8+hQyXwbBuqSz6lm6uWcncHGGh7lZO0PhQEQ=
X-Received: by 2002:a05:6870:c21f:b0:19e:fa1f:fc2f with SMTP id
 z31-20020a056870c21f00b0019efa1ffc2fmr9661638oae.38.1691426561171; Mon, 07
 Aug 2023 09:42:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230801080246.6556-1-sunran001@208suo.com> <DM6PR12MB26192EB1ADCC6973C37B6E2AE40AA@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB26192EB1ADCC6973C37B6E2AE40AA@DM6PR12MB2619.namprd12.prod.outlook.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 12:42:30 -0400
Message-ID: <CADnq5_NDGOUVTNFsQvxAmZMgOBDF64hQ89WXhq8gy2hZctzmHg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Clean up errors in vega20_baco.c
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
> > Sent: Tuesday, August 1, 2023 4:03 PM
> > To: Deucher, Alexander <Alexander.Deucher@amd.com>; airlied@gmail.com;
> > daniel@ffwll.ch
> > Cc: Ran Sun <sunran001@208suo.com>; dri-devel@lists.freedesktop.org;
> > amd-gfx@lists.freedesktop.org; linux-kernel@vger.kernel.org
> > Subject: [PATCH] drm/amdgpu: Clean up errors in vega20_baco.c
> >
> > Fix the following errors reported by checkpatch:
> >
> > ERROR: that open brace { should be on the previous line
> > ERROR: space required before the open parenthesis '('
> >
> > Signed-off-by: Ran Sun <sunran001@208suo.com>
> > ---
> >  drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c
> > b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c
> > index 8d99c7a5abf8..994c0d374bfa 100644
> > --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c
> > +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c
> > @@ -31,8 +31,7 @@
> >
> >  #include "amdgpu_ras.h"
> >
> > -static const struct soc15_baco_cmd_entry clean_baco_tbl[] =3D -{
> > +static const struct soc15_baco_cmd_entry clean_baco_tbl[] =3D {
> >       {CMD_WRITE, SOC15_REG_ENTRY(NBIF, 0, mmBIOS_SCRATCH_6), 0,
> > 0, 0, 0},
> >       {CMD_WRITE, SOC15_REG_ENTRY(NBIF, 0, mmBIOS_SCRATCH_7), 0,
> > 0, 0, 0},  }; @@ -90,11 +89,11 @@ int vega20_baco_set_state(struct
> > pp_hwmgr *hwmgr, enum BACO_STATE state)
> >                       data |=3D 0x80000000;
> >                       WREG32_SOC15(THM, 0, mmTHM_BACO_CNTL,
> > data);
> >
> > -                     if(smum_send_msg_to_smc_with_parameter(hwmgr,
> > +                     if
> > (smum_send_msg_to_smc_with_parameter(hwmgr,
> >                                       PPSMC_MSG_EnterBaco, 0, NULL))
> >                               return -EINVAL;
> >               } else {
> > -                     if(smum_send_msg_to_smc_with_parameter(hwmgr,
> > +                     if
> > (smum_send_msg_to_smc_with_parameter(hwmgr,
> >                                       PPSMC_MSG_EnterBaco, 1, NULL))
> >                               return -EINVAL;
> >               }
> > --
> > 2.17.1
>
