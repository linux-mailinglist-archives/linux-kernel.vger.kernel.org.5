Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53A678F4BC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 23:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244772AbjHaVhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 17:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjHaVhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 17:37:12 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC44611B
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 14:37:08 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-5009dd43130so147e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 14:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693517827; x=1694122627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jeq/mBI/Pxl8VGKDUQhwTdHQpOjR2gbUrSSK6eaDSlE=;
        b=ocQZXdthonHFumXZKfKzhCeAPAcM640MR72GE/yWskwGy0SHQzO0vmmTGMqR6Pif/Z
         fPVNwzW6qAJ/+D+k9TRY4Tr4vmve1yACAlpJY014qOvJdZ7Ctw9E2AI9PJKlTeVG/5pl
         mQYEenoDI6jF0/7/j1jGs5LpVAZv3T6vrZ6S0TP5reGUP7ABOc3Hbnoer4DRyRetveBs
         TkUTW9r90lS2onNu7n5XzG1id/Bbsr4pCEjbBrw0ooIvFz5WbS+6bE+Sc2LQ0YQYBV1r
         CYxwZ36yO3RHtvRMSep2vSxvHKSzWdmbPyD3gnsvv2+fyU3k6nlvbCRidCNO9EGf/VeY
         Cp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693517827; x=1694122627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jeq/mBI/Pxl8VGKDUQhwTdHQpOjR2gbUrSSK6eaDSlE=;
        b=e3xu1kYD7vwezlA0LGdY5A4BjNkaZDR50cO0VlRdcWkdRz34mxATMFdSzAij5UQrMC
         ZmquTJsuMB6fRHrdrh5vO1BnQseFu987cVjLDX+XAZJbsFqSAq82llFk4Zboyp6r0Mx5
         7TNwjA4JS4cdH2HJc94EX2RuSPdRUaZPXBSd75mJGGP4U+I5d2LqLKoqIh2h+oKeJVqJ
         B/HcqU10e2FA1deXaZPu82UM3ZlTgaqsLOgZXbk23RfKRdyPxqTzgUXrQHLPw7etcfQo
         0q0OldAqVQpsKmR+hepK6FN8Aax5ZkiuW1fhNX9usOSIrWyaEJvVTOZnztsvyKw876ZL
         yLGQ==
X-Gm-Message-State: AOJu0YzK4lVE5amCtzotIpJGd8gM7+1KghxvD8Lj8gEJcPWW+3NKyFxd
        w4mQUwRFqHN6kXFJmykEFFX18HP3Ngpdxz8oq4Xb/wJPMCPfZJ9JB1JA
X-Google-Smtp-Source: AGHT+IGywdiDa7cjFedVDCtOGCHnkFNOclZMR8LEh+xGJLPUmhDQNNdAep5MuaRzNcEdX83jHQWBiNXabcgo3gt8On4=
X-Received: by 2002:a19:f510:0:b0:500:d960:1a75 with SMTP id
 j16-20020a19f510000000b00500d9601a75mr37475lfb.6.1693517826809; Thu, 31 Aug
 2023 14:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230825233930.1875819-1-yabinc@google.com> <382193a4-4f30-d804-47da-a9c705b6bee5@arm.com>
 <CALJ9ZPNQAWCLrK4u+j3vMZmu3TaLUN_Ne+yqetkquU2QS_XQFQ@mail.gmail.com>
 <034c226d-7d0f-849c-45ae-a909839a4d2e@arm.com> <CALJ9ZPODSc0R=B4yJb2QO3f+gmEaBHO7ZZQy3bNRp+jz3rnr9Q@mail.gmail.com>
 <8d2eec52-a47e-f712-51fc-45f2414990e6@arm.com>
In-Reply-To: <8d2eec52-a47e-f712-51fc-45f2414990e6@arm.com>
From:   Yabin Cui <yabinc@google.com>
Date:   Thu, 31 Aug 2023 14:36:54 -0700
Message-ID: <CALJ9ZPOqF-t1wn5Nv_Dj1u7cp6fdgZsr3kKYVzS_+g05tF-R9A@mail.gmail.com>
Subject: Re: [PATCH] coresight: tmc-etr: Don't fail probe when non-secure
 access is disabled
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the suggestion of triggering the probe manually. It works.

I feel the problem isn't product-specific. Because DBGEN isn't product
specific.

If you don't want users to misunderstand that ETR works while not,
how about doing the check in tmc_enable_etr_sink() instead?
Or can we use some flag to make the check configurable?

Thanks,
Yabin

On Thu, Aug 31, 2023 at 3:05=E2=80=AFAM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 2023-08-30 18:49, Yabin Cui wrote:
> > Hi Suzuki,
> >
> >> Are you not able to build the coresight drivers as modules and load
> >> them after the device has been authenticated and NS access enabled ?
> >> Running a trace session without NS access enabled on a normal device
> >> would be asking for trouble in the "normal world".
> >
> > Theoretically we can load coresight drivers after getting NS access.
> > But in practice,
> > it makes the userspace work more complex. The process will be as below:
> > 1. Use device specific checks to know if we have NS access authorized.
> >      Because we can't use the general coresight sysfs interface to read
> > authstatus.
> > 2. Load coresight driver modules.
> > 3. Use ETM/ETR.
> >
> > It needs to add device specific checks in Android AOSP code (which we
> > don't prefer),
> > and add an extra step to load driver modules. It's more complex no matt=
er we do
> > it in a daemon or want to use ETM/ETR manually.
> >
> > If we can load the coresight drivers at boot time. The process is
> > simplified as below:
> > 1. Use the coresight sysfs interface to read authstatus. It works on
> > all devices.
> > 2. If authorized, use ETM/ETR.
> >
> > The authorization used on Pixel devices can be granted/revoked while ru=
nning.
> > So not allowing loading coresight drivers doesn't help us. We always ne=
ed to
> > check authstatus each time before using ETM/ETR. And the check can be
> > easily added in tools using ETM/ETR.
>
> What, and "needing to connect to a server to verify identification after
> booting" isn't already a complex extra step? You have to do that, and
> you presumably have to trigger some firmware call to toggle DBGEN, so it
> doesn't seem obvious why you couldn't synchronise module loading to a
> point within that process. Heck, it doesn't even need to be a module
> load, you could simply trigger a manual re-probe of a built-in (or
> already-loaded) driver. If you can parse sysfs to find a specific path
> to a device's "authstatus" attribute at the point when you think it
> should be available, I'm sure you can just as easily construct the
> relevant string to write to the relevant "probe" attribute if it is not.
>
> Really the big question here is why should upstream care about
> supporting some private product-specific internal workflow that is
> irrelevant to end users? Especially if doing so makes the end users'
> experience objectively worse, by making the driver look like it should
> work when in reality it won't.
>
> Thanks,
> Robin.
>
> >
> > Thanks,
> > Yabin
> >
> > On Wed, Aug 30, 2023 at 1:52=E2=80=AFAM Suzuki K Poulose <suzuki.poulos=
e@arm.com> wrote:
> >>
> >> Hi Yabin
> >>
> >> On 29/08/2023 22:16, Yabin Cui wrote:
> >>>> How can this be enabled ? Why not enable it before probing the ETR ?
> >>> How can a user know if this has been done or not ?
> >>>
> >>> Pixel devices (like Pixel 6, 7) support enabling some debugging featu=
res
> >>> (including granting non-secure access to ETM/ETR) even on devices wit=
h
> >>> secure boot. It is only used internally and has strict requirements,
> >>> needing to connect to a server to verify identification after booting=
.
> >>> So it can't be established when probing ETR at device boot time.
> >>
> >> Are you not able to build the coresight drivers as modules and load
> >> them after the device has been authenticated and NS access enabled ?
> >> Running a trace session without NS access enabled on a normal device
> >> would be asking for trouble in the "normal world".
> >>
> >> Suzuki
> >>
> >>>
> >>>
> >>> On Sun, Aug 27, 2023 at 2:37=E2=80=AFPM Suzuki K Poulose <suzuki.poul=
ose@arm.com> wrote:
> >>>>
> >>>> On 26/08/2023 00:39, Yabin Cui wrote:
> >>>>> Because the non-secure access can be enabled later on some devices.
> >>>>
> >>>> How can this be enabled ? Why not enable it before probing the ETR ?
> >>>> How can a user know if this has been done or not ? It is asking for
> >>>> trouble to continue without this.
> >>>>
> >>>> Suzuki
> >>>>
> >>>>>
> >>>>> Signed-off-by: Yabin Cui <yabinc@google.com>
> >>>>> ---
> >>>>>     drivers/hwtracing/coresight/coresight-tmc-core.c | 2 +-
> >>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/dri=
vers/hwtracing/coresight/coresight-tmc-core.c
> >>>>> index c106d142e632..5ebfd12b627b 100644
> >>>>> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
> >>>>> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
> >>>>> @@ -370,7 +370,7 @@ static int tmc_etr_setup_caps(struct device *pa=
rent, u32 devid, void *dev_caps)
> >>>>>         struct tmc_drvdata *drvdata =3D dev_get_drvdata(parent);
> >>>>>
> >>>>>         if (!tmc_etr_has_non_secure_access(drvdata))
> >>>>> -             return -EACCES;
> >>>>> +             dev_warn(parent, "TMC ETR doesn't have non-secure acc=
ess\n");
> >>>>>
> >>>>>         /* Set the unadvertised capabilities */
> >>>>>         tmc_etr_init_caps(drvdata, (u32)(unsigned long)dev_caps);
> >>>>
> >>
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
