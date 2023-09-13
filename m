Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3E179E81B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240538AbjIMMdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 08:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240320AbjIMMde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:33:34 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDCA19A8;
        Wed, 13 Sep 2023 05:33:30 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-6535b9caa1eso3992106d6.0;
        Wed, 13 Sep 2023 05:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694608409; x=1695213209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysLRCSCseChx5cOJvuBYixpbGJfXQ1OhPZDgx6AbVWw=;
        b=boQRkxwHQcLQFgGYT2JEp+q7hrpPtpHHzTpr7zbnUkSOvXNnlw1qZWtMx0hNC1jkDo
         L7brFGvhQTBZtv/vMQ6l8C/dQ4Whei5pfIdfcUnyfL8H7kqE1L9fAW8/HOvI4aOZKch+
         zcB77Bq0Op98rf4VgTjPvTaL1Q4WapRBH0hhkUCiHQYpGft6LJBzY8LuQJY7LEKO8H6F
         w8lzzsC42FxpMFJz3XzxxD2cO6jzBNDz4ZHMK3UiyBtlJYbUgheiy9ict3zgULuJGU6b
         iJt3teALtDQ2p3/ISEv78QCYzx/rRVudiyuF3Woh0YfTJXczxXRvg4A/wJCCDYYet5Qd
         x6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694608409; x=1695213209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ysLRCSCseChx5cOJvuBYixpbGJfXQ1OhPZDgx6AbVWw=;
        b=i3s52+z4tvMPIqBJpbC+lJTylGRaex5laZpZlvfhjFqv2dNxKMmpkbneNi1LsUk4CZ
         ssr/F+3UbjU379mwbyzgUXAIC/HR3r4nfoyLF/kc3VctyxE1ettfM4Xsi9FrT1oPfTIj
         +VrPD/KqL6aUnASK1hPvCke6zHG8vg8Oy8zPeiD+uFpsVgPHQJ4VOCVLa7P5tTUSOKf5
         fC4yuGzc0ISewYR0TydZMweCIqDPGhwL9N46hbujhb8fxoqtwvA3IDz0qPhuopTFBpbj
         LTRiVATEWyG3KxC1q7fSnE86tCHKyIBXRJPsagYq7cLOCtzbhfs8ybpgzkhl0fSahCRj
         kRSw==
X-Gm-Message-State: AOJu0YycA/ZKWq9wewJixoF4tENX9fApUmjtH98MLddcfFBVAbOf6M3N
        0Fg+Qbk12PeS6O1u9KApy2hIrLNlalL/02famlY=
X-Google-Smtp-Source: AGHT+IGKRjcd6Xur9DLhXiRqEIk4Ej1ss94os770k+uNurBWwY50rkOkRZhPZDxuuhLxdm0R/zpBBduch62W70VRHXs=
X-Received: by 2002:a0c:f54d:0:b0:64c:56c9:c2bd with SMTP id
 p13-20020a0cf54d000000b0064c56c9c2bdmr2445264qvm.31.1694608409161; Wed, 13
 Sep 2023 05:33:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230710033234.28641-1-di.shen@unisoc.com> <6d3f24a4-ae70-49eb-6e41-86baa1db6bed@linaro.org>
 <CAHYJL4og14kQ4ev6QtDQeknJELME7URTN_HmR01P5+2RhpthzQ@mail.gmail.com>
 <f7cf2153-aa22-d376-f776-54ea940a5e35@linaro.org> <CAHYJL4p7FEjLTZURA6fvVPCmwKodmxWS7fNpi_c0ZFBX7yjDZQ@mail.gmail.com>
 <33508f0e-414f-a990-29ad-58e43d20374b@linaro.org> <0844022b-cf2a-dadb-9340-9107cd40169b@arm.com>
In-Reply-To: <0844022b-cf2a-dadb-9340-9107cd40169b@arm.com>
From:   Di Shen <cindygm567@gmail.com>
Date:   Wed, 13 Sep 2023 20:33:18 +0800
Message-ID: <CAHYJL4qhXUDhuHzUHgWStXR+Lkc5z0M1vrmKaS3u05cbv0NtCQ@mail.gmail.com>
Subject: Re: [PATCH V5] thermal/core/power_allocator: reset thermal governor
 when trip point is changed
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Di Shen <di.shen@unisoc.com>, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xuewen.yan@unisoc.com,
        jeson.gao@unisoc.com, orsonzhai@gmail.com, zhanglyra@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On Mon, Jul 17, 2023 at 6:06=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
> Hi Daniel,
>
>
> On 7/11/23 09:23, Daniel Lezcano wrote:
> >
> > Hi Di,
> >
> > On 11/07/2023 05:40, Di Shen wrote:
> >
> > [ ... ]
> >
> >>>>>> +static void power_allocator_reset(struct thermal_zone_device *tz)
> >>>>>> +{
> >>>>>> +     struct power_allocator_params *params =3D tz->governor_data;
> >>>>>> +
> >>>>>> +     reset_pid_controller(params);
> >>>>>> +     allow_maximum_power(tz, true);
> >>>>>
> >>>>> Do you really want to allow the maximum power? What about if the tr=
ip
> >>>>> temperature is decreased ?
> >>>>>
> >>>> If the trip temperature is decreased, allow_maximum_power will only
> >>>> be executed once, and then the ipa governor will adapt to the lower
> >>>> trip
> >>>> temperature and calculate the allocated power for cooling actors aga=
in.
> >>>> Right?
> >>>
> >>> Sorry for jumping in this fifth version but I'm not sure about resett=
ing
> >>> the change is the right way (and probably, changing a trip point with
> >>> the power allocator is not a good idea)
> >>>
> >>> The platforms where the IPA is planned to be used are creating a dumm=
y
> >>> trip point where the IPA begins the acquisition without cooling devic=
es
> >>> in order to have the math building the PID schema (eg. hi3660.dtsi).
> >>>
> >>> What about the sustainable power vs the trip point temperature? I mea=
n
> >>> we can change the trip temperature but not the sustainable power whic=
h
> >>> is directly related to the target temperature. So the resulting power
> >>> computation will be wrong.
> >>>
> >> I totally agree, thanks for reminding me. Sustainable power is the
> >> maximum
> >> power available at the target temperature, so it must be updated when
> >> the trip
> >> point is changed. Sorry for missing this point. How about calling
> >> get_sustainable_power() to update the sustainable_power? Furthermore,
> >> when
> >> the sustainble_power() is changed, the pid constants tzp->k_* must be
> >> estimated
> >> again. In get_sustainble_power, it checks that the sustainable_power
> >> is updated,
> >> it will call the estimate_pid_constants() to renew the tzp->k_*.
> >
> > Yes and the sustainable power can be set from userspace too.
> >
> > So here we have to distinguish what is related to the thermal setup and
> > the thermal usage.
> >
> > Actually the thermal framework should protect the information from the
> > firmware. It is not acceptable to have an user being able to change the
> > trip points provided by the firmware.
> >
> > The writable trip point should allow only temperature changes below the
> > ones given in the firmware.
> >
> >>> The more I think about that, the more I do believe writable trip poin=
t
> >>> and IPA are incompatible.
> >>>
> >>> What about forbid that?
> >>>
> >>> For instance, add a set_trip callback instead of resetting in the
> >>> governor and return -EPERM from the IPA?
> >>>
> >> I've seen that you have sent a patch recently which adds the callback
> >> thermal_zone_trips_update(), is that what you said set_trip callback?
> >
> > Not exactly.
> >
> > Instead of adding a 'reset' callback, add a 'trip_update' (or whatever
> > the name) callback.
> >
> > Then pass the trip point to the callback along with the thermal zone.
> >
> > int ipa_trip_update(struct thermal_zone_device *tz,
> >              struct thermal_trip *trip)
> > {
> >      // Do more IPA crazy stuff or return -EPERM
> > }
> >
> >
> >>> Lukasz ?
> >
> > Lukasz? what do you think?
> >
> >
>
> My apologies for delay, I was on 2-weeks vacation. I'll catch up and
> respond to those questions.
>
> Regards,
> Lukasz

What do you think about the points that Daniel has mentioned? Any
comments would be very appreciated, hope to hear from you, thank you.

Best regards,
Di
