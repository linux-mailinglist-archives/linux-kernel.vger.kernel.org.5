Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785C576FCCA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjHDJEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjHDJDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:03:41 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89D85BA9
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:59:56 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bba2318546so16124675ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 01:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1691139596; x=1691744396;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p8xbFALbUi/aPvbyXUxUZArjYaoNFU5bFlaFH8YbE9c=;
        b=JiB3U7Xb1ZZGZZOnKeEScbCBtKkUUJOrcenL3F/g2056TP6mQ8WddV6zeK9ouCZpRf
         Zidox+WnOIhid82UT9cpLXqTJyK/hY9fcOO+M27Ks916EQTKyiVcSXGbBfZPoUehUtB2
         musYXzi/3bULgrQcke1KHXpYN2AhoXSzmHV1HacAwrO1rCsrFGmOCWdQl7OuLffxIqo9
         ZwRjhdk+AZJJ1EEr5Q2TJJw1RRh981LJB7F6Z6vBZS0J1EL7i4oojL401YbKdKX/I1Og
         Ty/vOZWwK47Ct+r456L5ldQ8DxYD9p/iEwuqnYFWSk/rlg9ugosMgpgl5bzot106abi1
         tgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691139596; x=1691744396;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p8xbFALbUi/aPvbyXUxUZArjYaoNFU5bFlaFH8YbE9c=;
        b=lRremcdkhSO5EAFdP+W27SGXCfV1xlM2DBoiwN4aKh5/hVbEIGicS8wugrV7oz+OwI
         4T70snl7SCIgKHoV8TWunVePNNlDNxMmKGBz57XfqpLOgA+mY27K3hVVKtCQdazTFm6y
         Pp0//aVrbO4KfLuM3eH9Gs4OcmrBemMq+UD5bv26PpzNMeoC7SpsAOG4znPVC9qTYPQT
         0+MJS7EVMCli7y0GzjIzEjYuSVwcYRV7tKSU5/6cfoYS+0hQ0h/EmSIMRKct4x3j9ObX
         U1HbQNM1XzwXTJalP6x2Qd+nO2N6FMZSZ/NnkcYuKqRRKXeUl7Iw1rN/RNjL0M8cmgmj
         iTFA==
X-Gm-Message-State: AOJu0YwbWu8/39z24Gh1/smjsvQKdlxo5mp3eAm0XerTEYibESwyDQeJ
        tWin8y/zDv9cQ7A9A1J73BAPDLpWHKQeAMcyoL49aNnRpRl2huO2K0Ot5KeS
X-Google-Smtp-Source: AGHT+IGAcQkPHtXWKYXmkbu5jAoPlmsvSNQl66fW3RQ7F1AyzA6h9TYprPeGEZbCGe0sfh75trGN6g35xofhPN3eUZw=
X-Received: by 2002:a17:90b:fca:b0:268:46fb:df32 with SMTP id
 gd10-20020a17090b0fca00b0026846fbdf32mr1189008pjb.34.1691139595859; Fri, 04
 Aug 2023 01:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230803111225.107572-1-Naresh.Solanki@9elements.com> <d3ea0fe2-00bb-493b-aca7-ba7a31bd3c78@hatter.bewilderbeest.net>
In-Reply-To: <d3ea0fe2-00bb-493b-aca7-ba7a31bd3c78@hatter.bewilderbeest.net>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Fri, 4 Aug 2023 14:29:44 +0530
Message-ID: <CABqG17j1KGoW3UVM1kttg08V0R0xC0gP3YOyE7DeboE4SWa+vw@mail.gmail.com>
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


On Fri, 4 Aug 2023 at 02:15, Zev Weiss <zev@bewilderbeest.net> wrote:
>
> On Thu, Aug 03, 2023 at 04:12:25AM PDT, Naresh Solanki wrote:
> >Add sysfs attribute to track regulator events received from regulator
> >notifier block handler.
> >
>
> Hi Naresh,
>
> Could you provide a bit more detail on how this is intended to be used?
> Some of the details (more below) seem a bit odd to me...
My application registers a event callback on the 'events' to track regulator
events
Reference:
https://github.com/9elements/pwrseqd/blob/main/src/VoltageRegulatorSysfs.cpp#L258
>
> >Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> >---
> > drivers/regulator/userspace-consumer.c | 52 +++++++++++++++++++++++++-
> > 1 file changed, 51 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/regulator/userspace-consumer.c b/drivers/regulator/userspace-consumer.c
> >index 97f075ed68c9..a0b980022993 100644
> >--- a/drivers/regulator/userspace-consumer.c
> >+++ b/drivers/regulator/userspace-consumer.c
> >@@ -29,6 +29,10 @@ struct userspace_consumer_data {
> >
> >       int num_supplies;
> >       struct regulator_bulk_data *supplies;
> >+
> >+      struct kobject *kobj;
> >+      struct notifier_block nb;
> >+      unsigned long events;
> > };
> >
> > static ssize_t name_show(struct device *dev,
> >@@ -89,12 +93,30 @@ static ssize_t state_store(struct device *dev, struct device_attribute *attr,
> >       return count;
> > }
> >
> >+static DEFINE_MUTEX(events_lock);
> >+
> >+static ssize_t events_show(struct device *dev,
> >+                         struct device_attribute *attr, char *buf)
> >+{
> >+      struct userspace_consumer_data *data = dev_get_drvdata(dev);
> >+      unsigned long e;
> >+
> >+      mutex_lock(&events_lock);
> >+      e = data->events;
> >+      data->events = 0;
>
> ...particularly this bit -- a read operation on a read-only file (and
> especially one with 0644 permissions) having side-effects (clearing the
> value it accesses) seems on the face of it like fairly surprising
> behavior.  Is this a pattern that's used elsewhere in any other sysfs
> files?
These are regulator events & are valid when it occurs.
Userspace application is intended to consume them as soon as the
event is notified by kernel sysfs_notify.

>
> >+      mutex_unlock(&events_lock);
> >+
> >+      return sprintf(buf, "0x%lx\n", e);
> >+}
> >+
> > static DEVICE_ATTR_RO(name);
> > static DEVICE_ATTR_RW(state);
> >+static DEVICE_ATTR_RO(events);
>
> New sysfs attributes should be documented in Documentation/ABI, which
> this appears to be missing.
Sure I can check.
>
> However, it looks like this would expose the values of all the
> REGULATOR_EVENT_* constants as a userspace-visible ABI -- is that
> something we really want to do?
Yes.
>
> >
> > static struct attribute *attributes[] = {
> >       &dev_attr_name.attr,
> >       &dev_attr_state.attr,
> >+      &dev_attr_events.attr,
> >       NULL,
> > };
> >
> >@@ -115,12 +137,28 @@ static const struct attribute_group attr_group = {
> >       .is_visible =  attr_visible,
> > };
> >
> >+static int regulator_userspace_notify(struct notifier_block *nb,
> >+                                    unsigned long event,
> >+                                    void *ignored)
> >+{
> >+      struct userspace_consumer_data *data =
> >+              container_of(nb, struct userspace_consumer_data, nb);
> >+
> >+      mutex_lock(&events_lock);
> >+      data->events |= event;
> >+      mutex_unlock(&events_lock);
> >+
>
> Using a single global mutex (events_lock) to protect a single member of
> a per-device struct looks weird.  Unless there's something subtle going
> on that I'm not seeing, it seems like the lock should be a member of the
> data struct instead of global, and since no blocking operations happen
> under it could it just be a spinlock?  Or since it's just some simple
> updates to a single variable, why not just use an atomic_t and skip the
> lock entirely?
Intent is that only one thread at a time is to be allowed to access/modify
the data->events variable to prevent potential data corruption and
race conditions. Sure can change it to spinlock or atomic_t.

>
> >+      sysfs_notify(data->kobj, NULL, dev_attr_events.attr.name);
> >+
> >+      return NOTIFY_OK;
> >+}
> >+
> > static int regulator_userspace_consumer_probe(struct platform_device *pdev)
> > {
> >       struct regulator_userspace_consumer_data tmpdata;
> >       struct regulator_userspace_consumer_data *pdata;
> >       struct userspace_consumer_data *drvdata;
> >-      int ret;
> >+      int i, ret;
> >
> >       pdata = dev_get_platdata(&pdev->dev);
> >       if (!pdata) {
> >@@ -153,6 +191,7 @@ static int regulator_userspace_consumer_probe(struct platform_device *pdev)
> >       drvdata->num_supplies = pdata->num_supplies;
> >       drvdata->supplies = pdata->supplies;
> >       drvdata->no_autoswitch = pdata->no_autoswitch;
> >+      drvdata->kobj = &pdev->dev.kobj;
> >
> >       mutex_init(&drvdata->lock);
> >
> >@@ -186,6 +225,13 @@ static int regulator_userspace_consumer_probe(struct platform_device *pdev)
> >       }
> >       drvdata->enabled = !!ret;
> >
> >+      drvdata->nb.notifier_call = regulator_userspace_notify;
> >+      for (i = 0; i < drvdata->num_supplies; i++) {
> >+              ret = devm_regulator_register_notifier(drvdata->supplies[i].consumer, &drvdata->nb);
> >+              if (ret)
> >+                      goto err_enable;
> >+      }
> >+
> >       return 0;
> >
> > err_enable:
> >@@ -197,6 +243,10 @@ static int regulator_userspace_consumer_probe(struct platform_device *pdev)
> > static int regulator_userspace_consumer_remove(struct platform_device *pdev)
> > {
> >       struct userspace_consumer_data *data = platform_get_drvdata(pdev);
> >+      int i;
> >+
> >+      for (i = 0; i < data->num_supplies; i++)
> >+              devm_regulator_unregister_notifier(data->supplies[i].consumer, &data->nb);
> >
> >       sysfs_remove_group(&pdev->dev.kobj, &attr_group);
> >
> >
> >base-commit: 4fb53b2377c364e3753d6e293913b57dad68e98b
> >--
> >2.41.0
> >
