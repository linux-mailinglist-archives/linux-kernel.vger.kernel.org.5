Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49A57D503D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 14:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbjJXMuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 08:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234390AbjJXMuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 08:50:12 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12C3123
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 05:50:08 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a7af45084eso42847667b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 05:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698151808; x=1698756608; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=drfWjB6Z+XkamCb0RZVbD4fvzQ6BkCWkgYR2SPLQjDQ=;
        b=HBszIJEjk1A4xHOEl31Ftpw3M74iAcPoDvlg1joH27lysuT+u6/oRSsfwP8BbqGlTi
         0ZaHn5pwFJJ9WRGbQuiCUMSkKH1QyALpj8l+IyVSkSqZKclyEFki1BZbpiWZMXKgH5Rn
         ezhXTKE1DesgDiXhA5dSC83H91HxHA6quA8E/JclciNLDNZ3VCoCub/NKw9NQTGfUVIF
         lIe5KWZC4ccoBBiZansLoP01AaCHsBsruV+hmyc9Yc1Wso5XV40GWhywUHsnJ5EFzgvI
         7z92i0kY3Yo7Ij4/f+sHnDGVdajC8CRYNK2j+lmcV/LComgsJS76Ozr/jr+PLeHr6Mf8
         +4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698151808; x=1698756608;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=drfWjB6Z+XkamCb0RZVbD4fvzQ6BkCWkgYR2SPLQjDQ=;
        b=Burv/mq+Q6LdKEsS6WGpcRxrEiOwzgjx/zrJhLH5tYyoTQFGIIk8y1IwQIdehsqSfy
         CvDVzvM7XjuycdvQXLvmTWQffR5fixdIONe0HHQHX+x/iCzmmyxDwGQNGM4cpQYOvfJc
         9hXztC16UNKf9WKrT6dSEX44vX+hzDO8gJmH2WJ8UdPPp8vEL8lEWez40I+p7bJ5S3xu
         wYDm8sVyY7e8Emrbef7amQkJ3YxGOH4SWII62uzKcMQvjrxgR36D4j2U/SPcrlcH7SOz
         pp/7NFA7Q3w0lp6rwMKZohRtpPnvxIuIq3eeQGJUPZdqexbeYJNRI3elwJyyQesDWlc4
         VRew==
X-Gm-Message-State: AOJu0YwM4g2zvfEIiLKZdvKtlmNVRa13d80V6HMuWGf0uWvxqbU3cp6o
        /qNIsBZM5x8Q2yDDCNkZ/3y7das4eIythGyw1YOtsQ==
X-Google-Smtp-Source: AGHT+IFjIONF78/WztY+ctTp3jQcYaP/sv8H3kp8H8VN9BTRgIwpHhVc5auQGkToBIGdlLssWU70AqKJYsuKK+wEpe4=
X-Received: by 2002:a0d:dac1:0:b0:598:7836:aac1 with SMTP id
 c184-20020a0ddac1000000b005987836aac1mr10268798ywe.49.1698151807846; Tue, 24
 Oct 2023 05:50:07 -0700 (PDT)
MIME-Version: 1.0
References: <20231018-msm8909-cpufreq-v2-0-0962df95f654@kernkonzept.com>
 <20231018-msm8909-cpufreq-v2-2-0962df95f654@kernkonzept.com>
 <CAPDyKFot9=M1ooP_Q1AOgG5o_4DTQ2qsyai1ZdXAzBwf89W4uA@mail.gmail.com>
 <CAPDyKFr5A-P=UhWs4rUMBWup3pH75WAhcZ56Y2_Sfk3=WfxRCQ@mail.gmail.com> <ZTeyhR7YY7VgWQlU@kernkonzept.com>
In-Reply-To: <ZTeyhR7YY7VgWQlU@kernkonzept.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Oct 2023 14:49:32 +0200
Message-ID: <CAPDyKFrcV8iJnJ904j1jkx0E8PaOLmiTZ7CKk7EV8qQ71AZdbA@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2023 at 14:03, Stephan Gerhold
<stephan.gerhold@kernkonzept.com> wrote:
>
> On Thu, Oct 19, 2023 at 01:26:19PM +0200, Ulf Hansson wrote:
> > On Thu, 19 Oct 2023 at 12:24, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > On Wed, 18 Oct 2023 at 10:06, Stephan Gerhold
> > > <stephan.gerhold@kernkonzept.com> wrote:
> > > >
> > > > The genpd core caches performance state votes from devices that are
> > > > runtime suspended as of commit 3c5a272202c2 ("PM: domains: Improve
> > > > runtime PM performance state handling"). They get applied once the
> > > > device becomes active again.
> > > >
> > > > To attach the power domains needed by qcom-cpufreq-nvmem the OPP core
> > > > calls genpd_dev_pm_attach_by_id(). This results in "virtual" dummy
> > > > devices that use runtime PM only to control the enable and performance
> > > > state for the attached power domain.
> > > >
> > > > However, at the moment nothing ever resumes the virtual devices created
> > > > for qcom-cpufreq-nvmem. They remain permanently runtime suspended. This
> > > > means that performance state votes made during cpufreq scaling get
> > > > always cached and never applied to the hardware.
> > > >
> > > > Fix this by enabling the devices after attaching them and use
> > > > dev_pm_syscore_device() to ensure the power domains also stay on when
> > > > going to suspend. Since it supplies the CPU we can never turn it off
> > > > from Linux. There are other mechanisms to turn it off when needed,
> > > > usually in the RPM firmware (RPMPD) or the cpuidle path (CPR genpd).
> > >
> > > I believe we discussed using dev_pm_syscore_device() for the previous
> > > version. It's not intended to be used for things like the above.
> > >
> > > Moreover, I was under the impression that it wasn't really needed. In
> > > fact, I would think that this actually breaks things for system
> > > suspend/resume, as in this case the cpr driver's genpd
> > > ->power_on|off() callbacks are no longer getting called due this,
> > > which means that the cpr state machine isn't going to be restored
> > > properly. Or did I get this wrong?
> >
> > BTW, if you really need something like the above, the proper way to do
> > it would instead be to call device_set_awake_path() for the device.
> >
>
> Unfortunately this does not work correctly. When I use
> device_set_awake_path() it does set dev->power.wakeup_path = true.
> However, this flag is cleared again in device_prepare() when entering
> suspend. To me it looks a bit like wakeup_path is not supposed to be set
> directly by drivers? Before and after your commit 8512220c5782 ("PM /
> core: Assign the wakeup_path status flag in __device_prepare()") it
> seems to be internally bound to device_may_wakeup().
>
> It works if I make device_may_wakeup() return true, with
>
>         device_set_wakeup_capable(dev, true);
>         device_wakeup_enable(dev);
>
> but that also allows *disabling* the wakeup from sysfs which doesn't
> really make sense for the CPU.
>
> Any ideas?

The device_set_awake_path() should be called from a system suspend
callback. So you need to add that callback for the cpufreq driver.

Sorry, if that wasn't clear.

Kind regards
Uffe
