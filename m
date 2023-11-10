Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20ED37E7FB4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbjKJR5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235637AbjKJR4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:56:00 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2713926325
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 02:05:01 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-66d0f945893so15852846d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 02:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699610699; x=1700215499; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JTh2PjtP0OKf6/BbjRju5hZ6Q5wateJL2w104j8DLtE=;
        b=ARVo/PIXIZmWNtOVMWfQxSRzyqeGmgDBYOeTUBycIOgnjRJgge28pWfD82+1iIWP3r
         LDERjb2xY8htMsT+Pah55i+etnWB90KySU4WhwphNdifLsmBnkVxPCQxh6crdvTzr3MU
         sFL3fyl2MMjG5wOk+OQG1UWecWFQ42MDqdr8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699610699; x=1700215499;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JTh2PjtP0OKf6/BbjRju5hZ6Q5wateJL2w104j8DLtE=;
        b=YA3uaW39I5H05CZpijWvMI1vud2vAB2xnSUqdlRUtWjH/gQTUtopcL1ZG1a2lrRkwC
         UFOTh61dSQV+KUMowj9Dye48GtB9X1Hpr4fHb8idWUM5r6nNPfOQF3b23ABOM6Ei+hP1
         wWS0uDaUVzvwzSYx5/Wr4JUJIuYHssfHKLtUG99D9iLAK0/wCuTJCkY1zG1neH4a7UNy
         aiQxiT9fxrrZ4kSPqnwimRJcQsQ+IpyYGskJ7ujVr9Z4v1ooz0z8tuEBRXhw3DIxM5An
         OJrPGJG5nhzT01BpCC5OihZdfLjawwHsVa3bet+iLQc51uJMPtkA7p0zy0Oh/4XdRNin
         ffcg==
X-Gm-Message-State: AOJu0YyKpVN2IMKEK95lCaBx1F0hmJZsea4dby4ewJmQK9iApYOd1sdH
        mMAAiJk3edq2/JVuq7e+f0Syfi2JOxgsvWl4q1U=
X-Google-Smtp-Source: AGHT+IEtnG7NdKeeMxGwHUfln31PcMH/ZvIJc162CJkwQCDNaRkq1bBELP+LIze1f1ebh9w6vn16vg==
X-Received: by 2002:a0c:e910:0:b0:66f:abb4:49ff with SMTP id a16-20020a0ce910000000b0066fabb449ffmr2939865qvo.7.1699610699643;
        Fri, 10 Nov 2023 02:04:59 -0800 (PST)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com. [209.85.222.182])
        by smtp.gmail.com with ESMTPSA id pl11-20020ad4468b000000b006710660a548sm2777472qvb.27.2023.11.10.02.04.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 02:04:59 -0800 (PST)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7789cc5c8ccso158403785a.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 02:04:59 -0800 (PST)
X-Received: by 2002:a05:620a:2952:b0:775:8fab:8c6f with SMTP id
 n18-20020a05620a295200b007758fab8c6fmr2773310qkp.29.1699610698754; Fri, 10
 Nov 2023 02:04:58 -0800 (PST)
MIME-Version: 1.0
References: <20231026-dwc3-v2-1-1d4fd5c3e067@chromium.org> <20231031232227.xkk4ju3hxifj3vee@synopsys.com>
In-Reply-To: <20231031232227.xkk4ju3hxifj3vee@synopsys.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 10 Nov 2023 11:04:43 +0100
X-Gmail-Original-Message-ID: <CANiDSCvEyjHFT3KQbsbURjUadpQYEfQ=M8esdcHnpWe9VsK=2w@mail.gmail.com>
Message-ID: <CANiDSCvEyjHFT3KQbsbURjUadpQYEfQ=M8esdcHnpWe9VsK=2w@mail.gmail.com>
Subject: Re: [PATCH v2] usb: dwc3: set the dma max_seg_size
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Zubin Mithra <zsm@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thinh

On Wed, 1 Nov 2023 at 00:22, Thinh Nguyen <Thinh.Nguyen@synopsys.com> wrote:
>
> On Fri, Oct 27, 2023, Ricardo Ribalda wrote:
> > Allow devices to have dma operations beyond 4K, and avoid warnings such
> > as:
> >
> > DMA-API: dwc3 a600000.usb: mapping sg segment longer than device claims to support [len=86016] [max=65536]
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 72246da40f37 ("usb: Introduce DesignWare USB3 DRD Driver")
> > Reported-by: Zubin Mithra <zsm@chromium.org>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> > Found while running
> > yavta -f YUYV -s 1280x720 -c  /dev/video0
> >
> > with:
> >
> > CONFIG_DMA_API_DEBUG=y
> > ---
> > Changes in v2:
> > - Add stable tag
> > - Link to v1: https://urldefense.com/v3/__https://lore.kernel.org/r/20231026-dwc3-v1-1-643c74771599@chromium.org__;!!A4F2R9G_pg!b22b7Wx1QOpnFtMi7rJ0TS-rhOnMmy_sOCX3kdfln7ezNjslyMhBwHvWaXbK8D5BkKPjjn3HdID-7Ls5R3eR_4o$
> > ---
> >  drivers/usb/dwc3/core.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index 343d2570189f..65f73dd8ef47 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -1918,6 +1918,8 @@ static int dwc3_probe(struct platform_device *pdev)
> >
> >       pm_runtime_put(dev);
> >
> > +     dma_set_max_seg_size(dev, UINT_MAX);
> > +
> >       return 0;
> >
> >  err_exit_debugfs:
> >
> > ---
> > base-commit: 611da07b89fdd53f140d7b33013f255bf0ed8f34
> > change-id: 20231026-dwc3-fac74fcb3b2a
> >
> > Best regards,
> > --
> > Ricardo Ribalda <ribalda@chromium.org>
> >
>
> Probably better to have the Closes: tag with the link to the reported
> issue. Regardless,

It was reported internally, so I have no link to share.

In this cases it seems that Reported-by with no link in good enough:
https://lore.kernel.org/all/ab557ae6-7550-189a-81dd-6e3346d84620@leemhuis.info/


>
> Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

Thanks!
>
> Thanks,
> Thinh



-- 
Ricardo Ribalda
