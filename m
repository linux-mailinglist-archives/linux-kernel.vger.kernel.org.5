Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED50A7D57AE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235001AbjJXQMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344164AbjJXQMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:12:35 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA58610D0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 09:12:12 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d9abc069c8bso3660368276.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 09:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698163931; x=1698768731; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/pjBUbLx3Wj6CmYiqOhDTL336nEXm92LuAjn2RJuUXA=;
        b=fB3MCDsolGJfkZXE5b8zs4f5XmqwhLMBgbB63lp+7mMp6sdBnXj0+8fG32rdlNOzED
         nDHFNuIb4n/gIJJCzocYGTwdtgxCI7PjaTVsDNZ3v14s2WumO6QrZhl2Mhck8tJRXo/Y
         zsjOOW04UFSUuJ6ADYxYcA72/jt56mREbjTyZi2plqrWuDONU2fkEQPSPyD6AQ4vMZ0D
         WI7WweU045zlyBPLvk3xpDtdxjGS8nmlxHIdTnBQTI1HjPK/SKzjznzdixWHnhbZ8bwc
         aIj6n/lQiU3H7WR+lmsKymv4nj7Xmy6A9SAhQvIoobUsfKSwVvRFXhS1nmSbFprCA3Zy
         MC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698163931; x=1698768731;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/pjBUbLx3Wj6CmYiqOhDTL336nEXm92LuAjn2RJuUXA=;
        b=XFdgSYfFIZIZ3WcE9I4Bkvp6Ft4+pM46j4UKn0cdTpWCTx66qU/SV0ZQMdIZPdZ18b
         DhFGuI1judYGxx/WRD+eATQmRH/+AQ63KlAsCR2ydFkIKixWrD2QenvCZer9AMj95aro
         KyHbXwhC5lTMddxnzL66xyDl4WGcJAlG9lxcJR7erj6FwXcXtyhQca6pQkTtaxzgwwMV
         kG92fbLbtu+c8jKwbtdpdvh1zTdmLUomPMLUTCfQ+bwpVdpbs0O1SIC10NxOYawTZBpw
         ES7bvhGYMeNmQxa/EoaPgw9NjQYoZzWzpuSUXFNX2J0D+iFHHDvJYbYoHogA4wejXJoG
         fuXw==
X-Gm-Message-State: AOJu0YztTBwaks5BGzygQ0srbA2ZBnfYjUYBasNGiNcDYTdO5b5RK/JG
        W8M8NbaB2XM1fEZ+UKk+M28/dmvECeR2Up/idCIbDQ==
X-Google-Smtp-Source: AGHT+IGTTwt4rHCuJ4w6CclzOwAHuYNSeyL9ErpNapwRYZRld/tKa5wE03Hs0mv9jEAhPtzgvqw2DogicE9JUIqA2Ug=
X-Received: by 2002:a25:b203:0:b0:da0:50e6:12c5 with SMTP id
 i3-20020a25b203000000b00da050e612c5mr1524017ybj.62.1698163931147; Tue, 24 Oct
 2023 09:12:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231018-msm8909-cpufreq-v2-0-0962df95f654@kernkonzept.com>
 <20231018-msm8909-cpufreq-v2-2-0962df95f654@kernkonzept.com>
 <CAPDyKFot9=M1ooP_Q1AOgG5o_4DTQ2qsyai1ZdXAzBwf89W4uA@mail.gmail.com>
 <CAPDyKFr5A-P=UhWs4rUMBWup3pH75WAhcZ56Y2_Sfk3=WfxRCQ@mail.gmail.com>
 <ZTeyhR7YY7VgWQlU@kernkonzept.com> <CAPDyKFrcV8iJnJ904j1jkx0E8PaOLmiTZ7CKk7EV8qQ71AZdbA@mail.gmail.com>
 <ZTfBZqBwqskhFydZ@kernkonzept.com>
In-Reply-To: <ZTfBZqBwqskhFydZ@kernkonzept.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Oct 2023 18:11:34 +0200
Message-ID: <CAPDyKFooPLCmJeqjhiMm7HRdW5UrEw0yHvGF9fgLvOigsgbWxg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] cpufreq: qcom-nvmem: Enable virtual power domain devices
To:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2023 at 15:07, Stephan Gerhold
<stephan.gerhold@kernkonzept.com> wrote:
>
> On Tue, Oct 24, 2023 at 02:49:32PM +0200, Ulf Hansson wrote:
> > On Tue, 24 Oct 2023 at 14:03, Stephan Gerhold
> > <stephan.gerhold@kernkonzept.com> wrote:
> > >
> > > On Thu, Oct 19, 2023 at 01:26:19PM +0200, Ulf Hansson wrote:
> > > > On Thu, 19 Oct 2023 at 12:24, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > >
> > > > > On Wed, 18 Oct 2023 at 10:06, Stephan Gerhold
> > > > > <stephan.gerhold@kernkonzept.com> wrote:
> > > > > >
> > > > > > The genpd core caches performance state votes from devices that are
> > > > > > runtime suspended as of commit 3c5a272202c2 ("PM: domains: Improve
> > > > > > runtime PM performance state handling"). They get applied once the
> > > > > > device becomes active again.
> > > > > >
> > > > > > To attach the power domains needed by qcom-cpufreq-nvmem the OPP core
> > > > > > calls genpd_dev_pm_attach_by_id(). This results in "virtual" dummy
> > > > > > devices that use runtime PM only to control the enable and performance
> > > > > > state for the attached power domain.
> > > > > >
> > > > > > However, at the moment nothing ever resumes the virtual devices created
> > > > > > for qcom-cpufreq-nvmem. They remain permanently runtime suspended. This
> > > > > > means that performance state votes made during cpufreq scaling get
> > > > > > always cached and never applied to the hardware.
> > > > > >
> > > > > > Fix this by enabling the devices after attaching them and use
> > > > > > dev_pm_syscore_device() to ensure the power domains also stay on when
> > > > > > going to suspend. Since it supplies the CPU we can never turn it off
> > > > > > from Linux. There are other mechanisms to turn it off when needed,
> > > > > > usually in the RPM firmware (RPMPD) or the cpuidle path (CPR genpd).
> > > > >
> > > > > I believe we discussed using dev_pm_syscore_device() for the previous
> > > > > version. It's not intended to be used for things like the above.
> > > > >
> > > > > Moreover, I was under the impression that it wasn't really needed. In
> > > > > fact, I would think that this actually breaks things for system
> > > > > suspend/resume, as in this case the cpr driver's genpd
> > > > > ->power_on|off() callbacks are no longer getting called due this,
> > > > > which means that the cpr state machine isn't going to be restored
> > > > > properly. Or did I get this wrong?
> > > >
> > > > BTW, if you really need something like the above, the proper way to do
> > > > it would instead be to call device_set_awake_path() for the device.
> > > >
> > >
> > > Unfortunately this does not work correctly. When I use
> > > device_set_awake_path() it does set dev->power.wakeup_path = true.
> > > However, this flag is cleared again in device_prepare() when entering
> > > suspend. To me it looks a bit like wakeup_path is not supposed to be set
> > > directly by drivers? Before and after your commit 8512220c5782 ("PM /
> > > core: Assign the wakeup_path status flag in __device_prepare()") it
> > > seems to be internally bound to device_may_wakeup().
> > >
> > > It works if I make device_may_wakeup() return true, with
> > >
> > >         device_set_wakeup_capable(dev, true);
> > >         device_wakeup_enable(dev);
> > >
> > > but that also allows *disabling* the wakeup from sysfs which doesn't
> > > really make sense for the CPU.
> > >
> > > Any ideas?
> >
> > The device_set_awake_path() should be called from a system suspend
> > callback. So you need to add that callback for the cpufreq driver.
> >
> > Sorry, if that wasn't clear.
> >
>
> Hmm, but at the moment I'm calling this on the virtual genpd devices.
> How would it work for them? I don't have a suspend callback for them.
>
> I guess could loop over the virtual devices in the cpufreq driver
> suspend callback, but is my driver suspend callback really guaranteed to
> run before the device_prepare() that clears "wakeup_path" on the virtual
> devices?

Yes, that's guaranteed. dpm_prepare() (which calls device_prepare())
is always being executed before dpm_suspend().

>
> Or is this the point where we need device links to make that work?
> A quick look suggests "wakeup_path" is just propagated to parents but
> not device links, so I don't think that would help, either.

I don't think we need device-links for this, at least the way things
are working currently.

Kind regards
Uffe
