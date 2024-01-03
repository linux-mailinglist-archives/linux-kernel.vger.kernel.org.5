Return-Path: <linux-kernel+bounces-15667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E90E822FD7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71EF41C237B6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374281B26E;
	Wed,  3 Jan 2024 14:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0N/xyR3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0431A703
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 14:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-204fdd685fdso3955992fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 06:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704293354; x=1704898154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufp4vRBdchU/yun+kCRIt0+8UCXvzfiwI6xueBPpbEo=;
        b=G0N/xyR3WYFE5hor7N2hFpkvflEXmVhOIhesOkXR7gh7BtC05w8da0PcmA10cQ/1l4
         EGb39H6Ho4dJ1F4Qz/rZakAAVZMT1667m33NzKnP4sWQ0fyErDeaaLsYMsTN40B8sf6m
         QZ1R6nrn8RhHZepECfes5vimy0raeCEWbQ0MPtPjDXezyR3D9uYINWkacvQI1+IOVmTB
         ZtNE/ala5X5KRAOfchxsRaYxUaqXq/eYgDyGfzuqGg86QAa69J7YWdK8bXdBg6gfoims
         Zd+RF63AzU7zIYrtpOc4Z51SohgYtskDQ4uX6g1hJzwCx9i8Ju9jJB2IvzwFa9CC9bDz
         09tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704293354; x=1704898154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ufp4vRBdchU/yun+kCRIt0+8UCXvzfiwI6xueBPpbEo=;
        b=RLLhWYWbauf1TDtoeKAbDGK1G/4hyLmvloYYKLIIVCGzt9th9D3yhXH2Vg9J+u2jOl
         DGHaKhT/v7j9lteSbeDKOCu4SfOlUly29oA6ODjl5OGgEQNaMPSwOp6Vpnz0xE4W16A/
         Zan2Q5hm6kOUxGNI5xzyjrkvKWZ+AFHTwebi2vmnsQQ2eJsI1iwVfflWNSF8RCI/yqls
         q+VChzwdYHQg7Wz283ovSgt5WQZbWFA7TF3X4KmNg/Q58X/M19vIwxFNWX/nCpmd/cOu
         LPl/B8RJysbpjFMtfpShSK0ILitUrTQg8pgxNdz3/UPsvSO1iIDtmH/dJ2wzqSYfkdM6
         Nfbg==
X-Gm-Message-State: AOJu0Yy3EM8yTmMXj0tnWxMsxom0L0YU1d2NNgaKgo75uHWb/bAhc0VI
	LTnMeWOtKdXWwDywHcxOGJUOTCCgkLHbYwuztC8=
X-Google-Smtp-Source: AGHT+IHSBZz2vMnviOtqfzzL8k/DYFyaP559afobIFqxIsn26VMxo6cpgS5jfL8RtysNy5czj+Ih+Xir/VELvwy3SSo=
X-Received: by 2002:a05:6870:c114:b0:1fb:205d:756b with SMTP id
 f20-20020a056870c11400b001fb205d756bmr27160386oad.19.1704293354292; Wed, 03
 Jan 2024 06:49:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122221421.2944301-1-arnd@kernel.org> <536a5850-34af-4a7d-b65d-82147895ef04@infradead.org>
In-Reply-To: <536a5850-34af-4a7d-b65d-82147895ef04@infradead.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 3 Jan 2024 09:49:03 -0500
Message-ID: <CADnq5_NN+gW5rRezagGr=uno0qSD1rAqMbtLtH-YWV9hGmhfPw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: avoid stringop-overflow warnings for dp_decide_lane_settings()
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Alan Liu <haoping.liu@amd.com>, 
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, Arnd Bergmann <arnd@arndb.de>, 
	Qingqing Zhuo <qingqing.zhuo@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, 
	Wenjing Liu <wenjing.liu@amd.com>, linux-kernel@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org, 
	Michael Mityushkin <michael.mityushkin@amd.com>, Michael Strauss <michael.strauss@amd.com>, 
	dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>, 
	George Shen <george.shen@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	Jun Lei <Jun.Lei@amd.com>, David Airlie <airlied@gmail.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Mon, Dec 25, 2023 at 5:30=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
>
>
> On 11/22/23 14:13, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > gcc prints a warning about a possible array overflow for a couple of
> > callers of dp_decide_lane_settings() after commit 1b56c90018f0 ("Makefi=
le:
> > Enable -Wstringop-overflow globally"):
> >
> > drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_trainin=
g_fixed_vs_pe_retimer.c: In function 'dp_perform_fixed_vs_pe_training_seque=
nce_legacy':
> > drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_trainin=
g_fixed_vs_pe_retimer.c:426:25: error: 'dp_decide_lane_settings' accessing =
4 bytes in a region of size 1 [-Werror=3Dstringop-overflow=3D]
> >   426 |                         dp_decide_lane_settings(lt_settings, dp=
cd_lane_adjust,
> >       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~
> >   427 |                                         lt_settings->hw_lane_se=
ttings, lt_settings->dpcd_lane_settings);
> >       |                                         ~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_trainin=
g_fixed_vs_pe_retimer.c:426:25: note: referencing argument 4 of type 'union=
 dpcd_training_lane[4]'
> >
> > I'm not entirely sure what caused this, but changing the prototype to e=
xpect
> > a pointer instead of an array avoids the warnings.
> >
> > Fixes: 7727e7b60f82 ("drm/amd/display: Improve robustness of FIXED_VS l=
ink training at DP1 rates")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
>
> Thanks.
>
> > ---
> >  .../gpu/drm/amd/display/dc/link/protocols/link_dp_training.c    | 2 +-
> >  .../gpu/drm/amd/display/dc/link/protocols/link_dp_training.h    | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_trai=
ning.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
> > index 90339c2dfd84..5a0b04518956 100644
> > --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
> > +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
> > @@ -807,7 +807,7 @@ void dp_decide_lane_settings(
> >               const struct link_training_settings *lt_settings,
> >               const union lane_adjust ln_adjust[LANE_COUNT_DP_MAX],
> >               struct dc_lane_settings hw_lane_settings[LANE_COUNT_DP_MA=
X],
> > -             union dpcd_training_lane dpcd_lane_settings[LANE_COUNT_DP=
_MAX])
> > +             union dpcd_training_lane *dpcd_lane_settings)
> >  {
> >       uint32_t lane;
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_trai=
ning.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.h
> > index 7d027bac8255..851bd17317a0 100644
> > --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.h
> > +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.h
> > @@ -111,7 +111,7 @@ void dp_decide_lane_settings(
> >       const struct link_training_settings *lt_settings,
> >       const union lane_adjust ln_adjust[LANE_COUNT_DP_MAX],
> >       struct dc_lane_settings hw_lane_settings[LANE_COUNT_DP_MAX],
> > -     union dpcd_training_lane dpcd_lane_settings[LANE_COUNT_DP_MAX]);
> > +     union dpcd_training_lane *dpcd_lane_settings);
> >
> >  enum dc_dp_training_pattern decide_cr_training_pattern(
> >               const struct dc_link_settings *link_settings);
>
> --
> #Randy
> https://people.kernel.org/tglx/notes-about-netiquette
> https://subspace.kernel.org/etiquette.html

