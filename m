Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D16777F271
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349109AbjHQIsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349208AbjHQIsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:48:36 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64852D57;
        Thu, 17 Aug 2023 01:48:24 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe1a17f983so67922655e9.3;
        Thu, 17 Aug 2023 01:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692262103; x=1692866903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dGOPI5y2sNHYEFQqa7vno1niWSdP4BceQq/Hcpqpq8=;
        b=GNcZbVucaaZ5sG/mb/tZq0cH/+GIPzroaobz13J8QbhUGMc2kiDw3bFIBbaWRUrMQi
         4Cj9KzsmNcgK2HsA3HgbUIWXy6dK3iTjajcVkBj80imrOCYVZTjynSHOXFCjNIOf7WPu
         7QfOtvejTiLAHXIsbvnrPAhbtwJfTHeGFWbUqaPtj4N2Xmc7bZTWIgcd8vepJvh7800w
         9VrvqOUwOgYGip2+QtVMjXylSDy7TbTFoIq+g+s8s5MpwANKUNzzFUYOzVFyz2kabBqd
         BnmYFashRuNNKeQbOFIbf+Jf+8UcgE4Ik1zEQptGma7jmd48ubF+SdZykvhjVoMRP2jZ
         f8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692262103; x=1692866903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5dGOPI5y2sNHYEFQqa7vno1niWSdP4BceQq/Hcpqpq8=;
        b=a82q6yOiOs6+edoQNEIh96EWDyfkgE3DVdjzzH4lyCyd5/7OkYiWu5UB1/HeCniOhX
         nlkmg5+olYc85+JHbh4zaOOucEJbGYYqOc3frJnkB/HlB4US93iR+uAMVYNv9nu+c5bw
         /GwKpRaaQdu9klDnMT2Ih3ptpR4TfWu/VHAFANS7/b2trUrJZDGCBGQb4Z257Ui8QLod
         5ZM3mjZh4nCVH1iqZETY+NuT6tXY1ZG1u1l09qZT5aLJrCnJPzoW7comf0aW0rJErfcg
         k0Pd07VvYr26GWoC0XwDvKr0KTwcFm2hwfdhlWQ6sYKmTBlPUf4TPXgQBgzToOJPHjQ6
         jHBw==
X-Gm-Message-State: AOJu0YzPqVlSAbLBDk2Ae0nO9pgJTpe77B9TxvJ6DJLWS2Y4VySHi1v+
        hPST4+N0Rx8bOdzCH+zYasI=
X-Google-Smtp-Source: AGHT+IH508hFF7rYuMEK3udUMWdoLHbt5vQkS/XUo6ncMHyiZW1EqCzmbAOxuXfcjlQJN4dW/yUwzA==
X-Received: by 2002:a7b:c014:0:b0:3fc:dd9:91fd with SMTP id c20-20020a7bc014000000b003fc0dd991fdmr3475237wmb.40.1692262102843;
        Thu, 17 Aug 2023 01:48:22 -0700 (PDT)
Received: from PCBABN.skidata.net ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id l11-20020a5d480b000000b00318147fd2d3sm23820967wrq.41.2023.08.17.01.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 01:48:22 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
To:     dmitry.osipenko@collabora.com
Cc:     bbara93@gmail.com, benjamin.bara@skidata.com, broonie@kernel.org,
        jneanne@baylibre.com, jonathanh@nvidia.com, lee@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org,
        peng.fan@oss.nxp.com, rafael.j.wysocki@intel.com,
        thierry.reding@gmail.com, tony@atomide.com, treding@nvidia.com
Subject: Re: [PATCH v2 3/6] soc/tegra: pmc: Specify restart mode
Date:   Thu, 17 Aug 2023 10:48:12 +0200
Message-Id: <20230817084812.323742-1-bbara93@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <76da3727-a4da-ac70-aa8e-b362b9114061@collabora.com>
References: <76da3727-a4da-ac70-aa8e-b362b9114061@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

thanks for your feedback!

On Tue, 15 Aug 2023 at 00:38, Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
> On 8/9/23 22:24, Benjamin Bara wrote:
> > From: Benjamin Bara <benjamin.bara@skidata.com>
> >
> > The current restart handler registration does not specify whether the
> > restart is a cold or a warm one. Now, as do_kernel_restart() knows about
> > the type, the priorization is implicitly done (cold restarts are
> > executed first) and the reboot_mode kernel parameter (which is currently
> > mostly ignored) can be respected.
> >
> > Acked-by: Thierry Reding <treding@nvidia.com>
> > Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
> > ---
> > v2:
> > - improve commit message
> > ---
> >  drivers/soc/tegra/pmc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> > index 162f52456f65..4f42febb9b0f 100644
> > --- a/drivers/soc/tegra/pmc.c
> > +++ b/drivers/soc/tegra/pmc.c
> > @@ -2962,7 +2962,7 @@ static int tegra_pmc_probe(struct platform_device *pdev)
> >       }
> > 
> >       err = devm_register_sys_off_handler(&pdev->dev,
> > -                                         SYS_OFF_MODE_RESTART,
> > +                                         SYS_OFF_MODE_RESTART_WARM,
> >                                           SYS_OFF_PRIO_LOW,
> >                                           tegra_pmc_restart_handler, NULL);
> >       if (err) {
> >
>
> You have tegra-pmc restart handler that uses low priority. And then
> you're adding cold/warm handlers to tps65219 and pca9450 drivers with a
> default priorities. 

Exactly, but I guess it makes sense to also use the handler with default
priority for the pmc reboot. The reason I kept it low prio was because
there is a comment that PMC should be last resort, but the reason
applies to any other soft restart handler too. I will adapt in the next
version.

> Hence this cold/warm separation of handlers doesn't do any practical
> difference in yours case because tegra-pmc will never be used as it
> did before your changes?

The change is e.g. relevant for platforms without PMIC-based soft reset,
e.g. when the tps6586x is in use. AFAIK, there is no possibility to
actually do a soft reboot, as the hard reboot will always be executed
first. This also happens if I set the kernel parameter "reboot_mode"
(also available via SysFS) to "soft" and a soft restart handler is
registered.

> Previously you wanted to make tps6586x driver to skip the warm reboot,
> but you're not touching tps6586x in this patchset.

True, there might also be other affected patches which are currently not
in linux-next yet. Will adapt the tps6586x too and depend on the whole
series in the next version.

> There is no real problem that is solved by these patches?

I think another problem is if the user sets the "reboot_mode" to "cold",
but there is no cold handler registered (as it was the case for me with
the pca9450), a warning should indicate that. AFAIK, there is no
possibility in user-space to find out if a cold restart handler is
registered, there is just this knob which can be switched to "cold". I
can also add a SysFS entry with "supported_modes" and check if the new
"mode" is supported on a store.

My other idea was to add a flags field to the notifier_block which
indicates (in case of a reboot notifier) the supported reboot_modes of
the registered handler, but I guess other notifier_block users won't
really benefit from an additional field, therefore I decided to add a
second list instead.

Best regards
Benjamin
