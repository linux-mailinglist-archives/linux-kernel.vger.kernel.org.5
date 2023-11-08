Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1384E7E5E09
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 20:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbjKHTBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 14:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbjKHTAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 14:00:38 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1E4258B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 11:00:32 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1efabc436e4so4162845fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 11:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699470031; x=1700074831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otxnVkd8YgWVTzG3H7cvr+93qyokKFzdStJbXRE7UUc=;
        b=PJPgcgLazdFeW8gdWkEn2tVkVi3lJ3PXD2DYs6dbdhrp+B1y5aHts8Si8GXuwdWZ2i
         0skSV+krDmX7B7LnO2VeB27HHX5Se96JJX8Ol4ucnNfQUHEf9AYM0RiQWqO+uwNuJ9bD
         PrLnwFFzUeNfoP97RLN8OAPUIQoD43ktLCYHPU7/OU10zMh4n16JM+cHUJH/Kcvoy/t/
         6xelVt5jp+2oCTFnkvGXqa+47Pl8pqMUl5s6m0HU0Kpkok8CS4KBigIG7miy+QBPI+zO
         6hz1X2TYHCeM6A7aE9KD7QPkbchq+rcqOpsc3KQeu8TYlnxgrT61wcwJfJwbiDKn8ogE
         ANCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699470031; x=1700074831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=otxnVkd8YgWVTzG3H7cvr+93qyokKFzdStJbXRE7UUc=;
        b=tBxA6SvNWyPtQVxHUpBMQ1cRgseidg4TYEqwmL7Q3qFnmzBVU/p1e/MtPiQkqdKsbL
         vbbj1UZv7F+aEN+2/b1V2zyvzotz2NgWGVO2aWbTnhx9EEEhL9F6I+LeHwWKgqOTZS20
         TZmGzq7Bw4R2tz3qpIUC8TRYC/AzzD1Y4EI5qyHjLAZto2n0rOkVPolaTywyLdiV5sW9
         yy3lxjvx1EyHESAeLBvY3HBVhWJlUwGYCd8rKNsNFP6tv2jopgDl5A+6TxHbo1kzjlB5
         gwRYd9rSP8QluWUjrvTznJooS91xUHSxWQgOXC+1cFPsZVLfgrgg4J1LDqrzGO84ckqj
         iRfQ==
X-Gm-Message-State: AOJu0YxoR2DZFi1h9tJOV9BL9bFk6s4uJJnYviCR9CEGhm6T2Cev0KJu
        Pn3ugfxwfZWBRbG6h9vYGcF9Z1xDLybuydJrqY6+QReD
X-Google-Smtp-Source: AGHT+IHvpi3a4SBVR+ik6OpPcUARXpDbAmpBYewfy5UA+w+qqJFFTZ6OeD4JVSJcj/4uYdeGrClnwBQQdXADX431yUk=
X-Received: by 2002:a05:6870:470b:b0:1e9:d158:2465 with SMTP id
 b11-20020a056870470b00b001e9d1582465mr3028814oaq.17.1699470031642; Wed, 08
 Nov 2023 11:00:31 -0800 (PST)
MIME-Version: 1.0
References: <20231029093926.137766-1-jose.pekkarinen@foxhound.fi>
 <d56cd927-49fc-cb4e-8abd-abc539e4d276@amd.com> <e095fae915d44ccc186d5e5ee74ec119@foxhound.fi>
In-Reply-To: <e095fae915d44ccc186d5e5ee74ec119@foxhound.fi>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 8 Nov 2023 14:00:19 -0500
Message-ID: <CADnq5_NjUnC_nsaDCgma8u=eBKv4qMb1L214QEY9S75tA=2vTA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove duplicated argument
To:     =?UTF-8?Q?Jos=C3=A9_Pekkarinen?= <jose.pekkarinen@foxhound.fi>
Cc:     Aurabindo Pillai <aurabindo.pillai@amd.com>, sunran001@208suo.com,
        sunpeng.li@amd.com, qingqing.zhuo@amd.com, Xinhui.Pan@amd.com,
        Rodrigo.Siqueira@amd.com, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, Zhongwei.Zhang@amd.com,
        alex.hung@amd.com, Yao.Wang1@amd.com,
        dri-devel@lists.freedesktop.org, skhan@linuxfoundation.org,
        alexander.deucher@amd.com, Jun.Lei@amd.com,
        christian.koenig@amd.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Wed, Nov 8, 2023 at 3:52=E2=80=AFAM Jos=C3=A9 Pekkarinen
<jose.pekkarinen@foxhound.fi> wrote:
>
> On 2023-10-30 15:54, Aurabindo Pillai wrote:
> > On 10/29/2023 5:39 AM, Jos=C3=A9 Pekkarinen wrote:
> >> Spotted by coccicheck, there is a redundant check for
> >> v->SourcePixelFormat[k] !=3D dm_444_16. This patch will
> >> remove it. The corresponding output follows.
> >>
> >> drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c:5130:86=
-122:
> >> duplicated argument to && or ||
> >>
> >> Signed-off-by: Jos=C3=A9 Pekkarinen <jose.pekkarinen@foxhound.fi>
> >> ---
> >>   drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c | 2
> >> +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git
> >> a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> >> b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> >> index ad741a723c0e..3686f1e7de3a 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> >> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> >> @@ -5128,7 +5128,7 @@ void
> >> dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib
> >> *mode_l
> >>                      ViewportExceedsSurface =3D true;
> >>              if (v->SourcePixelFormat[k] !=3D dm_444_64 &&
> >> v->SourcePixelFormat[k] !=3D dm_444_32 && v->SourcePixelFormat[k] !=3D
> >> dm_444_16
> >> -                            && v->SourcePixelFormat[k] !=3D dm_444_16=
 &&
> >> v->SourcePixelFormat[k] !=3D dm_444_8 && v->SourcePixelFormat[k] !=3D
> >> dm_rgbe) {
> >> +                            && v->SourcePixelFormat[k] !=3D dm_444_8 =
&& v->SourcePixelFormat[k]
> >> !=3D dm_rgbe) {
> >>                      if (v->ViewportWidthChroma[k] > v->SurfaceWidthC[=
k] ||
> >> v->ViewportHeightChroma[k] > v->SurfaceHeightC[k]) {
> >>                              ViewportExceedsSurface =3D true;
> >>                      }
> >
> > Thanks for catching.
> >
> > Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
>
>      Sorry to bring this up, I just wanted to check whether this
> has been applied in the following pulls or not.
>
>      Thanks!
>
>      Jos=C3=A9.
