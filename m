Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFCD07B7BC7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbjJDJUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbjJDJUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:20:18 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130BA9E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 02:20:15 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3ae2f8bf865so1103718b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 02:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1696411214; x=1697016014; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z4ZEfq04zllrSRTzv7mmbRW2t6PRThmiMwyytpscDSc=;
        b=AVwmhLncsdiBqBgOZcgKH3e7dXFcXp4apgXYqs6rMWtnPfTfgXdTVAz64oLNxSi+5V
         ld61c7tzxO6HfYjgVEzPWr9zNSPbZcngYvthb0UtQQ4TwGtr1vFK3R5MfJQPmi3O7qMC
         7++Jb7FXxeTeLltuxJllurr3T9tdjXjwAx68I8rNMbhYXzdLq7zn3GLAC8wywzPaKz15
         m2fSFXHLlnYMc+gjDPzQHkMbZZP2FzI+z3QvcfEGoHw+moY7ZhAPoD3O8apgkjMose6T
         vDKcbQ5cDVxxBxFINVt4GHgDxbo66bSboKTT4tb+JRNMakT2cCPyOEpWNKu6LxdTUcWs
         4Fcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696411214; x=1697016014;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z4ZEfq04zllrSRTzv7mmbRW2t6PRThmiMwyytpscDSc=;
        b=Izj3KcWfQonEHIszfYU2STpzDm0UuQzwn45uq4tvE1K6s8FvVAarptsDKklqdxEjRd
         c37HPS8MdK7UH43r6brYxXPdk/0n14Tk3EnlgMesKtgmRQkMulznGxbAkSz56+QqKDH4
         7TzWULFli7BwYoZmGQ9mMXsmlKdCIVsDGCkGXpJhTD16BgX4kUY7C9baztIIZH2Y4Nro
         NQ658ow46BW8AqoNyTV6IZz71DzoTB8vADZ2gowgH4HF9gwHrBwRqC/pP5sHRyEnK53B
         a0DAIiaY6m3RrCZ4yb+uPkszPC/szSrfSg22uLCz2r+gmeZiBEp1NuBQlO3a09v3XsA5
         8gXA==
X-Gm-Message-State: AOJu0YxAvW4VJfk4tuIAmCoY0jPA4w1saeBi/iAu5wfPkqoGGB7yw3mE
        dEEfBA693gbE2XiOZdWZQDDdljpnGwO13le057Nmww==
X-Google-Smtp-Source: AGHT+IHV5TwsPjh6OyF3H08WuFn96uysdJkng0j7hoGtEUsTjH+O7wKq0LcyjT/enJXXkJFbDeWCKhJjcSHkes/YQtI=
X-Received: by 2002:a05:6358:7e07:b0:139:c75f:63eb with SMTP id
 o7-20020a0563587e0700b00139c75f63ebmr1856623rwm.21.1696411214255; Wed, 04 Oct
 2023 02:20:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230922090330.1570350-1-naresh.solanki@9elements.com> <53bf617a-0a47-4c51-9738-6f6e6e520d99@hatter.bewilderbeest.net>
In-Reply-To: <53bf617a-0a47-4c51-9738-6f6e6e520d99@hatter.bewilderbeest.net>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Wed, 4 Oct 2023 14:50:02 +0530
Message-ID: <CABqG17h2tvTx4QD9RcoTZH-_J+g_F36CKdtujTxz9Xf5uwsThQ@mail.gmail.com>
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

On Sat, 23 Sept 2023 at 17:33, Zev Weiss <zev@bewilderbeest.net> wrote:
>
> Hi Naresh,
>
> This looks basically alright to me, though a few suggested tweaks
> below...
>
> On Fri, Sep 22, 2023 at 02:03:29AM PDT, Naresh Solanki wrote:
> >From: Naresh Solanki <Naresh.Solanki@9elements.com>
> >
> >Instead of hardcoding a single supply, retrieve supplies from DT.
> >
> >Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> >---
> > drivers/regulator/userspace-consumer.c | 43 ++++++++++++++++++++++++--
> > 1 file changed, 40 insertions(+), 3 deletions(-)
> >
> >diff --git a/drivers/regulator/userspace-consumer.c b/drivers/regulator/userspace-consumer.c
> >index 97f075ed68c9..a3d3e1e6ca74 100644
> >--- a/drivers/regulator/userspace-consumer.c
> >+++ b/drivers/regulator/userspace-consumer.c
> >@@ -115,11 +115,32 @@ static const struct attribute_group attr_group = {
> >       .is_visible =  attr_visible,
> > };
> >
> >+#define SUPPLY_SUFFIX "-supply"
> >+#define SUPPLY_SUFFIX_LEN 7
>
> I think 'strlen(SUPPLY_SUFFIX)' would be preferable to a numeric literal
> here; it's less fragile and the compiler can evaluate it at compile-time
> anyway (not that it's likely to be performance-critical in this context
> I'd expect).
Sure.

>
> >+
> >+static int get_num_supplies(struct platform_device *pdev)
> >+{
> >+      struct  property *prop;
> >+      int num_supplies = 0;
> >+
> >+      for_each_property_of_node(pdev->dev.of_node, prop) {
> >+              const char *prop_name = prop->name;
> >+              int len = strlen(prop_name);
> >+
> >+              if (len > SUPPLY_SUFFIX_LEN &&
> >+                  strcmp(prop_name + len - SUPPLY_SUFFIX_LEN, SUPPLY_SUFFIX) == 0) {
> >+                      num_supplies++;
> >+              }
>
> Preferred coding style is to omit braces around single-line 'if' blocks.
Sure
>
> >+      }
> >+      return num_supplies;
> >+}
> >+
> > static int regulator_userspace_consumer_probe(struct platform_device *pdev)
> > {
> >       struct regulator_userspace_consumer_data tmpdata;
> >       struct regulator_userspace_consumer_data *pdata;
> >       struct userspace_consumer_data *drvdata;
> >+      struct  property *prop;
>
> Looks like there's an extra space after 'struct' here.
Will fix that.
>
> >       int ret;
> >
> >       pdata = dev_get_platdata(&pdev->dev);
> >@@ -131,11 +152,27 @@ static int regulator_userspace_consumer_probe(struct platform_device *pdev)
> >               memset(pdata, 0, sizeof(*pdata));
> >
> >               pdata->no_autoswitch = true;
> >-              pdata->num_supplies = 1;
> >-              pdata->supplies = devm_kzalloc(&pdev->dev, sizeof(*pdata->supplies), GFP_KERNEL);
> >+              pdata->num_supplies = get_num_supplies(pdev);
> >+
> >+              pdata->supplies = devm_kzalloc(&pdev->dev, pdata->num_supplies *
> >+                                             sizeof(*pdata->supplies), GFP_KERNEL);
>
> Splitting the multiplication across two lines like that isn't great
> readability-wise IMO; it might be better to just assign it to a variable
> and use that instead to make things fit nicely.
Sure can do that. Will make like:

supplies_size = pdata->num_supplies * sizeof(*pdata->supplies);
pdata->supplies = devm_kzalloc(&pdev->dev, supplies_size, GFP_KERNEL);

>
> >               if (!pdata->supplies)
> >                       return -ENOMEM;
> >-              pdata->supplies[0].supply = "vout";
> >+
> >+              for_each_property_of_node(pdev->dev.of_node, prop) {
> >+                      const char *prop_name = prop->name;
> >+                      int len = strlen(prop_name);
> >+
> >+                      if (len > SUPPLY_SUFFIX_LEN &&
> >+                          strcmp(prop_name + len - SUPPLY_SUFFIX_LEN, SUPPLY_SUFFIX) == 0) {
>
> Rather than duplicating this suffix-checking code, how about factoring
> out a helper function like prop_is_supply() or something to use both
> here and in get_num_supplies()?
>
> Or actually to make it integrate here a little more nicely, you could
> have something like 'size_t prop_supply_name(char*)', returning zero if
> it doesn't end with "-supply", and the length of the name before the
> suffix if it does, so that get_num_supplies() could use it as a boolean
> and the code below could use the length to determine the allocation
> size.
Yes thats better idea will do that.

>
> >+                              char *supply_name = devm_kzalloc(&pdev->dev,
> >+                                                               len - SUPPLY_SUFFIX_LEN + 1,
> >+                                                               GFP_KERNEL);
> >+                              strscpy(supply_name, prop_name, len - SUPPLY_SUFFIX_LEN);
> >+                              supply_name[len - SUPPLY_SUFFIX_LEN] = '\0';
> >+                              pdata->supplies[0].supply = supply_name;
> >+                      }
> >+              }
> >       }
> >
> >       if (pdata->num_supplies < 1) {
> >
> >base-commit: 451e85e29c9d6f20639d4cfcff4b9dea280178cc
> >--
> >2.41.0
> >
