Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1089178C710
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236880AbjH2OOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236947AbjH2OOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:14:08 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B32BCC4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:13:59 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-44e84fbaab9so2012508137.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1693318438; x=1693923238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39bXmTr9o4j46Blz1DGjW7i8kc3+09Rh5ttDbKYOLuM=;
        b=Twz8DD8q5NiEFnUoOothYl9tZpQuExo2vhq45zvc/ZuLepSM4s2ZvtdMPL1pbFKTq1
         5KLZ+KDFFMdIx+W20C0ff4Lsf1lVYjnz8LbbMJQv1YUM5PfoJ2JREhBm0Qk62G4/8wZ/
         TTfEXrKOxXpeg4JzjsLV+AQC4e2cJCJ4jlYba4XsUQY5GzVTwPG3Z//muM6iAtxv3MM7
         8Km2rHtK6RS0/FHylLzA6UN1caACWeFrf2Rg7MKkEOxzgBmtZFTphbRLIFRdvRbGtfnr
         RjqAODnHgKaPIm0G5rkBaU665cnCpGuoG8CrF2YFWbrX/TITVo/uzq8QvcLQ8uQFTypZ
         L+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693318438; x=1693923238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=39bXmTr9o4j46Blz1DGjW7i8kc3+09Rh5ttDbKYOLuM=;
        b=JH9CozbCFebnteFvezRJEh6merstDHdLqFdLfu7LqMU/JQ39+YZ5XMxI/dBiDMbQqb
         qnSG1xqNUQcwIrMq0XRBottvHudSsbdf3Kaim284wCh12+EQgpWcv74pOVmfMY7v+gLU
         Xm/f9U+vZfcia/3nZaFn2dDtAkEHyxEtgbmke4ppbIMhGch1kEGD16FLCcOFnIj46pCc
         pMOOapB2BviuvvjK8JIgotfBYqHby8jTe1IRiQ3TzUlkRGx+VD0FeuroD+JBZFuTlRnc
         HoC6qBKe9h33SK/KVDMeVNTXDBI7OUswtP1r8f4YszeuEV1A325uotlVZXZnIAdZsfE+
         obLw==
X-Gm-Message-State: AOJu0Yyd9aiMZmWvMLwAtUv7rgbuXN/xGB2ZFbBoehyzxlnndNeQYE0j
        7rnUzKh6fKFpcytP7ak+1E6H2IPkXXNY45j7f/bkCg==
X-Google-Smtp-Source: AGHT+IG6pEXSN4/wB67twAtWXWyJhYwM2WMVCHmP8Qj9CM47h2hB8QNcdxKURRnQDfAXfpis4PQjHiiGhccGrsiqq6M=
X-Received: by 2002:a67:e245:0:b0:44e:eb7:24e0 with SMTP id
 w5-20020a67e245000000b0044e0eb724e0mr17087974vse.21.1693318438359; Tue, 29
 Aug 2023 07:13:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230725-visionox-vtdr-prev-first-v1-1-3bc44cec7dc6@quicinc.com>
 <dde2774e-6f0b-21d0-e9c9-4a5bd1eac4e8@linaro.org> <2f9a9450-438b-257d-759c-22b273a7b35d@quicinc.com>
 <c183d823-81d4-6d7c-98d9-649fa4041262@quicinc.com> <6c0dd9fd-5d8e-537c-804f-7a03d5899a07@linaro.org>
 <548b0333-103b-ac66-0fc5-f29e7cc50596@quicinc.com> <6e1f6cb7-7f88-48dc-b494-1a5e990e1a33@linaro.org>
 <ff1b04c3-c852-4e28-9054-3cebb4ca5d6e@linaro.org> <c7c5c8f0-16e6-47bd-94e8-ce924163dfd3@linaro.org>
 <giimknikofbipipawfmrcjiar5qfyw3t7sqy3iewjahsm3ktkt@qcn4g23zfcnj>
 <76e76728-974e-46ff-8046-c61c54d07c76@linaro.org> <54b37d60-61b1-e939-c71d-30aecad65598@quicinc.com>
 <0cb96702-b396-4223-870f-b798d32991ee@linaro.org>
In-Reply-To: <0cb96702-b396-4223-870f-b798d32991ee@linaro.org>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 29 Aug 2023 15:13:42 +0100
Message-ID: <CAPY8ntDf+sD-2mtLBxfrMKQiW5YYi6cfmCe2Sm8CYK9kO3W+nQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: Add prepare_prev_first flag to Visionox VTDR6130
To:     neil.armstrong@linaro.org
Cc:     Jessica Zhang <quic_jesszhan@quicinc.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        quic_parellan@quicinc.com,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil

On Mon, 28 Aug 2023 at 09:49, <neil.armstrong@linaro.org> wrote:
>
> Hi Jessica,
>
> On 25/08/2023 20:37, Jessica Zhang wrote:
> >
> >
> > On 8/21/2023 3:01 AM, neil.armstrong@linaro.org wrote:
> >> Hi Maxime,
> >>
> >> On 21/08/2023 10:17, Maxime Ripard wrote:
> >>> Hi,
> >>>
> >>> On Fri, Aug 18, 2023 at 10:25:48AM +0200, neil.armstrong@linaro.org w=
rote:
> >>>> On 17/08/2023 20:35, Dmitry Baryshkov wrote:
> >>>>> On 16/08/2023 10:51, neil.armstrong@linaro.org wrote:
> >>>>>> Sending HS commands will always work on any controller, it's all
> >>>>>> about LP commands. The Samsung panels you listed only send HS
> >>>>>> commands so they can use prepare_prev_first and work on any
> >>>>>> controllers.
> >>>>>
> >>>>> I think there is some misunderstanding there, supported by the
> >>>>> description of the flag.
> >>>>>
> >>>>> If I remember correctly, some hosts (sunxi) can not send DCS
> >>>>> commands after enabling video stream and switching to HS mode, see
> >>>>> [1]. Thus, as you know, most of the drivers have all DSI panel setu=
p
> >>>>> commands in drm_panel_funcs::prepare() /
> >>>>> drm_bridge_funcs::pre_enable() callbacks, not paying attention
> >>>>> whether these commands are to be sent in LP or in HS mode.
> >>>>>
> >>>>> Previously DSI source drivers could power on the DSI link either in
> >>>>> mode_set() or in pre_enable() callbacks, with mode_set() being the
> >>>>> hack to make panel/bridge drivers to be able to send commands from
> >>>>> their prepare() / pre_enable() callbacks.
> >>>>>
> >>>>> With the prev_first flags being introduced, we have established tha=
t
> >>>>> DSI link should be enabled in DSI host's pre_enable() callback and
> >>>>> switched to HS mode (be it command or video) in the enable()
> >>>>> callback.
> >>>>>
> >>>>> So far so good.
> >>>>
> >>>> It seems coherent, I would like first to have a state of all DSI hos=
t
> >>>> drivers and make this would actually work first before adding the
> >>>> prev_first flag to all the required panels.
> >>>
> >>> This is definitely what we should do in an ideal world, but at least =
for
> >>> sunxi there's no easy way for it at the moment. There's no documentat=
ion
> >>> for it and the driver provided doesn't allow this to happen.
> >>>
> >>> Note that I'm not trying to discourage you or something here, I'm sim=
ply
> >>> pointing out that this will be something that we will have to take in=
to
> >>> account. And it's possible that other drivers are in a similar
> >>> situation.
> >>>
> >>>>> Unfortunately this change is not fully backwards-compatible. This
> >>>>> requires that all DSI panels sending commands from prepare() should
> >>>>> have the prepare_prev_first flag. In some sense, all such patches
> >>>>> might have Fixes: 5ea6b1702781 ("drm/panel: Add prepare_prev_first
> >>>>> flag to drm_panel").
> >>>>
> >>>> This kind of migration should be done *before* any possible
> >>>> regression, not the other way round.
> >>>>
> >>>> If all panels sending commands from prepare() should have the
> >>>> prepare_prev_first flag, then it should be first, check for
> >>>> regressions then continue.
> >>>>
> >>>> <snip>
> >>>>
> >>>>>>
> >>>>>> I understand, but this patch doesn't qualify as a fix for
> >>>>>> 9e15123eca79 and is too late to be merged in drm-misc-next for
> >>>>>> v6.6, and since 9e15123eca79 actually breaks some support it
> >>>>>> should be reverted (+ deps) since we are late in the rc cycles.
> >>>>>
> >>>>> If we go this way, we can never reapply these patches. There will b=
e
> >>>>> no guarantee that all panel drivers are completely converted. We
> >>>>> already have a story without an observable end -
> >>>>> DRM_BRIDGE_ATTACH_NO_CONNECTOR.
> >>>>
> >>>> I don't understand this point, who would block re-applying the patch=
es ?
> >>>>
> >>>> The migration to DRM_BRIDGE_ATTACH_NO_CONNECTOR was done over multip=
le
> >>>> Linux version and went smoothly because we reverted regressing patch=
es
> >>>> and restarted when needed, I don't understand why we can't do this
> >>>> here aswell.
> >>>>
> >>>>> I'd consider that the DSI driver is correct here and it is about th=
e
> >>>>> panel drivers that require fixes patches. If you care about the
> >>>>> particular Fixes tag, I have provided one several lines above.
> >>>>
> >>>> Unfortunately it should be done in the other way round, prepare for
> >>>> migration, then migrate,
> >>>>
> >>>> I mean if it's a required migration, then it should be done and I'll
> >>>> support it from both bridge and panel PoV.
> >>>>
> >>>> So, first this patch has the wrong Fixes tag, and I would like a
> >>>> better explanation on the commit message in any case. Then I would
> >>>> like to have an ack from some drm-misc maintainers before applying i=
t
> >>>> because it fixes a patch that was sent via the msm tree thus per the
> >>>> drm-misc rules I cannot apply it via the drm-misc-next-fixes tree.
> >>>
> >>> Sorry, it's not clear to me what you'd like our feedback on exactly?
> >>
> >> So let me resume the situation:
> >>
> >> - pre_enable_prev_first was introduced in [1]
> >> - some panels made use of pre_enable_prev_first
> >> - Visionox VTDR6130 was enabled on SM8550 systems and works on v6.5 ke=
rnels and before
> >> - patch [2] was introduced on MSM DRM tree, breaking VTDR6130 on SM855=
0 systems (and probably other Video mode panels on Qcom platforms)
> >> - this fix was sent late, and is now too late to be merged via drm-mis=
c-next
> >
> > Hi Neil and Maxime,
> >
> > I agree with Neil that 9e15123eca79 was the commit that introduced the =
issue (since it changed the MSM DSI host behavior).
> >
> > However, I'm not too keen on simply reverting that patch because
> >
> > 1) it's not wrong to have the dsi_power_on in pre_enable. Arguably, it =
actually makes more sense to power on DSI host in pre_enable than in modese=
t (since modeset is meant for setting the bridge mode), and
>
> I never objected that, it's the right path to go.
>
> >
> > 2) I think it would be good practice to keep specific bridge chip check=
s out of the DSI host driver.
>
> We discussed about a plan with Maxime and Dmitry about that, and it would=
 require adding
> a proper atomic panel API to handle a "negociation" with the host control=
ler.
>
> >
> >
> > That being said, what do you think about setting the default value of p=
repare_prev_first to true (possibly in panel_bridge_attach)?
>
> As Dmitry pointed, all panels sending LP commands in pre_enable() should =
have prepare_prev_first to true.

Any panel wishing the clock and data lanes to be in a defined LP-11
state before pre_enable() is called need to set prepare_prev_first to
true. This is not a universal requirement of all DSI peripherals for
which commands are sent from pre_enable - a number will happily power
up at LP-00.
It is true that no harm will occur on those devices that do support
non-LP-11 power up if the host is in LP-11, so a blanket setting of
the flag for any panel driver sending DSI commands in pre_enable
should be safe.

It is documented [1] that transfer can be called at any time,
regardless of the state of the host. The MSM driver isn't supporting
that, hence issues.
[2] further clarifies that it is expected to power up the host
controller, send the message, and power down again.

[1] https://github.com/torvalds/linux/blob/master/include/drm/drm_mipi_dsi.=
h#L84-L87
[2] https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/drm_bridg=
e.c#L185-L188

> >
> > It seems to me that most panel drivers send DCS commands during pre_ena=
ble, so maybe it would make more sense to power on DSI host before panel en=
able() by default. Any panel that needs DSI host to be powered on later cou=
ld then explicitly set the flag to false in their respective drivers.
>
> A proper migration should be done, yes, but not as a fix on top of v6.5.

I looked at this when adding prepare_prev_first, but as the DSI
control path is separate from the bridge chain there's no obvious way
to automatically set a bridge flag from the mipi_dsi registration.

  Dave

> Neil
>
> >
> > Thanks,
> >
> > Jessica Zhang
> >
> >
> >>
> >> I do not consider it's the right way to fix regression caused by [2]
> >> I consider [2] should be reverted, panels migrated to pre_enable_prev_=
first when needed, tested and the [2] applied again
> >>
> >> I have no objection about [2] and it should be done widely over the wh=
ole DSI controllers
> >> and DSI Video panels.
> >>
> >> I also object about the Fixes tag of this patch, which is wrong, and D=
mitry considers [1]
> >> should be used but it's even more wrong since [2] really caused the re=
gression.
> >>
> >> And if [2] was to correct one to use, it was pushed via the MSM tree s=
o it couldn't be
> >> applied via drm-misc-next-fixes, right ?
> >>
> >> [1] 4fb912e5e190 ("drm/bridge: Introduce pre_enable_prev_first to alte=
r bridge init order")
> >> [2] 9e15123eca79 ("drm/msm/dsi: Stop unconditionally powering up DSI h=
osts at modeset")
> >>
> >> Thanks,
> >> Neil
> >>
> >>>
> >>> Maxime
> >>
>
