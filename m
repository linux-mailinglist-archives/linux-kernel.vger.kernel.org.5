Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E9E7E6862
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 11:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbjKIKiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 05:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbjKIKiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 05:38:20 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93311211B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 02:38:18 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso584220a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 02:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1699526298; x=1700131098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmFf27EdTViei+rx09X875KNUOWxvPdfwYwyu2/XAyU=;
        b=fDSN9AKO1rJ6J4ztpZFQxvSn0Lyxz04kwZmLqjvmLrWBisJ0SfUdpdqDhwnm3k27Rh
         z4U17dDV54PnaT19NlV0Y8tWbMpFXwH0kFpFAU693ssuh7Gdq/TU5/2QjWNGChc+UDC3
         jPaKD28DJlj56SpGFvIthXh8YfmXrs/j/o8wjqRY62lKXAcEN1HvpmcZGfO61oyaid3h
         cM9TWhu+QBapFt9/PBEWH09vn+r28fMa5LHj2ihKW3WoHejsKvq9w9hQgxO3h+CUkm4I
         fCOzl73Qzc1uME078PiUhu5uCgjbBWRGmZY8I2W5ehfLte74jnai9i1Igkw99XYxqy6m
         T4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699526298; x=1700131098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SmFf27EdTViei+rx09X875KNUOWxvPdfwYwyu2/XAyU=;
        b=Cpa6SMxUEos+oLPk0PWn+B1iPwcA4muWWlQ9FlVYArF9Y1UTfQOq2tDuvSco0PtT1B
         8XAJlAaBaM3IJUF/Q6/wRyqYljGCXtGbqA3wIMHjlxzumBQL4q4hVc+flD+BZFicFY/q
         dukphkjyT+59O9KNow+j4e43nN/F1N6PyUZZLMC6sWu4xUDOR0JL6BPAjCQNfCbKSv+b
         tKPmKgWSZY0RJaobaGVjv054fOFFIBfc4OwUSJPEUPN0T01A4IFy/qgAOseeIthu5P4F
         lsSGyGp4TN3U/8Cdz78p1GxILBt6cOCdSA8SfJLfrhAGQoxMSpE2JMB1qmS7gbEqYV9N
         1oNw==
X-Gm-Message-State: AOJu0YyiYKhnBrJdDqaAkNcAoIkPcR9xxjqwOiuVc/73GXFqqm1ZtyJ6
        YuNl0ngvf7k+BQFBrrPeNxT1FfGaKnLlWaahBwBIpQ==
X-Google-Smtp-Source: AGHT+IEoOyiZ9nU5Ns70/ZXOsQC2eTmJROwHvQ2lU5+FPSfwRLrrvWwlNdBg8x89QOGGNa2hlECIq2feY7jHc26h/h0=
X-Received: by 2002:a17:90b:4a85:b0:27d:8ad:c4e1 with SMTP id
 lp5-20020a17090b4a8500b0027d08adc4e1mr1268664pjb.19.1699526298042; Thu, 09
 Nov 2023 02:38:18 -0800 (PST)
MIME-Version: 1.0
References: <20231005133059.917577-1-naresh.solanki@9elements.com>
 <f8dd6d53-7c0b-4a89-9ec4-400aa242c020@sirena.org.uk> <CABqG17iufSniSLZ2vU5fFduFwV2FL8jNzMcsveOgFUME1jXmgg@mail.gmail.com>
 <aa3f5615-dddf-4c94-88c7-494cf7cd80ab@sirena.org.uk> <CABqG17h949R+3NFgA1MvPLZFc6zkBi+WRPSE9qP4fCBv5gdXHw@mail.gmail.com>
 <c2dd0533-3a60-4481-8621-86578e62aab6@sirena.org.uk> <CABqG17h0OnMD-L1vYkJobji+Z=QPuYrd=ra1d7DncAN0_TO23A@mail.gmail.com>
 <f5829ebc-b3ab-409b-9271-e066c08aec6e@sirena.org.uk>
In-Reply-To: <f5829ebc-b3ab-409b-9271-e066c08aec6e@sirena.org.uk>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Thu, 9 Nov 2023 16:08:06 +0530
Message-ID: <CABqG17iBsEO-NnRvgFJ9e5PvT7q+HgLyiDDfO5GcvXh4ueySsA@mail.gmail.com>
Subject: Re: [PATCH] drivers/regulator: Notify sysfs about status changes
To:     Mark Brown <broonie@kernel.org>
Cc:     zev@bewilderbeest.net, Liam Girdwood <lgirdwood@gmail.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Thu, 2 Nov 2023 at 22:20, Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Nov 02, 2023 at 09:03:40PM +0530, Naresh Solanki wrote:
> > On Thu, 2 Nov 2023 at 20:31, Mark Brown <broonie@kernel.org> wrote:
>
> > > That's the opposite sense to what I was thinking of - we're reporting
> > > voltage changes and enables to userspace rather than just errors.  My
> > > concern here is that this could generate an awful lot of notificaiton=
s
> > > for normal operation on systems that don't use the uevents, I was
> > > expecting this to be used for errors.  Could you remind me what the u=
se
> > > case is here, I think I might've got myself confused sorry?
>
> > Sorry for confusion caused because I should first described my applicat=
ion
> > requirements.
> > Currently my application is interested in know regulator status i.e.,
> > ENABLE, DISABLE or ERROR.
> > Also events are needed specifically to get them logged like
> > UNDER_VOLTAGE, OVER_CURRENT, REGULATION_OUT,
> > OVER_TEMP.
>
> Ah, right.  Everything except for the enable and disable there looks
> like it should be OK since they should normally just not happen but the
> enables and disables might get a bit frequent with runtime PM - not
> *super* frequent like voltage scaling but enough that people could have
> an issue with it.
I aim for a straightforward implementation.
Using attributes such as status or state seems ideal for receiving
notifications.
In my case, the application focuses on status changes=E2=80=94whether it's =
on, off,
or encountering an error.
These changes are driven by events originating from the regulator.
So below change is what I see fit well.

        status_events =3D REGULATOR_EVENT_DISABLE;
        status_events |=3D REGULATOR_EVENT_ENABLE;
        status_events |=3D REGULATOR_EVENT_FAIL;
        status_events |=3D REGULATOR_EVENT_FORCE_DISABLE;
        status_events |=3D REGULATOR_EVENT_ABORT_DISABLE;

        if (event & status_events) {
                name =3D dev_attr_status.attr.name;
                sysfs_notify(&rdev->dev.kobj, NULL, name);
        }

Let me know if this can be further tuned to be better..

Regards,
Naresh

>
> Netlink feels like it might be a better fit?  Not really looked at the
> kernel side of implementing that and how sensible that ends up looking.
