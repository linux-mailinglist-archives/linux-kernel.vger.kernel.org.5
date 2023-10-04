Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED16F7B7C33
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241985AbjJDJeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242007AbjJDJeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:34:10 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF2DC4
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 02:34:03 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-27927d37ec7so1385545a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 02:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1696412043; x=1697016843; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nT8ftubfCGwwT4A/BlmuxmyIj2PQDGT0AjFeJGDQBzI=;
        b=GzLb27r4FMpIdsdkt3iDk5mlJttIEKNGXBKrt6sJPpeno8PS1v0FD6cNSB4yVY6J5J
         Z70ZTcnSL0tz0kym0yj1r+qF9jFgACsTv6hgVJuOaRabDcdfkeMYRs7ACNsNn39wmGnr
         18Wp+EKZO8rk1NXBbsOCirNbMsmp0lCO1Gt0TYejwh/QzhN0yNQV1VFh8SClNu18bPaZ
         Jc4hFmPg6k3fS22vpFKWJHdjjTmGa88qb0zuk2U3B/oRIE0Tks51HazxSvKV6ZhWML5P
         IP4W14UDJ1pUx5YDF2p64DzPSAQ2fn3zUGxR5QFmBRZUryr/QzE/59fZ00ZJbRPVbr+E
         /UiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696412043; x=1697016843;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nT8ftubfCGwwT4A/BlmuxmyIj2PQDGT0AjFeJGDQBzI=;
        b=mJYPbOqMTGwIRexK8iJzZQENOPKNJ2Nhf7I2Q+1dIHrWpcdRdmFC8lxwdtu+I4VmaU
         aAMk7HUGcG4MDs4biJutfHm3Nfd099LSg13fhRUXnDFcK6N75Lkh86wWUZEi5QwR02hx
         iiE6nRr/f5RkiKuw0c2ZyNku16aT8D8mvaNktUJqY0KzmoVW/RJtWhIws6Ez+1zouXiq
         PigIrfIR/o0RIVCInSftVN3pXfWWUIE38quqw4GFsihCqtRWbOi/1cs+Rx+6Eko0gGc+
         oJxEVahGU5vY3sETWWtXFBoGWNA9UXzBXdMLBYwrOklDwhscQ/9n6gbyW6Dk985bQwfw
         NZoA==
X-Gm-Message-State: AOJu0YyD5/BBdfh8Hh5WfNL+4RoTYbG/DrVs1kh9DBBD6jDE3NtAXOgv
        Lkbpfq9E88JI3mHDkWBrJSW8ZsB2u2tKwjojngoQew9iM2yT3UTI/3w=
X-Google-Smtp-Source: AGHT+IF+nOLcn1rQrNFiqUNTBB2Lc1jEcUA2XXyZPHMqXCZJh1uYTySQKzIIkpCCMjmTQ9B2PgptteSImecXZIDbD1s=
X-Received: by 2002:a17:90b:4a86:b0:274:5880:1606 with SMTP id
 lp6-20020a17090b4a8600b0027458801606mr1404817pjb.48.1696412043055; Wed, 04
 Oct 2023 02:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230922090330.1570350-1-naresh.solanki@9elements.com>
 <53bf617a-0a47-4c51-9738-6f6e6e520d99@hatter.bewilderbeest.net> <6da614bf-c35c-4bae-84d9-fb9641dcbe59@hatter.bewilderbeest.net>
In-Reply-To: <6da614bf-c35c-4bae-84d9-fb9641dcbe59@hatter.bewilderbeest.net>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Wed, 4 Oct 2023 15:03:52 +0530
Message-ID: <CABqG17jKFfv_cfSbWGUXnRn3wNrc6X-rCgT1gRKWopefoO-+oQ@mail.gmail.com>
Subject: Re: [RESEND PATCH] regulator: userspace-consumer: Retrieve supplies
 from DT
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     broonie@kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
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

Hi

On Sat, 23 Sept 2023 at 17:46, Zev Weiss <zev@bewilderbeest.net> wrote:
>
> On Sat, Sep 23, 2023 at 05:02:59AM PDT, Zev Weiss wrote:
> >Hi Naresh,
> >
> >This looks basically alright to me, though a few suggested tweaks
> >below...
> >
> >On Fri, Sep 22, 2023 at 02:03:29AM PDT, Naresh Solanki wrote:
> >>From: Naresh Solanki <Naresh.Solanki@9elements.com>
> >>
> >>Instead of hardcoding a single supply, retrieve supplies from DT.
> >>
> >>Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> >>---
> >>drivers/regulator/userspace-consumer.c | 43 ++++++++++++++++++++++++--
> >>1 file changed, 40 insertions(+), 3 deletions(-)
> >>
> >>diff --git a/drivers/regulator/userspace-consumer.c b/drivers/regulator/userspace-consumer.c
> >>index 97f075ed68c9..a3d3e1e6ca74 100644
> >>--- a/drivers/regulator/userspace-consumer.c
> >>+++ b/drivers/regulator/userspace-consumer.c
> >>@@ -115,11 +115,32 @@ static const struct attribute_group attr_group = {
> >>      .is_visible =  attr_visible,
> >>};
> >>
> >>+#define SUPPLY_SUFFIX "-supply"
> >>+#define SUPPLY_SUFFIX_LEN 7
> >
> >I think 'strlen(SUPPLY_SUFFIX)' would be preferable to a numeric
> >literal here; it's less fragile and the compiler can evaluate it at
> >compile-time anyway (not that it's likely to be performance-critical
> >in this context I'd expect).
> >
> >>+
> >>+static int get_num_supplies(struct platform_device *pdev)
> >>+{
> >>+     struct  property *prop;
> >>+     int num_supplies = 0;
> >>+
> >>+     for_each_property_of_node(pdev->dev.of_node, prop) {
> >>+             const char *prop_name = prop->name;
> >>+             int len = strlen(prop_name);
> >>+
> >>+             if (len > SUPPLY_SUFFIX_LEN &&
> >>+                 strcmp(prop_name + len - SUPPLY_SUFFIX_LEN, SUPPLY_SUFFIX) == 0) {
> >>+                     num_supplies++;
> >>+             }
> >
> >Preferred coding style is to omit braces around single-line 'if' blocks.
> >
> >>+     }
> >>+     return num_supplies;
> >>+}
> >>+
> >>static int regulator_userspace_consumer_probe(struct platform_device *pdev)
> >>{
> >>      struct regulator_userspace_consumer_data tmpdata;
> >>      struct regulator_userspace_consumer_data *pdata;
> >>      struct userspace_consumer_data *drvdata;
> >>+     struct  property *prop;
> >
> >Looks like there's an extra space after 'struct' here.
> >
> >>      int ret;
> >>
> >>      pdata = dev_get_platdata(&pdev->dev);
> >>@@ -131,11 +152,27 @@ static int regulator_userspace_consumer_probe(struct platform_device *pdev)
> >>              memset(pdata, 0, sizeof(*pdata));
> >>
> >>              pdata->no_autoswitch = true;
> >>-             pdata->num_supplies = 1;
> >>-             pdata->supplies = devm_kzalloc(&pdev->dev, sizeof(*pdata->supplies), GFP_KERNEL);
> >>+             pdata->num_supplies = get_num_supplies(pdev);
> >>+
> >>+             pdata->supplies = devm_kzalloc(&pdev->dev, pdata->num_supplies *
> >>+                                            sizeof(*pdata->supplies), GFP_KERNEL);
> >
> >Splitting the multiplication across two lines like that isn't great
> >readability-wise IMO; it might be better to just assign it to a
> >variable and use that instead to make things fit nicely.
> >
> >>              if (!pdata->supplies)
> >>                      return -ENOMEM;
> >>-             pdata->supplies[0].supply = "vout";
> >>+
> >>+             for_each_property_of_node(pdev->dev.of_node, prop) {
> >>+                     const char *prop_name = prop->name;
> >>+                     int len = strlen(prop_name);
> >>+
> >>+                     if (len > SUPPLY_SUFFIX_LEN &&
> >>+                         strcmp(prop_name + len - SUPPLY_SUFFIX_LEN, SUPPLY_SUFFIX) == 0) {
> >
> >Rather than duplicating this suffix-checking code, how about factoring
> >out a helper function like prop_is_supply() or something to use both
> >here and in get_num_supplies()?
> >
> >Or actually to make it integrate here a little more nicely, you could
> >have something like 'size_t prop_supply_name(char*)', returning zero
>
> Or rather prop_supply_name_len(), to make the name a bit more accurate.
>
> >if it doesn't end with "-supply", and the length of the name before
> >the suffix if it does, so that get_num_supplies() could use it as a
> >boolean and the code below could use the length to determine the
> >allocation size.
> >
> >>+                             char *supply_name = devm_kzalloc(&pdev->dev,
> >>+                                                              len - SUPPLY_SUFFIX_LEN + 1,
> >>+                                                              GFP_KERNEL);
> >>+                             strscpy(supply_name, prop_name, len - SUPPLY_SUFFIX_LEN);
> >>+                             supply_name[len - SUPPLY_SUFFIX_LEN] = '\0';
>
> Also, kstrndup() would be a cleaner replacement for these lines, though
> then the cleanup would get messy, and sadly a devm_kstrndup() doesn't
> currently exist -- maybe it'd be worth adding separately?  Or
> alternately you could just use devm_kstrdup() and then truncate it by
> inserting a '\0'.
Sure. Will make it like:

char *supply_name = devm_kstrdup(&pdev->dev, prop_name, GFP_KERNEL);
supply_name[supply_len] = '\0';
pdata->supplies[0].supply = supply_name;

Regards,
Naresh
>
> >>+                             pdata->supplies[0].supply = supply_name;
> >>+                     }
> >>+             }
> >>      }
> >>
> >>      if (pdata->num_supplies < 1) {
> >>
> >>base-commit: 451e85e29c9d6f20639d4cfcff4b9dea280178cc
> >>--
> >>2.41.0
> >>
