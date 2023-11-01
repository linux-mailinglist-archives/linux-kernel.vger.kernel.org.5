Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46EE7DE348
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjKAO4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 10:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjKAO4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 10:56:32 -0400
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD10110C;
        Wed,  1 Nov 2023 07:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:Reply-To:
        Content-ID:Content-Description;
        bh=2OitxQ/ndqBrxlaO/t3PZApPqvhNvUnxSmmdj8bUi1o=; b=TLMz5jcMPUMHKCqqaVE2eDGCv6
        MfEjncZPQ6PZTjZWqBM8qgKjGVkodYTXB1l8EMkOoI/4V8yhDIYbEJggi/F4IsYEX1sa3XqHs0BWI
        mfXampdWmXkN3jz7WN7oO+c2LGGqhNF5MCIFLT1PzMmHh+t3y81Ubj/gO6kLW2PcFz9J3e8G08To/
        tf+Mv+5PVtTuEb64H6Mg5a0J2WQ5brAWlL4XQBZHfK69qy3KiNKNcPkVDjbdK0oa7Bks201XuaKPW
        c3gkrapt/cK3IA4iFn069hEgDcghFVqeZ2Mt4I/1w+vCeFbOjWDQMF9spozzcjVwQAwTDwV0EPRDf
        adeP5T7w==;
Received: from [10.22.3.24] (helo=kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.96)
        id 1qyCdn-002MbQ-2q;
        Wed, 01 Nov 2023 15:56:19 +0100
Date:   Wed, 1 Nov 2023 15:56:13 +0100
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
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
Subject: Re: [PATCH v2 2/3] cpufreq: qcom-nvmem: Enable virtual power domain
 devices
Message-ID: <ZUJm-r43cj0E-vBP@kernkonzept.com>
References: <20231018-msm8909-cpufreq-v2-0-0962df95f654@kernkonzept.com>
 <20231018-msm8909-cpufreq-v2-2-0962df95f654@kernkonzept.com>
 <CAPDyKFot9=M1ooP_Q1AOgG5o_4DTQ2qsyai1ZdXAzBwf89W4uA@mail.gmail.com>
 <CAPDyKFr5A-P=UhWs4rUMBWup3pH75WAhcZ56Y2_Sfk3=WfxRCQ@mail.gmail.com>
 <ZTeyhR7YY7VgWQlU@kernkonzept.com>
 <CAPDyKFrcV8iJnJ904j1jkx0E8PaOLmiTZ7CKk7EV8qQ71AZdbA@mail.gmail.com>
 <ZTfBZqBwqskhFydZ@kernkonzept.com>
 <CAPDyKFooPLCmJeqjhiMm7HRdW5UrEw0yHvGF9fgLvOigsgbWxg@mail.gmail.com>
 <ZTfv-Dea693UqLXB@gerhold.net>
 <CAPDyKFpFJd+ipv6kb77MgnDtXtFPa3=BX2RgaKq5i5r6WpVmJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpFJd+ipv6kb77MgnDtXtFPa3=BX2RgaKq5i5r6WpVmJQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 12:05:49PM +0200, Ulf Hansson wrote:
> On Tue, 24 Oct 2023 at 18:25, Stephan Gerhold <stephan@gerhold.net> wrote:
> > On Tue, Oct 24, 2023 at 06:11:34PM +0200, Ulf Hansson wrote:
> > > On Tue, 24 Oct 2023 at 15:07, Stephan Gerhold
> > > <stephan.gerhold@kernkonzept.com> wrote:
> > > > On Tue, Oct 24, 2023 at 02:49:32PM +0200, Ulf Hansson wrote:
> > > > > On Tue, 24 Oct 2023 at 14:03, Stephan Gerhold
> > > > > <stephan.gerhold@kernkonzept.com> wrote:
> > > > > > On Thu, Oct 19, 2023 at 01:26:19PM +0200, Ulf Hansson wrote:
> > > > > > > On Thu, 19 Oct 2023 at 12:24, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > > > > On Wed, 18 Oct 2023 at 10:06, Stephan Gerhold
> > > > > > > > <stephan.gerhold@kernkonzept.com> wrote:
> > > > > > > > >
> > > > > > > > > The genpd core caches performance state votes from devices that are
> > > > > > > > > runtime suspended as of commit 3c5a272202c2 ("PM: domains: Improve
> > > > > > > > > runtime PM performance state handling"). They get applied once the
> > > > > > > > > device becomes active again.
> > > > > > > > >
> > > > > > > > > To attach the power domains needed by qcom-cpufreq-nvmem the OPP core
> > > > > > > > > calls genpd_dev_pm_attach_by_id(). This results in "virtual" dummy
> > > > > > > > > devices that use runtime PM only to control the enable and performance
> > > > > > > > > state for the attached power domain.
> > > > > > > > >
> > > > > > > > > However, at the moment nothing ever resumes the virtual devices created
> > > > > > > > > for qcom-cpufreq-nvmem. They remain permanently runtime suspended. This
> > > > > > > > > means that performance state votes made during cpufreq scaling get
> > > > > > > > > always cached and never applied to the hardware.
> > > > > > > > >
> > > > > > > > > Fix this by enabling the devices after attaching them and use
> > > > > > > > > dev_pm_syscore_device() to ensure the power domains also stay on when
> > > > > > > > > going to suspend. Since it supplies the CPU we can never turn it off
> > > > > > > > > from Linux. There are other mechanisms to turn it off when needed,
> > > > > > > > > usually in the RPM firmware (RPMPD) or the cpuidle path (CPR genpd).
> > > > > > > >
> > > > > > > > I believe we discussed using dev_pm_syscore_device() for the previous
> > > > > > > > version. It's not intended to be used for things like the above.
> > > > > > > >
> > > > > > > > Moreover, I was under the impression that it wasn't really needed. In
> > > > > > > > fact, I would think that this actually breaks things for system
> > > > > > > > suspend/resume, as in this case the cpr driver's genpd
> > > > > > > > ->power_on|off() callbacks are no longer getting called due this,
> > > > > > > > which means that the cpr state machine isn't going to be restored
> > > > > > > > properly. Or did I get this wrong?
> > > > > > >
> > > > > > > BTW, if you really need something like the above, the proper way to do
> > > > > > > it would instead be to call device_set_awake_path() for the device.
> > > > > > >
> > > > > >
> > > > > > Unfortunately this does not work correctly. When I use
> > > > > > device_set_awake_path() it does set dev->power.wakeup_path = true.
> > > > > > However, this flag is cleared again in device_prepare() when entering
> > > > > > suspend. To me it looks a bit like wakeup_path is not supposed to be set
> > > > > > directly by drivers? Before and after your commit 8512220c5782 ("PM /
> > > > > > core: Assign the wakeup_path status flag in __device_prepare()") it
> > > > > > seems to be internally bound to device_may_wakeup().
> > > > > >
> > > > > > It works if I make device_may_wakeup() return true, with
> > > > > >
> > > > > >         device_set_wakeup_capable(dev, true);
> > > > > >         device_wakeup_enable(dev);
> > > > > >
> > > > > > but that also allows *disabling* the wakeup from sysfs which doesn't
> > > > > > really make sense for the CPU.
> > > > > >
> > > > > > Any ideas?
> > > > >
> > > > > The device_set_awake_path() should be called from a system suspend
> > > > > callback. So you need to add that callback for the cpufreq driver.
> > > > >
> > > > > Sorry, if that wasn't clear.
> > > > >
> > > >
> > > > Hmm, but at the moment I'm calling this on the virtual genpd devices.
> > > > How would it work for them? I don't have a suspend callback for them.
> > > >
> > > > I guess could loop over the virtual devices in the cpufreq driver
> > > > suspend callback, but is my driver suspend callback really guaranteed to
> > > > run before the device_prepare() that clears "wakeup_path" on the virtual
> > > > devices?
> > >
> > > Yes, that's guaranteed. dpm_prepare() (which calls device_prepare())
> > > is always being executed before dpm_suspend().
> > >
> >
> > Thanks, I think I understand. Maybe. :-)
> >
> > Just to confirm, I should call device_set_awake_path() for the virtual
> > genpd devices as part of the PM ->suspend() callback? And this will be
> > guaranteed to run after the "prepare" phase but before the
> > "suspend_noirq" phase where the genpd core will check the wakeup flag?
> 
> Correct!
> 

Thanks, this seems to works as intended! The diff I tested is below, in
case you already have some comments.

I'll put this into proper patches and will send a v3 after the merge
window.

Stephan

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 7e9202080c98..e0c82c958018 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -23,6 +23,7 @@
 #include <linux/nvmem-consumer.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
@@ -426,6 +427,18 @@ static const struct qcom_cpufreq_match_data match_data_ipq8074 = {
 	.get_version = qcom_cpufreq_ipq8074_name_version,
 };
 
+static void qcom_cpufreq_suspend_virt_devs(struct qcom_cpufreq_drv *drv, unsigned cpu)
+{
+	const char * const *name = drv->data->genpd_names;
+	int i;
+
+	if (!drv->cpus[cpu].virt_devs)
+		return;
+
+	for (i = 0; *name; i++, name++)
+		device_set_awake_path(drv->cpus[cpu].virt_devs[i]);
+}
+
 static void qcom_cpufreq_put_virt_devs(struct qcom_cpufreq_drv *drv, unsigned cpu)
 {
 	const char * const *name = drv->data->genpd_names;
@@ -542,9 +555,6 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 
 					goto free_opp;
 				}
-
-				/* Keep CPU power domain always-on */
-				dev_pm_syscore_device(virt_devs[i], true);
 			}
 			drv->cpus[cpu].virt_devs = virt_devs;
 		}
@@ -581,11 +591,25 @@ static void qcom_cpufreq_remove(struct platform_device *pdev)
 	}
 }
 
+static int qcom_cpufreq_suspend(struct device *dev)
+{
+	struct qcom_cpufreq_drv *drv = dev_get_drvdata(dev);
+	unsigned int cpu;
+
+	for_each_possible_cpu(cpu)
+		qcom_cpufreq_suspend_virt_devs(drv, cpu);
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(qcom_cpufreq_pm_ops, qcom_cpufreq_suspend, NULL);
+
 static struct platform_driver qcom_cpufreq_driver = {
 	.probe = qcom_cpufreq_probe,
 	.remove_new = qcom_cpufreq_remove,
 	.driver = {
 		.name = "qcom-cpufreq-nvmem",
+		.pm = pm_sleep_ptr(&qcom_cpufreq_pm_ops),
 	},
 };
 
diff --git a/drivers/pmdomain/qcom/rpmpd.c b/drivers/pmdomain/qcom/rpmpd.c
index abb62e4a2bdf..0f91e00b5909 100644
--- a/drivers/pmdomain/qcom/rpmpd.c
+++ b/drivers/pmdomain/qcom/rpmpd.c
@@ -1050,6 +1050,7 @@ static int rpmpd_probe(struct platform_device *pdev)
 		rpmpds[i]->pd.power_off = rpmpd_power_off;
 		rpmpds[i]->pd.power_on = rpmpd_power_on;
 		rpmpds[i]->pd.set_performance_state = rpmpd_set_performance;
+		rpmpds[i]->pd.flags = GENPD_FLAG_ACTIVE_WAKEUP;
 		pm_genpd_init(&rpmpds[i]->pd, NULL, true);
 
 		data->domains[i] = &rpmpds[i]->pd;

-- 
Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Kernkonzept GmbH at Dresden, Germany, HRB 31129, CEO Dr.-Ing. Michael Hohmuth
