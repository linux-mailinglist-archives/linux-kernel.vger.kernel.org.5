Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB9F7CA1E3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjJPIme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJPImc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:42:32 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B593CA1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 01:42:29 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53db3811d8fso8723624a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 01:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google; t=1697445748; x=1698050548; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1wBxzlRRAgDKIdsw/oD7JceYwzO5gCiOpsX8wotSdyc=;
        b=VK+XFdoPSBvD1oHpd5kL3F8qtyVyQooEFZA9r6p0H2SzkZhnL5N3WqupCHz0ne4tv3
         y0h+CY4+OJOZiLctnA7cxrsLa+NrlXI0Fgj+Ao5Nsv8mrcFtj4uPZOxZ/FK+nK9GihD2
         7L8AOAAeRIhtpsvOiPfY0XazTG3NfYftOqZyPPJIk+izbwLpmafGJjQzAlsgD315DEsY
         EavrPkgpW5e1laRqaM12w1URCtReNpyOoDAQE6fNj7c1H4zwTB6N/xCHKfHv4bX8YEFl
         uf5Vhzv7ao7qLU1IDStRfEMnnfXeyIMcUns2x6LJI9yifCnLtNnhUSN1iNkUWZjbet6e
         ueLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697445748; x=1698050548;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1wBxzlRRAgDKIdsw/oD7JceYwzO5gCiOpsX8wotSdyc=;
        b=h18zq2bA02uYlGyV+ML0tSosgBoXE+topVziPm9feOudGyWTJVhMSTcoJ1v/4UVxfg
         ppTG4eUxUEiAzeuVY1ODdcGFmDi6Zsn7ySSeBSXmNEaebiUG+7oPhNpHNf/PiDtjEQhm
         28nOQKzBQ31SVbZIOkpdVN0CYlPdeMYatZRZdxdhsIiaZegIiBhHtizBE/Q5cH6VZoXB
         c1EtNazokQ3TNZvwQcKvZFvbo+BI3qMk2/lzGveV0bn+VOVWfI7sVvSe8pSs5VUvyqsk
         H64zXXODU6oZqJCz0Zm3tirUqtzDOsWq66nXCdI4KPeSUyz3AL9s/twVvf/KFM3RvtkR
         ceAQ==
X-Gm-Message-State: AOJu0YzdwFFUFIfCmKsQidNTNHs6obnYEmYqMtXAZfY1RsgN0wQcdTRZ
        rVFvCXdhzyHOvc0ndv0j9Nom1A==
X-Google-Smtp-Source: AGHT+IHsPIu++Ad85zFmzO6Ctq1olWeev1HosLIP1wm3eBsy+gDdrSPn7qAmKXsDNbTWci4vo+RvWg==
X-Received: by 2002:a05:6402:268c:b0:53e:e623:6a47 with SMTP id w12-20020a056402268c00b0053ee6236a47mr1056178edd.4.1697445748082;
        Mon, 16 Oct 2023 01:42:28 -0700 (PDT)
Received: from localhost ([193.89.194.60])
        by smtp.gmail.com with ESMTPSA id cz12-20020a0564021cac00b0053e43492ef1sm4448841edb.65.2023.10.16.01.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 01:42:27 -0700 (PDT)
Date:   Mon, 16 Oct 2023 10:42:27 +0200
From:   Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin@pqrs.dk>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Archit Taneja <architt@codeaurora.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Mads Bligaard Nielsen <bli@bang-olufsen.dk>,
        Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>
Subject: Re: [PATCH] drm/bridge: adv7511: fix crash on irq during probe
Message-ID: <gczlvtbnch2a3yjke5ltzes66ozb4hz77hstjh5irgzql57y7y@aez4d26675lc>
References: <20231014-adv7511-cec-irq-crash-fix-v1-1-3389486c8373@bang-olufsen.dk>
 <20231016081444.GD23177@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231016081444.GD23177@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

Thanks for the quick review!

On Mon, Oct 16, 2023 at 11:14:44AM +0300, Laurent Pinchart wrote:
> Hello Alvin,
> 
> On Sat, Oct 14, 2023 at 08:46:12PM +0200, Alvin Šipraga wrote:
> > From: Mads Bligaard Nielsen <bli@bang-olufsen.dk>
> > 
> > Moved IRQ registration down to end of adv7511_probe().
> > 
> > If an IRQ already is pending during adv7511_probe
> > (before adv7511_cec_init) then cec_received_msg_ts
> > could crash using uninitialized data:
> > 
> >     Unable to handle kernel read from unreadable memory at virtual address 00000000000003d5
> >     Internal error: Oops: 96000004 [#1] PREEMPT_RT SMP
> >     Call trace:
> >      cec_received_msg_ts+0x48/0x990 [cec]
> >      adv7511_cec_irq_process+0x1cc/0x308 [adv7511]
> >      adv7511_irq_process+0xd8/0x120 [adv7511]
> >      adv7511_irq_handler+0x1c/0x30 [adv7511]
> >      irq_thread_fn+0x30/0xa0
> >      irq_thread+0x14c/0x238
> >      kthread+0x190/0x1a8
> > 
> > Fixes: 3b1b975003e4 ("drm: adv7511/33: add HDMI CEC support")
> 
> Isn't the issue older than that ?

I don't think so. The stacktrace shows the crash is in CEC handling code, which
was added in the blamed commit. A static analysis of adv7511_irq_process()
suggests that the only other place where data could be uninitialized is if the
hpd_work is scheduled:

	if (process_hpd && irq0 & ADV7511_INT0_HPD && adv7511->bridge.encoder)
		schedule_work(&adv7511->hpd_work);

... but this has a check on bridge.encoder, which seems to have been introduced
in a similar fix here:

| commit a1d0503d26ea2ef04f3f013d379e8f4d29c27127
| Author: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
| Date:   Thu May 14 00:31:07 2015 +0300
| 
|     drm: adv7511: Fix crash in IRQ handler when no encoder is associated
|     
|     The ADV7511 is probed before its slave encoder init function associates
|     it with an encoder. This creates a time window during which hot plug
|     detection interrupts can occur with an encoder, resulting in a crash in
|     the IRQ handler.
|     
|     Fix this by ignoring hot plug detection IRQs when no encoder is
|     associated yet.
|     
|     Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
|     Acked-by: Lars-Peter Clausen <lars@metafoo.de>
| 
| diff --git a/drivers/gpu/drm/i2c/adv7511.c b/drivers/gpu/drm/i2c/adv7511.c
| index b728523e194f..2aaa3c88999e 100644
| --- a/drivers/gpu/drm/i2c/adv7511.c
| +++ b/drivers/gpu/drm/i2c/adv7511.c
| @@ -438,7 +438,7 @@ static int adv7511_irq_process(struct adv7511 *adv7511)
|         regmap_write(adv7511->regmap, ADV7511_REG_INT(0), irq0);
|         regmap_write(adv7511->regmap, ADV7511_REG_INT(1), irq1);
|  
| -       if (irq0 & ADV7511_INT0_HDP)
| +       if (irq0 & ADV7511_INT0_HDP && adv7511->encoder)
|                 drm_helper_hpd_irq_event(adv7511->encoder->dev);
|  
|         if (irq0 & ADV7511_INT0_EDID_READY || irq1 & ADV7511_INT1_DDC_ERROR) {

So assuming that is the case, I am not sure which Fixes: tag I ought to
otherwise use. What do you think?

> 
> > Signed-off-by: Mads Bligaard Nielsen <bli@bang-olufsen.dk>
> > Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
> 
> With the Fixes: tag updated,
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Kind regards,
Alvin
