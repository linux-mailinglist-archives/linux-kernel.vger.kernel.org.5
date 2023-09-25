Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CABC67AD9DF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 16:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbjIYOOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 10:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbjIYOOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 10:14:46 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366D8CE;
        Mon, 25 Sep 2023 07:14:40 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3add255c88aso4061859b6e.1;
        Mon, 25 Sep 2023 07:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695651279; x=1696256079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJfyUt1ShfjZl6t8cnVtNZYV0Rqi3aBl3H7mr80x/Gw=;
        b=JbWQ5Iz/GUZz9GMC8qoI3gy9GFRjgwCAZ4qS84sY4F9B+a/8vDDRrFDUpyGBNMmtYI
         Fc6wfuRYySfTSfDhM9KnOs/6k0QxO9XL8bQnVXZQaQ4WIyKV+yx8fPoSRGSJ8OOC7nCO
         2gd4j97YohuNZGLOnBuDVNmfHSJrBdzjCReQpIhwVxdemgNHmqP7AQhaww7ZkH/Sf1ze
         B+7EU6/1FDBDYP4Shrzj42np3547VTJfcwqj6dMnl3zx/t02nheTJG9iLJuD+iQ2i7bi
         olWG/yAeK6T4x9ggobE8nrByRrYuuXeRLHfFLTvSdtVmre4c2ENeBwh0TcLrc1sCDsWe
         D2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695651279; x=1696256079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJfyUt1ShfjZl6t8cnVtNZYV0Rqi3aBl3H7mr80x/Gw=;
        b=TJtdqz9qahgu/Vd9GVYX5gspgktM7sQi+OLl4H4fIaoARYBt01NHsa+x1DfVWDIio0
         9hoZOajFRzTY9Hq7NHkX0UQag3i8e3HMSsNQ1ZnQ21zjbcyxRR2jAQsICN2KV50XqN1F
         Gtay9Olrsgh5SM/6NybBSPX05SaJqMZJr/Zh9r8OazCKXaK6bCGMA5DfG/81dNufohgl
         dj4d+deONp+ylbwnJZDvvpyjlHiSV7qM4k0JNviR1/KMKn3QZV6W0FpbhYfXBLG2+aSL
         iR0OEtnxqLWGfGGf0x6Up94B01zLLERSFe6z73fddgDp4B0yCtRwlZFBOLkP4W0QTZBE
         gC8Q==
X-Gm-Message-State: AOJu0YzoSCghnomtSDg3nDneI1CRjnf6sJ30wMuJj8CT2K3lZIXO6pWz
        aJ7x8vDO0KpyQHPBXX/Jebh63GrnBz8YJJyVgZk=
X-Google-Smtp-Source: AGHT+IGzozeIAKQxxu15vnXC4O0U2/wFx2Ttdhu1Ykj7GBRveGIst2ctDf9dvYvaREsBKdttLh7p7tRIuZBiTVLnOX8=
X-Received: by 2002:a05:6871:c10:b0:1dc:dcf9:18d8 with SMTP id
 ve16-20020a0568710c1000b001dcdcf918d8mr4061353oab.24.1695651279489; Mon, 25
 Sep 2023 07:14:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230922173110.work.084-kees@kernel.org> <20230922173216.3823169-1-keescook@chromium.org>
 <CADnq5_P2p3bmczci=pU+pG6f9+hqn=-xp1EynP2345CJZRW08w@mail.gmail.com>
 <2635922e-f52a-4e91-40c6-4f1358972786@amd.com> <CADnq5_P1tg2-rWUmsRAy3aPJLT7ZmaZORMSOrPa6t6oSc5xS3g@mail.gmail.com>
In-Reply-To: <CADnq5_P1tg2-rWUmsRAy3aPJLT7ZmaZORMSOrPa6t6oSc5xS3g@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 25 Sep 2023 10:14:28 -0400
Message-ID: <CADnq5_P3xDDi-MS2PkAA7paAOQ3f7DQ8+sL6W7O5HcWTFQ0BSg@mail.gmail.com>
Subject: Re: [PATCH 1/9] drm/amd/pm: Annotate struct smu10_voltage_dependency_table
 with __counted_by
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Kees Cook <keescook@chromium.org>,
        David Airlie <airlied@gmail.com>,
        Tejas Upadhyay <tejas.upadhyay@intel.com>,
        Emma Anholt <emma@anholt.net>, Tom Rix <trix@redhat.com>,
        llvm@lists.linux.dev, dri-devel@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Prike Liang <Prike.Liang@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Matthew Brost <matthew.brost@intel.com>,
        Karol Herbst <kherbst@redhat.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        amd-gfx@lists.freedesktop.org,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Nathan Chancellor <nathan@kernel.org>,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        nouveau@lists.freedesktop.org, David Airlie <airlied@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-hardening@vger.kernel.org, Lijo Lazar <lijo.lazar@amd.com>,
        Yifan Zhang <yifan1.zhang@amd.com>,
        linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        Kevin Wang <kevin1.wang@amd.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Melissa Wen <mwen@igalia.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Evan Quan <evan.quan@amd.com>, Sean Paul <sean@poorly.run>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>, Le Ma <le.ma@amd.com>,
        freedreno@lists.freedesktop.org,
        Bjorn Andersson <andersson@kernel.org>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Nirmoy Das <nirmoy.das@intel.com>, Lang Yu <Lang.Yu@amd.com>,
        John Harrison <john.c.harrison@intel.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
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

On Mon, Sep 25, 2023 at 10:07=E2=80=AFAM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
>
> On Mon, Sep 25, 2023 at 2:30=E2=80=AFAM Christian K=C3=B6nig
> <christian.koenig@amd.com> wrote:
> >
> > Am 22.09.23 um 19:41 schrieb Alex Deucher:
> > > On Fri, Sep 22, 2023 at 1:32=E2=80=AFPM Kees Cook <keescook@chromium.=
org> wrote:
> > >> Prepare for the coming implementation by GCC and Clang of the __coun=
ted_by
> > >> attribute. Flexible array members annotated with __counted_by can ha=
ve
> > >> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_=
BOUNDS
> > >> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-fa=
mily
> > >> functions).
> > >>
> > >> As found with Coccinelle[1], add __counted_by for struct smu10_volta=
ge_dependency_table.
> > >>
> > >> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examp=
les/counted_by.cocci
> > >>
> > >> Cc: Evan Quan <evan.quan@amd.com>
> > >> Cc: Alex Deucher <alexander.deucher@amd.com>
> > >> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> > >> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> > >> Cc: David Airlie <airlied@gmail.com>
> > >> Cc: Daniel Vetter <daniel@ffwll.ch>
> > >> Cc: Xiaojian Du <Xiaojian.Du@amd.com>
> > >> Cc: Huang Rui <ray.huang@amd.com>
> > >> Cc: Kevin Wang <kevin1.wang@amd.com>
> > >> Cc: amd-gfx@lists.freedesktop.org
> > >> Cc: dri-devel@lists.freedesktop.org
> > >> Signed-off-by: Kees Cook <keescook@chromium.org>
> > > Acked-by: Alex Deucher <alexander.deucher@amd.com>
> >
> > Mhm, I'm not sure if this is a good idea. That is a structure filled in
> > by the firmware, isn't it?
> >
> > That would imply that we might need to byte swap count before it is
> > checkable.
>
> True. Good point.  Same for the other amdgpu patch.

Actually the other patch is fine.  That's just a local structure.

Alex

>
> Alex
>
> >
> > Regards,
> > Christian.
> >
> > >
> > >> ---
> > >>   drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.h | 2 +-
> > >>   1 file changed, 1 insertion(+), 1 deletion(-)
> > >>
> > >> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.h b/=
drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.h
> > >> index 808e0ecbe1f0..42adc2a3dcbc 100644
> > >> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.h
> > >> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.h
> > >> @@ -192,7 +192,7 @@ struct smu10_clock_voltage_dependency_record {
> > >>
> > >>   struct smu10_voltage_dependency_table {
> > >>          uint32_t count;
> > >> -       struct smu10_clock_voltage_dependency_record entries[];
> > >> +       struct smu10_clock_voltage_dependency_record entries[] __cou=
nted_by(count);
> > >>   };
> > >>
> > >>   struct smu10_clock_voltage_information {
> > >> --
> > >> 2.34.1
> > >>
> >
