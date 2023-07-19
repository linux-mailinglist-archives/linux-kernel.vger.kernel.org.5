Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5534C75925F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjGSKJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGSKJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:09:27 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391C2E69;
        Wed, 19 Jul 2023 03:09:26 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-992acf67388so824782666b.1;
        Wed, 19 Jul 2023 03:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689761365; x=1690366165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GDNwH3HNE0FsRRgZD2/PtyPc5UbtacjX+R2TbQgSYw=;
        b=ol9tjXotX3OmlRRDr1uVMwxNBGtzw/4HpR/vj1sFVg2NUpf94JXHFtbrNOWq6VS4iD
         uQUHmwnEqvjzT/7n71IMcOddbREBD94fBWcrKdiS6PZWsO8i27Ko8O7/xEB7nb53MxV/
         fu5MjfHVcuL9sx6On3XqizR73DzeKjesYmf/MNDvRMReIW318aIRNU7fAUK7C27WyMg0
         7Vqt2QYj22cJ1s4H6aJWkVpvC4r27OV+c1OwwQQrOxUzaTCAL2Gl9auYx+RJrlfE75Gp
         yGDUxGbcSjEfU+RV1NgS5m+DMR/r++nqzqqpFqeMeUz3QojKJdcuv/ULWdFxvGzAZuZW
         67oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689761365; x=1690366165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GDNwH3HNE0FsRRgZD2/PtyPc5UbtacjX+R2TbQgSYw=;
        b=A9Ofj7pgYdNOJ1zj1sEoZyxDIKnTEzC+PRIKliQ/yrTkD0ETz/vQwP+CeTYvbNWGRQ
         9pTvzfAzYtFErM733MIceT11pNJZ1I43qrVZYer3nXpRjw4J3WPPbf8RhBFoFV4CG7Vt
         zFVZE3GahnsqPAlTTUt4mvP7X4O1bBXrioq0WOa8QwLXtmH/R8nibfiF5MgWeieB8NXf
         Ce61uGeuWmjLaVU0NEdRmpI1RxaqhaP9Z55ZSqgM8j5wnwCJxRdEpHG+w3PqrpE8S4Ey
         nEW5sguiziH2krZWjciDnlIicaQEvbiq2D/kYT7DOyeVo5kt6h3OgRpGuQbzaT1kd6lt
         57Qg==
X-Gm-Message-State: ABy/qLaPTIQnwMM8RNieapp8fzbqF6Chakdg6Gpewz5ItWvxntnqENPG
        4rduzkp9AAYav+hzcUXd+OJ6gIFPcoSHN/wDpnY=
X-Google-Smtp-Source: APBJJlGva/2jpmmraE+ZwDdpr/EWe24LQyi64H0jhQnxCqK030YkjHZDPgbUn7Faq5HVeAL3PIT74a7SBff9wdoq6i0=
X-Received: by 2002:a17:906:5358:b0:96a:52e:5379 with SMTP id
 j24-20020a170906535800b0096a052e5379mr1937947ejo.63.1689761364363; Wed, 19
 Jul 2023 03:09:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230712084840.3594-1-di.shen@unisoc.com> <47ded4da-5c39-9132-7978-d0f8c8ee0318@arm.com>
In-Reply-To: <47ded4da-5c39-9132-7978-d0f8c8ee0318@arm.com>
From:   Di Shen <cindygm567@gmail.com>
Date:   Wed, 19 Jul 2023 18:09:12 +0800
Message-ID: <CAHYJL4o5yPEFMEHBuTCmC1d6qsw52LWr222_xibmGXcP3=052w@mail.gmail.com>
Subject: Re: [PATCH] Revert "thermal: power allocator: change the 'k_*' always
 in estimate_pid_constants()"
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Di Shen <di.shen@unisoc.com>, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, rafael@kernel.org, daniel.lezcano@linaro.org,
        linux-kernel@vger.kernel.org, xuewen.yan@unisoc.com,
        jeson.gao@unisoc.com, orsonzhai@gmail.com, zhanglyra@gmail.com,
        amitk@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,
I'm happy to hear from you :)

On Wed, Jul 19, 2023 at 4:50=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
> Hi Di,
>
> On 7/12/23 09:48, Di Shen wrote:
> > This reverts commit 90a996544946d1d4834ec2ec8add586edd905779.
> >
> > The commit ensures that the pid constants are updated when
> > sustainable_power changes, but it makes it impossible for
> > the driver to set the pid constants when the sustainable_power
> > is not changed.
> >
> > When the driver tries to register a thermal zone device by
> > thermal_zone_device_register_with_trips(const char *type,
> >       struct thermal_trip *trips, int num_trips, int mask,
> >       void *devdata, struct thermal_zone_device_ops *ops,
> >       struct thermal_zone_params *tzp, int passive_delay,
> >       int polling_delay)
> > and passes the private thermal_zone_params structure data,
> >
> > thermal_zone_devcice_register_with_trips
> >       |
> > thermal_set_governor
> >       |
> > bind_to_tz
> >       |
> > power_allocator_bind
> >       |
> > estimate_pid_constants
> >
> > the tzp->k_* will not be the data that driver have given,
> > but the data estimated by sustainable_power.
> >
> > To make it possible for driver to add its own pid constants,
>
> That was dropped, the drivers shouldn't configure 'k_*' IPA
> parameters. There was also an ask to add those parameter
> values to the DT for setup - also not allowed.
>
> > the 'force' flag is needed to indicate whether the tzp->k_*
> > should be estimated by sustainable_power or not.
>
> We don't want to maintain many different ways of configurations,
> which can cause bugs in not tested corner cases.
>
Ok, I understand.

> Please use the user-space to change those 'k_*' parameters.
> There are this dedicated and safe sysfs interfaces for each
> thermal zone.
>
> The phones that I have on my desk do the update of 'k_*' parameters via
> sysfs. They do this in different scenarios. You can try to derive
> best 'k_*' values for your workload scenarios and than save
> them in the config file. You can update in runtime from user-space
> when you switch to your scenario (e.g. camera, game, video call).
>
Thank you for your kind suggestions, Lukasz. Now I totally understand.
Thank you.

> Regards,
> Lukasz

Best regards,
Di
