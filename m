Return-Path: <linux-kernel+bounces-35838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3E983972A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C2A328A11E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D6C81AAE;
	Tue, 23 Jan 2024 18:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cI+kAZHF"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD261811E7
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 18:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706032956; cv=none; b=X2lvWgo7v0B+RjOyrZVbV7qwhYjEnAULjnCffUXbwmKHxhcv2aVNZzCUkfZ4hebKzsTSswcCvKGjRMoDa2wFMIp+Ma4zXAhVkNiOczT/i2ZYzA8jwge7xdkxYnNcH5xyjIIeB+SxrJdmrRZKWo3VyAnqihGRHakS1IwSIIX+N/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706032956; c=relaxed/simple;
	bh=S6w7WPbKr7/eAyccuQc7VfqEKc2BNyjZzIwtGeg1HDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=euevHu6mg/M6l3cCmDfpxXiz4j7k+m6PGqPJHga4Mngy8h+ozNo8BcSn4AWqFhk/R/n31gs9XoRs8OBnK0DFW9C6chA+jI1wGzV8Os8jRoVnOsBrn+2cys41/5sPoieb8gdWPvSWKcP16kXPzL809z0ZtZJpKpUBxteltxz2UyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cI+kAZHF; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a271a28aeb4so495068566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 10:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706032951; x=1706637751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzP0eSKOjbnQ2ru8HTdKomejWSOPl2M8Q/mGuB9QTvM=;
        b=cI+kAZHFKjDEkw3EzShZx7FfpiOshwkVmrtRdntVKYT0394g7Pz6edE+PJPrWhfZhV
         /p1r55Pptd/KqXWd/OPu5lyJy0qt8/JYirUBJjEdhexplPF5ctSqlROQ7W6eCzpve5TX
         mYzawEXyxYc9eeoZV8yf8OqmD1ojDPFZLVKTdIyhwLVDbnyGZ+fg94TLdUSjh4biqAGM
         DCgGYbH7+NFkj2RhH2RuYu2b4OeVHGrwoqsQc5vDPCyRZJEa/qV2qhrdB+fB/obSCBTP
         Y9u/ZnUKmJMn/UEoQAWdthFTy8xysXEfncxTIlNKa70EsK+CchhbnnPpULJPgkJvMati
         ilOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706032951; x=1706637751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzP0eSKOjbnQ2ru8HTdKomejWSOPl2M8Q/mGuB9QTvM=;
        b=YOndm6Mtdzox2kroCaoRt86jAKZLT5yhvGuCkyD6uJ3/ioKEotfwetbT3Ju96O6zCH
         I/JeawHoLUCcLwglJYgBNtLuvPy3nlFDQtcq68Dud9Wx8OYmgHz8UbZiOlGRJBAdNd93
         ERf2ZKDcDVRuvynMYq84g3ypdYJCuxLekWieM2pYQ0/+5e79r58P+TzGWVv+o91pRi1J
         eBOap5Hbhp2Yy5UVkTDAs0C7f+YZqDvwg1OHz/fg2VZqxDc8AH4kqM0El83KUPi++iTq
         7gN0xU7znLdVJ1ygrIGIrseRKsguUoqUABgO2PX2RsoX96a5a6pqGQpdCscdWhGhwvPx
         Epbw==
X-Gm-Message-State: AOJu0YwF8W/uSffCCJSp70Jpf8+OfBvCRMDjZX8oEfFLIwl6WE1AS2Gl
	EwjC8UrtpNHZ61OrqWcHdyav5s2rkNHg/fTdPLbHEkO/UA1tLYJCTnBfYPmgtI2hJud9zdGwMD6
	/Jp/fmpXRCQ56U80jWOiF/ZO7qUY=
X-Google-Smtp-Source: AGHT+IFXNCzW7fj97YFexXyytl2W4XGvmpFASWQFHqqEseZhsAxlmfxjf3sCf6iXVl3hCAHBMPiR2WNUO1TEyg3u1mg=
X-Received: by 2002:a17:906:4094:b0:a30:dca4:ee7e with SMTP id
 u20-20020a170906409400b00a30dca4ee7emr135796ejj.93.1706032950735; Tue, 23 Jan
 2024 10:02:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119181235.255060-1-andrealmeid@igalia.com>
 <20240119181235.255060-3-andrealmeid@igalia.com> <Zaq-r7UZpEy7_Rrn@intel.com> <ca1faaec-461b-401c-a86a-e0929d282b51@amd.com>
In-Reply-To: <ca1faaec-461b-401c-a86a-e0929d282b51@amd.com>
From: Xaver Hugl <xaver.hugl@gmail.com>
Date: Tue, 23 Jan 2024 19:02:19 +0100
Message-ID: <CAFZQkGyf5MxKeGgz09kgyYTp+g-Jk2uaiQkmzSX7BDGHpcz0CQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/amdgpu: Implement check_async_props for planes
To: Harry Wentland <harry.wentland@amd.com>
Cc: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, daniel@ffwll.ch, 
	=?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>, 
	=?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>, 
	linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	Pekka Paalanen <ppaalanen@gmail.com>, dri-devel@lists.freedesktop.org, 
	kernel-dev@igalia.com, alexander.deucher@amd.com, 
	Dave Airlie <airlied@gmail.com>, christian.koenig@amd.com, 
	Joshua Ashton <joshua@froggi.es>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Mo., 22. Jan. 2024 um 16:50 Uhr schrieb Harry Wentland
<harry.wentland@amd.com>:
>
>
>
> On 2024-01-19 13:25, Ville Syrj=C3=A4l=C3=A4 wrote:
> > On Fri, Jan 19, 2024 at 03:12:35PM -0300, Andr=C3=A9 Almeida wrote:
> >> AMD GPUs can do async flips with changes on more properties than just
> >> the FB ID, so implement a custom check_async_props for AMD planes.
> >>
> >> Allow amdgpu to do async flips with IN_FENCE_ID and FB_DAMAGE_CLIPS
> >> properties. For userspace to check if a driver support this two
> >> properties, the strategy for now is to use TEST_ONLY commits.
> >>
> >> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> >> ---
> >> v2: Drop overlay plane option for now
> >>
> >>   .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 29 +++++++++++++++++=
++
> >>   1 file changed, 29 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b=
/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> >> index 116121e647ca..7afe8c1b62d4 100644
> >> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> >> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> >> @@ -25,6 +25,7 @@
> >>    */
> >>
> >>   #include <drm/drm_atomic_helper.h>
> >> +#include <drm/drm_atomic_uapi.h>
> >>   #include <drm/drm_blend.h>
> >>   #include <drm/drm_gem_atomic_helper.h>
> >>   #include <drm/drm_plane_helper.h>
> >> @@ -1430,6 +1431,33 @@ static void amdgpu_dm_plane_drm_plane_destroy_s=
tate(struct drm_plane *plane,
> >>      drm_atomic_helper_plane_destroy_state(plane, state);
> >>   }
> >>
> >> +static int amdgpu_dm_plane_check_async_props(struct drm_property *pro=
p,
> >> +                                      struct drm_plane *plane,
> >> +                                      struct drm_plane_state *plane_s=
tate,
> >> +                                      struct drm_mode_object *obj,
> >> +                                      u64 prop_value, u64 old_val)
> >> +{
> >> +    struct drm_mode_config *config =3D &plane->dev->mode_config;
> >> +    int ret;
> >> +
> >> +    if (prop !=3D config->prop_fb_id &&
> >> +        prop !=3D config->prop_in_fence_fd &&
> >
> > IN_FENCE should just be allowed always.
> >
> >> +        prop !=3D config->prop_fb_damage_clips) {
> >
> > This seems a bit dubious to me. How is amdgpu using the damage
> > information during async flips?
>
> Yeah, I'm also not sure this is right. Has anyone tested this
> with a PSR SU panel?
>
> Harry

I attempted to, but according to
/sys/kernel/debug/dri/1/eDP-1/psr_state, PSR never kicks in on my
laptop at all. The only reason I wanted this property though is to
reduce the number of special cases for async pageflips compositors
have to implement; as it's not necessary for any functionality I think
it's also fine to leave it out.

> >> +            ret =3D drm_atomic_plane_get_property(plane, plane_state,
> >> +                                                prop, &old_val);
> >> +            return drm_atomic_check_prop_changes(ret, old_val, prop_v=
alue, prop);
> >> +    }
> >> +
> >> +    if (plane_state->plane->type !=3D DRM_PLANE_TYPE_PRIMARY) {
> >> +            drm_dbg_atomic(prop->dev,
> >> +                           "[OBJECT:%d] Only primary planes can be ch=
anged during async flip\n",
> >> +                           obj->id);
> >> +            return -EINVAL;
> >> +    }
> >> +
> >> +    return 0;
> >> +}
> >> +
> >>   static const struct drm_plane_funcs dm_plane_funcs =3D {
> >>      .update_plane   =3D drm_atomic_helper_update_plane,
> >>      .disable_plane  =3D drm_atomic_helper_disable_plane,
> >> @@ -1438,6 +1466,7 @@ static const struct drm_plane_funcs dm_plane_fun=
cs =3D {
> >>      .atomic_duplicate_state =3D amdgpu_dm_plane_drm_plane_duplicate_s=
tate,
> >>      .atomic_destroy_state =3D amdgpu_dm_plane_drm_plane_destroy_state=
,
> >>      .format_mod_supported =3D amdgpu_dm_plane_format_mod_supported,
> >> +    .check_async_props =3D amdgpu_dm_plane_check_async_props,
> >>   };
> >>
> >>   int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
> >> --
> >> 2.43.0
> >

