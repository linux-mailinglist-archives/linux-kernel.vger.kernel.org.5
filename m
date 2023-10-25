Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFBA7D67D9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbjJYKGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbjJYKGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:06:30 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA00111
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 03:06:27 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a8ada42c2aso53741277b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 03:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698228387; x=1698833187; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q9wXtrZXCK+13JkLhq9pSaIeP3nLGHw9GpelTWB58cI=;
        b=LdCBsroYTUKhoWeSTC6as9+pv8NW82IaXT4Gnif8NBEGVs3bP5sbbMKcTGNsih+/Rq
         I5VfXVOmirNUzq+SH3u9def5xMFWiQ94xBZzRnr5xv8iEkKz4mw4NKNmaNAtBiEyAo4i
         F9gRp06cbbeDNhnaPyRvX2XWR1URQ58xB/iw8oqgK3hTOQEXKQCf93NkCOoT2uuyNlsq
         0lJNvHYNrU5iK6OvxoG8KTZjCVSN5dZZY/ABARe7kqjmcI1Q0Nd/I/hZbrb4zBr/QyGK
         X73yKeWMOTiZ/qlkHk0hHHzMMBh0a3WZdIi+fnrN/ZlyGNU2bVR7/8O0IJX+RH5cYegJ
         joXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698228387; x=1698833187;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q9wXtrZXCK+13JkLhq9pSaIeP3nLGHw9GpelTWB58cI=;
        b=w/XL3P6lF/8gVM/oXLGxoxC5H3DmCsOzH+3I7p5cOXNu7l4oy1DPOZXGRo+huuEGHW
         0Wpy9250Phy5P0l9t6BbeTOSTlS3gOMNdwY8iqVTa7q7xLBTpsBS8RkuzxAartSi8JPZ
         xWg1QI7IFip0SRkcuhqgu0If/09IrXPcnSqucK3YORxYK4FqthbcVM7VfPW2rAY0dZe7
         jq/WOOceAqtW6rDQBiE+HqQFHXvhhbZ5DOqipp5c8EkPmuoMTTt6jRH8KyqU7qQexxl/
         dLH6vH6JgIPJ59rQTJS3tWTwI0aj2ZhSDznwh91i8yrIXhwDN7H2hL0xw5B3Y7RkM50j
         HOcA==
X-Gm-Message-State: AOJu0YzBvnHzKHabYatSxgJVowd3+8bMbmuigrMjCqHWtYB2eo2x/bOs
        hwhGiT9YpX4SBeFMrTPB1U3h3XR1yGD1Du7gVg/bXQ==
X-Google-Smtp-Source: AGHT+IEulIKu5K+XkQLWBzrf2lHWc+yXcrbptuf3RzpTO2ez6RMQ5O+8XbGz9VCo7WdlKXwSrNqxi77C9q4BZM7tS8o=
X-Received: by 2002:a0d:e84c:0:b0:5a8:277f:b378 with SMTP id
 r73-20020a0de84c000000b005a8277fb378mr14113574ywe.1.1698228386871; Wed, 25
 Oct 2023 03:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <20231018-msm8909-cpufreq-v2-0-0962df95f654@kernkonzept.com>
 <20231018-msm8909-cpufreq-v2-2-0962df95f654@kernkonzept.com>
 <CAPDyKFot9=M1ooP_Q1AOgG5o_4DTQ2qsyai1ZdXAzBwf89W4uA@mail.gmail.com>
 <CAPDyKFr5A-P=UhWs4rUMBWup3pH75WAhcZ56Y2_Sfk3=WfxRCQ@mail.gmail.com>
 <ZTeyhR7YY7VgWQlU@kernkonzept.com> <CAPDyKFrcV8iJnJ904j1jkx0E8PaOLmiTZ7CKk7EV8qQ71AZdbA@mail.gmail.com>
 <ZTfBZqBwqskhFydZ@kernkonzept.com> <CAPDyKFooPLCmJeqjhiMm7HRdW5UrEw0yHvGF9fgLvOigsgbWxg@mail.gmail.com>
 <ZTfv-Dea693UqLXB@gerhold.net>
In-Reply-To: <ZTfv-Dea693UqLXB@gerhold.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 25 Oct 2023 12:05:49 +0200
Message-ID: <CAPDyKFpFJd+ipv6kb77MgnDtXtFPa3=BX2RgaKq5i5r6WpVmJQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] cpufreq: qcom-nvmem: Enable virtual power domain devices
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2023 at 18:25, Stephan Gerhold <stephan@gerhold.net> wrote:
>
> On Tue, Oct 24, 2023 at 06:11:34PM +0200, Ulf Hansson wrote:
> > On Tue, 24 Oct 2023 at 15:07, Stephan Gerhold
> > <stephan.gerhold@kernkonzept.com> wrote:
> > >
> > > On Tue, Oct 24, 2023 at 02:49:32PM +0200, Ulf Hansson wrote:
> > > > On Tue, 24 Oct 2023 at 14:03, Stephan Gerhold
> > > > <stephan.gerhold@kernkonzept.com> wrote:
> > > > >
> > > > > On Thu, Oct 19, 2023 at 01:26:19PM +0200, Ulf Hansson wrote:
> > > > > > On Thu, 19 Oct 2023 at 12:24, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > > >
> > > > > > > On Wed, 18 Oct 2023 at 10:06, Stephan Gerhold
> > > > > > > <stephan.gerhold@kernkonzept.com> wrote:
> > > > > > > >
> > > > > > > > The genpd core caches performance state votes from devices that are
> > > > > > > > runtime suspended as of commit 3c5a272202c2 ("PM: domains: Improve
> > > > > > > > runtime PM performance state handling"). They get applied once the
> > > > > > > > device becomes active again.
> > > > > > > >
> > > > > > > > To attach the power domains needed by qcom-cpufreq-nvmem the OPP core
> > > > > > > > calls genpd_dev_pm_attach_by_id(). This results in "virtual" dummy
> > > > > > > > devices that use runtime PM only to control the enable and performance
> > > > > > > > state for the attached power domain.
> > > > > > > >
> > > > > > > > However, at the moment nothing ever resumes the virtual devices created
> > > > > > > > for qcom-cpufreq-nvmem. They remain permanently runtime suspended. This
> > > > > > > > means that performance state votes made during cpufreq scaling get
> > > > > > > > always cached and never applied to the hardware.
> > > > > > > >
> > > > > > > > Fix this by enabling the devices after attaching them and use
> > > > > > > > dev_pm_syscore_device() to ensure the power domains also stay on when
> > > > > > > > going to suspend. Since it supplies the CPU we can never turn it off
> > > > > > > > from Linux. There are other mechanisms to turn it off when needed,
> > > > > > > > usually in the RPM firmware (RPMPD) or the cpuidle path (CPR genpd).
> > > > > > >
> > > > > > > I believe we discussed using dev_pm_syscore_device() for the previous
> > > > > > > version. It's not intended to be used for things like the above.
> > > > > > >
> > > > > > > Moreover, I was under the impression that it wasn't really needed. In
> > > > > > > fact, I would think that this actually breaks things for system
> > > > > > > suspend/resume, as in this case the cpr driver's genpd
> > > > > > > ->power_on|off() callbacks are no longer getting called due this,
> > > > > > > which means that the cpr state machine isn't going to be restored
> > > > > > > properly. Or did I get this wrong?
> > > > > >
> > > > > > BTW, if you really need something like the above, the proper way to do
> > > > > > it would instead be to call device_set_awake_path() for the device.
> > > > > >
> > > > >
> > > > > Unfortunately this does not work correctly. When I use
> > > > > device_set_awake_path() it does set dev->power.wakeup_path = true.
> > > > > However, this flag is cleared again in device_prepare() when entering
> > > > > suspend. To me it looks a bit like wakeup_path is not supposed to be set
> > > > > directly by drivers? Before and after your commit 8512220c5782 ("PM /
> > > > > core: Assign the wakeup_path status flag in __device_prepare()") it
> > > > > seems to be internally bound to device_may_wakeup().
> > > > >
> > > > > It works if I make device_may_wakeup() return true, with
> > > > >
> > > > >         device_set_wakeup_capable(dev, true);
> > > > >         device_wakeup_enable(dev);
> > > > >
> > > > > but that also allows *disabling* the wakeup from sysfs which doesn't
> > > > > really make sense for the CPU.
> > > > >
> > > > > Any ideas?
> > > >
> > > > The device_set_awake_path() should be called from a system suspend
> > > > callback. So you need to add that callback for the cpufreq driver.
> > > >
> > > > Sorry, if that wasn't clear.
> > > >
> > >
> > > Hmm, but at the moment I'm calling this on the virtual genpd devices.
> > > How would it work for them? I don't have a suspend callback for them.
> > >
> > > I guess could loop over the virtual devices in the cpufreq driver
> > > suspend callback, but is my driver suspend callback really guaranteed to
> > > run before the device_prepare() that clears "wakeup_path" on the virtual
> > > devices?
> >
> > Yes, that's guaranteed. dpm_prepare() (which calls device_prepare())
> > is always being executed before dpm_suspend().
> >
>
> Thanks, I think I understand. Maybe. :-)
>
> Just to confirm, I should call device_set_awake_path() for the virtual
> genpd devices as part of the PM ->suspend() callback? And this will be
> guaranteed to run after the "prepare" phase but before the
> "suspend_noirq" phase where the genpd core will check the wakeup flag?

Correct!

Kind regards
Uffe
