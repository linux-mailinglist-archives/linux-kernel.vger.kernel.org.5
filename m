Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D0D7D4F61
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 14:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbjJXMDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 08:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbjJXMDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 08:03:32 -0400
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352D3F9;
        Tue, 24 Oct 2023 05:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:Reply-To:
        Content-ID:Content-Description;
        bh=zRIi9/LubZwPopqf6kr3BLpCYi15YnR3163PaROLkPc=; b=mTYVwfkdKLTHhanJB6iXTcGdRN
        B4MGvwjKxtEHB9ISxJYLjUPkavsTwTRNUl+/dYaX8yIOwuQxB7l9Np7qR13iLSaKKHdBO0cJGkzd1
        z6+PwxU6TURDYTmHgLz9xsIBJxXlfBQgwSXCjAnQCaj8RjJi041unbBCCgvcs1T7TkzE9Wz6bzxHq
        5A9yH8mOT1hmHimnZy+WkCoU6cMmRgZ7sQtnjBzlPfMGk/4pXLyTnc+pcMVGqBAVPL2M/8TqlOFup
        z99GPSxcLYXAtUlrlJtsa3F9kVjgZilmYOJEo5yezpZXCs/tExSS3HRS4iPEy1l70zpPHHtUetTZu
        SMl1I8Mg==;
Received: from [10.22.3.24] (helo=kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.96)
        id 1qvG83-000jUo-0O;
        Tue, 24 Oct 2023 14:03:22 +0200
Date:   Tue, 24 Oct 2023 14:03:17 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
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
Subject: Re: [PATCH v2 2/3] cpufreq: qcom-nvmem: Enable virtual power domain
 devices
Message-ID: <ZTeyhR7YY7VgWQlU@kernkonzept.com>
References: <20231018-msm8909-cpufreq-v2-0-0962df95f654@kernkonzept.com>
 <20231018-msm8909-cpufreq-v2-2-0962df95f654@kernkonzept.com>
 <CAPDyKFot9=M1ooP_Q1AOgG5o_4DTQ2qsyai1ZdXAzBwf89W4uA@mail.gmail.com>
 <CAPDyKFr5A-P=UhWs4rUMBWup3pH75WAhcZ56Y2_Sfk3=WfxRCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFr5A-P=UhWs4rUMBWup3pH75WAhcZ56Y2_Sfk3=WfxRCQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 01:26:19PM +0200, Ulf Hansson wrote:
> On Thu, 19 Oct 2023 at 12:24, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Wed, 18 Oct 2023 at 10:06, Stephan Gerhold
> > <stephan.gerhold@kernkonzept.com> wrote:
> > >
> > > The genpd core caches performance state votes from devices that are
> > > runtime suspended as of commit 3c5a272202c2 ("PM: domains: Improve
> > > runtime PM performance state handling"). They get applied once the
> > > device becomes active again.
> > >
> > > To attach the power domains needed by qcom-cpufreq-nvmem the OPP core
> > > calls genpd_dev_pm_attach_by_id(). This results in "virtual" dummy
> > > devices that use runtime PM only to control the enable and performance
> > > state for the attached power domain.
> > >
> > > However, at the moment nothing ever resumes the virtual devices created
> > > for qcom-cpufreq-nvmem. They remain permanently runtime suspended. This
> > > means that performance state votes made during cpufreq scaling get
> > > always cached and never applied to the hardware.
> > >
> > > Fix this by enabling the devices after attaching them and use
> > > dev_pm_syscore_device() to ensure the power domains also stay on when
> > > going to suspend. Since it supplies the CPU we can never turn it off
> > > from Linux. There are other mechanisms to turn it off when needed,
> > > usually in the RPM firmware (RPMPD) or the cpuidle path (CPR genpd).
> >
> > I believe we discussed using dev_pm_syscore_device() for the previous
> > version. It's not intended to be used for things like the above.
> >
> > Moreover, I was under the impression that it wasn't really needed. In
> > fact, I would think that this actually breaks things for system
> > suspend/resume, as in this case the cpr driver's genpd
> > ->power_on|off() callbacks are no longer getting called due this,
> > which means that the cpr state machine isn't going to be restored
> > properly. Or did I get this wrong?
> 
> BTW, if you really need something like the above, the proper way to do
> it would instead be to call device_set_awake_path() for the device.
> 

Unfortunately this does not work correctly. When I use
device_set_awake_path() it does set dev->power.wakeup_path = true.
However, this flag is cleared again in device_prepare() when entering
suspend. To me it looks a bit like wakeup_path is not supposed to be set
directly by drivers? Before and after your commit 8512220c5782 ("PM /
core: Assign the wakeup_path status flag in __device_prepare()") it
seems to be internally bound to device_may_wakeup().

It works if I make device_may_wakeup() return true, with

	device_set_wakeup_capable(dev, true);
	device_wakeup_enable(dev);

but that also allows *disabling* the wakeup from sysfs which doesn't
really make sense for the CPU.

Any ideas?

Thanks!
--
Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Kernkonzept GmbH at Dresden, Germany, HRB 31129, CEO Dr.-Ing. Michael Hohmuth
