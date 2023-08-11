Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FA9779612
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236769AbjHKR2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbjHKR2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:28:02 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF73CE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:28:01 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5657add1073so522919a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1691774881; x=1692379681;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T357cVNGxKdvrgjkl+ScQ6i4J1Sdi/gRYjbZOopfFvU=;
        b=E0iIUDTyn0wlRV7pepsTjp/YcDRNwFsdAzy7+sUkClnZhsl2mhCq9ooyNzH2SepEkb
         +uRSNLTCVnyIh3OKz4TLnZg4uvONuXBf5tdT7dJm3bR5Ztx+oI+9+ThsrC8p/oplL6O+
         ql73K1KW1G2xYnZA5BuHdif96QgimnjuwDBRM8p2ePcCIzxBbnR5kFNwe7G4sjYF9Xli
         mEsFnL2vgSh64g5onm1aazw988/790gm3Iww5sJH5X4sZ7WhtsooQ89DfH6bopHtCPXB
         8mBU411Pbx3Q1bwVMrF9VGl9u3jSQ2KlizDQZBpyBtt/++u6fSX010UrNTLctBwN4DlG
         TqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691774881; x=1692379681;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T357cVNGxKdvrgjkl+ScQ6i4J1Sdi/gRYjbZOopfFvU=;
        b=dmDCG/fZTiWaRjugpygDsXUJ9cLcHoahQZkXBThXsefmvBtF+hc3tXIgpMBhbfl2/F
         LiyVHAzJigC6t4dLKARMu3fEKXQQfLV9d9sz0/A8umtpn7coXz3q+8i5M9daePG9M0LL
         rDoSWFUfvVIf+IwzFTUHyKz8JVd2BjFqdRpRqPPc8YLmS6nZ190cFvqacVhqgffUHOH9
         HrsGtmfcj4bpY9TMKk9Zwh1xI7joP7oCadkBbeg+gbuNz6pI9tzPn8wobgbeR3eGEWF7
         AUWCtJZkYKcDdQGZrCPKjuUtd4dTLrcIIm1OC5SprUmeywOTicvP+QJTTwOhBkl6gxcZ
         yHMg==
X-Gm-Message-State: AOJu0YxPwQ+IuqV6qbhHGwjQXbo2gVr7S00wM2Vh8CVj8SEOjaLXXJzl
        JLnHcliTBUKZaNhoTzbAMOZ3FtYndFbqziJ2WahXlA==
X-Google-Smtp-Source: AGHT+IEJrVMzEsitlXoQ3k7SSNOvcEEH7VgopuMa41sm1JpgMtnsBYElOoN080rA4YrtPLTspZ/49fhZF+h/3GYmS0c=
X-Received: by 2002:a17:90b:1010:b0:268:f8c8:bd5c with SMTP id
 gm16-20020a17090b101000b00268f8c8bd5cmr7517326pjb.17.1691774880823; Fri, 11
 Aug 2023 10:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230803111225.107572-1-Naresh.Solanki@9elements.com>
 <d3ea0fe2-00bb-493b-aca7-ba7a31bd3c78@hatter.bewilderbeest.net>
 <CABqG17j1KGoW3UVM1kttg08V0R0xC0gP3YOyE7DeboE4SWa+vw@mail.gmail.com> <0643fa76-5320-4e1a-84d4-c3be4b1d1df6@hatter.bewilderbeest.net>
In-Reply-To: <0643fa76-5320-4e1a-84d4-c3be4b1d1df6@hatter.bewilderbeest.net>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Fri, 11 Aug 2023 22:57:52 +0530
Message-ID: <CABqG17i7QCE7-T+EWongwUhZ3qEBhrNZs9iA830tGBwkbPr0Lg@mail.gmail.com>
Subject: Re: [PATCH] regulator: userspace-consumer: Add regulator event support
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zev,

On Fri, 4 Aug 2023 at 17:32, Zev Weiss <zev@bewilderbeest.net> wrote:
>
> On Fri, Aug 04, 2023 at 01:59:44AM PDT, Naresh Solanki wrote:
> >Hi Zev,
> >
> >
> >On Fri, 4 Aug 2023 at 02:15, Zev Weiss <zev@bewilderbeest.net> wrote:
> >>
> >> On Thu, Aug 03, 2023 at 04:12:25AM PDT, Naresh Solanki wrote:
> >> >Add sysfs attribute to track regulator events received from regulator
> >> >notifier block handler.
> >> >
> >>
> >> Hi Naresh,
> >>
> >> Could you provide a bit more detail on how this is intended to be used?
> >> Some of the details (more below) seem a bit odd to me...
> >My application registers a event callback on the 'events' to track regulator
> >events
> >Reference:
> >https://github.com/9elements/pwrseqd/blob/main/src/VoltageRegulatorSysfs.cpp#L258
> >>
> >> >Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> >> >---
> >> > drivers/regulator/userspace-consumer.c | 52 +++++++++++++++++++++++++-
> >> > 1 file changed, 51 insertions(+), 1 deletion(-)
> >> >
> >> >diff --git a/drivers/regulator/userspace-consumer.c b/drivers/regulator/userspace-consumer.c
> >> >index 97f075ed68c9..a0b980022993 100644
> >> >--- a/drivers/regulator/userspace-consumer.c
> >> >+++ b/drivers/regulator/userspace-consumer.c
> >> >@@ -29,6 +29,10 @@ struct userspace_consumer_data {
> >> >
> >> >       int num_supplies;
> >> >       struct regulator_bulk_data *supplies;
> >> >+
> >> >+      struct kobject *kobj;
> >> >+      struct notifier_block nb;
> >> >+      unsigned long events;
> >> > };
> >> >
> >> > static ssize_t name_show(struct device *dev,
> >> >@@ -89,12 +93,30 @@ static ssize_t state_store(struct device *dev, struct device_attribute *attr,
> >> >       return count;
> >> > }
> >> >
> >> >+static DEFINE_MUTEX(events_lock);
> >> >+
> >> >+static ssize_t events_show(struct device *dev,
> >> >+                         struct device_attribute *attr, char *buf)
> >> >+{
> >> >+      struct userspace_consumer_data *data = dev_get_drvdata(dev);
> >> >+      unsigned long e;
> >> >+
> >> >+      mutex_lock(&events_lock);
> >> >+      e = data->events;
> >> >+      data->events = 0;
> >>
> >> ...particularly this bit -- a read operation on a read-only file (and
> >> especially one with 0644 permissions) having side-effects (clearing the
> >> value it accesses) seems on the face of it like fairly surprising
> >> behavior.  Is this a pattern that's used elsewhere in any other sysfs
> >> files?
> >These are regulator events & are valid when it occurs.
> >Userspace application is intended to consume them as soon as the
> >event is notified by kernel sysfs_notify.
> >
>
> Sure, but that doesn't really address what I was concerned about -- as
> written this is a read operation on a read-only file (0444, not 0644 as
> I mistakenly wrote above) that nevertheless alters the state of an
> internal kernel data structure.  Can you point to any other sysfs
> attributes that behave like that?  I can't think of one offhand, and I'd
> be reluctant to establish the precedent.
I guess many hwmon properties on input are readonly & its possible to
send sysfs_notify on the properties.
Like in
https://github.com/torvalds/linux/blob/master/drivers/hwmon/hwmon.c#L668

>
> Would a uevent-based mechanism maybe be a better fit for the problem
> you're trying to solve?
If the application also needs uevent then that can be added as done in hwmon.
>
> >>
> >> >+      mutex_unlock(&events_lock);
> >> >+
> >> >+      return sprintf(buf, "0x%lx\n", e);
> >> >+}
> >> >+
> >> > static DEVICE_ATTR_RO(name);
> >> > static DEVICE_ATTR_RW(state);
> >> >+static DEVICE_ATTR_RO(events);
> >>
> >> New sysfs attributes should be documented in Documentation/ABI, which
> >> this appears to be missing.
> >Sure I can check.
For Documentation/ABI, 'sysfs-driver-regulator-output' below. let me know
if this looks ok.
What:           /sys/bus/platform/drivers/regulator-output/*/events
Date:           August 2023
Contact:        Naresh Solanki <naresh.solanki@9elements.com>
Description:    Provided regulator events.

                Read provides various events the regulator associated with the
                driver has encountered. All REGULATOR_EVENT_* are
                defined in include/linux/regulator/consumer.h

                e.g.
                cat /sys/bus/platform/drivers/regulator-output/ssb_rssd32/events
                0x0
> >>
> >> However, it looks like this would expose the values of all the
> >> REGULATOR_EVENT_* constants as a userspace-visible ABI -- is that
> >> something we really want to do?
> >Yes.
>
> Given that the REGULATOR_EVENT_* constants are defined in headers under
> include/linux and not include/uapi, it doesn't seem like they were
> intended to be used as part of a userspace-visible interface.  If
> they're going to be, I think they should be moved to the uapi directory
> so that applications can use the proper definitions from the kernel
> instead of manually replicating it on their own (but I suspect we should
> probably find a different approach instead).
Yes they have to be moved to include/uapi in that case.
>
> >>
> >> >
> >> > static struct attribute *attributes[] = {
> >> >       &dev_attr_name.attr,
> >> >       &dev_attr_state.attr,
> >> >+      &dev_attr_events.attr,
> >> >       NULL,
> >> > };
> >> >
> >> >@@ -115,12 +137,28 @@ static const struct attribute_group attr_group = {
> >> >       .is_visible =  attr_visible,
> >> > };
> >> >
> >> >+static int regulator_userspace_notify(struct notifier_block *nb,
> >> >+                                    unsigned long event,
> >> >+                                    void *ignored)
> >> >+{
> >> >+      struct userspace_consumer_data *data =
> >> >+              container_of(nb, struct userspace_consumer_data, nb);
> >> >+
> >> >+      mutex_lock(&events_lock);
> >> >+      data->events |= event;
> >> >+      mutex_unlock(&events_lock);
> >> >+
> >>
> >> Using a single global mutex (events_lock) to protect a single member of
> >> a per-device struct looks weird.  Unless there's something subtle going
> >> on that I'm not seeing, it seems like the lock should be a member of the
> >> data struct instead of global, and since no blocking operations happen
> >> under it could it just be a spinlock?  Or since it's just some simple
> >> updates to a single variable, why not just use an atomic_t and skip the
> >> lock entirely?
> >Intent is that only one thread at a time is to be allowed to access/modify
> >the data->events variable to prevent potential data corruption and
> >race conditions. Sure can change it to spinlock or atomic_t.
> >
> >>
> >> >+      sysfs_notify(data->kobj, NULL, dev_attr_events.attr.name);
> >> >+
> >> >+      return NOTIFY_OK;
> >> >+}
> >> >+
> >> > static int regulator_userspace_consumer_probe(struct platform_device *pdev)
> >> > {
> >> >       struct regulator_userspace_consumer_data tmpdata;
> >> >       struct regulator_userspace_consumer_data *pdata;
> >> >       struct userspace_consumer_data *drvdata;
> >> >-      int ret;
> >> >+      int i, ret;
> >> >
> >> >       pdata = dev_get_platdata(&pdev->dev);
> >> >       if (!pdata) {
> >> >@@ -153,6 +191,7 @@ static int regulator_userspace_consumer_probe(struct platform_device *pdev)
> >> >       drvdata->num_supplies = pdata->num_supplies;
> >> >       drvdata->supplies = pdata->supplies;
> >> >       drvdata->no_autoswitch = pdata->no_autoswitch;
> >> >+      drvdata->kobj = &pdev->dev.kobj;
> >> >
> >> >       mutex_init(&drvdata->lock);
> >> >
> >> >@@ -186,6 +225,13 @@ static int regulator_userspace_consumer_probe(struct platform_device *pdev)
> >> >       }
> >> >       drvdata->enabled = !!ret;
> >> >
> >> >+      drvdata->nb.notifier_call = regulator_userspace_notify;
> >> >+      for (i = 0; i < drvdata->num_supplies; i++) {
> >> >+              ret = devm_regulator_register_notifier(drvdata->supplies[i].consumer, &drvdata->nb);
> >> >+              if (ret)
> >> >+                      goto err_enable;
> >> >+      }
> >> >+
> >> >       return 0;
> >> >
> >> > err_enable:
> >> >@@ -197,6 +243,10 @@ static int regulator_userspace_consumer_probe(struct platform_device *pdev)
> >> > static int regulator_userspace_consumer_remove(struct platform_device *pdev)
> >> > {
> >> >       struct userspace_consumer_data *data = platform_get_drvdata(pdev);
> >> >+      int i;
> >> >+
> >> >+      for (i = 0; i < data->num_supplies; i++)
> >> >+              devm_regulator_unregister_notifier(data->supplies[i].consumer, &data->nb);
> >> >
> >> >       sysfs_remove_group(&pdev->dev.kobj, &attr_group);
> >> >
> >> >
> >> >base-commit: 4fb53b2377c364e3753d6e293913b57dad68e98b
> >> >--
> >> >2.41.0
> >> >
